-- TCBHP Standalone Unlocker [April 2026]
-- Targets Skins, Wraps, and Finisher attributes for the latest update

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local function UnlockItems()
    -- Common paths for Rivals and other modern shooters
    local targets = {
        ReplicatedStorage:FindFirstChild("ItemData"),
        ReplicatedStorage:FindFirstChild("Skins"),
        ReplicatedStorage:FindFirstChild("Wraps"),
        ReplicatedStorage:FindFirstChild("Cosmetics")
    }

    for _, folder in pairs(targets) do
        if folder then
            for _, item in pairs(folder:GetDescendants()) do
                -- 1. Standard BoolValue Unlock (Old System)
                if item:IsA("BoolValue") and (item.Name == "Owned" or item.Name == "Unlocked") then
                    item.Value = true
                
                -- 2. Attribute Unlock (Update 19 / Modern System)
                elseif item:IsA("Configuration") or item:IsA("Folder") or item:IsA("Model") then
                    if item:GetAttribute("Owned") ~= nil then
                        item:SetAttribute("Owned", true)
                    end
                    if item:GetAttribute("Unlocked") ~= nil then
                        item:SetAttribute("Unlocked", true)
                    end
                end
            end
        end
    end
end

-- Run once on execute, then every 5 seconds to catch new shop rotations
task.spawn(function()
    while true do
        UnlockItems()
        task.wait(5) -- Long wait time to save CPU usage on your N2940
    end
end)

print("TCBHP: Skins and Wraps Unlocked.")
