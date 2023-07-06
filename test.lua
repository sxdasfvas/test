repeat task.wait() until game:IsLoaded()
task.wait()

getgenv().Settings = {
    ["Farm Speed"] = 0.30,
    ["Pet Sending"] = "Single", -- All or Single
    ["Minimum Oranges"] = 170,
    ["Maximum Oranges"] = 200,
    ["Mailbox"] = {
        ["Auto Claim"] = false,
        ["Auto Send"] = true,
        ["Delay"] = 60,
        ["Recipient"] = "Pr4m0t",
        ["Amount"] = 50000000000,
    },
    ["Performance"] = {
        ["FPS Cap"] = 60,
        ["Disable Rendering"] = true,
        ["Downgraded Quality"] = true
    }
}

-- dont touch below pls

local MYSTIC_CFRAME_SAFE = CFrame.new(9038, -33, 2458)
local VAULT_CFRAME_SAFE = CFrame.new(3588, -35, 2457)

local PERF = Settings["Performance"]
local MB = Settings["Mailbox"]
local mailing = false

if not game:IsLoaded() then game.Loaded:Wait() end
local Lib = require(game:GetService("ReplicatedStorage"):WaitForChild("Framework"):WaitForChild("Library"))
repeat task.wait() until Lib.Loaded

-- // Services //
local RS = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- // PSX Libraries //
local Library = RS:WaitForChild("Library")
local ClientModule = Library:WaitForChild("Client")
local Directory = require(Library:WaitForChild("Directory"))

local Network = require(ClientModule:WaitForChild("Network"))
local Save = require(ClientModule:WaitForChild("Save"))
local WorldCmds = require(ClientModule:WaitForChild("WorldCmds"))
local PetCmds = require(ClientModule:WaitForChild("PetCmds"))
local ServerBoosts = require(ClientModule:WaitForChild("ServerBoosts"))

-- Anti AFK
for _,v in pairs(getconnections(LocalPlayer.Idled)) do
    v:Disable()
end

do -- Patching/Hooking
    if (not getgenv().hooked) then
        hookfunction(debug.getupvalue(Network.Fire, 1) , function(...) return true end)
        hookfunction(debug.getupvalue(Network.Invoke, 1) , function(...) return true end)
        getgenv().hooked = true
    end

    local Blunder = require(RS:FindFirstChild("BlunderList", true))
    local OldGet = Blunder.getAndClear

    setreadonly(Blunder, false)

    Blunder.getAndClear = function(...)
        local Packet = ...
        for i,v in next, Packet.list do
            if v.message ~= "PING" then
                table.remove(Packet.list, i)
            end
        end
        return OldGet(Packet)
    end

    local Audio = require(RS:WaitForChild("Library"):WaitForChild("Audio"))
    hookfunction(Audio.Play, function(...)
        return {
            Play = function() end,
            Stop = function() end,
            IsPlaying = function() return false end
        }
    end)

    print("Hooked")
end

do -- Performance
    setfpscap(PERF["FPS Cap"] or 15)
    game:GetService("RunService"):Set3dRenderingEnabled(not PERF["Disable Rendering"])
    if PERF["Downgraded Quality"] then
        local lighting = game.Lighting
        lighting.GlobalShadows = false
        lighting.FogStart = 0
        lighting.FogEnd = 0
        lighting.Brightness = 0
        settings().Rendering.QualityLevel = "Level01"

        for _,v in pairs(game:GetDescendants()) do
            if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
                v.Material = "Plastic"
                v.Reflectance = 0
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Lifetime = NumberRange.new(0)
            elseif v:IsA("Explosion") then
                v.BlastPressure = 1
                v.BlastRadius = 1
            elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
                v.Enabled = false
            elseif v:IsA("MeshPart") then
                v.Material = "Plastic"
                v.Reflectance = 0
            end
        end

        for _,e in pairs(lighting:GetChildren()) do
            if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
                e.Enabled = false
            end
        end
    end
end

