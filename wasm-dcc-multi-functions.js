let bfCode = null;

const output = (c) => {
    postMessage(c)
};

const memory = new WebAssembly.Memory({ initial: 1 });

// from Wikipedia: https://en.wikipedia.org/wiki/LEB128
const encodeSignedLeb128FromInt32 = (value) => {
    value |= 0;
    const result = [];
    while (true) {
        const byte_ = value & 0x7f;
        value >>= 7;
        if (
            (value === 0 && (byte_ & 0x40) === 0) ||
            (value === -1 && (byte_ & 0x40) !== 0)
        ) {
            result.push(byte_);
            return result;
        }
        result.push(byte_ | 0x80);
    }
};

const compose = async (bfCode) => {

    // to understand this code well, this document will help you understand better:
    // https://github.com/WebAssembly/design/blob/main/BinaryEncoding.md

    // firstly, build sub functions using bfCode

    let p = 0;
    let functionList = [];
    let functionCount = 1; // id:0 === imported function (== js.output)
    const traverse = () => {
        const functionId = functionCount++;
        // (func sub[id] (param: i32) (result: i32)) => type 1
        const functionBody = [];
        functionList.push({functionBody}); // need to push immediately

        while(p < bfCode.length) {
            const c = bfCode[p++];
            switch (c) {
                case '>': functionBody.push(0x20, 0x00, 0x41, 0x04, 0x6a, 0x21, 0x00); break;
                // local.get $pointer
                // i32.const 4
                // i32.add
                // local.set $pointer
    
                case '<': functionBody.push(0x20, 0x00, 0x41, 0x04, 0x6b, 0x21, 0x00); break;
                // local.get $pointer
                // i32.const 4
                // i32.sub
                // local.set $pointer
    
                case '+': functionBody.push(0x20, 0x00, 0x20, 0x00, 0x28, 0x02, 0x00, 0x41, 0x01, 0x6a, 0x36, 0x02, 0x00); break;
                // local.get $pointer
                // local.get $pointer
                // i32.load
                // i32.const 1
                // i32.add
                // i32.store
    
                case '-': functionBody.push(0x20, 0x00, 0x20, 0x00, 0x28, 0x02, 0x00, 0x41, 0x01, 0x6b, 0x36, 0x02, 0x00); break;
                // local.get $pointer
                // local.get $pointer
                // i32.load
                // i32.const 1
                // i32.sub
                // i32.store

                case '.': functionBody.push(0x20, 0x00, 0x28, 0x02, 0x00, 0x10, 0x00); break;
                // local.get $pointer
                // i32.load
                // call $output
    
                case '[':
                    functionBody.push(0x03, 0x40, 0x20, 0x00, 0x28, 0x02, 0x00, 0x45, 0x04, 0x40, 0x05);
                // (loop 
                //     local.get $pointer
                //     i32.load
                //     i32.eqz
                //     (if
                //         (then)
                //         (else
                    const callId = traverse();
                    functionBody.push(0x20, 0x00, 0x10, ...encodeSignedLeb128FromInt32(callId), 0x21, 0x00, 0x0c, 0x01, 0x0b, 0x0b);
                //             local.get $pointer
                //             call $sub${callId}
                //             local.set $pointer
                //             br 1
                //         )
                //     )
                // )
                    break;

                case ']': functionBody.push(0x20, 0x00, 0x0b);
                //     local.get $pointer
                // )
                    return functionId;
            }
        }

        functionBody.push(0x20, 0x00, 0x0b);
        //     local.get $pointer
        // )
        return functionId;
    };

    const rootSubFunctionId = traverse(); // root sub function will be called from `compose` function
    const composeId = functionCount; // `compose` function will be exported


    // build Function Section binary

    let functionSection = [...encodeSignedLeb128FromInt32(functionList.length + 1)];
    // entries: import(js.output) + functionList.length + composer
    for(let i = 0; i < functionList.length; i++) {
        functionSection.push(0x01); // type === 1 (param: [i32], result: i32)
    }
    functionSection.push(0x02); // type === 2 (param:no, result: no) -> composer
    functionSection = [
        0x03, // 0x03 === Function Section,
        ...encodeSignedLeb128FromInt32(functionSection.length),
        ...functionSection
    ];


    // build Code Section binary

    let codeSection = [];
    for(let i = 0; i < functionList.length; i++) {
        const body = [
            0x00, // local_count === 0, no local variables
            ...functionList[i].functionBody];
        codeSection = [...codeSection, ...encodeSignedLeb128FromInt32(body.length), ...body];
    }
    // add compose function
    const rootSubFunctionIdLeb128 = encodeSignedLeb128FromInt32(rootSubFunctionId);
    codeSection = [
        ...encodeSignedLeb128FromInt32(functionList.length + 1), // entries === functionList + compose
        ...codeSection,
        0x0f + rootSubFunctionIdLeb128.length, // body size, length: 15 + length
        0x01, // local_count === 1, 1 entry
            0x02, 0x7f, // 2 same local variables, type === 0x7f: i32
            0x41, 0xb0, 0xea, 0x01, // i32.const 30000
            0x21, 0x01, // local.set 1
            0x20, 0x01, // local.get 1
            0x10, ...rootSubFunctionIdLeb128, // call rootSubFunction
            0x21, 0x01, // local.set 1
            0x0b, // end
    ];
    codeSection = [
        0x0a, // CODE section
        ...encodeSignedLeb128FromInt32(codeSection.length), // code length
        ...codeSection
    ];

    const composeFunctionIdLeb128 = encodeSignedLeb128FromInt32(composeId);

    const wasmBinary = [
        0x00, 0x61, 0x73, 0x6d, 0x01, 0x00, 0x00, 0x00, // magic word: "\0asm", version 1
        0x01, 0x0d, // 0x01 === Type Section, length: 13
            0x03, // 3 entries
                0x60, 0x01, 0x7f, 0x00, // 0x60 === func, param_count: 1, param_type: i32(0x7f), return_count: 0
                0x60, 0x01, 0x7f, 0x01, 0x7f, // 0x60 === func, param_count: 1, param_type: i32(0x7f), return_count: 1, return_type: i32(0x7f)
                0x60, 0x00, 0x00, // 0x60 === func, param_count: 0,  return_count: 0
        
        0x02, 0x1a, // 0x02 === Import Section, length: 26
            0x02, // 2 entries
                0x02, 0x6a, 0x73, // length:2, "js"
                0x06, 0x6f, 0x75, 0x74, 0x70, 0x75, 0x74, // length: 6, "output"
                0x00, // external_kind === 0 : Function
                0x00, // function signature === 0 => [i32]: void

                0x02, 0x6a, 0x73, // length:2, "js"
                0x06, 0x6d, 0x65, 0x6d, 0x6f, 0x72, 0x79, // length: 6, "memory"
                0x02, // external_kind === 2 : Memory
                    0x00, // flags: 0 => no maximum field
                    0x01, // initial length: 1
        
        ...functionSection,
        
        0x07, 0x0a + composeFunctionIdLeb128.length, // 0x07 === Export Section, length: 10 + composeFunction id length
            0x01, // 1 entry
                0x07, 0x63, 0x6f, 0x6d, 0x70, 0x75, 0x74, 0x65, // length: 7, "compose"
                0x00, // external_kind === 0: function,
                ...composeFunctionIdLeb128, // function index: 0x00=>import, 0x01-last => wasm func, and this is a last func
        
        ...codeSection
    ];

    // compile the wasm binary just in time
    const wasmBuffer = Uint8Array.from(wasmBinary);
    const importObj = {
        js: {
            memory: memory,
            output: output
        }
    };
    // console.log(wasmBinary.length, functionList.length + 1);
    const module = await WebAssembly.instantiate(wasmBuffer.buffer, importObj);
    return module.instance.exports.compute;
};

onmessage = async (e) => {
    bfCode = e.data;
    const compute = await compose(bfCode);
    compute();
    output(null);
};
