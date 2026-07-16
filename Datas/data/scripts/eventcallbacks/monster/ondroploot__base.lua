local callback = EventCallback("MonsterOnDropLootBaseEvent")

function Player:canReceiveLoot()
          return self:getStamina() > 840
end

function callback.monsterOnDropLoot(monster, corpse)
          local player = Player(corpse:getCorpseOwner())
          local factor = 1.0
          local msgSuffix = ""
          
          if player and player:canReceiveLoot() then
                    local config = player:calculateLootFactor(monster)
                    factor = config.factor
                    msgSuffix = config.msgSuffix

                    -- ====================================================
                    -- SISTEMA DE MULTIPLICAÇÃO DA RELÍQUIA DE LOOT (10X)
                    -- ====================================================
                    local STORAGE_TIME = 859603
                    local STORAGE_ACTIVE = 859604

                    if player:getStorageValue(STORAGE_ACTIVE) == 1 and player:getStorageValue(STORAGE_TIME) > os.time() then
                              factor = factor * 10 -- Multiplica o fator de drop atual por 10
                    end
                    -- ====================================================
          end

          local mType = monster:getType()
          if not mType then
                    logger.warn("monsterOnDropLoot: monster '{}' has no type", monster:getName())
                    return
          end

          local charm = player and player:getCharmMonsterType(CHARM_GUT)
          local gut = charm and charm:raceId() == mType:raceId()

          local lootTable = mType:generateLootRoll({ factor = factor, gut = gut }, {}, player)
          corpse:addLoot(lootTable)
          for _, item in ipairs(lootTable) do
                    if item.gut then
                              msgSuffix = msgSuffix .. " (active charm bonus)"
                    end
          end
          local existingSuffix = corpse:getAttribute(ITEM_ATTRIBUTE_LOOTMESSAGE_SUFFIX) or ""
          corpse:setAttribute(ITEM_ATTRIBUTE_LOOTMESSAGE_SUFFIX, existingSuffix .. msgSuffix)
end

callback:register()