do -- Collection
    coroutine.wrap(function() while task.wait(0.1) do
        -- // Lootbags
        for _,v in pairs(workspace["__THINGS"].Lootbags:GetChildren()) do
            Network.Fire("Collect Lootbag", v:GetAttribute("ID"), v.CFrame.p)
        end

        -- // Orbs
        local orbs = workspace["__THINGS"].Orbs:GetChildren()
        for i,v in pairs(orbs) do orbs[i] = v.Name end
        if #orbs > 0 and orbs[1] ~= nil then
            Network.Fire("Claim Orbs", orbs)
        end

        -- // Gifts
        for _,v in pairs(LocalPlayer.PlayerGui.FreeGifts.Frame.Container.Gifts:GetDescendants()) do
            if v.ClassName == "TextLabel" and v.Text == "Redeem!" then
                local giftName = v.Parent.Name
                local number = string.match(giftName, "%d+")
                Network.Invoke("Redeem Free Gift", tonumber(number))
            end
        end
    end end)()

    coroutine.wrap(function() while task.wait(10) do
        useServerBoost("Triple Damage")
        useBoost("Triple Damage")
    end end)()
end

function createPlatform(name, cframe)
    if workspace:FindFirstChild(name) then return end

    local part = Instance.new("Part", workspace)
    part.Name = name
    part.Size = Vector3.new(50, 1, 50)
    part.CFrame = cframe
    part.Anchored = true
end

function getOrangeCount()
    local boosts = LocalPlayer.PlayerGui.Main.Boosts
    return boosts:FindFirstChild("Orange") and tonumber(boosts.Orange.TimeLeft.Text:match("%d+")) or 0
end

function getEquippedPets()
    local pets = PetCmds.GetEquipped()
    for i,v in pairs(pets) do pets[i] = v.uid end
    return pets
end

function farmCoin(coinId, petUIDs)
    local pets = (petUIDs == nil and getEquippedPets()) or (typeof(petUIDs) ~= "table" and { petUIDs }) or petUIDs
    Network.Invoke("Join Coin", coinId, pets)
    for _,pet in pairs(pets) do
        Network.Fire("Farm Coin", coinId, pet)
    end
end

function farmFruits()
    createPlatform("Safe-Vault", VAULT_CFRAME_SAFE)

    local function isFruitValid(coinObj)
        return Directory.Coins[coinObj.n].breakSound == "fruit"
    end

    local function GetFruits()
        local fruits = {}
        for i,v in pairs(Network.Invoke("Get Coins")) do
            if v == nil then continue end
            if isFruitValid(v) and WorldCmds.HasArea(v.a) then
                v.id = i
                table.insert(fruits, v)
            end
        end
        return fruits
    end

    local function GetCoinsInPV()
        local coins = {}
        for i,v in pairs(Network.Invoke("Get Coins")) do
            if v == nil then continue end
            if v.a == "Pixel Vault" then 
                v.id = i
                table.insert(coins, v)
            end
        end
        table.sort(coins, function(a, b) return a.h < b.h end)
        return coins
    end

    local function GetAllInPV()
        local f = GetFruits()
        for _,v in pairs(GetCoinsInPV()) do
            table.insert(f, v)
        end
        return f
    end

    if WorldCmds.HasLoaded() and WorldCmds.Get() ~= "Pixel" then
        WorldCmds.Load("Pixel")
    end

    if WorldCmds.HasLoaded() then
        local areaTeleport = WorldCmds.GetMap().Teleports:FindFirstChild("Pixel Vault")
		if areaTeleport then
		    LocalPlayer.Character:PivotTo(VAULT_CFRAME_SAFE + VAULT_CFRAME_SAFE.UpVector * (LocalPlayer.Character.Humanoid.HipHeight + LocalPlayer.Character.HumanoidRootPart.Size.Y / 2))
		end
    end

    local fruits = GetAllInPV()
    if #fruits == 0 then return end
    for i,pet in pairs(getEquippedPets()) do
        if #fruits == 0 then return end
        local c = fruits[1]
        table.remove(fruits, 1)
        task.spawn(function()
            task.wait(Settings["Farm Speed"] * i)
            farmCoin(c.id, { pet })
        end)
    end
