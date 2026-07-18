-- ====================================================
-- DEFINIÇÃO DAS CONFIGURAÇÕES DE SKILLS (CONDITIONS)
-- ====================================================

-- Berserker Spitter (+70 Melee Skills)
local berserkerCondition = Condition(CONDITION_ATTRIBUTES)
berserkerCondition:setParameter(CONDITION_PARAM_TICKS, -1)
berserkerCondition:setParameter(CONDITION_PARAM_SKILL_SWORD, 70)
berserkerCondition:setParameter(CONDITION_PARAM_SKILL_AXE, 70)
berserkerCondition:setParameter(CONDITION_PARAM_SKILL_CLUB, 70)

-- ====================================================
-- EVENTOS DE MOVIMENTO (EQUIP / DEEQUIP)
-- ====================================================

-- REGISTRO: BERSERKER SPITTER (ID: 9216)
local moveBerEquip = MoveEvent()
function moveBerEquip.onEquip(player, item, slot)
    if not player:getCondition(CONDITION_ATTRIBUTES) then
        player:addCondition(berserkerCondition)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The Berserker Spitter ignites your melee fury.")
    end
    return true
end
moveBerEquip:id("9216")
moveBerEquip:slot("ammo")
moveBerEquip:register()

local moveBerDeEquip = MoveEvent()
function moveBerDeEquip.onDeEquip(player, item, slot)
    player:removeCondition(CONDITION_ATTRIBUTES)
    return true
end
moveBerDeEquip:id("9216")
moveBerDeEquip:slot("ammo")
moveBerDeEquip:register()