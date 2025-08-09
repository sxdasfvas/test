repeat task.wait() until game:IsLoaded()
repeat task.wait() until game:GetService("Players").LocalPlayer:GetAttribute('DataFullyLoaded') == true

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local Httprequest = http_request or request or (syn and syn.request) or (fluxus and fluxus.request) or (getgenv and getgenv().request)
local PetUtilities = require(ReplicatedStorage.Modules.PetServices.PetUtilities)
local ReplicationClass = require(ReplicatedStorage.Modules.ReplicationClass)
local ActivePetsService = ReplicationClass.new("ActivePetsService_Replicator")
local webhookUrl = "https://discord.com/api/webhooks/1403552223748817059/dTKvd6XBJ6-eod-6_7QLf7kKytxsIf94mlbq44hYfwxiXSTHsNVqoUvLiLcycoSoWiio"

local function sendDiscordEmbed(title, description)
	local embed = {{
		title = title,
		description = description,
		color = 0x1abc9c, -- สีเขียวสวย
		timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
		footer = {
			text = "Roblox Pet Monitor"
		}
	}}

	local payload = {
		embeds = embed
	}
	local jsonData = HttpService:JSONEncode(payload)

	local response = Httprequest({
		Url = webhookUrl,
		Method = "POST",
		Headers = {
			["Content-Type"] = "application/json",
			["Content-Length"] = tostring(#jsonData)
		},
		Body = jsonData
	})

	print("Status Code:", response.StatusCode)
	print("Response Body:", response.Body)
end

local function checkAndSend()
	local success, dataResult = pcall(function()
		return ActivePetsService:YieldUntilData()
	end)

	if success then
		local dataTable = dataResult.Table
		if dataTable and dataTable.PlayerPetData then
			local playerName = Players.LocalPlayer.Name
			local playerPetData = dataTable.PlayerPetData[playerName]
			if playerPetData then
				local petInventory = playerPetData['PetInventory']
				if petInventory and petInventory['Data'] then
					local petData = petInventory['Data']
					for _, v in pairs(petData) do
						local baseWeight = v.PetData.BaseWeight or 1
						local level = v.PetData.Level or 1
						local weight = PetUtilities:CalculateWeight(baseWeight, level)
						local petType = v.PetType or "Unknown"

						if weight >= 20 then
							sendDiscordEmbed(
								"⚠️ เจอสัตว์น้ำหนักมาก!",
								string.format(
									"ผู้เล่น: %s\nประเภทสัตว์: %s\nน้ำหนัก: %.2f\nอายุ (Level): %d",
									playerName, petType, weight, level
								)
							)
						elseif (weight > 7 and level <= 10) or (weight > 10 and level <= 39) then
							sendDiscordEmbed(
								"🐾 สัตว์เข้าเงื่อนไข",
								string.format(
									"ผู้เล่น: %s\nประเภทสัตว์: %s\nน้ำหนัก: %.2f\nอายุ (Level): %d",
									playerName, petType, weight, level
								)
							)
						end
					end
				end
			end
		end
	end
end

task.spawn(function()
	while true do
		checkAndSend()
		task.wait(500)
	end
end)

print('this is loadstring for webhook')
