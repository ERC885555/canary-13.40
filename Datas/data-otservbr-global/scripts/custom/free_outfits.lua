-- local loginEvent = CreatureEvent("FreeOutfitsOnLogin")

-- function loginEvent.onLogin(player)
    -- O 'player' aqui já representa automaticamente quem está logando (Czar ou qualquer outro)
    -- Removemos a trava de storage para garantir que ele processe todos os seus personagens agora
    
    -- Loop largo para pegar absolutamente todas as outfits e addons
    -- for i = 1, 2000 do
   -- for i = 1, 2 do
    --    player:addOutfitAddon(i, 3)
    --end
    
    -- Opcional: Descomente a linha abaixo se quiser liberar todas as montarias também
    -- for m = 1, 500 do player:addMount(m) end
    --for m = 1, 2 do player:addMount(m) end

    --player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Hello, ".. player:getName() .."! Your outfits and addons was updated.")
    --return true
--end

--loginEvent:register()
