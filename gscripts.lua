repeat wait(10) until game:IsLoaded()
task.spawn(function()
getgenv().Config = {
    ["EquipEnchants"] = {"Lucky Eggs", "Lucky Eggs", "Lucky Eggs", "Criticals", "Treasure Hunter", "Treasure Hunter"},
    ["CraftSnowflakeGifts"] = true,
    ["Mailing"] = {
        ["Usernames"] = {"Pr4m0t"},
        ["Items"] = {
            ["Lootbox"] = {
                ["Snowflake Gift"] = 200,
                ["2024 Gargantuan Christmas Present"] = 1,
                ["2024 X-Large Christmas Present"] = 10,
                ["2024 Large Christmas Present"] = 50,
                ["2024 Medium Christmas Present"] = 100,
                ["2024 Small Christmas Present"] = 200,
            },
            ["Egg"] = {
                ["Huge Machine Egg 4"] = 1,
            },
        },
        ["MailAllHuges"] = true --// False will mail all new huges, True will send all huges in inventory
    },
    ["Notifications"] = {
        ["UserID"] = "1167566243969126442",
        ["Webhook"] = "https://discord.com/api/webhooks/1311053918716825720/Vi7JJ2QrcUtkNdGixBbwBWLl-uyhAzj2opmljacNj1hAML808QkEmcj2U5sPelLG475s"
    }
}
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/b883bc159a5f609adb4871db6fc15ea8.lua"))()
end)
task.spawn(function()
    task.wait(30)
local StarterGui = game:GetService('StarterGui')
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)

game:GetService('StarterGui'):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)

game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu, false)
end)
