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
    // header
    const header = [
        0x00, 0x61, 0x73, 0x6d, 0x01, 0x00, 0x00, 0x00, 0x01, 0x08, 0x02, 0x60, 0x01, 0x7f, 0x00, 0x60,
        0x00, 0x00, 0x02, 0x1a, 0x02, 0x02, 0x6a, 0x73, 0x06, 0x6f, 0x75, 0x74, 0x70, 0x75, 0x74, 0x00,
        0x00, 0x02, 0x6a, 0x73, 0x06, 0x6d, 0x65, 0x6d, 0x6f, 0x72, 0x79, 0x02, 0x00, 0x01, 0x03, 0x02,
        0x01, 0x01, 0x07, 0x0b, 0x01, 0x07, 0x63, 0x6f, 0x6d, 0x70, 0x75, 0x74, 0x65, 0x00, 0x01, 0x0a,

        // the last 0x0a === varuint7 section code (10 === Code, Function bodies (code))
        // we need to insert:
        // - payload_len (varuint32) === function body size + 1 + length(varuint32 of function body size)
        // - 0x01 (count of function bodies to follow)
        // - function body size (varuint32)
    ];

    // function body starts here
    const functionBody = [
        0x01, 0x02, 0x7f, 0x41, 0xb0, 0xea, 0x01, 0x21, 0x01, 0x03, 0x40,
    ];

    for (const c of [...bfCode]) {
        switch (c) {
            case '>': functionBody.push(0x20, 0x01, 0x41, 0x04, 0x6a, 0x21, 0x01); break;
                // local.get $pointer
                // i32.const 4
                // i32.add
                // local.set $pointer

            case '<': functionBody.push(0x20, 0x01, 0x41, 0x04, 0x6b, 0x21, 0x01); break;
                // local.get $pointer
                // i32.const 4
                // i32.sub
                // local.set $pointer
                
            case '+': functionBody.push(0x20, 0x01, 0x20, 0x01, 0x28, 0x02, 0x00, 0x41, 0x01, 0x6a, 0x36, 0x02, 0x00); break;
                // local.get $pointer
                // local.get $pointer
                // i32.load
                // i32.const 1
                // i32.add
                // i32.store
        
            case '-': functionBody.push(0x20, 0x01, 0x20, 0x01, 0x28, 0x02, 0x00, 0x41, 0x01, 0x6b, 0x36, 0x02, 0x00); break;
                // local.get $pointer
                // local.get $pointer
                // i32.load
                // i32.const 1
                // i32.sub
                // i32.store
            case '.': functionBody.push(0x20, 0x01, 0x28, 0x02, 0x00, 0x10, 0x00); break;
                // local.get $pointer
                // i32.load
                // call $output

            case '[': functionBody.push(0x03, 0x40, 0x20, 0x01, 0x28, 0x02, 0x00, 0x45, 0x04, 0x40, 0x05); break;
                // (loop $loopXXX
                //     local.get $pointer
                //     i32.load
                //     i32.eqz
                //     (if
                //         (then)
                //         (else

            case ']': functionBody.push(0x0c, 0x01, 0x0b, 0x0b); break;
                //             br $loopXXX
                //         )
                //     )
                // )

        }
    }

    // footer
    functionBody.push(0x0b, 0x0b);

    const lebLength = encodeSignedLeb128FromInt32(functionBody.length).length;

    const wasmBinary = [
        ...header,
        ...encodeSignedLeb128FromInt32(functionBody.length + lebLength + 1), // payload_len (varuint32)
        0x01, // count of function bodies to follow
        ...encodeSignedLeb128FromInt32(functionBody.length), // function body size (varuint32)
        ...functionBody
    ];

    // compile the wasm binary just in time
    const wasmBuffer = Uint8Array.from(wasmBinary);
    const importObj = {
        js: {
            memory: memory,
            output: output
        }
    };
    const module = await WebAssembly.instantiate(wasmBuffer.buffer, importObj);
    return module.instance.exports.compute;
};

onmessage = async (e) => {
    bfCode = e.data;
    const compute = await compose(bfCode);
    compute();
    output(null);
};
