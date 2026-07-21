local huntRelic = Action()

local huntCategories = {

    ["0-50"] = {
        ["Orc Fortress (Venore)"] = Position (32891, 31772, 6),
        ["Mintwalin"] = Position (32493, 32102, 15),
    },
    ["50-100"] = {
        ["Yalahar Sunken Quarter"] = Position(32948, 31182, 6),
        ["Dragon Lair (Pits Of Inferno)"] = Position(32816, 32337, 11),
        ["Dragon Lair (Darama)"] = Position(32265, 32276, 7),
        ["Demonwar Dungeon"] = Position (33165, 31649, 13),
        ["Brimestone Bug Cave"] = Position (33293, 31140, 7),
        ["Temple of Equilibrium"] = Position (33180, 31200, 8),
        ["Mutated Tiger"] = Position (33334, 31151, 5),
    },
    ["100-200"] = {
        ["Demona"] = Position (32511, 31723, 14),
        ["Orc Fortress (Edron)"] = Position (33173, 31876, 7),
        ["Hero Fortress (Edron)"] = Position (33224, 31650, 7),
        ["Yielothax"] = Position (32942, 31593, 8),
        ["Calassa"] = Position (31913, 32712, 12),
        ["Grim Reaper Drefia"] = Position (33030, 32450, 11),
        ["Wyrms Darashia"] = Position(33067, 32396, 12),
        ["Wyrms Vandura"] = Position(32388, 32844, 8),
        ["Dragon Lair (Fenrock)"] = Position(32601, 31396, 14),
        ["Stampors"] = Position (33165, 31209, 8),
        ["Black Serpent Dungeon"] = Position (33285, 31204, 9),
        ["Black Sphinx Estate"] = Position (32806, 31657, 8),
        ["Sea Serpent"] = Position(31909, 31185, 9),
        ["Isle of Evil"] = Position (32677, 31456, 7),
    },
    ["200-300"] = {
        ["Glooth Factory"] = Position(33651, 31941, 7),
        ["Ghastly Dragon Lair"] = Position(33176, 31016, 7),
        ["Spirittrails"] = Position(33139, 31058, 6),
        ["Feyrist Undergound"] = Position(33548, 32267, 8),
        ["Medusa Cave"] = Position (31928, 32632, 10),
        ["Kharos"] = Position (32120, 32709, 7),
        ["Oramond Catacombs"] = Position (33525, 32024, 10),
        ["First Dragon Lair"] = Position (31994, 32391, 9),
        ["Hydra Oramond"] = Position (33507, 31888, 8),
        ["Minotaur Cult"] = Position (31936, 32503, 8),
        ["Demon Hell"] = Position(33143, 31700, 14),
        ["Hive Main Structure"] = Position (33481, 31201, 8),
        ["Minotaur Camp (Oramond)"] = Position (33682, 31940, 6),
        ["Hive"] = Position (33549, 31261, 6),
        ["Iksupan"] = Position (34016, 31834, 8),
        ["Werehyaenas"] = Position(33223, 32350, 10),
        ["Liberty Bay Fortress"] = Position(32409, 32804, 5),
        ["Asura Palace"] = Position (32950, 32691, 7),
        ["Werelions"] = Position (33160, 32335, 12),
        ["Pirats"] = Position (33838, 31222, 5),
    },
    ["300-400"] = {
        ["Gnomebase Alpha"] = Position (33011, 31895, 9),
        ["Rathleton Slum"] = Position (33562, 31918, 6),
        ["Upper Roshamuul"] = Position(33674, 32359, 6),
        ["Lower Roshamuul"] = Position(33532, 32480, 6),
        ["Foam Stalker"] = Position (33743, 32781, 7),
        ["Ferumbras Entrance"] = Position (33322, 32324, 12)
        ["Issavi Sewers"] = Position (33926, 31465, 7),
        ["Medusa Tower"] = Position (32850, 32814, 8),
        ["Rathleton Catacombs"] = Position (33453, 31725, 9),
        ["Roshamuul Cistern"] = Position (33666, 32272, 7),
        ["Roshamuul Mines"] = Position (33691, 32349, 7),
        ["Roshamuul Mountains"] = Position (33558, 32358, 6),
        ["Roshamuul Prison"] = Position(33589, 32434, 8),
        ["Seacrest Grounds"] = Position(33557, 31631, 13),
        ["Temple of the Moon Goddess"] = Position(33659, 32738, 7),
        ["Asura Mirror"] = Position (32812, 32753, 9),
        ["Issavi Crypt Wardens"] = Position(33871, 31456, 6),
        ["Diremaw 1"] = Position(33838, 32085, 15),
        ["Diremaw 2"] = Position(33841, 32175, 15),
    },
    ["400-500"] = {
        ["Asura Vaults"] = Position(32885, 32805, 9),
        ["Central Steppe"] = Position(33871, 31456, 6),
        ["Issavi Surface"] = Position (33939, 31549, 6),
        ["Deep Desert"] = Position (32959, 32322, 8),
        ["Cobra Bastion"] = Position (33397, 32651, 7),
        ["Hell Hub"] = Position (33309, 32377, 13),
        ["Killmaesh Catacombs"] = Position (33857, 31528, 7),
        ["Deeper Ingol"] = Position (33798, 32573, 7),
        ["Falcon Bastion"] = Position (33364, 31330, 4),
        ["Antrum of the Fallen"] = Position (32684, 31756, 10),
        ["Summer Court"] = Position (33670, 32233, 7),
        ["Winter Court"] = Position (33680, 32155, 7),
        ["Bashmu"] = Position (33971, 31653, 7),
        ["The Cube"] = Position (33842, 32507, 14),
        ["Secret Library"] = Position (32515, 32532, 12),
    },
    --["500-600"] = {
        --["Hunt"] = Position(),
    --},
    --["600-700"] = {
        --["Hunt"] = Position(),
    --},
    --["700-800"] = {
        --["Hunt"] = Position(),
    --},
    --["800-900"] = {
        --["Hunt"] = Position(),
    --},
    --["900-1000"] = {
        --["Hunt"] = Position(),
    --},
    ["1000+"] = {
        ["Gnomprona Entrance"] = Position (33517, 32856, 14),
        ["Soul War Hub"] = Position(33621, 31427, 10),

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

huntRelic:id(22120) -- Coloque o id do item aqui
huntRelic:register()