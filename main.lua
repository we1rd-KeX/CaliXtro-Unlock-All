-- [[ CALIXTRO STEALTH CORE ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService") -- Used for saving settings locally
local player = game:GetService("Players").LocalPlayer

-- 1. THE WRAP UNLOCKER (The "Spoof")
local function unlockSkins()
    -- We search for modules named "Skin", "WeaponData", or "WrapConfig"
    for _, v in pairs(ReplicatedStorage:GetDescendants()) do
        if v:IsA("ModuleScript") and (v.Name:find("Skin") or v.Name:find("Wrap")) then
            local data = require(v)
            if type(data) == "table" then
                for _, skin in pairs(data) do
                    if type(skin) == "table" then
                        skin.Unlocked = true
                        skin.Owned = true
                        skin.Price = 0 -- Makes them free if it's a shop system
                    end
                end
            end
        end
    end
    print("CaliXtro: All Wraps Spoofed to 'Owned'")
end

-- 2. THE LOCAL SAVING SYSTEM (2GB RAM Friendly)
-- Since we want it to save when they leave, we use a local JSON file
local SAVE_FILE = "CaliXtro_Config.json"

local function saveSelection(weapon, skin)
    local data = { [weapon] = skin }
    -- writefile is a command used by most executors
    writefile(SAVE_FILE, HttpService:JSONEncode(data))
end

local function loadSelection()
    if isfile(SAVE_FILE) then
        local data = HttpService:JSONDecode(readfile(SAVE_FILE))
        return data
    end
    return {}
end

-- 3. AUTO-APPLIER
-- This waits for a gun to be added to your character and forces the skin
player.CharacterAdded:Connect(function(char)
    char.ChildAdded:Connect(function(child)
        if child:IsA("Tool") then
            local savedSkins = loadSelection()
            if savedSkins[child.Name] then
                -- This is where your Skin Changer logic from before goes!
                print("CaliXtro: Auto-applying " .. savedSkins[child.Name])
            end
        end
    end)
end)

-- RUN INITIAL BOOT
unlockSkins()
