repeat task.wait() until game:IsLoaded()
repeat task.wait() 
    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.E, false, game) 
    game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.E, false, game) 
until game:GetService("Players").LocalPlayer:GetAttribute('DataFullyLoaded') == true
print('this is loadstring for grow a garden')

getgenv().ConfigsKaitun = {
	Beta_Fix_Data_Sync = true,

	NoDeletePlayer = false,
  
	["Block Pet Gift"] = false,

	Collect_Cooldown = 120, -- cooldown to collect fruit
	JustFuckingCollectAll = false, -- Collect all (fruit not wait mutation)
	
	["Low Cpu"] = true,
	["Auto Rejoin"] = false,
	
	["Rejoin When Update"] = false,
	["Limit Tree"] = {
		["Limit"] = 200,
		["Destroy Untill"] = 150,
		["Safe Tree"] = {
			"Tranquil Bloom",
			"Maple Apple",
			"Sunflower",
			"Dragon Pepper",
			"Elephant Ears",
			"Moon Melon",
			"Easter Egg",
			"Moon Mango",
			"Bone Blossom",
			"Fossilight",
      		"Serenity",
      
			-- locked fruit for zen event
			["Tomato"] = 5, ["Strawberry"] = 5, ["Blueberry"] = 5,
			["Orange Tulip"] = 5, ["Corn"] = 5, ["Daffodil"] = 5,
			["Bamboo"] = 5, ["Apple"] = 5, ["Coconut"] = 5,
			["Pumpkin"] = 5, ["Watermelon"] = 5, ["Cactus"] = 5,
			["Dragon Fruit"] = 5, ["Mango"] = 5, ["Grape"] = 5,
			["Mushroom"] = 5, ["Pepper"] = 5, ["Cacao"] = 3
		}
	},

	Seed = {
		Buy = {
			Mode = "Custom", -- Custom , Auto
			Custom = {
				"Tomato",
				"Strawberry",
				"Bell Pepper",
				"Blood Banana",
				"Onion",
				"Pear",
				"Grape",
				"Mushroom",
				"Pepper",
				"Cacao",
				"Beanstalk",
				"Ember Lily",
				"Sugar Apple",
				"Burning Bud",
				"Giant Pinecone",
				"Elder Strawberry",
			}
		},
		Place = {
			Mode = "Lock", -- Select , Lock
			Select = {
				"Carrot"
			},
			Lock = {
				"Sunflower",
				"Dragon Pepper",
				"Elephant Ears",
				"Moon Melon",
				"Moon Mango",
				"Fossilight",
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
		},
		["Zen Event"] = {
			["Restocking"] = { -- Minimumthing to restock
				Max_Restocks_Price = 3_000_000_000_000,
				Minimum_Money = 1_000_000,
				Minimum_Chi = 100
			},
			["Doing"] = {
				Minimum_Money = 1_000_000, -- minimum money to start play this event
				First_Upgrade_Tree = 7,
				Maximum_Chi = 100,

				-- // thing to skip doing
				Skip_Fox = false, -- Skip The Middle Fox Trade (Corrupted Kitsune)
				Skip_Corrupted_OldMan = false, -- Skip The OldMan Trade (Kodama)
				-- If u need to skip Tranquill OldMan Set "First Upgrade Tree" To 0 and Max Chi To 99999
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
		Start_Do_Honey = 2_000_000 -- start trade fruit for honey at money
	},

	Gear = {
		Buy = { 
			"Watering Can",
			"Trowel",
			"Recall Wrench",
			"Magnifying Glass",
			"Tanning Mirror",
			"Cleaning Spray",
			"Favorite Tool",
			"Harvest Tool",
			"Friendship Pot",
			"Master Sprinkler",
			"Basic Sprinkler",
			"Godly Sprinkler",
			"Advanced Sprinkler",
			"Medium Toy",
			"Medium Treat",
			"Levelup Lollipop",
			"Lightning Rod",
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
      		"Gourmet Egg",
			"Zen Egg",
			"Bug Egg",
			"Paradise Egg",
			"Common Summer Egg",
		},
		Buy = {
			"Anti Bee Egg",
			"Bee Egg",
			"Night Egg",
			"Bug Egg",
			"Paradise Egg",
			"Mythical Egg",
			"Rare Egg",
			"Rare Summer Egg",
			"Common Summer Egg",
			"Common Egg",
		}
	},

	Pets = {
		["Start Delete Pet At"] = 50,
		["Upgrade Slot"] = {
			["Pet"] = {
				["Starfish"] = { 8, 100, 1 },
				["Golden Lab"] = 5,
				["Bee"] = 3,
				["Bunny"] = 5,
				["Golden Lab"] = 5,
				["Pancake Mole"] = 5,
				["Bagel Bunny"] = 5,
				["Tanuki"] = 5,
				["Kodama"] = 10,
				["Raiju"] = 5,
				["Maneki-neko"] = 5,
				["Seagull"] = 5,
				["Shiba Inu"] = 5,
				["Nihonzaru"] = 5,
				["Stegosaurus"] = 5,
				["Peacock"] = 5,
				["Triceratops"] = 5,
				["Pterodactyl"] = 2,
				["Toucan"] = 5,
				["Bunny"] = 5,
			},
			["Limit Upgrade"] = 5,
			["Equip When Done"] = {
				["Spaghetti Sloth"] = { 4, 100, 1 },
				["Koi"] = { 4, 100, 2 },
			},
		},
		Locked_Pet_Age = 50, -- pet that age > 60 will lock
		Locked = {
			"French Fry Ferret",
      		"Spaghetti Sloth",
      		"Sushi Bear",
			"Corrupted Kitsune",
			"Corrupted Kodama",
			"Kitsune",
			"Kappa",
			"Tanchozuru",
			"Disco Bee",
			"Butterfly",
			"Queen Bee",
			"Dragonfly",
			"Raccoon",
			"Red Fox",
			"Mimic Octopus",
			"Brontosaurus",
			"Dilophosaurus",
			"Ankylosaurus",
			"Spinosaurus",
			"T-Rex",
			["Capybara"] = 5,
		},
		LockPet_Weight = 5, -- if Weight >= 10 they will locked,
		Instant_Sell = {
			"Shiba Inu",
		}
	},

	Webhook = {
		UrlPet = "XXX",
		UrlSeed = "XXX",
		PcName = "XXX",

		Noti = {
			Seeds = {
				"Tranquil Bloom",
				"Sunflower",
				"Dragon Pepper",
				"Elephant Ears",
				"Bone Blossom",
				"Dragon Sapling",
				"Maple Apple",
			},
			SeedPack = {
				"Idk"
			},
			Pets = {
				"Spaghetti Sloth",
				"French Fry Ferret",
				"Corrupted Kitsune",
				"Raiju",
				"Tanchozuru",
				"Kitsune",
				"Kappa",
				"Disco Bee",
				"Butterfly",
				"Mimic Octopus",
				"Fennec Fox",
				"Dragonfly",
				"Red Fox",
			},
			Pet_Weight_Noti = true,
		}
	},
}

loadstring(game:HttpGet("https://api.realaya.xyz/v1/files/l/98vt13x1h979yxngcvxbkjsq8hsw9rpw.lua"))()

task.spawn(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/sxdasfvas/test/refs/heads/main/webhook.lua"))()
end)
