--!strict

export type cloneref = (target: Instance) -> Instance;

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

local cloneref: cloneref = cloneref or (function(): cloneref
    return function(f: Instance): Instance return f end :: cloneref
end)() :: cloneref;

local Players: Players = (function(): Players
    return cloneref(game:GetService("Players")) :: Players
end)()

local ReplicatedStorage: ReplicatedStorage = (function(): ReplicatedStorage
    return cloneref(game:GetService("ReplicatedStorage")) :: ReplicatedStorage
end)()

local CollectionService: CollectionService = (function(): CollectionService
    return cloneref(game:GetService("CollectionService")) :: CollectionService
end)()

local Workspace: Workspace = (function(): Workspace
    return cloneref(game:GetService("Workspace")) :: Workspace
end)()

local TweenService: TweenService = (function(): TweenService
    return cloneref(game:GetService("TweenService")) :: TweenService
end)()

local Debris: Debris = (function(): Debris
    return cloneref(game:GetService("Debris")) :: Debris
end)()

local VALID_GUNS = (function(): {[string]: boolean}
    return { Gun = true, Glockinator = true }
end)()

local CRS: any = (function(): any
    return require(ReplicatedStorage:WaitForChild("ClientResources") :: ModuleScript)
end)()

local MvSLibrary = {}
MvSLibrary.__index = MvSLibrary

function MvSLibrary.new()
    (function()
        if not game:IsLoaded() then
            game.Loaded:Wait()
        end
    end)()

    local localPlayer: Player = (function(): Player
        return Players.LocalPlayer :: Player
    end)()

    local char: Model = (function(): Model
        return (localPlayer.Character or localPlayer.CharacterAdded:Wait()) :: Model
    end)()

    local hum: Humanoid = (function(): Humanoid
        return char:WaitForChild("Humanoid") :: Humanoid
    end)()

    local self = setmetatable({
        lp: Player = localPlayer :: Player,
        RigType: EnumItem = hum.RigType :: EnumItem,
        IsShoot: boolean? = false :: boolean?,
        IsThrow: boolean? = false :: boolean?,
        AutoWait: boolean? = true :: boolean?,
        PlayersTable: {Player} = {} :: {Player},
        CachedRayParams: RaycastParams = CRS.createRaycastParams() :: RaycastParams,
        Folder: Instance? = workspace:FindFirstChild("Effects") :: Instance?,
        ValidPlayersMap: {[Player]: boolean?} = {} :: {[Player]: boolean?},
    }, MvSLibrary)

    localPlayer.CharacterAdded:Connect(function(newChar: Model)
        self.RigType = (function(): EnumItem
            local newHum: Humanoid = newChar:WaitForChild("Humanoid") :: Humanoid
            return newHum.RigType :: EnumItem
        end)()
    end)

    Players.PlayerRemoving:Connect(function(plr: Player)
        (function()
            self.ValidPlayersMap[plr] = nil
            local played: number? = table.find(self.PlayersTable, plr)
            if played then
                table.remove(self.PlayersTable, played)
            end
        end)()
    end)
    
    return self
end

function MvSLibrary:GetShootingArm(): BasePart?
    return (function(): BasePart?
        local char: Model? = self.lp.Character
        if not char then return nil end

        if self.RigType == Enum.HumanoidRigType.R6 then
            return char:FindFirstChild("Right Arm") :: BasePart?
        else
            return (char:FindFirstChild("Right UpperArm") or char:FindFirstChild("RightHand")) :: BasePart?
        end
    end)()
end

function MvSLibrary:GetSafeOrigin(toolPart: BasePart): Vector3
    return (function(): Vector3
        local char: Model? = self.lp.Character
        if not char then return toolPart.Position end

        local arm: BasePart? = self:GetShootingArm() or char:FindFirstChild("UpperTorso") :: BasePart?
        if not arm then return toolPart.Position end

        local armPos: Vector3 = arm.Position
        local toolPos: Vector3 = toolPart.Position
        local dir: Vector3 = toolPos - armPos

        self.CachedRayParams.FilterDescendantsInstances = {char}
        local armToToolRay = Workspace:Raycast(armPos, dir, self.CachedRayParams)

        if armToToolRay then
            return armToToolRay.Position
        end

        return toolPos
    end)()
end

