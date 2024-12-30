repeat wait(10) until game:IsLoaded()
task.spawn(function()
script_key = "ipXBywOqWcuQMMEBBCmVrvDBXrSRfJLd";
_G.GDO_HOLIDAY_EVENT = true
_G.GDO_SNOWSTORM_SURVIVAL = true
_G.GCONVERT_SNOWFLAKES = true
_G.GGFX_MODE = 1
_G.GZONE_TO = 99
_G.GPOTIONS = {"Coins","Lucky","The Cocktail","Treasure Hunter","Walkspeed","Diamonds","Damage"}
_G.GHATCH_CHARGED_EGGS = false
_G.GENCHANTS = {"Lucky Eggs", "Lucky Eggs", "Lucky Eggs", "Criticals", "Treasure Hunter", "Treasure Hunter"}
_G.GWEBHOOK_USERID = "1167566243969126442"
_G.GWEBHOOK_LINK = "https://discord.com/api/webhooks/1311053918716825720/Vi7JJ2QrcUtkNdGixBbwBWLl-uyhAzj2opmljacNj1hAML808QkEmcj2U5sPelLG475s"
_G.GMAIL_RECEIVERS = {"Pr4m0t"}
_G.GMAIL_ITEMS = {
  ["All Huges"] = {Class = "Pet", Id = "All Huges", Amount = 1},
  ["Snowflake Gifts"] = {Class = "Lootbox", Id = "Snowflake Gift", MinAmount = 400},
  ["Cove Lockpick"] = {Class = "Misc", Id = "Lockpick A", MinAmount = 30},
  ["Gold Lockpick"] = {Class = "Misc", Id = "Lockpick B", MinAmount = 10},
  ["Diamond Lockpick"] = {Class = "Misc", Id = "Lockpick C", MinAmount = 1},
  ["Normals"] = {Class = "Pet", Id = "Poinsettia Peacock", MinAmount = 1},
  ["Shinies"] = {Class = "Pet", Id = "Poinsettia Peacock", MinAmount = 1, IsShiny = true},
  ["Goldens"] = {Class = "Pet", Id = "Poinsettia Peacock", MinAmount = 1, IsGold = true},
  ["Shiny Goldens"] = {Class = "Pet", Id = "Poinsettia Peacock", MinAmount = 1, IsGold = true, IsShiny = true},
  ["RBs"] = {Class = "Pet", Id = "Poinsettia Peacock", MinAmount = 1, IsRainbow = true},
  ["Shiny RBs"] = {Class = "Pet", Id = "Poinsettia Peacock", MinAmount = 1, IsRainbow = true, IsShiny = true},
  ["Snowglobe eggs"] = {Class = "Egg", Id = "Exclusive Egg 40", MinAmount = 1},
  ["Daycare egg"] = {Class = "Egg", Id = "Huge Machine Egg 4", MinAmount = 1},
  ["Secret pet1"] = {Class = "Pet", Id = "Rainbow Swirl", MinAmount = 1, AllVariants = true},
  ["Secret pet2"] = {Class = "Pet", Id = "Banana", MinAmount = 1, AllVariants = true},
  ["Secret pet3"] = {Class = "Pet", Id = "Coin", MinAmount = 1, AllVariants = true},
  ["Secret pet4"] = {Class = "Pet", Id = "Lucky Block", MinAmount = 1, AllVariants = true},
}
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/34915da4ad87a5028e1fd64efbe3543f.lua"))()
end)
task.spawn(function()
    task.wait(30)
local StarterGui = game:GetService('StarterGui')
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)

game:GetService('StarterGui'):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)

game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu, false)
end)
