local abc = os.clock
local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/NoobHubV7/RobloxScripts/refs/heads/main/library/main.lua"))()
local Window = lib:CreateWindow("Op Ninja Simulator")
local Section = Window:AddFolder("Main")
local remote = nil
local autoPower = nil
local remote2 = nil
local autoUpgrade = nil
local Time = 1
local upgrade1, upgrade2, upgrade3 = "\xE0\xB8\xAD\xE0\xB8\xB1\xE0\xB8\x9E\xE0\xB9\x80\xE0\xB8\x81\xE0\xB8\xA3\xE0\xB8\x94\xE0\xB8\x94\xE0\xB8\xB2\xE0\xB8\x9A", "\xE0\xB8\xAD\xE0\xB8\xB1\xE0\xB8\x9E\xE0\xB9\x80\xE0\xB8\x81\xE0\xB8\xA3\xE0\xB8\x94\xE0\xB8\x84\xE0\xB8\xA5\xE0\xB8\xB2\xE0\xB8\xAA", "\xE0\xB8\xAD\xE0\xB8\xB1\xE0\xB8\x9E\xE0\xB9\x80\xE0\xB8\x81\xE0\xB8\xA3\xE0\xB8\x94\xE0\xB9\x81\xE0\xB8\xAD\xE0\xB8\xAA\xE0\xB9\x80\xE0\xB8\x8B\xE0\xB8\x99\xE0\xB8\x95\xE0\xB9\x8C"
local ActionTime = 0.125

function FindRemoteEvent()
for i,v in ipairs(game.Players.LocalPlayer.PlayerGui.MainGui:GetChildren()) do
if v:IsA("RemoteEvent") and string.find(v.Name, "-") then
remote = v
end
end
end

function FindRemoteFunction()
for i,v in ipairs(game.Players.LocalPlayer.PlayerGui.MainGui:GetChildren()) do
if v:IsA("RemoteFunction") and string.find(v.Name, "-") then
remote2 = v
end
end
end

function CheckTool()
for i,v in ipairs(game.Players.LocalPlayer.Character:GetChildren()) do
if v:IsA("Tool") and (v.Name ~= 'TeleportTool' or v.Name ~= "Shuriken") then
return v
end
end
end

function Replay(arg)
pcall(function()
remote2:InvokeServer(arg,100)
end)
end

Section:AddToggle({text = "Auto Power", flag = "toggle", callback = function(state) autoPower = state end})
Section:AddToggle({text = "Auto Upgrade", flag = "toggle", callback = function(state) autoUpgrade = state end})

task.spawn(function()
       game:GetService("RunService").RenderStepped:Connect(function(dt)
              if dt > 0 and remote then
                     if autoPower and CheckTool() then
                            if (abc() - ActionTime) >= 0.125 then
                                   ActionTime = abc()
                                   pcall(function()
                                          remote:FireServer("SwordSlash",100000)
                                   end)
                            end
                     end
              end
              if dt > 0 and remote2 then
                     if autoUpgrade then
                            if game:GetService("Players").LocalPlayer.PlayerGui.MainGui.UpgradeF.SwordF.SwordImgBtn.ImageColor3 ~= Color3.fromRGB(0, 20, 0) and (abc() - Time) >= 1 then
                                   Time = abc()
                                   Replay(upgrade1)
                            end
                            if game:GetService("Players").LocalPlayer.PlayerGui.MainGui.UpgradeF.ClassF.ClassImgBtn.ImageColor3 ~= Color3.fromRGB(0, 0, 105) and (abc() - Time) >= 1 then
                                   Time = abc()
                                   Replay(upgrade2)
                            end
                            if game:GetService("Players").LocalPlayer.PlayerGui.MainGui.UpgradeF.AscendF.AscendImgBtn.ImageColor3 ~= Color3.fromRGB(0, 0, 105) and (abc() - Time) >= 1 then
                                   Time = abc()
                                   Replay(upgrade3)
                            end
                     end
              end
       end)
end)

Section:AddLabel({text = "Created by NoobHubV6", type = "label"})
lib:Init(); FindRemoteEvent(); FindRemoteFunction()
