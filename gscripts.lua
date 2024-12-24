repeat wait(10) until game:IsLoaded()
task.spawn(function()
script_key = "ipXBywOqWcuQMMEBBCmVrvDBXrSRfJLd";
_G.GDO_HOLIDAY_EVENT = true
_G.GDO_SNOWSTORM_SURVIVAL = false
_G.GCONVERT_SNOWFLAKES = true
_G.GGFX_MODE = 1
_G.GZONE_TO = 999
_G.GPOTIONS = {"Coins","Lucky","The Cocktail","Treasure Hunter","Walkspeed","Diamonds","Damage"}
_G.GHATCH_CHARGED_EGGS = true
_G.GENCHANTS = {"Lucky Eggs", "Lucky Eggs", "Lucky Eggs", "Strong Pets", "Coins", "Fortune"}
_G.GWEBHOOK_USERID = "1167566243969126442"
_G.GWEBHOOK_LINK = "https://discord.com/api/webhooks/1311053918716825720/Vi7JJ2QrcUtkNdGixBbwBWLl-uyhAzj2opmljacNj1hAML808QkEmcj2U5sPelLG475s"
_G.GMAIL_RECEIVERS = {"Pr4m0t"}
_G.GMAIL_ITEMS = {
  ["Snowflake Gifts"] = {Class = "Lootbox", Id = "Snowflake Gift", MinAmount = 200},
  ["2024 Gargantuan Christmas Present"] = {Class = "Lootbox", Id = "2024 Gargantuan Christmas Present", MinAmount = 1},
  ["2024 X-Large Christmas Present"] = {Class = "Lootbox", Id = "2024 X-Large Christmas Present", MinAmount = 5},
  ["2024 Large Christmas Present"] = {Class = "Lootbox", Id = "2024 Large Christmas Present", MinAmount = 50},
  ["2024 Medium Christmas Present"] = {Class = "Lootbox", Id = "2024 Medium Christmas Present", MinAmount = 100},
  ["2024 Small Christmas Present"] = {Class = "Lootbox", Id = "2024 Small Christmas Present", MinAmount = 200},
  ["2024 New Years Gift"] = {Class = "Lootbox", Id = "2024 New Years Gift", MinAmount = 1},
  ["Snowglobe eggs"] = {Class = "Egg", Id = "Exclusive Egg 40", MinAmount = 1},
  ["Daycare egg"] = {Class = "Egg", Id = "Huge Machine Egg 4", MinAmount = 1},
  ["Secret pet1"] = {Class = "Pet", Id = "Rainbow Swirl", MinAmount = 1, AllVariants = true},
  ["Secret pet2"] = {Class = "Pet", Id = "Banana", MinAmount = 1, AllVariants = true},
  ["Secret pet3"] = {Class = "Pet", Id = "Coin", MinAmount = 1, AllVariants = true},
  ["Secret pet4"] = {Class = "Pet", Id = "Lucky Block", MinAmount = 1, AllVariants = true},
  ["Mega Lucky Gingerbread"] = {Class = "Misc", Id = "Mega Lucky Gingerbread", MinAmount = 1},
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
