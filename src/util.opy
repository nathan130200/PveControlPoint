#!define eT_Player Team.1
#!define eT_Bot Team.2
#!define scaledHealth(player) round((eventPlayer.getNormalizedHealth() * 100))

/* Variable Name Obfuscator */
#!define declareVariables(scope, names) __script__("util/variableNameGenerator.js")

/* Workshop Setting Alias */
#!define declareConfigs(params) __script__("util/configGenerator.js")