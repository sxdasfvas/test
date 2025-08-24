repeat task.wait(10) until game:IsLoaded()
getgenv().ConfigsKaitun = {
	["Block Pet Gift"] = true,
	Beta_Fix_Data_Sync = false,
	Collect_Cooldown = 60, -- cooldown to collect fruit
	JustFuckingCollectAll = true, -- Collect all (fruit not wait mutation)

	["Low Cpu"] = true,
	["Auto Rejoin"] = false,
	["Rejoin When Update"] = false,

	["Limit Tree"] = {
		["Limit"] = 300,
		["Destroy Untill"] = 280,

		["Safe Tree"] = {
            "Moon Blossom",
            "Maple Apple",
            "Dragon Pepper",
            "Princess Thorn",
			"Cyclamen",
			-- for the event
            ["Blueberry"] = 15,
            ["Strawberry"] = 15,
            ["Apple"] = 15,
            ["Coconut"] = 15,
            ["Dragon Fruit"] = 15,
            ["Mango"] = 15,
            ["Tomato"] = 15,
            ["Cactus"] = 15,
			["Carrot"] = 3, ["Rose"] = 3, ["Orange Tulip"] = 3, ["Dezen"] = 3, ["Artichoke"] = 3,
			["Onion"] = 3, ["Daffodil"] = 3, ["Cauliflower"] = 3, ["Raspberry"] = 3, ["Foxglove"] = 3, ["Corn"] = 3,
			["Horsetail"] = 3, ["Twisted Tangle"] = 3, ["Jalapeno"] = 3, ["Watermelon"] = 3, ["Pumpkin"] = 3, ["Avocado"] = 3, ["Green Apple"] = 3,
			["Banana"] = 3, ["Lilac"] = 3, ["Taro Flower"] = 3, ["Bamboo"] = 3, ["Rafflesia"] = 3, ["Lingonberry"] = 3,["Lucky Bamboo"] = 3, ["Veinpetal"] = 3, ["Crown Melon"] = 3, ["Peach"] = 3, ["Pineapple"] = 3, ["Amber Spine"] = 3,
			["Kiwi"] = 3, ["Bell Pepper"] = 3, ["Prickly Pear"] = 3, ["Pink Lily"] = 3,
			["Purple Dahlia"] = 3, ["Tall Asparagus"] = 3, ["Sugarglaze"] = 3, ["Grape"] = 3, ["Loquat"] = 3, ["Mushroom"] = 3, ["Pepper"] = 3,
			["Cacao"] = 3, ["Feijoa"] = 3, ["Pitcher Plant"] = 3, ["Grand Volcania"] = 3, ["Sunflower"] = 3, ["Grand Tomato"] = 3, ["Taco Fern"] = 3,
			["Beanstalk"] = 3, ["Ember Lily"] = 3, ["Sugar Apple"] = 3, ["Burning Bud"] = 3, ["Giant Pinecone"] = 3, ["Elder Strawberry"] = 3, ["Chocolate Carrot"] = 3,
			["Red Lollipop"] = 3, ["Nightshade"] = 3, ["Crocus"] = 3, ["Lavender"] = 3, ["Manuka Flower"] = 3, ["Wild Carrot"] = 3, ["Stonebite"] = 3,
			["Candy Sunflower"] = 3, ["Peace Lily"] = 3, ["Mint"] = 3, ["Blue Lollipop"] = 3, ["Glowshroom"] = 3, ["Dandelion"] = 3, ["Nectarshade"] = 3,["Succulent"] = 3,
			["Bee Balm"] = 3, ["Pear"] = 3, ["Delphinium"] = 3, ["Liberty Lily"] = 3, ["Paradise Petal"] = 3, ["Cranberry"] = 3, ["Durian"] = 3,["Papaya"] = 3, ["Moonflower"] = 3,
			["Starfruit"] = 3, ["Lumira"] = 3, ["Violet Corn"] = 3, ["Nectar Thorn"] = 3, ["Cantaloupe"] = 3, ["Aloe Vera"] = 3,["Firework Flower"] = 3, ["White Mulberry"] = 3, ["Dragon Sapling"] = 3,
			["Horned Dinoshroom"] = 3, ["Boneboo"] = 3, ["Fruitball"] = 3, ["Enkaku"] = 3,["Sakura Bush"] = 3, ["Easter Egg"] = 3, ["Eggplant"] = 3, ["Passionfruit"] = 3, ["Lemon"] = 3, ["Moonglow"] = 3, ["Moon Melon"] = 3, ["Blood Banana"] = 3,
			["Celestiberry"] = 3, ["Guanabana"] = 3, ["Nectarine"] = 3, ["Honeysuckle"] = 3, ["Suncoil"] = 3, ["Bendboo"] = 3, ["Cocovine"] = 3, ["Parasol Flower"] = 3,
			["Lily Of The Valley"] = 3, ["Firefly Fern"] = 3, ["Moon Mango"] = 3, ["Candy Blossom"] = 3, ["Cherry Blossom"] = 3, ["Lotus"] = 3, ["Venus Fly Trap"] = 3,
			["Rosy Delight"] = 3, ["Traveler's Fruit"] = 3, ["Fossilight"] = 3, ["Tranquil Bloom"] = 3, ["Elephant Ears"] = 3, ["Bone Blossom"] = 3, ["Pink Tulip"] = 3,
			["Noble Flower"] = 3, ["Purple Cabbage"] = 3, ["Sinisterdrip"] = 3, ["Mega Mushroom"] = 3, ["Ice Cream Bean"] = 3, ["Lime"] = 3, ["Crimson Vine"] = 3, ["Zenflare"] = 3,
			["Serenity"] = 3, ["Zen Rocks"] = 3, ["Hinomai"] = 3, ["Monobloom"] = 3,
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
				"Maple Apple",
				"Sunflower",
				"Dragon Pepper",
				"Elephant Ears",
				"Moon Melon",
				"Easter Egg",
				"Moon Mango",
				"Bone Blossom",
				"Fossilight",
			}
		}
	},

	["Seed Pack"] = { Locked = { } },


	Events = {
		["Bean Event"] = {
			Minimum_Money = 10_000_000, -- minimum money to start play this event
		},
		MaxMoney_Restocks = 10_000_000,
		Shop = { -- un comment to buy
			"Sprout Seed Pack",
			"Sprout Egg",
			-- "Mandrake",
			"Silver Fertilizer",
			-- "Canary Melon",
			-- "Amberheart",
			-- ["Spriggan"] = 8,
			-- Friend Shop
			"Skyroot Chest",
			"Pet Shard GiantBean",
		},
		["Traveling Shop"] = {
			"Bee Egg", "Paradise Egg", "Loquat", "Feijoa", "Pitcher Plant"
		},
		Craft = {
			"Anti Bee Egg",
			"Pet Shard GiantBean",
			"Sprout Egg",
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
						-- "Trading Ticket",
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
                        "Sprout Egg", "Rare Summer Egg", "Paradise Egg", "Gourmet Egg", "Common Summer Egg", "Zen Egg", "Oasis Egg", "Night Egg", "Anti Bee Egg", "Bug Egg", "Primal Egg", "Dinosaur Egg",
						-- "Mythical Egg", 
                },
                Buy = {
                        "Bug Egg", "Bee Egg", "Paradise Egg", "Mythical Egg", "Rare Summer Egg", "Common Summer Egg", "Rare Egg",
                }
        },

        Pets = {
				["Auto Feed"] = true,
                ["Start Delete Pet At"] = 55,
                ["Upgrade Slot"] = {
                        ["Pet"] = {
                                ["Starfish"] = { 5, 100, 1, true }, -- the "true" on the last is auto equip (use for like only need to use for upgrade pet)
                        },
                        ["Limit Upgrade"] = 5, -- max is 5 (more than or lower than 1 will do nothing)
                        ["Equip When Done"] = {
                                --["Spaghetti Sloth"] = { 5, 100, 1 }, -- 5 on the first mean equip only 5 | pet , 100 mean equip only level pet lower than 100 | the one on the last is priority it will ues first if possible 
                                --["Junkbot"] = { 1, 100, 2 },
                                ["Sunny-Side Chicken"] = { 2, 100, 2 },
                                ["Seal"] = { 8, 100, 1 },
                                -- ["Toucan"] = { 1, 100 },
                                ["Koi"] = { 8, 100, 3 },
								["Peach Wasp"] = { 1, 100, 5 },
                                ["Green Bean"] = { 1, 100, 4 },
								["Wasp"] = { 1, 100 },
								["Tarantula Hawk"] = { 1, 100 },
								--["French Fry Ferret"] = { 5, 75, 3 },
                        },
                },
				Unfavorite_AllPet = false,
                Favorite_LockedPet = true,
                Locked_Pet_Age = 75, -- pet that age > 60 will lock
                Locked = {
                     "Griffin", "Peach Wasp", "Apple Gazelle", "Green Bean", "Lemon Lion", "Golden Goose", "Kitsune", "Corrupted Kitsune", "French Fry Ferret", "Lobster Thermidor",
                     "T-Rex", "Spinosaurus", "Fennec Fox", "Mimic Octopus", "Disco Bee",
                     "Butterfly", "Raccoon", "Queen Bee", "Dragonfly", "Red Fox",
                     "Ankylosaurus", "Dilophosaurus", "Brontosaurus", "Hyacinth Macaw",
                     "Moth", "Moon Cat",
                     "Night Owl", "Blood Owl", "Blood Kiwi", "Cooked Owl", "Pterodactyl", "Chicken Zombie",
                     "Raiju", ["Spaghetti Sloth"] =4, "Wasp", "Tarantula Hawk",
                     "Axolotl", "Echo Frog", "Hamster", ["Maneki-neko"] = 2, ["Squirrel"] = 2, ["Hotdog Daschund"] = 2, ["Sunny-Side Chicken"] =2 , ["Gorilla Chef"] = 3,
                     ["Sushi Bear"] = 1, ["Mochi Mouse"] = 1, ["Koi"] = 2, ["Flamingo"] = 5, ["Bacon Pig"] = 1, ["Junkbot"] = 1,
                     ["Starfish"] = 3, ["Kodama"] = 2, ["Kappa"] = 1, ["Tanchozuru"] = 2,
                     ["Praying Mantis"] = 1,
                     ["Toucan"] = 1, ["Capybara"] = 2, ["Rooster"] = 2, ["Seal"] = 2, ["Chicken"] = 2,
					 ["Bagel Bunny"] = 2, ["Peacock"] = 3, ["Ostrich"] = 2, ["Orange Tabby"] = 2, ["Sea Turtle"] = 3, ["Scarlet Macaw"] = 2
                },
                LockPet_Weight = 8, -- if Weight >= 10 they will locked
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
                                 "Lobster Thermidor",
                                 "French Fry Ferret",
                        },
                        Pet_Weight_Noti = false,
                }
        },
}

License = getgenv().KeyAYA
loadstring(game:HttpGet('https://raw.githubusercontent.com/Real-Aya/Loader/main/Init.lua'))()
