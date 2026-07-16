local allBosses = {
    -- Add as many bosses as you want here, with unique names and positions
    { bossName = "Drume", spawnPos = Position(1028, 983, 7), msg = "Drume is here!" },
    { bossName = "Demodras", spawnPos = Position(1028, 983, 7), msg = "Demodras spreads its wings!" },
    { bossName = "Orshabaal", spawnPos = Position(1028, 983, 7), msg = "Orshabaal is here!" },
    { bossName = "The Pale Count", spawnPos = Position(1028, 983, 7), msg = "The Pale Count rises from his crypt!" },
    { bossName = "Razzagorn", spawnPos = Position(1028, 983, 7), msg = "Razzagorn brings fire and fury!" },
    { bossName = "Zulazza the Corruptor", spawnPos = Position(1028, 983, 7), msg = "Zulazza the Corruptor corrupts the land!" },
    { bossName = "Tanjis", spawnPos = Position(1028, 983, 7), msg = "Tanjis storms the battlefield!" },
    { bossName = "The Imperor", spawnPos = Position(1028, 983, 7), msg = "The Imperor commands his minions!" },
    { bossName = "Ferumbras Mortal Shell", spawnPos = Position(1028, 983, 7), msg = "Ferumbras Mortal Shell emerges from Soul War!" },
    { bossName = "Magma Bubble", spawnPos = Position(1028, 983, 7), msg = "Magma Bubble erupts from the depths of Soul War!" },
    { bossName = "The Noxious Spawn", spawnPos = Position(1028, 983, 7), msg = "The Noxious Spawn poisons the air!" },
    { bossName = "The Welter", spawnPos = Position(1028, 983, 7), msg = "The Welter shakes the ground!" },
    { bossName = "Goshnar's Malice", spawnPos = Position(1028, 983, 7), msg = "Goshnar's Malice is here!!" },
    { bossName = "Goshnar's Greed", spawnPos = Position(1028, 983, 7), msg = "Goshnar's Greed shakes the ground!" },
    { bossName = "Goshnar's Spite", spawnPos = Position(1028, 983, 7), msg = "Goshnar's Spite shakes the ground!" },
    { bossName = "Goshnar's Hatred", spawnPos = Position(1028, 983, 7), msg = "The Welter shakes the ground!" },
    { bossName = "Murcion", spawnPos = Position(1028, 983, 7), msg = "Murcion shakes the ground!" },
    { bossName = "Chagorz", spawnPos = Position(1028, 983, 7), msg = "Chagorz shakes the ground!" },
    { bossName = "Chikhaton", spawnPos = Position(1028, 983, 7), msg = "Chikhaton emerges from the sands!" },
    { bossName = "Gaffir", spawnPos = Position(1028, 983, 7), msg = "Gaffir slithers into the world!" },
    { bossName = "Sugar Daddy", spawnPos = Position(1028, 983, 7), msg = "Sugar Daddy craves sweets... and souls!" },
    { bossName = "Lord Azaram", spawnPos = Position(1028, 983, 7), msg = "Lord Azaram commands the undead!" },
    { bossName = "Zushuka", spawnPos = Position(1028, 983, 7), msg = "Zushuka brings a chilling presence!" },
    { bossName = "Bakragore", spawnPos = Position(1028, 983, 7), msg = "Bakragore roars with fury!" },
    { bossName = "Bullwark", spawnPos = Position(1028, 983, 7), msg = "Bullwark charges into the fray!" },
    { bossName = "Bazir", spawnPos = Position(1028, 983, 7), msg = "Bazir, one of the Ruthless Seven, appears!" },
    { bossName = "Mitmah Vanguard", spawnPos = Position(1028, 983, 7), msg = "Mitmah Vanguard leads the charge!" },
    { bossName = "Grand Chaplain Gaunder", spawnPos = Position(1028, 983, 7), msg = "Grand Chaplain Gaunder preaches doom!" },
    { bossName = "Zarabustor", spawnPos = Position(1028, 983, 7), msg = "Zarabustor unleashes his magic!" },
    { bossName = "Zavarash", spawnPos = Position(1028, 983, 7), msg = "Zavarash brings darkness!" },
    { bossName = "Chagorz", spawnPos = Position(1028, 983, 7), msg = "Chagorz brings the light... that drains!" },
    { bossName = "Grand Canon Dominus", spawnPos = Position(1028, 983, 7), msg = "Grand Canon Dominus judges all!" }
}

