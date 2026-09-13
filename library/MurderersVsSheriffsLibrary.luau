--!strict

export type AppearanceInfo = {
    TextureID: string,
    Color: Color3,
    Material: Enum.Material,
    Transparency: number
}

export type KnifePayload = {
    Action: string,
    KnifeAction: string?,
    Handle: BasePart,
    AppearanceInfo: AppearanceInfo?,
    StartPosition: Vector3?,
    EndPosition: Vector3?,
    Attacker: Player?
}

export type BulletPayload = {
    [number]: any
}

local Players = cloneref(game:GetService("Players")) :: Players
local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage")) :: ReplicatedStorage
local CollectionService = cloneref(game:GetService("CollectionService")) :: CollectionService
local Workspace = cloneref(game:GetService("Workspace")) :: Workspace
local TweenService = cloneref(game:GetService("TweenService")) :: TweenService
local Debris = cloneref(game:GetService("Debris")) :: Debris

local VALID_GUNS = { Gun = true, Glockinator = true }
local CRS: any = require(ReplicatedStorage:WaitForChild("ClientResources") :: ModuleScript)

local MvSLibrary = {}
MvSLibrary.__index = MvSLibrary

function MvSLibrary.new()
    local self = setmetatable({
        LocalPlayer = Players.LocalPlayer :: Player,
        IsShoot = false,
        IsThrow = false,
        AutoWait = true :: boolean?,
        PlayersTable = {} :: {Player},
        CachedRayParams = CRS.createRaycastParams(),
        Folder = workspace:FindFirstChild("Effects"),
        ValidPlayersMap = {} :: {[Player]: boolean?},
    }, MvSLibrary)

    Players.PlayerRemoving:Connect(function(plr)
        self.ValidPlayersMap[plr] = nil
        local played = table.find(self.PlayersTable, plr)
        if played then
            table.remove(self.PlayersTable, played)
            break
        end
    end)
    
    return self
end

function MvSLibrary:CheckTeam(): string
    local char = self.LocalPlayer.Character
    local backpack = self.LocalPlayer:FindFirstChildOfClass("Backpack")
    
    local containers = {}
    if char then table.insert(containers, char) end
    if backpack then table.insert(containers, backpack) end

    local hasGun = false
    local hasKnife = false

    for _, container in containers do
        for _, child in container:GetChildren() do
            if child:IsA("Tool") then
                local toolName = child.Name
                if VALID_GUNS[toolName] then
                    hasGun = true
                elseif toolName:find("Knife") or child:FindFirstChild("Damage") then
                    hasKnife = true
                end
            end
        end
    end

    if hasGun then
        return "Sheriffs"
    elseif hasKnife then
        return "Murderers"
    else
        return "Joining"
    end
end

function MvSLibrary:UpdateList()
    for _, plr in Players:GetPlayers() do
        if plr ~= self.LocalPlayer then
            local char = plr.Character
            local isValid = char and CRS.canCharacterTakeDamage(char)
            local isInTable = self.ValidPlayersMap[plr] or false

            if isValid and not isInTable then
                -- Player hợp lệ nhưng chưa có trong danh sách -> Thêm vào
                self.ValidPlayersMap[plr] = true
                table.insert(self.PlayersTable, plr)
            elseif not isValid and isInTable then
                -- Player không còn hợp lệ nhưng đang có trong danh sách -> Xóa đi
                self.ValidPlayersMap[plr] = nil
                local index = table.find(self.PlayersTable, plr)
                if index then
                    table.remove(self.PlayersTable, index)
                end
            end
        end
    end
end

function MvSLibrary:PlayKnifeAnimation(char: Model?, waitToStop: boolean?)
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    local knife = char:FindFirstChild("Knife") or char:FindFirstChildOfClass("Tool")
    if not hum or not knife then return end

    local animName = `Throw{if hum.RigType == Enum.HumanoidRigType.R15 then "" else "R6"}`
    local animObj = knife:FindFirstChild(animName) :: Animation?

    if animObj then
        local animTrack = hum:LoadAnimation(animObj)
        animTrack:Play()
        if waitToStop then animTrack.Stopped:Wait() end
    end
end

