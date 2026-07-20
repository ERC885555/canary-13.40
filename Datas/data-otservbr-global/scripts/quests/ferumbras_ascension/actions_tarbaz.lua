local config = {
	boss = {
		name = "Tarbaz",
		position = Position(33459, 32844, 11),
	},
	timeToDefeat = 17 * 60, -- 17 minutes in seconds
	playerPositions = {
		{ pos = Position(33418, 32849, 11), teleport = Position(33459, 32848, 11), effect = CONST_ME_TELEPORT },
		{ pos = Position(33418, 32850, 11), teleport = Position(33459, 32848, 11), effect = CONST_ME_TELEPORT },
		{ pos = Position(33418, 32851, 11), teleport = Position(33459, 32848, 11), effect = CONST_ME_TELEPORT },
		{ pos = Position(33418, 32852, 11), teleport = Position(33459, 32848, 11), effect = CONST_ME_TELEPORT },
		{ pos = Position(33418, 32853, 11), teleport = Position(33459, 32848, 11), effect = CONST_ME_TELEPORT },
	},
	specPos = {
		from = Position(33447, 32832, 11),
		to = Position(33473, 32856, 11),
	},
	exit = Position(33319, 32318, 13),
}

local leverTarbaz = Action()

function leverTarbaz.onUse(player, item, fromPosition, target, toPosition, isHotkey)

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


leverTarbaz:uid(1027)
leverTarbaz:register()
