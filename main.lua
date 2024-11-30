local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "LIGMA HUB",
    Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
    LoadingTitle = "LIGMA HUB",
    LoadingSubtitle = "by dxmnlxrd_",
    Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes
    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

    ConfigurationSaving = {
       Enabled = true,
       FolderName = nil, -- Create a custom folder for your hub/game
       FileName = "Big Hub"
    },

    Discord = {
       Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
       Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
       RememberJoins = true -- Set this to false to make them join the discord every time they load it up
    },

    KeySystem = false, -- Set this to true to use our key system
    KeySettings = {
       Title = "Untitled",
       Subtitle = "Key System",
       Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
       FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
       SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
       GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
       Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
    }
})

local KIMTab = Window:CreateTab("Kim jong un", 4483362458) -- Title, Image

-- Button 1
KIMTab:CreateButton({
    Name = "Invisible (Click E)",
    Callback = function()
        loadstring(game:HttpGet("https://scriptblox.com/raw/Universal-Script-fe-invisible-4366"))()  
        print("Invisible script enabled")
    end
})

-- Button 2
KIMTab:CreateButton({
    Name = "Inf Yield",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
        print("Yield enabled")
    end
})

-- Button 3
KIMTab:CreateButton({
    Name = "Banging (Buggy)",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/4gh9/Bang-Script-Gui/main/bang%20gui.lua"))()
        print("Bang enabled")
    end
})

-- Slider 1: Walkspeed
local WalkspeedSlider = KIMTab:CreateSlider({
    Name = "Walkspeed",
    Range = {0, 500},
    Increment = 10,
    Suffix = " WalkSpeed", -- Adds a space before the suffix for better formatting
    CurrentValue = 10,
    Flag = "WalkspeedSlider", -- Unique identifier
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        if player and player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = Value
        end
    end
})

-- Slider 2: Jumppower
local JumpPowerSlider = KIMTab:CreateSlider({
    Name = "Jump power",
    Range = {0, 500},
    Increment = 10,
    Suffix = " JumpPower",
    CurrentValue = 10,
    Flag = "JumpPowerSlider", -- Unique identifier
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        if player and player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.JumpPower = Value
        end
    end
})
