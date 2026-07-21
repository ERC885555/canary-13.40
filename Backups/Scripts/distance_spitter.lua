-- ====================================================
-- DEFINIÇÃO DAS CONFIGURAÇÕES DE SKILLS (CONDITIONS)
-- ====================================================

-- Distance Spitter (+70 Holy ML / Distance)
local distanceCondition = Condition(CONDITION_ATTRIBUTES)
distanceCondition:setParameter(CONDITION_PARAM_TICKS, -1)
distanceCondition:setParameter(CONDITION_PARAM_SKILL_DISTANCE, 70)

-- ====================================================
-- EVENTOS DE MOVIMENTO (EQUIP / DEEQUIP)
-- ====================================================

-- REGISTRO: DISTANCE SPITTER (ID: 9215)
local moveDistEquip = MoveEvent()
function moveDistEquip.onEquip(player, item, slot)
    if not player:getCondition(CONDITION_ATTRIBUTES) then
        player:addCondition(distanceCondition)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The Distance Spitter sharpens your precision and holy power.")
    end
    return true
end
moveDistEquip:id(9215)
moveDistEquip:slot("ammo")
moveDistEquip:register()

local moveDistDeEquip = MoveEvent()
function moveDistDeEquip.onDeEquip(player, item, slot)
    player:removeCondition(CONDITION_ATTRIBUTES)
    return true
end
moveDistDeEquip:id(9215)
moveDistDeEquip:slot("ammo")
moveDistDeEquip:register()