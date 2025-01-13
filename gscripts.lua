repeat wait(10) until game:IsLoaded()
task.spawn(function()
script_key = "ipXBywOqWcuQMMEBBCmVrvDBXrSRfJLd";
_G.GPROGRESS_MODE = "Hybrid"
_G.GGFX_MODE = 1
_G.GRANK_TO = 99
_G.GZONE_TO = 999
_G.GHATCH_SPEED_MS = 0
_G.GMAX_EGG_SLOTS = 99
_G.GMAX_EQUIP_SLOTS = 99
_G.GHOLD_GIFTS = false
_G.GHOLD_BUNDLES = true
_G.GCOLLECT_FREE_ITEMS = true
_G.GMAX_ZONE_UPGRADE_COST = 40000000
_G.GMAX_MAIL_COST = "2M"
_G.GPOTIONS = {"Coins","Lucky","Treasure Hunter","Walkspeed","Diamonds","Damage"}
_G.GPOTIONS_MAX_TIER = 19
_G.GUSE_SPRINKLERS = true
_G.GUSE_FLAGS = {"Fortune Flag","Diamonds Flag","Coins Flag"}
_G.GENCHANTS = {"Diamonds", "Diamonds", "Criticals", "Criticals", "Strong Pets", "Strong Pets"}
_G.GWEBHOOK_USERID = "" -- your discord userID, not your name. numerical id.
_G.GWEBHOOK_LINK = "https://discord.com/api/webhooks/1298622782963449860/9OPkOivRphgOct-73RmJbwa5_R0OS4-007prtfQSgSYnLdCTikfezX1YYrQQX8EVJx8R" -- a webhook URL from your private discord channel.
_G.GMAIL_RECEIVERS = {"R6dtProfit"}  -- an account to receive hatched Huges etc
_G.GMAIL_ITEMS = {
  ["All Huges"] = {Class = "Pet", Id = "All Huges", Amount = 1},
  ["Send all Diamonds"] = {Class = "Currency", Id = "Diamonds", MinAmount = "50m"},
  ["Hype Egg"] = {Class = "Lootbox", Id = "Hype Egg", MinAmount = 1},
  ["Doodle Gift"] = {Class = "Lootbox", Id = "Doodle Gift", MinAmount = 10},
  ["Daycare egg"] = {Class = "Egg", Id = "Huge Machine Egg 4", MinAmount = 1},
  ["Secret pet1"] = {Class = "Pet", Id = "Rainbow Swirl", MinAmount = 1, AllVariants = true},
  ["Secret pet2"] = {Class = "Pet", Id = "Banana", MinAmount = 1, AllVariants = true},
  ["Secret pet3"] = {Class = "Pet", Id = "Coin", MinAmount = 1, AllVariants = true},
  ["Secret pet4"] = {Class = "Pet", Id = "Lucky Block", MinAmount = 1, AllVariants = true},
}
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/34915da4ad87a5028e1fd64efbe3543f.lua"))()
end)
task.spawn(function()
    task.wait(60)
local StarterGui = game:GetService('StarterGui')
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)

game:GetService('StarterGui'):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)

game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu, false)
end)
