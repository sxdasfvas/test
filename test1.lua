getgenv([[

    Donate:
        BTC: bc1q9ptr83ds6y2ly2jhlnn8qvypeucap3ez2v5zzr
        LTC: LUEafMZScHjF3m1sMohj9LKqcRoFQn1bW2
        Cashapp $jedpep
    
    I dont make any money from this so donating helps a lot :)
    made by jedpep
    discord.gg/BNxJpgymkE

]])

getgenv().JXMysticFarmerConfig = {
    AutoServerTripleDamage = true,
    MineMode = "Multi", -- Multi or All
    Areas = {
        ["Mystic Mine"] = {
            Diamonds = true,
            GiantChest = true,
        },
        ["Cyber Cavern"] = {
            Diamonds = false,
            GiantChest = true,
        },
        ["Paradise Cave"] = {
            Diamonds = false,
        },
    },
    Webhook = {
        EnabledGemWebhook = true,
        EnableFruitWebhook = true,
        GemUrl = "https://discord.com/api/webhooks/1116895553096253542/ljzDDJyGbHamPaur6MOyrVG-MElqYcd9oV1ivp3rq5KuL8ar10leYf4ZHSS3lyhUdGt6",
        FruitUrl = "https://discord.com/api/webhooks/1116895553096253542/ljzDDJyGbHamPaur6MOyrVG-MElqYcd9oV1ivp3rq5KuL8ar10leYf4ZHSS3lyhUdGt6",
        ShowUsername = true,
        ShowFruits = true,
        Delay = 300, -- seconds
    },
    Fruits = {
        Max = 200,
        StartFarmAt = -1,
        FruitsToFarm = {
            "Apple",
            "Orange",
            "Pineapple",
            "Pear", -- Golden apple thing
            "Rainbow Fruit",
            "Banana"
        },
        Worlds = {
            "Spawn",
            "Fantasy",
            "Tech",
            "Axolotl Ocean",
            "Pixel",
            "Cat",
            "Doodle",
            --"Kawaii",
            --"Dog",
        }
    },
    Preformace = {
        FPS = 60,
    }
}

loadstring(game:HttpGet("https://raw.githubusercontent.com/sxdasfvas/test/main/555.lua"))()
