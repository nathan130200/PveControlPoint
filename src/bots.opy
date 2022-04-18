#!mainFile '../main.opy'

defineConfigs('Scoring', [
	{ name: 'Amount of experience Required to next level', type: 'int[100:9999]', value: 1000 },
	{ name: 'Exp per damage dealt', type: 'int[1:9999]', value: 25 },
	{ name: 'Exp per healing dealt', type: 'int[1:9999]', value: 25 },
	{ name: 'Exp per healing dealt include healer', type: 'bool', value: true },
	{ name: 'Exp per assist', type: 'int[1:9999]', value: 50 },
	{ name: 'Exp per kill', type: 'int[1:9999]', value: 100 },
	{ name: 'Exp per environmental kill', type: 'int[1:9999]', value: 125 },
])

rule 'initialize bots':
	@Event eachPlayer
	@Team eTeam_Bot
	eventPlayer.expCurr = 0
	eventPlayer.expNext = optAmountOfExperienceRequiredToNextLevel
	eventPlayer.expOld = eventPlayer.expNext
	eventPlayer.expFmt = '0'
	
rule 'bot/score: level up':
	@Event eachPlayer
	@Condition isGameInProgress()
	@Condition (eventPlayer.expOld - eventPlayer.expCurr) <= 0
	eventPlayer.expOld = eventPlayer.expCurr + eventPlayer.expNext # old = current + next constant value
	
rule 'bot/score: damage':
	@Event playerDealtDamage
	@Condition isGameInProgress()
	@Condition entityExists(victim)
	@Condition attacker.getTeam() == eTeam_Bot
	@Condition attacker != victim
	attacker.expCurr += optExpPerDamageDealt
	
rule 'bot/score: self healing':
	@Event playerDealtHealing
	@Condition isGameInProgress()
	@Condition entityExists(healee)
	@Condition healer.getTeam() == eTeam_Bot
	@Condition optExpPerHealingDealtIncludeHealer
	@Condition healer == healee
	healer.expCurr += optExpPerHealingDealt
	
rule 'bot/score: healing':
	@Event playerDealtHealing
	@Condition isGameInProgress()
	@Condition entityExists(healee)
	@Condition healer.getTeam() == eTeam_Bot
	@Condition healer != healee
	healer.expCurr += optExpPerHealingDealt
	
rule 'bot/score: assist':
	@Event playerEarnedElimination
	@Condition isGameInProgress()
	@Condition entityExists(victim)
	@Condition attacker.getTeam() == eTeam_Bot
	@Condition attacker != victim
	attacker.expCurr += optExpPerAssist
	
	if eventWasEnvironment:
		attacker.expCurr += optExpPerEnvironmentalKill
		
rule 'bot/score: kill':
	@Event playerDealtFinalBlow
	@Condition isGameInProgress()
	@Condition entityExists(victim)
	@Condition attacker.getTeam() == eTeam_Bot
	@Condition attacker != victim
	attacker.expCurr += optExpPerKill
	
	if eventWasEnvironment:
		attacker.expCurr += optExpPerEnvironmentalKill