script_key="tlClaHDMEVLHCVznuBbZZnCneFncboRR";

getgenv().Settings = {
["Webhook"] = "https://discord.com/api/webhooks/1116896146376376391/nxCUIoP8hJUft1K44Rdv1raf1-Y92apQRC0KVzKXK1WVz6r4RHiz22ZJhtPzNIRoWSpk", -- Discord Webhook url for 10 minutes hook.
    ["Farm Speed"] = 0.1,
    ["KickOnCollapse"] = false, -- Will kick you Daily Collapse BUT u should recheck after 6-8 hours he dont get it thats open again before u dont join 1 time
    ["HideChatName"] = true, -- Hide ingame name and chat
    ["FruitHop"] = false, -- If true it hopes world&server if false it do Pixel Vault.
    ["RandomPos"] = false, -- If true it changes a bit world positions but farming maybe will be bit slower.
    ["Minimum Oranges"] = 80,
    ["Maximum Oranges"] = 120,
    ["Mystic Mine"] = true, -- Mines Mystic
    ["Cyber Cavern"] = true, -- Mines Cybern
    ["Minimum Multiplier"] = {
        ["Giant Chest"] = 1,
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
        ["FPS Cap"] = 30,
        ["Disable Rendering"] = true, -- set to true to save GPU/CPU (Screen White)
        ["Downgraded Quality"] = true
    }
}
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/6ae50945c2b57aa2e65b6afc2f4817de.lua"))()
