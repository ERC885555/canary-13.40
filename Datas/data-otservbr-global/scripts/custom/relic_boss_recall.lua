local bossRelic = Action()

local bossCategories = {

    ["Main Bosses"] = {
        ["Grand Master Oberon"] = Position(33364, 31342, 9),
        ["Scarlett Etzel"] = Position(33395, 32662, 6),
        ["Drume"] = Position(32458, 32507, 6),
        ["Timira"] = Position(33801, 32701, 8),
        ["Urmahlullu"] = Position(33920, 31624, 8),
    },
    ["Forgotten Knowledge"] = {
        ["Lady Tenebris"] = Position(32900, 31624, 14),
        ["Melting Frozen Horror"] = Position(32300, 31089, 14),
        ["Lloyd"] = Position(32759, 32868, 14),
        ["The Brainstealer"] = Position(32531, 31120, 15),
        ["The Last Lorekeeper"] = Position(32016, 32845, 14),
        ["The Thorn Knight"] = Position(32657, 32877, 14),
        ["The Time Guardian"] = Position(33010, 31660, 14),
    },
    ["Grave Danger"] = {
        ["Ghulosh"] = Position(32748, 32771, 10),
        ["Gorzindel"] = Position(32747, 32749, 10),
        ["Lokathmor"] = Position(32722, 32747, 10),
        ["Mazzinor"] = Position(32722, 32771, 10),
        ["Duke Krule"] = Position(33456, 31495, 13),
        ["Lord Azaram"] = Position(33423, 31495, 13),
        ["Sir Baeloc"] = Position(33425, 31411, 13),
        ["Count Vlarkorth"] = Position(33456, 31410, 13),
        ["Earl Osam"] = Position(33517, 31441, 13),
        ["King Zelos"] = Position(33489, 31546, 13),
        ["Gaffir"] = Position(33390, 32674, 4),
        ["Guard Captain Quaid"] = Position(33391, 32665, 3),
    },
    ["Feaster of Souls"] = {
        ["Vok the Freakish"] = Position(33509, 31452, 9),
        ["Irgix the Flimsy"] = Position(33490, 31395, 8),
        ["Unaz the Mean"] = Position(33570, 31477, 8),
        ["Brain Head"] = Position(31972, 32325, 10),
        ["The Fear Feaster"] = Position(33741, 31471, 14),
        ["The Unwelcome"] = Position(33743, 31537, 14),
        ["The Dread Maiden"] = Position(33745, 31506, 14),
        ["The Pale Worm"] = Position(33777, 31504, 14),
    },
    ["Secret Library"] = {
        ["Brokul"] = Position(33522, 31465, 15),
        ["Grand Canon Dominus"] = Position(33383, 31291, 7),
        ["Grand Chaplain Gaunder"] = Position(33376, 31347, 5),
        ["Grand Commander Soeren"] = Position(33375, 31319, 1),
        ["Preceptor Lazare"] = Position(33376, 31334, 3),
        ["The Scourge of Oblivion"] = Position(32676, 32743, 11),
    },
    ["Cults of Tibia"] = {
        ["The False God"] = Position(33164, 31895, 15),
        ["Leiden"] = Position(33135, 31952, 15),
        ["The Sandking"] = Position(33505, 32229, 10),
        ["Essence of Malice"] = Position(33093, 31944, 15),
        ["The Souldespoiler"] = Position(33125, 31894, 15),
        ["The Source of Corruption"] = Position(33071, 31886, 15),
    },
    ["Dream Courts"] = {
        ["Faceless Bane"] = Position(33640, 32564, 13),
        ["Dream Courts Hub"] = Position(32043, 31936, 14),
        ["The Nightmare Beast"] = Position(32212, 32073, 15),
    },
    ["Soul War"] = {
        ["Goshnar's Malice"] = Position(33680, 31597, 14),
        ["Goshnar's Spite"] = Position(33774, 31633, 14),
        ["Goshnar's Hatred"] = Position(33773, 31600, 14),
        ["Goshnar's Greed"] = Position(33776, 31664, 14),
        ["Goshnar's Megalomania"] = Position(33677, 31632, 14),
    },
    ["Primal Ordeal"] = {
        ["Magma Bubble"] = Position(33668, 32927, 15),
    },
    ["Ferumbras Ascension"] = {
        ["Tarbaz"] = Position(33418, 32841, 11),
        ["Ragiaz"] = Position(33452, 32356, 13),
        ["Plagirath"] = Position(33230, 31493, 13),
        ["Razzagorn"] = Position(33380, 32454, 14),
        ["Zamulosh"] = Position(33680, 32736, 11),
        ["Mazoran"] = Position(33593, 32658, 14),
        ["Shulgrax"] = Position(33436, 32800, 13),
        ["Ferumbras Mortal Shell"] = Position(33270, 31474, 14),
    },
    ["Other Bosses"] = {
        ["Ratmiral Blackwiskers"] = Position(33894, 31390, 15),
        ["The Monster"] = Position(33811, 32582, 12),
        ["Tentugly's Head"] = Position(33963, 31377, 15),
        ["Megasylvan Yselda"] = Position(32576, 32500, 12),
        ["Rahemos"] = Position(33120, 32798, 14),
        ["Ahsmunrah"] = Position(33149, 32867, 11),
        ["Dipthrah"] = Position(33073, 32605, 15),
        ["Mahrdis"] = Position(33159, 32771, 15),
        ["Morguthis"] = Position(33263, 32669, 13),
        ["Omruc"] = Position(33206, 32980, 14),
        ["Thalas"] = Position(33366, 32805, 14),
        ["Vashresamun"] = Position(33118, 32627, 15),
        ["Ahau"] = Position(34037, 31714, 10),
    }
}

local function openBossList(player, categoryName)
    local category = bossCategories[categoryName]

    local modal = ModalWindow({
        title = categoryName,
        message = "Choose your destination:"
    })

    local sortedBosses = {}

    for bossName in pairs(category) do
        table.insert(sortedBosses, bossName)
    end

    table.sort(sortedBosses)

    for _, bossName in ipairs(sortedBosses) do
        local pos = category[bossName]

        modal:addChoice(bossName, function(player)

            local currentPos = player:getPosition()

            currentPos:sendMagicEffect(CONST_ME_TELEPORT)

            player:teleportTo(pos)

            pos:sendMagicEffect(CONST_ME_TELEPORT)

            player:sendTextMessage(
                MESSAGE_EVENT_ADVANCE,
                "You have been teleported to " .. bossName .. "."
            )
        end)
    end

    modal:addButton("Teleport")
    modal:addButton("Back")

    modal:sendToPlayer(player)
end

function bossRelic.onUse(player, item, fromPosition, target, toPosition, isHotkey)

    if player:getCondition(CONDITION_INFIGHT) then
        player:sendTextMessage(
            MESSAGE_EVENT_ADVANCE,
            "You cannot use this relic while in combat."
        )
        return true
    end

    local modal = ModalWindow({
        title = "Relic Bosses",
        message = "Choose a boss category:"
    })

    local sortedCategories = {}

    for categoryName in pairs(bossCategories) do
        table.insert(sortedCategories, categoryName)
    end

    table.sort(sortedCategories)

    for _, categoryName in ipairs(sortedCategories) do
        modal:addChoice(categoryName, function(player)
            openBossList(player, categoryName)
        end)
    end

    modal:addButton("Open")
    modal:addButton("Cancel")

    modal:sendToPlayer(player)

    return true
end

bossRelic:id(16262)
bossRelic:register()