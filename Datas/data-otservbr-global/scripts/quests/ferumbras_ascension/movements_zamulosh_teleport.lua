local zamuloshTeleport = MoveEvent()

function zamuloshTeleport.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()

    if not player then
        return true
    end

    local destination = Position(33618, 32620, 10)

    player:teleportTo(destination)
    destination:sendMagicEffect(CONST_ME_TELEPORT)

    return true
end

zamuloshTeleport:type("stepin")
zamuloshTeleport:aid(34313, 34314)
zamuloshTeleport:register()