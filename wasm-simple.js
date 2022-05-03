let bfCode = null;

const output = (c) => {
    postMessage(c)
};

const memory = new WebAssembly.Memory({ initial: 1 });
let compute = null;

const startUp = new Promise(async (resolve) => {
    const importObj = {
        js: {
            memory: memory,
            output: output
        }
    };
    const module = await WebAssembly.instantiateStreaming(fetch('./wasm-simple.wasm'), importObj);
    compute = module.instance.exports.compute;
    resolve();
});

onmessage = async (e) => {
    bfCode = e.data;
    await startUp;
    const bytes = new Uint8Array(memory.buffer, 0, bfCode.length);
    for(let i = 0; i < bfCode.length; i++) {
        bytes[i] = bfCode.charCodeAt(i);
    }
    compute();
    output(null);
};
