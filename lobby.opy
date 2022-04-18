#!mainFile "./main.opy"

settings {
    "main": {
        "description": "Fight againt pve forces capturing and holding objects.\n\nCreated By: FRNathan13#1826\nOfficial Share Code: 3F476",
        "modeName": "CONTROL POINT PVE"
    },
    "lobby": {
        "allowPlayersInQueue": true,
        "mapRotation": "afterGame",
        "returnToLobby": "afterGame",
        "swapTeamsAfterMatch": false
    },
    "gamemodes": {
        "control": {
			"scoreToWin": 2
		},
        "general": {
            "captureSpeed%": 105,
            "enableCompetitiveRules": true,
            "gamemodeStartTrigger": "allSlotsFilled",
            "enableKillCam": false,
            "enableKillCam": false,
            "respawnTime%": 70,
            "scoringSpeed%": 85,
            "spawnHealthPacks": "enabled"
        }
    },
    "heroes": {
        "allTeams": {
            "general": {
                "abilityCooldown%": 50,
                "ammoClipSize%": 150,
                "ultDuration%": 125,
                "ultGen%": 200,
                "combatUltGen%": 200,
                "passiveUltGen%": 200,
				"health%": 150
            }
        },
		"team1": {
			"general": {
				"abilityCooldown%": 45,
				"movementSpeed%": 120
			}
		}
    },
	 "workshop": {
		"Enable Telemetry": false,
		"Enable Workshop Inspector": true,
		"Endless Mode": false
    }
}