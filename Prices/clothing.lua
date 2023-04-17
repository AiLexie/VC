---@diagnostic disable: undefined-global

-- Import the Orion UI Library
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

-- Create a window using the Orion UI Library
local Window = OrionLib:MakeWindow({Name = "Store Claimer", SaveConfig = true, ConfigFolder = "StoreClaimer"})

-- api
VirtualInputManager = game:GetService("VirtualInputManager")


function TeleportToTargetPos(targetPos)
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, targetPos)
    repeat wait() until game:GetService("Players").LocalPlayer.Character
    local humanoid = game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid")
    local rootPart = game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart")
    local offset = Vector3.new(0, 5, 0)
    local targetPosition = targetPos.Position + offset

    while (rootPart.Position - targetPosition).Magnitude > 5 do
        humanoid:MoveTo(targetPosition, targetPart)
        wait(0.1)
    end
end

local function ServerHop()
    wait(25)
    game:GetService("TeleportService"):Teleport(7406897155, game:GetService("Players").LocalPlayer)
end



local function claimStores()
    local claimStores = game:GetService("Workspace").ClaimStores

    for i = 1, 13 do
        local storeName = "S" .. i
        local storeObject = claimStores:FindFirstChild(storeName)
           
    
        if storeObject then
            if storeObject:FindFirstChildWhichIsA("ProximityPrompt") then
                local storePrompt = storeObject:FindFirstChildWhichIsA("ProximityPrompt")
                -- Teleport to the store object
                OrionLib:MakeNotification({
                    Name = "Teleporting to " .. storeName,
                    Content = "Moving to store...",
                    Image = "rbxassetid://4483345998",
                    Time = 5
                })
        
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = storeObject.CFrame
                wait(1)
        
                -- Check if Roblox is active
                --if iswindowactive() then
                -- Simulate pressing the E key
                fireproximityprompt(storePrompt, 1 ,true)
                OrionLib:MakeNotification({
                    Name = "Clicked E button",
                    Content = "For store " .. storeName,
                    Image = "rbxassetid://4483345998",
                    Time = 5
                })
                task.wait(1)
                if storeObject.Ava.SurfaceGui.Title.Text == game.Players.LocalPlayer.Name then
                    ServerHop()
                end
                
                
               --[[ else
                    -- Roblox is not active, print a message
                    OrionLib:MakeNotification({
                        Name = "Error",
                        Content = "Roblox is not active, please focus the window.",
                        Image = "rbxassetid://4483345998",
                        Time = 5
                    })
                end ]]
                    -- Wait 5 seconds before moving on to the next store object
                wait(3)
            end
        else
            -- The store object was not found
            OrionLib:MakeNotification({
                Name = "Store not found",
                Content = storeName,
                Image = "rbxassetid://4483345998",
                Time = 5
            })
        end
    end
    
        -- Wait 25 seconds before server hopping
    OrionLib:MakeNotification({
        Name = "Waiting to server hop",
        Content = "Waiting 25 seconds...",
        Image = "rbxassetid://4483345998",
        Time = 5
    })
    wait(25)
    
    -- Server hop here
    game:GetService("TeleportService"):Teleport(7406897155, game:GetService("Players").LocalPlayer)
end

syn.queue_on_teleport([[
    loadstring(game:HttpGet'https://raw.githubusercontent.com/SnPux/VC/master/Prices/clothing.lua')()
]])

-- GUI Elements
local toggleEnabled = false

local Home = Window:MakeTab({
    Name = "Claimer",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local toggleBox = Home:AddToggle({
    Name = "Teleport and Claim Stores",
    Default = false,
    Callback = function(Value)
        toggleEnabled = Value
        if toggleEnabled then
            claimStores()
        end
    end
})

-- Main Loop
while wait() do
    if toggleEnabled then
        claimStores()
    end
end
OrionLib:Init()
