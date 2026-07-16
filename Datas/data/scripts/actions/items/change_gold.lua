-- Adicionamos a Tibianum Coin (37317) conectada à Crystal Coin (3043)
local config = {
	[3031] = { changeTo = 3035 }, -- Gold Coin vira Platinum
	[3035] = { changeBack = 3031, changeTo = 3043 }, -- Platinum vira Gold ou Crystal
	[3043] = { changeBack = 3035, changeTo = 37317 }, -- Crystal vira Platinum ou Tibianum Coin (Novo!)
	[37317] = { changeBack = 3043 }, -- Tibianum Coin vira Crystal (Novo!)
}

local changeGold = Action()

function changeGold.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local coin = config[item:getId()]
	if not coin then
		return false
	end
	
	-- Se tiver 100 moedas e clicar, transforma na moeda superior
	if coin.changeTo and item.type == 100 then
		item:remove()
		player:addItem(coin.changeTo, 1)
		fromPosition:sendMagicEffect(EFFECT_LOOT_GOLD) -- Efeito visual oficial de moedas
		return true
	-- Se clicar em 1 moeda superior, ela se desmancha em 100 moedas inferiores
	elseif coin.changeBack and item.type < 100 then
		item:remove(1)
		player:addItem(coin.changeBack, 100)
		fromPosition:sendMagicEffect(EFFECT_LOOT_GOLD)
		return true
	end
	return false
end

-- Registramos todos os IDs que participam da brincadeira, incluindo a sua moeda 37317
changeGold:id(3031, 3035, 3043, 37317)
changeGold:register()
