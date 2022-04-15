#!mainFile "./main.opy"

settings {
    "main": {
        "description": "Fight againt pve forces capturing and holding objects.\n\nCreated By: FRNathan13#1826\nOfficial Share Code: 3F476",
        "modeName": "CONTROL POINT PVE"
    },
    "lobby": {
        "allowPlayersInQueue": true,
        "mapRotation": "paused",
        "returnToLobby": "afterGame",
        "swapTeamsAfterMatch": false
    },
    "gamemodes": {
        "control": {
			"scoreToWin": 1
		},
        "general": {
            "captureSpeed%": 125,
            "enableCompetitiveRules": true,
            "gamemodeStartTrigger": "immediately",
            "enableKillCam": false,
            "respawnTime%": 70,
            "scoringSpeed%": 125,
            "spawnHealthPacks": "disabled"
        }
    },
    "heroes": {
        "allTeams": {
            "general": {
                "abilityCooldown%": 50,
                "ammoClipSize%": 150,
                "ultDuration%": 125,
                "ultGen%": 115,
                "combatUltGen%": 115,
                "passiveUltGen%": 115
            }
        }
    },
	 "workshop": {
        "Bot Base Damage Percent": 98,
        "Bot Base Move Speed Percent": 104,
        "Bot Damage Increment Per Level": 0.939,
        "Bot Speed Increment Per Level": 0.926,
        "Exp per Elimination": 350,
		"Exp per Damage Dealt": 250,
		"Exp per Final Blow": 700,
		"Exp per Healing Done": 250,
        "Exp per Level Up": 300,
        "Max bot level": -1,
		"Player Shield Increment Modifier On Bot Team Kill": 2.5,
		"Enable Telemetry": false,
		"Disable Inspector Recording": true
    }
}