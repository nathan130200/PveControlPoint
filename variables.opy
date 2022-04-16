#!mainFile "main.opy"

declareVariables('player', [
	'botLevel',
	'botExp',
	'damageMod',
	'speedMod',
	'botHudText',
	'botHudTextValue',
	'healthPoolID',
	'botFinalDamage',
	'botFinalSpeed'
])

declareVariables('global', [
	'autoStartWaitTick',

	/* telemetry params */
	'xmlStarted',
	'teamParams',
	'xmlMatchStatus',
	'xmlEntityIndex',
	'xmlEntity',
	'matchId',
])