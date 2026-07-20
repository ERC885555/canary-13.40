local config = {
	boss = {
		name = "Plagirath",
		position = Position(33172, 31501, 13),
	},
	timeToDefeat = 17 * 60, -- 17 minutes in seconds
	playerPositions = {
		{ pos = Position(33229, 31500, 13), teleport = Position(33173, 31504, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33229, 31501, 13), teleport = Position(33173, 31504, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33229, 31502, 13), teleport = Position(33173, 31504, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33229, 31503, 13), teleport = Position(33173, 31504, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33229, 31504, 13), teleport = Position(33173, 31504, 13), effect = CONST_ME_TELEPORT },
	},
	specPos = {
		from = Position(33159, 31488, 13),
		to = Position(33190, 31515, 13),
	},
	exit = Position(33319, 32318, 13),
}

local leverPlagirath = Action()

function leverPlagirath.onUse(player, item, fromPosition, target, toPosition, isHotkey)

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

	addEvent(clearBossRoom, config.timeToDefeat * 1000, config.specPos.from, config.specPos.to, config.exit)

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


leverPlagirath:uid(1022)
leverPlagirath:register()