function MvSLibrary:CreateKnife(knifeTool: Instance, appearanceInfo: AppearanceInfo, startPos: Vector3, endPos: Vector3, attacker: Player)
    local projectileContainer = Workspace:FindFirstChild("ProjectilesAndDebris") or Workspace
    local projectileModel = (ReplicatedStorage.ClientResources:WaitForChild("KnifeProjectile") :: Model):Clone()
    local visualPart = projectileModel:WaitForChild("Visual") :: BasePart

    pcall(function()
        visualPart.TextureID = appearanceInfo.TextureID
        visualPart.Color = appearanceInfo.Color
        visualPart.Material = appearanceInfo.Material
        visualPart.Transparency = appearanceInfo.Transparency
    end)

    local dirVector = endPos - startPos
    local distance = dirVector.Magnitude
    if distance < 0.1 then 
        projectileModel:Destroy()
        return
    end

    local initialCFrame = CFrame.lookAt(startPos, endPos)
    projectileModel:PivotTo(initialCFrame)

    local vecVel = visualPart:FindFirstChild("VectorVelocity")
    if vecVel and vecVel:IsA("LinearVelocity") then
        vecVel.VectorVelocity = dirVector.Unit * 1500
    end

    local alignOrient = visualPart:FindFirstChild("AlignOrientation")
    if alignOrient and alignOrient:IsA("AlignOrientation") then
        alignOrient.CFrame = initialCFrame
    end

    if attacker == self.LocalPlayer then
        task.spawn(function()
            self.CachedRayParams.FilterDescendantsInstances = if self.LocalPlayer.Character then {self.LocalPlayer.Character} else {}
            local rayHit = Workspace:Raycast(startPos, dirVector, self.CachedRayParams)
            
            local actualEndPos = if rayHit then rayHit.Position else endPos
            local actualDistance = (actualEndPos - startPos).Magnitude

            local tracer = Instance.new("Part")
            tracer.Anchored = true
            tracer.CanCollide = false
            tracer.TopSurface, tracer.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
            tracer.CastShadow = false
            tracer.Material = Enum.Material.Neon
            tracer.Color = Color3.fromRGB(255, 255, 255)
            tracer.Size = Vector3.new(0.25, 0.25, actualDistance)
            tracer.CFrame = CFrame.new(startPos, actualEndPos) * CFrame.new(0, 0, -actualDistance / 2)
            
            CollectionService:AddTag(tracer, "IgnoreProjectiles")

            for face = 0, 5 do
                local light = Instance.new("SurfaceLight", tracer)
                light.Range = 10
                light.Brightness = 1.5
                light.Color = Color3.fromRGB(255, 255, 255)
                light.Face = Enum.NormalId:GetEnumItems()[face + 1]
                TweenService:Create(light, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), { Brightness = 0 }):Play()
            end
            
            Debris:AddItem(tracer, 1)
            tracer.Parent = projectileContainer

            TweenService:Create(tracer, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Transparency = 1,
                Size = Vector3.new(0.01, 0.01, actualDistance)
            }):Play()
        end)
    end

    Debris:AddItem(projectileModel, 3)
    projectileModel.Parent = projectileContainer
end

function MvSLibrary:LineOfSightEstablished(targetPart: Instance?, isKnife: boolean): boolean
    if not targetPart or not targetPart:IsA("BasePart") then return false end
    
    local targetChar = CRS.getCharacterFromPart(targetPart) or targetPart.Parent
    local myChar = self.LocalPlayer.Character
    if not targetChar or not myChar then return false end

    local origin: Vector3? = if isKnife then
        (if myChar:FindFirstChild("Head") then (myChar:FindFirstChild("Head") :: BasePart).Position else nil)
    else
        (function(): Vector3?
            local tool = myChar:FindFirstChildOfClass("Tool")
            local barrel = tool and (tool:FindFirstChild("Barrel") or tool:FindFirstChild("Handle")) :: BasePart?
            return if barrel then barrel.Position else nil
        end)())

    if not origin then return false end

    self.CachedRayParams.FilterDescendantsInstances = {myChar}
    local direction = targetPart.Position - origin
    local raycastResult = Workspace:Raycast(origin, direction, self.CachedRayParams)

    if raycastResult then
        if CRS.getCharacterFromPart(raycastResult.Instance) == targetChar then
            return true
        end

        local checkOffsets = { Vector3.new(1.2, 0, 0), Vector3.new(-1.2, 0, 0) }
        for _, offset in checkOffsets do
            local edgePos = targetPart.Position + offset
            local edgeResult = Workspace:Raycast(origin, edgePos - origin, self.CachedRayParams)
            if edgeResult and CRS.getCharacterFromPart(edgeResult.Instance) == targetChar then
                return true
            end
        end
        return false
    end
    return true
end

