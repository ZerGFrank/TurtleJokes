-- TurtleJokes v1.0
-- A simple addon to send turtle-themed jokes in World of Warcraft: Turtle WoW.

--------------------------------------------------------------------
-- 1. Banner & RNG seed
local banner = "TurtleJokes loaded – /tjoke for a laugh"
local seedFrame = CreateFrame("Frame")
seedFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
seedFrame:SetScript("OnEvent", function()
    DEFAULT_CHAT_FRAME:AddMessage(banner)
    math.randomseed(GetTime() * 1000)
    seedFrame:UnregisterAllEvents()
end)

--------------------------------------------------------------------
-- 2. Joke list
local jokes = {
    "Why is Turtle WoW's economy stable? Because turtles never inflate their shells!",
    "My mount isn't slow—it's tactically advancing at turtle speed.",
    "Why did the turtle mage spec frost? Because slow is a turtle's favorite crowd control!",
    "Why do turtles love fishing? It's the only skill they can level quickly!",
    "I rolled a rogue on Turtle WoW. My ambush takes three hours!",
    "Why don't turtles raid Naxxramas? They're still on their way to Stratholme.",
    "How do Turtle WoW warriors charge? They politely crawl forward.",
    "Why is Thunder Bluff popular with turtles? Lots of grass and no rush.",
    "Why did the turtle avoid PvP? He didn't want to shell out repair gold.",
    "My turtle alt dinged 60—people cheered because he started at launch.",
    "Why did the turtle player AFK mid-raid? Snack breaks every boss pull.",
    "What did the turtle priest say? Slow heals are good heals.",
    "Why do turtles love dungeons? Short distances between naps.",
    "Turtle WoW druids shapeshift into even slower turtles.",
    "Why don't turtles farm gold efficiently? Too much stopping to sunbathe.",
    "What's a turtle's favorite addon? Slow-scrolling combat text.",
    "How did the turtle rogue vanish? He slowly ducked into his shell.",
    "Why is the turtle's backpack always full? Snacks for slow journeys.",
    "Turtle battleground queues: Instant pops—two days later.",
    "Why did the turtle fail DPS checks? Waiting for cooldowns takes forever.",
    "Turtle hunters tame snails for a compatible pace.",
    "Why did the turtle roll paladin? Bubble hearth matches their normal speed.",
    "What's the turtle guild motto? We're going places—eventually!",
    "Why is fishing mandatory for turtles? It's fast-paced action for them.",
    "Turtle WoW mages casting Pyroblast: still charging since last year.",
    "Why do turtles never go OOM? Mana regenerates faster than they move.",
    "Turtle's favorite raid boss? Baron Geddon—he's patient too.",
    "Why can't turtles play rogues? Stealth doesn't work at 1 mph.",
    "Turtle WoW flight paths guarantee at least two naps.",
    "Why do turtles love Alterac Valley? Matches last days—just like their raids.",
    "How do turtles deal with gankers? Wait until they log off from boredom.",
    "What's a turtle's favorite potion? Flask of Endless Patience.",
    "Why did the turtle fail fishing? Even the fish got bored waiting.",
    "Turtle leveling guide: Level 60 by 2027—guaranteed!",
    "Why do turtles tank bosses at max range? That's where they stopped walking.",
    "What's the turtle's favorite profession? Herbalism—flowers don't run away.",
    "Why can't turtles raid AQ40? The doors closed before they arrived.",
    "Turtle WoW druids never leave bear form—they're too tired to switch back.",
    "Why do turtle guild banks overflow? They never vendor junk, and auctioning is too slow.",
    "Why is Thunderfury the best turtle weapon? Its slower swing matches their pace.",
    "How does a turtle warrior taunt? 'Hey, boss!' as he slowly waddles closer.",
    "Why don't turtles need mounts? They're already at top turtle speed.",
    "Turtle's favorite class? Shaman—they resonate with Earthbind Totem.",
    "Why are turtle rogues bad at Sap? They're too slow, and targets walk away.",
    "Why do turtles never get lost? It's easy to backtrack slowly.",
    "What's the turtle's favorite battleground? Warsong Crawl.",
    "Why do turtles enjoy Scholomance? Cozy crypts perfect for naps.",
    "Turtle WoW cooking skill: Slow Roasted Everything.",
    "Why do turtles fail at escaping dungeon wipes? They leisurely stroll out.",
    "What's the turtle PvP strategy? Bore the enemy into surrender.",
    "Why are turtle druids always Resto? Slow enough for stacking HoTs.",
    "Why did the turtle player quit PvP? Couldn't handle fast 10-second duels.",
    "Turtle's favorite toy? Tiny walking stick.",
    "Why don't turtles use raid calendars? Appointments stress their pace.",
    "Turtle priest's favorite spell? Renew—slowly refreshed repeatedly.",
    "Why did the turtle fail at herbalism? Plants regrew by the time they harvested.",
    "What's a turtle's favorite quest? Anything without timed objectives.",
    "Why did the turtle choose engineering? Slow Fall matches their pace.",
    "Turtle WoW auction strategy: List items and wait patiently for sales.",
    "Why did the turtle hunter prefer melee pets? Ranged pets outran them.",
    "What's the turtle's favorite instance? Maraudon—long, slow, and scenic.",
    "Why don't turtles visit Booty Bay? Takes too long to climb ramps.",
    "Turtle player's favorite emote: wave—repeatedly.",
    "Why did the turtle fail leatherworking? Tanning hides took months.",
    "Turtle's favorite legendary? Thunderfury—it slows enemies to their pace.",
    "Why do turtles always have rested XP? Logged off halfway to the next quest.",
    "Turtle WoW druids' favorite form? Turtle form—slow, steady, safe.",
    "Why don't turtles use mounts? Walking speed is already mount speed.",
    "Turtle's favorite raid? Molten Snore—guaranteed naps.",
    "Why did the turtle warlock lose duels? DoTs expired before reapplication.",
    "Turtle's favorite holiday? Midsummer—slow, long days.",
    "Turtle WoW players' favorite event? Waiting for quest mob respawns.",
    "Why do turtles prefer classic WoW? Because sprint doesn't exist yet.",
    "Turtle's favorite food? Mage-made slow bread.",
    "Why did the turtle avoid Stranglethorn Vale? Couldn't dodge gankers slowly.",
    "Turtle WoW PvP titles: Rank 1—Slow Sergeant.",
    "What's the turtle's favorite addon? SlowChat—it delays conversations nicely.",
    "Why did the turtle guild disband? They never reached the first guild meeting."
}

