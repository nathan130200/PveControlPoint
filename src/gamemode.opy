#!mainFile "../main.opy"

rule "setup global":
	@Event global
	disableAnnouncer()
	
rule "setup bots":
	@Event eachPlayer
	@Team eT_Bot
	eventPlayer.botLevel = 1
	eventPlayer.botExp = 0
	eventPlayer.dmgModifier = 1
	eventPlayer.speedModifier = 1
	eventPlayer.startScalingBarriers(1.5, true)
	eventPlayer.startScalingSize(1.25, true)
	
	#createInWorldText(getAllPlayers(), "{} / Level: {}\nDamage: {}%/Speed :{}%\nHealth: {}%/Exp: {}".format(eventPlayer, eventPlayer.botLevel, eventPlayer.dmgModifier, eventPlayer.speedModifier, scaledHealth(eventPlayer), eventPlayer.botExp), updateEveryTick(eventPlayer.getEyePosition() + vect(0, 0.15, 0)), 0.85, Clip.SURFACES, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.YELLOW, SpecVisibility.ALWAYS)
	#eventPlayer.worldTextRef = getLastCreatedText()
	
#!defineMember healthPoolModifier dmgModifier
	
rule "player: setup armor protection":
	@Event eachPlayer
	@Team eT_Player
	@Condition eventPlayer.isAlive()
	eventPlayer.addHealthPool(Health.SHIELDS, eventPlayer.healthPoolModifier, false, true)
	eventPlayer.healthPoolID = getLastCreatedHealthPool()
	
rule "player: kill bot then increment armor":
	@Event playerEarnedElimination
	@Condition attacker != victim
	@Condition entityExists(attacker)
	@Condition attacker.getTeam() == eT_Player
	attacker.healthPoolModifier += optPlayerShieldIncrementModifierOnBotTeamKill
	
rule "player: reset armor protection":
	@Event playerDied
	@Condition victim.getTeam() == eT_Player
	@Condition victim.healthPoolID != -1
	victim.removeAllHealthPools()
	victim.healthPoolID = -1
	
rule "bot: update stuff":
	@Event eachPlayer
	@Team eT_Bot
	@Condition entityExists(eventPlayer)
	@Condition eventPlayer.isAlive()
	
	if optEnableFastBotRespawn:
		eventPlayer.disableRespawn()
	
	eventPlayer.disableNameplatesFor(getAllPlayers())
	eventPlayer.setMoveSpeed(optBotBaseMoveSpeedPercent + (eventPlayer.speedModifier * 1))
	eventPlayer.setDamageDealt(optBotBaseDamagePercent + (eventPlayer.dmgModifier * 0.9))
	wait(1.5)
	
	if RULE_CONDITION:
		goto RULE_START

rule "skip assemble heroes phase":
	@Event global
	@Condition isAssemblingHeroes()
	@Condition optSkipAssembleHeroesPhase
	setMatchTime(1)
	wait(1.5)
	
	if optSkipSetupPhase:
		setMatchTime(optSetupPhaseSkipTime)
	
rule "bot: fast respawn":
	@Event eachPlayer
	@Team eT_Bot
	@Condition eventPlayer.isDead()
	@Condition any([x for x in getPlayers(eT_Bot) if x.isAlive()])
	@Condition optEnableFastBotRespawn
	wait(2, Wait.ABORT_WHEN_FALSE)
	wait(optFastBotRespawnTime)
	eventPlayer.respawn()

rule "bot: assist":
	@Event playerEarnedElimination
	@Condition attacker.getTeam() == eT_Bot
	@Condition attacker != victim
	attacker.botExp += optExpPerElimination
	
rule "bot: upgrade to next level":
	@Event eachPlayer
	@Team eT_Bot
	@Condition eventPlayer.botExp > 0
	@Condition eventPlayer.botExp % optExpPerLevelUp == 0
	@Condition optMaxBotLevel <= 0 or eventPlayer.botLevel < optMaxBotLevel
	eventPlayer.botLevel++
	eventPlayer.dmgModifier += optBotDamageIncrementPerLevel
	eventPlayer.speedModifier += optBotSpeedIncrementPerLevel
	
	if optMaxBotLevel > 0 and eventPlayer.botLevel == optMaxBotLevel:
		bigMessage(getAllPlayers(), "Bot #{} reached max level!".format(eventPlayer.getSlot()))
	#else:
		#smallMessage(getAllPlayers(), "Bot #{} is now level: {}".format(eventPlayer.getSlot(), eventPlayer.botLevel))
	
rule "bot: earn exp on kill":
	@Event playerDealtFinalBlow
	@Condition attacker.getTeam() == eT_Bot
	@Condition attacker != victim
	attacker.botExp += optExpPerFinalBlow
	
	if eventWasCriticalHit:
		attacker.botExp += optExpPerCriticalDamage
	
rule "bot: earn exp on damage":
	@Event playerDealtDamage
	@Condition attacker.getTeam() == eT_Bot
	@Condition attacker != victim
	@Condition eventDamage > 0
	attacker.botExp += optExpPerDamageDealt
	
	if eventWasCriticalHit:
		attacker.botExp += eventWasCriticalHit
	
rule "bot: earn exp on heal":
	@Event playerDealtHealing
	@Condition healer.getTeam() == eT_Bot
	@Condition healer != healee
	@Condition healer.isInSpawnRoom() == false
	@Condition eventHealing > 0
	healer.botExp += optExpPerHealingDone
	