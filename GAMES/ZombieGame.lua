local Compkiller = loadstring(game:HttpGet("https://raw.githubusercontent.com/4lpaca-pin/CompKiller/refs/heads/main/src/source.luau"))();

Compkiller:Loader("rbxassetid://15544034532", 10).yield()

local FileWatcher = Compkiller:ConfigManager({
	Directory = "Compkiller",
	Config = "Example-Configs"	
});

local Window = Compkiller.new({
	Keybind = "RightShift",
	Name = "Zombie Game",
	Logo = "rbxassetid://15544034532",
	Scale = Compkiller.Scale.Mobile,
	TextSize = 15
});

task.wait(1.5)

local players = Window:DrawTab({
	Name = "Players",
	Icon = "user",
	Type = "Single"
});

local Teams = Window:DrawTab({
	Name = "Teams",
	Icon = "users",
	Type = "Single"
});

local Items = Window:DrawTab({
	Name = "Items",
	Icon = "package",
    Type = "Single"
});

local Weapons = Window:DrawTab({
	Name = "Weapons",
	Icon = "swords",
	Type = "Single"
});

local Client = Window:DrawTab({
	Name = "Client",
	Icon = "monitor",
	Type = "Single"
});

local Server = Window:DrawTab({
	Name = "Server",
	Icon = "server",
	Type = "Single"
});

local Notifier = Compkiller.newNotify();

local killAura = {
       Plr = {},
       Me = false
}
local tool, InfectAura
local LoopkillZombies, LoopsummonNecro
local LoopsummonLandmine, LoopsummonAcid
local def, zList = Vector3.new, {-268, -250, -232, -214, -196, -178, -142, -124, -106, -88, -70, -54, -32, -16, 2, 20, 38, 56, 74, 92, 110, 128, 146, 164, 182, 200, 218, 236, 254, 272, 290, 308, 326, 344, 362}
local target, TargetAcid = nil, {}
local weaponTable, RNG = {}, Random.new()
local SpreadAcid, find = {}, {
       Weapons = "Hitbox" or "Handle" or "Damage",
	   Raygun = "Gun"
}
local event = game.ReplicatedStorage.NetworkEvents.RemoteEvent
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
       Eight = 1, --nil
       Nine = 1, --nil
       Ten = 1, --nil
	   Eleven = 1, --nil
	   Twelve = 1, --nil
	   Thirteen = 1, --nil
	   Fourteen = 1 --nil
}
local connecting, stop
local connecting2, autoHeal
local medkit, stop2
local stop3, living = nil, workspace.LivingThings
local stop4 = nil
local Namebarriers, RemoveBarrier = {
	   "ZombieSIGN",
       "ZombieDoor",
       "ZombieDoor2",
       "ZombieDoor3",
       "NoZombie"
}, false
local SavedPositions = {
	   InfectFunction = nil
}
local number = 1
do
    for i,v in next, find do
        find[i] = function(bool)
			if i == "Weapons" then
                local char = game.Players.LocalPlayer.Character; local back = game.Players.LocalPlayer.Backpack
                local container = ((bool ~= false) and char) or back
                if not (container:FindFirstChildOfClass("Tool") and container:FindFirstChildOfClass("Tool"):FindFirstChildOfClass('Model') and container:FindFirstChildOfClass("Tool"):FindFirstChildOfClass('Model'):FindFirstChild(v)) then return false end
                if (container:FindFirstChildOfClass("Tool") and container:FindFirstChildOfClass("Tool"):FindFirstChildOfClass('Model') and container:FindFirstChildOfClass("Tool"):FindFirstChildOfClass('Model'):FindFirstChild(v)) then
					if not (container:FindFirstChildOfClass("Tool"):FindFirstChildOfClass('Model'):FindFirstChild("Gun")) then
                        local Finding = (container:FindFirstChildOfClass("Tool") and container:FindFirstChildOfClass("Tool"):FindFirstChildOfClass('Model') and container:FindFirstChildOfClass("Tool"):FindFirstChildOfClass('Model'):FindFirstChild(v))
                        return Finding.Parent.Parent
					end
		        end
			elseif i == "Raygun" then
				local char = game.Players.LocalPlayer.Character; local back = game.Players.LocalPlayer.Backpack
                local container = ((bool ~= false) and char) or back
                if not (container:FindFirstChildOfClass("Tool") and container:FindFirstChildOfClass("Tool"):FindFirstChildOfClass('Model') and container:FindFirstChildOfClass("Tool"):FindFirstChildOfClass('Model'):FindFirstChild(v)) then return false end
                if (container:FindFirstChildOfClass("Tool") and container:FindFirstChildOfClass("Tool"):FindFirstChildOfClass('Model') and container:FindFirstChildOfClass("Tool"):FindFirstChildOfClass('Model'):FindFirstChild(v)) then
					if (container:FindFirstChildOfClass("Tool"):FindFirstChildOfClass('Model'):FindFirstChild("Gun")) then
                        local Finding = (container:FindFirstChildOfClass("Tool") and container:FindFirstChildOfClass("Tool"):FindFirstChildOfClass('Model') and container:FindFirstChildOfClass("Tool"):FindFirstChildOfClass('Model'):FindFirstChild(v))
                        return Finding.Parent.Parent
					end
				end
			end
        end
    end
end

table.freeze(find)

