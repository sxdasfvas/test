repeat wait(10) until game:IsLoaded()
script_key = "ckPdayaCOBNNdcEoSYIMtTTHwVWAWXzu"

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
                ["Jolly Gift"] = 10,
            },
            ["Egg"] = {
                ["Huge Machine Egg 4"] = 1,
            },
        },
        ["MailAllHuges"] = true --// False will mail all new huges, True will send all huges in inventory
    },
    ["Notifications"] = {
        ["UserID"] = "",
        ["Webhook"] = "https://discord.com/api/webhooks/1311053918716825720/Vi7JJ2QrcUtkNdGixBbwBWLl-uyhAzj2opmljacNj1hAML808QkEmcj2U5sPelLG475s"
    }
}
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/e75d31131aa5d9b2da332ee7b55d5f6b.lua"))()
