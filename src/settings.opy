#!mainFile "../main.opy"

declareConfigs([
	{
		name: "Enable Telemetry",
		type: "bool",
		value: false,
		group: "Telemetry"
	},
	{
		name: "Telemetry Interval Seconds",
		type: "int[5:30]",
		value: 10,
		group: "Telemetry"
	},
	{
		name: "Disable Inspector Recording",
		type: "bool",
		value: false,
		group: "Core"
	},
	{
		name: "Skip assemble heroes phase",
		type: "bool",
		value: true,
		group: "Core"
	},
	{
		name: "Enable fast bot respawn",
		type: "bool",
		value: true,
		group: "Core"
	},
	{
		name: "Endless Mode",
		type: "bool",
		value: false,
		group: "Core"
	},
	{
		name: "Fast bot respawn time",
		type: "float[3:10]",
		value: 3.5,
		group: "Core"
	},
	{
		name: "Skip Setup Phase",
		type: "bool",
		value: true,
		group: "Core"
	},
	{
		name: "Setup Phase Time Seconds",
		type: "float[5:10]",
		value: 10,
		group: "Core"
	},
	{
		name: "Exp per Elimination",
		type: "int[5:1000]",
		value: 750,
		group: "Scoring"
	},
	{
		name: "Exp per Level Up",
		type: "int[100:1000]",
		value: 300,
		group: "Scoring"
	},
	{
		name: "Max bot level",
		type: "int[0:200]",
		value: 0,
		group: "Scoring"
	},
	{
		name: "Exp per Final Blow",
		type: "int[5:1000]",
		value: 785,
		group: "Scoring"
	},
	{
		name: "Exp per Damage Dealt",
		type: "int[5:1000]",
		value: 200,
		group: "Scoring"
	},
	{
		name: "Exp per Healing Done",
		type: "int[5:1000]",
		value: 200,
		group: "Scoring"
	},
	{
		name: "Exp per Critical Damage",
		type: "int[5:1000]",
		value: 580,
		group: "Scoring"
	},
	{
		name: "Bot Base Move Speed Percent",
		type: "float[80:110]",
		value: 100,
		group: "Shared Params"
	},
	{
		name: "Bot Base Damage Percent",
		type: "float[80:110]",
		value: 95,
		group: "Shared Params"
	},
	{
		name: "Bot Damage Increment Per Level",
		type: "float[0.1:5]",
		value: 1.19,
		group: "Shared Params"
	},
	{
		name: "Bot Speed Increment Per Level",
		type: "float[0.1:10]",
		value: 1.02,
		group: "Shared Params"
	},
	{
		name: "Player Shield Increment On Kill",
		type: "float[0.25:10]",
		value: 0.75,
		group: "Shared Params"
	},
	{
		name: "Player Shield Increment Over Time Rate",
		type: "float[0.25:10]",
		value: 0.5,
		group: "Shared Params"
	},
	{
		name: "Post Match Auto Restart",
		type: "bool",
		value: true,
		group: "Lobby"
	},
	{
		name: "Post Match Auto Restart Delay",
		type: "float[1:30]",
		value: 12,
		group: "Lobby"
	},
	{
		name: "Auto Start Enabled",
		type: "bool",
		value: true,
		group: "Lobby"
	},
	{
		name: "Auto Start Min Players",
		type: "int[1:6]",
		value: 4,
		group: "Lobby"
	}
])