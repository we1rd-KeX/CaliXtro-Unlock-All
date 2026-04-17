-- [[ CALIXTRO LITE - RIVALS UNLOCKER ]]
-- Optimized for 2GB RAM / N2940
repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local lp = Players.LocalPlayer

-- 1. ULTRALIGHT BYPASS (No getgc loop)
local mt = getrawmetatable(game)
local oldnc = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    -- Block Kicks and Anti-Cheat Alerts
    if (method == "Kick" or method == "kick") and self == lp then return nil end
    if method == "FireServer" and (tostring(self) == "ClientAlert" or tostring(self) == "CheckAC") then
        return nil 
    end
    return oldnc(self, ...)
end)
setreadonly(mt, true)

-- 2. DIRECT MODULE HOOKING (Efficient)
local function applyHooks()
    local Modules = ReplicatedStorage:WaitForChild("Modules", 5)
    if not Modules then return end

    local CosmeticLib = require(Modules:WaitForChild("CosmeticLibrary"))
    local ItemLib = require(Modules:WaitForChild("ItemLibrary"))

    -- Force ownership to TRUE for everything
    CosmeticLib.OwnsCosmetic = function() return true end
    CosmeticLib.OwnsCosmeticNormally = function() return true end
    CosmeticLib.OwnsCosmeticUniversally = function() return true end
    
    print("CaliXtro: Skins Unlocked (Direct Hook)")
end

-- 3. STEALTH AUTO-SAVE (Uses Workspace)
local savePath = "CaliXtro_Rivals.json"

local function saveSkins(data)
    if writefile then
        writefile(savePath, game:GetService("HttpService"):JSONEncode(data))
    end
end

-- Run
task.spawn(applyHooks)
