#!mainFile "../main.opy"

rule "setup bots hud":
	@Event eachPlayer
	@Team eT_Bot
	hudText(localPlayer, heroIcon(eventPlayer.getCurrentHero()), "{} / LVL: {} / HP: {}% / EXP: {}".format(eventPlayer.getCurrentHero(), eventPlayer.botLevel, scaledHealth(eventPlayer), eventPlayer.botHudTextValue), "DAMAGE: {}% / SPEED: {}%".format(eventPlayer.botFinalDamage, eventPlayer.botFinalSpeed), HudPosition.LEFT, (-10) - (eventPlayer.getSlot() * -1), Color.LIME_GREEN, Color.ROSE, Color.ORANGE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
	eventPlayer.botHudText = getLastCreatedText()
	
rule "bot: format exp for display":
	@Event eachPlayer
	@Team eT_Bot
	@Condition eventPlayer.isAlive()
	@Condition entityExists(eventPlayer)
	
	if eventPlayer.botExp >= 1000 and eventPlayer.botExp < 1000000:
		eventPlayer.botHudTextValue = "{}K".format(eventPlayer.botExp / 1000)
	elif eventPlayer.botExp > 1000000:
		eventPlayer.botHudTextValue = "{}M".format(eventPlayer.botExp / 1000000)
	elif eventPlayer.botExp < 1000:
		eventPlayer.botHudTextValue = "{}".format(eventPlayer.botExp)
	
	wait(0.25)
	
	if RULE_CONDITION:
		goto RULE_START