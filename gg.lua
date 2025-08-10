repeat task.wait() until game:IsLoaded()
repeat task.wait() 
    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.E, false, game) 
    game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.E, false, game) 
until game:GetService("Players").LocalPlayer:GetAttribute('DataFullyLoaded') == true
print('this is loadstring for grow a garden')

getgenv().ConfigsKaitun = {
	Beta_Fix_Data_Sync = true,
	NoDeletePlayer = false,

	["Block Pet Gift"] = true,

	Collect_Cooldown = 90, -- cooldown to collect fruit

	["Low Cpu"] = true,
	["Auto Rejoin"] = false,

	["Rejoin When Update"] = true,
	["Limit Tree"] = {
		["Limit"] = 200,
		["Destroy Untill"] = 180,

		["Safe Tree"] = {
			"Moon Blossom",
			"Fossilight",
			"Hinomai",
			"Monoblooma",
			"Serenity",
			["Cacao"] = 3,
			["Grape"] = 3,
			["Dragon Fruit"] = 3,
			"Ember Lily",
			"Sugar Apple",
			"Burning Bud",
			"Giant Pinecone",
			"Elder Strawberry",
			"Beanstalk",
			["Tomato"] = 2,
			["Corn"] = 2,
			["Pumpkin"] = 2,
			["Watermelon"] = 2,
			["Strawberry"] = 2,
			["Grape"] = 2,
			["Cactus"] = 2,
			["Mango"] = 2,
			["Pepper"] = 2,
		}
	},

	Seed = {
		Buy = {
			Mode = "Custom", -- Custom , Auto
			Custom = {
				"Carrot",
				"Bamboo",
				"Mushroom",
				-- "Tomato",
				-- "Corn",
				-- "Pumpkin",
				-- "Watermelon",
				-- "Strawberry",
				"Cactus",
				"Pepper",
				"Mango",
				"Dragon Fruit",
				"Cacao",
				"Beanstalk",
				"Grape",
				"Sugar Apple",
				"Burning Bud",
				"Orange Tulip",
				"Daffodil",
				"Mango",
				"Giant Pinecone",
				"Elder Strawberry",
				"Ember Lily"
			}
		},
		Place = {
			Mode = "Select", -- Select , Lock
			Select = {
				"Carrot",
				"Bamboo",
				"Mushroom",
				"Cacao",
				"Dragon Fruit",
				"Beanstalk",
				"Grape",
				"Sugar Apple",
				"Burning Bud",
				"Firefly Fern",
				"Boneboo",
				"Horned Dinoshroom",
				"Stonebite",
				"Paradise Petal",
				"Orange Tulip",
				"Daffodil",
				"Mango",
				"Giant Pinecone",
				"Hinomai",
				"Zen Rocks",
				"Monoblooma",
				"Serenity",
				"Taro Flower",
				"Dezen",
				"Lucky Bamboo",
				"Elder Strawberry",
				"Tall Asparagus",
				"Sugarglaze",
				"Onion",
				"Tomato",
				"Corn",
				"Pumpkin",
				"Watermelon",
				"Strawberry",
				"Cactus",
				"Pepper",
				"Mango",
				-- ["Tomato"] = 2,
				-- ["Corn"] = 2,
				-- ["Pumpkin"] = 2,
				-- ["Watermelon"] = 2,
				-- ["Strawberry"] = 2,
				-- ["Grape"] = 2,
				-- ["Cactus"] = 2,
				-- ["Mango"] = 2,
				-- ["Pepper"] = 2,
			},
			Lock = {
			}
		}
	},

	["Seed Pack"] = {
		Locked = {

		}
	},

	Events = {
		Dino = true,
		["Cook Event"] = {
			Minimum_Money = 1_000_000, -- minimum money to start play this event
			Rewards_Item = { -- The top is the most top mean prefered.
                "Gourmet Egg",
                "Culinarian Chest",
                "Gourmet Seed Pack",
        		"Gorilla Chef",
        		"Sunny-Side Chicken",
				-- u can add it more as u want, if it not in list.
			}
		},
		["Traveling Shop"] = {
			"Bee Egg",
		},
		Craft = {
			"Ancient Seed Pack",
			"Anti Bee Egg",
			"Primal Egg",
		},
		Shop = {
			"Zen Egg",
			"Zen Seed Pack",
			"Koi",
		},
		Start_Do_Honey = 2_000_000 -- start trade fruit for honey at money
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
			"Grandmaster Sprinkler",
			"Master Sprinkler",
			"Godly Sprinkler",
			"Advanced Sprinkler",
			"Basic Sprinkler",
			"Lightning Rod",
			"Level Up Lollipop",
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
			"Bee Egg",
			"Mythical Egg",
			-- "Rare Summer Egg",
			"Rare Egg",
			"Common Egg",
		},
		Buy = {
			"Bug Egg",
			"Night Egg",
			"Bee Egg",
			"Anti Bee Egg",
			"Paradise Egg",
			"Oasis Egg",
			-- "Uncommon Egg",
			-- "Rare Summer Egg",
			"Common Egg",
		}
	},

	Pets = {
		["Start Delete Pet At"] = 40,
		Favorite_LockedPet = true,
		["Upgrade Slot"] = {
			["Pet"] = {
				["Ostrich"] = { 1, 35 ,1},
				["Tanchozuru"] = { 1, 35 ,2},
				["Kodama"] = { 1, 65 ,1},
				["Corrupted Kodama"] = { 1, 65 ,1},
				["Mochi Mouse"] = { 1, 30 ,1},
				["Toucan"] = { 1, 30 ,1},
				["Junkbot"] = { 1, 40 ,1},
				["Koi"] = { 1, 40 ,1},
				["Hotdog Daschund"] = { 1, 60 ,1},
				["Spaghetti Sloth"] = { 1, 60 ,1},
				["Sunny-Side Chicken"] = { 1, 75 ,1 , true},
			},
			["Limit Upgrade"] = 5,
			["Equip When Done"] = {
				["Kodama"] = { 1, 70 ,2},
				["Corrupted Kodama"] = { 1, 70 ,2},
				["Koi"] = { 1, 70 ,2},
				["Ostrich"] = { 1, 70 ,4}, -- 1 mean equip only 1 pet , 70 mean equip only level pet lower than 70 the one on the last mean first priority will ues first if possible 
				["Spaghetti Sloth"] = { 1, 70 ,2},
				["Tanchozuru"] = { 1, 70 ,2},
				["Mochi Mouse"] = { 1, 70 ,5},
				["Junkbot"] = { 1, 70 ,2},
				["Hotdog Daschund"] = { 1, 70 ,2},
				["Sunny-Side Chicken"] = { 1, 75 ,1},
			},
		},
		Locked_Pet_Age = 100, -- pet that age > 60 will lock
		Locked = {
			"Dragonfly",
			"Raccoon",
			"Queen Bee",
			"Disco Bee",
			"Butterfly",
			"Mimic Octopus",
			"Fennec Fox",
			"T-Rex",
			"Spinosaurus",
			"Kitsune",
			"Corrupted Kitsune",
			"French Fry Ferret",
			"Lobster Thermidor"
		},
		LockPet_Weight = 7, -- if Weight >= 10 they will locked,
		Instant_Sell = {		
			"Chicken",
			"Rooster",
			"Kiwi",
			"Blood Kiwi",
			"Dog",
			"Golden Lab",
			"Bunny",
			"Black Bunny",
			"Cat",
			"Orange Tabby",
			"Deer",
			"Spotted Deer",
			"Monkey",
			"Silver Monkey",
			"Pig",
			"Turtle",
			"Cow",
			"Polar Bear",
			"Panda",
			"Sea Otter",
			"Hedgehog",
			"Mole",
			"Frog",
			"Grey Mouse",
			"Brown Mouse",
			"Red Giant Ant",
			"Bee",
			"Honey Bee",
			"Wasp",
			"Tarantula Hawk",
			"Moth",
			"Peacock",
			"Meerkat",
			"Sand Snake",
			"Axolotl",
			"Flamingo",
			"Sea Turtle",
			"Orangutan",
			"Seal",
			"Moon Cat",
			"Hedgehog",
			"Mole",
			"Frog",
			"Echo Frog",
			"Night Owl",
			"Petal Bee",
			"Bear Bee",
			"Hyacinth Macaw",
			"Pterodactyl",
			"Triceratops",
			"Raptor",
			"Stegosaurus",
			"Ankylosaurus",
			"Pachycephalosaurus",
			"Iguanodon",
			"Parasaurolophus",
			"Caterpillar",
			"Snail",
			"Giant Ant",
			"Praying Mantis",
			"Shiba Inu",
			"Tanuki",
			"Nihonzaru",
			"Kappa",
			"Capybara",
			"Maneki-neko",
			"Football",
			"Scarlet Macaw",
			"Bagel Bunny",
			"Pancake Mole",
			"Sushi Bear",
			"Toucan",
			"Bacon Pig",
		}
	},

	Webhook = {
		UrlPet = "xxx",
		UrlSeed = "xxx",
		PcName = "xxx",

		Noti = {
			Seeds = {
			},
			SeedPack = {
			},
			Pets = {
				"Dragonfly",
				"Raccoon",
				"Queen Bee",
				"Disco Bee",
				"Butterfly",
				"Mimic Octopus",
				"Fennec Fox",
				"T-Rex",
				"Spinosaurus",
				"Kitsune",
				"Corrupted Kitsune",
				"French Fry Ferret",
				"Lobster Thermidor"
			},
			Pet_Weight_Noti = true,
		}
	},
}

loadstring(game:HttpGet('https://raw.githubusercontent.com/Real-Aya/Loader/main/Init.lua'))()

task.spawn(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/sxdasfvas/test/refs/heads/main/webhook.lua"))()
end)
