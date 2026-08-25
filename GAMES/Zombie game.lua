local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/NoobHubV7/RobloxScripts/refs/heads/main/library/main.lua"))()
local Window = lib:CreateWindow("Zombie game")
local Window2 = lib:CreateWindow("Zombie game 2")
local Section = Window:AddFolder("Main")
local Section2 = Window:AddFolder("Kill")
local Section3 = Window:AddFolder("Summon")
local Section4 = Window2:AddFolder("Team")
local Section5 = Window2:AddFolder("Weapon")
local Section6 = Window2:AddFolder("Lag Server")
local killAura, abc = {
       Plr = {},
       Me = false
}, nil
local tool, InfectAura
local LoopkillZombies, LoopsummonNecro
local LoopsummonLandmine, LoopsummonAcid
local def, zList = Vector3.new, {-268, -250, -232, -214, -196, -178, -142, -124, -106, -88, -70, -54, -32, -16, 2, 20, 38, 56, 74, 92, 110, 128, 146, 164, 182, 200, 218, 236, 254, 272, 290, 308, 326, 344, 362}
local target, TargetAcid = nil, {}
local weaponTable, RNG = {}, Random.new()
local SpreadAcid, find = {}, {
       Weapons = "Hitbox" or "Handle" or "Damage",
       Sniper = "M24" or "Bolt"
}
local TeleportService : TeleportService = cloneref(game:GetService("TeleportService"))
local networkCli : NetworkClient = cloneref(game:GetService("NetworkClient"))
local startTime = {
       One = 1,
       Two = 1,
       Three = 1,
       Four = 1,
       Five = 1,
       Six = 1,
       Seven = 1,
       Eight = 1,
       Nine = 1,
       Ten = 1,
	   Eleven = 1
}
local connecting, stop
local connecting2, autoHeal
local medkit, stop2
do
    for i,v in next, find do
        find[i] = function(bool)
            local char = game.Players.LocalPlayer.Character; local back = game.Players.LocalPlayer.Backpack
            local container = ((bool ~= false) and char) or back
            if not (container:FindFirstChildOfClass("Tool") and container:FindFirstChildOfClass("Tool"):FindFirstChildOfClass('Model') and container:FindFirstChildOfClass("Tool"):FindFirstChildOfClass('Model'):FindFirstChild(v)) then return false end
            if (container:FindFirstChildOfClass("Tool") and container:FindFirstChildOfClass("Tool"):FindFirstChildOfClass('Model') and container:FindFirstChildOfClass("Tool"):FindFirstChildOfClass('Model'):FindFirstChild(v)) then
                local Finding = (container:FindFirstChildOfClass("Tool") and container:FindFirstChildOfClass("Tool"):FindFirstChildOfClass('Model') and container:FindFirstChildOfClass("Tool"):FindFirstChildOfClass('Model'):FindFirstChild(v))
                return Finding.Parent.Parent
            end
        end
    end
end

table.freeze(find)

function Kill(model, isDestroy)
    if not (find.Sniper(true) or find.Sniper(false)) then
        game.ReplicatedStorage.Remotes.Shop.EquipWeapon:InvokeServer("Sniper")
    end
    if find.Sniper(false) then
        repeat
            if (os.clock() - startTime.Eight) >= 0.01 then
                startTime.Eight = os.clock(); game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("Sniper"))
            end
        until game.Players.LocalPlayer.Character:FindFirstChild("Sniper")
    end
    if find.Sniper(true) then game:GetService("ReplicatedStorage").NetworkEvents.RemoteEvent:FireServer("GUN_DAMAGE", model) end
	if find.Sniper(true) then find.Sniper(true):Destroy() end