function MvSLibrary:GetClosestTarget(isKnife: boolean): (Player?, BasePart?)
    local myChar = self.LocalPlayer.Character
    if not myChar then return nil, nil end
    local myHead = myChar:FindFirstChild("Head") :: BasePart?
    if not myHead then return nil, nil end

    local myPos = myHead.Position
    local candidateTarget: Player?, candidatePart: BasePart? = nil, nil
    local minDistanceSq = math.huge

    for _, player in self.PlayersTable do
        local char = player and player.Character
        if char and CRS.canCharacterTakeDamage(char) then
            local targetPart = (char:FindFirstChild("CharacterCenter") or char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")) :: BasePart?
            if targetPart then
                local offset = targetPart.Position - myPos
                local distSq = offset.X * offset.X + offset.Y * offset.Y + offset.Z * offset.Z
                
                if distSq < minDistanceSq and self:LineOfSightEstablished(targetPart, isKnife) then
                    minDistanceSq = distSq
                    candidateTarget, candidatePart = player, targetPart
                end
            end
        end
    end
    return candidateTarget, candidatePart
end

function MvSLibrary:Shoot(targetPlayer: Player?, targetPart: BasePart?)
    if self.IsShoot or not targetPlayer or not targetPlayer.Character or not targetPart then return end
    local char = self.LocalPlayer.Character
    if not char then return end
    
    local tool = char:FindFirstChildOfClass("Tool")
    if not tool or not VALID_GUNS[tool.Name] then return end
    
    local barrel = (tool:FindFirstChild("Barrel") or tool:FindFirstChild("Handle")) :: BasePart?
    local damageRemote = tool:FindFirstChild("Damage") :: RemoteEvent?
    local remotes = ReplicatedStorage:FindFirstChild("Remotes")
    local replicateBullet = remotes and remotes:FindFirstChild("ReplicateBullet") :: RemoteEvent?
    if not barrel or not damageRemote or not replicateBullet then return end

    local origin, hitPos = barrel.Position, targetPart.Position

    self.CachedRayParams.FilterDescendantsInstances = {char}
    local raycastResult = Workspace:Raycast(origin, hitPos - origin, self.CachedRayParams)

    if raycastResult and CRS.getCharacterFromPart(raycastResult.Instance) ~= targetPlayer.Character then
        return 
    end

    self.IsShoot = true
    task.delay(2.5, function() self.IsShoot = false end)

    local hrp = char:FindFirstChild("HumanoidRootPart") :: BasePart?
    if not hrp then return end

    local bulletData: BulletPayload = { origin, hitPos, { PartType = "Character" }, tool }
    CRS.createBullet(unpack(bulletData))
    replicateBullet:FireServer(bulletData)
    damageRemote:FireServer(targetPart, hitPos, hrp.Position)
end

function MvSLibrary:Throw(targetPlayer: Player?, targetPart: BasePart?)
    if self.IsThrow or not targetPlayer or not targetPlayer.Character or not targetPart then return end
    local char = self.LocalPlayer.Character
    if not char then return end
    
    local knife = char:FindFirstChildOfClass("Tool")
    if not knife or not knife.Name:find("Knife") then return end
    
    local handle = knife:FindFirstChild("Handle") :: BasePart?
    local damageRemote = knife:FindFirstChild("Damage") :: RemoteEvent?
    local remotes = ReplicatedStorage:FindFirstChild("Remotes")
    local replicateKnife = remotes and remotes:FindFirstChild("ReplicateKnife") :: RemoteEvent?
    if not handle or not damageRemote or not replicateKnife then return end

    self.IsThrow = true
    task.delay(0.85, function() self.IsThrow = false end)

    self:PlayKnifeAnimation(char, self.AutoWait)

    if not targetPlayer or not targetPlayer.Character or not targetPart or not targetPart.Parent then return end

    local startPos, endPos = handle.Position, targetPart.Position
    local appearanceInfo: AppearanceInfo = {
        TextureID = (handle :: any).TextureID,
        Color = handle.Color,
        Material = handle.Material,
        Transparency = handle.Transparency
    }

    local rayParams = RaycastParams.new()
    rayParams.FilterType = Enum.RaycastFilterType.Exclude
    rayParams.FilterDescendantsInstances = {char}

    local dirVector = endPos - startPos
    local distance = dirVector.Magnitude
    local rayHit = Workspace:Raycast(startPos, dirVector.Unit * distance, rayParams)

    local actualHitPart: Instance = targetPart
    local isWallBlocked = false

    if rayHit then
        local hitChar = CRS.getCharacterFromPart(rayHit.Instance)
        if hitChar then
            actualHitPart = rayHit.Instance
        else
            isWallBlocked = true
        end
    end

    CRS.playKnifeSounds(handle, appearanceInfo, "Throw")
    
    replicateKnife:FireServer({ Action = "PlayKnifeSound", KnifeAction = "Throw", Handle = handle } :: KnifePayload)
    replicateKnife:FireServer({
        Action = "CreateKnife",
        Handle = handle,
        AppearanceInfo = appearanceInfo,
        StartPosition = startPos,
        EndPosition = endPos,
        Attacker = self.LocalPlayer
    } :: KnifePayload)

    self:CreateKnife(handle, appearanceInfo, startPos, endPos, self.LocalPlayer)

    if not isWallBlocked then
        task.delay(math.clamp(distance / 1500, 0.02, 0.12), function()
            if actualHitPart and actualHitPart.Parent then
                damageRemote:FireServer(actualHitPart, "Throw")
            end
        end)
    end
end

function MvSLibrary:SetAutoWait(state: boolean) self.AutoWait = state end

function MvSLibrary:ToggleEffects(state: boolean)
    if self.Folder then 
        self.Folder.Parent = if state then nil else workspace 
    end
end

return MvSLibrary
