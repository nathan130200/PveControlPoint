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
		name: "Fast bot respawn time",
		type: "float[3:10]",
		value: 3.5,
		group: "Core"
	},
	{
		name: "Skip setup phase",
		type: "bool",
		value: true,
		group: "Core"
	},
	{
		name: "Setup phase skip time",
		type: "float[5:10]",
		value: 6,
		group: "Core"
	},
	{
		name: "Exp per Elimination",
		type: "int[5:1000]",
		value: 350,
		group: "Scoring"
	},
	{
		name: "Exp per Level Up",
		type: "int[100:1000]",
		value: 500,
		group: "Scoring"
	},
	{
		name: "Max bot level",
		type: "int[-1:200]",
		value: 100,
		group: "Scoring"
	},
	{
		name: "Exp per Final Blow",
		type: "int[5:1000]",
		value: 700,
		group: "Scoring"
	},
	{
		name: "Exp per Damage Dealt",
		type: "int[5:1000]",
		value: 150,
		group: "Scoring"
	},
	{
		name: "Exp per Healing Done",
		type: "int[5:1000]",
		value: 150,
		group: "Scoring"
	},
	{
		name: "Exp per Critical Damage",
		type: "int[5:1000]",
		value: 250,
		group: "Scoring"
	},
	{
		name: "Bot Base Move Speed Percent",
		type: "float[80:110]",
		value: 105.79,
		group: "Shared Params"
	},
	{
		name: "Bot Base Damage Percent",
		type: "float[80:110]",
		value: 103.96,
		group: "Shared Params"
	},
	{
		name: "Bot Damage Increment Per Level",
		type: "float[0.1:5]",
		value: 0.75,
		group: "Shared Params"
	},
	{
		name: "Bot Speed Increment Per Level",
		type: "float[0.1:10]",
		value: 1.25,
		group: "Shared Params"
	},
	{
		name: "Player Shield Increment Modifier On Bot Team Kill",
		type: "float[0.25:10]",
		value: 0.65,
		group: "Shared Params"
	}
])