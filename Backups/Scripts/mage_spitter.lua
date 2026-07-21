-- ====================================================
-- DEFINIÇÃO DAS CONFIGURAÇÕES DE SKILLS (CONDITIONS)
-- ====================================================

-- Mage Spitter (+70 ML)
local mageCondition = Condition(CONDITION_ATTRIBUTES)
mageCondition:setParameter(CONDITION_PARAM_TICKS, -1)
mageCondition:setParameter(CONDITION_PARAM_STAT_MAGICPOINTS, 70)

-- ====================================================
-- EVENTOS DE MOVIMENTO (EQUIP / DEEQUIP)
-- ====================================================

-- REGISTRO: MAGE SPITTER (ID: 9217)
local moveMageEquip = MoveEvent()
function moveMageEquip.onEquip(player, item, slot)
    if not player:getCondition(CONDITION_ATTRIBUTES) then
        player:addCondition(mageCondition)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The Mage Spitter channels elemental magic.")
    end
    return true
end
moveMageEquip:id("9217")
moveMageEquip:slot("ammo")
moveMageEquip:register()

local moveMageDeEquip = MoveEvent()
function moveMageDeEquip.onDeEquip(player, item, slot)
    player:removeCondition(CONDITION_ATTRIBUTES)
    return true
end
moveMageDeEquip:id("9217")
moveMageDeEquip:slot("ammo")
moveMageDeEquip:register()