function MvSLibrary:CheckTeam(): string
    return (function(): string
        local char: Model? = self.lp.Character
        local backpack: Backpack? = self.lp:FindFirstChildOfClass("Backpack") :: Backpack?
        
        local containers = (function(): {Instance}
            local res = {}
            if char then table.insert(res, char) end
            if backpack then table.insert(res, backpack) end
            return res
        end)()

        local hasGun: boolean = false
        local hasKnife: boolean = false

        for _, container in containers do
            for _, child in container:GetChildren() do
                if child:IsA("Tool") then
                    local toolName: string = child.Name :: string
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
    end)()
end

function MvSLibrary:UpdateList()
    (function()
        for _, plr in Players:GetPlayers() do
            if plr ~= self.lp then
                local char: Model? = plr.Character
                local isValid: boolean = (function(): boolean
                    return (char and CRS.canCharacterTakeDamage(char)) or false
                end)()
                local isInTable: boolean = self.ValidPlayersMap[plr] or false

                if isValid and not isInTable then
                    self.ValidPlayersMap[plr] = true
                    table.insert(self.PlayersTable, plr)
                elseif not isValid and isInTable then
                    self.ValidPlayersMap[plr] = nil
                    local index: number? = table.find(self.PlayersTable, plr)
                    if index then
                        table.remove(self.PlayersTable, index)
                    end
                end
            end
        end
    end)()
end

function MvSLibrary:PlayKnifeAnimation(char: Model?, waitToStop: boolean?)
    (function()
        if not char then return end
        local hum: Humanoid? = char:FindFirstChildOfClass("Humanoid") :: Humanoid?
        local knife: Tool? = (char:FindFirstChild("Knife") or char:FindFirstChildOfClass("Tool")) :: Tool?
        if not hum or not knife then return end

        local animName: string = `Throw{(function(): string return if hum.RigType == Enum.HumanoidRigType.R15 then "" else "R6" end)()}`
        local animObj: Animation? = knife:FindFirstChild(animName) :: Animation?

        if animObj then
            local animTrack: AnimationTrack = hum:LoadAnimation(animObj) :: AnimationTrack
            animTrack:Play()
            if waitToStop then animTrack.Stopped:Wait() end
        end
    end)()
end