function bodyParts()
	local Found = {}
	for i,v in next, {"HumanoidRootPart","Torso","Head","Left Arm","Right Arm","Left Leg","Right Leg"} do
		if typeof(v) == "string" and game.Players.LocalPlayer.Character then
			if game.Players.LocalPlayer.Character[v] then
				Found[#Found + 1] = game.Players.LocalPlayer.Character[v]
			end
		end
	end
	return Found
end

function GetTeam(team)
	local Found, hasplayers = {}, nil
	for i,v in ipairs(living:GetChildren()) do
		if (v and v:IsA("Model")) and v:FindFirstChild("Humanoid").Health > 0 and not v.FindFirstChildOfClass(v, "ForceField") then
			if v ~= game.Players.LocalPlayer.Character and v:GetAttribute("Team") == team and v:FindFirstChild("Torso") then
				hasplayers = true
				Found[#Found + 1] = v
			end
		end
	end
	if not hasplayers then
		return
	end
	return Found
end

function Noclip(bool)
	for i,v in pairs(bodyParts()) do
		if v then
			v.CanCollide = not bool
		end
	end
end

if not workspace:FindFirstChild("Teambarriers") then
	local folder = Instance.new("Folder",workspace)
	folder.Name = "Teambarriers"
	for i,v in next, Namebarriers do
		if workspace:FindFirstChild(v, true) then
			workspace:FindFirstChild(v, true).Parent = folder
		end
	end
end
if not workspace:FindFirstChild("Acids") then
	local folder2 = Instance.new("Folder",workspace)
	folder2.Name = "Acids"
	for i,v in next, workspace:GetChildren() do
		if v.Name == "Spit" or v.Name == "Acid" then
			v.Parent = folder2
		end
	end
	workspace.ChildAdded:Connect(function(part)
		if part.Name == "Spit" or part.Name == "Acid" then
			part.Parent = folder2
		end
	end)
end
local Barrier = workspace:FindFirstChild("Teambarriers")
local acidSpit = workspace:FindFirstChild("Acids")

function CheckFriends(player)
	return not (player:IsFriendsWith(game.Players.LocalPlayer.UserId))
end

function Kill(model)
	local gun = game.Players.LocalPlayer.Backpack:FindFirstChild("Sniper") or game.Players.LocalPlayer.Character:FindFirstChild("Sniper")
	if not gun and (game.Players.LocalPlayer.Character:GetAttribute("Team") ~= "Zombie") then
		game.ReplicatedStorage.Remotes.Shop.EquipWeapon:InvokeServer("Sniper")
		repeat game:GetService("RunService").PreSimulation:Wait() until game.Players.LocalPlayer.Backpack:FindFirstChild("Sniper")
		gun = game.Players.LocalPlayer.Backpack:FindFirstChild("Sniper") or game.Players.LocalPlayer.Character:FindFirstChild("Sniper")
	elseif gun and (game.Players.LocalPlayer.Character:GetAttribute("Team") ~= "Zombie") then
		gun = game.Players.LocalPlayer.Backpack:FindFirstChild("Sniper") or game.Players.LocalPlayer.Character:FindFirstChild("Sniper")
	end
	local hasplayers = nil
	local ShootEvents = {}
	pcall(function()
		for i,v in next, GetTeam("Zombie") do
			if v == model then
				hasplayers = true
				ShootEvents[#ShootEvents + 1] = v
			end
		end
	end)
	if not hasplayers then
		return
	end
	if gun.Parent == game.Players.LocalPlayer.Backpack then
    	game.Players.LocalPlayer.Character.Humanoid:EquipTool(gun)
    end
	task.spawn(function()
		for i,v in next, ShootEvents do
			if (v and v:IsA("Model")) then
			    event:FireServer("GUN_DAMAGE", v)
			end
		end
	end)
end
function oldKillZombies()
	local gun = game.Players.LocalPlayer.Backpack:FindFirstChild("Shotgun") or game.Players.LocalPlayer.Character:FindFirstChild("Shotgun")
	if not gun and (game.Players.LocalPlayer.Character:GetAttribute("Team") ~= "Zombie") then
		game.ReplicatedStorage.Remotes.Shop.EquipWeapon:InvokeServer("Shotgun")
		repeat game:GetService("RunService").PreSimulation:Wait() until game.Players.LocalPlayer.Backpack:FindFirstChild("Shotgun")
		gun = game.Players.LocalPlayer.Backpack:FindFirstChild("Shotgun")
	elseif gun and (game.Players.LocalPlayer.Character:GetAttribute("Team") ~= "Zombie") then
		game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
		gun = game.Players.LocalPlayer.Backpack:FindFirstChild("Shotgun")
	end
	pcall(function()
	    local hasplayers = nil
	    local ShootEvents, BulletEvents = {}, {}
	    for i,v in pairs(GetTeam("Zombie")) do
			hasplayers = true
			ShootEvents[#ShootEvents + 1] = v:FindFirstChild("Torso")
			BulletEvents[#BulletEvents + 1] = {{v:FindFirstChild("Torso").Position, v:FindFirstChild("Torso").Position}}
	    end
	    if not hasplayers then
	    	return
	    end
		if gun.Parent == game.Players.LocalPlayer.Backpack then
			game.Players.LocalPlayer.Character.Humanoid:EquipTool(gun)
		end
		task.spawn(function()
	        for i = 1, 6 do
	    		game:GetService("ReplicatedStorage").Remotes.Guns.Reload:FireServer()
		        game:GetService("ReplicatedStorage").Remotes.Guns.ShotgunReplicateBullet:FireServer(BulletEvents)
	            game:GetService("ReplicatedStorage").Remotes.Guns.ShotgunDamage:FireServer(ShootEvents)
	    	    game:GetService("ReplicatedStorage").Remotes.Guns.ShotgunLoad:FireServer()
	        end
		end)
	end)
end
function KillZombies()
	local gun = game.Players.LocalPlayer.Backpack:FindFirstChild("Sniper") or game.Players.LocalPlayer.Character:FindFirstChild("Sniper")
	if not gun and (game.Players.LocalPlayer.Character:GetAttribute("Team") ~= "Zombie") then
		game.ReplicatedStorage.Remotes.Shop.EquipWeapon:InvokeServer("Sniper")
		repeat game:GetService("RunService").PreSimulation:Wait() until game.Players.LocalPlayer.Backpack:FindFirstChild("Sniper")
		gun = game.Players.LocalPlayer.Backpack:FindFirstChild("Sniper") or game.Players.LocalPlayer.Character:FindFirstChild("Sniper")
	elseif gun and (game.Players.LocalPlayer.Character:GetAttribute("Team") ~= "Zombie") then
		gun = game.Players.LocalPlayer.Backpack:FindFirstChild("Sniper") or game.Players.LocalPlayer.Character:FindFirstChild("Sniper")
	end
	local hasplayers = nil
	local ShootEvents = {}
	pcall(function()
		for i,v in next, GetTeam("Zombie") do
			hasplayers = true
			ShootEvents[#ShootEvents + 1] = v
		end
	end)
	if not hasplayers then
		return
	end
	if gun.Parent == game.Players.LocalPlayer.Backpack then
    	game.Players.LocalPlayer.Character.Humanoid:EquipTool(gun)
    end
	task.spawn(function()
		for i,v in next, ShootEvents do
			if (v and v:IsA("Model")) then
			    event:FireServer("GUN_DAMAGE", v)
			end
		end
	end)
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
              event:FireServer("PLACE_LANDMINE")
       elseif name == "Acid" then
              for coverX = -268, 378, 18 do
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
                     game:GetService("ReplicatedStorage").Remotes.ZombieRelated.TouchedAcid:FireServer("")
              end
       end
end
function GetPlayer(Player)
    local function findPlayer(stringg)
	    if (stringg == ("me")) or not stringg or (stringg == ("")) then
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
			if connecting2 then connecting2:Disconnect(); connecting2 = nil end
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
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(medkit.CFrame.p + Vector3.new(0, 7, 0)); coroutine.wrap(event.FireServer, "Medkit_Heal")()
            if (tick() - startTime.One) >= 0.2 then
                startTime.One = tick(); fireproximityprompt(medkit.ProximityPrompt)
            end
        until game.Players.LocalPlayer.Character.Humanoid.Health == 100 or game.Players.LocalPlayer.Character.Humanoid:GetState() == Enum.HumanoidStateType.Dead or not game.Players.LocalPlayer.Character:FindFirstChild("Head")
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
    end
end

function Click(name)
	local part = workspace.Interaction.ToolGivers[name]
	if part:FindFirstChildOfClass("ClickDetector") then
	    fireclickdetector(part.ClickDetector)
	end
end

function AddAttack()
	if game.Players.LocalPlayer:FindFirstChild("Attack", true) and game.Players.LocalPlayer.Character:FindFirstChild("Attack", true) then
		return
	end
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
end

function RemoveAttack()
	game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
    if tool then tool:Destroy(); tool = nil end
    if connecting then connecting:Disconnect(); connecting = nil end
    if connecting2 then connecting2:Disconnect(); connecting2 = nil end
end

function Infect(model)
	if not stop == false then return nil end
	stop = true
	SavedPositions.InfectFunction = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
	local melee = game.Players.LocalPlayer.Character:FindFirstChild("Attack") or game.Players.LocalPlayer.Backpack:FindFirstChild("Attack")
	if not melee then
		AddAttack()
		repeat game:GetService("RunService").PreSimulation:Wait() until game.Players.LocalPlayer.Backpack:FindFirstChild("Attack")
		melee = game.Players.LocalPlayer.Backpack:FindFirstChild("Attack") or game.Players.LocalPlayer.Character:FindFirstChild("Attack")
	else
		melee = game.Players.LocalPlayer.Backpack:FindFirstChild("Attack") or game.Players.LocalPlayer.Character:FindFirstChild("Attack")
	end
	local player, hasplayer = model, nil
	if (player and player:IsA("Model")) and player:FindFirstChild("Humanoid").Health > 0 and not player:FindFirstChildOfClass("ForceField") then
		if player:GetAttribute("Team") == "Human" then
			hasplayer = true
		end
	end
	if not hasplayer then
		stop = false
		return
	end
	task.spawn(function()
		startTime.Ten = tick()
		repeat game:GetService("RunService").Heartbeat:Wait()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(player.HumanoidRootPart.CFrame.p)
			coroutine.wrap(game.ReplicatedStorage.Remotes.ZombieRelated.PlayerAttack.InvokeServer)(game.ReplicatedStorage.Remotes.ZombieRelated.PlayerAttack, player.HumanoidRootPart)
		until player:GetAttribute("Team") == "Zombie" or player:FindFirstChildOfClass("ForceField") or (tick() - startTime.Ten) >= 5 or (not player)
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = SavedPositions.InfectFunction
	    if not InfectAura == true then
		    RemoveAttack()
		end
		stop = false
		return true
	end)
end
function Dupe(amount)
	if not stop3 == false then return end
	stop3 = true
	SavedPositions.Dupe = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
	for i = 1, tonumber(amount or 1) do
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 1000000, 0)
		task.wait(.15)
		game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
		local part = workspace.Interaction.ToolGivers["Rainbow Potion"]:FindFirstChildOfClass("ClickDetector")
		local tool = game.Players.LocalPlayer.Backpack:FindFirstChild("Rainbow Potion") or game.Players.LocalPlayer.Character:FindFirstChild("Rainbow Potion")
		if (part and not tool) then
			fireclickdetector(part)
			repeat game:GetService("RunService").PreRender:Wait() until game.Players.LocalPlayer.Backpack:FindFirstChild("Rainbow Potion")
		elseif not part and not tool then
		    return
		end
		task.wait(.075)
		game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
		for i,v in ipairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
			if v:IsA("Tool") and v.Name == "Rainbow Potion" then
				v.Parent = game.Players.LocalPlayer.Character
				v.Parent = workspace
			end
		end
		repeat game:GetService("RunService").PostSimulation:Wait() until workspace.Interaction.ToolGivers["Rainbow Potion"]:FindFirstChildOfClass("ClickDetector")
		fireclickdetector(workspace.Interaction.ToolGivers["Rainbow Potion"]:FindFirstChildOfClass("ClickDetector"))
		task.wait()
		for i,v in ipairs(workspace:GetChildren()) do
			if v:IsA("Tool") and v.Name == "Rainbow Potion" then
				v.Parent = game.Players.LocalPlayer.Backpack
			end
		end
		game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = SavedPositions.Dupe
		task.wait(.15)
	end
	stop3 = false
end
function old()
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
       if not state == false then
	       AddAttack()
	   elseif not state == true then
		   RemoveAttack()
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
Section2:AddButton({text = "Kill Zombies", flag = "button", callback = function() stop2 = true; KillZombies(false); stop2 = false end})
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
Section7:AddButton({text = "Give Antidote Potion", flag = "button", callback = function() Click("Antidote") end})
Section7:AddButton({text = "Give Rainbow Potion", flag = "button", callback = function() Click("Rainbow Potion") end})
Section7:AddButton({text = "Give All Sign", flag = "button", callback = function()
	if game.Players.LocalPlayer.Character:GetAttribute("Team") == "Human" then
        if not game.Players.LocalPlayer:FindFirstChild("AntiZombieSign", true) and not game.Players.LocalPlayer.Character:FindFirstChild("AntiZombieSign", true) and not game.Players.LocalPlayer:FindFirstChild("AntiZombieSign2", true) and not game.Players.LocalPlayer.Character:FindFirstChild("AntiZombieSign2", true) and not game.Players.LocalPlayer:FindFirstChild("AntiZombieSign3", true) and not game.Players.LocalPlayer.Character:FindFirstChild("AntiZombieSign3", true) then
            fireclickdetector(workspace.Interaction.ToolGivers.AntiZombieSign.ClickDetector)
            fireclickdetector(workspace.Interaction.ToolGivers.AntiZombieSign2.ClickDetector)
            fireclickdetector(workspace.Interaction.ToolGivers.AntiZombieSign3.ClickDetector)
            fireclickdetector(workspace.Interaction.ZombieSign.ClickDetector)
            fireclickdetector(workspace.Interaction:GetChildren()[15].ClickDetector or workspace.Interaction:GetChildren()[16].ClickDetector)
		end
    else
        if not game.Players.LocalPlayer:FindFirstChild("AntiZombieSign", true) and not game.Players.LocalPlayer.Character:FindFirstChild("AntiZombieSign", true) and not game.Players.LocalPlayer:FindFirstChild("AntiZombieSign2", true) and not game.Players.LocalPlayer.Character:FindFirstChild("AntiZombieSign2", true) and not game.Players.LocalPlayer:FindFirstChild("AntiZombieSign3", true) and not game.Players.LocalPlayer.Character:FindFirstChild("AntiZombieSign", true) and not game.Players.LocalPlayer:FindFirstChild("ZombieSign", true) and not game.Players.LocalPlayer.Character:FindFirstChild("ZombieSign") and not game.Players.LocalPlayer:FindFirstChild("ZombieSign2", true) and not game.Players.LocalPlayer.Character:FindFirstChild("ZombieSign2", true) then
            fireclickdetector(workspace.Interaction.ToolGivers.AntiZombieSign.ClickDetector)
            fireclickdetector(workspace.Interaction.ToolGivers.AntiZombieSign2.ClickDetector)
            fireclickdetector(workspace.Interaction.ToolGivers.AntiZombieSign3.ClickDetector)
            fireclickdetector(workspace.Interaction.ZombieSign.ClickDetector)
            fireclickdetector(workspace.Interaction:GetChildren()[15].ClickDetector or workspace.Interaction:GetChildren()[16].ClickDetector)
		end
	end
end})
Section8:AddToggle({text = "Destroy Guns", state = true, flag = "toggle", callback = function(state) Settings.DestroyGuns = state end})
Section9:AddToggle({text = "Unload Entities", flag = "toggle", callback = function(state)
	game.Players.LocalPlayer.Character.Parent = ((state ~= false) and workspace) or living
	if not state == false then
		living.Parent = nil
	elseif not state == true then
		living.Parent = workspace
	end
end})
end

do
	local main = Teams:DrawSection({Name = "Select Team"})
	main:AddButton({Name = "Become Human", Callback = function() Become("Human") end,})
	main:AddButton({Name = "Become Zombie", Callback = function() Become("Zombie") end,})
	main:AddButton({Name = "Become Spitter", Callback = function() Become("Spitter") end,})
	local main2 = Items:DrawSection({Name = "Buff Sniper"})
	main2:AddButton({Name = "Minigun Sniper", Callback = function()
		if not (game.Players.LocalPlayer.Character:FindFirstChild("Sniper") or game.Players.LocalPlayer.Backpack:FindFirstChild("Sniper")) then
		    game.ReplicatedStorage.Remotes.Shop.EquipWeapon:InvokeServer("Sniper")
		    repeat game:GetService("RunService").Heartbeat:Wait() until game.Players.LocalPlayer.Backpack:FindFirstChild("Sniper")
		end
		local tool = game.Players.LocalPlayer:FindFirstChild("Sniper", true) or game.Players.LocalPlayer.Character:FindFirstChild("Sniper", true)
		if tool then
			local script = getsenv(tool.LocalScript)
			local shoot, calc = debug.getupvalue(script.FireGun, 5), debug.getupvalue(script.FireGun, 6)
			local firesound = tool.Handle["Sniper fire sound"]
			script.FireGun = function(...)
                local soundc = firesound:Clone()
                soundc.Playing = true
                soundc.Parent = tool.Handle
                task.delay(soundc.TimeLength, function()
                    soundc:Destroy() 
                end)
                shoot(tool.Flash2.Position, calc(...))
            end
    
            local mouse = game.Players.LocalPlayer:GetMouse()
            local buttonDown = false
            mouse.Button1Down:Connect(function()
                if not buttonDown and tool.Parent == game.Players.LocalPlayer.Character then
                    buttonDown = true
                    repeat
                        coroutine.wrap(script.FireGun)(mouse.X, mouse.Y)
                        game:GetService("RunService").Heartbeat:Wait()
                    until not buttonDown
				end
			end)
    
            mouse.Button1Up:Connect(function()
                buttonDown = false
            end)
		end
	end,})
	local main3 = Items:DrawSection({Name = "Give Item"})
	main3:AddButton({Name = "Give Antidote Potion", Callback = function() Click("Antidote") end,})
	main3:AddButton({Name = "Give Rainbow Potion", Callback = function() Click("Rainbow Potion") end,})
	main3:AddButton({Name = "Give All Sign", Callback = function()
		if game.Players.LocalPlayer.Character:GetAttribute("Team") == "Human" then
            if not game.Players.LocalPlayer:FindFirstChild("AntiZombieSign", true) and not game.Players.LocalPlayer.Character:FindFirstChild("AntiZombieSign", true) and not game.Players.LocalPlayer:FindFirstChild("AntiZombieSign2", true) and not game.Players.LocalPlayer.Character:FindFirstChild("AntiZombieSign2", true) and not game.Players.LocalPlayer:FindFirstChild("AntiZombieSign3", true) and not game.Players.LocalPlayer.Character:FindFirstChild("AntiZombieSign3", true) then
                fireclickdetector(workspace.Interaction.ToolGivers.AntiZombieSign.ClickDetector)
                fireclickdetector(workspace.Interaction.ToolGivers.AntiZombieSign2.ClickDetector)
                fireclickdetector(workspace.Interaction.ToolGivers.AntiZombieSign3.ClickDetector)
                fireclickdetector(workspace.Interaction.ZombieSign.ClickDetector)
                fireclickdetector(workspace.Interaction:GetChildren()[15].ClickDetector or workspace.Interaction:GetChildren()[16].ClickDetector)
		    end
        else
            if not game.Players.LocalPlayer:FindFirstChild("AntiZombieSign", true) and not game.Players.LocalPlayer.Character:FindFirstChild("AntiZombieSign", true) and not game.Players.LocalPlayer:FindFirstChild("AntiZombieSign2", true) and not game.Players.LocalPlayer.Character:FindFirstChild("AntiZombieSign2", true) and not game.Players.LocalPlayer:FindFirstChild("AntiZombieSign3", true) and not game.Players.LocalPlayer.Character:FindFirstChild("AntiZombieSign", true) and not game.Players.LocalPlayer:FindFirstChild("ZombieSign", true) and not game.Players.LocalPlayer.Character:FindFirstChild("ZombieSign") and not game.Players.LocalPlayer:FindFirstChild("ZombieSign2", true) and not game.Players.LocalPlayer.Character:FindFirstChild("ZombieSign2", true) then
                fireclickdetector(workspace.Interaction.ToolGivers.AntiZombieSign.ClickDetector)
                fireclickdetector(workspace.Interaction.ToolGivers.AntiZombieSign2.ClickDetector)
                fireclickdetector(workspace.Interaction.ToolGivers.AntiZombieSign3.ClickDetector)
                fireclickdetector(workspace.Interaction.ZombieSign.ClickDetector)
                fireclickdetector(workspace.Interaction:GetChildren()[15].ClickDetector or workspace.Interaction:GetChildren()[16].ClickDetector)
		    end
		end
	end,})
	local main4 = Items:DrawSection({Name = "Remove Cooldown"})
	main4:AddButton({Name = "Remove Melee & Spit Cooldown", Callback = function()
	    local MeleeFunction = require(game.ReplicatedStorage.Modules.MeleeFunctions)
	    local ShovelModule = require(game.ReplicatedStorage.Modules.Items.Shovel)
	    local ShovelNew = ShovelModule.new
	    local SpitModule = require(game.ReplicatedStorage.Modules.Items.Spit)
	    local FireGun = SpitModule.FireGun

	    MeleeFunction.AddCooldown = function() end
	    MeleeFunction.CheckForCooldown = function() return false end

	    ShovelModule.new = function(...)
            local shovelObject = ShovelNew(...)
        
            if shovelObject and shovelObject.AnimationTracks and shovelObject.AnimationTracks.Attack then
                shovelObject.AnimationTracks.Attack.Speed = 1.30
            end
        
            return shovelObject
        end

        SpitModule.FireGun = function(spitObject, mouseX, mouseY)
            local headPosition = spitObject.Character.Head.Position
        
            local localPlayer = game:GetService("Players").LocalPlayer
            local cameraRay = workspace.CurrentCamera:ScreenPointToRay(mouseX, mouseY)
            local raycastParams = RaycastParams.new()
            raycastParams.FilterType = Enum.RaycastFilterType.Exclude
            raycastParams.FilterDescendantsInstances = { localPlayer.Character }
            local raycastResult = workspace:Raycast(cameraRay.Origin, cameraRay.Direction * 1000, raycastParams)
            local aimPosition = raycastResult and raycastResult.Position or (cameraRay.Origin + cameraRay.Direction * 1000)

            local directionVector = aimPosition - headPosition
        
            game.ReplicatedStorage.Remotes.ZombieRelated.AcidSpit:FireServer(headPosition, aimPosition)

            local projectileMagnitude = directionVector.Magnitude
            if projectileMagnitude > 41 then
                directionVector = directionVector.Unit * 40
                projectileMagnitude = 40
            end

            local timeToTarget = math.log(1.001 + projectileMagnitude * 0.01)
            local projectileVelocity = directionVector / timeToTarget + Vector3.new(0, workspace.Gravity * 0.5 * timeToTarget, 0)
        
            require(game.ReplicatedStorage.VisualFunctions.AcidProjectile)(headPosition, projectileVelocity)
	    end
    end,})
    local main5 = Weapons:DrawSection({Name = "Select Weapons"})
	for i,v in next, game:GetService("ReplicatedStorage").Assets.Weapons:GetChildren() do
		if v:IsA("Tool") then
			main5:AddButton({Name = "Give ".. v.Name, Callback = function()
				game.ReplicatedStorage.Remotes.Shop.EquipWeapon:InvokeServer(v.Name)
			end,})
		end
	end
	local main6 = players:DrawSection({Name = "Write Player Name"})
	main6:AddTextBox({
	    Name = "Player Name",
    	Default = "roblox123",
    	PlaceholderText = "Username or Displayname",
    	ClearTextOnFocus = true,
    	Callback = function(Value)
		    target = tostring(Value)
	    end
    })
	local main7 = Client:DrawSection({Name = "Toggle"})
	main7:AddToggle({Name = "Remove Team Barriers", Flag = "djshajfkfehdad", Default = false, Callback = function(state)
		RemoveBarrier = state
		if not RemoveBarrier == false then
			Barrier.Parent = nil
	    elseif not RemoveBarrier == true then
			Barrier.Parent = workspace
		end
	end,})
	main7:AddToggle({Name = "Unload Entities", Flag = "fjiwheu23xj", Default = false, Callback = function(state)
		game.Players.LocalPlayer.Character.Parent = ((state ~= false) and workspace) or living
	    if not state == false then
		    living.Parent = nil
	    elseif not state == true then
	    	living.Parent = workspace
		end
	end,})
	local main8 = Server:DrawSection({Name = "Kills"})
	main8:AddToggle({Name = "Kill Aura", Flag = "wifyriwfujw789jd", Default = false, Callback = function(state)
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
	end,})
	main8:AddButton({Name = "Kill Zombies", Callback = function() stop2 = true; KillZombies(false); stop2 = false end,})
	main8:AddToggle({Name = "Loopkill Zombies", Flag = "wifhcueiwkfjch367", Default = false, Callback = function(state)
		LoopkillZombies = state
	end,})
	main8:AddButton({Name = "Kill Zombies (old)", Callback = function() oldKillZombies() end,})
	local main9 = Server:DrawSection({Name = "Infect Human"})
	main9:AddToggle({Name = "Infect Aura", Flag = "djsiejfhcuriw", Default = false, Callback = function(state)
		if not state == false then
			AddAttack()
		elseif state == false then
			RemoveAttack()
		end
	    InfectAura = state
	end,})
    local main10 = Server:DrawSection({Name = "Acid"})
	main10:AddButton({Name = "Summon Acid", Callback = function() Summon("Acid") end,})
	main10:AddToggle({Name = "Target Acid", Flag = "Hwkcjcuriwkef61", Default = false, Callback = function(state)
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
	end,})
	main10:AddToggle({Name = "Spread Acid (Target)", Flag = "wodjfiwowndh69", Default = false, Callback = function(state)
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
	end,})
	local main11 = Server:DrawSection({Name = "Landmine"})
	main11:AddButton({Name = "Summon Landmine", Callback = function() Summon("Landmine") end,})
	main11:AddButton({Name = "Lag Server (Landmine)", Callback = function()
		lagServer(event, "PLACE_LANDMINE")
		game:GetService("RunService").RenderStepped:Wait()
		rejoin()
	end,})
	local main12 = Server:DrawSection({Name = "Necro"})
	main12:AddButton({Name = "Summon Necro", Callback = function() Summon("NpcZombie") end,})
	main12:AddButton({Name = "Lag Server (Necro)", Callback = function()
		lagServer(game.ReplicatedStorage.Remotes.ZombieRelated.Necro.AbilityPlayer)
		game:GetService("RunService").RenderStepped:Wait()
		rejoin()
	end,})
	local main13 = Client:DrawSection({Name = "Dupe"})
	main13:AddTextBox({
	    Name = "Dupe Amount",
    	Default = "1",
    	PlaceholderText = "Amount",
    	ClearTextOnFocus = false,
    	Callback = function(Value)
		    number = tonumber(Value)
	    end
    })
	main13:AddButton({Name = "Dupe Rainbow Potion", Callback = function() Dupe(number) end,})
	main7:AddToggle({Name = "Unload Acids", Default = false, Flag = "wofbdjwoffjru", Callback = function(state)
		if not state == false then
			acidSpit.Parent = nil
		else
			acidSpit.Parent = workspace
		end
	end,})
end
	
task.spawn(function()
    game:GetService('RunService').RenderStepped:Connect(function(dt)
	    if killAura.Me then
            for i,v in ipairs(living:GetChildren()) do
				local success, err = pcall(function()
				    if (v and v:IsA("Model")) and v.FindFirstChild(v, "Humanoid").Health > 0 and not v:FindFirstChildOfClass("ForceField") then
				    	if v ~= game.Players.LocalPlayer.Character and v:FindFirstChild("HumanoidRootPart") and ((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude - (game.Players.LocalPlayer.Character.HumanoidRootPart.Size.Magnitude / 2) - (v.HumanoidRootPart.Size.Magnitude / 2)) <= 7 then
				    		if game.Players.LocalPlayer.Character:GetAttribute("Team") ~= "Zombie" then
				    			if (string.find(v.Name, "Zombie") or string.find(v.Name, "Summon") or string.find(v.Name, "Necro")) then
					    			local weapon = find.Weapons(true) or find.Weapons(false)
							    	if not weapon and (game.Players.LocalPlayer.Character:GetAttribute("Team") == "Human") then
										if (tick() - startTime.Two) >= 0.5 then
								            startTime.Two = tick(); game.ReplicatedStorage.Remotes.Shop.EquipWeapon:InvokeServer("Classic Sword")
										end
								    	weapon = find.Weapons(true) or find.Weapons(false)
							    	elseif weapon and (game.Players.LocalPlayer.Character:GetAttribute("Team") == "Human") then
								    	weapon = find.Weapons(true) or find.Weapons(false)
							    	end
							    	if weapon.Parent == game.Players.LocalPlayer.Backpack then
										if (tick() - startTime.Three) >= 0.75 then
								            startTime.Three = tick(); game.Players.LocalPlayer.Character.Humanoid:EquipTool(find.Weapons(false))
										end
							    	end
							    	task.spawn(function()
							    		if weapon.Parent == game.Players.LocalPlayer.Character then
							     		    coroutine.wrap(game.ReplicatedStorage.Remotes.Melee.Damage.InvokeServer)(game.ReplicatedStorage.Remotes.Melee.Damage, v.HumanoidRootPart)
									    end
								    end)
								elseif not (string.find(v.Name, "Zombie") or string.find(v.Name, "Summon") or string.find(v.Name, "Necro")) then
									local players = game.Players[v.Name]
									if (players and players.Character) then
										if players.Character:GetAttribute("Team") == "Zombie" then
											return task.spawn(function()
												local weapon = find.Weapons(true) or find.Weapons(false)
							    	            if not weapon and (game.Players.LocalPlayer.Character:GetAttribute("Team") == "Human") then
								    	            if (tick() - startTime.Four) >= 0.75 then
								                        startTime.Four = tick(); game.ReplicatedStorage.Remotes.Shop.EquipWeapon:InvokeServer("Classic Sword")
													end
								    	            weapon = find.Weapons(true) or find.Weapons(false)
							    	            elseif weapon and (game.Players.LocalPlayer.Character:GetAttribute("Team") == "Human") then
								    	            weapon = find.Weapons(true) or find.Weapons(false)
							    	            end
							    	            if weapon.Parent == game.Players.LocalPlayer.Backpack then
							    		            if (tick() - startTime.Five) >= 1 then
								                        startTime.Five = tick(); game.Players.LocalPlayer.Character.Humanoid:EquipTool(find.Weapons(false))
													end
							    	            end
							    	            task.spawn(function()
							    		            if weapon.Parent == game.Players.LocalPlayer.Character then
							     		                coroutine.wrap(game.ReplicatedStorage.Remotes.Melee.Damage.InvokeServer)(game.ReplicatedStorage.Remotes.Melee.Damage, v.HumanoidRootPart)
									                end
								                end)
											end)
										elseif players.Character:GetAttribute("Team") ~= "Zombie" then
											return task.spawn(function()
												local gun = find.Raygun(false) or find.Raygun(true)
											    if not gun and (game.Players.LocalPlayer.Character:GetAttribute("Team") == "Human") then
												    if (tick() - startTime.Six) >= 1 then
								                        startTime.Six = tick(); game.ReplicatedStorage.Remotes.Shop.EquipWeapon:InvokeServer("Raygun")
													end
												    gun = find.Raygun(false) or find.Raygun(true)
												elseif gun and (game.Players.LocalPlayer.Character:GetAttribute("Team") == "Human") then
												    gun = find.Raygun(true) or find.Raygun(false)
											    end
											    if gun.Parent == game.Players.LocalPlayer.Backpack then
							    		            if (tick() - startTime.Seven) >= 1.25 then
								                        startTime.Seven = tick(); game.Players.LocalPlayer.Character.Humanoid:EquipTool(find.Raygun(false))
													end
											    end
										        task.spawn(function()
												    if gun.Parent == game.Players.LocalPlayer.Character then
													    coroutine.wrap(function()
														    game.ReplicatedStorage.Remotes.Guns.ReplicateBullet:FireServer({Vector3.new(0, 0, 0), Vector3.new(0, 0, 0)}, "Raygun")
														    game.ReplicatedStorage.Remotes.Guns.Damage:FireServer(players.Character.HumanoidRootPart)
															game.ReplicatedStorage.Remotes.Guns.Reload:FireServer()
														end)()
													end
												end)
											end)
										end
									end
								end
							    if v.Name == "HumanNpc" then return end
							end
					    end
				    end
				end)
				if not success then
					warn("[KillAura Error]:", err)
				end
			end
		end
        if LoopsummonLandmine then Summon("Landmine") end
        if LoopkillZombies then task.spawn(KillZombies, true) end
        if LoopsummonNecro then Summon("NpcZombie") end
    end)
    game:GetService("RunService").PreSimulation:Connect(function(dt)
        if InfectAura then
            for i,v in ipairs(living:GetChildren()) do
                if v ~= game.Players.LocalPlayer.Character and v:FindFirstChild("HumanoidRootPart") then
                    local root = v.HumanoidRootPart
                    if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - root.Position).Magnitude - (game.Players.LocalPlayer.Character.HumanoidRootPart.Size.Magnitude / 2) - (root.Size.Magnitude / 2) <= 7 and v:FindFirstChild("Humanoid").Health > 0 then
                        if not v:FindFirstChildOfClass("ForceField") and v:GetAttribute("Team") == "Human" then
                            if (game.Players.LocalPlayer.Backpack:FindFirstChild("Attack") or game.Players.LocalPlayer.Character:FindFirstChild("Attack")) then game.ReplicatedStorage.Remotes.ZombieRelated.PlayerAttack:InvokeServer(root) end
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
                    for _,b in pairs(living:GetChildren()) do
                        if (b and b:FindFirstChild("Torso") and b:FindFirstChild("Humanoid")) and b.Humanoid.Health > 0 and not b:FindFirstChildOfClass("ForceField") then
                            local torso = b:FindFirstChild("Torso")
                            if (v.Character.Torso.Position - torso.Position).Magnitude - (v.Character.Torso.Size.Magnitude / 2) - (torso.Size.Magnitude / 2) <= 8 and game.Players.LocalPlayer.Character:GetAttribute("Team") == "Human" then
                                if b ~= game.Players.LocalPlayer.Character and (game.Players.LocalPlayer.Character.Humanoid.Health > 0) then
									if b ~= v.Character then
                                        if (string.find(b.Name, "Zombie") or string.find(b.Name, "Summon") or string.find(b.Name, "Necro")) then return task.spawn(Kill, b)
								        elseif not (string.find(b.Name, "Zombie") or string.find(b.Name, "Summon") or string.find(b.Name, "Necro")) then
								   			if game.Players[b.Name] then
												local targ = game.Players[b.Name]
											    if targ.Character:GetAttribute("Team") == "Human" then
                                                    return task.spawn(function()
                                                        local gun = find.Raygun(false) or find.Raygun(true)
                                                        if not gun and (game.Players.LocalPlayer.Character:GetAttribute("Team") == "Human") then
                                                            if (tick() - startTime.Eight) >= 0.5 then
                                                                startTime.Eight = tick(); coroutine.wrap(game.ReplicatedStorage.Remotes.Shop.EquipWeapon.InvokeServer)(game.ReplicatedStorage.Remotes.Shop.EquipWeapon, "Raygun")
                                                            end
                                                            gun = find.Raygun(false) or find.Raygun(true)
                                                        elseif gun and (game.Players.LocalPlayer.Character:GetAttribute("Team") == "Human") then
                                                            gun = find.Raygun(true) or find.Raygun(false)
                                                        end
                                                        if gun.Parent == game.Players.LocalPlayer.Backpack then
                                                            if (tick() - startTime.Nine) >= 0.75 then
                                                                startTime.Nine = tick(); game.Players.LocalPlayer.Character.Humanoid:EquipTool(find.Raygun(false))
                                                            end
														end
                                                        task.spawn(function()
                                                            if gun.Parent == game.Players.LocalPlayer.Character then
                                                                coroutine.wrap(function()
																    game.ReplicatedStorage.Remotes.Guns.ReplicateBullet:FireServer({Vector3.new(0, 0, 0), Vector3.new(0, 0, 0)}, "Raygun")
																	game.ReplicatedStorage.Remotes.Guns.Damage:FireServer(targ.Character.Head)
																	game.ReplicatedStorage.Remotes.Guns.Reload:FireServer()
																end)()
															end
                                                        end)
                                                    end)
												elseif targ.Character:GetAttribute("Team") == "Zombie" then return task.spawn(Kill, targ.Character) end
											end
										end
										if b.Name == "HumanNpc" then
											return
										end
									end
                                end
                            end
                        end
                    end
                end
            end
        end
    end)
end)
Notifier.new({
	Title = "Loader Script!",
	Content = "Thank you for use this script!",
	Duration = 10,
	Icon = "rbxassetid://15544034532"
});
