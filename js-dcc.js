let bfCode = null;

const output = (c) => {
    postMessage(c)
};

const compose = (bfCode) => {
    let funcBody = `let pointer = 0;const memory = new Int32Array(30000);`;
    for (const c of [...bfCode]) {
        switch (c) {
            case '>': funcBody += 'pointer++;'; break;
            case '<': funcBody += 'pointer--;'; break;
            case '+': funcBody += 'memory[pointer]++;'; break;
            case '-': funcBody += 'memory[pointer]--;'; break;
            case '.': funcBody += `output(memory[pointer]);`; break;
            case '[': funcBody += `while (memory[pointer]) {`; break;
            case ']': funcBody += `}`; break;
        }
    }
    funcBody += 'output(null);'
    return new Function(funcBody);
};

onmessage = (e) => {
    bfCode = e.data;
    const compute = compose(bfCode);
    compute();
};
