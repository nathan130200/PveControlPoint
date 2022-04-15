#!mainFile "../main.opy"
	
declareVariables('global', [
	'xmlIsOpenTag',
	'xmlMatchStatus',
	'xmlEntityIndex',
	'xmlEntity',
	'matchId'
])

rule "random match id":
	@Event global
	matchId[1] = ["0","1","2","3","4","5","6","7","8","9"]
	
	for xmlEntityIndex in range(0, 256):
		matchId[0] = "{}{}".format(matchId[0], matchId[1][random.randint(0, len(matchId[1]) - 1)])
	
	matchId = matchId[0]

#!define xmlStat(entity) "[{},{},{},{},{},{},{},{}]".format(\
	entity.getStatistic(Stat.DAMAGE_DEALT),\
	entity.getStatistic(Stat.DAMAGE_TAKEN),\
	entity.getStatistic(Stat.HEALING_DEALT),\
	entity.getStatistic(Stat.DAMAGE_BLOCKED),\
	entity.getStatistic(Stat.FINAL_BLOWS),\
	entity.getStatistic(Stat.DEFENSIVE_ASSISTS),\
	entity.getStatistic(Stat.OFFENSIVE_ASSISTS),\
	entity.getUltCharge())
	
#!define heroIndex(entity) getAllHeroes().index(entity.getCurrentHero())

#!define botXML(slot) xmlEntity = getPlayersInSlot(slot, eT_Bot)\
	printLog("<b x='{}' h='{}' l='{}' e='{}' dm='{}' sm='{}' st='{}' />".format(slot, heroIndex(xmlEntity), xmlEntity.botLevel, xmlEntity.botExp, xmlEntity.dmgModifier, xmlEntity.speedModifier, xmlStat(xmlEntity)))

rule "warning hostplayer about DONT open inspector!":
	@Event global
	@Condition optEnableTelemetry
	@Condition not optDisableInspectorRecording
	hudSubheader(hostPlayer, "\u200b\nDear host player!\n\nMatch telemetry is enabled! Please avoid opening workshop inspector or\nyour game can crash for many log entries! You can open metrics logs inside:\n '%USERPROFILE%\\Documents\\Overwatch\\Workshop' folder!\n\nContains XML serialized data for track bot stats in this match.", HudPosition.RIGHT, -99, Color.ORANGE, HudReeval.VISIBILITY, SpecVisibility.ALWAYS)

#!define getWonTeam() ("bots" if teamScore(eT_Bot) >= teamScore(eT_Player) else "players")

rule "collect metrics":
	@Event global
	@Condition optEnableTelemetry
	@Condition not optDisableInspectorRecording
		
	if not xmlIsOpenTag:
		if optDisableInspectorRecording:
			disableInspector()
		
		printLog("<m s='{}'>".format(matchId))
		xmlIsOpenTag = true
	
	if isAssemblingHeroes():
		xmlMatchStatus = 1
	elif isInSetup():
		xmlMatchStatus = 2
	elif isGameInProgress():
		xmlMatchStatus = 3
	elif isMatchComplete():
		xmlMatchStatus = 4
	elif isWaitingForPlayers():
		xmlMatchStatus = 5
	else:
		xmlMatchStatus = -1
		
	printLog("<d ms='{}' st='{}'>".format(xmlMatchStatus, getMatchTime()))
	printLog("<cp i='{}' p='{}' l='{}'/>".format(getCurrentObjective(), getCapturePercentage(), 1 if isControlPointLocked() else 0))
	printLog("<l>".format(len(getPlayers(eT_Bot))))
	
	for xmlEntityIndex in range(getNumberOfSlots(eT_Bot)):
		botXML(xmlEntityIndex)
		wait()
		
	printLog("</l>")
	printLog("</d>")
	
	if isMatchComplete():
		printLog("<r mt='{}' t1='{}' t2='{}' tr='{}' />".format(getTotalTimeElapsed(),
			teamScore(Team.1), teamScore(Team.2), getWonTeam()))
		printLog("</m>")
		enableInspector()
		return
		
	wait(optTelemetryIntervalSeconds)
	
	if RULE_CONDITION:
		goto RULE_START