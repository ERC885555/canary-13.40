local lootAction = Action()

-- Configurações da Relíquia
local BOOST_DURATION = 2 * 60 * 60 -- Tempo de duração: 2 horas (em segundos)
local STORAGE_TIME = 859603 -- Storage que guarda quando o buff vai acabar
local STORAGE_ACTIVE = 859604 -- Storage que diz se o buff está ligado

function lootAction.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    -- Verifica se o personagem já está com o super boost ativo
    if player:getStorageValue(STORAGE_ACTIVE) == 1 and player:getStorageValue(STORAGE_TIME) > os.time() then
        local timeLeft = player:getStorageValue(STORAGE_TIME) - os.time()
        local minutesLeft = math.ceil(timeLeft / 60)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You already have an active loot boost! It will expire in " .. minutesLeft .. " minutes.")
        fromPosition:sendMagicEffect(CONST_ME_POFF)
        return true
    end

    -- Calcula o momento exato em que o buff vai terminar
    local endTime = os.time() + BOOST_DURATION

    -- Grava os dados na memória do personagem
    player:setStorageValue(STORAGE_TIME, endTime)
    player:setStorageValue(STORAGE_ACTIVE, 1)

    -- Mensagem e efeito visual
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The Relic of Abundant Fortune has been unleashed! You now have 10x Loot Rate for the next 2 hours.")
    player:getPosition():sendMagicEffect(CONST_ME_GREEN_RINGS)
    
    return true
end

lootAction:id(14143)
lootAction:register()

-- ====================================================
-- SISTEMA ANTIBUG: MANTÉM O BUFF SE O PLAYER LOGAR/DESLOGAR
-- ====================================================
local loginEvent = CreatureEvent("LootRelicCheckOnLogin")

function loginEvent.onLogin(player)
    if player:getStorageValue(STORAGE_ACTIVE) == 1 then
        if player:getStorageValue(STORAGE_TIME) > os.time() then
            local timeLeft = player:getStorageValue(STORAGE_TIME) - os.time()
            local minutesLeft = math.ceil(timeLeft / 60)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your 10x Loot boost is still active! Remaining time: " .. minutesLeft .. " minutes.")
        else
            -- Se o tempo acabou offline, desativa
            player:setStorageValue(STORAGE_ACTIVE, -1)
        end
    end
    return true
end

loginEvent:register()