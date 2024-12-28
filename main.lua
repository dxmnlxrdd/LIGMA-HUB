local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Ligma hub new ui",
    SubTitle = "dxmnxlrd_,6tears",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when there's no MinimizeKeybind
})

-- Fluent provides Lucide Icons https://lucide.dev/icons/ for the tabs, icons are optional
local Tabs = {
    Kim = Window:AddTab({ Title = "Troll scripts", Icon = "" }),
    Troll = Window:AddTab({ Title = "4kings", Icon = "" }),
    Kim2 = Window:AddTab({ Title = "Kim jong un", Icon = "" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options

do
    Window:SelectTab(1)

    Fluent:Notify({
        Title = "Ligma hub",
        Content = "Executed the script!",
        SubContent = "", -- Optional
        Duration = 5 -- Set to nil to make the notification not disappear
    })

    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local UserInputService = game:GetService("UserInputService")
    local DetectionRadius = 30
    -- Detect R6 or R15
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local isR6 = character:FindFirstChild("Torso") ~= nil

    local function GetDistance(part1, part2)
        return (part1.Position - part2.Position).Magnitude
    end

    local function Humanoid_Remover(Character)
        local Parts = {}

        for _, Descendant in pairs(Character:GetDescendants()) do
            if Descendant:IsA("Humanoid") then
                table.insert(Parts, Descendant)
            end
        end

        for _, Part in ipairs(Parts) do
            if Part and Part.Parent then
                local Success, _ = pcall(function()
                    DeleteCarEvent:FireServer(Part)
                end)
            end
        end
    end

    local function Tool_Remover(Character)
        local Parts = {}

        for _, Descendant in pairs(Character:GetDescendants()) do
            if Descendant:IsA("Tool") then
                table.insert(Parts, Descendant)
            end
        end

        for _, Part in ipairs(Parts) do
            if Part and Part.Parent then
                local Success, _ = pcall(function()
                    DeleteCarEvent:FireServer(Part)
                end)
            end
        end
    end

    local function Kick(Player)
        if not Player then return end

        -- Remove PlayerGui components
        local PlayerGui = Player:FindFirstChild("PlayerGui")
        if PlayerGui then
            for _, GuiObject in pairs(PlayerGui:GetChildren()) do
                local Success, _ = pcall(function()
                    DeleteCarEvent:FireServer(Player, GuiObject)
                end)
            end
        end

        -- Remove Backpack items
        local Backpack = Player:FindFirstChild("Backpack")
        if Backpack then
            for _, Tool in pairs(Backpack:GetChildren()) do
                local Success, _ = pcall(function()
                    DeleteCarEvent:FireServer(Player, Tool)
                end)
            end
        end

        -- Remove Tools in Character
        local Character = Player.Character
        if Character then
            for _, Tool in pairs(Character:GetChildren()) do
                if Tool:IsA("Tool") or Tool:IsA("Humanoid") then
                    local Success, _ = pcall(function()
                        DeleteCarEvent:FireServer(Player, Tool)
                    end)
                end
            end
        end
    end

    function Game_Remove()
        for _, object in pairs(game.Workspace:GetDescendants()) do
            local Success ,_ = pcall(function()
                game:GetService("ReplicatedStorage"):WaitForChild("DeleteCar"):FireServer(object)
            end)
        end
        for _, players in pairs(game.Players:GetPlayers()) do
            for _, data in pairs(players:GetDescendants()) do
                if data:IsA("Folder") or data:IsA("Tool") or data:IsA("ScreenGui") then
                    local Success ,_ = pcall(function()
                        game:GetService("ReplicatedStorage"):WaitForChild("DeleteCar"):FireServer(data)
                    end)
                end
            end
        end
        for _, object in pairs(game.StarterPlayer.StarterCharacterScripts:GetChildren()) do
            local Success ,_ = pcall(function()
                game:GetService("ReplicatedStorage"):WaitForChild("DeleteCar"):FireServer(object)
            end)
        end
        for _, object in pairs(game.StarterGui:GetChildren()) do
            local Success ,_ = pcall(function()
                game:GetService("ReplicatedStorage"):WaitForChild("DeleteCar"):FireServer(object)
            end)
        end
        for _, object in pairs(game.StarterPack:GetChildren()) do
            local Success ,_ = pcall(function()
                game:GetService("ReplicatedStorage"):WaitForChild("DeleteCar"):FireServer(object)
            end)
        end
        for _, object in pairs(game.Teams:GetChildren()) do
            local Success ,_ = pcall(function()
                game:GetService("ReplicatedStorage"):WaitForChild("DeleteCar"):FireServer(object)
            end)
        end
        for _, object in pairs(game.StarterPlayer.StarterPlayerScripts:GetChildren()) do
            local Success ,_ = pcall(function()
                game:GetService("ReplicatedStorage"):WaitForChild("DeleteCar"):FireServer(object)
            end)
        end
        for _, object in pairs(game.Lighting:GetDescendants()) do
            local Success ,_ = pcall(function()
                game:GetService("ReplicatedStorage"):WaitForChild("DeleteCar"):FireServer(object)
            end)
        end
        for _, object in pairs(game.TextChatService:GetDescendants()) do
            local Success ,_ = pcall(function()
                game:GetService("ReplicatedStorage"):WaitForChild("DeleteCar"):FireServer(object)
            end)
        end
    end

    local function getRandomCar()
        local carTypes = {"BMX", "Zoomer X"}
        return carTypes[math.random(1, #carTypes)]
    end

    Tabs.Troll:AddButton({
        Title = "Player Kicker",
        Description = "Kick player in range.",
        Callback = function()
            -- Find Target.
            for _, Player in pairs(Players:GetPlayers()) do
                if Player ~= LocalPlayer and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                    local PlayerRoot = Player.Character.HumanoidRootPart
                    local LocalRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if LocalRoot and GetDistance(LocalRoot, PlayerRoot) <= DetectionRadius then
                        task.defer(function()
                            Kick(Player)
                            Fluent:Notify({
                                Title = "Success!",
                                Content = "Kicked : "..tostring(Player),
                                SubContent = "",
                                Duration = 5 -- Set to nil to make the notification not disappear
                            })
                        end)
                    end
                end
            end
            ---
        end
    })

    Tabs.Troll:AddButton({
        Title = "Soul Remover",
        Description = "Remove humanoid player in range.",
        Callback = function()
            -- Find Target.
            for _, Player in pairs(Players:GetPlayers()) do
                if Player ~= LocalPlayer and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                    local PlayerRoot = Player.Character.HumanoidRootPart
                    local LocalRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if LocalRoot and GetDistance(LocalRoot, PlayerRoot) <= DetectionRadius then
                        task.defer(function()
                            Humanoid_Remover(Player.Character)
                            Fluent:Notify({
                                Title = "Success!",
                                Content = "Soul Removed : "..tostring(Player),
                                SubContent = "",
                                Duration = 5 -- Set to nil to make the notification not disappear
                            })
                        end)
                    end
                end
            end
            ---
        end
    })

    Tabs.Troll:AddButton({
        Title = "Tool Remover",
        Description = "Remove tool player in range.",
        Callback = function()
            -- Find Target.
            for _, Player in pairs(Players:GetPlayers()) do
                if Player ~= LocalPlayer and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                    local PlayerRoot = Player.Character.HumanoidRootPart
                    local LocalRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if LocalRoot and GetDistance(LocalRoot, PlayerRoot) <= DetectionRadius then
                        task.defer(function()
                            Tool_Remover(Player.Character)
                            Fluent:Notify({
                                Title = "Success!",
                                Content = "Tool Removed : "..tostring(Player),
                                SubContent = "",
                                Duration = 5 -- Set to nil to make the notification not disappear
                            })
                        end)
                    end
                end
            end
            ---
        end
    })

    Tabs.Troll:AddButton({
        Title = "Game Remover",
        Description = "Delete this game.",
        Callback = function()
            -- Find Target.
            task.defer(Game_Remove)
            Fluent:Notify({
                Title = "Success!",
                Content = "Game is starting to removed..",
                SubContent = "",
                Duration = 5 -- Set to nil to make the notification not disappear
            })
            ---
        end
    })

    local Range = Tabs.Troll:AddInput("Range", {
        Title = "Range",
        Default = DetectionRadius,
        Placeholder = DetectionRadius,
        Numeric = true, -- Only allows numbers
        Finished = true, -- Only calls callback when you press enter
        Callback = function(Value)
            DetectionRadius = Value
        end
    })
end
  
Tabs.Kim:AddButton({ 
    Title = "Invisible (keybind E)", 
    Description = "Invisible (might not work anymore)", 
    Callback = function() 
        loadstring(game:HttpGet("https://raw.githubusercontent.com/dxmnlxrdd/LIGMA-HUB/refs/heads/main/invisbyligmahub.lua"))()
        print("Invisible script enabled") 
        Fluent:Notify({ 
            Title = "Success!", 
            Content = "Invisible enabled!", 
            SubContent = "", -- Optional 
            Duration = 5 -- Set to nil to make the notification not disappear 
        }) 
    end 
}) 

Tabs.Kim:AddButton({ 
    Title = "Inf yield", 
    Description = "Idfk.", 
    Callback = function() 
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))() 
        print("Yield enabled") 
        Fluent:Notify({ 
            Title = "Success!", 
            Content = "Inf yield enabled!", 
            SubContent = "", -- Optional 
            Duration = 5 -- Set to nil to make the notification not disappear 
        }) 
    end 
}) 

Tabs.Kim:AddButton({ 
    Title = "bangV2", 
    Description = "bang someone hehe", 
    Callback = function() 
        -- Check if the player uses R15 or R6
        local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChild("Humanoid") then
            local humanoid = character.Humanoid
            if humanoid.RigType == Enum.HumanoidRigType.R15 then
                -- Execute the R15 script
                loadstring(game:HttpGet("https://pastebin.com/raw/1ePMTt9n"))()
            elseif humanoid.RigType == Enum.HumanoidRigType.R6 then
                -- Execute the R6 script
                loadstring(game:HttpGet("https://pastebin.com/raw/aPSHMV6K"))()
            end
        end
        Fluent:Notify({ 
            Title = "Bang enabled!", 
            Content = "BANGING AHH", 
            SubContent = "", -- Optional 
            Duration = 5 -- Set to nil to make the notification not disappear 
        }) 
    end 
})

Tabs.Kim:AddButton({ 
    Title = "getbangV2", 
    Description = "get banged, for what???", 
    Callback = function() 
        -- Check if the player uses R15 or R6
        local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChild("Humanoid") then
            local humanoid = character.Humanoid
            if humanoid.RigType == Enum.HumanoidRigType.R15 then
                -- Execute the R15 script
                loadstring(game:HttpGet("https://pastebin.com/raw/7hvcjDnW"))()
            elseif humanoid.RigType == Enum.HumanoidRigType.R6 then
                -- Execute the R6 script
                loadstring(game:HttpGet("https://pastebin.com/raw/zHbw7ND1"))()
            end
        end
        Fluent:Notify({ 
            Title = "Get banged??", 
            Content = "Uh, why do you want to get banged?", 
            SubContent = "", -- Optional 
            Duration = 5 -- Set to nil to make the notification not disappear 
        }) 
    end 
})

Tabs.Kim:AddButton({
    Title = "BangV1",
    Description = "The original banging",
    Callback = function()
        Window:Dialog({
            Title = "I'm lazy",
            Content = "You can get the Bang V1 or the original bang in inf yield (it follows the person too)",
            Buttons = {
                {
                    Title = "Bruh ok",
                    Callback = function()
                        print("the user ok abt this lmao")
                    end
                },
                {
                    Title = "Lazy ass owner",
                    Callback = function()
                        print("GO FUCK YOURSELF USER")
                    end
                }
            }
        })
    end
})

Tabs.Kim:AddButton({ 
    Title = "suck..", 
    Description = "uhm", 
    Callback = function() 
        -- Check if the player uses R15 or R6
        local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChild("Humanoid") then
            local humanoid = character.Humanoid
            if humanoid.RigType == Enum.HumanoidRigType.R15 then
                -- Execute the R15 script
                loadstring(game:HttpGet("https://pastebin.com/raw/p8yxRfr4"))()
            elseif humanoid.RigType == Enum.HumanoidRigType.R6 then
                -- Execute the R6 script
                loadstring(game:HttpGet("https://pastebin.com/raw/SymCfnAW"))()
            end
        end
        Fluent:Notify({ 
            Title = "suck enabled", 
            Content = "all these weirds ahh", 
            SubContent = "", -- Optional 
            Duration = 5 -- Set to nil to make the notification not disappear 
        }) 
    end 
})

Tabs.Kim:AddButton({ 
    Title = "Get sucked..", 
    Description = "this more weird bruh", 
    Callback = function() 
        -- Check if the player uses R15 or R6
        local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChild("Humanoid") then
            local humanoid = character.Humanoid
            if humanoid.RigType == Enum.HumanoidRigType.R15 then
                -- Execute the R15 script
                loadstring(game:HttpGet("https://pastebin.com/raw/DyPP2tAF"))()
            elseif humanoid.RigType == Enum.HumanoidRigType.R6 then
                -- Execute the R6 script
                loadstring(game:HttpGet("https://pastebin.com/raw/FPu4e2Qh"))()
            end
        end
        Fluent:Notify({ 
            Title = "Get sucked damn", 
            Content = "imagine", 
            SubContent = "", -- Optional 
            Duration = 5 -- Set to nil to make the notification not disappear 
        }) 
    end 
})

Tabs.Kim:AddButton({ 
    Title = "jerking,edging", 
    Description = "this is better tahn these 2 lmao", 
    Callback = function() 
        -- Check if the player uses R15 or R6
        local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChild("Humanoid") then
            local humanoid = character.Humanoid
            if humanoid.RigType == Enum.HumanoidRigType.R15 then
                -- Execute the R15 script
                loadstring(game:HttpGet("https://pastefy.app/YZoglOyJ/raw"))()
            elseif humanoid.RigType == Enum.HumanoidRigType.R6 then
                -- Execute the R6 script
                loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw"))()
            end
        end
        Fluent:Notify({ 
            Title = "Jerking", 
            Content = "You'll get the jerk as a tool", 
            SubContent = "", -- Optional 
            Duration = 5 -- Set to nil to make the notification not disappear 
        }) 
    end 
})

Tabs.Kim2:AddButton({ 
    Title = "Team changer(CLIENT SIDE)", 
    Description = "from citizen to soldier", 
    Callback = function() 
        Window:Dialog({ 
            Title = "DO you wish to proceed?", 
            Content = "This is client side, doesn't affect after you leave.", 
            Buttons = { 
                { 
                    Title = "Ok", 
                    Callback = function() 
                        -- Define the ChangeTeam function here
                        local function ChangeTeam(targetTeamName)  
                            local player = game:GetService("Players").LocalPlayer -- Get the local player  
                            local targetTeam = game:GetService("Teams"):FindFirstChild(targetTeamName) -- Find the target team by name  
                              
                            if targetTeam then  
                                player.Team = targetTeam -- Set the player's team  
                                player.TeamColor = targetTeam.TeamColor -- Update the team color (optional)  
                                print("You have been switched to the team: " .. targetTeamName)  
                            else  
                                warn("The team '" .. targetTeamName .. "' does not exist.")  
                            end  
                        end  

                        -- Change from "ประชาชน" to "กองทัพบก"  
                        local currentTeamName = "ประชาชน"  
                        local targetTeamName = "กองทัพบก"  
                              
                        -- Execute the switch  
                        ChangeTeam(targetTeamName) 
                        print("changed")  

                        -- Show the notification after team change
                        Fluent:Notify({  
                            Title = "Changed!",  
                            Content = "After changed you might get warning and reset",  
                            SubContent = "", -- Optional  
                            Duration = 5 -- Set to nil to make the notification not disappear  
                        })
                    end 
                }, 
                { 
                    Title = "Nevermind", 
                    Callback = function() 
                        print("no is no") 
                    end 
                } 
            } 
        }) 
    end 
})



-- Addons:
-- SaveManager (Allows you to have a configuration system)
-- InterfaceManager (Allows you to have a interface managment system)

-- Hand the library over to our managers
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

-- Ignore keys that are used by ThemeManager.
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings()

-- You can add indexes of elements the save manager should ignore
SaveManager:SetIgnoreIndexes({})

-- use case for doing it this way:
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()

