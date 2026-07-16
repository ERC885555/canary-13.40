local recallAction = Action()

function recallAction.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    -- Trava para não fugir da morte no meio da hunt (PZ/Combat lock)
    if player:getCondition(CONDITION_INFIGHT) then
        player:sendTextMessage(MESSAGE_STATUS_SMALL, "You cannot use this relic while in combat.")
        fromPosition:sendMagicEffect(EFFECT_POFF)
        return true
    end

    -- Puxa o local do templo da cidade natal do jogador
    local town = player:getTown()
    if not town then
        player:sendTextMessage(MESSAGE_STATUS_SMALL, "Your home town temple could not be found.")
        return true
    end

    -- Corrigido de getTemplatePosition para getTemplePosition (Sintaxe oficial Canary 3.x)
    local templePosition = town:getTemplePosition()

    -- Executa o teleporte e solta os efeitos visuais
    fromPosition:sendMagicEffect(EFFECT_TELEPORT)
    player:teleportTo(templePosition)
    templePosition:sendMagicEffect(EFFECT_TELEPORT)
    
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The Relic of Recall safely returns you to your home temple.")
    return true
end

recallAction:id(9144)
recallAction:register()
