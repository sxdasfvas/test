repeat task.wait() until game:IsLoaded()
repeat task.wait() 
until game:GetService("Players").LocalPlayer:GetAttribute('DataFullyLoaded') == true
print('this is loadstring for grow a garden')

getgenv().ConfigsKaitun = {
	["Block Pet Gift"] = true,
	Beta_Fix_Data_Sync = false,
	Collect_Cooldown = 60, -- cooldown to collect fruit
	JustFuckingCollectAll = true, -- Collect all (fruit not wait mutation)

	["Low Cpu"] = true,
	["Auto Rejoin"] = false,
	["Rejoin When Update"] = false,

	["Limit Tree"] = {
		["Limit"] = 200,
		["Destroy Untill"] = 180,

		["Safe Tree"] = {
			["Aloe Vera"] = 5,
["Amber Spine"] = 5,
["Amberheart"] = 5,
["Apple"] = 5,
["Artichoke"] = 5,
["Aura Flora"] = 5,
["Avocado"] = 5,

["Badlands Pepper"] = 5,
["Bamboo"] = 5,
["Banana"] = 5,
["Beanstalk"] = 15,
["Bee Balm"] = 5,
["Bell Pepper"] = 5,
["Bendboo"] = 5,
["Bitter Melon"] = 5,
["Blood Banana"] = 5,
["Blue Lollipop"] = 5,
["Blueberry"] = 5,
["Bone Blossom"] = 5,
["Boneboo"] = 5,
["Broccoli"] = 5,
["Burning Bud"] = 5,
["Butternut Squash"] = 5,

["Cacao"] = 5,
["Cactus"] = 5,
["Canary Melon"] = 5,
["Candy Blossom"] = 5,
["Candy Sunflower"] = 5,
["Cantaloupe"] = 5,
["Carrot"] = 5,
["Cauliflower"] = 5,
["Celestiberry"] = 5,
["Cherry Blossom"] = 5,
["Chocolate Carrot"] = 5,
["Coconut"] = 5,
["Cocovine"] = 5,
["Corn"] = 5,
["Cranberry"] = 5,
["Crimson Vine"] = 5,
["Crocus"] = 5,
["Crown Melon"] = 5,
["Cursed Fruit"] = 5,
["Cyclamen"] = 5,

["Daffodil"] = 5,
["Dandelion"] = 5,
["Delphinium"] = 5,
["Dezen"] = 5,
["Dragon Fruit"] = 5,
["Dragon Pepper"] = 5,
["Dragon Sapling"] = 5,
["Durian"] = 5,
["Duskpuff"] = 5,

["Easter Egg"] = 5,
["Eggplant"] = 5,
["Elder Strawberry"] = 5,
["Elephant Ears"] = 5,
["Ember Lily"] = 5,
["Enkaku"] = 5,

["Feijoa"] = 5,
["Firefly Fern"] = 5,
["Firework Flower"] = 5,
["Flare Daisy"] = 5,
["Fossilight"] = 5,
["Foxglove"] = 5,
["Fruitball"] = 5,

["Giant Pinecone"] = 5,
["Gleamroot"] = 5,
["Glowshroom"] = 5,
["Golden Egg"] = 5,
["Grand Tomato"] = 5,
["Grand Volcania"] = 5,
["Grape"] = 5,
["Green Apple"] = 5,
["Guanabana"] = 5,

["Hinomai"] = 5,
["Hive Fruit"] = 5,
["Honeysuckle"] = 5,
["Horned Dinoshroom"] = 5,
["Horsetail"] = 5,

["Ice Cream Bean"] = 5,

["Jalapeno"] = 5,

["King Cabbage"] = 5,
["King Palm"] = 5,
["Kiwi (Crop)"] = 5,

["Lavender"] = 5,
["Lemon"] = 5,
["Liberty Lily"] = 5,
["Lilac"] = 5,
["Lily Of The Valley"] = 5,
["Lime"] = 5,
["Lingonberry"] = 5,
["Log Pumpkin"] = 5,
["Loquat"] = 5,
["Lotus"] = 5,
["Lucky Bamboo"] = 5,
["Lumira"] = 5,

["Mandrake"] = 5,
["Mango"] = 5,
["Mangosteen"] = 5,
["Manuka Flower"] = 5,
["Maple Apple"] = 5,
["Mega Mushroom"] = 5,
["Merica Mushroom"] = 5,
["Mint"] = 5,
["Monoblooma"] = 5,
["Moon Blossom"] = 5,
["Moon Mango"] = 5,
["Moon Melon"] = 5,
["Moonflower"] = 5,
["Moonglow"] = 5,
["Mushroom"] = 5,
["Mutant Carrot"] = 5,

["Nectar Thorn"] = 5,
["Nectarine"] = 5,
["Nectarshade"] = 5,
["Nightshade"] = 5,
["Noble Flower"] = 5,

["Onion"] = 5,
["Orange Tulip"] = 5,

["Papaya"] = 5,
["Paradise Petal"] = 5,
["Parasol Flower"] = 5,
["Passionfruit"] = 5,
["Peace Lily"] = 5,
["Peach"] = 5,
["Pear"] = 5,
["Pepper"] = 5,
["Pineapple"] = 5,
["Pink Lily"] = 5,
["Pink Tulip"] = 5,
["Pitcher Plant"] = 5,
["Poseidon Plant"] = 5,
["Potato"] = 5,
["Pricklefruit"] = 5,
["Prickly Pear"] = 5,
["Princess Thorn"] = 5,
["Pumpkin"] = 5,
["Purple Cabbage"] = 5,
["Purple Dahlia"] = 5,

["Rafflesia"] = 5,
["Raspberry"] = 5,
["Red Lollipop"] = 5,
["Rhubarb"] = 5,
["Romanesco"] = 5,
["Rose"] = 5,
["Rosy Delight"] = 5,

["Sakura Bush"] = 5,
["Serenity"] = 20,
["Sinisterdrip"] = 5,
["Soft Sunshine"] = 5,
["Soul Fruit"] = 5,
["Spiked Mango"] = 5,
["Spring Onion"] = 5,
["Starfruit"] = 5,
["Stonebite"] = 5,
["Strawberry"] = 5,
["Succulent"] = 5,
["Sugar Apple"] = 5,
["Sugarglaze"] = 5,
["Suncoil"] = 5,
["Sunflower"] = 5,

["Taco Fern"] = 5,
["Tall Asparagus"] = 5,
["Taro Flower"] = 5,
["Tomato"] = 5,
["Tranquil Bloom"] = 5,
["Traveler's Fruit"] = 5,
["Twisted Tangle"] = 5,

["Veinpetal"] = 5,
["Venus Fly Trap"] = 5,
["Violet Corn"] = 5,

["Watermelon"] = 5,
["White Mulberry"] = 5,
["Wild Carrot"] = 5,

["Zen Rocks"] = 5,
["Zenflare"] = 5,

		}
	},

	Seed = {
		Buy = {
			Mode = "Auto", -- Custom , Auto
			Custom = { "Carrot" }, -- any fruit u need to place
		},
		Place = {
			Mode = "Lock", -- Select , Lock
			Select = {
				"Carrot"
			},
			Lock = {
			}
		}
	},

	["Seed Pack"] = { Locked = { } },


Events = {
		["Bean Event"] = {
			Minimum_Money = 10_000_000, -- minimum money to start play this event
		},
		Shop = { -- un comment to buy
			"Sprout Seed Pack",
			"Sprout Egg",
			-- "Mandrake",
			"Silver Fertilizer",
			-- "Canary Melon",
			-- "Amberheart",
			"Spriggan",
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
		["Traveling Shop"] = {
			"Bee Egg",
		},
		Craft = {
			"Anti Bee Egg",
		},
		Start_Do_Honey = 2_000_000 -- start trade fruit for honey at money
	},

	Gear = {
		Buy = {
            "Watering Can",
			"Master Sprinkler",
			"Trading Ticket",
			"Godly Sprinkler",
			"Grandmaster Sprinkler", -- sửa chính tả
			"Advanced Sprinkler",
			"Basic Sprinkler",
			"Lightning Rod",
			"Level Up Lollipop",
			"Medium Treat",
			"Medium Toy",
		},
		Lock = { },
	},

	Eggs = {
		Place = {
            "Zen Egg",
            "Sprout Egg",
			"Gourmet Egg",
            "Common Summer Egg",
			"Bug Egg",
			"Paradise Egg",
		},
		Buy = {
			"Common Summer Egg",
			"Bee Egg",
			"Oasis Egg",
			"Paradise Egg",
			"Anti Bee Egg",
			"Night Egg",
			"Bug Egg",
            "Mythical Egg",
		}
	},

	Pets = {
		["Start Delete Pet At"] = 40,
		["Upgrade Slot"] = {
			["Pet"] = {
				["Starfish"] = { 8, 76, 1, true }, -- last = auto equip
			},
			["Limit Upgrade"] = 5,
			["Equip When Done"] = {
                ["Dairy Cow"] = { 8, 100, 1 },
				["Sunny-Side Chicken"] = { 8, 100, 2 },
			},
		},
		Favorite_LockedPet = true,
		Locked_Pet_Age = 76, -- comment nói >60; bạn để 76 là OK nếu cố ý
		Locked = {
			"Corrupted Kitsune",
			"Kitsune",
			"Dragonfly",
			"Raccoon",
			"Fennec Fox",
			"Mimic Octopus",
			"Red Fox",
			"Blood Owl",
			"Spinosaurus",
			"T-Rex",
			"Lobster Thermidor",
			["Dairy Cow"] = 8,
			["Sunny-Side Chicken"] = 8,
			["Starfish"] = 15,
			"French Fry Ferret",
			"Rainbow Hotdog Daschund",
            ["Hotdog Daschund"] = 4,
            ["Koi"] = 8,
            "Raiju",
            "Golden Goose",
		},
		LockPet_Weight = 6, -- comment ghi 10 nhưng bạn set 6
		Instant_Sell = {
			"Dog","Bunny","Golden Lab","Triceratops","Stegosaurus","Raptor","Seagull",
			"Parasaurolophus","Pachycephalosaurus","Iguanodon","Shiba Inu","Nihonzaru","Tanuki",
			"Kappa","Caterpillar","Snail","Giant Ant","Praying Mantis","Ankylosaurus","Ostrich",
			"Peacock","Scarlet Macaw","Capybara","Wasp","Tarantula Hawk","Moth","Bee","Honey Bee",
			"Bear Bee","Petal Bee","Grey Mouse","Brown Mouse","Squirrel","Red Giant Ant","Hedgehog",
			"Mole","Frog","Echo Frog","Night Owl","Brontosaurus","Dilophosaurus","Pterodactyl",
			"Crab","Sushi Bear","Bagel Bunny","Mochi Mouse","Bacon Pig","Pancake Mole",
		},
	},

	Webhook = {
		UrlPet = getgenv().Discord,
		UrlSeed = getgenv().Discord,
		PcName = getgenv().PCAYA,
		Noti = {
			Seeds = { "Sunflower", "Dragon Pepper", "Elephant Ears" },
			SeedPack = { "Idk" },
			Pets = {
				"French Fry Ferret",
				"Rainbow Hotdog Daschund",
				"Lobster Thermidor",
				"King Cabbage",
				"Kitsune",
                "Mimic Octopus",
			    "Red Fox",
                "Golden Goose",
			},
			Pet_Weight_Noti = true,
		}
	},
}

License = getgenv().KeyAYA
loadstring(game:HttpGet('https://raw.githubusercontent.com/Real-Aya/Loader/main/Init.lua'))()
