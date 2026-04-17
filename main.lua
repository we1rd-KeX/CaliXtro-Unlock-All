-- [[ CALIXTRO ULTRA-LITE ]]
if not game:IsLoaded() then game.Loaded:Wait() end

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Modules = ReplicatedStorage:WaitForChild("Modules", 20)

-- Direct Bypass (No Namecall, No Metatables = No Lag)
local function bypass()
    local lp = game:GetService("Players").LocalPlayer
    local old; old = hookfunction(lp.Kick, function(self, reason)
        return nil 
    end)
end

-- Direct Skin Injection (Targeting exact modules only)
local function unlock()
    local CosmeticLib = require(Modules:WaitForChild("CosmeticLibrary"))
    local ItemLib = require(Modules:WaitForChild("ItemLibrary"))
    local DataCtrl = require(game:GetService("Players").LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"))

    -- The "Heavy" logic is removed. We just flip the logic gates.
    local function forceTrue() return true end

    CosmeticLib.OwnsCosmetic = forceTrue
    CosmeticLib.OwnsCosmeticNormally = forceTrue
    CosmeticLib.OwnsCosmeticUniversally = forceTrue
    
    -- Force the inventory data to act as if it's full
    local oldGet = DataCtrl.Get
    DataCtrl.Get = function(self, key)
        if key == "CosmeticInventory" then return setmetatable({}, {__index = forceTrue}) end
        return oldGet(self, key)
    end
    
    print("CaliXtro: Mobile Ready")
end

-- Run in separate threads to prevent screen freezing
task.spawn(bypass)
task.spawn(unlock)
