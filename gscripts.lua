repeat wait(10) until game:IsLoaded()
task.spawn(function()
script_key = "ipXBywOqWcuQMMEBBCmVrvDBXrSRfJLd";
_G.GPROGRESS_MODE = "Hybrid"
_G.GGFX_MODE = 1
_G.GRANK_TO = 99
_G.GZONE_TO = 999
_G.GMAX_EGG_SLOTS = 99
_G.GMAX_EQUIP_SLOTS = 99
_G.GHOLD_GIFTS = true
_G.GHOLD_BUNDLES = true
_G.GMAX_ZONE_UPGRADE_COST = 40000000
_G.GPOTIONS = {"Coins","Lucky","Treasure Hunter","Walkspeed","Diamonds","Damage"}
_G.GPOTIONS_MAX_TIER = 19
_G.GENCHANTS = {"Tap Power", "Coins", "Treasure Hunter", "Strong Pets", "Criticals", "Diamonds"}
_G.GWEBHOOK_USERID = "" -- your discord userID, not your name. numerical id.
_G.GWEBHOOK_LINK = "https://discord.com/api/webhooks/1298622782963449860/9OPkOivRphgOct-73RmJbwa5_R0OS4-007prtfQSgSYnLdCTikfezX1YYrQQX8EVJx8R" -- a webhook URL from your private discord channel.
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/34915da4ad87a5028e1fd64efbe3543f.lua"))()
end)
task.spawn(function()
    task.wait(30)
local StarterGui = game:GetService('StarterGui')
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)

game:GetService('StarterGui'):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)

game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu, false)
end)
