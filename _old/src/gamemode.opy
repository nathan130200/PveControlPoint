#!mainFile "../main.opy"

rule "setup global":
	@Event global
	disableAnnouncer()
	
rule "setup bots":
	@Event eachPlayer
	@Team eT_Bot
	eventPlayer.botLevel = 1
	eventPlayer.botExp = 0
	eventPlayer.damageMod = 1
	eventPlayer.speedMod = 1


rule "reset some stuff after start match":
	@Event eachPlayer
	@Team eT_Bot
	@Condition eventPlayer.hasSpawned()
	@Condition isWaitingForPlayers()
	waitUntil(not isGameInProgress(), 9999)
	eventPlayer.botLevel = 1
	eventPlayer.botExp = 0
	eventPlayer.damageMod = 1
	eventPlayer.speedMod = 1
	
rule "player: setup armor protection":
	@Event eachPlayer
	@Team eT_Player
	@Condition eventPlayer.hasSpawned()
	@Condition eventPlayer.healthPoolID == null
	eventPlayer.addHealthPool(Health.SHIELDS, eventPlayer.healthPoolModifier, true, true)
	eventPlayer.healthPoolID = getLastCreatedHealthPool()

rule "minimum players to start":
	@Event global
	@Condition isWaitingForPlayers()
	@Condition optAutoStartEnabled
	
	bigMessage(getAllPlayers(), "Min players to auto start: {}".format(optAutoStartMinPlayers))
	
	if numSpawnedPlayers >= optAutoStartMinPlayers:
		goToAssembleHeroes()
		return
	
	for autoStartWaitTick in range(0, 10):
		wait(1, Wait.RESTART_WHEN_TRUE)
		
		if numSpawnedPlayers >= optAutoStartMinPlayers:
			goto RULE_START
	
	if RULE_CONDITION:
		goto RULE_START
	
rule "restart post match":
	@Condition isMatchComplete()
	# Telemetry must wait full lobby completition to finalize, so cannot mix these values
	@Condition not optEnableTelemetry
	@Condition optPostMatchAutoRestart
	wait(optPostMatchAutoRestartDelay)
	restartMatch()
	
rule "player: kill bot then increment armor":
	@Event playerEarnedElimination
	@Condition attacker != victim
	@Condition entityExists(attacker)
	@Condition attacker.getTeam() == eT_Player
	attacker.healthPoolModifier += optPlayerShieldIncrementOnKill
	
rule "config: enable endless mode":
	@Event global
	@Condition optEndlessMode
	@Condition isGameInProgress()
	disableGamemodeCompletion()
	
rule "config: disable inspector recording":
	@Event global
	@Condition optDisableInspectorRecording
	disableInspector()

rule "skip assemble heroes phase":
	@Event global
	@Condition isAssemblingHeroes()
	@Condition optSkipAssembleHeroesPhase
	setMatchTime(1)
	
rule "set setup phase":
	@Event global
	@Condition isInSetup()
	@Condition optSkipSetupPhase
	setMatchTime(optSetupPhaseTimeSeconds)

rule "bot: assist":
	@Event playerEarnedElimination
	@Condition isGameInProgress()
	@Condition attacker.getTeam() == eT_Bot
	@Condition attacker != victim
	attacker.botExp += optExpPerElimination
	
rule "bot: upgrade to next level":
	@Event eachPlayer
	@Team eT_Bot
	@Condition isGameInProgress()
	@Condition eventPlayer.botExp > 0
	@Condition eventPlayer.botExp % optExpPerLevelUp == 0
	@Condition optMaxBotLevel <= 0 or eventPlayer.botLevel < optMaxBotLevel
	eventPlayer.botLevel++
	eventPlayer.damageMod += optBotDamageIncrementPerLevel
	eventPlayer.speedMod += optBotSpeedIncrementPerLevel
	
	if optMaxBotLevel > 0 and eventPlayer.botLevel == optMaxBotLevel:
		bigMessage(getAllPlayers(), "{} {} reached max level!".format(heroNameWithIcon(eventPlayer)))
	else:
		smallMessage(getAllPlayers(), "{} {} is now level: {}".format(heroNameWithIcon(eventPlayer), eventPlayer.botLevel))
	
rule "bot: earn exp on kill":
	@Event playerDealtFinalBlow
	@Condition isGameInProgress()
	@Condition attacker.getTeam() == eT_Bot
	@Condition attacker != victim
	attacker.botExp += optExpPerFinalBlow
	
	if eventWasCriticalHit:
		attacker.botExp += optExpPerCriticalDamage
	
rule "bot: earn exp on damage":
	@Event playerDealtDamage
	@Condition isGameInProgress()
	@Condition attacker.getTeam() == eT_Bot
	@Condition attacker != victim
	@Condition eventDamage > 0
	attacker.botExp += optExpPerDamageDealt
	
	if eventWasCriticalHit:
		attacker.botExp += optExpPerCriticalDamage
	
rule "bot: earn exp on heal":
	@Event playerDealtHealing
	@Condition isGameInProgress()
	@Condition healer.getTeam() == eT_Bot
	@Condition healer != healee
	@Condition healer.isInSpawnRoom() == false
	@Condition eventHealing > 0
	healer.botExp += optExpPerHealingDone
	