end
function KillZombies()
    if (tick() - startTime.Nine) < 0.5 then return nil end
    startTime.Nine = tick()
    for i,v in ipairs(workspace.LivingThings:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChild("Torso") and v.Humanoid.Health > 0 and not v:FindFirstChild("ForceField") then
            if v:GetAttribute("Team") == "Zombie" then Kill(v, false) end
        end
    end
    find.Sniper(true):Destroy()
end
function Acid(pos, pos2)
       if not pos2 then
              pos2 = def(0, 0, 0)
       end
       game:GetService("ReplicatedStorage").Remotes.ZombieRelated.AcidSpit:FireServer(pos,pos2)
end
function Summon(name)
       if name == "NpcZombie" then
              game:GetService("ReplicatedStorage").Remotes.ZombieRelated.Necro.AbilityPlayer:FireServer()
       elseif name == "Landmine" then
              game:GetService("ReplicatedStorage").NetworkEvents.RemoteEvent:FireServer("PLACE_LANDMINE")
       elseif name == "Acid" then
              for coverX = -266, 378, 18 do
                     for coverZ = -266, 378, 18 do
                            Acid(def(coverX, 255, coverZ))
                     end
              end
       end
end
function Become(team)
       if team == "Human" then
              game.Players.LocalPlayer.Character.Humanoid:ChangeState("Dead")
       elseif team == "Zombie" then
              game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(";zombie")
       elseif team == "Spitter" then
              if game.Players.LocalPlayer.Character:FindFirstChild("ForceField") then
                     repeat task.wait()
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.ZombieSpawnerModel.PrimaryPart.CFrame
                     until not game.Players.LocalPlayer.Character:FindFirstChild("ForceField")
              end
              for i = 1,15 do
                     game:GetService("ReplicatedStorage").Remotes.ZombieRelated.TouchedAcid:FireServer(nil)
              end
       end
end
function GetPlayer(Player)
    local function findPlayer(stringg)
	    if (stringg == ("me")) or not stringg then
		    return game.Players.LocalPlayer
		else
		    for _,player in pairs(game.Players:GetPlayers()) do
			    if (stringg:lower() == (player.Name:lower()):sub(1, #stringg)) or (stringg:lower() == (player.DisplayName:lower()):sub(1, #stringg)) then
			        return player
				end
		    end
		end
	end
	return findPlayer(Player)
end

do
    for i,v in next, game:GetService("ReplicatedStorage").Assets.Weapons:GetChildren() do
        if v:IsA("Tool") then
            weaponTable[#weaponTable + 1] = v.Name
        end
    end
end

do
    for i,v in next, workspace.Scripted.Medkits:GetChildren() do
        if v:FindFirstChild("Handle") then
            local handle = v:FindFirstChild("Handle")
            if handle and handle.Position == Vector3.new(34.92776870727539, 22.455726623535156, -40.15422058105469) then
                medkit = handle
            end
        end
    end
end

function Removing(char)
    connecting2 = char:GetAttributeChangedSignal("Team"):Connect(function()
        if char:GetAttribute("Team") == "Zombie" then
            if tool then tool:Destroy(); tool = nil end
        end
    end)
end

networkCli:SetOutgoingKBPSLimit(tonumber("-inf"))
local rastorThreads = 25
local lagServer = function(event, ...)
    for _ = 1, rastorThreads do
        coroutine.wrap(function(...)
            for _ = 1, (rastorThreads * 1000) do
                coroutine.wrap(event.FireServer)(event, ...)
            end
        end)(...)
    end
end

local rejoin = function()
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId)
end

function Heal()
    if game.Players.LocalPlayer.Character.Humanoid.Health <= 50 then
        local pos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        repeat task.wait()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = medkit.CFrame * CFrame.new(0, 7, 0)
            if (tick() - startTime.One) >= 0.2 then
                startTime.One = tick(); fireproximityprompt(medkit.ProximityPrompt)
            end
        until game.Players.LocalPlayer.Character.Humanoid.Health == 100 or game.Players.LocalPlayer.Character.Humanoid:GetState() == Enum.HumanoidStateType.Dead or not game.Players.LocalPlayer.Character:FindFirstChild("Head")
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
    end
end

Section:AddBox({text = "Player Name", value = 'Name', callback = function(text)
       target = text
end, type = "TextBox", flag = "TextBox"})
Section:AddToggle({text = "Kill Aura", flag = "toggle", callback = function(state)
       if not state == false then
              local tar = GetPlayer(target)
              if tar == game.Players.LocalPlayer then
                     killAura.Me = true
              elseif tar ~= game.Players.LocalPlayer then
                     killAura.Plr[tar.UserId] = tar
              end
       elseif not state == true then
              if killAura.Plr then
                     for _,v in next, killAura.Plr do
                            killAura.Plr[v.UserId] = nil
                     end
              end
              if killAura.Me then killAura.Me = false end
       end
end})
Section:AddToggle({text = "Infect Aura", flag = "toggle", callback = function(state)
       abc = state
       if abc == true then
              if game.Players.LocalPlayer.Character:GetAttribute("Team") == "Human" then
                     tool = game:GetService("ReplicatedStorage").Attack:Clone()
                     tool.Parent = game.Players.LocalPlayer.Backpack
              end
              Removing(game.Players.LocalPlayer.Character)
              connecting = game.Players.LocalPlayer.CharacterAdded:Connect(function(new)
                     if new:GetAttribute("Team") == "Human" then
                            if tool then
                                tool:Destroy(); tool = nil
                            end
                            tool = game:GetService("ReplicatedStorage").Attack:Clone()
                            tool.Parent = game.Players.LocalPlayer.Backpack
                            Removing(game.Players.LocalPlayer.Character)
                     end
              end)
       elseif not abc == true then
              game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
              if tool then tool:Destroy(); tool = nil end
              if connecting then connecting:Disconnect(); connecting = nil end
              if connecting2 then connecting2:Disconnect(); connecting2 = nil end
       end
       InfectAura = state
end})
Section:AddToggle({text = "Target Acid", flag = "toggle", callback = function(state)
       if not state == false then
              local played = GetPlayer(target)
              if played then
                     TargetAcid[played.UserId] = played
              end
       elseif state == false then
              for _,v in next, TargetAcid do
                     TargetAcid[v.UserId] = nil
              end
       end
end})
Section:AddToggle({text = "Spread Acid (Target)", flag = "toggle", callback = function(state)
       if not state == false then
              local played = GetPlayer(target)
              if played then
                     SpreadAcid[played.UserId] = played
              end
       elseif state == false then
              for _,v in next, SpreadAcid do
                     SpreadAcid[v.UserId] = nil
              end
       end
end})
Section:AddButton({text = "Heal", flag = "button", callback = function() Heal() end})
Section:AddToggle({text = "Auto Heal", flag = "button", callback = function(state) autoHeal = state end})
Section2:AddButton({text = "Kill Zombies", flag = "button", callback = function() stop2 = true; KillZombies(); stop2 = false end})
Section2:AddToggle({text = "Loopkill Zombies", flag = "toggle", callback = function(state)
    LoopkillZombies = state
    stop2 = state
end})
Section3:AddButton({text = "Summon Necro", flag = "button", callback = function() Summon("NpcZombie") end})
Section3:AddToggle({text = "Auto Spawn Necro", flag = "toggle", callback = function(state) LoopsummonNecro = state end})
Section3:AddButton({text = "Summon Landmine", flag = "button", callback = function() Summon("Landmine") end})
Section3:AddToggle({text = "Auto Spawn Landmine", flag = "toggle", callback = function(state) LoopsummonLandmine = state end})
Section3:AddButton({text = "Summon Acid", flag = "button", callback = function() Summon("Acid") end})
Section3:AddToggle({text = "Auto Spawn Acid", flag = "toggle", callback = function(state) LoopsummonAcid = state end})
Section4:AddButton({text = "Become Human", flag = "button", callback = function() Become("Human") end})
Section4:AddButton({text = "Become Zombie", flag = "button", callback = function() Become("Zombie") end})
Section4:AddButton({text = "Become Spitter", flag = "button", callback = function() Become("Spitter") end})
Section5:AddList({text = 'Select Weapons', values = weaponTable, callback = function(value) game.ReplicatedStorage.Remotes.Shop.EquipWeapon:InvokeServer(value) end, open = false, flag = 'color_option'})
Section6:AddButton({text = "Necro", flag = "button", callback = function()
    lagServer(game.ReplicatedStorage.Remotes.ZombieRelated.Necro.AbilityPlayer)
    task.wait()
    rejoin()
end})
Section6:AddButton({text = "Landmine", flag = "button", callback = function()
    lagServer(game.ReplicatedStorage.NetworkEvents.RemoteEvent, "PLACE_LANDMINE")
    task.wait()
    rejoin()
end})
task.spawn(function()
    game:GetService('RunService').RenderStepped:Connect(function(dt)
        if killAura.Me then
            for i,v in ipairs(game.Workspace.LivingThings:GetChildren()) do
                if v ~= game.Players.LocalPlayer.Character and v:FindFirstChild("Humanoid").Health > 0 and not v:FindFirstChildOfClass("ForceField") then
                    if v:FindFirstChild("Head") and v:GetAttribute("Team") ~= game.Players.LocalPlayer.Character:GetAttribute("Team") then
                        local head = v:FindFirstChild("Head")
                        if (game.Players.LocalPlayer.Character.Head.Position - head.Position).Magnitude - (game.Players.LocalPlayer.Character.Head.Size.Magnitude / 2) - (head.Size.Magnitude / 2) <= 8.5 and not stop2 == true then
                            if game.Players.LocalPlayer.Character:GetAttribute("Team") == "Human" then
                                if not (find.Weapons(true) or find.Weapons(false)) then
                                    if (tick() - startTime.Two) >= 0.5 then
                                        startTime.Two = tick(); game.ReplicatedStorage.Remotes.Shop.EquipWeapon:InvokeServer("Classic Sword")
                                    end
                                end; if find.Weapons(false) then
                                    if (tick() - startTime.Three) >= 0.5 then
                                        startTime.Three = tick(); game.Players.LocalPlayer.Character.Humanoid:EquipTool(find.Weapons(false))
                                    end
                                end
                                if find.Weapons(true) then game.ReplicatedStorage.Remotes.Melee.Damage:InvokeServer(head) end
                            elseif game.Players.LocalPlayer.Character:GetAttribute("Team") == "Zombie" then
                                if not (find.Weapons(true) or find.Weapons(false)) then
                                    if (tick() - startTime.Four) >= 0.5 then
                                        startTime.Four = tick(); game.ReplicatedStorage.Remotes.Shop.EquipWeapon:InvokeServer("Bone Sword")
                                    end
                                end; if find.Weapons(false) then
                                    if (tick() - startTime.Five) >= 0.5 then
                                        startTime.Five = tick(); game.Players.LocalPlayer.Character.Humanoid:EquipTool(find.Weapons(false))
                                    end
                                end
                                if find.Weapons(true) then game.ReplicatedStorage.Remotes.Melee.Damage:InvokeServer(head) end
                            end
                        end
                    end
                end
            end
        end
        if LoopsummonLandmine then Summon("Landmine") end
        if LoopkillZombies then KillZombies() end
        if LoopsummonNecro then Summon("NpcZombie") end
    end)
    game:GetService("RunService").PreSimulation:Connect(function(dt)
        if InfectAura then
            for i,v in ipairs(game.Workspace.LivingThings:GetChildren()) do
                if v ~= game.Players.LocalPlayer.Character and v:FindFirstChild("HumanoidRootPart") then
                    local root = v.HumanoidRootPart
                    if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - root.Position).Magnitude - (game.Players.LocalPlayer.Character.HumanoidRootPart.Size.Magnitude / 2) - (root.Size.Magnitude / 2) <= 5 and v:FindFirstChild("Humanoid").Health > 0 then
                        if not v:FindFirstChildOfClass("ForceField") and v:GetAttribute("Team") == "Human" then
                            if game.Players.LocalPlayer.Backpack:FindFirstChild("Attack") then
                                if (tick() - startTime.Six) >= 0.75 then
                                    startTime.Six = tick(); game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("Attack"))
                                end
                            end
                            if game.Players.LocalPlayer.Character:FindFirstChild("Attack") then game.ReplicatedStorage.Remotes.ZombieRelated.PlayerAttack:InvokeServer(root) end
                        end
                    end
                end
            end
        end
        if LoopsummonAcid then Summon("Acid") end
        if TargetAcid then
            for _,v in next, TargetAcid do
                if v.Character and v.Character:FindFirstChild("Humanoid") then
                    Acid((v.Character.Head.CFrame * CFrame.new(0, 5, 0)).Position, v.Character.Torso.Position)
                end
            end
        end
        if SpreadAcid then
            for _,v in next, SpreadAcid do
                if v.Character and v.Character:FindFirstChild("Humanoid") then
                    local head = v.Character:FindFirstChild("Head"); local offset = def(RNG:NextNumber(-5, 5), RNG:NextNumber(0, 9), RNG:NextNumber(0, -13)); local targetPos = (head.CFrame * CFrame.new(offset)).Position
                    Acid(head.Position, targetPos)
                end
            end
        end
    end)
    game:GetService("RunService").Heartbeat:Connect(function(dt)
        if autoHeal and (tick() - startTime.Seven) >= 1 then startTime.Seven = tick(); Heal() end
        if killAura.Plr then
            for i,v in next, killAura.Plr do
                if (v.Character and v.Character:IsA("Model")) then
                    for _,b in pairs(workspace.LivingThings:GetChildren()) do
                        if (b and b:FindFirstChild("Torso") and b:FindFirstChild("Humanoid")) and b.Humanoid.Health > 0 and not b:FindFirstChildOfClass("ForceField") then
                            local torso = b:FindFirstChild("Torso")
                            if (v.Character.Torso.Position - torso.Position).Magnitude - (v.Character.Torso.Size.Magnitude / 2) - (torso.Size.Magnitude / 2) <= 7 and game.Players.LocalPlayer.Character:GetAttribute("Team") == "Human" then
                                if b ~= game.Players.LocalPlayer.Character and b ~= v.Character then
                                    if b:GetAttribute("Team") == "Human" then
                                        if not (game.Players.LocalPlayer.Character:FindFirstChild("Raygun") or game.Players.LocalPlayer.Backpack:FindFirstChild("Raygun")) then
											if (tick() - startTime.Eleven) >= 0.5 then
                                                startTime.Eleven = tick(); game.ReplicatedStorage.Remotes.Shop.EquipWeapon:InvokeServer("Raygun")
											end
                                        end
                                        if game.Players.LocalPlayer.Backpack:FindFirstChild("Raygun") then
                                            if (os.clock() - startTime.Ten) >= 0.5 then
                                                startTime.Ten = os.clock(); game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("Raygun"))
                                            end
										end
                                        if game.Players.LocalPlayer.Character:FindFirstChild("Raygun") then game.ReplicatedStorage.Remotes.Guns.Damage:FireServer(torso) end
                                    elseif b:GetAttribute("Team") == "Zombie" then Kill(torso.Parent, true) end
                                end
                            end
                        end
                    end
                end
            end
        end
    end)
end)
Window:AddFolder("Created by NoobHubV7"); Window2:AddFolder("Created by NoobHubV7")
lib:Init()