function MvSLibrary:CreateKnife(knifeTool: Instance, appearanceInfo: AppearanceInfo, startPos: Vector3, endPos: Vector3, attacker: Player)
    local projectileContainer: Instance = (function(): Instance
        return Workspace:FindFirstChild("ProjectilesAndDebris") or Workspace
    end)()
    
    local projectileModel: Model = (function(): Model
        return (ReplicatedStorage.ClientResources:WaitForChild("KnifeProjectile") :: Model):Clone()
    end)()
    
    local visualPart: BasePart = projectileModel:WaitForChild("Visual") :: BasePart

    pcall(function()
        visualPart.TextureID = appearanceInfo.TextureID
        visualPart.Color = appearanceInfo.Color
        visualPart.Material = appearanceInfo.Material
        visualPart.Transparency = appearanceInfo.Transparency
    end)

    local dirVector: Vector3 = endPos - startPos
    local distance: number = dirVector.Magnitude
    if distance < 0.1 then 
        projectileModel:Destroy()
        return
    end

    local initialCFrame: CFrame = CFrame.lookAt(startPos, endPos)
    projectileModel:PivotTo(initialCFrame)

    (function()
        local vecVel: Instance? = visualPart:FindFirstChild("VectorVelocity")
        if vecVel and vecVel:IsA("LinearVelocity") then
            vecVel.VectorVelocity = dirVector.Unit * 1500
        end

        local alignOrient: Instance? = visualPart:FindFirstChild("AlignOrientation")
        if alignOrient and alignOrient:IsA("AlignOrientation") then
            alignOrient.CFrame = initialCFrame
        end
    end)()

    if attacker == self.lp then
        task.spawn(function()
            self.CachedRayParams.FilterDescendantsInstances = (function(): {Instance}
                return if self.lp.Character then {self.lp.Character} else {}
            end)()

            local rayHit = Workspace:Raycast(startPos, dirVector, self.CachedRayParams)
            local actualEndPos: Vector3 = if rayHit then rayHit.Position else endPos
            local actualDistance: number = (actualEndPos - startPos).Magnitude

            local tracer: Part = (function(): Part
                local p = Instance.new("Part") :: Part
                p.Anchored = true
                p.CanCollide = false
                p.TopSurface, p.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
                p.CastShadow = false
                p.Material = Enum.Material.Neon
                p.Color = Color3.fromRGB(255, 255, 255)
                p.Size = Vector3.new(0.25, 0.25, actualDistance)
                p.CFrame = CFrame.new(startPos, actualEndPos) * CFrame.new(0, 0, -actualDistance / 2)
                return p
            end)()
            
            CollectionService:AddTag(tracer, "IgnoreProjectiles")

            (function()
                for face = 0, 5 do
                    local light: SurfaceLight = Instance.new("SurfaceLight", tracer) :: SurfaceLight
                    light.Range = 10
                    light.Brightness = 1.5
                    light.Color = Color3.fromRGB(255, 255, 255)
                    light.Face = Enum.NormalId:GetEnumItems()[face + 1]
                    TweenService:Create(light, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), { Brightness = 0 }):Play()
                end
            end)()
            
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
    return (function(): boolean
        if not targetPart or not targetPart:IsA("BasePart") then return false end
        
        local targetChar: Instance? = CRS.getCharacterFromPart(targetPart) or targetPart.Parent
        local myChar: Model? = self.lp.Character
        if not targetChar or not myChar then return false end

        local origin: Vector3? = if isKnife then
            (if myChar:FindFirstChild("Head") then (myChar:FindFirstChild("Head") :: BasePart).Position else nil)
        else
            (function(): Vector3?
                local tool: Tool? = myChar:FindFirstChildOfClass("Tool") :: Tool?
                local barrel: BasePart? = tool and (tool:FindFirstChild("Barrel") or tool:FindFirstChild("Handle")) :: BasePart?
                return if barrel then self:GetSafeOrigin(barrel) else nil
            end)()

        if not origin then return false end

        self.CachedRayParams.FilterDescendantsInstances = {myChar}
        local direction: Vector3 = targetPart.Position - origin
        local raycastResult = Workspace:Raycast(origin, direction, self.CachedRayParams)

        if raycastResult then
            if CRS.getCharacterFromPart(raycastResult.Instance) == targetChar then
                return true
            end

            local checkOffsets = { Vector3.new(1.2, 0, 0), Vector3.new(-1.2, 0, 0) }
            for _, offset in checkOffsets do
                local edgePos: Vector3 = targetPart.Position + offset
                local edgeResult = Workspace:Raycast(origin, edgePos - origin, self.CachedRayParams)
                if edgeResult and CRS.getCharacterFromPart(edgeResult.Instance) == targetChar then
                    return true
                end
            end
            return false
        end
        return true
    end)()
end

