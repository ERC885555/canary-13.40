local homeRelic = Action()

local destinations = {
    ["Home"] = Position(32520, 31601, 7),
    ["Temple"] = Position(32369, 32241, 7),
}

function homeRelic.onUse(player, item, fromPosition, target, toPosition, isHotkey)

    if player:getCondition(CONDITION_INFIGHT) then
        player:sendTextMessage(
            MESSAGE_EVENT_ADVANCE,
            "You cannot use this relic while in combat."
        )
        return true
    end

    local modal = ModalWindow({
        title = "Relic of Residence",
        message = "Choose your destination:"
    })

    for name, pos in pairs(destinations) do
        modal:addChoice(name, function(player, button, choice)

            if button.name ~= "Teleport" then
                return true
            end

            local currentPos = player:getPosition()

            currentPos:sendMagicEffect(CONST_ME_TELEPORT)

            player:teleportTo(pos)

            pos:sendMagicEffect(CONST_ME_TELEPORT)

            player:sendTextMessage(
                MESSAGE_EVENT_ADVANCE,
                "You have been teleported to " .. name .. "."
            )
        end)
    end

    modal:addButton("Teleport")
    modal:addButton("Cancel")

    modal:sendToPlayer(player)

    return true
end

homeRelic:id(12540)
homeRelic:register()