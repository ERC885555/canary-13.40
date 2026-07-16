-- Supreme Amulet (+85% Physical/Death Protection & +25% Elemental Protection)

-- ====================================================
-- EVENTOS DE MOVIMENTO (EQUIP / DEEQUIP)
-- ====================================================

-- REGISTRO: SUPREME AMULET (ID: 31268)
local moveEventEquip = MoveEvent()
function moveEventEquip.onEquip(player, item, slot)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The Supreme Amulet hardens your skin and spirit.")
    return true
end
moveEventEquip:id(31268)
moveEventEquip:slot("necklace")
moveEventEquip:register()

local moveEventDeEquip = MoveEvent()
function moveEventDeEquip.onDeEquip(player, item, slot)
    return true
end
moveEventDeEquip:id(31268)
moveEventDeEquip:slot("necklace")
moveEventDeEquip:register()
