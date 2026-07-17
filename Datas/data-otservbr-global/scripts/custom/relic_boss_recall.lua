local bossRelic = Action()

local bosses = {
    ["Grand Master Oberon"] = Position(33364, 31342, 9),
    ["Scarlett Etzel"] = Position(33395, 32662, 6),
    ["Drume"] = Position(32458, 32507, 6),
    ["Urmahlullu"] = Position(33920, 31624, 8),
    ["Vok the Freakish"] = Position(33509, 31452, 9),
    ["Irgix the Flimsy"] = Position(33490, 31395, 8),
    ["Unaz the Mean"] = Position(33570, 31477, 8),
    ["Brain Head"] = Position(31972, 32325, 10),
    ["The Fear Feaster"] = Position(33741, 31471, 14),
    ["The Unwelcome"] = Position(33743, 31537, 14),
    ["The Dread Maiden"] = Position(33745, 31506, 14),
    ["The Pale Worm"] = Position(33777, 31504, 14),
    ["Duke Krule"] = Position(33456, 31495, 13),
    ["Lord Azaram"] = Position(33423, 31495, 13),
    ["Sir Baeloc"] = Position(33425, 31411, 13),
    ["Count Vlarkorth"] = Position(33456, 31410, 13),
    ["Earl Osam"] = Position(33517, 31441, 13),
    ["King Zelos"] = Position(33489, 31546, 13),
    ["Ratmiral Blackwiskers"] = Position(33894, 31390, 15),
    ["Faceless Bane"] = Position(33640, 32564, 13),
    ["Ghulosh"] = Position(32748, 32771, 10),
    ["Gorzindel"] = Position(32747, 32749, 10),
    ["Lokathmor"] = Position(32722, 32747, 10),
    ["Mazzinor"] = Position(32722, 32771, 10),
    ["Megasylvan Yselda"] = Position(32576, 32500, 12),
    ["Lady Tenebris"] = Position(32900, 31624, 14),
    ["Melting Frozen Horror"] = Position(32300, 31089, 14),
    ["Magma Bubble"] = Position(33668, 32927, 15),
    ["The Brainstealer"] = Position(32531, 31120, 15),
    ["The Last Lorekeeper"] = Position(32016, 32845, 14),
    ["The Monster"] = Position(33811, 32582, 12),
    ["The Nightmare Beast"] = Position(32212, 32073, 15),
    ["The Primal Menace"] = Position(33549, 32750, 14),
    ["The Scourge of Oblivion"] = Position(32676, 32743, 11),
    ["The Thorn Knight"] = Position(32657, 32877, 14),
    ["The Time Guardian"] = Position(33010, 31660, 14),
    ["Ahau"] = Position(34037, 31714, 10),
    ["Lloyd"] = Position(32759, 32868, 14),
    ["Brokul"] = Position(33522, 31465, 15),
    ["Goshnar's Malice"] = Position(33680, 31597, 14),
    ["Goshnar's Spite"] = Position(33774, 31633, 14),
    ["Goshnar's Hatred"] = Position(33773, 31600, 14),
    ["Goshnar's Greed"] = Position(33776, 31664, 14),
    ["Goshnar's Megalomania"] = Position(33677, 31632, 14),
    ["Timira"] = Position(33801, 32701, 8),
    ["Rookgaard"] = Position(32097, 32219, 7),
}

function bossRelic.onUse(player, item, fromPosition, target, toPosition, isHotkey)

    if player:getCondition(CONDITION_INFIGHT) then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE,
            "You cannot use this relic while in combat."
        )
        return true
    end

    local modal = ModalWindow({
        title = "Relic of Boss Recall",
        message = "Choose your destination:"
    })

    for bossName, pos in pairs(bosses) do
        modal:addChoice(bossName, function(player)

            local currentPos = player:getPosition()

            currentPos:sendMagicEffect(CONST_ME_TELEPORT)

            player:teleportTo(pos)

            pos:sendMagicEffect(CONST_ME_TELEPORT)

            player:sendTextMessage(
                MESSAGE_EVENT_ADVANCE,
                "You have been teleported to the waiting room of " .. bossName .. "."
            )

        end)
    end

    modal:addButton("Teleport")
    modal:addButton("Cancel")

    modal:sendToPlayer(player)

    return true
end

bossRelic:id(16262) -- ID da relíquia
bossRelic:register()