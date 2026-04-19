-- CaliXtro Project: Rivals Universal Unlocker
-- Focus: Skins, Wraps, and Melee

local MT = getrawmetatable(game)
local OldNamecall = MT.__namecall
setreadonly(MT, false)

MT.__namecall = newcclosure(function(Self, ...)
    local Args = {...}
    local Method = getnamecallmethod()

    -- This hooks the "OwnsItem" or "CheckInventory" logic
    if not checkcaller() and (Method == "InvokeServer" or Method == "FireServer") then
        if Args[1] == "UpdateInventory" or Args[1] == "EquipItem" then
            -- This tells the game the equip was successful
            return true
        end
    end

    return OldNamecall(Self, ...)
end)

-- Visual Unlocker (Forces the UI to show the items as owned)
for _, v in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
    if v:IsA("BoolValue") and (v.Name == "Unlocked" or v.Name == "Owned") then
        v.Value = true
    end
end

setreadonly(MT, true)
print("CaliXtro: Rivals Unlocker Active")
