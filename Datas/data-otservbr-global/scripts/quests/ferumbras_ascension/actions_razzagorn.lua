local config = {
	boss = {
		name = "Razzagorn",
		position = Position(33422, 32467, 14),
	},
	timeToDefeat = 17 * 60, -- 17 minutes in seconds
	playerPositions = {
		{ pos = Position(33386, 32455, 14), teleport = Position(33419, 32467, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(33387, 32455, 14), teleport = Position(33419, 32467, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(33388, 32455, 14), teleport = Position(33419, 32467, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(33389, 32455, 14), teleport = Position(33419, 32467, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(33390, 32455, 14), teleport = Position(33419, 32467, 14), effect = CONST_ME_TELEPORT },
	},
	specPos = {
		from = Position(33407, 32453, 14),
		to = Position(33439, 32481, 14),
	},
	exit = Position(33319, 32318, 13),
}

local leverRazzagorn = Action()

function leverRazzagorn.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	
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


leverRazzagorn:uid(1024)
leverRazzagorn:register()