end

function farmMystic()
    createPlatform("Safe-Mystic", MYSTIC_CFRAME_SAFE)
    local function GetCoinsInMM()
        local coins = {}
        for i,v in pairs(Network.Invoke("Get Coins")) do
            if v.a == "Mystic Mine" and v.n ~= "Mystic Mine Diamond Mine Giant Chest" then
                v.id = i
                table.insert(coins, v)
            end
        end
        table.sort(coins, function(a, b) return (a.b and a.b.l[1].m or 1) > (b.b and b.b.l[1].m or 1) end)
        return coins
    end

    if WorldCmds.HasLoaded() and WorldCmds.Get() ~= "Diamond Mine" then
        WorldCmds.Load("Diamond Mine")
    end

    if WorldCmds.HasLoaded() then
        local areaTeleport = WorldCmds.GetMap().Teleports:FindFirstChild("Mystic Mine")
		if areaTeleport then
		    LocalPlayer.Character:PivotTo(MYSTIC_CFRAME_SAFE + MYSTIC_CFRAME_SAFE.UpVector * (LocalPlayer.Character.Humanoid.HipHeight + LocalPlayer.Character.HumanoidRootPart.Size.Y / 2))
		end
    end


    local coins = GetCoinsInMM()
    if #coins == 0 then return end
    local pets = Settings["Pet Sending"] == "Single" and getEquippedPets() or {getEquippedPets()}
    for _,pet in pairs(pets) do
        if #coins == 0 then return end
        local c = coins[1]
        if not c then
            table.remove(coins, 1)
            continue
        end
        task.spawn(farmCoin, c.id, typeof(pet) == "table" and pet or { pet })
        table.remove(coins, 1)
        task.wait(Settings["Farm Speed"])
    end
end

function sendMail()
    if not MB["Auto Send"] or MB["Amount"] > Save.Get().Diamonds then return end

    local re = MB["Recipient"]
    if not re or re == "" or re == game.Players.LocalPlayer.Name then return end

    mailing = true
    task.wait(0.5)

    if WorldCmds.HasLoaded() and WorldCmds.Get() ~= "Diamond Mine" then
        WorldCmds.Load("Diamond Mine")
    end

    if WorldCmds.HasLoaded() then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(9298, -14, 2988)
    end

    task.wait(0.5)

    Network.Invoke("Send Mail", {
        Recipient = re,
        Diamonds = MB["Amount"],
        Pets = {},
        Message = "ring ring"
    })

    task.wait(1)
    mailing = false
end

function claimMail()
    if not MB["Auto Claim"] then return end

    local mails = {}
    for _,v in pairs(Network.Invoke("Get Mail")["Inbox"]) do
        if v.Message == "ring ring" then
            table.insert(mails, v.uuid)
        end
    end

    mailing = true
    task.wait(0.5)

    if WorldCmds.HasLoaded() and WorldCmds.Get() ~= "Diamond Mine" then
        WorldCmds.Load("Diamond Mine")
    end

    if WorldCmds.HasLoaded() then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(9298, -14, 2988)
    end

    task.wait(0.5)

    Network.Invoke("Claim Mail", mails)

    task.wait(1)
    mailing = false
end


do -- Main
    coroutine.wrap(function()
        while task.wait(MB["Delay"]) do
            claimMail()
            sendMail()
        end
    end)()

    coroutine.wrap(function()
        while task.wait() do
            if mailing then continue end

            if getOrangeCount() < Settings["Minimum Oranges"] then
                repeat
                    farmFruits()
                    task.wait(Settings["Farm Speed"] or 0.04)
                until getOrangeCount() >= Settings["Maximum Oranges"] or mailing
            else
                repeat
                    farmMystic()
                    task.wait(Settings["Farm Speed"] or 0.04)
                until getOrangeCount() < Settings["Minimum Oranges"] or mailing
            end
        end
    end)()
end
