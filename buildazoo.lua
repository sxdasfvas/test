-- Build A Zoo: Auto Buy Egg using WindUI

-- Load WindUI library (same as in Windui.lua)
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local ProximityPromptService = game:GetService("ProximityPromptService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local TeleportService = game:GetService("TeleportService")
local vector = { create = function(x, y, z) return Vector3.new(x, y, z) end }
local LocalPlayer = Players.LocalPlayer

-- Selection state variables
local selectedTypeSet = {}
local selectedMutationSet = {}
local selectedFruits = {}
local selectedFeedFruits = {}
local updateCustomUISelection
local settingsLoaded = false
local function waitForSettingsReady(extraDelay)
    while not settingsLoaded do
        task.wait(0.1)
    end
    if extraDelay and extraDelay > 0 then
        task.wait(extraDelay)
    end
end
local autoFeedToggle

-- Forward declarations

-- Window
local Window = WindUI:CreateWindow({
    Title = "Build A Zoo",
    Icon = "app-window-mac",
    IconThemed = true,
    Author = "Zebux",
    Folder = "Zebux",
    Size = UDim2.fromOffset(520, 360),
    Transparent = true,
    Theme = "Dark",
    -- No keysystem
})

local Tabs = {}
Tabs.MainSection = Window:Section({ Title = "🤖 Auto Helpers", Opened = true })
Tabs.AutoTab = Tabs.MainSection:Tab({ Title = "🥚 | Buy Eggs"})
Tabs.PlaceTab = Tabs.MainSection:Tab({ Title = "🏠 | Place Pets"})
Tabs.HatchTab = Tabs.MainSection:Tab({ Title = "⚡ | Hatch Eggs"})
Tabs.ClaimTab = Tabs.MainSection:Tab({ Title = "💰 | Get Money"})
Tabs.ShopTab = Tabs.MainSection:Tab({ Title = "🛒 | Shop"})
Tabs.PackTab = Tabs.MainSection:Tab({ Title = "🎁 | Get Packs"})
Tabs.FruitTab = Tabs.MainSection:Tab({ Title = "🍎 | Fruit Store"})
Tabs.FeedTab = Tabs.MainSection:Tab({ Title = "🍽️ | Auto Feed"})
-- Bug tab removed per user request
Tabs.SaveTab = Tabs.MainSection:Tab({ Title = "💾 | Save Settings"})

-- Function to load all saved settings before any function starts
local function loadAllSettings()
    -- Load WindUI config for simple UI elements
    if zebuxConfig then
        local loadSuccess, loadErr = pcall(function()
            zebuxConfig:Load()
        end)
        
        if not loadSuccess then
            warn("Failed to load WindUI config: " .. tostring(loadErr))
        end
    end
    
    -- Load custom selection variables from JSON files
    local success, data = pcall(function()
        if isfile("Zebux_EggSelections.json") then
            local jsonData = readfile("Zebux_EggSelections.json")
            return game:GetService("HttpService"):JSONDecode(jsonData)
        end
    end)
    
    if success and data then
        selectedTypeSet = {}
        if data.eggs then
            for _, eggId in ipairs(data.eggs) do
                selectedTypeSet[eggId] = true
            end
        end
        
        selectedMutationSet = {}
        if data.mutations then
            for _, mutationId in ipairs(data.mutations) do
                selectedMutationSet[mutationId] = true
            end
        end
    end
    
    -- Load fruit selections
    local fruitSuccess, fruitData = pcall(function()
        if isfile("Zebux_FruitSelections.json") then
            local jsonData = readfile("Zebux_FruitSelections.json")
            return game:GetService("HttpService"):JSONDecode(jsonData)
        end
    end)
    
    if fruitSuccess and fruitData then
        selectedFruits = {}
        if fruitData.fruits then
            for _, fruitId in ipairs(fruitData.fruits) do
                selectedFruits[fruitId] = true
            end
        end
    end
    
    -- Load feed fruit selections
    local feedFruitSuccess, feedFruitData = pcall(function()
        if isfile("Zebux_FeedFruitSelections.json") then
            local jsonData = readfile("Zebux_FeedFruitSelections.json")
            return game:GetService("HttpService"):JSONDecode(jsonData)
        end
    end)
    
    if feedFruitSuccess and feedFruitData then
        selectedFeedFruits = {}
        if feedFruitData.fruits then
            for _, fruitId in ipairs(feedFruitData.fruits) do
                selectedFeedFruits[fruitId] = true
            end
        end
    end
    
    -- Load auto place selections
    local autoPlaceSuccess, autoPlaceData = pcall(function()
        if isfile("Zebux_AutoPlaceSelections.json") then
            local jsonData = readfile("Zebux_AutoPlaceSelections.json")
            return game:GetService("HttpService"):JSONDecode(jsonData)
        end
    end)
    
    if autoPlaceSuccess and autoPlaceData then
        if autoPlaceData.eggTypes then
            selectedEggTypes = autoPlaceData.eggTypes
        end
        if autoPlaceData.mutations then
            selectedMutations = autoPlaceData.mutations
        end
    end
end

-- Function to save all settings (WindUI config + custom selections)
local function saveAllSettings()
    -- Save WindUI config for simple UI elements
    if zebuxConfig then
        local saveSuccess, saveErr = pcall(function()
            zebuxConfig:Save()
        end)
        
        if not saveSuccess then
            warn("Failed to save WindUI config: " .. tostring(saveErr))
        end
    end
    
    -- Save custom selection variables to JSON files
    local eggSelections = {
        eggs = {},
        mutations = {}
    }
    
    for eggId, _ in pairs(selectedTypeSet) do
        table.insert(eggSelections.eggs, eggId)
    end
    
    for mutationId, _ in pairs(selectedMutationSet) do
        table.insert(eggSelections.mutations, mutationId)
    end
    
    -- Save auto place selections
    local autoPlaceSelections = {
        eggTypes = selectedEggTypes,
        mutations = selectedMutations
    }
    
    pcall(function()
        writefile("Zebux_AutoPlaceSelections.json", game:GetService("HttpService"):JSONEncode(autoPlaceSelections))
    end)
    
    pcall(function()
        writefile("Zebux_EggSelections.json", game:GetService("HttpService"):JSONEncode(eggSelections))
    end)
    
    -- Save fruit selections
    local fruitSelections = {
        fruits = {}
    }
    
    for fruitId, _ in pairs(selectedFruits) do
        table.insert(fruitSelections.fruits, fruitId)
    end
    
    pcall(function()
        writefile("Zebux_FruitSelections.json", game:GetService("HttpService"):JSONEncode(fruitSelections))
    end)
    
    -- Save feed fruit selections
    local feedFruitSelections = {
        fruits = {}
    }
    
    for fruitId, _ in pairs(selectedFeedFruits) do
        table.insert(feedFruitSelections.fruits, fruitId)
    end
    
    pcall(function()
        writefile("Zebux_FeedFruitSelections.json", game:GetService("HttpService"):JSONEncode(feedFruitSelections))
    end)
end

-- Auto state variables (declared early so close handler can reference)

local autoFeedEnabled = false
local autoPlaceEnabled = false
local autoPlaceThread = nil
local autoHatchEnabled = false
local antiAFKEnabled = false
local antiAFKConnection = nil
local autoHatchThread = nil
-- Priority system removed per user request

-- Egg config loader
local eggConfig = {}
local conveyorConfig = {}
local petFoodConfig = {}
local mutationConfig = {}

local function loadEggConfig()
    local ok, cfg = pcall(function()
        local cfgFolder = ReplicatedStorage:WaitForChild("Config")
        local module = cfgFolder:WaitForChild("ResEgg")
        return require(module)
    end)
    if ok and type(cfg) == "table" then
        eggConfig = cfg
    else
        eggConfig = {}
    end
end

local idToTypeMap = {}
local function loadConveyorConfig()
    local ok, cfg = pcall(function()
        local cfgFolder = ReplicatedStorage:WaitForChild("Config")
        local module = cfgFolder:WaitForChild("ResConveyor")
        return require(module)
    end)
    if ok and type(cfg) == "table" then
        conveyorConfig = cfg
    else
        conveyorConfig = {}
    end
end

local function loadPetFoodConfig()
    local ok, cfg = pcall(function()
        local cfgFolder = ReplicatedStorage:WaitForChild("Config")
        local module = cfgFolder:WaitForChild("ResPetFood")
        return require(module)
    end)
    if ok and type(cfg) == "table" then
        petFoodConfig = cfg
    else
        petFoodConfig = {}
    end
end

local function loadMutationConfig()
    local ok, cfg = pcall(function()
        local cfgFolder = ReplicatedStorage:WaitForChild("Config")
        local module = cfgFolder:WaitForChild("ResMutate")
        return require(module)
    end)
    if ok and type(cfg) == "table" then
        mutationConfig = cfg
    else
        mutationConfig = {}
    end
end
local function getTypeFromConfig(key, val)
    if type(val) == "table" then
        local t = val.Type or val.Name or val.type or val.name
        if t ~= nil then return tostring(t) end
    end
    return tostring(key)
end

local function buildEggIdList()
    idToTypeMap = {}
    local ids = {}
    for id, val in pairs(eggConfig) do
        local idStr = tostring(id)
        -- Filter out meta keys like _index, __index, and any leading underscore entries
        if not string.match(idStr, "^_%_?index$") and not string.match(idStr, "^__index$") and not idStr:match("^_") then
            table.insert(ids, idStr)
            idToTypeMap[idStr] = getTypeFromConfig(id, val)
        end
    end
    table.sort(ids)
    return ids
end

local function buildMutationList()
    local mutations = {}
    for id, val in pairs(mutationConfig) do
        local idStr = tostring(id)
        -- Filter out meta keys like _index, __index, and any leading underscore entries
        if not string.match(idStr, "^_%_?index$") and not string.match(idStr, "^__index$") and not idStr:match("^_") then
            local mutationName = val.Name or val.ID or val.Id or idStr
            mutationName = tostring(mutationName)
            
            table.insert(mutations, mutationName)
        end
    end
    table.sort(mutations)
    return mutations
end

-- UI helpers
local function tryCreateTextInput(parent, opts)
    -- Tries common method names to create a textbox-like input in WindUI
    local created
    for _, method in ipairs({"Textbox", "Input", "TextBox"}) do
        local ok, res = pcall(function()
            return parent[method](parent, opts)
        end)
        if ok and res then created = res break end
    end
    return created
end

-- Removed unused function caseInsensitiveContains

local function getEggPriceById(eggId)
    local entry = eggConfig[eggId] or eggConfig[tonumber(eggId)]
    if entry == nil then
        for key, value in pairs(eggConfig) do
            if tostring(key) == tostring(eggId) then
                entry = value
                break
            end
            if type(value) == "table" then
                if value.Id == eggId or tostring(value.Id) == tostring(eggId) or value.Name == eggId then
                    entry = value
                    break
                end
            end
        end
    end
    if type(entry) == "table" then
        local price = entry.Price or entry.price or entry.Cost or entry.cost
        if type(price) == "number" then return price end
        if type(entry.Base) == "table" and type(entry.Base.Price) == "number" then return entry.Base.Price end
    end
    return nil
end

local function getEggPriceByType(eggType)
    local target = tostring(eggType)
    for key, value in pairs(eggConfig) do
        if type(value) == "table" then
            local t = value.Type or value.Name or value.type or value.name or tostring(key)
            if tostring(t) == target then
                local price = value.Price or value.price or value.Cost or value.cost
                if type(price) == "number" then return price end
                if type(value.Base) == "table" and type(value.Base.Price) == "number" then return value.Base.Price end
            end
        else
            if tostring(key) == target then
                -- primitive mapping, try id-based
                local price = getEggPriceById(key)
                if type(price) == "number" then return price end
            end
        end
    end
    return nil
end

-- Player helpers
local function getAssignedIslandName()
    if not LocalPlayer then return nil end
    return LocalPlayer:GetAttribute("AssignedIslandName")
end

-- Function to read mutation from egg GUI
local function getEggMutation(eggUID)
    if not eggUID then return nil end
    
    local islandName = getAssignedIslandName()
    if not islandName then return nil end
    
    local art = workspace:FindFirstChild("Art")
    if not art then return nil end
    
    local island = art:FindFirstChild(islandName)
    if not island then return nil end
    
    local env = island:FindFirstChild("ENV")
    if not env then return nil end
    
    local conveyor = env:FindFirstChild("Conveyor")
    if not conveyor then return nil end
    
    -- Check all conveyor belts
    for i = 1, 9 do
        local conveyorBelt = conveyor:FindFirstChild("Conveyor" .. i)
        if conveyorBelt then
            local belt = conveyorBelt:FindFirstChild("Belt")
            if belt then
                local eggModel = belt:FindFirstChild(eggUID)
                if eggModel and eggModel:IsA("Model") then
                    local rootPart = eggModel:FindFirstChild("RootPart")
                    if rootPart then
                        local eggGUI = rootPart:FindFirstChild("GUI/EggGUI")
                        if eggGUI then
                            local mutateText = eggGUI:FindFirstChild("Mutate")
                            if mutateText and mutateText:IsA("TextLabel") then
                                local mutationText = mutateText.Text
                                if mutationText and mutationText ~= "" then
                                    -- Handle special case: if mutation is "Dino", return "Jurassic"
                                    if string.lower(mutationText) == "dino" then
                                        return "Jurassic"
                                    end
                                    return mutationText
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    
    return nil
end

-- Player helpers (getAssignedIslandName moved earlier to fix undefined global error)

local function getPlayerNetWorth()
    if not LocalPlayer then return 0 end
    local attrValue = LocalPlayer:GetAttribute("NetWorth")
    if type(attrValue) == "number" then return attrValue end
    local leaderstats = LocalPlayer:FindFirstChild("leaderstats")
    if leaderstats then
        local netWorthValue = leaderstats:FindFirstChild("NetWorth")
        if netWorthValue and type(netWorthValue.Value) == "number" then
            return netWorthValue.Value
        end
    end
    return 0
end

local function fireConveyorUpgrade(index)
    local args = { "Upgrade", tonumber(index) or index }
    local ok, err = pcall(function()
        ReplicatedStorage:WaitForChild("Remote"):WaitForChild("ConveyorRE"):FireServer(table.unpack(args))
    end)
    if not ok then warn("Conveyor Upgrade fire failed: " .. tostring(err)) end
    return ok
end

-- World helpers
local function getIslandBelts(islandName)
    if type(islandName) ~= "string" or islandName == "" then return {} end
    local art = workspace:FindFirstChild("Art")
    if not art then return {} end
    local island = art:FindFirstChild(islandName)
    if not island then return {} end
    local env = island:FindFirstChild("ENV")
    if not env then return {} end
    local conveyorRoot = env:FindFirstChild("Conveyor")
    if not conveyorRoot then return {} end
    local belts = {}
    -- Strictly look for Conveyor1..Conveyor9 in order
    for i = 1, 9 do
        local c = conveyorRoot:FindFirstChild("Conveyor" .. i)
        if c then
            local b = c:FindFirstChild("Belt")
            if b then table.insert(belts, b) end
        end
    end
    return belts
end

-- Pick one "active" belt (with most eggs; tie -> nearest to player)
local function getActiveBelt(islandName)
    local belts = getIslandBelts(islandName)
    if #belts == 0 then return nil end
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    local hrpPos = hrp and hrp.Position or Vector3.new()
    local bestBelt, bestScore, bestDist
    for _, belt in ipairs(belts) do
        local children = belt:GetChildren()
        local eggs = 0
        local samplePos
        for _, ch in ipairs(children) do
            if ch:IsA("Model") then
                eggs += 1
                if not samplePos then
                    local ok, cf = pcall(function() return ch:GetPivot() end)
                    if ok and cf then samplePos = cf.Position end
                end
            end
        end
        if not samplePos then
            local p = belt.Parent and belt.Parent:FindFirstChildWhichIsA("BasePart", true)
            samplePos = p and p.Position or hrpPos
        end
        local dist = (samplePos - hrpPos).Magnitude
        -- Higher eggs preferred; for tie, closer belt preferred
        local score = eggs * 100000 - dist
        if not bestScore or score > bestScore then
            bestScore, bestDist, bestBelt = score, dist, belt
        end
    end
    return bestBelt
end

-- Auto Place helpers
local function getIslandNumberFromName(islandName)
    if not islandName then return nil end
    -- Extract number from island name (e.g., "Island_3" -> 3)
    local match = string.match(islandName, "Island_(%d+)")
    if match then
        return tonumber(match)
    end
    -- Try other patterns
    match = string.match(islandName, "(%d+)")
    if match then
        return tonumber(match)
    end
    return nil
end

local function getFarmParts(islandNumber)
    if not islandNumber then return {} end
    local art = workspace:FindFirstChild("Art")
    if not art then return {} end
    
    local islandName = "Island_" .. tostring(islandNumber)
    local island = art:FindFirstChild(islandName)
    if not island then 
        -- Try alternative naming patterns
        for _, child in ipairs(art:GetChildren()) do
            if child.Name:match("^Island[_-]?" .. tostring(islandNumber) .. "$") then
                island = child
                break
            end
        end
        if not island then return {} end
    end
    
    local farmParts = {}
    local function scanForFarmParts(parent)
        for _, child in ipairs(parent:GetChildren()) do
            if child:IsA("BasePart") and child.Name:match("^Farm_split_%d+_%d+_%d+$") then
                -- Additional validation: check if part is valid for placement
                if child.Size == Vector3.new(8, 8, 8) and child.CanCollide then
                    table.insert(farmParts, child)
                end
            end
            scanForFarmParts(child)
        end
    end
    
    scanForFarmParts(island)
    
    -- Filter out locked tiles by checking the Locks folder
    local unlockedFarmParts = {}
    local locksFolder = island:FindFirstChild("ENV"):FindFirstChild("Locks")
    
    if locksFolder then
        -- Create a map of locked areas using CFrame and size
        local lockedAreas = {}
        for _, lockModel in ipairs(locksFolder:GetChildren()) do
            if lockModel:IsA("Model") then
                local farmPart = lockModel:FindFirstChild("Farm")
                if farmPart and farmPart:IsA("BasePart") then
                    -- Check if this lock is active (transparency = 0 means locked)
                    if farmPart.Transparency == 0 then
                        -- Store the lock's CFrame and size for area checking
                        table.insert(lockedAreas, {
                            cframe = farmPart.CFrame,
                            size = farmPart.Size,
                            position = farmPart.Position
                        })
                    end
                end
            end
        end
        
        -- Check each farm part against locked areas
        for _, farmPart in ipairs(farmParts) do
            local isLocked = false
            
            for _, lockArea in ipairs(lockedAreas) do
                -- Check if farm part is within the lock area
                -- Use CFrame and size to determine if the farm part is covered by the lock
                local farmPartPos = farmPart.Position
                local lockCenter = lockArea.position
                local lockSize = lockArea.size
                
                -- Calculate the bounds of the lock area
                local lockHalfSize = lockSize / 2
                local lockMinX = lockCenter.X - lockHalfSize.X
                local lockMaxX = lockCenter.X + lockHalfSize.X
                local lockMinZ = lockCenter.Z - lockHalfSize.Z
                local lockMaxZ = lockCenter.Z + lockHalfSize.Z
                
                -- Check if farm part is within the lock bounds
                if farmPartPos.X >= lockMinX and farmPartPos.X <= lockMaxX and
                   farmPartPos.Z >= lockMinZ and farmPartPos.Z <= lockMaxZ then
                    isLocked = true
                    break
                end
            end
            
            if not isLocked then
                table.insert(unlockedFarmParts, farmPart)
            end
        end
    else
        -- If no locks folder found, assume all tiles are unlocked
        unlockedFarmParts = farmParts
    end
    
    return unlockedFarmParts
end

-- Occupancy helpers (uses Model:GetPivot to detect nearby placed pets)
local function isPetLikeModel(model)
    if not model or not model:IsA("Model") then return false end
    -- Common signals that a model is a pet or a placed unit
    if model:FindFirstChildOfClass("Humanoid") then return true end
    if model:FindFirstChild("AnimationController") then return true end
    if model:GetAttribute("IsPet") or model:GetAttribute("PetType") or model:GetAttribute("T") then return true end
    local lowerName = string.lower(model.Name)
    if string.find(lowerName, "pet") or string.find(lowerName, "egg") then return true end
    if CollectionService and (CollectionService:HasTag(model, "Pet") or CollectionService:HasTag(model, "IdleBigPet")) then
        return true
    end
    return false
end

local function getTileCenterPosition(farmPart)
    if not farmPart or not farmPart.IsA or not farmPart:IsA("BasePart") then return nil end
    -- Middle of the farm tile (parts are 8x8x8)
    return farmPart.Position
end

local function getPetModelsOverlappingTile(farmPart)
    if not farmPart or not farmPart:IsA("BasePart") then return {} end
    local centerCF = farmPart.CFrame
    -- Slightly taller box to capture pets above the tile
    local regionSize = Vector3.new(8, 14, 8)
    local params = OverlapParams.new()
    params.RespectCanCollide = false
    -- Search within whole workspace, we will filter to models
    local parts = workspace:GetPartBoundsInBox(centerCF, regionSize, params)
    local modelMap = {}
    for _, part in ipairs(parts) do
        if part ~= farmPart then
            local model = part:FindFirstAncestorOfClass("Model")
            if model and not modelMap[model] and isPetLikeModel(model) then
                modelMap[model] = true
            end
        end
    end
    local models = {}
    for model in pairs(modelMap) do table.insert(models, model) end
    return models
end

-- Get all pet configurations that the player owns
local function getPlayerPetConfigurations()
    local petConfigs = {}
    
    if not LocalPlayer then return petConfigs end
    
    local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
    if not playerGui then return petConfigs end
    
    local data = playerGui:FindFirstChild("Data")
    if not data then return petConfigs end
    
    local petsFolder = data:FindFirstChild("Pets")
    if not petsFolder then return petConfigs end
    
    -- Get all pet configurations
    for _, petConfig in ipairs(petsFolder:GetChildren()) do
        if petConfig:IsA("Configuration") then
            table.insert(petConfigs, {
                name = petConfig.Name,
                config = petConfig
            })
        end
    end
    
    return petConfigs
end

-- Check if a pet exists in workspace.Pets by configuration name
local function findPetInWorkspace(petConfigName)
    local workspacePets = workspace:FindFirstChild("Pets")
    if not workspacePets then return nil end
    
    local petModel = workspacePets:FindFirstChild(petConfigName)
    if petModel and petModel:IsA("Model") then
        return petModel
    end
    
    return nil
end

-- Get all player's pets that exist in workspace
local function getPlayerPetsInWorkspace()
    local petsInWorkspace = {}
    local playerPets = getPlayerPetConfigurations()
    local workspacePets = workspace:FindFirstChild("Pets")
    
    if not workspacePets then return petsInWorkspace end
    
    for _, petConfig in ipairs(playerPets) do
        local petModel = workspacePets:FindFirstChild(petConfig.name)
        if petModel and petModel:IsA("Model") then
            table.insert(petsInWorkspace, {
                name = petConfig.name,
                model = petModel,
                position = petModel:GetPivot().Position
            })
        end
    end
    
    return petsInWorkspace
end

local function isFarmTileOccupied(farmPart, minDistance)
    minDistance = minDistance or 6
    local center = getTileCenterPosition(farmPart)
    if not center then return true end
    
    -- Calculate surface position (same as placement logic)
    local surfacePosition = Vector3.new(
        center.X,
        center.Y + 12, -- Eggs float 12 studs above tile surface
        center.Z
    )
    
    -- Check for pets in PlayerBuiltBlocks (eggs/hatching pets)
    local models = getPetModelsOverlappingTile(farmPart)
    if #models > 0 then
    for _, model in ipairs(models) do
        local pivotPos = model:GetPivot().Position
            -- Check distance to surface position instead of center
            if (pivotPos - surfacePosition).Magnitude <= minDistance then
            return true
        end
    end
    end
    
    -- Check for fully hatched pets in workspace.Pets
    local playerPets = getPlayerPetsInWorkspace()
    for _, petInfo in ipairs(playerPets) do
        local petPos = petInfo.position
        -- Check distance to surface position instead of center
        if (petPos - surfacePosition).Magnitude <= minDistance then
            return true
        end
    end
    
    return false
end

local function findAvailableFarmPart(farmParts, minDistance)
    if not farmParts or #farmParts == 0 then return nil end
    
    -- First, collect all available parts
    local availableParts = {}
    for _, part in ipairs(farmParts) do
        if not isFarmTileOccupied(part, minDistance) then
            table.insert(availableParts, part)
        end
    end
    
    -- If no available parts, return nil
    if #availableParts == 0 then return nil end
    
    -- Shuffle available parts to distribute placement
    for i = #availableParts, 2, -1 do
        local j = math.random(1, i)
        availableParts[i], availableParts[j] = availableParts[j], availableParts[i]
    end
    
    return availableParts[1]
end

-- Player helpers for proximity-based placement
local function getPlayerRootPosition()
    local character = LocalPlayer and LocalPlayer.Character
    if not character then return nil end
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end
    return hrp.Position
end

local function findAvailableFarmPartNearPosition(farmParts, minDistance, targetPosition)
    if not targetPosition then return findAvailableFarmPart(farmParts, minDistance) end
    if not farmParts or #farmParts == 0 then return nil end
    -- Sort farm parts by distance to targetPosition and pick first unoccupied
    local sorted = table.clone(farmParts)
    table.sort(sorted, function(a, b)
        return (a.Position - targetPosition).Magnitude < (b.Position - targetPosition).Magnitude
    end)
    for _, part in ipairs(sorted) do
        if not isFarmTileOccupied(part, minDistance) then
            return part
        end
    end
    return nil
end

-- Helper function to check if a specific tile position is unlocked
local function isTileUnlocked(islandName, tilePosition)
    if not islandName or not tilePosition then return false end
    
    local art = workspace:FindFirstChild("Art")
    if not art then return true end -- Assume unlocked if no Art folder
    
    local island = art:FindFirstChild(islandName)
    if not island then return true end -- Assume unlocked if island not found
    
    local locksFolder = island:FindFirstChild("ENV"):FindFirstChild("Locks")
    if not locksFolder then return true end -- Assume unlocked if no locks folder
    
    -- Check if there's a lock covering this position
    for _, lockModel in ipairs(locksFolder:GetChildren()) do
        if lockModel:IsA("Model") then
            local farmPart = lockModel:FindFirstChild("Farm")
            if farmPart and farmPart:IsA("BasePart") and farmPart.Transparency == 0 then
                -- Check if tile position is within the lock area
                local lockCenter = farmPart.Position
                local lockSize = farmPart.Size
                
                -- Calculate the bounds of the lock area
                local lockHalfSize = lockSize / 2
                local lockMinX = lockCenter.X - lockHalfSize.X
                local lockMaxX = lockCenter.X + lockHalfSize.X
                local lockMinZ = lockCenter.Z - lockHalfSize.Z
                local lockMaxZ = lockCenter.Z + lockHalfSize.Z
                
                -- Check if tile position is within the lock bounds
                if tilePosition.X >= lockMinX and tilePosition.X <= lockMaxX and
                   tilePosition.Z >= lockMinZ and tilePosition.Z <= lockMaxZ then
                    return false -- This tile is locked
                end
            end
        end
    end
    
    return true -- Tile is unlocked
end




local function getPetUID()
    if not LocalPlayer then return nil end
    
    -- Wait for PlayerGui to exist
    local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
    if not playerGui then
        -- Try to wait for it briefly
        playerGui = LocalPlayer:WaitForChild("PlayerGui", 2)
        if not playerGui then return nil end
    end
    
    -- Wait for Data folder to exist
    local data = playerGui:FindFirstChild("Data")
    if not data then
        data = playerGui:WaitForChild("Data", 2)
        if not data then return nil end
    end
    
    -- Wait for Egg object to exist
    local egg = data:FindFirstChild("Egg")
    if not egg then
        egg = data:WaitForChild("Egg", 2)
        if not egg then return nil end
    end
    
    -- The PET UID is the NAME of the egg object, not its Value
    local eggName = egg.Name
    if not eggName or eggName == "" then
        return nil
    end
    
    return eggName
end

-- Available Egg helpers (Auto Place)
local function getEggContainer()
    local pg = LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui")
    local data = pg and pg:FindFirstChild("Data")
    return data and data:FindFirstChild("Egg") or nil
end

-- Function to read mutation from egg configuration (for Auto Place)
local function getEggMutation(eggUID)
    local localPlayer = Players.LocalPlayer
    if not localPlayer then return nil end
    
    local playerGui = localPlayer:FindFirstChild("PlayerGui")
    if not playerGui then return nil end
    
    local data = playerGui:FindFirstChild("Data")
    if not data then return nil end
    
    local eggContainer = data:FindFirstChild("Egg")
    if not eggContainer then return nil end
    
    local eggConfig = eggContainer:FindFirstChild(eggUID)
    if not eggConfig then return nil end
    
    -- Read the M attribute (mutation)
    local mutation = eggConfig:GetAttribute("M")
    
    -- Map "Dino" to "Jurassic" for consistency
    if mutation == "Dino" then
        mutation = "Jurassic"
    end
    
    return mutation
end

-- Function to read mutation from GUI text on conveyor belt (for Auto Buy)
local function getEggMutationFromGUI(eggUID)
    local islandName = getAssignedIslandName()
    if not islandName then return nil end
    
    local art = workspace:FindFirstChild("Art")
    if not art then return nil end
    
    local island = art:FindFirstChild(islandName)
    if not island then return nil end
    
    local env = island:FindFirstChild("ENV")
    if not env then return nil end
    
    local conveyor = env:FindFirstChild("Conveyor")
    if not conveyor then return nil end
    
    -- Check all conveyor belts
    for i = 1, 9 do
        local conveyorBelt = conveyor:FindFirstChild("Conveyor" .. i)
        if conveyorBelt then
            local belt = conveyorBelt:FindFirstChild("Belt")
            if belt then
                local eggModel = belt:FindFirstChild(eggUID)
                if eggModel and eggModel:IsA("Model") then
                    local rootPart = eggModel:FindFirstChild("RootPart")
                    if rootPart then
                        local eggGUI = rootPart:FindFirstChild("GUI/EggGUI")
                        if eggGUI then
                            local mutateText = eggGUI:FindFirstChild("Mutate")
                            if mutateText and mutateText:IsA("TextLabel") then
                                local mutationText = mutateText.Text
                                if mutationText and mutationText ~= "" then
                                    -- Map "Dino" to "Jurassic" for consistency
                                    if string.lower(mutationText) == "dino" then
                                        return "Jurassic"
                                    end
                                    return mutationText
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    
    return nil
end

local function listAvailableEggUIDs()
    local eg = getEggContainer()
    local uids = {}
    if not eg then return uids end
    for _, child in ipairs(eg:GetChildren()) do
        if #child:GetChildren() == 0 then -- no subfolder => available
            -- Get the actual egg type from T attribute
            local eggType = child:GetAttribute("T")
            if eggType then
                -- Get the mutation from M attribute
                local mutation = getEggMutation(child.Name)
                table.insert(uids, { 
                    uid = child.Name, 
                    type = eggType,
                    mutation = mutation
                })
            else
                table.insert(uids, { 
                    uid = child.Name, 
                    type = child.Name,
                    mutation = nil
                })
            end
        end
    end
    return uids
end

-- Enhanced pet validation based on the Pet module
local function validatePetUID(petUID)
    if not petUID or type(petUID) ~= "string" or petUID == "" then
        return false, "Invalid PET UID"
    end
    
    -- Check if pet exists in ReplicatedStorage.Pets (based on Pet module patterns)
    local petsFolder = ReplicatedStorage:FindFirstChild("Pets")
    if petsFolder then
        -- The Pet module shows pets are stored by their type (T attribute)
        -- We might need to validate the pet type exists
        return true, "Valid PET UID"
    end
    
    return true, "PET UID found (pets folder not accessible)"
end

-- Get pet information for better status display
local function getPetInfo(petUID)
    if not petUID then return nil end
    
    -- Try to get pet data from various sources
    local petData = {
        UID = petUID,
        Type = nil,
        Rarity = nil,
        Level = nil,
        Mutations = nil
    }
    
    -- Check if we can get pet type from the UID
    -- This might be stored in the player's data or we might need to parse it
    if type(petUID) == "string" then
        -- Some games store pet type in the UID itself
        petData.Type = petUID
    end
    
    return petData
end

-- ============ Auto Claim Money ============
local autoClaimEnabled = false
local autoClaimThread = nil
local autoClaimDelay = 0.3 -- seconds between claims

local function getOwnedPetNames()
    local names = {}
    local playerGui = LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui")
    local data = playerGui and playerGui:FindFirstChild("Data")
    local petsContainer = data and data:FindFirstChild("Pets")
    if petsContainer then
        for _, child in ipairs(petsContainer:GetChildren()) do
            -- Assume children under Data.Pets are ValueBase instances or folders named as pet names
            local n
            if child:IsA("ValueBase") then
                n = tostring(child.Value)
            else
                n = tostring(child.Name)
            end
            if n and n ~= "" then
                table.insert(names, n)
            end
        end
    end
    return names
end

local function claimMoneyForPet(petName)
    if not petName or petName == "" then return false end
    local petsFolder = workspace:FindFirstChild("Pets")
    if not petsFolder then return false end
    local petModel = petsFolder:FindFirstChild(petName)
    if not petModel then return false end
    local root = petModel:FindFirstChild("RootPart")
    if not root then return false end
    local re = root:FindFirstChild("RE")
    if not re or not re.FireServer then return false end
    local ok, err = pcall(function()
        re:FireServer("Claim")
    end)
    if not ok then warn("Claim failed for pet " .. tostring(petName) .. ": " .. tostring(err)) end
    return ok
end

local function runAutoClaim()
    while autoClaimEnabled do
        local ok, err = pcall(function()
            local names = getOwnedPetNames()
            if #names == 0 then task.wait(0.8) return end
            for _, n in ipairs(names) do
                claimMoneyForPet(n)
                task.wait(autoClaimDelay)
            end
        end)
        if not ok then
            warn("Auto Claim error: " .. tostring(err))
            task.wait(1)
        end
    end
end

local autoClaimToggle = Tabs.ClaimTab:Toggle({
    Title = "💰 Auto Get Money",
    Desc = "Automatically collects money from your pets",
    Value = false,
    Callback = function(state)
        autoClaimEnabled = state
        
        waitForSettingsReady(0.2)
        if state and not autoClaimThread then
            autoClaimThread = task.spawn(function()
                runAutoClaim()
                autoClaimThread = nil
            end)
            WindUI:Notify({ Title = "💰 Auto Claim", Content = "Started collecting money! 🎉", Duration = 3 })
        elseif (not state) and autoClaimThread then
            WindUI:Notify({ Title = "💰 Auto Claim", Content = "Stopped", Duration = 3 })
        end
    end
})



local autoClaimDelaySlider = Tabs.ClaimTab:Slider({
    Title = "⏰ Claim Speed",
    Desc = "How fast to collect money (lower = faster)",
    Default = 100,
    Min = 0,
    Max = 1000,
    Rounding = 0,
    Callback = function(value)
        autoClaimDelay = math.clamp((tonumber(value) or 100) / 1000, 0, 2)
    end
})

Tabs.ClaimTab:Button({
    Title = "💰 Get All Money Now",
    Desc = "Collect money from all pets right now",
    Callback = function()
        local names = getOwnedPetNames()
        if #names == 0 then
            WindUI:Notify({ Title = "💰 Auto Claim", Content = "No pets found", Duration = 3 })
            return
        end
        local count = 0
        for _, n in ipairs(names) do
            if claimMoneyForPet(n) then count += 1 end
            task.wait(0.05)
        end
        WindUI:Notify({ Title = "💰 Auto Claim", Content = string.format("Got money from %d pets! 🎉", count), Duration = 3 })
    end
})

-- ============ Auto Hatch ============

-- Hatch status section removed per user request

local function getOwnerUserIdDeep(inst)
    local current = inst
    while current and current ~= workspace do
        if current.GetAttribute then
            local uidAttr = current:GetAttribute("UserId")
            if type(uidAttr) == "number" then return uidAttr end
            if type(uidAttr) == "string" then
                local n = tonumber(uidAttr)
                if n then return n end
            end
        end
        current = current.Parent
    end
    return nil
end

local function playerOwnsInstance(inst)
    if not inst then return false end
    local ownerId = getOwnerUserIdDeep(inst)
    local lp = Players.LocalPlayer
    return ownerId ~= nil and lp and lp.UserId == ownerId
end

local function getModelPosition(model)
    if not model or not model.GetPivot then return nil end
    local ok, cf = pcall(function() return model:GetPivot() end)
    if ok and cf then return cf.Position end
    local pp = model.PrimaryPart or model:FindFirstChild("RootPart")
    return pp and pp.Position or nil
end

local function getEggTypeFromModel(model)
    if not model then return nil end
    local root = model:FindFirstChild("RootPart")
    if root and root.GetAttribute then
        local et = root:GetAttribute("EggType")
        if et ~= nil then return tostring(et) end
    end
    return nil
end

local function isStringEmpty(s)
    return type(s) == "string" and (s == "" or s:match("^%s*$") ~= nil)
end

local function isReadyText(text)
    if type(text) ~= "string" then return false end
    -- Empty or whitespace means ready
    if isStringEmpty(text) then return true end
    -- Percent text like "100%", "100.0%", "100.00%" also counts as ready
    local num = text:match("^%s*(%d+%.?%d*)%s*%%%s*$")
    if num then
        local n = tonumber(num)
        if n and n >= 100 then return true end
    end
    -- Words that often mean ready
    local lower = string.lower(text)
    if string.find(lower, "hatch", 1, true) or string.find(lower, "ready", 1, true) then
        return true
    end
    return false
end

local function isHatchReady(model)
    -- Look for TimeBar/TXT text being empty anywhere under the model
    for _, d in ipairs(model:GetDescendants()) do
        if d:IsA("TextLabel") and d.Name == "TXT" then
            local parent = d.Parent
            if parent and parent.Name == "TimeBar" then
                if isReadyText(d.Text) then
                    return true
                end
            end
        end
        if d:IsA("ProximityPrompt") and type(d.ActionText) == "string" then
            local at = string.lower(d.ActionText)
            if string.find(at, "hatch", 1, true) then
                return true
            end
        end
    end
    return false
end

local function collectOwnedEggs()
    local owned = {}
    local container = workspace:FindFirstChild("PlayerBuiltBlocks")
    if not container then
        -- No PlayerBuiltBlocks found
        return owned
    end
    for _, child in ipairs(container:GetChildren()) do
        if child:IsA("Model") and playerOwnsInstance(child) then
            table.insert(owned, child)
        end
    end
    -- also allow owned nested models (fallback)
    if #owned == 0 then
        for _, child in ipairs(container:GetDescendants()) do
            if child:IsA("Model") and playerOwnsInstance(child) then
                table.insert(owned, child)
            end
        end
    end
    return owned
end

local function filterReadyEggs(models)
    local ready = {}
    for _, m in ipairs(models or {}) do
        if isHatchReady(m) then table.insert(ready, m) end
    end
    return ready
end

local function pressPromptE(prompt)
    if typeof(prompt) ~= "Instance" or not prompt:IsA("ProximityPrompt") then return false end
    -- Try executor helper first
    if _G and typeof(_G.fireproximityprompt) == "function" then
        local s = pcall(function() _G.fireproximityprompt(prompt, prompt.HoldDuration or 0) end)
        if s then return true end
    end
    -- Pure client fallback: simulate the prompt key with VirtualInput
    local key = prompt.KeyboardKeyCode
    if key == Enum.KeyCode.Unknown or key == nil then key = Enum.KeyCode.E end
    -- LoS and distance flexibility
    pcall(function()
        prompt.RequiresLineOfSight = false
        prompt.Enabled = true
    end)
    local hold = prompt.HoldDuration or 0
    VirtualInputManager:SendKeyEvent(true, key, false, game)
    if hold > 0 then task.wait(hold + 0.05) end
    VirtualInputManager:SendKeyEvent(false, key, false, game)
    return true
end

local function walkTo(position, timeout)
    local char = Players.LocalPlayer and Players.LocalPlayer.Character
    if not char then return false end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return false end
    hum:MoveTo(position)
    local reached = hum.MoveToFinished:Wait(timeout or 5)
    return reached
end

local function tryHatchModel(model)
    -- Double-check ownership before proceeding
    if not playerOwnsInstance(model) then
        return false, "Not owner"
    end
    -- Find a ProximityPrompt named "E" or any prompt on the model
    local prompt
    -- Prefer a prompt on a part named Prompt or with ActionText that implies hatch
    for _, inst in ipairs(model:GetDescendants()) do
        if inst:IsA("ProximityPrompt") then
            prompt = inst
            if inst.ActionText and string.len(inst.ActionText) > 0 then break end
        end
    end
    if not prompt then return false, "No prompt" end
    local pos = getModelPosition(model)
    if not pos then return false, "No position" end
    walkTo(pos, 6)
    -- Ensure we are within MaxActivationDistance by nudging forward if necessary
    local hrp = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp and (hrp.Position - pos).Magnitude > (prompt.MaxActivationDistance or 10) - 1 then
        local dir = (pos - hrp.Position).Unit
        hrp.CFrame = CFrame.new(pos - dir * 1.5, pos)
        task.wait(0.1)
    end
    local ok = pressPromptE(prompt)
    return ok
end

local function runAutoHatch()
    while autoHatchEnabled do
        -- Check priority - if Auto Place is running and has priority, pause hatching
        -- Priority system removed
        
        local ok, err = pcall(function()
            local owned = collectOwnedEggs()
            if #owned == 0 then
                task.wait(1.0)
                return
            end
            local eggs = filterReadyEggs(owned)
            if #eggs == 0 then
                task.wait(0.8)
                return
            end
            -- Try nearest first
            local me = getPlayerRootPosition()
            table.sort(eggs, function(a, b)
                local pa = getModelPosition(a) or Vector3.new()
                local pb = getModelPosition(b) or Vector3.new()
                return (pa - me).Magnitude < (pb - me).Magnitude
            end)
            for _, m in ipairs(eggs) do
                -- Check priority again before each hatch
                -- Priority system removed
                
                -- Moving to hatch
                tryHatchModel(m)
                task.wait(0.2)
            end
            -- Done
        end)
        if not ok then
            warn("Auto Hatch error: " .. tostring(err))
            task.wait(1)
        end
    end
end

local autoHatchToggle = Tabs.HatchTab:Toggle({
    Title = "⚡ Auto Hatch Eggs",
    Desc = "Automatically hatches your eggs by walking to them",
    Value = false,
    Callback = function(state)
        autoHatchEnabled = state
        
        waitForSettingsReady(0.2)
        if state and not autoHatchThread then
            -- Check if Auto Place is running and we have lower priority
            -- Priority system removed
            autoHatchThread = task.spawn(function()
                runAutoHatch()
                autoHatchThread = nil
            end)
            WindUI:Notify({ Title = "⚡ Auto Hatch", Content = "Started hatching eggs! 🎉", Duration = 3 })
        elseif (not state) and autoHatchThread then
            WindUI:Notify({ Title = "⚡ Auto Hatch", Content = "Stopped", Duration = 3 })
        end
    end
})



Tabs.HatchTab:Button({
    Title = "⚡ Hatch Nearest Egg",
    Desc = "Hatch the closest egg to you",
    Callback = function()
        local owned = collectOwnedEggs()
        if #owned == 0 then
            WindUI:Notify({ Title = "⚡ Auto Hatch", Content = "No eggs found", Duration = 3 })
            return
        end
        local eggs = filterReadyEggs(owned)
        if #eggs == 0 then
            WindUI:Notify({ Title = "⚡ Auto Hatch", Content = "No eggs ready", Duration = 3 })
            return
        end
        local me = getPlayerRootPosition() or Vector3.new()
        table.sort(eggs, function(a, b)
            local pa = getModelPosition(a) or Vector3.new()
            local pb = getModelPosition(b) or Vector3.new()
            return (pa - me).Magnitude < (pb - me).Magnitude
        end)
        -- Moving to hatch
        local ok = tryHatchModel(eggs[1])
        WindUI:Notify({ Title = ok and "🎉 Hatched!" or "❌ Hatch Failed", Content = eggs[1].Name, Duration = 3 })
    end
})

-- Priority system UI removed

local function placePetAtPart(farmPart, petUID)
    if not farmPart or not petUID then return false end
    
    -- Enhanced validation based on Pet module insights
    if not farmPart:IsA("BasePart") then return false end
    
    local isValid, validationMsg = validatePetUID(petUID)
    if not isValid then
        warn("Pet validation failed: " .. validationMsg)
        return false
    end
    
    -- Place pet on surface (top of the farm split tile)
    local surfacePosition = Vector3.new(
        farmPart.Position.X,
        farmPart.Position.Y + (farmPart.Size.Y / 2), -- Top surface
        farmPart.Position.Z
    )
    
    local args = {
        "Place",
        {
            DST = vector.create(surfacePosition.X, surfacePosition.Y, surfacePosition.Z),
            ID = petUID
        }
    }
    
    local ok, err = pcall(function()
        local remote = ReplicatedStorage:WaitForChild("Remote"):WaitForChild("CharacterRE")
        if remote then
            remote:FireServer(unpack(args))
        else
            error("CharacterRE remote not found")
        end
    end)
    
    if not ok then
        warn("Failed to fire Place for PET UID " .. tostring(petUID) .. " at " .. tostring(surfacePosition) .. ": " .. tostring(err))
        return false
    end
    
    return true
end

-- Hardcoded Egg and Mutation Data
local EggData = {
    BasicEgg = { Name = "Basic Egg", Price = "100", Icon = "rbxassetid://129248801621928", Rarity = 1 },
    RareEgg = { Name = "Rare Egg", Price = "500", Icon = "rbxassetid://71012831091414", Rarity = 2 },
    SuperRareEgg = { Name = "Super Rare Egg", Price = "2,500", Icon = "rbxassetid://93845452154351", Rarity = 2 },
    EpicEgg = { Name = "Epic Egg", Price = "15,000", Icon = "rbxassetid://116395645531721", Rarity = 2 },
    LegendEgg = { Name = "Legend Egg", Price = "100,000", Icon = "rbxassetid://90834918351014", Rarity = 3 },
    PrismaticEgg = { Name = "Prismatic Egg", Price = "1,000,000", Icon = "rbxassetid://79960683434582", Rarity = 4 },
    HyperEgg = { Name = "Hyper Egg", Price = "2,500,000", Icon = "rbxassetid://104958288296273", Rarity = 4 },
    VoidEgg = { Name = "Void Egg", Price = "24,000,000", Icon = "rbxassetid://122396162708984", Rarity = 5 },
    BowserEgg = { Name = "Bowser Egg", Price = "130,000,000", Icon = "rbxassetid://71500536051510", Rarity = 5 },
    DemonEgg = { Name = "Demon Egg", Price = "400,000,000", Icon = "rbxassetid://126412407639969", Rarity = 5 },
    CornEgg = { Name = "Corn Egg", Price = "1,000,000,000", Icon = "rbxassetid://94739512852461", Rarity = 5 },
    BoneDragonEgg = { Name = "Bone Dragon Egg", Price = "2,000,000,000", Icon = "rbxassetid://83209913424562", Rarity = 5 },
    UltraEgg = { Name = "Ultra Egg", Price = "10,000,000,000", Icon = "rbxassetid://83909590718799", Rarity = 6 },
    DinoEgg = { Name = "Dino Egg", Price = "10,000,000,000", Icon = "rbxassetid://80783528632315", Rarity = 6 },
    FlyEgg = { Name = "Fly Egg", Price = "999,999,999,999", Icon = "rbxassetid://109240587278187", Rarity = 6 },
    UnicornEgg = { Name = "Unicorn Egg", Price = "40,000,000,000", Icon = "rbxassetid://123427249205445", Rarity = 6 },
    AncientEgg = { Name = "Ancient Egg", Price = "999,999,999,999", Icon = "rbxassetid://113910587565739", Rarity = 6 }
}

local MutationData = {
    Golden = { Name = "Golden", Icon = "✨", Rarity = 10 },
    Diamond = { Name = "Diamond", Icon = "💎", Rarity = 20 },
    Electirc = { Name = "Electric", Icon = "⚡", Rarity = 50 },
    Fire = { Name = "Fire", Icon = "🔥", Rarity = 100 },
    Jurassic = { Name = "Jurassic", Icon = "🦕", Rarity = 100 }
}

-- Load UI modules
local EggSelection = loadstring(game:HttpGet("https://raw.githubusercontent.com/ZebuxHub/Main/refs/heads/main/EggSelection.lua"))()
local FruitSelection = loadstring(game:HttpGet("https://raw.githubusercontent.com/ZebuxHub/Main/refs/heads/main/FruitSelection.lua"))()
local FeedFruitSelection = loadstring(game:HttpGet("https://raw.githubusercontent.com/ZebuxHub/Main/refs/heads/main/FeedFruitSelection.lua"))()
local AutoFeedSystem = loadstring(game:HttpGet("https://raw.githubusercontent.com/ZebuxHub/Main/refs/heads/main/AutoFeedSystem.lua"))()
-- FruitStoreSystem functions are now implemented locally in the auto buy fruit section
local AutoQuestSystem = nil

-- UI state
local eggSelectionVisible = false
local fruitSelectionVisible = false
local feedFruitSelectionVisible = false




Tabs.AutoTab:Button({
    Title = "🥚 Open Egg Selection UI",
    Desc = "Open the modern glass-style egg selection interface",
    Callback = function()
        if not eggSelectionVisible then
            EggSelection.Show(
                function(selectedItems)
                    -- Handle selection changes
            selectedTypeSet = {}
                    selectedMutationSet = {}
                    
                    if selectedItems then
                        for itemId, isSelected in pairs(selectedItems) do
                            if isSelected then
                                -- Check if it's an egg or mutation
                                if EggData[itemId] then
                                    selectedTypeSet[itemId] = true
                                elseif MutationData[itemId] then
                                    selectedMutationSet[itemId] = true
                end
            end
                        end
                    end
                    
                    -- Auto-save the selections
                    updateCustomUISelection("eggSelections", {
                        eggs = selectedTypeSet,
                        mutations = selectedMutationSet
                    })
                end,
                function(isVisible)
                    eggSelectionVisible = isVisible
                end,
                selectedTypeSet, -- Pass saved egg selections
                selectedMutationSet -- Pass saved mutation selections
            )
            eggSelectionVisible = true
        else
            EggSelection.Hide()
            eggSelectionVisible = false
        end
    end
})



local autoBuyEnabled = false
local autoBuyThread = nil

-- Auto Feed variables
local autoFeedEnabled = false
local autoFeedThread = nil













local function shouldBuyEggInstance(eggInstance, playerMoney)
    if not eggInstance or not eggInstance:IsA("Model") then return false, nil, nil end
    
    -- Read Type first - check if this is the egg type we want
    local eggType = eggInstance:GetAttribute("Type")
        or eggInstance:GetAttribute("EggType")
        or eggInstance:GetAttribute("Name")
    if not eggType then return false, nil, nil end
    eggType = tostring(eggType)
    
    -- If eggs are selected, check if this is the type we want
    if selectedTypeSet and next(selectedTypeSet) then
    if not selectedTypeSet[eggType] then return false, nil, nil end
    end
    
    -- Now check mutation if mutations are selected
    if selectedMutationSet and next(selectedMutationSet) then
        local eggMutation = getEggMutationFromGUI(eggInstance.Name)
        
        if not eggMutation then
            -- If mutations are selected but egg has no mutation, skip this egg
            return false, nil, nil
        end
        
        -- Check if egg has a selected mutation
        if not selectedMutationSet[eggMutation] then
            return false, nil, nil
        end
    end

    -- Get price from hardcoded data or instance attribute
    local price = nil
    if EggData[eggType] then
        -- Convert price string to number (remove commas and convert to number)
        local priceStr = EggData[eggType].Price:gsub(",", "")
        price = tonumber(priceStr)
    end
    
    if not price then
        price = eggInstance:GetAttribute("Price") or getEggPriceByType(eggType)
    end
    
    if type(price) ~= "number" then return false, nil, nil end
    if playerMoney < price then return false, nil, nil end
    
    return true, eggInstance.Name, price
end

local function buyEggByUID(eggUID)
    local args = {
        "BuyEgg",
        eggUID
    }
    local ok, err = pcall(function()
        ReplicatedStorage:WaitForChild("Remote"):WaitForChild("CharacterRE"):FireServer(unpack(args))
    end)
    if not ok then
        warn("Failed to fire BuyEgg for UID " .. tostring(eggUID) .. ": " .. tostring(err))
    end
end

local function focusEggByUID(eggUID)
    local args = {
        "Focus",
        eggUID
    }
    local ok, err = pcall(function()
        ReplicatedStorage:WaitForChild("Remote"):WaitForChild("CharacterRE"):FireServer(unpack(args))
    end)
    if not ok then
        warn("Failed to fire Focus for UID " .. tostring(eggUID) .. ": " .. tostring(err))
    end
end

-- Event-driven Auto Buy system
local beltConnections = {}
local lastBeltChildren = {}
local buyingInProgress = false

local function cleanupBeltConnections()
    for _, conn in ipairs(beltConnections) do
        pcall(function() conn:Disconnect() end)
    end
    beltConnections = {}
end

-- Removed duplicate function - using the one with mutation logic above

local function buyEggInstantly(eggInstance)
    if buyingInProgress then return end
    buyingInProgress = true
    
    local netWorth = getPlayerNetWorth()
    local ok, uid, price = shouldBuyEggInstance(eggInstance, netWorth)
    
    if ok then
        -- Retry mechanism - try up to 3 times with delays
        local maxRetries = 3
        local retryCount = 0
        local buySuccess = false
        
        while retryCount < maxRetries and not buySuccess do
            retryCount = retryCount + 1
            
            -- Check if egg still exists and is still valid
            if not eggInstance or not eggInstance.Parent then

                break
            end
            
            -- Check if we still want to buy it (price might have changed)
            local stillOk, stillUid, stillPrice = shouldBuyEggInstance(eggInstance, getPlayerNetWorth())
            if not stillOk then

                break
            end
            
            -- Try to buy
            local buyResult = pcall(function()
        buyEggByUID(uid)
        focusEggByUID(uid)
            end)
            
            if buyResult then

                buySuccess = true
            else

                wait(0.5) -- Wait 0.5 seconds before retry
            end
        end
        
        if not buySuccess then
    
        end
    end
    
    buyingInProgress = false
end

local function setupBeltMonitoring(belt)
    if not belt then return end
    
    -- Monitor for new eggs appearing
    local function onChildAdded(child)
        if not autoBuyEnabled then return end
        if child:IsA("Model") then
            task.wait(0.1) -- Small delay to ensure attributes are set
            buyEggInstantly(child)
        end
    end
    
    -- Monitor existing eggs for price/money changes
    local function checkExistingEggs()
        if not autoBuyEnabled then return end
        local children = belt:GetChildren()
        for _, child in ipairs(children) do
            if child:IsA("Model") then
                buyEggInstantly(child)
            end
        end
    end
    
    -- Connect events
    table.insert(beltConnections, belt.ChildAdded:Connect(onChildAdded))
    
    -- Check existing eggs periodically
    local checkThread = task.spawn(function()
        while autoBuyEnabled do
            checkExistingEggs()
            task.wait(0.5) -- Check every 0.5 seconds
        end
    end)
    
    -- Store thread for cleanup
    beltConnections[#beltConnections + 1] = { disconnect = function() 
        if checkThread then
            task.cancel(checkThread)
            checkThread = nil 
        end
    end }
end

local function runAutoBuy()
    while autoBuyEnabled do
        local islandName = getAssignedIslandName()
        -- Status update removed

        if not islandName or islandName == "" then
            task.wait(1)
            continue
        end

        local activeBelt = getActiveBelt(islandName)
        if not activeBelt then
            task.wait(1)
            continue
        end

        -- Setup monitoring for this belt
        cleanupBeltConnections()
        setupBeltMonitoring(activeBelt)
        
        -- Wait until disabled or island changes
        while autoBuyEnabled do
            local currentIsland = getAssignedIslandName()
            if currentIsland ~= islandName then
                break -- Island changed, restart monitoring
            end
            task.wait(0.5)
        end
    end
    
    cleanupBeltConnections()
end

local autoBuyToggle = Tabs.AutoTab:Toggle({
    Title = "🥚 Auto Buy Eggs",
    Desc = "Instantly buys eggs as soon as they appear on the conveyor belt!",
    Value = false,
    Callback = function(state)
        autoBuyEnabled = state
        
        waitForSettingsReady(0.2)
        if state and not autoBuyThread then
            autoBuyThread = task.spawn(function()
                runAutoBuy()
                autoBuyThread = nil
            end)
            WindUI:Notify({ Title = "🥚 Auto Buy", Content = "Started - Watching for eggs! 🎉", Duration = 3 })
        elseif (not state) and autoBuyThread then
            cleanupBeltConnections()
            WindUI:Notify({ Title = "🥚 Auto Buy", Content = "Stopped", Duration = 3 })
        end
    end
})

-- Auto Feed Functions moved to AutoFeedSystem.lua

-- Event-driven Auto Place functionality
local placeConnections = {}
local placingInProgress = false
local availableEggs = {} -- Track available eggs to place
local availableTiles = {} -- Track available tiles
local selectedEggTypes = {} -- Selected egg types for placement
local selectedMutations = {} -- Selected mutations for placement
local tileMonitoringActive = false




-- Function to get egg options
local function getEggOptions()
    local eggOptions = {}
    
    -- Try to get from ResEgg config first
    local eggConfig = loadEggConfig()
    if eggConfig then
        for id, data in pairs(eggConfig) do
            if type(id) == "string" and not id:match("^_") and id ~= "_index" and id ~= "__index" then
                local eggName = data.Type or data.Name or id
                table.insert(eggOptions, eggName)
            end
        end
    end
    
    -- Fallback: get from PlayerBuiltBlocks
    if #eggOptions == 0 then
        local playerBuiltBlocks = workspace:FindFirstChild("PlayerBuiltBlocks")
        if playerBuiltBlocks then
            for _, egg in ipairs(playerBuiltBlocks:GetChildren()) do
                if egg:IsA("Model") then
                    local eggType = egg:GetAttribute("Type") or egg:GetAttribute("EggType") or egg:GetAttribute("Name")
                    if eggType and not table.find(eggOptions, eggType) then
                        table.insert(eggOptions, eggType)
                    end
                end
            end
        end
    end
    
    table.sort(eggOptions)
    return eggOptions
end

-- Egg selection dropdown
local placeEggDropdown = Tabs.PlaceTab:Dropdown({
    Title = "🥚 Pick Pet Types",
    Desc = "Choose which pets to place",
    Values = {"BasicEgg", "RareEgg", "SuperRareEgg", "EpicEgg", "LegendEgg", "PrismaticEgg", "HyperEgg", "VoidEgg", "BowserEgg", "DemonEgg", "CornEgg", "BoneDragonEgg", "UltraEgg", "DinoEgg", "FlyEgg", "UnicornEgg", "AncientEgg"},
    Value = {},
    Multi = true,
    AllowNone = true,
    Callback = function(selection)
        selectedEggTypes = selection
    end
})

-- Mutation selection dropdown for auto place
local placeMutationDropdown = Tabs.PlaceTab:Dropdown({
    Title = "🧬 Pick Mutations",
    Desc = "Choose which mutations to place (leave empty for all mutations)",
    Values = {"Golden", "Diamond", "Electric", "Fire", "Jurassic"},
    Value = {},
    Multi = true,
    AllowNone = true,
    Callback = function(selection)
        selectedMutations = selection
    end
})

-- Ensure dropdown selections are reflected in runtime variables after loading
local function syncAutoPlaceFiltersFromUI()
    local function coalesceSelection(element)
        if not element then return {} end
        -- Try common getter patterns
        local candidates = {
            function()
                if element.GetValue then return element:GetValue() end
            end,
            function()
                return element.Value
            end,
            function()
                if element.Get then return element:Get() end
            end,
            function()
                return element.Selected
            end,
            function()
                if element.GetSelected then return element:GetSelected() end
            end,
        }
        local raw
        for _, getter in ipairs(candidates) do
            local ok, val = pcall(getter)
            if ok and val ~= nil then raw = val break end
        end
        if type(raw) ~= "table" then return {} end
        -- Normalize to array of strings
        local arr = {}
        for i, v in ipairs(raw) do
            table.insert(arr, v)
        end
        if #arr > 0 then return arr end
        for k, v in pairs(raw) do
            if v == true then table.insert(arr, k) end
        end
        return arr
    end

    local eggs = coalesceSelection(placeEggDropdown)
    if #eggs > 0 then selectedEggTypes = eggs end

    local muts = coalesceSelection(placeMutationDropdown)
    if #muts > 0 then selectedMutations = muts end
end


local function updateAvailableEggs()
    local eggs = listAvailableEggUIDs()
    availableEggs = {}
    
    -- Create sets for faster lookup
    local selectedTypeSet = {}
        for _, type in ipairs(selectedEggTypes) do
        selectedTypeSet[type] = true
    end
    
    local selectedMutationSet = {}
    for _, mutation in ipairs(selectedMutations) do
        selectedMutationSet[mutation] = true
        end
        
        for _, eggInfo in ipairs(eggs) do
        local shouldInclude = true
        
        -- Check egg type filter
        if #selectedEggTypes > 0 then
            if not selectedTypeSet[eggInfo.type] then
                shouldInclude = false
            end
        end
        
        -- Check mutation filter (only if egg type passed)
        if shouldInclude and #selectedMutations > 0 then
            if not eggInfo.mutation or not selectedMutationSet[eggInfo.mutation] then
                shouldInclude = false
        end
    end
    
        if shouldInclude then
            table.insert(availableEggs, eggInfo)
        end
    end
    
    -- Status update removed
end

-- Comprehensive tile scanning system
local function scanAllTilesAndModels()
    local islandName = getAssignedIslandName()
    local islandNumber = getIslandNumberFromName(islandName)
    local farmParts = getFarmParts(islandNumber)
    
    local tileMap = {}
    local totalTiles = #farmParts
    local occupiedTiles = 0
    local lockedTiles = 0
    
    -- Initialize all tiles as available
    for i, part in ipairs(farmParts) do
        local surfacePos = Vector3.new(
            part.Position.X,
            part.Position.Y + 12, -- Eggs float 12 studs above tile surface
            part.Position.Z
        )
        tileMap[surfacePos] = {
            part = part,
            index = i,
            available = true,
            occupiedBy = nil,
            distance = 0
        }
    end
    
    -- Scan all floating models in PlayerBuiltBlocks
        local playerBuiltBlocks = workspace:FindFirstChild("PlayerBuiltBlocks")
        if playerBuiltBlocks then
            for _, model in ipairs(playerBuiltBlocks:GetChildren()) do
                if model:IsA("Model") then
                    local modelPos = model:GetPivot().Position
                
                -- Find which tile this model occupies
                for surfacePos, tileInfo in pairs(tileMap) do
                    if tileInfo.available then
                        -- Calculate distance to surface position
                        local xzDistance = math.sqrt((modelPos.X - surfacePos.X)^2 + (modelPos.Z - surfacePos.Z)^2)
                        local yDistance = math.abs(modelPos.Y - surfacePos.Y)
                        
                        -- If model is within placement range (more generous to avoid missing)
                        if xzDistance < 4.0 and yDistance < 20.0 then
                            tileInfo.available = false
                            tileInfo.occupiedBy = "egg"
                            tileInfo.distance = xzDistance
                        occupiedTiles = occupiedTiles + 1
                            break -- This tile is occupied, move to next model
                        end
                    end
                    end
                end
            end
        end
        
    -- Scan all pets in workspace.Pets
    local playerPets = getPlayerPetsInWorkspace()
    for _, petInfo in ipairs(playerPets) do
        local petPos = petInfo.position
        
        -- Find which tile this pet occupies
        for surfacePos, tileInfo in pairs(tileMap) do
            if tileInfo.available then
                -- Calculate distance to surface position
                local xzDistance = math.sqrt((petPos.X - surfacePos.X)^2 + (petPos.Z - surfacePos.Z)^2)
                local yDistance = math.abs(petPos.Y - surfacePos.Y)
                
                -- If pet is within placement range (more generous to avoid missing)
                if xzDistance < 4.0 and yDistance < 20.0 then
                    tileInfo.available = false
                    tileInfo.occupiedBy = "pet"
                    tileInfo.distance = xzDistance
                    occupiedTiles = occupiedTiles + 1
                    break -- This tile is occupied, move to next pet
                end
            end
        end
    end
    
    -- Count locked tiles
    local art = workspace:FindFirstChild("Art")
    if art then
        local island = art:FindFirstChild(islandName)
        if island then
            local locksFolder = island:FindFirstChild("ENV"):FindFirstChild("Locks")
            if locksFolder then
                for _, lockModel in ipairs(locksFolder:GetChildren()) do
                    if lockModel:IsA("Model") then
                        local farmPart = lockModel:FindFirstChild("Farm")
                        if farmPart and farmPart:IsA("BasePart") and farmPart.Transparency == 0 then
                            lockedTiles = lockedTiles + 1
                        end
                    end
                end
            end
        end
    end
    
    return tileMap, totalTiles, occupiedTiles, lockedTiles
end

local function updateAvailableTiles()
    local tileMap, totalTiles, occupiedTiles, lockedTiles = scanAllTilesAndModels()
    
    availableTiles = {}
    
    -- Collect all available tiles
    for surfacePos, tileInfo in pairs(tileMap) do
        if tileInfo.available then
            table.insert(availableTiles, { 
                part = tileInfo.part, 
                index = tileInfo.index,
                surfacePos = surfacePos
            })
        end
    end
    
    -- Status updates removed
    
    -- Status update removed
end


-- Place status format function removed per user request

-- Place status update function removed per user request

-- Check and remember which tiles are taken
-- Count actual placed pets in PlayerBuiltBlocks
local function countPlacedPets()
    local playerBuiltBlocks = workspace:FindFirstChild("PlayerBuiltBlocks")
    local count = 0
    if playerBuiltBlocks then
        for _, model in ipairs(playerBuiltBlocks:GetChildren()) do
            if model:IsA("Model") then
                local userId = model:GetAttribute("UserId")
                if userId and tonumber(userId) == Players.LocalPlayer.UserId then
                    count = count + 1
                end
            end
        end
    end
    return count
end

-- Event-driven placement system
local function cleanupPlaceConnections()
    for _, conn in ipairs(placeConnections) do
        pcall(function() conn:Disconnect() end)
    end
    placeConnections = {}
end




local function placeEggInstantly(eggInfo, tileInfo)
    if placingInProgress then return false end
    placingInProgress = true
    
    local petUID = eggInfo.uid
    local tilePart = tileInfo.part
    
    -- Final check: is tile still available?
    local playerBuiltBlocks = workspace:FindFirstChild("PlayerBuiltBlocks")
    if playerBuiltBlocks then
        for _, model in ipairs(playerBuiltBlocks:GetChildren()) do
            if model:IsA("Model") then
                local modelPos = model:GetPivot().Position
                local tilePos = tilePart.Position
                
                -- Calculate surface position (same as placement logic)
                local surfacePos = Vector3.new(
                    tilePos.X,
                    tilePos.Y + (tilePart.Size.Y / 2), -- Top surface
                    tilePos.Z
                )
                
                -- Separate X/Z and Y axis checks
                local xzDistance = math.sqrt((modelPos.X - surfacePos.X)^2 + (modelPos.Z - surfacePos.Z)^2)
                local yDistance = math.abs(modelPos.Y - surfacePos.Y)
                
                -- X/Z: 4 studs radius, Y: 8 studs radius
                if xzDistance < 4.0 and yDistance < 8.0 then
                    placingInProgress = false
                    return false
                end
            end
        end
    end
    
    -- Check for fully hatched pets in workspace.Pets
    local playerPets = getPlayerPetsInWorkspace()
    for _, petInfo in ipairs(playerPets) do
        local petPos = petInfo.position
        local tilePos = tilePart.Position
        
        -- Calculate surface position (same as placement logic)
        local surfacePos = Vector3.new(
            tilePos.X,
            tilePos.Y + 12, -- Eggs float 12 studs above tile surface
            tilePos.Z
        )
        
        -- Separate X/Z and Y axis checks
        local xzDistance = math.sqrt((petPos.X - surfacePos.X)^2 + (petPos.Z - surfacePos.Z)^2)
        local yDistance = math.abs(petPos.Y - surfacePos.Y)
        
        -- X/Z: 4 studs radius, Y: 8 studs radius
        if xzDistance < 4.0 and yDistance < 8.0 then
            placingInProgress = false
            return false
        end
    end
    
    -- Equip egg to Deploy S2
    local deploy = LocalPlayer.PlayerGui.Data:FindFirstChild("Deploy")
    if deploy then
        local eggUID = "Egg_" .. petUID
        deploy:SetAttribute("S2", eggUID)
    end
    
    -- Hold egg
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Two, false, game)
    task.wait(0.1)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Two, false, game)
    task.wait(0.1)
    
    -- Teleport to tile
    local char = Players.LocalPlayer.Character
    if char then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = CFrame.new(tilePart.Position)
            task.wait(0.1)
        end
    end
    
    -- Place egg on surface (top of the farm split tile)
    local surfacePosition = Vector3.new(
        tilePart.Position.X,
        tilePart.Position.Y + (tilePart.Size.Y / 2), -- Top surface
        tilePart.Position.Z
    )
    
    local args = {
        "Place",
        {
            DST = vector.create(surfacePosition.X, surfacePosition.Y, surfacePosition.Z),
            ID = petUID
        }
    }
    
    local success = pcall(function()
        ReplicatedStorage:WaitForChild("Remote"):WaitForChild("CharacterRE"):FireServer(unpack(args))
    end)
    
    if success then
        -- Verify placement
        task.wait(0.3)
        local placementConfirmed = false
        
        if playerBuiltBlocks then
            for _, model in ipairs(playerBuiltBlocks:GetChildren()) do
                if model:IsA("Model") and model.Name == petUID then
                    placementConfirmed = true
                    break
                end
            end
        end
        
        if placementConfirmed then
                    -- Placement successful
            
            -- Remove egg and tile from available lists
            for i, egg in ipairs(availableEggs) do
                if egg.uid == petUID then
                    table.remove(availableEggs, i)
                    break
                end
            end
            
            for i, tile in ipairs(availableTiles) do
                if tile.index == tileInfo.index then
                    table.remove(availableTiles, i)
                    break
                end
            end
            
            -- Status update removed
            placingInProgress = false
            return true
        else
            -- Placement failed
            -- Remove the failed tile from available tiles so we don't retry it
            for i, tile in ipairs(availableTiles) do
                if tile.index == tileInfo.index then
                    table.remove(availableTiles, i)
                    break
                end
            end
            -- Status update removed
            placingInProgress = false
            return false
        end
    else
                    -- Failed to fire placement
        -- Remove the failed tile from available tiles so we don't retry it
        for i, tile in ipairs(availableTiles) do
            if tile.index == tileInfo.index then
                table.remove(availableTiles, i)
                break
            end
        end
        -- Status update removed
        placingInProgress = false
        return false
    end
