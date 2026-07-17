local setting = {
	-- At what level can do the quest?
	requiredLevel = 100,
	-- Can it be done daily? true = yes, false = no
	daily = true,
	-- Do not change from here down
	centerDemonRoomPosition = { x = 33221, y = 31659, z = 13 },
	demonsPositions = {
		{ x = 33219, y = 31657, z = 13 },
		{ x = 33221, y = 31657, z = 13 },
		{ x = 33223, y = 31659, z = 13 },
		{ x = 33224, y = 31659, z = 13 },
		{ x = 33220, y = 31661, z = 13 },
		{ x = 33222, y = 31661, z = 13 },
	},
	playersPositions = {
		{ fromPos = { x = 33225, y = 31671, z = 13 }, toPos = { x = 33222, y = 31659, z = 13 } },
		{ fromPos = { x = 33224, y = 31671, z = 13 }, toPos = { x = 33221, y = 31659, z = 13 } },
		{ fromPos = { x = 33223, y = 31671, z = 13 }, toPos = { x = 33220, y = 31659, z = 13 } },
		{ fromPos = { x = 33222, y = 31671, z = 13 }, toPos = { x = 33219, y = 31659, z = 13 } },
	},
}

local lever = Action()

function lever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 2772 then
		-- Single player check
		if player:getLevel() < setting.requiredLevel then
		player:sendTextMessage(
			MESSAGE_EVENT_ADVANCE,
			"You need to be level " .. setting.requiredLevel .. " or higher."
		)
		return true
		end

		-- Checks if there are still players inside the room, if so, return true
		if roomIsOccupied(setting.centerDemonRoomPosition, true, 4, 4) then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "A team is already inside the quest room.")
			return true
		end

		-- Create monsters
		for i = 1, #setting.demonsPositions do
			Game.createMonster("Angry Demon", setting.demonsPositions[i])
		end

		-- Teleport only the player who pulled the lever
		local destination = Position(33222, 31659, 13)

		player:teleportTo(destination)
		destination:sendMagicEffect(CONST_ME_TELEPORT)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		item:transform(2773)
	elseif item.itemid == 2773 then
		-- If it has "daily = true" then it will execute this function
		if setting.daily then
			player:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
			return true
		end
		-- Not be able to push the lever back if someone is still inside the monsters room
		if roomIsOccupied(setting.centerDemonRoomPosition, true, 4, 4) then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "A team is already inside the quest room.")
			return true
		end
		-- Removes all monsters so that the next team can enter
		if Position.removeMonster(setting.centerDemonRoomPosition, 4, 4) then
			return true
		end
		item:transform(2772)
	end
	return true
end

lever:uid(30025)
lever:register()
