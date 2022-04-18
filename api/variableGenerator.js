const size = 24, chars = 'Oo0';

function randomKey() {
    let id = '';

    for (let i = 0; i < size; i++) {
        id += chars[Math.floor(Math.random() * chars.length)];
    }

    return id;
}

let code = '';
let counter = 0;

for (let name of g) {
    let key = `_${randomKey()}${counter}`;
    code += `globalvar ${key}\n`;
    code += `#!define ${name} ${key}\n`;
    counter++;
}

counter = 0;

for (let name of p) {
    let key = `_${randomKey()}${counter}`;
    code += `playervar ${key}\n`;
    code += `#!defineMember ${name} ${key}\n`;
    counter++;
}

code;