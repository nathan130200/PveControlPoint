let alphabet = 'abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
let variables = {};
let counter = 0;

function variableName() {
    let result = '';
    for (let i = 0; i < 16; i++)
        result += alphabet[Math.floor(Math.random() * alphabet.length)];

    return '_' + result;
}

for (let name of names) {
    let key = '';

    while (true) {
        key = `${variableName()}`;

        if (!variables[key]) {
            variables[key] = name;
            break;
        }
    }
}

let kind;

if(!/(global|player)/.test(scope)){
    throw new Error("Unexcepted variable scope.");
}

kind = scope + 'var';

let code = '';

for (let key of Object.keys(variables)) {
    let name = variables[key];

    code += `${kind} ${key}\n`;

    if (scope == 'player')
        code += `#!defineMember ${name} ${key}\n`;
    else
        code += `#!define ${name} ${key}\n`;
}

code