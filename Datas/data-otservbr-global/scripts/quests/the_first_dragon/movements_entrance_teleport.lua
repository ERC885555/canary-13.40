local UniqueTable = {
    [35001] = {
        newPos = { x = 32015, y = 32466, z = 8 },
        bossName = "Tazhadur",
        bossPos = { x = 32018, y = 32465, z = 8 },
        range = 10,
    },

    [35002] = {
        newPos = { x = 32078, y = 32456, z = 8 },
        bossName = "Kalyassa",
        bossPos = { x = 32079, y = 32459, z = 8 },
        range = 10,
    },

    [35003] = {
        newPos = { x = 32008, y = 32396, z = 8 },
        bossName = "Zorvorax",
        bossPos = { x = 32015, y = 32396, z = 8 },
        range = 10,
    },

    [35004] = {
        newPos = { x = 32076, y = 32402, z = 8 },
        bossName = "Gelidrazah The Frozen",
        bossPos = { x = 32078, y = 32400, z = 8 },
        range = 10,
    },
}

local entranceTeleport = MoveEvent()

function entranceTeleport.onStepIn(creature, item, position, fromPosition)

    local player = creature:getPlayer()

    if not player then
        return true
    end

    local setting = UniqueTable[item.uid]

    if not setting then
        return true
    end

    local monster = Game.createMonster(
        setting.bossName,
        setting.bossPos,
        true,
        true
    )

    if monster then
        monster:setReward(true)
    end

    player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)

    player:teleportTo(setting.newPos)

    player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)

    player:say(
        "You have thirty minutes to kill and loot this boss.",
        TALKTYPE_MONSTER_SAY
    )

    addEvent(
        clearBossRoom,
        60 * 30 * 1000,
        player.uid,
        setting.bossPos,
        false,
        setting.range,
        setting.range,
        fromPosition
    )

    return true
end

for index, value in pairs(UniqueTable) do
    entranceTeleport:uid(index)
end

entranceTeleport:register()