end

local function attemptPlacement()
    if #availableEggs == 0 then 
        warn("Auto Place stopped: No eggs available")
        return 
    end
    
    if #availableTiles == 0 then 
        warn("Auto Place stopped: No available tiles")
        return 
    end
    
    -- Place eggs on available tiles (limit to prevent lag)
    local placed = 0
    local attempts = 0
    local maxAttempts = math.min(#availableEggs, #availableTiles, 1) -- Limit to 5 attempts max
    
    while #availableEggs > 0 and #availableTiles > 0 and attempts < maxAttempts do
        attempts = attempts + 1
        
        -- Double-check tile is still available before placing
        local tileInfo = availableTiles[1]
        local isStillAvailable = true
        
        if tileInfo then
            local playerBuiltBlocks = workspace:FindFirstChild("PlayerBuiltBlocks")
            if playerBuiltBlocks then
                for _, model in ipairs(playerBuiltBlocks:GetChildren()) do
                    if model:IsA("Model") then
                        local modelPos = model:GetPivot().Position
                        local tilePos = tileInfo.part.Position
                        
                        -- Calculate surface position (same as placement logic)
                        local surfacePos = Vector3.new(
                            tilePos.X,
                            tilePos.Y + 12, -- Eggs float 12 studs above tile surface
                            tilePos.Z
                        )
                        
                        -- Separate X/Z and Y axis checks
                        local xzDistance = math.sqrt((modelPos.X - surfacePos.X)^2 + (modelPos.Z - surfacePos.Z)^2)
                        local yDistance = math.abs(modelPos.Y - surfacePos.Y)
                        
                        -- X/Z: 4 studs radius, Y: 8 studs radius
                        if xzDistance < 4.0 and yDistance < 8.0 then
                            isStillAvailable = false
                            break
                        end
                    end
                end
            end
            
            -- Check for fully hatched pets in workspace.Pets
            if isStillAvailable then
                local playerPets = getPlayerPetsInWorkspace()
                for _, petInfo in ipairs(playerPets) do
                    local petPos = petInfo.position
                    local tilePos = tileInfo.part.Position
                    
                    -- Calculate surface position (same as placement logic)
                    local surfacePos = Vector3.new(
                        tilePos.X,
                        tilePos.Y + 12, -- Eggs float 12 studs above tile surface
                        tilePos.Z
                    )
                    
                    -- Separate X/Z and Y axis checks
                    local xzDistance = math.sqrt((petPos.X - surfacePos.X)^2 + (petPos.Z - surfacePos.Z)^2)
                    local yDistance = math.abs(petPos.Y - surfacePos.Y)
                    
                    -- X/Z: 4 studs radius, Y: 8 studs radius
                    if xzDistance < 4.0 and yDistance < 8.0 then
                        isStillAvailable = false
                        break
                    end
                end
            end
        end
        
        if isStillAvailable then
            if placeEggInstantly(availableEggs[1], availableTiles[1]) then
                placed = placed + 1
                task.wait(0.2) -- Longer delay between successful placements
            else
                -- Placement failed, tile was removed from availableTiles
                task.wait(0.1) -- Quick retry
            end
        else
            -- Tile is no longer available, remove it
            table.remove(availableTiles, 1)
        end
    end
    
    -- Placement attempt completed
end

local function setupPlacementMonitoring()
    -- Monitor for new eggs in PlayerGui.Data.Egg
    local eggContainer = getEggContainer()
    if eggContainer then
        local function onEggAdded(child)
            if not autoPlaceEnabled then return end
            if #child:GetChildren() == 0 then -- No subfolder = available egg
                task.wait(0.2) -- Wait for attributes to be set
                updateAvailableEggs()
                attemptPlacement()
            end
        end
        
        local function onEggRemoved(child)
            if not autoPlaceEnabled then return end
            updateAvailableEggs()
        end
        
        table.insert(placeConnections, eggContainer.ChildAdded:Connect(onEggAdded))
        table.insert(placeConnections, eggContainer.ChildRemoved:Connect(onEggRemoved))
    end
    
    -- Monitor for new tiles becoming available (when pets are removed from PlayerBuiltBlocks)
    local playerBuiltBlocks = workspace:FindFirstChild("PlayerBuiltBlocks")
    if playerBuiltBlocks then
        local function onBlockChanged()
            if not autoPlaceEnabled then return end
            task.wait(0.2)
            updateAvailableTiles()
            attemptPlacement()
        end
        
        table.insert(placeConnections, playerBuiltBlocks.ChildAdded:Connect(onBlockChanged))
        table.insert(placeConnections, playerBuiltBlocks.ChildRemoved:Connect(onBlockChanged))
    end
    
    -- Monitor for pets in workspace (when pets hatch and appear in workspace.Pets)
    local workspacePets = workspace:FindFirstChild("Pets")
    if workspacePets then
        local function onPetChanged()
            if not autoPlaceEnabled then return end
            task.wait(0.2)
            updateAvailableTiles()
            attemptPlacement()
        end
        
        table.insert(placeConnections, workspacePets.ChildAdded:Connect(onPetChanged))
        table.insert(placeConnections, workspacePets.ChildRemoved:Connect(onPetChanged))
    end
    
    -- More frequent periodic updates to handle continuous placement
    local updateThread = task.spawn(function()
        while autoPlaceEnabled do
            updateAvailableEggs()
            updateAvailableTiles()
            attemptPlacement()
            task.wait(1.5) -- Update every 1.5 seconds for better responsiveness
        end
    end)
    
    table.insert(placeConnections, { disconnect = function() updateThread = nil end })
end

local function runAutoPlace()
    while autoPlaceEnabled do
        -- Check priority - if Auto Hatch is running and has priority, pause placing
        -- But allow Auto Place to work if Auto Hatch has no eggs to work with
        -- Priority system removed
        
        local islandName = getAssignedIslandName()
        -- Status update removed
        
        if not islandName or islandName == "" then
            task.wait(1)
            continue
        end
        
        -- Setup monitoring
        cleanupPlaceConnections()
        setupPlacementMonitoring()
        
        -- Wait until disabled or island changes
        while autoPlaceEnabled do
            -- Priority system removed
            
            local currentIsland = getAssignedIslandName()
            if currentIsland ~= islandName then
                break -- Island changed, restart monitoring
            end
            task.wait(0.5)
        end
    end
    
    cleanupPlaceConnections()
end

local autoPlaceToggle = Tabs.PlaceTab:Toggle({
    Title = "🏠 Auto Place Pets",
    Desc = "Automatically places your pets on empty farm tiles!",
    Value = false,
    Callback = function(state)
        autoPlaceEnabled = state
        
        waitForSettingsReady(0.2)
        -- Re-sync filters at the moment auto place is toggled to on
        if state then
            syncAutoPlaceFiltersFromUI()
            -- Prime available lists and try an immediate placement
            pcall(function()
                updateAvailableEggs()
                updateAvailableTiles()
                attemptPlacement()
            end)
        end
        if state and not autoPlaceThread then
            -- Check if Auto Hatch is running and we have lower priority
            -- Priority system removed
            -- Reset counters
            
            autoPlaceThread = task.spawn(function()
                runAutoPlace()
                autoPlaceThread = nil
            end)
            WindUI:Notify({ Title = "🏠 Auto Place", Content = "Started - Placing pets automatically! 🎉", Duration = 3 })
        elseif (not state) and autoPlaceThread then
            cleanupPlaceConnections()
            WindUI:Notify({ Title = "🏠 Auto Place", Content = "Stopped", Duration = 3 })
        end
    end
})




-- Auto Unlock Tile functionality
local autoUnlockEnabled = false
local autoUnlockThread = nil



-- Function to get all locked tiles
local function getLockedTiles()
    local lockedTiles = {}
    local islandName = getAssignedIslandName()
    
    if not islandName then return lockedTiles end
    
    local art = workspace:FindFirstChild("Art")
    if not art then return lockedTiles end
    
    local island = art:FindFirstChild(islandName)
    if not island then return lockedTiles end
    
    local env = island:FindFirstChild("ENV")
    if not env then return lockedTiles end
    
    local locksFolder = env:FindFirstChild("Locks")
    if not locksFolder then return lockedTiles end
    
    for _, lockModel in ipairs(locksFolder:GetChildren()) do
        if lockModel:IsA("Model") then
            local farmPart = lockModel:FindFirstChild("Farm")
            if farmPart and farmPart:IsA("BasePart") then
                -- Check if this lock is active (transparency = 0 means locked)
                if farmPart.Transparency == 0 then
                    local lockCost = farmPart:GetAttribute("LockCost")
                    table.insert(lockedTiles, {
                        modelName = lockModel.Name,
                        farmPart = farmPart,
                        cost = lockCost
                    })
                end
            end
        end
    end
    
    return lockedTiles
end

-- Function to unlock a specific tile
local function unlockTile(lockInfo)
    if not lockInfo then return false end
    
    local args = {
        "Unlock",
        lockInfo.farmPart
    }
    
    local success = pcall(function()
        ReplicatedStorage:WaitForChild("Remote"):WaitForChild("CharacterRE"):FireServer(unpack(args))
    end)
    
    return success
end

local function runAutoUnlock()
    while autoUnlockEnabled do
        local ok, err = pcall(function()
            local lockedTiles = getLockedTiles()
            
            if #lockedTiles == 0 then
                task.wait(2)
                return
            end
            
            -- Count affordable locks
            local affordableCount = 0
            local netWorth = getPlayerNetWorth()
            for _, lockInfo in ipairs(lockedTiles) do
                local cost = tonumber(lockInfo.cost) or 0
                if netWorth >= cost then
                    affordableCount = affordableCount + 1
                end
            end
            
            if affordableCount == 0 then
                task.wait(2)
                return
            end
            
            -- Try to unlock affordable tiles
            for _, lockInfo in ipairs(lockedTiles) do
                if not autoUnlockEnabled then break end
                
                local cost = tonumber(lockInfo.cost) or 0
                if netWorth >= cost then
                    if unlockTile(lockInfo) then
                        task.wait(0.5) -- Wait between unlocks
                    else
                        task.wait(0.2)
                    end
                end
            end
            
            task.wait(3) -- Wait before next scan
            
        end)
        
        if not ok then
            warn("Auto Unlock error: " .. tostring(err))
            task.wait(1)
        end
    end
end

local autoUnlockToggle = Tabs.PlaceTab:Toggle({
    Title = "🔓 Auto Unlock Tiles",
    Desc = "Automatically unlock tiles when you have enough money",
    Value = false,
    Callback = function(state)
        autoUnlockEnabled = state
        
        waitForSettingsReady(0.2)
        if state and not autoUnlockThread then
            autoUnlockThread = task.spawn(function()
                runAutoUnlock()
                autoUnlockThread = nil
            end)
            WindUI:Notify({ Title = "🔓 Auto Unlock", Content = "Started unlocking tiles! 🎉", Duration = 3 })
        elseif (not state) and autoUnlockThread then
            WindUI:Notify({ Title = "🔓 Auto Unlock", Content = "Stopped", Duration = 3 })
        end
    end
})



Tabs.PlaceTab:Button({
    Title = "🔓 Unlock All Affordable Now",
    Desc = "Unlock all tiles you can afford right now",
    Callback = function()
        local lockedTiles = getLockedTiles()
        local netWorth = getPlayerNetWorth()
        local unlockedCount = 0
        
        for _, lockInfo in ipairs(lockedTiles) do
            local cost = tonumber(lockInfo.cost) or 0
            if netWorth >= cost then
                if unlockTile(lockInfo) then
                    unlockedCount = unlockedCount + 1
                    task.wait(0.1)
                end
            end
        end
        
        WindUI:Notify({ 
            Title = "🔓 Unlock Complete", 
            Content = string.format("Unlocked %d tiles! 🎉", unlockedCount), 
            Duration = 3 
        })
    end
})

 

-- Auto Delete functionality
local autoDeleteEnabled = false
local autoDeleteThread = nil
local deleteSpeedThreshold = 100 -- Default speed threshold



local autoDeleteSpeedSlider = Tabs.PlaceTab:Input({
    Title = "Speed Threshold",
    Desc = "Delete pets with speed below this value",
    Value = "100",
    Callback = function(value)
        deleteSpeedThreshold = tonumber(value) or 100
    end
})

-- Auto Delete function
local function runAutoDelete()
    while autoDeleteEnabled do
        local ok, err = pcall(function()
            -- Get all pets in workspace.Pets
            local petsFolder = workspace:FindFirstChild("Pets")
            if not petsFolder then
                task.wait(1)
                return
            end
            
            local playerUserId = Players.LocalPlayer.UserId
            local petsToDelete = {}
            local scannedCount = 0
            
            -- Scan all pets and check their speed
            for _, pet in ipairs(petsFolder:GetChildren()) do
                if not autoDeleteEnabled then break end
                
                if pet:IsA("Model") then
                    scannedCount = scannedCount + 1
                    
                    -- Check if pet belongs to player
                    local petUserId = pet:GetAttribute("UserId")
                    if petUserId and tonumber(petUserId) == playerUserId then
                        -- Check pet's speed
                        local rootPart = pet:FindFirstChild("RootPart")
                        if rootPart then
                            local idleGUI = rootPart:FindFirstChild("GUI/IdleGUI", true)
                            if idleGUI then
                                local speedText = idleGUI:FindFirstChild("Speed")
                                if speedText and speedText:IsA("TextLabel") then
                                    -- Parse speed from format like "$100/s"
                                    local speedTextValue = speedText.Text
                                    local speedValue = tonumber(string.match(speedTextValue, "%d+"))
                                    if speedValue and speedValue < deleteSpeedThreshold then
                                        table.insert(petsToDelete, {
                                            name = pet.Name,
                                            speed = speedValue
                                        })
                                    end
                                end
                            end
                        end
                    end
                end
            end
            
            if #petsToDelete == 0 then
                task.wait(2)
                return
            end
            
            -- Delete pets one by one
            for i, petInfo in ipairs(petsToDelete) do
                if not autoDeleteEnabled then break end
                
                -- Deleting pet
                
                -- Fire delete remote
                local args = {
                    "Del",
                    petInfo.name
                }
                
                local success = pcall(function()
                    ReplicatedStorage:WaitForChild("Remote"):WaitForChild("CharacterRE"):FireServer(unpack(args))
                end)
                
                if success then
                    task.wait(0.5) -- Wait between deletions
                else
                    task.wait(0.2)
                end
            end
            
            task.wait(3) -- Wait before next scan
            
        end)
        
        if not ok then
            warn("Auto Delete error: " .. tostring(err))
            task.wait(1)
        end
    end
end

local autoDeleteToggle = Tabs.PlaceTab:Toggle({
    Title = "Auto Delete",
    Desc = "Automatically delete slow pets (only your pets)",
    Value = false,
    Callback = function(state)
        autoDeleteEnabled = state
        
        waitForSettingsReady(0.2)
        if state and not autoDeleteThread then
            autoDeleteThread = task.spawn(function()
                runAutoDelete()
                autoDeleteThread = nil
            end)
            WindUI:Notify({ Title = "Auto Delete", Content = "Started", Duration = 3 })
        elseif (not state) and autoDeleteThread then
            WindUI:Notify({ Title = "Auto Delete", Content = "Stopped", Duration = 3 })
        end
    end
})



-- Enhanced Open Button UI
Window:EditOpenButton({
    Title = "Build A Zoo",
    Icon = "monitor",
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 2,
    Color = ColorSequence.new( -- gradient
        Color3.fromHex("FF0F7B"), 
        Color3.fromHex("F89B29")
    ),
    OnlyMobile = false,
    Enabled = true,
    Draggable = true,
})

-- Close callback
Window:OnClose(function()
    autoBuyEnabled = false
    autoPlaceEnabled = false
    autoFeedEnabled = false
end)


-- ============ Auto Claim Dino (every 10 minutes) ============
local autoDinoEnabled = false
local autoDinoThread = nil
local lastDinoAt = 0

local function fireDinoClaim()
    local ok, err = pcall(function()
        ReplicatedStorage:WaitForChild("Remote"):WaitForChild("DinoEventRE"):FireServer({ event = "onlinepack" })
    end)
    if not ok then warn("DinoClaim fire failed: " .. tostring(err)) end
    return ok
end

local function getDinoClaimText()
    local pg = LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui")
    if not pg then return nil end
    local gui = pg:FindFirstChild("ScreenDinoOnLinePack")
    if not gui then return nil end
    local root = gui:FindFirstChild("Root")
    if not root then return nil end
    local freeBtn = root:FindFirstChild("FreeBtn")
    if not freeBtn then return nil end
    local frame = freeBtn:FindFirstChild("Frame")
    if not frame then return nil end
    local count = frame:FindFirstChild("Count")
    if count and count:IsA("TextLabel") then
        return count.Text
    end
    return nil
end

local function getDinoProgressText()
    local pg = LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui")
    if not pg then return nil end
    local gui = pg:FindFirstChild("ScreenDinoOnLinePack")
    if not gui then return nil end
    local root = gui:FindFirstChild("Root")
    if not root then return nil end
    local bar = root:FindFirstChild("ProgressBar")
    if not bar then return nil end
    local textHolder = bar:FindFirstChild("Text")
    if not textHolder then return nil end
    local label = textHolder:FindFirstChild("Text")
    if label and label:IsA("TextLabel") then
        return label.Text
    end
    return nil
end

local function parseMMSS(str)
    if type(str) ~= "string" then return nil end
    local m, s = str:match("^(%d+):(%d+)$")
    if not m then return nil end
    local mi = tonumber(m)
    local si = tonumber(s)
    if not mi or not si then return nil end
    return mi * 60 + si
end

local function canClaimDino()
    -- Check if claim count shows "Claim(x0)" - if so, don't claim
    local claimText = getDinoClaimText()
    if claimText then
        if string.find(claimText, "Claim%(x0%)") or string.find(claimText, "Claim%(0%)") then
            return false, "No claims remaining"
        end
    end
    
    -- If claim text exists and doesn't show "Claim(x0)", allow claiming
    if claimText and claimText ~= "" then
        return true, "Ready to claim"
    end
    
    return false, "Cannot read claim status"
end

local function runAutoDino()
    while autoDinoEnabled do
        local canClaim, reason = canClaimDino()
        
        if canClaim then
            if os.clock() - (lastDinoAt or 0) > 2 then -- small debounce window
                if fireDinoClaim() then
                    lastDinoAt = os.clock()
                    WindUI:Notify({ Title = "🦕 Auto Claim Dino", Content = "Dino pack claimed! 🎉", Duration = 3 })
                end
            end
            task.wait(2)
        else
            task.wait(1)
        end
    end
end

local autoDinoToggle = Tabs.PackTab:Toggle({
    Title = "🦕 Auto Claim Dino",
    Desc = "Automatically claims dino packs when ready (checks claim count)",
    Value = false,
    Callback = function(state)
        autoDinoEnabled = state
        
        waitForSettingsReady(0.2)
        if state and not autoDinoThread then
            autoDinoThread = task.spawn(function()
                runAutoDino()
                autoDinoThread = nil
            end)
            WindUI:Notify({ Title = "🦕 Auto Claim Dino", Content = "Started claiming dino packs! 🎉", Duration = 3 })
        elseif (not state) and autoDinoThread then
            WindUI:Notify({ Title = "🦕 Auto Claim Dino", Content = "Stopped", Duration = 3 })
        end
    end
})



Tabs.PackTab:Button({
    Title = "🦕 Claim Dino Now",
    Desc = "Claim dino pack right now (if available)",
    Callback = function()
        local canClaim, reason = canClaimDino()
        if canClaim then
            if fireDinoClaim() then
                lastDinoAt = os.clock()
                WindUI:Notify({ Title = "🦕 Claim Dino", Content = "Dino pack claimed! 🎉", Duration = 3 })
            end
        else
            WindUI:Notify({ Title = "🦕 Claim Dino", Content = "Cannot claim: " .. reason, Duration = 3 })
        end
    end
})

Tabs.PackTab:Button({
    Title = "🔍 Check Dino Status",
    Desc = "Check current dino pack status",
    Callback = function()
        local claimText = getDinoClaimText() or "Unknown"
        local progressText = getDinoProgressText() or "Unknown"
        local canClaim, reason = canClaimDino()
        
        local message = string.format("🦕 Dino Pack Status:\n")
        message = message .. string.format("📊 Claim Text: %s\n", claimText)
        message = message .. string.format("⏰ Progress: %s\n", progressText)
        message = message .. string.format("✅ Can Claim: %s\n", tostring(canClaim))
        message = message .. string.format("💬 Reason: %s", reason)
        
        WindUI:Notify({ Title = "🔍 Dino Status", Content = message, Duration = 8 })
    end
})

-- ============ Shop / Auto Upgrade ============
Tabs.ShopTab:Section({ Title = "🛒 Auto Upgrade Conveyor", Icon = "arrow-up" })
local shopStatus = { lastAction = "Ready to upgrade!", upgradesTried = 0, upgradesDone = 0 }
local shopParagraph = Tabs.ShopTab:Paragraph({ Title = "🛒 Shop Status", Desc = "Shows upgrade progress", Image = "activity", ImageSize = 22 })
local function setShopStatus(msg)
    shopStatus.lastAction = msg
    if shopParagraph and shopParagraph.SetDesc then
        shopParagraph:SetDesc(string.format("Upgrades: %d done\nLast: %s", shopStatus.upgradesDone, shopStatus.lastAction))
    end
end

local function parseConveyorIndexFromId(idStr)
    local n = tostring(idStr):match("(%d+)")
    return n and tonumber(n) or nil
end

-- Remember upgrades we have already bought in this session
local purchasedUpgrades = {}

local function chooseAffordableUpgrades(netWorth)
    local actions = {}
    for key, entry in pairs(conveyorConfig) do
        if type(entry) == "table" then
            local cost = entry.Cost or entry.Price or (entry.Base and entry.Base.Price)
            if type(cost) == "string" then
                local clean = tostring(cost):gsub("[^%d%.]", "")
                cost = tonumber(clean)
            end
            local idLike = entry.ID or entry.Id or entry.Name or key
            local idx = parseConveyorIndexFromId(idLike)
            if idx and type(cost) == "number" and netWorth >= cost and idx >= 1 and idx <= 9 and not purchasedUpgrades[idx] then
                table.insert(actions, { idx = idx, cost = cost })
            end
        end
    end
    table.sort(actions, function(a, b) return a.idx < b.idx end)
    return actions
end

local autoUpgradeEnabled = false
local autoUpgradeThread = nil
local autoUpgradeToggle = Tabs.ShopTab:Toggle({
    Title = "🛒 Auto Upgrade Conveyor",
    Desc = "Automatically upgrades conveyor when you have enough money",
    Value = false,
    Callback = function(state)
        autoUpgradeEnabled = state
        
        waitForSettingsReady(0.2)
        if state and not autoUpgradeThread then
            autoUpgradeThread = task.spawn(function()
                -- Ensure conveyor config is loaded
                if not conveyorConfig or not next(conveyorConfig) then
                    loadConveyorConfig()
                end
                while autoUpgradeEnabled do
                    -- Attempt reload if config still not present
                    if not conveyorConfig or not next(conveyorConfig) then
                        setShopStatus("Waiting for config...")
                        loadConveyorConfig()
                        task.wait(1)
                        -- continue loop
                    end
                    local net = getPlayerNetWorth()
                    local actions = chooseAffordableUpgrades(net)
                    if #actions == 0 then
                        setShopStatus("Waiting for money (NetWorth " .. tostring(net) .. ")")
                        task.wait(0.8)
                    else
                        for _, a in ipairs(actions) do
                            setShopStatus(string.format("Upgrading %d (cost %s)", a.idx, tostring(a.cost)))
                            if fireConveyorUpgrade(a.idx) then
                                shopStatus.upgradesDone += 1
                                purchasedUpgrades[a.idx] = true
                            end
                            shopStatus.upgradesTried += 1
                            task.wait(0.2)
                        end
                    end
                end
            end)
            setShopStatus("Started upgrading!")
            WindUI:Notify({ Title = "🛒 Shop", Content = "Auto upgrade started! 🎉", Duration = 3 })
        elseif (not state) and autoUpgradeThread then
            WindUI:Notify({ Title = "🛒 Shop", Content = "Auto upgrade stopped", Duration = 3 })
            setShopStatus("Stopped")
        end
    end
})



Tabs.ShopTab:Button({
    Title = "🛒 Upgrade All Now",
    Desc = "Upgrade everything you can afford right now",
    Callback = function()
        local net = getPlayerNetWorth()
        local actions = chooseAffordableUpgrades(net)
        if #actions == 0 then
            setShopStatus("No upgrades affordable (NetWorth " .. tostring(net) .. ")")
            return
        end
        for _, a in ipairs(actions) do
            if fireConveyorUpgrade(a.idx) then
                shopStatus.upgradesDone += 1
                purchasedUpgrades[a.idx] = true
            end
            shopStatus.upgradesTried += 1
            task.wait(0.1)
        end
        setShopStatus("Upgraded " .. tostring(#actions) .. " items!")
    end
})

Tabs.ShopTab:Button({
    Title = "🔄 Reset Upgrade Memory",
    Desc = "Clear upgrade memory to try again",
    Callback = function()
        purchasedUpgrades = {}
        setShopStatus("Memory reset!")
        WindUI:Notify({ Title = "🛒 Shop", Content = "Upgrade memory cleared!", Duration = 3 })
    end
})



-- ============ Fruit Market (Auto Buy Fruit) ============
-- Load Fruit Selection UI
local FruitSelection = loadstring(game:HttpGet("https://raw.githubusercontent.com/ZebuxHub/Main/refs/heads/main/FruitSelection.lua"))()

-- Fruit Data for auto buy functionality
local FruitData = {
    Strawberry = { Price = "5,000" },
    Blueberry = { Price = "20,000" },
    Watermelon = { Price = "80,000" },
    Apple = { Price = "400,000" },
    Orange = { Price = "1,200,000" },
    Corn = { Price = "3,500,000" },
    Banana = { Price = "12,000,000" },
    Grape = { Price = "50,000,000" },
    Pear = { Price = "200,000,000" },
    Pineapple = { Price = "600,000,000" },
    GoldMango = { Price = "2,000,000,000" },
    BloodstoneCycad = { Price = "8,000,000,000" },
    ColossalPinecone = { Price = "40,000,000,000" },
    VoltGinkgo = { Price = "80,000,000,000" }
}

-- Helper functions moved to FruitStoreSystem.lua

-- Fruit selection state
local fruitSelectionVisible = false

-- Fruit auto buy status removed per user request

-- Fruit status display removed per user request

Tabs.FruitTab:Button({
    Title = "🍎 Open Fruit Selection UI",
    Desc = "Open the modern glass-style fruit selection interface",
    Callback = function()
        if not fruitSelectionVisible then
            FruitSelection.Show(
                function(selectedItems)
                    -- Handle selection changes
                    selectedFruits = selectedItems
                    updateCustomUISelection("fruitSelections", selectedItems)
                end,
                function(isVisible)
                    fruitSelectionVisible = isVisible
                end,
                selectedFruits -- Pass saved fruit selections
            )
            fruitSelectionVisible = true
        else
            FruitSelection.Hide()
            fruitSelectionVisible = false
        end
    end
})

-- Auto Buy Fruit functionality
local autoBuyFruitEnabled = false
local autoBuyFruitThread = nil

-- Helper functions for fruit buying
local function getPlayerNetWorth()
    local player = Players.LocalPlayer
    if not player then return 0 end
    
    -- First try to get from Attributes (as you mentioned)
    local attrValue = player:GetAttribute("NetWorth")
    if type(attrValue) == "number" then
        return attrValue
    end
    
    -- Fallback to leaderstats
    local leaderstats = player:FindFirstChild("leaderstats")
    if not leaderstats then return 0 end
    
    local netWorth = leaderstats:FindFirstChild("NetWorth")
    if not netWorth then return 0 end
    
    return netWorth.Value or 0
end

local function parsePrice(priceStr)
    if type(priceStr) == "number" then
        return priceStr
    end
    local cleanPrice = priceStr:gsub(",", "")
    return tonumber(cleanPrice) or 0
end

local function getFoodStoreUI()
    local player = Players.LocalPlayer
    if not player then return nil end
    
    local playerGui = player:FindFirstChild("PlayerGui")
    if not playerGui then return nil end
    
    return playerGui:FindFirstChild("ScreenFoodStore")
end

local function getFoodStoreLST()
    local player = Players.LocalPlayer
    if not player then return nil end
    
    local playerGui = player:FindFirstChild("PlayerGui")
    if not playerGui then return nil end
    
    local data = playerGui:FindFirstChild("Data")
    if not data then return nil end
    
    local foodStore = data:FindFirstChild("FoodStore")
    if not foodStore then return nil end
    
    local lst = foodStore:FindFirstChild("LST")
    return lst
end

local function isFruitInStock(fruitId)
    local lst = getFoodStoreLST()
    if not lst then return false end
    
    -- Try different possible key formats
    local candidates = {fruitId, string.lower(fruitId), string.upper(fruitId)}
    local underscoreVersion = fruitId:gsub(" ", "_")
    table.insert(candidates, underscoreVersion)
    table.insert(candidates, string.lower(underscoreVersion))
    
    for _, candidate in ipairs(candidates) do
        -- First try to get from Attributes (as you mentioned)
        local stockValue = lst:GetAttribute(candidate)
        if type(stockValue) == "number" and stockValue > 0 then
            return true
        end
        
        -- Fallback to TextLabel
        local stockLabel = lst:FindFirstChild(candidate)
        if stockLabel and stockLabel:IsA("TextLabel") then
            local stockText = stockLabel.Text
            local stockNumber = tonumber(stockText:match("%d+"))
            if stockNumber and stockNumber > 0 then
                return true
            end
        end
    end
    
    return false
end

local autoBuyFruitToggle = Tabs.FruitTab:Toggle({
    Title = "🍎 Auto Buy Fruit",
    Desc = "Automatically buy selected fruits when you have enough money",
    Value = false,
    Callback = function(state)
        autoBuyFruitEnabled = state
        
        waitForSettingsReady(0.2)
        if state and not autoBuyFruitThread then
            autoBuyFruitThread = task.spawn(function()
                while autoBuyFruitEnabled do
                    -- Auto buy fruit logic
                    if selectedFruits and next(selectedFruits) then
                        local netWorth = getPlayerNetWorth()
                        local boughtAny = false
                        
                        for fruitId, _ in pairs(selectedFruits) do
                            if FruitData[fruitId] then
                                local fruitPrice = parsePrice(FruitData[fruitId].Price)
                                
                                -- Check if fruit is in stock
                                if not isFruitInStock(fruitId) then
                                    task.wait(0.5)
                                else
                                    -- Check if player can afford it
                                    if netWorth < fruitPrice then
                                        task.wait(0.5)
                                    else
                                        -- Try to buy the fruit
                                        local success = pcall(function()
                                            -- Fire the fruit buying remote
                                            local args = {fruitId}
                                            ReplicatedStorage:WaitForChild("Remote"):WaitForChild("FoodStoreRE"):FireServer(unpack(args))
                                        end)
                                        
                                        if success then
                                            boughtAny = true
                                        end
                                        
                                        task.wait(0.5) -- Wait between each fruit purchase
                                    end
                                end
                            end
                        end
                        
                        -- If no fruits were bought, wait longer before next attempt
                        if not boughtAny then
                            task.wait(2)
                        else
                            task.wait(1) -- Shorter wait if we bought something
                        end
                    else
                        task.wait(2)
                    end
        end
    end)
            WindUI:Notify({ Title = "🍎 Auto Buy Fruit", Content = "Started buying fruits! 🎉", Duration = 3 })
        elseif (not state) and autoBuyFruitThread then
            WindUI:Notify({ Title = "🍎 Auto Buy Fruit", Content = "Stopped", Duration = 3 })
        end
    end
})



 



 

 

 

-- ============ WindUI ConfigManager System ============

-- 1. Load ConfigManager
local ConfigManager = Window.ConfigManager

-- 2. Create Config File
local zebuxConfig = ConfigManager:CreateConfig("zebuxConfig")

-- Custom UI selections storage (separate from WindUI config)
local customSelections = {
    eggSelections = {},
    fruitSelections = {},
    feedFruitSelections = {}
}

-- Function to save custom UI selections
local function saveCustomSelections()
    local success, err = pcall(function()
        local jsonData = game:GetService("HttpService"):JSONEncode(customSelections)
        writefile("Zebux_CustomSelections.json", jsonData)
    end)
    
    if not success then
        warn("Failed to save custom selections: " .. tostring(err))
    end
end

-- Function to load custom UI selections
local function loadCustomSelections()
    local success, err = pcall(function()
        if isfile("Zebux_CustomSelections.json") then
            local jsonData = readfile("Zebux_CustomSelections.json")
            local loaded = game:GetService("HttpService"):JSONDecode(jsonData)
            if loaded then
                customSelections = loaded
                
                -- Apply loaded selections to variables
                if customSelections.eggSelections then
                    selectedTypeSet = {}
                    for _, eggId in ipairs(customSelections.eggSelections.eggs or {}) do
                        selectedTypeSet[eggId] = true
                    end
                    selectedMutationSet = {}
                    for _, mutationId in ipairs(customSelections.eggSelections.mutations or {}) do
                        selectedMutationSet[mutationId] = true
                    end
                end
                
                if customSelections.fruitSelections then
                    selectedFruits = {}
                    for _, fruitId in ipairs(customSelections.fruitSelections or {}) do
                        selectedFruits[fruitId] = true
                    end
                end
                
                if customSelections.feedFruitSelections then
                    selectedFeedFruits = {}
                    for _, fruitId in ipairs(customSelections.feedFruitSelections or {}) do
                        selectedFeedFruits[fruitId] = true
                    end
                end
            end
        end
    end)
    
    if not success then
        warn("Failed to load custom selections: " .. tostring(err))
    end
end

-- Function to update custom UI selections
updateCustomUISelection = function(uiType, selections)
    if uiType == "eggSelections" then
        customSelections.eggSelections = {
            eggs = {},
            mutations = {}
        }
        for eggId, _ in pairs(selections.eggs or {}) do
            table.insert(customSelections.eggSelections.eggs, eggId)
        end
        for mutationId, _ in pairs(selections.mutations or {}) do
            table.insert(customSelections.eggSelections.mutations, mutationId)
        end
    elseif uiType == "fruitSelections" then
        customSelections.fruitSelections = {}
        for fruitId, _ in pairs(selections) do
            table.insert(customSelections.fruitSelections, fruitId)
        end
    elseif uiType == "feedFruitSelections" then
        customSelections.feedFruitSelections = {}
        for fruitId, _ in pairs(selections) do
            table.insert(customSelections.feedFruitSelections, fruitId)
        end
    end
    
    saveCustomSelections()
end

-- Register all UI elements with WindUI ConfigManager
local function registerUIElements()
    local function registerIfExists(key, element)
        if element then
            zebuxConfig:Register(key, element)
        end
    end
    -- Register toggles (skip nil ones)
    registerIfExists("autoBuyEnabled", autoBuyToggle)
    registerIfExists("autoHatchEnabled", autoHatchToggle)
    registerIfExists("autoClaimEnabled", autoClaimToggle)
    registerIfExists("autoPlaceEnabled", autoPlaceToggle)
    registerIfExists("autoUnlockEnabled", autoUnlockToggle)
    registerIfExists("autoDeleteEnabled", autoDeleteToggle)
    registerIfExists("autoDinoEnabled", autoDinoToggle)
    registerIfExists("autoUpgradeEnabled", autoUpgradeToggle)
    registerIfExists("autoBuyFruitEnabled", autoBuyFruitToggle)
    registerIfExists("autoFeedEnabled", autoFeedToggle)
    
    -- Register dropdowns
    registerIfExists("placeEggDropdown", placeEggDropdown)
    registerIfExists("placeMutationDropdown", placeMutationDropdown)
    -- priorityDropdown removed
    
    -- Register sliders/inputs
    registerIfExists("autoClaimDelaySlider", autoClaimDelaySlider)
    registerIfExists("autoDeleteSpeedSlider", autoDeleteSpeedSlider)

end

-- ============ Anti-AFK System ============

setupAntiAFK = function()
    if antiAFKEnabled then return end
    antiAFKEnabled = true
    antiAFKConnection = game:GetService("Players").LocalPlayer.Idled:Connect(function()
        game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
    WindUI:Notify({ Title = "🛡️ Anti-AFK", Content = "Anti-AFK activated!", Duration = 3 })
end

disableAntiAFK = function()
    if not antiAFKEnabled then return end
    antiAFKEnabled = false
    if antiAFKConnection then
        antiAFKConnection:Disconnect()
        antiAFKConnection = nil
    end
    WindUI:Notify({ Title = "🛡️ Anti-AFK", Content = "Anti-AFK deactivated.", Duration = 3 })
end

-- ============ Save Settings Tab ============
Tabs.SaveTab:Section({ Title = "💾 Save & Load", Icon = "save" })

Tabs.SaveTab:Paragraph({
    Title = "💾 Settings Manager",
    Desc = "Save your current settings to remember them next time you use the script!",
    Image = "save",
    ImageSize = 18,
})

Tabs.SaveTab:Button({
    Title = "💾 Manual Save",
    Desc = "Manually save all your current settings",
    Callback = function()
        zebuxConfig:Save()
        saveCustomSelections()
        WindUI:Notify({ 
            Title = "💾 Settings Saved", 
            Content = "All your settings have been saved! 🎉", 
            Duration = 3 
        })
    end
})

Tabs.SaveTab:Button({
    Title = "📂 Manual Load",
    Desc = "Manually load your saved settings",
    Callback = function()
        zebuxConfig:Load()
        loadCustomSelections()
        syncAutoPlaceFiltersFromUI()
        WindUI:Notify({ 
            Title = "📂 Settings Loaded", 
            Content = "Your settings have been loaded! 🎉", 
            Duration = 3 
        })
    end
})

Tabs.SaveTab:Button({
    Title = "🛡️ Toggle Anti-AFK",
    Desc = "Enable or disable the built-in anti-AFK system",
    Callback = function()
        if antiAFKEnabled then
            disableAntiAFK()
        else
            setupAntiAFK()
        end
    end
})



 

Tabs.SaveTab:Button({
    Title = "🔄 Manual Load Settings",
    Desc = "Manually load all settings (WindUI + Custom)",
    Callback = function()
        -- Load WindUI config
        local configSuccess, configErr = pcall(function()
            zebuxConfig:Load()
        end)
        if not configSuccess then
            warn("Failed to load WindUI config: " .. tostring(configErr))
        end
        
        -- Load custom selections
        local customSuccess, customErr = pcall(function()
            loadCustomSelections()
        end)
        
        -- Sync dropdowns into runtime filters after both loads
        syncAutoPlaceFiltersFromUI()

        if customSuccess then
            WindUI:Notify({ Title = "✅ Manual Load", Content = "Settings loaded successfully!", Duration = 3 })
        else
            warn("Failed to load custom selections: " .. tostring(customErr))
            WindUI:Notify({ Title = "⚠️ Manual Load", Content = "Settings loaded but custom selections failed", Duration = 3 })
        end
    end
})

Tabs.SaveTab:Button({
    Title = "📤 Export Settings",
    Desc = "Export your settings to clipboard",
    Callback = function()
        local success, err = pcall(function()
            -- Get WindUI config data
            local configData = ConfigManager:AllConfigs()
            -- Combine with custom selections
            local exportData = {
                windUIConfig = configData,
                customSelections = customSelections
            }
            local jsonData = game:GetService("HttpService"):JSONEncode(exportData)
            setclipboard(jsonData)
        end)
        
        if success then
            WindUI:Notify({ 
                Title = "📤 Settings Exported", 
                Content = "Settings copied to clipboard! 🎉", 
                Duration = 3 
            })
        else
            WindUI:Notify({ 
                Title = "❌ Export Failed", 
                Content = "Failed to export settings: " .. tostring(err), 
                Duration = 5 
            })
        end
    end
})

Tabs.SaveTab:Button({
    Title = "📥 Import Settings",
    Desc = "Import settings from clipboard",
    Callback = function()
        local success, err = pcall(function()
            local clipboardData = getclipboard()
            local importedData = game:GetService("HttpService"):JSONDecode(clipboardData)
            
            if importedData and importedData.windUIConfig then
                -- Import WindUI config
                for configName, configData in pairs(importedData.windUIConfig) do
                    local config = ConfigManager:GetConfig(configName)
                    if config then
                        config:LoadFromData(configData)
                    end
                end
                
                -- Import custom selections
                if importedData.customSelections then
                    customSelections = importedData.customSelections
                    saveCustomSelections()
                end
                
                WindUI:Notify({ 
                    Title = "📥 Settings Imported", 
                    Content = "Settings imported successfully! 🎉", 
                    Duration = 3 
                })
            else
                error("Invalid settings format")
            end
        end)
        
        if not success then
            WindUI:Notify({ 
                Title = "❌ Import Failed", 
                Content = "Failed to import settings: " .. tostring(err), 
                Duration = 5 
            })
        end
    end
})

Tabs.SaveTab:Button({
    Title = "🔄 Reset Settings",
    Desc = "Reset all settings to default",
    Callback = function()
        Window:Dialog({
            Title = "🔄 Reset Settings",
            Content = "Are you sure you want to reset all settings to default?",
            Icon = "alert-triangle",
            Buttons = {
                {
                    Title = "❌ Cancel",
                    Variant = "Secondary",
                    Callback = function() end
                },
                {
                    Title = "✅ Reset",
                    Variant = "Primary",
                    Callback = function()
                        local success, err = pcall(function()
                            -- Delete WindUI config files
                            local configFiles = listfiles("WindUI/Zebux/config")
                            for _, file in ipairs(configFiles) do
                                if file:match("zebuxConfig%.json$") then
                                    delfile(file)
                                end
                            end
                            
                            -- Delete custom selections file
                            if isfile("Zebux_CustomSelections.json") then
                                delfile("Zebux_CustomSelections.json")
                            end
                            
                            -- Reset custom selections
                            customSelections = {
                                eggSelections = {},
                                fruitSelections = {},
                                feedFruitSelections = {}
                            }
                            
                            -- Reset all variables to defaults
                            autoBuyEnabled = false
                            autoHatchEnabled = false
                            autoClaimEnabled = false
                            autoPlaceEnabled = false
                            autoUnlockEnabled = false
                            autoDeleteEnabled = false
                            autoDinoEnabled = false
                            autoUpgradeEnabled = false
                            autoBuyFruitEnabled = false
                            autoFeedEnabled = false
                            
                            selectedTypeSet = {}
                            selectedMutationSet = {}
                            selectedFruits = {}
                            selectedFeedFruits = {}
                            selectedEggTypes = {}
                            selectedMutations = {}
                            
                            -- Refresh UI if visible
                            local function safeRefresh(uiModule, moduleName)
                                if uiModule then
                                    if uiModule.RefreshContent then
                                        local ok, refreshErr = pcall(function()
                                            uiModule.RefreshContent()
                                        end)
                                        if not ok then
                                            warn("Failed to refresh " .. moduleName .. " UI: " .. tostring(refreshErr))
                                        end
                                    else
                                        warn(moduleName .. " UI module exists but has no RefreshContent method")
                                    end
                                else
                                    warn(moduleName .. " UI module is nil - not loaded yet")
                                end
                            end
                            
                            safeRefresh(EggSelection, "EggSelection")
                            safeRefresh(FruitSelection, "FruitSelection")
                            safeRefresh(FeedFruitSelection, "FeedFruitSelection")
                            
                            WindUI:Notify({ 
                                Title = "🔄 Settings Reset", 
                                Content = "All settings have been reset to default! 🎉", 
                                Duration = 3 
                            })
                        end)
                        
                        if not success then
                            warn("Failed to reset settings: " .. tostring(err))
                            WindUI:Notify({ 
                                Title = "⚠️ Reset Error", 
                                Content = "Failed to reset some settings. Please try again.", 
                                Duration = 3 
                            })
                        end
                    end
                }
            }
        })
    end
})

-- Auto-load settings after all UI elements are created
task.spawn(function()
    task.wait(3) -- Wait longer for UI to fully load
    
    -- Show loading notification
        WindUI:Notify({ 
        Title = "📂 Loading Settings", 
        Content = "Loading your saved settings...", 
        Duration = 2 
    })
    
    -- Register all UI elements with WindUI config
    registerUIElements()

    -- Load local AutoQuest module and initialize its UI. Keep it after base UI exists so it can attach to Window and Config
    pcall(function()
        local autoQuestModule = nil
        -- Try local file first (if present in environment with filesystem)
        if isfile and isfile("AutoQuestSystem.lua") then
            autoQuestModule = loadstring(readfile("AutoQuestSystem.lua"))()
        end
        -- Fallback: try from same directory
        if not autoQuestModule then
            local success, result = pcall(function()
                return loadstring(game:HttpGet("https://raw.githubusercontent.com/ZebuxHub/Main/refs/heads/main/AutoQuestSystem.lua"))()
            end)
            if success then
                autoQuestModule = result
            end
        end
        if autoQuestModule and autoQuestModule.Init then
            AutoQuestSystem = autoQuestModule.Init({
                WindUI = WindUI,
                Window = Window,
                Config = zebuxConfig,
                waitForSettingsReady = waitForSettingsReady,
                -- Pass existing automation references so AutoQuest can control them
                autoBuyToggle = autoBuyToggle,
                autoPlaceToggle = autoPlaceToggle,
                autoHatchToggle = autoHatchToggle,
                -- Pass automation state variables
                getAutoBuyEnabled = function() return autoBuyEnabled end,
                getAutoPlaceEnabled = function() return autoPlaceEnabled end,
                getAutoHatchEnabled = function() return autoHatchEnabled end,
            })
        end
    end)
    
    -- Load WindUI config settings
    zebuxConfig:Load()
    
    -- Load custom UI selections
    loadCustomSelections()
    
    -- First sync immediately in case UI is already populated
    syncAutoPlaceFiltersFromUI()

    -- Schedule a delayed sync to catch any late UI restoration
    task.delay(0.5, function()
        syncAutoPlaceFiltersFromUI()
    end)

    WindUI:Notify({ 
        Title = "📂 Auto-Load Complete", 
            Content = "Your saved settings have been loaded! 🎉", 
            Duration = 3 
        })
    settingsLoaded = true
end)

-- ============ Auto Feed Tab ============
-- Feed status section removed per user request

-- Feed Fruit Selection UI Button
Tabs.FeedTab:Button({
    Title = "🍎 Open Feed Fruit Selection UI",
    Desc = "Open the modern glass-style fruit selection interface for feeding",
    Callback = function()
        if not feedFruitSelectionVisible then
            FeedFruitSelection.Show(
                function(selectedItems)
                    -- Handle selection changes
                    selectedFeedFruits = selectedItems
                    updateCustomUISelection("feedFruitSelections", selectedItems)
                end,
                function(isVisible)
                    feedFruitSelectionVisible = isVisible
                end,
                selectedFeedFruits -- Pass saved fruit selections
            )
            feedFruitSelectionVisible = true
        else
            FeedFruitSelection.Hide()
            feedFruitSelectionVisible = false
        end
    end
})

-- Auto Feed Toggle
autoFeedToggle = Tabs.FeedTab:Toggle({
    Title = "🍽️ Auto Feed Pets",
    Desc = "Automatically feed Big Pets with selected fruits when they're hungry",
    Value = false,
    Callback = function(state)
        autoFeedEnabled = state
        
        waitForSettingsReady(0.2)
        if state and not autoFeedThread then
            autoFeedThread = task.spawn(function()
                -- Ensure selections are loaded before starting
                local function getSelected()
                    -- if empty, try to lazy-load from file once
                    if not selectedFeedFruits or not next(selectedFeedFruits) then
pcall(function()
                            if isfile("Zebux_FeedFruitSelections.json") then
                                local data = game:GetService("HttpService"):JSONDecode(readfile("Zebux_FeedFruitSelections.json"))
                                if data and data.fruits then
                                    selectedFeedFruits = {}
                                    for _, id in ipairs(data.fruits) do selectedFeedFruits[id] = true end
                                end
                            end
                        end)
                    end
                    return selectedFeedFruits
                end
                
                -- Wrap the auto feed call in error handling
                local ok, err = pcall(function()
                    AutoFeedSystem.runAutoFeed(autoFeedEnabled, {}, function() end, getSelected)
                end)
                
                if not ok then
                    warn("Auto Feed thread error: " .. tostring(err))
                    WindUI:Notify({ 
                        Title = "⚠️ Auto Feed Error", 
                        Content = "Auto Feed stopped due to error: " .. tostring(err), 
                        Duration = 5 
                    })
                end
                
                autoFeedThread = nil
            end)
            WindUI:Notify({ Title = "🍽️ Auto Feed", Content = "Started - Feeding Big Pets! 🎉", Duration = 3 })
        elseif (not state) and autoFeedThread then
            WindUI:Notify({ Title = "🍽️ Auto Feed", Content = "Stopped", Duration = 3 })
        end
    end
})

-- Late-register Auto Feed toggle after it exists, then re-load to apply saved value
task.spawn(function()
    -- Wait until settings load sequence either completed or shortly timed in
    local tries = 0
    while not (zebuxConfig and autoFeedToggle) and tries < 50 do
        tries += 1
        task.wait(0.05)
    end
    if zebuxConfig and autoFeedToggle then
        pcall(function()
            zebuxConfig:Register("autoFeedEnabled", autoFeedToggle)
            -- If settings already loaded, load again to apply saved value to this control
            if settingsLoaded then
                zebuxConfig:Load()
            end
        end)
    end
end)






-- Safe window close handler
local ok, err = pcall(function()
Window:OnClose(function()

end)
end)

if not ok then
    warn("Failed to set window close handler: " .. tostring(err))
end

-- Function removed - using WindUI config system instead
-- Function removed - using WindUI config system instead
