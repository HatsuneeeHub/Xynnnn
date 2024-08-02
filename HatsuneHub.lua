-- Hatsune Script for Blox Fruits with NPC Lock
-- Dependencies
local player = game.Players.LocalPlayer
local replicatedStorage = game:GetService("ReplicatedStorage")
local enemies = game.Workspace.Enemies

-- Auto Farm Variables
local autoFarmEnabled = false
local targetNPC = "Bandit [Lv. 5]" -- Ganti nama NPC sesuai target yang diinginkan

-- Main Auto Farm Function
function autoFarm()
while autoFarmEnabled do
for _, enemy in pairs(enemies:GetChildren()) do
if enemy.Name == targetNPC and enemy:FindFirstChildOfClass("Humanoid") and enemy:FindFirstChildOfClass("Humanoid").Health > 0 then
repeat
player.Character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame + Vector3.new(0, 0, 5)
replicatedStorage.Remotes.CommF_:InvokeServer("AttackNMoveStart", enemy.HumanoidRootPart.Position)
replicatedStorage.Remotes.CommF_:InvokeServer("AttackDEnd", enemy.HumanoidRootPart.Position)
wait(0.5)
until enemy:FindFirstChildOfClass("Humanoid").Health <= 0 or not autoFarmEnabled
end
end
wait(1)
end
end

-- Toggle Auto Farm On/Off
local function toggleAutoFarm()
autoFarmEnabled = not autoFarmEnabled
if autoFarmEnabled then
autoFarm()
else
print("Auto farm stopped.")
end
end

-- Keybind to Toggle Auto Farm
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
if input.KeyCode == Enum.KeyCode.F and not gameProcessed then
toggleAutoFarm()
end
end)

print("Auto farm script loaded. Press 'F' to toggle auto farm.")