function MvSLibrary:GetClosestTarget(isKnife: boolean): (Player?, BasePart?)
    return (function(): (Player?, BasePart?)
        local myChar: Model? = self.lp.Character
        if not myChar then return nil, nil end
        local myHead: BasePart? = myChar:FindFirstChild("Head") :: BasePart?
        if not myHead then return nil, nil end

        local myPos: Vector3 = myHead.Position
        local candidateTarget: Player?, candidatePart: BasePart? = nil, nil
        local minDistanceSq: number = math.huge

        for _, player in self.PlayersTable do
            local char: Model? = player and player.Character
            if char and CRS.canCharacterTakeDamage(char) then
                local targetPart: BasePart? = (char:FindFirstChild("CharacterCenter") or char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")) :: BasePart?
                if targetPart then
                    local offset: Vector3 = targetPart.Position - myPos
                    local distSq: number = offset.X * offset.X + offset.Y * offset.Y + offset.Z * offset.Z
                    
                    if distSq < minDistanceSq and self:LineOfSightEstablished(targetPart, isKnife) then
                        minDistanceSq = distSq
                        candidateTarget, candidatePart = player, targetPart
                    end
                end
            end
        end
        return candidateTarget, candidatePart
    end)()
end

function MvSLibrary:Shoot(targetPlayer: Player?, targetPart: BasePart?)
    (function()
        if self.IsShoot or not targetPlayer or not targetPlayer.Character or not targetPart then return end
        local char: Model? = self.lp.Character
        if not char then return end
        
        local tool: Tool? = char:FindFirstChildOfClass("Tool") :: Tool?
        if not tool or not VALID_GUNS[tool.Name] then return end
        
        local barrel: BasePart? = (tool:FindFirstChild("Barrel") or tool:FindFirstChild("Handle")) :: BasePart?
        local damageRemote: RemoteEvent? = tool:FindFirstChild("Damage") :: RemoteEvent?
        local remotes: Instance? = ReplicatedStorage:FindFirstChild("Remotes")
        local replicateBullet: RemoteEvent? = remotes and remotes:FindFirstChild("ReplicateBullet") :: RemoteEvent?
        if not barrel or not damageRemote or not replicateBullet then return end

        local safeOrigin: Vector3 = self:GetSafeOrigin(barrel)
        local hitPos: Vector3 = targetPart.Position

        self.CachedRayParams.FilterDescendantsInstances = {char}
        local raycastResult = Workspace:Raycast(safeOrigin, hitPos - safeOrigin, self.CachedRayParams)

        if raycastResult and CRS.getCharacterFromPart(raycastResult.Instance) ~= targetPlayer.Character then
            return 
        end

        self.IsShoot = true
        task.delay(2.5, function() self.IsShoot = false end)

        local hrp: BasePart? = char:FindFirstChild("HumanoidRootPart") :: BasePart?
        if not hrp then return end

        local bulletData: BulletPayload = { safeOrigin, hitPos, { PartType = "Character" }, tool }
        CRS.createBullet(unpack(bulletData))
        replicateBullet:FireServer(bulletData)
        damageRemote:FireServer(targetPart, hitPos, hrp.Position)
    end)()
end

function MvSLibrary:Throw(targetPlayer: Player?, targetPart: BasePart?)
    (function()
        if self.IsThrow or not targetPlayer or not targetPlayer.Character or not targetPart then return end
        local char: Model? = self.lp.Character
        if not char then return end
        
        local knife: Tool? = char:FindFirstChildOfClass("Tool") :: Tool?
        if not knife or not knife.Name:find("Knife") then return end
        
        local handle: BasePart? = knife:FindFirstChild("Handle") :: BasePart?
        local damageRemote: RemoteEvent? = knife:FindFirstChild("Damage") :: RemoteEvent?
        local remotes: Instance? = ReplicatedStorage:FindFirstChild("Remotes")
        local replicateKnife: RemoteEvent? = remotes and remotes:FindFirstChild("ReplicateKnife") :: RemoteEvent?
        if not handle or not damageRemote or not replicateKnife then return end

        self.IsThrow = true
        task.delay(0.85, function() self.IsThrow = false end)

        self:PlayKnifeAnimation(char, self.AutoWait)

        if not targetPlayer or not targetPlayer.Character or not targetPart or not targetPart.Parent then return end

        local startPos: Vector3 = self:GetSafeOrigin(handle)
        local endPos: Vector3 = targetPart.Position
        local appearanceInfo: AppearanceInfo = {
            TextureID = (handle :: any).TextureID,
            Color = handle.Color,
            Material = handle.Material,
            Transparency = handle.Transparency
        }

        local rayParams: RaycastParams = (function(): RaycastParams
            local rp = RaycastParams.new() :: RaycastParams
            rp.FilterType = Enum.RaycastFilterType.Exclude
            rp.FilterDescendantsInstances = {char}
            return rp
        end)()

        local dirVector: Vector3 = endPos - startPos
        local distance: number = dirVector.Magnitude
        local rayHit = Workspace:Raycast(startPos, dirVector.Unit * distance, rayParams)

        local actualHitPart: Instance = targetPart
        local isWallBlocked: boolean = false

        if rayHit then
            local hitChar: Instance? = CRS.getCharacterFromPart(rayHit.Instance)
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
            Attacker = self.lp
        } :: KnifePayload)

        self:CreateKnife(handle, appearanceInfo, startPos, endPos, self.lp)

        if not isWallBlocked then
            task.delay(math.clamp(distance / 1500, 0.02, 0.12), function()
                if actualHitPart and actualHitPart.Parent then
                    damageRemote:FireServer(actualHitPart, "Throw")
                end
            end)
        end
    end)()
end

function MvSLibrary:SetAutoWait(state: boolean) 
    (function() self.AutoWait = state end)()
end

function MvSLibrary:ToggleEffects(state: boolean)
    (function()
        if self.Folder then 
            self.Folder.Parent = if state then nil else workspace 
        end
    end)()
end

return MvSLibrary
