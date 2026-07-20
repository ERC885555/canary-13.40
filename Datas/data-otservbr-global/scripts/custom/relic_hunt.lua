local huntRelic = Action()

local huntCategories = {

    ["0-50"] = {
        --["Pits of Inferno Hub"] = Position(),
    },
    ["50-100"] = {
        --["Pits of Inferno Hub"] = Position(),
    },
    ["100-200"] = {
        --["Pits of Inferno Hub"] = Position(),
    },
    ["200-300"] = {
        --["Pits of Inferno Hub"] = Position(),
    },
    ["300-400"] = {
        --["Pits of Inferno Hub"] = Position(),
    },
    ["400-500"] = {
        --["Pits of Inferno Hub"] = Position(),
    },
    ["500-600"] = {
        --["Pits of Inferno Hub"] = Position(),
    },
    ["600-700"] = {
        --["Pits of Inferno Hub"] = Position(),
    },
    ["700-800"] = {
        --["Pits of Inferno Hub"] = Position(),
    },
    ["800-900"] = {
        --["Pits of Inferno Hub"] = Position(),
    },
    ["900-1000"] = {
        --["Pits of Inferno Hub"] = Position(),
    },
    ["1000+"] = {
        --["Pits of Inferno Hub"] = Position(),
    },
}

local function openhuntList(player, categoryName)
    local category = huntCategories[categoryName]

    local modal = ModalWindow({
        title = categoryName,
        message = "Choose your destination:"
    })

    local sortedhunt = {}

    for huntName in pairs(category) do
        table.insert(sortedhunt, huntName)
    end

    table.sort(sortedhunt)

    for _, huntName in ipairs(sortedhunt) do
        local pos = category[huntName]

        modal:addChoice(huntName, function(player, button, choice)

            if button.name ~= "Teleport" then
                return true
            end

            local currentPos = player:getPosition()

            currentPos:sendMagicEffect(CONST_ME_TELEPORT)

            player:teleportTo(pos)

            pos:sendMagicEffect(CONST_ME_TELEPORT)

            player:sendTextMessage(
                MESSAGE_EVENT_ADVANCE,
                "You have been teleported to " .. huntName .. "."
            )
        end)
    end

    modal:addButton("Teleport")
    modal:addButton("Cancel", function(player)
        return true
    end)

    modal:sendToPlayer(player)
end

function huntRelic.onUse(player, item, fromPosition, target, toPosition, isHotkey)

    if player:getCondition(CONDITION_INFIGHT) then
        player:sendTextMessage(
            MESSAGE_EVENT_ADVANCE,
            "You cannot use this relic while in combat."
        )
        return true
    end

    local modal = ModalWindow({
        title = "Relic of Hunt",
        message = "Choose a location:"
    })

    local sortedCategories = {}

    for categoryName in pairs(huntCategories) do
        table.insert(sortedCategories, categoryName)
    end

    table.sort(sortedCategories)

    for _, categoryName in ipairs(sortedCategories) do
        modal:addChoice(categoryName, function(player)
            openhuntList(player, categoryName)
        end)
    end

    modal:addButton("Open")
    modal:addButton("Cancel")

    modal:sendToPlayer(player)

    return true
end

huntRelic:id(XXXX) -- Coloque o id do item aqui
huntRelic:register()