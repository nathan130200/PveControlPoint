let code = '';
let macros = '';
let index = 0;

let baseVarName = (() => {
    var alphabet = 'abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    var str = '';
    for (var i = 0; i < 16; i++)
        str += alphabet.charAt(Math.floor(Math.random() * alphabet.length));

    return str;
})();

function toVarName(name) {
    var str = 'opt';

    name.split(' ').forEach(function (v, i) {
        if (i > 0)
            str += v.charAt(0).toUpperCase() + v.slice(1);
        else {
            str += v.replace(/[^a-z0-9]/gi, '');
        }
    });

    return str;
}

for (let param of params) {
    let desc = "PVE Control Point";
    let { type, name, value } = param;
    macros += `#!define ${toVarName(name)} config[${index}]\n`;

    if (param.group)
        desc += " / " + param.group;

    code += `\tconfig[${index}] = createWorkshopSetting(${type}, "${desc}", "${name}", ${value}, 0)\n`;
    index++;
}

baseVarName = '_var_' + baseVarName;

`
globalvar ${baseVarName}
#!define config ${baseVarName}
${macros}

rule "setup gamemode":
    @Event global
    ${code}
`