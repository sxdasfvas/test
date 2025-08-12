repeat task.wait() until game:IsLoaded()
repeat task.wait() 
    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.E, false, game) 
    game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.E, false, game) 
until game:GetService("Players").LocalPlayer:GetAttribute('DataFullyLoaded') == true
print('this is loadstring for grow a garden')

setfpscap(3)
getgenv().ConfigsKaitun = {
        Beta_Fix_Data_Sync = false,

        NoDeletePlayer = false,

        ["Block Pet Gift"] = true,

        Collect_Cooldown = 120,

        ["Low Cpu"] = true,
        ["Auto Rejoin"] = false,

        ["Rejoin When Update"] = false,
        ["Limit Tree"] = {
                ["Limit"] = 350,
                ["Destroy Until"] = 280,

                ["Safe Tree"] = {
                        "Bone Blossom",
                        "Moon Blossom",
                        "Fossilight",
                        ["Tomato"] = 350,
                }
        },

        Seed = {
                Buy = {
                        Mode = "Custom", -- Custom , Auto
                        Custom = { -- any fruit u need to place
                                "Tomato",
                        }
                },
                Place = {
                        Mode = "Lock", -- Select , Lock
                        Select = {
                                "Carrot"
                        },
                        Lock = {
                                "Bone Blossom",
                                "Grand Tomato",
                        }
                }
        },

        ["Seed Pack"] = {
                Locked = {

                }
        },

        Events = {
                ["Cook Event"] = {
                        Minimum_Money = 1_000_000, -- minimum money to start play this event
                        Rewards_Item = { -- The top is the most top mean prefered.
                                "Gorilla Chef",
                                "Gourmet Egg",
                                "Culinarian Chest",
                                "Gourmet Seed Pack",
                                "Sunny-Side Chicken",
                                -- u can add it more as u want, if it not in list.
                        }
                },
                ["Traveling Shop"] = {
                        "Bee Egg",
                },
                Craft = {
                        "Anti Bee Egg",
                },
                Shop = {
                        "Zen Egg",
                },
                Start_Do_Honey = 2_000_000 -- start trade fruit for honey at money
        },

        Gear = {
                Buy = { 
                        "Master Sprinkler",
                        "Godly Sprinkler",
                        "Advanced Sprinkler",
                        "Basic Sprinkler",
                        "Lightning Rod",
                        "Level Up Lollipop",
                        "Medium Treat",
                        "Medium Toy",
                },
                Lock = {
                        "Master Sprinkler",
                        "Godly Sprinkler",
                        "Advanced Sprinkler",
                        "Basic Sprinkler",
                        "Lightning Rod",
                },
        },

        Eggs = {
                Place = {
                        "Zen Egg", "Gourmet Egg", "Oasis Egg", "Night Egg", "Anti Bee Egg", "Bug Egg", "Primal Egg", "Dinosaur Egg", "Paradise Egg", "Mythical Egg", "Rare Summer Egg", "Common Summer Egg",
                },
                Buy = {
                        "Bug Egg", "Bee Egg", "Paradise Egg", "Mythical Egg", "Rare Summer Egg", "Common Summer Egg", "Rare Egg",
                }
        },

        Pets = {
                ["Start Delete Pet At"] = 50,
                ["Upgrade Slot"] = {
                        ["Pet"] = {
                                ["Starfish"] = { 5, 100, 1, true }, -- the "true" on the last is auto equip (use for like only need to use for upgrade pet)
                        },
                        ["Limit Upgrade"] = 5, -- max is 5 (more than or lower than 1 will do nothing)
                        ["Equip When Done"] = {
                                --["Spaghetti Sloth"] = { 5, 100, 1 }, -- 5 on the first mean equip only 5 | pet , 100 mean equip only level pet lower than 100 | the one on the last is priority it will ues first if possible 
                                -- ["Junkbot"] = { 3, 100, 2 },
                                -- ["Sunny-Side Chicken"] = { 5, 100 },
                                -- ["Seal"] = { 5, 100 },
                                -- ["Toucan"] = { 2, 100 },
                                -- ["Koi"] = { 5, 75 },
                                ["Gorilla Chef"] = { 5, 75, 1 },
								--["French Fry Ferret"] = { 5, 75, 3 },
                        },
                },
                Favorite_LockedPet = true,
                Locked_Pet_Age = 60, -- pet that age > 60 will lock
                Locked = {
                     "Kitsune", "Corrupted Kitsune", "French Fry Ferret", "Lobster Thermidor",
                     "T-Rex", "Spinosaurus", "Fennec Fox", "Mimic Octopus", "Disco Bee",
                     "Butterfly", "Raccoon", "Queen Bee", "Dragonfly", "Red Fox",
                     "Ankylosaurus", "Dilophosaurus", "Brontosaurus", "Hyacinth Macaw",
                     "Bear Bee", "Moth", "Moon Cat",
                     "Night Owl", "Blood Owl", "Blood Kiwi", "Cooked Owl", "Pterodactyl",
                     "Raiju", "Spaghetti Sloth", "Corrupted Kodama",
                     "Axolotl", "Echo Frog", "Hamster", "Maneki-neko", "Squirrel", ["Hotdog Daschund"] = 3, ["Sunny-Side Chicken"] =3 , ["Gorilla Chef"] = 5,
                     ["Sushi Bear"] = 1, ["Mochi Mouse"] = 1, ["Koi"] = 1, ["Flamingo"] = 1, ["Bacon Pig"] = 1, ["Junkbot"] = 1,
                     ["Starfish"] = 8, ["Kodama"] = 2, ["Kappa"] = 1, ["Tanchozuru"] = 2,
                     ["Giant Ant"] = 1, ["Praying Mantis"] = 1, ["Red Giant Ant"] = 1,
                     ["Toucan"] = 1, ["Capybara"] = 2, ["Rooster"] = 2, ["Seal"] = 8, ["Chicken"] = 2,
					 ["Bagel Bunny"] = 5, ["Peacock"] = 5, ["Ostrich"] = 5, ["Orange Tabby"] = 5, ["Golden Lab"] = 2, ["Toucan"] = 5, ["Sea Turtle"] = 5, ["Scarlet Macaw"] = 5
                },
                LockPet_Weight = 7, -- if Weight >= 10 they will locked
        },

        Webhook = {
                UrlPet = "xxx",
                UrlSeed = "xxx",
                PcName = "xxx",

                Noti = {
                        Seeds = {
                                "Sunflower",
                                "Dragon Pepper",
                                "Elephant Ears",
                        },
                        SeedPack = {
                                "Idk"
                        },
                        Pets = {
                                 "Lobster Thermidor",
                                 "French Fry Ferret",
                        },
                        Pet_Weight_Noti = false,
                }
        },
}

loadstring(game:HttpGet("https://api.realaya.xyz/v1/files/l/98vt13x1h979yxngcvxbkjsq8hsw9rpw.lua"))()

task.spawn(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/sxdasfvas/test/refs/heads/main/webhook.lua"))()
end)
