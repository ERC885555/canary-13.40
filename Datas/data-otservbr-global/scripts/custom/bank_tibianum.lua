-- 1. SOMA O DINHEIRO DO INVENTÁRIO (Para o comando "deposit all" ler a moeda)
local oldGetMoney = Player.getMoney
function Player.getMoney(self)
    local money = oldGetMoney(self)
    money = money + (self:getItemCount(37317) * 1000000) -- Cada Tibianum Coin vale 1kk
    return money
end

-- 2. GERENCIA O DEPÓSITO (Remove as moedas físicas e põe o saldo real no banco)
local oldDepositMoney = Player.depositMoney
function Player.depositMoney(self, amount)
    local currentGold = oldGetMoney(self)
    local tibianumCoins = self:getItemCount(37317)
    local totalWallet = currentGold + (tibianumCoins * 1000000)

    if amount > totalWallet then
        return false -- Não tem dinheiro suficiente somando tudo
    end

    -- Se o depósito for menor ou igual ao gold normal, usa a função padrão
    if amount <= currentGold then
        return oldDepositMoney(self, amount)
    end

    -- Se precisar queimar Tibianum Coins no depósito:
    local neededFromTibianum = amount - currentGold
    local tibianumToDestroy = math.ceil(neededFromTibianum / 1000000)

    -- Remove o gold normal e as moedas com "T"
    if currentGold > 0 then
        oldDepositMoney(self, currentGold)
    end
    self:removeItem(37317, tibianumToDestroy)

    -- Calcula o troco se a moeda de 1kk cobriu mais do que o valor do depósito
    local change = (tibianumToDestroy * 1000000) - neededFromTibianum
    if change > 0 then
        self:addItem(3043, math.floor(change / 10000)) -- Devolve o troco em Crystal Coins na bolsa
    end

    -- Injeta o saldo total direto na conta bancária do jogador
    self:setBankBalance(self:getBankBalance() + amount)
    return true
end

-- 3. GERENCIA O SAQUE (Se você sacar mais de 1kk, o NPC te entrega a Tibianum Coin física)
local oldWithdrawMoney = Player.withdrawMoney
function Player.withdrawMoney(self, amount)
    if self:getBankBalance() < amount then
        return false
    end

    -- Desconta o saldo do banco do jogador
    self:setBankBalance(self:getBankBalance() - amount)

    -- Calcula quantas Tibianum Coins entregar (Acima de 1kk)
    local tibianumToGive = math.floor(amount / 1000000)
    local remainingGold = amount % 1000000

    -- Entrega as moedas com "T"
    if tibianumToGive > 0 then
        self:addItem(37317, tibianumToGive)
    end

    -- Entrega o restante em gold normal usando a função nativa da engine
    if remainingGold > 0 then
        self:addMoney(remainingGold)
    end

    return true
end
