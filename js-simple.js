let bfCode = null;

const output = (c) => {
    postMessage(c)
};

const compute = () => {
    let programCounter = 0;
    let pointer = 0;
    const memory = new Int32Array(30000);

    const calcJump = () => {
        const delta = (bfCode[programCounter] === '[') ? 1 : -1;

        let target = programCounter + delta;
        let count = 1;
        while (true) {
            if (bfCode[target] === '[') {
                count += delta
            }
            if (bfCode[target] === ']') {
                count -= delta;
            }
            if (count === 0) {
                return target;
            }
            target += delta;
        }
    };

    while (programCounter < bfCode.length) {
        switch (bfCode[programCounter]) {
            case '>': pointer++; break;
            case '<': pointer--; break;
            case '+': memory[pointer]++; break;
            case '-': memory[pointer]--; break;
            case '.': output(memory[pointer]); break;
            case '[': if (!memory[pointer]) programCounter = calcJump(); break;
            case ']': if (memory[pointer]) programCounter = calcJump(); break;
        }
        programCounter++;
    }


    output(null);
};

onmessage = (e) => {
    bfCode = e.data;
    compute();
};
