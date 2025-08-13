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
                ["Destroy Until"] = 320,

                ["Safe Tree"] = {
                        "Bone Blossom",
                        "Elephant Ears",
                        "Tranquil Bloom",
                        "Elder Strawberry",
                        "Giant Pinecone",
                        "Burning Bud",
                        "Sugar Apple",
                        "Ember Lily",
                        "Beanstalk",
                        "Candy Blossom",
                        "Moon Blossom",
                        "Hive Fruit",
                        "Dragon Pepper",
                        "Rosy Delight",
                        "Fossilight",
                        "Pitcher Plant",
                        "Sunflower",
                        "Maple Apple",
                        "Nectarine",
                        "Taco Fern",
                        "Grand Tomato",
                        "King Cabbage",
                        "Badlands Pepper",
       ["Carrot"] = 4, ["Strawberry"] = 4, ["Blueberry"] = 4, ["Rose"] = 4, ["Orange Tulip"] = 4, ["Dezen"] = 4, ["Artichoke"] = 4,
       ["Onion"] = 4, ["Tomato"] = 4, ["Daffodil"] = 4, ["Cauliflower"] = 4, ["Raspberry"] = 4, ["Foxglove"] = 4, ["Corn"] = 4,
       ["Horsetail"] = 4, ["Twisted Tangle"] = 4, ["Jalapeno"] = 4, ["Watermelon"] = 4, ["Pumpkin"] = 4, ["Avocado"] = 4, ["Green Apple"] = 4,
       ["Apple"] = 4, ["Banana"] = 4, ["Lilac"] = 4, ["Taro Flower"] = 4, ["Bamboo"] = 4, ["Rafflesia"] = 4, ["Lingonberry"] = 4,
       ["Lucky Bamboo"] = 4, ["Veinpetal"] = 4, ["Crown Melon"] = 4, ["Peach"] = 4, ["Pineapple"] = 4, ["Amber Spine"] = 4, ["Coconut"] = 4,
       ["Cactus"] = 4, ["Dragon Fruit"] = 4, ["Mango"] = 4, ["Kiwi"] = 4, ["Bell Pepper"] = 4, ["Prickly Pear"] = 4, ["Pink Lily"] = 4,
       ["Purple Dahlia"] = 4, ["Tall Asparagus"] = 4, ["Sugarglaze"] = 4, ["Grape"] = 4, ["Loquat"] = 4, ["Mushroom"] = 4, ["Pepper"] = 4,
       ["Cacao"] = 4, ["Feijoa"] = 4, ["Pitcher Plant"] = 4, ["Grand Volcania"] = 4, ["Sunflower"] = 4, ["Grand Tomato"] = 4, ["Taco Fern"] = 4,
       ["Beanstalk"] = 4, ["Ember Lily"] = 4, ["Sugar Apple"] = 4, ["Burning Bud"] = 4, ["Giant Pinecone"] = 4, ["Elder Strawberry"] = 4, ["Chocolate Carrot"] = 4,
       ["Red Lollipop"] = 4, ["Nightshade"] = 4, ["Crocus"] = 4, ["Lavender"] = 4, ["Manuka Flower"] = 4, ["Wild Carrot"] = 4, ["Stonebite"] = 4,
       ["Candy Sunflower"] = 4, ["Peace Lily"] = 4, ["Mint"] = 4, ["Blue Lollipop"] = 4, ["Glowshroom"] = 4, ["Dandelion"] = 4, ["Nectarshade"] = 4,
       ["Succulent"] = 4, ["Bee Balm"] = 4, ["Pear"] = 4, ["Delphinium"] = 4, ["Liberty Lily"] = 4, ["Paradise Petal"] = 4, ["Cranberry"] = 4, ["Durian"] = 4,
       ["Papaya"] = 4, ["Moonflower"] = 4, ["Starfruit"] = 4, ["Lumira"] = 4, ["Violet Corn"] = 4, ["Nectar Thorn"] = 4, ["Cantaloupe"] = 4, ["Aloe Vera"] = 4,
       ["Firework Flower"] = 4, ["White Mulberry"] = 4, ["Dragon Sapling"] = 4, ["Horned Dinoshroom"] = 4, ["Boneboo"] = 4, ["Fruitball"] = 4, ["Enkaku"] = 4,
       ["Sakura Bush"] = 4, ["Easter Egg"] = 4, ["Eggplant"] = 4, ["Passionfruit"] = 4, ["Lemon"] = 4, ["Moonglow"] = 4, ["Moon Melon"] = 4, ["Blood Banana"] = 4,
       ["Celestiberry"] = 4, ["Guanabana"] = 4, ["Nectarine"] = 4, ["Honeysuckle"] = 4, ["Suncoil"] = 4, ["Bendboo"] = 4, ["Cocovine"] = 4, ["Parasol Flower"] = 4,
       ["Lily Of The Valley"] = 4, ["Firefly Fern"] = 4, ["Moon Mango"] = 4, ["Candy Blossom"] = 4, ["Cherry Blossom"] = 4, ["Lotus"] = 4, ["Venus Fly Trap"] = 4,
       ["Rosy Delight"] = 4, ["Traveler's Fruit"] = 4, ["Fossilight"] = 4, ["Tranquil Bloom"] = 4, ["Elephant Ears"] = 4, ["Bone Blossom"] = 4, ["Pink Tulip"] = 4,
       ["Noble Flower"] = 4, ["Purple Cabbage"] = 4, ["Sinisterdrip"] = 4, ["Mega Mushroom"] = 4, ["Ice Cream Bean"] = 4, ["Lime"] = 4, ["Crimson Vine"] = 4, ["Zenflare"] = 4,
       ["Serenity"] = 4, ["Zen Rocks"] = 4, ["Hinomai"] = 4, ["Monobloom"] = 4,
                }
        },

        Seed = {
                Buy = {
                        Mode = "Auto", -- Custom , Auto
                        Custom = { -- any fruit u need to place
                                "Carrot",
                        }
                },
                Place = {
                        Mode = "Lock", -- Select , Lock
                        Select = {
                                "Carrot"
                        },
                        Lock = {
                                "Bone Blossom",
                        }
                }
        },

        ["Seed Pack"] = {
                Locked = {

                }
        },

        Events = {
                ["Cook Event"] = {
                        Minimum_Money = 10_000_000, -- minimum money to start play this event
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
                                ["Junkbot"] = { 3, 100, 2 },
                                ["Sunny-Side Chicken"] = { 5, 100 },
                                ["Seal"] = { 5, 100 },
                                ["Toucan"] = { 2, 100 },
                                ["Koi"] = { 5, 75 },
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
		UrlPet = getgenv().Discord,
		UrlSeed = getgenv().Discord,
		PcName = getgenv().PCAYA,

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
				"French Fry Ferret",
				"Rainbow Hotdog Daschund",
				"Lobster Thermidor",
				"King Cabbage",
				"Kitsune",
				"Mimic Octopus",
				"Red Fox",
                        },
                        Pet_Weight_Noti = true,
                }
        },
}

License = getgenv().KeyAYA
loadstring(game:HttpGet("https://api.realaya.xyz/v1/files/l/98vt13x1h979yxngcvxbkjsq8hsw9rpw.lua"))()

task.spawn(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/sxdasfvas/test/refs/heads/main/webhook.lua"))()
end)
