script_key = "IHvytEKwVEPmCrZxYOEDTXahSbmtmhDe"
getgenv().Settings = {
    Sniper = {
        Active = true,
        Items = {
            --// Example Settings showcasing features.
            SearchTerminal = {
                [[ Terminal doesn't support custom keywords like "All Huges". ]],

                ["Huge Red Wolf"] = {Class = "Pet", Price = 19000000},
                ["Huge Scarecrow Dog"] = {Class = "Pet", Price = 19000000},
       
            },
        },
        Serverhop = {
            ["Switch Servers"] = true,
            ["Teleport Delay (s)"] = 1,
            ["Add Pro Plaza Lobbies"] = false,
            ["Constant Terminal Searching"] = true,
            ["Terminal Searches per Item"] = 1,
            ["Save # Servers"] = 10,
        },
        Webhook = {
            ["URL"] = "https://discord.com/api/webhooks/1296049119034347521/qg6arpnD8o8kkk7nAzYRcDIBx282Flvh7HjYXOC4gRcCLcEDhPkQO-fsVuDHZ_kg3U8L",
            ["Send Embeds"] = true,
            ["Remove Username"] = true,
            ["Ping on Huges 'n Titanics"] = true,
            ["Global Snipes"] = true,
        },
        StopParams = {
            ["Limits Reached"] = false,
            ["Diamonds Hit: 250k"] = true,
            ["60 Minutes"] = false,
            ["Switch To Selling"] = true,
        },
    },
}
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/60a293774110e918789cddc0e20be048.lua"))()
