#!mainFile "../main.opy"

rule "random match id":
	@Event global
	matchId[1] = ["0","1","2","3","4","5","6","7","8","9"]
	
	for xmlEntityIndex in range(0, 16):
		matchId[0] = "{}{}".format(matchId[0], matchId[1][random.randint(0, len(matchId[1]) - 1)])
	
	matchId = matchId[0]

rule "metrics: update teams":
	@Event global
	@Condition isMatchComplete() == false
	teamParams[0] = [teamScore(eT_Player), getControlScorePercentage(eT_Player)]
	teamParams[1] = [teamScore(eT_Bot), getControlScorePercentage(eT_Bot)]
	
	if teamParams[0][0] == teamParams[1][0]:
		teamParams[2] = "bots" if teamParams[1][1] >= teamParams[0][1] else "players"
	else:
		teamParams[2] = "bots" if teamParams[1][0] > teamParams[0][0] else "players"
		
	wait(1)
	
	if RULE_CONDITION:
		goto RULE_START

rule "warning hostplayer about DONT open inspector!":
	@Event global
	@Condition optEnableTelemetry
	@Condition not optDisableInspectorRecording
	hudSubtext(hostPlayer, "\u200b\nDear host player!\n\nMatch telemetry is enabled! Please avoid opening workshop inspector or\nyour game can crash for many log entries! You can open metrics logs inside:\n '%USERPROFILE%\\Documents\\Overwatch\\Workshop' folder!\n\nAccess: https://github.com/nathan130200/PveControlPoint\nFor more details about this feature.", HudPosition.RIGHT, -99, Color.ORANGE, HudReeval.VISIBILITY, SpecVisibility.ALWAYS)
	
rule "disable inspector if needed":
	@Event global
	@Condition optDisableInspectorRecording
	disableInspector()
	
rule "collect metrics":
	@Event global
	@Condition optEnableTelemetry
	@Condition not optDisableInspectorRecording
		
	if not xmlStarted:		
		printLog("<m s='{}'>".format(matchId))
		xmlStarted = true
	
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
		
	printLog("<d ms='{}' st='{}' i='{} l='{}'>".format(xmlMatchStatus, getMatchTime(), getCurrentObjective(), 1 if isControlPointLocked() else 0))
	printLog("<l>".format(len(getPlayers(eT_Bot))))
	
	for xmlEntityIndex in range(getNumberOfSlots(eT_Bot)):
		botXML(xmlEntityIndex)
		wait()
		
	printLog("</l>")
	printLog("</d>")
	
	if isMatchComplete() and xmlStarted:
		printLog("<r mt='{}' t1='[{},{}]' t2='[{},{}]' tr='{}' />".format(getTotalTimeElapsed(),
			teamParams[0][0], teamParams[0][1], teamParams[1][0], teamParams[1][1], teamParams[2]))
		printLog("</m>")
		return
		
	wait(optTelemetryIntervalSeconds)
	
	if RULE_CONDITION:
		goto RULE_START