local eventHour = 20 -- 20:30
local eventMinute = 30
local bossesPerDay = 7

-- Set the days you want the event to run: 1=Sunday, 4=Wednesday, 6=Friday, 7=Saturday
local eventDays = {
    [1] = true, -- Sunday
    [2] = true, --Monday
    [3] = true, -- Tuesday
    [4] = true, -- Wednesday
    [5] = true, -- Thursday
    [6] = true, -- Friday
    [7] = true  -- Saturday
}

local spawnedBossIndex = {}
local todayBosses = {}

local function getRandomBosses(n)
    local pool = {}
    for i, boss in ipairs(allBosses) do
        pool[i] = boss
    end
    local result = {}
    for i = 1, n do
        if #pool == 0 then break end
        local idx = math.random(1, #pool)
        table.insert(result, pool[idx])
        table.remove(pool, idx)
    end
    return result
end

local function spawnBossForDay(day)
    local bosses = todayBosses[day]
    if not bosses then return end
    local idx = spawnedBossIndex[day] or 1
    local boss = bosses[idx]
    if boss then
        local monster = Game.createMonster(boss.bossName, boss.spawnPos)
        if monster then
            Game.broadcastMessage(boss.msg, MESSAGE_EVENT_ADVANCE)
            spawnedBossIndex[day] = idx
            monster:registerEvent("BossChainDeath")
        end
    end
end

local bossEvent = GlobalEvent("BossEventAuto")
function bossEvent.onTime(interval)
    local now = os.date("*t")
    if eventDays[now.wday] and now.hour == eventHour and now.min == eventMinute and not spawnedBossIndex[now.wday] then
        todayBosses[now.wday] = getRandomBosses(bossesPerDay)
        spawnedBossIndex[now.wday] = 1
        spawnBossForDay(now.wday)
    end
    return true
end
bossEvent:interval(60000)
bossEvent:register()

-- CreatureEvent for boss death chain
local bossChainDeath = CreatureEvent("BossChainDeath")
function bossChainDeath.onDeath(monster, corpse, killer, mostDamage, unjustified, mostDamage_unjustified)
    for day, bosses in pairs(todayBosses) do
        local idx = spawnedBossIndex[day]
        if idx and bosses[idx] and bosses[idx].bossName == monster:getName() then
            spawnedBossIndex[day] = idx + 1
            local nextBoss = bosses[idx + 1]
            if nextBoss then
                addEvent(function()
                    local m = Game.createMonster(nextBoss.bossName, nextBoss.spawnPos)
                    if m then
                        Game.broadcastMessage(nextBoss.msg, MESSAGE_EVENT_ADVANCE)
                        m:registerEvent("BossChainDeath")
                    end
                end, 5000) -- 5 seconds delay before next boss spawns
            else
                spawnedBossIndex[day] = nil -- reset for next week
                todayBosses[day] = nil
            end
            break
        end
    end
    return true
end
bossChainDeath:register()

-- Talkaction for gods to start the boss event manually
local bossEventTalk = TalkAction("/bossevent")
function bossEventTalk.onSay(player, words, param)
    if player:getGroup():getId() >= 6 then -- 6 is typically "god" group
        local now = os.date("*t")
        local wday = now.wday
        todayBosses[wday] = getRandomBosses(bossesPerDay)
        spawnedBossIndex[wday] = 1
        spawnBossForDay(wday)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have started the boss event for today.")
    else
        player:sendCancelMessage("You do not have permission to use this command.")
    end
    return false
end
bossEventTalk:groupType("god")
bossEventTalk:register()