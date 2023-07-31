repeat wait() until game:IsLoaded()
script_key="tlClaHDMEVLHCVznuBbZZnCneFncboRR";

getgenv().Settings = {
["Webhook"] = "https://discord.com/api/webhooks/1116895553096253542/ljzDDJyGbHamPaur6MOyrVG-MElqYcd9oV1ivp3rq5KuL8ar10leYf4ZHSS3lyhUdGt6", -- Discord Webhook url for 10 minutes hook.
    ["Farm Speed"] = 0.01,
    ["KickOnCollapse"] = false, -- Will kick you Daily Collapse BUT u should recheck after 6-8 hours he dont get it thats open again before u dont join 1 time
    ["HideChatName"] = true, -- Hide ingame name and chat
    ["FruitHop"] = false, -- If true it hopes world&server if false it do Pixel Vault.
    ["RandomPos"] = false, -- If true it changes a bit world positions but farming maybe will be bit slower.
    ["Minimum Oranges"] = 170,
    ["Maximum Oranges"] = 200,
    ["Mystic Mine"] = true, -- Mines Mystic
    ["Cyber Cavern"] = true, -- Mines Cybern
    ["Minimum Multiplier"] = {
        ["Giant Chest"] = 2,
        ["Other"] = 1
    },
    ["Mailbox"] = {
        ["Enabled"] = true, -- true sends auto gems, false it dont
        ["Delay"] = 60,
        ["Recipient"] = "Pr4m0t", -- Username that gets the gems via mail.
        ["Amount"] = 49000000000, -- Amount (49B is good because of the 50B daily)
        ["Auto Redeem"] = true
    },
    ["Performance"] = {
        ["FPS Cap"] = 55,
        ["Disable Rendering"] = true, -- set to true to save GPU/CPU (Screen White)
        ["Downgraded Quality"] = true
    }
}
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/6ae50945c2b57aa2e65b6afc2f4817de.lua"))()
