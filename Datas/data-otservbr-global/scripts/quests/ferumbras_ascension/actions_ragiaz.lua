local config = {
	boss = {
		name = "Ragiaz",
		position = Position(33481, 32334, 13),
	},

	timeToDefeat = 17 * 60, -- 17 minutes in seconds
	playerPositions = {
		{ pos = Position(33456, 32356, 13), teleport = Position(33482, 32339, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33457, 32356, 13), teleport = Position(33482, 32339, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33458, 32356, 13), teleport = Position(33482, 32339, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33459, 32356, 13), teleport = Position(33482, 32339, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33460, 32356, 13), teleport = Position(33482, 32339, 13), effect = CONST_ME_TELEPORT },
	},
	monsters = {
		{ name = "Death Dragon", pos = Position(33476, 32331, 13) },
		{ name = "Death Dragon", pos = Position(33476, 32340, 13) },
		{ name = "Death Dragon", pos = Position(33487, 32340, 13) },
		{ name = "Death Dragon", pos = Position(33488, 32331, 13) },
	},
	specPos = {
		from = Position(33468, 32319, 13),
		to = Position(33495, 32347, 13),
	},
	exit = Position(33319, 32318, 13),
}

local leverRagiaz = Action()

function leverRagiaz.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	
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


leverRagiaz:uid(1023)
leverRagiaz:register()
