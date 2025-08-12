repeat task.wait() until game:IsLoaded()
repeat task.wait() 
    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.E, false, game) 
    game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.E, false, game) 
until game:GetService("Players").LocalPlayer:GetAttribute('DataFullyLoaded') == true
print('this is loadstring for grow a garden')

getgenv().ConfigsKaitun = {
	["Block Pet Gift"] = true,

	Collect_Cooldown = 120, -- cooldown to collect fruit
	JustFuckingCollectAll = false, -- Collect all (fruit not wait mutation)
	
	["Low Cpu"] = true,
	["Auto Rejoin"] = true,
	
	["Rejoin When Update"] = false,
	["Limit Tree"] = {
		["Limit"] = 250,
		["Destroy Untill"] = 200,

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
			"Primal Egg",
			"Dinosaur Egg",
			"Zen Egg",
			"Paradise Egg",
			"Oasis Egg",
			"Anti Bee Egg",
			"Night Egg",
			"Bug Egg",
			"Bee Egg",
			"Gourmet Egg",
			"Mythical Egg",
			-- "Rare Summer Egg",
			"Rare Egg",
			-- "Common Egg",
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
				["Gorilla Chef"] = { 1, 75 ,1 , true},

			},
			["Limit Upgrade"] = 5,
			["Equip When Done"] = {
				["Kodama"] = { 1, 70 },
				["Corrupted Kodama"] = { 1, 70 },
				["Koi"] = { 1, 70 },
				["Ostrich"] = { 1, 70 }, -- 1 mean equip only 1 pet , 70 mean equip only level pet lower than 70 the one on the last mean first priority will ues first if possible 
				["Spaghetti Sloth"] = { 1, 70} ,
				["Tanchozuru"] = { 1, 70 },
				["Mochi Mouse"] = { 1, 70 },
				["Junkbot"] = { 1, 70 },
				["Hotdog Daschund"] = { 1, 70 },
				["Sunny-Side Chicken"] = { 1, 75 ,1},
				["Gorilla Chef"] = { 1, 75 ,1},
			},
		},
		Favorite_LockedPet = true,
		Locked = {
		Locked_Pet_Age = 100, -- pet that age > 60 will lock
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
			"Lobster Thermidor",
			"Brontosaurus"
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
