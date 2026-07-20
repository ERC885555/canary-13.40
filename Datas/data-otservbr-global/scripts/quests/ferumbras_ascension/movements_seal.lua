local config = {
    [24839] = {
        toPosition = Position(33419, 32841, 11),
        backPosition = Position(33484, 32775, 12),
        boss = "Tarbaz",
    },
    [24840] = {
        toPosition = Position(33452, 32356, 13),
        backPosition = Position(33432, 32330, 14),
        boss = "Ragiaz",
    },
    [24841] = {
        toPosition = Position(33230, 31493, 13),
        backPosition = Position(33197, 31438, 13),
        boss = "Plagirath",
    },
    [24842] = {
        toPosition = Position(33380, 32454, 14),
        backPosition = Position(33399, 32402, 15),
        boss = "Razzagorn",
    },
    [24843] = {
        toPosition = Position(33680, 32736, 11),
        backPosition = Position(33664, 32682, 10),
        boss = "Zamulosh",
    },
    [24844] = {
        toPosition = Position(33593, 32658, 14),
        backPosition = Position(33675, 32690, 13),
        boss = "Mazoran",
    },
    [24845] = {
        toPosition = Position(33436, 32800, 13),
        backPosition = Position(33477, 32701, 14),
        boss = "Shulgrax",
    },
    [24846] = {
        toPosition = Position(33270, 31474, 14),
        backPosition = Position(33324, 31374, 14),
        boss = "Ferumbras Mortal Shell",
    },
}

local seal = MoveEvent()

function seal.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()

    if not player then
        return true
    end

    local setting = config[item.actionid]

    if not setting then
        return true
    end

    if item.actionid == 24846 then
        player:sendTextMessage(
            MESSAGE_EVENT_ADVANCE,
            "The portal leads you to the final challenge."
        )
    end

    player:teleportTo(setting.toPosition)
    setting.toPosition:sendMagicEffect(CONST_ME_TELEPORT)

    return true
end

seal:type("stepin")

for index, value in pairs(config) do
    seal:aid(index)
end

seal:register()