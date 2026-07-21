-- ====================================================
-- DEFINIÇÃO DAS CONFIGURAÇÕES DE SKILLS (CONDITIONS)
-- ====================================================

-- Final Fate (+20 Shielding, +120 ML & Speed 1000)
local fateCondition = Condition(CONDITION_ATTRIBUTES)
fateCondition:setParameter(CONDITION_PARAM_TICKS, -1)
fateCondition:setParameter(CONDITION_PARAM_SKILL_SHIELD, 20)
fateCondition:setParameter(CONDITION_PARAM_STAT_MAGICPOINTS, 120)

local fateSpeed = Condition(CONDITION_HASTE)
fateSpeed:setParameter(CONDITION_PARAM_TICKS, -1)
fateSpeed:setParameter(CONDITION_PARAM_SPEED, 1000)

-- ====================================================
-- EVENTOS DE MOVIMENTO (EQUIP / DEEQUIP)
-- ====================================================

-- REGISTRO: FINAL FATE (ID: 37335)
local moveFateEquip = MoveEvent()
function moveFateEquip.onEquip(player, item, slot)
    if not player:getCondition(CONDITION_ATTRIBUTES) then
        player:addCondition(fateCondition)
        player:addCondition(fateSpeed)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have triggered the Final Fate.")
    end
    return true
end
moveFateEquip:id("37335")
moveFateEquip:slot("ammo")
moveFateEquip:register()

local moveFateDeEquip = MoveEvent()
function moveFateDeEquip.onDeEquip(player, item, slot)
    player:removeCondition(CONDITION_ATTRIBUTES)
    player:removeCondition(CONDITION_HASTE)
    return true
end
moveFateDeEquip:id("37335")
moveFateDeEquip:slot("ammo")
moveFateDeEquip:register()
