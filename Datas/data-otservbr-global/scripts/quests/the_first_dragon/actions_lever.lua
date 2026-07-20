local lever = Action()

local config = {
	centerRoom = { x = 33616, y = 31022, z = 14 },
	range = 10,
	storage = Storage.FirstDragon.FirstDragonTimer,
	monsterPosition = {
		{ position = Position(33574, 31013, 14) },
		{ position = Position(33592, 31013, 14) },
		{ position = Position(33583, 31022, 14) },
		{ position = Position(33574, 31031, 14) },
		{ position = Position(33592, 31031, 14) },
	},
	playerPositions = {
		Position(33582, 30993, 14),
		Position(33583, 30993, 14),
		Position(33584, 30993, 14),
		Position(33582, 30994, 14),
		Position(33583, 30994, 14),
		Position(33584, 30994, 14),
		Position(33582, 30995, 14),
		Position(33583, 30995, 14),
		Position(33584, 30995, 14),
		Position(33582, 30996, 14),
		Position(33583, 30996, 14),
		Position(33584, 30996, 14),
		Position(33582, 30997, 14),
		Position(33583, 30997, 14),
		Position(33584, 30997, 14),
	},
	toPosition1 = Position(33574, 31017, 14),
	roomTile1 = {
		{ fromPosition = Position(33582, 30993, 14) },
		{ fromPosition = Position(33583, 30993, 14) },
		{ fromPosition = Position(33584, 30993, 14) },
	},
	toPosition2 = Position(33592, 31017, 14),
	roomTile2 = {
		{ fromPosition = Position(33582, 30994, 14) },
		{ fromPosition = Position(33583, 30994, 14) },
		{ fromPosition = Position(33584, 30994, 14) },
	},
	toPosition3 = Position(33592, 31035, 14),
	roomTile3 = {
		{ fromPosition = Position(33582, 30995, 14) },
		{ fromPosition = Position(33583, 30995, 14) },
		{ fromPosition = Position(33584, 30995, 14) },
	},
	toPosition4 = Position(33574, 31035, 14),
	roomTile4 = {
		{ fromPosition = Position(33582, 30996, 14) },
		{ fromPosition = Position(33583, 30996, 14) },
		{ fromPosition = Position(33584, 30996, 14) },
	},
	toPosition5 = Position(33583, 31026, 14),
	roomTile5 = {
		{ fromPosition = Position(33582, 30997, 14) },
		{ fromPosition = Position(33583, 30997, 14) },
		{ fromPosition = Position(33584, 30997, 14) },
	},
}

function lever.onUse(player, item, fromPosition, target, toPosition, isHotkey)

    for d = 1, 5 do
        Game.createMonster(
            "unbeatable dragon",
            Position(
                math.random(33610, 33622),
                math.random(31016, 31030),
                14
            ),
            true,
            true
        )
    end

    for b = 1, #config.monsterPosition do
        Game.createMonster(
            "fallen challenger",
            config.monsterPosition[b].position,
            true,
            true
        )
    end

    player:teleportTo(config.toPosition5)
    player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)

    player:setStorageValue(
        config.storage,
        os.time() + 20 * 3600
    )

    player:setStorageValue(
        Storage.FirstDragon.SomewhatBeatable,
        0
    )

    addEvent(
        clearRoom,
        60 * 60 * 1000,
        Position(33583, 31022, 14),
        50,
        50,
        config.storage
    )

    Game.createMonster(
        "spirit of fertility",
        Position(33625, 31021, 14),
        true,
        true
    )

    if item.itemid == 8911 then
        item:transform(8912)
    else
        item:transform(8911)
    end

    return true
end


lever:uid(30003)
lever:register()
