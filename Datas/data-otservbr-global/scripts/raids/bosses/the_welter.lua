local zone = Zone("ankrahmun.the-welter")
zone:addArea(Position(33025, 32659, 5), Position(33027, 32661, 5))

local raid = Raid("ankrahmun.the-welter", {
	zone = zone,
	allowedDays = { "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday" },
	minActivePlayers = 3,
	initialChance = 9.01,
	targetChancePerDay = 9.01,
	maxChancePerCheck = 9.6,
})

raid
	:addSpawnMonsters({
		{
			name = "The Welter",
			amount = 1,
		},
	})
	:autoAdvance("24h")

raid:register()
