local relicCondition = Condition(CONDITION_ATTRIBUTES)
relicCondition:setParameter(CONDITION_PARAM_TICKS, -1)
relicCondition:setParameter(CONDITION_PARAM_SKILL_SWORD, 70)
relicCondition:setParameter(CONDITION_PARAM_SKILL_AXE, 70)
relicCondition:setParameter(CONDITION_PARAM_SKILL_CLUB, 70)
relicCondition:setParameter(CONDITION_PARAM_SKILL_DISTANCE, 70)
relicCondition:setParameter(CONDITION_PARAM_SKILL_SHIELD, 70)
relicCondition:setParameter(CONDITION_PARAM_STAT_MAGICPOINTS, 10)

local speedCondition = Condition(CONDITION_HASTE)
speedCondition:setParameter(CONDITION_PARAM_TICKS, -1)
speedCondition:setParameter(CONDITION_PARAM_SPEED, 500)

local moveEventEquip = MoveEvent()

function moveEventEquip.onEquip(player, item, slot)
    if not player:getCondition(CONDITION_ATTRIBUTES) then
        player:addCondition(relicCondition)
        player:addCondition(speedCondition)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The Epic Relic skills and speed have been activated.")
    end
    return true
end

moveEventEquip:id(26189)
moveEventEquip:slot("ring")
moveEventEquip:register()

local moveEventDeEquip = MoveEvent()

function moveEventDeEquip.onDeEquip(player, item, slot)
    if player:getCondition(CONDITION_ATTRIBUTES) then
        player:removeCondition(CONDITION_ATTRIBUTES)
        player:removeCondition(CONDITION_HASTE)
    end
    return true
end

moveEventDeEquip:id(26189)
moveEventDeEquip:slot("ring")
moveEventDeEquip:register()
