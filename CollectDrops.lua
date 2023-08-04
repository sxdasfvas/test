getgenv().ToggleL = true -- if you want stop just type false
while getgenv().ToggleL do wait()
-- Orbs
for i,v in pairs(game:GetService("Workspace")["__THINGS"].Orbs:GetChildren()) do
v.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position)
end

-- Lootbags      
for i,v in pairs(game:GetService("Workspace")["__THINGS"].Lootbags:GetChildren()) do
v.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position)
end
end
