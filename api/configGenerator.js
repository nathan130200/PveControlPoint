let group = 'Pve Control Point';

const size = 24, chars = 'Oo0';

function randomKey() {
    let id = '';

    for (let i = 0; i < size; i++) {
        id += chars[Math.floor(Math.random() * chars.length)];
    }

    return id;
}


let variableName = `_${randomKey()}`;
let code = `globalvar ${variableName}\n`;
let actions = [];

function getConfigKey(obj) {
    let res = '';

    if (obj.key)
        res = obj.key[0].toUpperCase() + obj.key.slice(1);
    else {
        res = obj.name.split(' ').map(word =>
            word[0].toUpperCase() + word.slice(1)).join('')
            .replace(/[^a-zA-Z0-9]/g, '');
    }

    return `opt${res}`;
}

let i = 0;

if (param && param.length > 0)
    group =  `${group} / ${param}`

for (let indexer of Object.keys(arg)) {
    let obj = arg[indexer];
    let key = getConfigKey(obj);

    let { type, name, value } = obj;
    code += `#${obj.name}\n#!define ${key} ${variableName}[${i}]\n\n`;
    actions.push(`${variableName}[${i}] = createWorkshopSetting(${type}, '${group}', '${name}', ${value}, ${i})`);
    i++;
}

`${code}

rule 'initialize: config':
    @Event global
    ${actions.join('\n\t')}
`;