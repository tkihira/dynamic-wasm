let bfCode = null;

const output = (c) => {
    postMessage(c)
};

const compose = (bfCode) => {

    let funcCounter = 0;
    let p = 0;
    const funcBodyList = [];
    const builder = () => {
        const funcId = funcCounter++;
        let funcBody = `function func${funcId}() {`;
        while(p < bfCode.length) {
            const c = bfCode[p++];
            switch (c) {
                case '>': funcBody += 'pointer++;'; break;
                case '<': funcBody += 'pointer--;'; break;
                case '+': funcBody += 'memory[pointer]++;'; break;
                case '-': funcBody += 'memory[pointer]--;'; break;
                case '.': funcBody += `output(memory[pointer]);`; break;
                case '[':
                    funcBody += `while (memory[pointer]) {`;
                    const calleeId = builder();
                    funcBody += `func${calleeId}();`;
                    funcBody += `}`;
                    break;
                case ']':
                    funcBody += `}`;
                    funcBodyList.push(funcBody);
                    return funcId;
            }
        }
        funcBody += `}`;
        funcBodyList.push(funcBody);
        return funcId;
    };
    builder();

    let rootBody = `let pointer = 0;const memory = new Int32Array(30000);`;
    rootBody += funcBodyList.join('');
    rootBody += 'func0();output(null);'
    return new Function(rootBody);
};

onmessage = (e) => {
    bfCode = e.data;
    const compute = compose(bfCode);
    compute();
};