local function getJoke()
    return jokes[ math.random( table.getn(jokes) ) ]   -- Lua 5.0-safe
end

--------------------------------------------------------------------
-- 3. Channel aliases
local alias = {
    s="SAY",  say="SAY",
    y="YELL", yell="YELL",
    p="PARTY", party="PARTY",
    g="GUILD", guild="GUILD",
    r="RAID",  raid="RAID",
    o="OFFICER", officer="OFFICER",
    rw="RAID_WARNING", raidwarning="RAID_WARNING",
    bg="BATTLEGROUND"
}

--------------------------------------------------------------------
-- 4. Send helper
local function sendJoke(chatType, target)
    local text = getJoke()
    if chatType == "WHISPER" then
        SendChatMessage(text, "WHISPER", nil, target)
    elseif chatType == "CHANNEL" then
        SendChatMessage(text, "CHANNEL", nil, target) -- target = channel ID
    else
        SendChatMessage(text, chatType)
    end
end

--------------------------------------------------------------------
-- 5. Current chat context (1.12 safe)
local function getDefaultChat()
    local eb = ChatFrameEditBox
    if eb and eb:IsVisible() then
        return eb.chatType, eb.tellTarget, eb.channelTarget
    end
    if GetNumRaidMembers() > 0 then return "RAID" end
    if GetNumPartyMembers() > 0 then return "PARTY" end
    return "SAY"
end

--------------------------------------------------------------------
-- 6. Trim helper
local function trim(str)
    str = string.gsub(str, "^%s+", "")
    str = string.gsub(str, "%s+$", "")
    return str
end

--------------------------------------------------------------------
-- 7. /tjoke handler (Lua 5.0-safe parsing)
local function TJ_Handler(msg)
    msg = trim(msg or "")

    -- a) No argument → current chat box
    if msg == "" then
        local ctype, tell, chan = getDefaultChat()
        if ctype == "WHISPER" then
            sendJoke("WHISPER", tell)
        elseif ctype == "CHANNEL" then
            sendJoke("CHANNEL", chan)
        else
            sendJoke(ctype)
        end
        return
    end

    -- b) Parse first word (cmd) and the rest (target/arg) with string.find
    local space = string.find(msg, " ")
    local cmd, rest
    if space then
        cmd  = string.lower(string.sub(msg, 1, space - 1))
        rest = trim(string.sub(msg, space + 1))
    else
        cmd  = string.lower(msg)
        rest = ""
    end

    -- b-1) whisper / w <name>
    if (cmd == "whisper" or cmd == "w") then
        if rest ~= "" then
            sendJoke("WHISPER", rest)
        else
            DEFAULT_CHAT_FRAME:AddMessage("Usage: /tjoke w <player>")
        end
        return
    end

    -- c) Alias channels (say, p, g, etc.)
    if alias[cmd] then
        sendJoke(alias[cmd])
        return
    end

    -- d) Numbered custom channel (e.g. 3)
    local chanID = tonumber(cmd)
    if chanID and GetChannelName(chanID) then
        sendJoke("CHANNEL", chanID)
        return
    end

    -- e) Usage fallback
    DEFAULT_CHAT_FRAME:AddMessage("Usage: /tjoke [s|y|p|g|r|o|rw|bg|1-9|w <name>|whisper <name>]")
end

--------------------------------------------------------------------
-- 8. Register /tjoke
SLASH_TJOKE1 = "/tjoke"
SlashCmdList.TJOKE = TJ_Handler