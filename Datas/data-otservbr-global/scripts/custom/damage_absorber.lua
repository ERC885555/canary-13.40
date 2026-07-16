-- ====================================================
-- DEFINIÇÃO DAS CONFIGURAÇÕES DE SKILLS (CONDITIONS)
-- ====================================================

-- Damage Absorber (+200 Shielding & Speed 500)
local absorberCondition = Condition(CONDITION_ATTRIBUTES)
absorberCondition:setParameter(CONDITION_PARAM_TICKS, -1)
absorberCondition:setParameter(CONDITION_PARAM_SKILL_SHIELD, 200)

local absorberSpeed = Condition(CONDITION_HASTE)
absorberSpeed:setParameter(CONDITION_PARAM_TICKS, -1)
absorberSpeed:setParameter(CONDITION_PARAM_SPEED, 500)

-- ====================================================
-- EVENTOS DE MOVIMENTO (EQUIP / DEEQUIP)
-- ====================================================

-- REGISTRO: DAMAGE ABSORBER (ID: 30058)
local moveAbsEquip = MoveEvent()
function moveAbsEquip.onEquip(player, item, slot)
    if not player:getCondition(CONDITION_ATTRIBUTES) then
        player:addCondition(absorberCondition)
        player:addCondition(absorberSpeed)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The Damage Absorber fortifies your absolute defense.")
    end
    return true
end
moveAbsEquip:id("30058")
moveAbsEquip:slot("ammo")
moveAbsEquip:register()

local moveAbsDeEquip = MoveEvent()
function moveAbsDeEquip.onDeEquip(player, item, slot)
    player:removeCondition(CONDITION_ATTRIBUTES)
    player:removeCondition(CONDITION_HASTE)
    return true
end
moveAbsDeEquip:id("30058")
moveAbsDeEquip:slot("ammo")
moveAbsDeEquip:register()