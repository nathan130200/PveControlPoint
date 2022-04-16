#!mainFile "../main.opy"

#!define eT_Player Team.1
#!define eT_Bot Team.2

# Returns number of spawned players on non bots team
#!define numSpawnedPlayers len([x for x in getPlayers(eT_Player) if x.hasSpawned()])

# Scaled player health to percentage
#!define scaledHealth(player) round((eventPlayer.getNormalizedHealth() * 100))

# An alias, so we don't need another variable :P
#!defineMember healthPoolModifier damageMod

#!define heroNameWithIcon(x) heroIcon(x.getCurrentHero()), x.getCurrentHero()

/* Variable Name Obfuscator */
#!define declareVariables(scope, names) __script__("util/variableNameGenerator.js")

/* Workshop Setting Alias */
#!define declareConfigs(params) __script__("util/configGenerator.js")

/* XML metrics generation stuff */

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
	printLog("<b x='{}' h='{}' l='{}' e='{}' dm='{}' sm='{}' st='{}' />".format(slot, heroIndex(xmlEntity), xmlEntity.botLevel, xmlEntity.botExp, xmlEntity.damageMod, xmlEntity.speedMod, xmlStat(xmlEntity)))