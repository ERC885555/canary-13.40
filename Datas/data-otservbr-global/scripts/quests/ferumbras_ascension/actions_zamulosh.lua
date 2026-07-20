local config = {
	boss = {
		name = "Zamulosh",
		position = Position(33643, 32756, 11),
	},
	timeToDefeat = 17 * 60,
	playerPositions = {
		{ pos = Position(33680, 32741, 11), teleport = Position(33644, 32760, 11), effect = CONST_ME_TELEPORT },
	},
	specPos = {
		from = Position(33632, 32747, 11),
		to = Position(33654, 32765, 11),
	},
	exit = Position(33319, 32318, 13),

	summons = {
		Position(33642, 32756, 11),
		Position(33642, 32756, 11),
		Position(33642, 32756, 11),
		Position(33644, 32756, 11),
		Position(33644, 32756, 11),
		Position(33644, 32756, 11),
	},
}

local leverZamulosh = Action()

function leverZamulosh.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	local teleportPos = config.playerPositions[1].teleport
	fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
	player:teleportTo(teleportPos)
	teleportPos:sendMagicEffect(CONST_ME_TELEPORT)

	local boss = Game.createMonster(
		config.boss.name,
		config.boss.position
	)
	
		if boss then
			boss:setReward(true)
		end

    	local zamuloshIndex = math.random(#config.summons)

	for i, summonPos in ipairs(config.summons) do
		if i == zamuloshIndex then
		Game.createMonster(config.boss.name, summonPos)
		else
		Game.createMonster("Zamulosh3", summonPos)
		end
	end

    addEvent(
        clearBossRoom,
        config.timeToDefeat * 1000,
        config.specPos.from,
        config.specPos.to,
        config.exit
    )

    if item.itemid == 8911 then
        item:transform(8912)
    else
        item:transform(8911)
    end

    return true
end

function clearBossRoom(fromPos, toPos, exitPos)
    local spectators = Game.getSpectators(
        fromPos,
        false,
        false,
        0,
        0,
        0,
        0,
        toPos
    )

    for _, spec in pairs(spectators) do
        if spec:isPlayer() then
            spec:teleportTo(exitPos)
            exitPos:sendMagicEffect(CONST_ME_TELEPORT)

            spec:sendTextMessage(
                MESSAGE_EVENT_ADVANCE,
                "You took too long, the battle has ended."
            )
        else
            spec:remove()
        end
    end
end

leverZamulosh:uid(1026)
leverZamulosh:register()
