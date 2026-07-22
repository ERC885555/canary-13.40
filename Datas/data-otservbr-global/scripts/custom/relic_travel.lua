local travelRelic = Action()

local travelCategories = {

    ["Cities"] = {
        ["Ab'Dendriel"] = Position (32732, 31634, 7),
        ["Ankrahmun"] = Position (33194, 32853, 8),
        ["Carlin"] = Position (32360, 31782, 7),
        ["Darashia"] = Position (33213, 32454, 1),
        ["Edron"] = Position (33217, 31814, 8),
        ["Farmine"] = Position (33023, 31521, 11),
        ["Gray Island"] = Position (33447, 31323, 9),
        ["Marapur"] = Position (33842, 32853, 7),
        ["Candia"] = Position (33338, 32125, 7),
        ["Ingol"] = Position (33711, 32602, 6),
        ["Krailos"] = Position (33657, 31665, 8),
        ["Issavi"] = Position (33921, 31477, 5),
        ["Feyrist"] = Position(33490, 32221, 7),
        ["Kazordoon"] = Position (32649, 31925, 11),
        ["Liberty Bay"] = Position (32317, 32826, 7),
        ["Port Hope"] = Position (32594, 32745, 7),
        ["Rathleton"] = Position (33594, 31899, 6),
        ["Roshamuul"] = Position (33513, 32363, 6),
        ["Svargrond"] = Position (32212, 31132, 7),
        ["Thais"] = Position (32369, 32241, 7),
        ["Venore"] = Position (32957, 32076, 7),
        ["Yalahar"] = Position (32787, 31276, 7),
    },
    ["Special Locations"] = {
        ["Dawnport"] = Position (32064, 31894, 6),
        ["Island of Destiny"] = Position (32091, 32027, 7),
        ["Chayenne's Realm"] = Position (32825, 31509, 7),
        ["Schrödinger's Island"] = Position (32831, 32435, 7),
        ["Basilisk"] = Position (32639, 31944, 15),
        ["Rookgaard"] = Position (32097, 32219, 7),
        ["GM Island"] = Position (32316, 31942, 7),
        ["Adventurer's Guild"] = Position (32192, 32296, 7),
        ["Forge Shrine"] = Position (32209, 32275, 7),
        ["Morgaroth Lair"] = Position (32062, 32600, 13),
        ["Ghazbaran Lair"] = Position (32228, 31184, 15),
        ["Event Room"] = Position (1062, 1024, 7),
        ["NPC Room"] = Position (994, 1029, 6),
        ["Training Room"] = Position (1116, 1094, 7),
    },
    ["Quest Entrances"] = {
        ["Pits of Inferno Hub"] = Position(32838, 32230, 13),
        ["Inquisition Hub"] = Position(33165, 31709, 14),
        ["Annihilation Quest"] = Position(33225, 31670, 13),
        ["Demon Helmet Quest"] = Position (33276, 31591, 11),
        ["Behemoth Quest"] = Position (33285, 31700, 14),
    },
}

local function openTravelList(player, categoryName)
    local category = travelCategories[categoryName]

    local modal = ModalWindow({
        title = categoryName,
        message = "Choose your destination:"
    })

    local sortedTravel = {}

    for travelName in pairs(category) do
        table.insert(sortedTravel, travelName)
    end

    table.sort(sortedTravel)

    for _, travelName in ipairs(sortedTravel) do
        local pos = category[travelName]

        modal:addChoice(travelName, function(player, button, choice)

            if button.name ~= "Teleport" then
                return true
            end

            local currentPos = player:getPosition()

            currentPos:sendMagicEffect(CONST_ME_TELEPORT)

            player:teleportTo(pos)

            pos:sendMagicEffect(CONST_ME_TELEPORT)

            player:sendTextMessage(
                MESSAGE_EVENT_ADVANCE,
                "You have been teleported to " .. travelName .. "."
            )
        end)
    end

    modal:addButton("Teleport")
    modal:addButton("Cancel", function(player)
        return true
    end)

    modal:sendToPlayer(player)
end

function travelRelic.onUse(player, item, fromPosition, target, toPosition, isHotkey)

    if player:getCondition(CONDITION_INFIGHT) then
        player:sendTextMessage(
            MESSAGE_EVENT_ADVANCE,
            "You cannot use this relic while in combat."
        )
        return true
    end

    local modal = ModalWindow({
        title = "Relic of Travel",
        message = "Choose a location:"
    })

    local sortedCategories = {}

    for categoryName in pairs(travelCategories) do
        table.insert(sortedCategories, categoryName)
    end

    table.sort(sortedCategories)

    for _, categoryName in ipairs(sortedCategories) do
        modal:addChoice(categoryName, function(player)
            openTravelList(player, categoryName)
        end)
    end

    modal:addButton("Open")
    modal:addButton("Cancel")

    modal:sendToPlayer(player)

    return true
end

travelRelic:id(31633) -- Coloque o id do item aqui
travelRelic:register()