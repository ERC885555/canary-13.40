local portalDays = {
    [1] = true,  -- Sunday
    [2] = false, -- Monday
    [3] = false, -- Tuesday
    [4] = true,  -- Wednesday
    [5] = false, -- Thursday
    [6] = true,  -- Friday
    [7] = true   -- Saturday
}

local portalHour = 20   -- 20:15 server time
local portalMinute = 15
local portalPositions = {
    Position(32341, 32220, 7),
    Position(32365, 32239, 7)
}
local portalId = 25049 -- Example: magic portal item id

local portalDestination = Position(1020, 983, 7)

local portalActionId = 45000 -- Unique action id for the portal

local spawnedPortals = {}

local function spawnPortal()
    for i, pos in ipairs(portalPositions) do
        if not Tile(pos):getItemById(portalId) then
            local portal = Game.createItem(portalId, 1, pos)
            portal:setActionId(portalActionId)
            spawnedPortals[i] = portal
        end
    end
    Game.broadcastMessage("A mysterious portal has appeared!", MESSAGE_EVENT_ADVANCE)
end

local function removePortal()
    for i, pos in ipairs(portalPositions) do
        local tile = Tile(pos)
        if tile then
            local portal = tile:getItemById(portalId)
            if portal then
                portal:remove()
                spawnedPortals[i] = nil
            end
        end
    end
    Game.broadcastMessage("The mysterious portal vanishes!", MESSAGE_EVENT_ADVANCE)
end

local startEvent = GlobalEvent("BossEventPortal")

function startEvent.onTime(interval)
    local now = os.date("*t")
    if portalDays[now.wday] and now.hour == portalHour and now.min == portalMinute then
        spawnPortal()
        addEvent(removePortal, 60 * 60 * 1000) -- Remove after 1 hour
    end
    return true
end

startEvent:interval(60000)
startEvent:register()

-- Talkaction for gods to open the portal manually
local bossPortalTalk = TalkAction("/bossportal")
function bossPortalTalk.onSay(player, words, param)
    if player:getGroup():getId() >= 6 then -- 6 is typically "god" group
        spawnPortal()
        addEvent(removePortal, 60 * 60 * 1000)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have opened the boss event portal.")
    else
        player:sendCancelMessage("You do not have permission to use this command.")
    end
    return false
end
bossPortalTalk:groupType("god")
bossPortalTalk:register()

-- Portal onStepIn event
local portalStep = MoveEvent()
portalStep:type("stepin")
portalStep:aid(portalActionId)
function portalStep.onStepIn(creature, item, position, fromPosition)
    if creature:isPlayer() then
        creature:teleportTo(portalDestination)
        creature:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    end
    return true
end
portalStep:register()