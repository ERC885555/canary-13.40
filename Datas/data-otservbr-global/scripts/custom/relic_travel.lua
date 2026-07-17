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
        ["Yalahar"] = Position (32787, 31276, 7)
    },
    ["Special Locations"] = {
        ["Dawnport"] = Position (32064, 31894, 6),
        ["Pits of Inferno Hub"] = Position(32838, 32230, 13),
        ["Inquisition Hub"] = Position(33165, 31709, 14),
        ["Demon Helmet Quest"] = Position (33276, 31591, 11),
        ["Behemoth Quest"] = Position (33285, 31700, 14),
        ["Island of Destiny"] = Position (32091, 32027, 7),
        ["Rookgaard"] = Position (32097, 32219, 7),
        ["GM Island"] = Position (32316, 31942, 7),
        ["Event Room"] = Position (),
        ["Depot Room"] = Position ()
    },
    ["Hunt Entrances"] = {
        ["Gnomprona Entrance"] = Position (33517, 32856, 14),
        ["Lower Roshamuul"] = Position(),
        ["Upper Roshamuul"] = Position(),
        ["Roshamuul Prison"] = Position(),
        ["Wyrms Darashia"] = Position(33067, 32396, 12),
        ["Werehyaenas"] = Position(33223, 32350, 10),
        ["Issavi Crypt Wardens"] = Position(33871, 31456, 6),
        ["Soul War Hub"] = Position(33621, 31427, 10),
        ["Asura Mirror"] = Position (32812, 32753, 9),
        ["Summer Court"] = Position (33670, 32233, 7),
        ["Winter Court"] = Position (33680, 32155, 7),
        ["Cobra Bastion"] = Position (33397, 32651, 7),
        ["Bounac"] = Position (32424, 32445, 7),
        ["Falcon Bastion"] = Position (33364, 31330, 4),
        ["Bashmu"] = Position (33971, 31653, 7),
        ["Issavi Surface"] = Position (33939, 31549, 6),
        ["Issavi Sewers"] = Position (33926, 31465, 7),
        ["Secret Library"] = Position (32515, 32532, 12),
       ["Werelions"] = Position (33160, 32335, 12),
        ["Pirats"] = Position (33838, 31222, 5),
        ["Nagas"] = Position (33659, 32738, 7),
    },
    ["Utilities"] = {
        ["Adventurer's Guild"] = Position (32200, 32294, 7),
--        ["Blessings"] = Position (),
--        ["Offline Training"] = Position (),
--        ["Prey Shrine"] = Position ()
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

        modal:addChoice(travelName, function(player)

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
    modal:addButton("Back")

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

travelRelic:id(XXXXXX) -- Coloque o id do item aqui
travelRelic:register()