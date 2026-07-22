local xpAction = Action()

-- Configurações da Relíquia
local XP_MULTIPLIER = 1000000 -- 1000000% representa 10000x XP
local BOOST_DURATION = 2 * 60 * 60 -- Tempo de duração: 2 horas (em segundos)
local STORAGE_TIME = 859601 -- Storage que guarda quando o buff vai acabar
local STORAGE_ACTIVE = 859602 -- Storage que diz se o buff está ligado

function xpAction.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    -- Verifica se o personagem já está com o super boost ativo para não acumular infinito
    if player:getStorageValue(STORAGE_ACTIVE) == 1 and player:getStorageValue(STORAGE_TIME) > os.time() then
        local timeLeft = player:getStorageValue(STORAGE_TIME) - os.time()
        local minutesLeft = math.ceil(timeLeft / 60)
        player:sendTextMessage(MESSAGE_STATUS_SMALL, "You already have an active experience boost! It will expire in " .. minutesLeft .. " minutes.")
        fromPosition:sendMagicEffect(EFFECT_POFF)
        return true
    end

    -- Calcula o momento exato em que o buff vai terminar (Hora atual + 2 horas)
    local endTime = os.time() + BOOST_DURATION

    -- Grava os dados na memória do personagem
    player:setStorageValue(STORAGE_TIME, endTime)
    player:setStorageValue(STORAGE_ACTIVE, 1)

    -- Injeta o ganho de 10x XP direto na engine do Canary
    player:setBaseXpGain(XP_MULTIPLIER)

    -- Mensagem verde de impacto na tela e efeitos mágicos sagrados
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The Relic of Infinite Wisdom has been unleashed! You now have 10000x Experience for the next 2 hours.")
    player:getPosition():sendMagicEffect(EFFECT_HOLY)
    
    -- Como é uma relíquia eterna e não um consumível, NÃO colocamos a linha de remover o item! 
    -- Você guarda ele na bolsa e pode usar de novo daqui a 2 horas.
    return true
end

xpAction:id(9219)
xpAction:register()

-- ====================================================
-- SISTEMA ANTIBUG: MANTÉM O BUFF SE O PLAYER LOGAR/DESLOGAR
-- ====================================================
local loginEvent = CreatureEvent("XpRelicCheckOnLogin")

function loginEvent.onLogin(player)
    -- Se o personagem logar e ainda estiver dentro do tempo do buff, reativa os 10x de XP
    if player:getStorageValue(STORAGE_ACTIVE) == 1 then
        if player:getStorageValue(STORAGE_TIME) > os.time() then
            player:setBaseXpGain(XP_MULTIPLIER)
            local timeLeft = player:getStorageValue(STORAGE_TIME) - os.time()
            local minutesLeft = math.ceil(timeLeft / 60)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your 10x Experience boost is still active! Remaining time: " .. minutesLeft .. " minutes.")
        else
            -- Se o tempo acabou enquanto ele estava deslogado, reseta o boneco
            player:setBaseXpGain(100)
            player:setStorageValue(STORAGE_ACTIVE, -1)
        end
    end
    return true
end

loginEvent:register()