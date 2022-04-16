#!mainFile "../main.opy"

rule "bot: calculate shared params":
	@Event eachPlayer
	@Condition entityExists(eventPlayer)
	@Condition isGameInProgress()
	do:
		eventPlayer.botFinalDamage = optBotBaseDamagePercent + eventPlayer.damageMod
		eventPlayer.botFinalSpeed = optBotBaseMoveSpeedPercent + eventPlayer.speedMod
		wait(1)
	while RULE_CONDITION
	
rule "player: tick shield increment":
	@Event eachPlayer
	@Condition eventPlayer.isAlive()
	@Team eT_Player
	do:
		eventPlayer.healthPoolModifier += optPlayerShieldIncrementOverTimeRate
		wait(random.randint(1, 3))
	while RULE_CONDITION