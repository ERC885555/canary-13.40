local config = {
	boss = {
		name = "Ferumbras Mortal Shell",
		position = Position(33392, 31473, 14),
	},
	timeToDefeat = 17 * 60, -- 17 minutes in seconds
	playerPositions = {
		{ pos = Position(33269, 31477, 14), teleport = Position(33390, 31483, 14), effect = CONST_ME_TELEPORT },
	},
	specPos = {
		from = Position(33374, 31458, 14),
		to = Position(33414, 31498, 14),
	},
	exit = Position(33319, 32318, 13),
	centerRoom = Position(33392, 31473, 14),
	summonName = "Rift Fragment",
	maxSummon = 3,
}

local leverFerumbras = Action()

function leverFerumbras.onUse(player, item, fromPosition, target, toPosition, isHotkey)

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

leverFerumbras:uid(1021)
leverFerumbras:register()
