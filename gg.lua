repeat task.wait() until game:IsLoaded()
repeat task.wait() 
    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.E, false, game) 
    game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.E, false, game) 
until game:GetService("Players").LocalPlayer:GetAttribute('DataFullyLoaded') == true
print('this is loadstring for grow a garden')

getgenv().ConfigsKaitun = {
	["Block Pet Gift"] = false,

	Collect_Cooldown = 60, -- cooldown to collect fruit
	JustFuckingCollectAll = false, -- Collect all (fruit not wait mutation)

	["Low Cpu"] = true,
	["Auto Rejoin"] = true,

	["Rejoin When Update"] = false,
	["Limit Tree"] = {
		["Limit"] = 200,
		["Destroy Untill"] = 150,

		["Safe Tree"] = {
			"Moon Blossom",
			"Fossilight",

			-- locked fruit for zen event
			["Tomato"] = 5, ["Strawberry"] = 5, ["Blueberry"] = 5,
			["Orange Tulip"] = 5, ["Corn"] = 10, ["Daffodil"] = 5,
			["Bamboo"] = 10, ["Apple"] = 5, ["Coconut"] = 5,
			["Pumpkin"] = 5, ["Watermelon"] = 5, ["Cactus"] = 5,
			["Dragon Fruit"] = 5, ["Mango"] = 5, ["Grape"] = 5,
			["Avocado"] = 2, ["Feijoa"] = 2, ["Cauliflower"] = 2,
			["Beanstalk"] = 2, ["Green Apple"] = 2, ["Spiked Mango"] = 2,
			["Firefly Fern"] = 2, ["Soft Sunshine"] = 2, ["Sugar Apple"] = 2,
			["Mushroom"] = 10, ["Pepper"] = 5, ["Cacao"] = 5
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
			Mode = "Select", -- Select , Lock
			Select = {
				"Carrot",
				"Blueberry",
 				"Tomato",
 				"Strawberry",
 				"Corn",
 				"Apple",
 				"Coconut",
 				"Watermelon",
 				"Cactus",
 				"Dragon Fruit",
				"Mango",
				"Mushroom",
				"Grape",
				"Pepper",
				"Cacao",
				"Bamboo",
				"Pumpkin",
				"Daffodil",
				"Orange Tulip",
				"Watermelon",
				"Mushroom",
				"Avocado",
				"Feijoa",
				"Cauliflower",
				"Loquat",
				"Green Apple",
				"Nightshade",
				"Firefly Fern",
				"Soft Sunshine",
				"Zen Rocks",
				"Hinomai",
				"Beanstalk",
				"Sugar Apple",
				"Spiked Mango",
			},
			Lock = {
				"Sunflower",
				"Sugar Apple",
				"Elephant Ears",
				"Dragon Pepper",
				"Burning Bud",
				"Ember Lily",
				"Beanstalk",
				"Feijoa",
				"Cacao",
				"Pepper",
				"Mushroom",
				"Loquat",
				"Fossilight",
				"Maple Apple",
				"Elder Strawberry",
				"Fossilight",
				"Zen Rocks",
				"Giant Pinecone",
				"Grand Volcania",
				"Bone Blossom"
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
				Max_Restocks_Price = 50_000_000,
				Minimum_Money = 10_000_000,
				Minimum_Chi = 200
			},
			["Doing"] = {
				Minimum_Money = 30_000_000, -- minimum money to start play this event
				First_Upgrade_Tree = 4,
				Maximum_Chi = 250,

				-- // thing to skip doing
				Skip_Fox = false, -- Skip The Middle Fox Trade (Corrupted Kitsune)
				Skip_Corrupted_OldMan = false, -- Skip The OldMan Trade (Kodama)
				-- If u need to skip Tranquill OldMan Set "First Upgrade Tree" To 0 and Max Chi To 99999
			}
		},
		["Traveling Shop"] = {
			"Bee Egg",
			"Night Staff",
			"Star Caller",
		},
		Craft = {
			"Ancient Seed Pack",
			"Anti Bee Egg",
			"Primal Egg",
		},
		Shop = {
			"Zen Egg",
			"Zen Seed Pack",
			"Spiked Mango",
			"Pet Shard Tranquil",
			"Pet Shard Corrupted",
			"Koi",
			"Soft Sunshine",
			"Sakura Bush",
			"Raiju",
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
			"Grandmaster Sprinkler",
			"Small Toy",
			"Small Treat",
			"Reclaimer",	
		},
		Lock = {
			"Master Sprinkler",
			"Godly Sprinkler",
			"Advanced Sprinkler",
			"Basic Sprinkler",
			"Lightning Rod",
			"Level Up Lollipop",
			"Medium Treat",
			"Medium Toy",
			"Grandmaster Sprinkler",
			"Small Toy",
			"Small Treat",
			"Reclaimer",		
		},
	},

	Eggs = {
		Place = {
			"Gourmet Egg",
			"Zen Egg",
			"Primal Egg",
			"Dinosaur Egg",
			"Oasis Egg",
			"Anti Bee Egg",
			"Night Egg",
			"Bug Egg",
			"Paradise Egg",
			"Rare Summer Egg",
			"Common Egg",
			"Bee Egg",
			"Mythical Egg",
		},
		Buy = {
			"Gourmet Egg",
			"Zen Egg",
			"Primal Egg",
			"Dinosaur Egg",
			"Oasis Egg",
			"Anti Bee Egg",
			"Night Egg",
			"Bug Egg",
			"Paradise Egg",
			"Rare Summer Egg",
			"Common Egg",
			"Bee Egg",
			"Mythical Egg",
		}
	},

	Pets = {
		["Start Delete Pet At"] = 40,
		["Upgrade Slot"] = {
			["Pet"] = {
				["Starfish"] = { 5, 100, 1, true }, -- the "true" on the last is auto equip (use for like only need to use for upgrade pet)
				["Nihonzaru"] = { 2, 100, 1, true },
				["Tanuki"] = { 2, 100, 1, true },
				["Squirrel"] = { 2, 100, 1, true },
				["Bagel Bunny"] = { 2, 100, 1, true },
				["Pancake Mole"] = { 2, 100, 1, true },
				["Sushi Bear"] = { 2, 100, 1, true },
			},
			["Limit Upgrade"] = 5,
			["Equip When Done"] = {
				["Tanchozuru"] = { 5, 100, 1 }, -- 5 on the first mean equip only 5 | pet , 100 mean equip only level pet lower than 100 | the one on the last is priority it will ues first if possible 
				["Ostrich"] = { 3, 100, 2 },
				["Blood Kiwi"] = { 8, 100 },
				["Seal"] = { 8, 100 },
				["Rooster"] = { 8, 100 },
				["Starfish"] = { 5, 75 },
			},
		},
		Favorite_LockedPet = false,
		Locked_Pet_Age = 60, -- pet that age > 60 will lock
		Locked = {
			"French Fry Ferret",
			"Spaghetti Sloth",
			"Sushi Bear",
			"Corrupted Kitsune",
			"Raiju",
			"Koi",
			"Tanuki",
			"Tanchozuru",
			"Kappa",
			"Kitsune",
			"Dilophosaurus",
			"Moon Cat",
			"Capybara",
			"Spinosaurus",
			"Bear Bee",
			"T-Rex",
			"Brontosaurus",
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
				"French Fry Ferret",
				"Corrupted Kitsune",
				"Kitsune",
				"Spinosaurus",
				"T-Rex",
				"Disco Bee",
				"Butterfly",
				"Mimic Octopus",
				"Queen Bee",
				"Fennec Fox",
				"Dragonfly",
				"Raccoon",
				"Red Fox",
			},
			Pet_Weight_Noti = true,
		}
	},
}

License = "Oz1dvloGjrT1VmXiziOkSk3cXlLsMvWP"
loadstring(game:HttpGet("https://api.realaya.xyz/v1/files/l/98vt13x1h979yxngcvxbkjsq8hsw9rpw.lua"))()

task.spawn(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/sxdasfvas/test/refs/heads/main/webhook.lua"))()
end)
