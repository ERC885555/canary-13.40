local config = {
	boss = {
		name = "The Lord of The Lice",
		position = Position(33220, 31460, 12),
	},
	timeToDefeat = 17 * 60, -- 17 minutes in seconds
	playerPositions = {
		{ pos = Position(33197, 31475, 11), teleport = Position(33215, 31470, 12), effect = CONST_ME_TELEPORT },
		{ pos = Position(33198, 31475, 11), teleport = Position(33215, 31470, 12), effect = CONST_ME_TELEPORT },
		{ pos = Position(33199, 31475, 11), teleport = Position(33215, 31470, 12), effect = CONST_ME_TELEPORT },
		{ pos = Position(33200, 31475, 11), teleport = Position(33215, 31470, 12), effect = CONST_ME_TELEPORT },
		{ pos = Position(33201, 31475, 11), teleport = Position(33215, 31470, 12), effect = CONST_ME_TELEPORT },
	},
	specPos = {
		from = Position(33187, 31429, 12),
		to = Position(33242, 31487, 12),
	},
	exit = Position(33319, 32318, 13),
}

local ferumbrasAscendantRatLever = Action()

function ferumbrasAscendantRatLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local spectators = Game.getSpectators(config.specPos.from, false, false, 0, 0, 0, 0, config.specPos.to)
	for _, spec in pairs(spectators) do
		if spec:isPlayer() then
			player:say("Someone is already inside the room.", TALKTYPE_MONSTER_SAY)
			return true
		end
	end

	if isBossInRoom(config.specPos.from, config.specPos.to, config.boss.name) then
		player:say("The room is being cleared. Please wait a moment.", TALKTYPE_MONSTER_SAY)
		return true
	end

	local players = { player }

	local teleportPos = config.playerPositions[1].teleport

	fromPosition:sendMagicEffect(CONST_ME_TELEPORT)

	player:teleportTo(teleportPos)

	teleportPos:sendMagicEffect(CONST_ME_TELEPORT)

	Game.createMonster(config.boss.name, config.boss.position)

	addEvent(clearBossRoom, config.timeToDefeat * 1000, config.specPos.from, config.specPos.to, config.exit)

	if item.itemid == 8911 then
		item:transform(8912)
	else
		item:transform(8911)
	end

	return true
end

function clearBossRoom(fromPos, toPos, exitPos)
	local spectators = Game.getSpectators(fromPos, false, false, 0, 0, 0, 0, toPos)
	for _, spec in pairs(spectators) do
		if spec:isPlayer() then
			spec:teleportTo(exitPos)
			exitPos:sendMagicEffect(CONST_ME_TELEPORT)
			spec:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You took too long, the battle has ended.")
		else
			spec:remove()
		end
	end
end

function isBossInRoom(fromPos, toPos, bossName)
	local bossRemoved = false
	for x = fromPos.x, toPos.x do
		for y = fromPos.y, toPos.y do
			for z = fromPos.z, toPos.z do
				local tile = Tile(Position(x, y, z))
				if tile then
					local creature = tile:getTopCreature()
					if creature and creature:isMonster() and creature:getName() == bossName then
						creature:remove()
						bossRemoved = true
					end
				end
			end
		end
	end
	return bossRemoved
end

ferumbrasAscendantRatLever:uid(1030)
ferumbrasAscendantRatLever:register()
