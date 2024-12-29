repeat wait(10) until game:IsLoaded()
getgenv().Config = {
    ["EquipEnchants"] = {"Lucky Eggs", "Lucky Eggs", "Lucky Eggs", "Strong Pets", "Coins", "Fortune"},
    ["SnowstormSurvival"] = true,
    ["Mailing"] = {
        ["Usernames"] = {"Pr4m0t"},
        ["Items"] = {
            ["Misc"] = {
                ["Lockpick A"] = 25,
                ["Lockpick B"] = 10,
                ["Lockpick C"] = 3,
            },
            ["Lootbox"] = {
                ["Jolly Gift"] = 5,
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
