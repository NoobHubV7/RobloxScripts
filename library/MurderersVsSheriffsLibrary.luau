--!strict
export type cloneref = (target: Instance) -> Instance;
export type AppearanceInfo = { TextureID: string, Color: Color3, Material: Enum.Material, Transparency: number }
export type KnifePayload = { Action: string, KnifeAction: string?, Handle: BasePart, AppearanceInfo: AppearanceInfo?, StartPosition: Vector3?, EndPosition: Vector3?, Attacker: Player? }
export type BulletPayload = { [number]: any }

local cloneref: cloneref = cloneref or (function(f): cloneref
    return function(target: Instance): Instance
        return target
    end :: cloneref
end)(cloneref) :: cloneref;

local Players: Players = (function(serviceName): Players
    return cloneref(game:GetService(serviceName)) :: Players
end)("Players")

local ReplicatedStorage: ReplicatedStorage = (function(serviceName): ReplicatedStorage
    return cloneref(game:GetService(serviceName)) :: ReplicatedStorage
end)("ReplicatedStorage")

local CollectionService: CollectionService = (function(serviceName): CollectionService
    return cloneref(game:GetService(serviceName)) :: CollectionService
end)("CollectionService")

local Workspace: Workspace = (function(serviceName): Workspace
    return cloneref(game:GetService(serviceName)) :: Workspace
end)("Workspace")

local TweenService: TweenService = (function(serviceName): TweenService
    return cloneref(game:GetService(serviceName)) :: TweenService
end)("TweenService")

local Debris: Debris = (function(serviceName): Debris
    return cloneref(game:GetService(serviceName)) :: Debris
end)("Debris")

local VALID_GUNS = (function(g1, g2): {[string]: boolean}
    return { [g1] = true, [g2] = true }
end)("Gun", "Glockinator")

local CRS: any = (function(folder): any
    return require(folder:WaitForChild("ClientResources") :: ModuleScript)
end)(ReplicatedStorage)

local MvSLibrary = {}
MvSLibrary.__index = MvSLibrary

function MvSLibrary.new()
    return (function(plrs)
        if not game:IsLoaded() then
            game.Loaded:Wait()
        end
        
        local localPlayer: Player = (function(p): Player
            return p.LocalPlayer :: Player
        end)(plrs)
        
        local char: Model = (function(p): Model
            return (p.Character or p.CharacterAdded:Wait()) :: Model
        end)(localPlayer)
        
        local hum: Humanoid = (function(c): Humanoid
            return c:WaitForChild("Humanoid") :: Humanoid
        end)(char)
        
        local self = setmetatable({
            lp = localPlayer :: Player,
            RigType = hum.RigType :: EnumItem,
            IsShoot = false :: boolean?,
            IsThrow = false :: boolean?,
            AutoWait = true :: boolean?,
            PlayersTable = {} :: {Player},
            CachedRayParams = CRS.createRaycastParams() :: RaycastParams,
            Folder = workspace:FindFirstChild("Effects") :: Instance?,
            ValidPlayersMap = {} :: {[Player]: boolean?}
        }, MvSLibrary)
        
        localPlayer.CharacterAdded:Connect(function(newChar: Model)
            self.RigType = (function(nc): EnumItem
                local newHum: Humanoid = nc:WaitForChild("Humanoid") :: Humanoid
                return newHum.RigType :: EnumItem
            end)(newChar)
        end)
        
        plrs.PlayerRemoving:Connect(function(plr: Player)
            (function(targetPlr)
                self.ValidPlayersMap[targetPlr] = nil
                local played: number? = table.find(self.PlayersTable, targetPlr)
                if played then
                    table.remove(self.PlayersTable, played)
                end
            end)(plr)
        end)
        
        return self
    end)(Players)
end

function MvSLibrary:CheckTeam(): string
    return (function(plr)
        local char: Model? = plr.Character
        local backpack: Backpack? = plr:FindFirstChildOfClass("Backpack") :: Backpack?
        
        local containers = (function(c, b): {Instance}
            local res = {}
            if c then table.insert(res, c) end
            if b then table.insert(res, b) end
            return res
        end)(char, backpack)
        
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
    end)(self.lp)
end

function MvSLibrary:UpdateList()
    (function(plrs)
        for _, plr in plrs:GetPlayers() do
            if plr ~= self.lp then
                local char: Model? = plr.Character
                local isValid: boolean = (function(c): boolean
                    return (c and CRS.canCharacterTakeDamage(c)) or false
                end)(char)
                
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
    end)(Players)
end

function MvSLibrary:PlayKnifeAnimation(char: Model?, waitToStop: boolean?)
    (function(c, waitStop)
        if not c then return end
        local hum: Humanoid? = c:FindFirstChildOfClass("Humanoid") :: Humanoid?
        local knife: Tool? = (c:FindFirstChild("Knife") or c:FindFirstChildOfClass("Tool")) :: Tool?
        if not hum or not knife then return end
        
        local animName: string = `Throw{(function(h): string
            return if h.RigType == Enum.HumanoidRigType.R15 then "" else "R6"
        end)(hum)}`
        
        local animObj: Animation? = knife:FindFirstChild(animName) :: Animation?
        if animObj then
            local animTrack: AnimationTrack = hum:LoadAnimation(animObj) :: AnimationTrack
            animTrack:Play()
            if waitStop then
                animTrack.Stopped:Wait()
            end
        end
    end)(char, waitToStop)
end

function MvSLibrary:CreateKnife(knifeTool: Instance, appearanceInfo: AppearanceInfo, startPos: Vector3, endPos: Vector3, attacker: Player)
    (function(kt, info, sPos, ePos, atk)
        local projectileContainer: Instance = (function(ws): Instance
            return ws:FindFirstChild("ProjectilesAndDebris") or ws
        end)(Workspace)
        
        local projectileModel: Model = (function(rs): Model
            return (rs.ClientResources:WaitForChild("KnifeProjectile") :: Model):Clone()
        end)(ReplicatedStorage)
        
        local visualPart: BasePart = projectileModel:WaitForChild("Visual") :: BasePart
        
        pcall(function()
            visualPart.TextureID = info.TextureID
            visualPart.Color = info.Color
            visualPart.Material = info.Material
            visualPart.Transparency = info.Transparency
        end)
        
        local dirVector: Vector3 = ePos - sPos
        local distance: number = dirVector.Magnitude
        if distance < 0.1 then
            projectileModel:Destroy()
            return
        end
        
        local initialCFrame: CFrame = CFrame.lookAt(sPos, ePos)
        projectileModel:PivotTo(initialCFrame)
        
        (function(vp, icf, dv)
            local vecVel: Instance? = vp:FindFirstChild("VectorVelocity")
            if vecVel and vecVel:IsA("LinearVelocity") then
                vecVel.VectorVelocity = dv.Unit * 1500
            end
            local alignOrient: Instance? = vp:FindFirstChild("AlignOrientation")
            if alignOrient and alignOrient:IsA("AlignOrientation") then
                alignOrient.CFrame = icf
            end
        end)(visualPart, initialCFrame, dirVector)
        
        if atk == self.lp then
            task.spawn(function()
                self.CachedRayParams.FilterDescendantsInstances = (function(p): {Instance}
                    return if p.Character then {p.Character} else {}
                end)(self.lp)
                
                local rayHit = Workspace:Raycast(sPos, dirVector, self.CachedRayParams)
                local actualEndPos: Vector3 = if rayHit then rayHit.Position else ePos
                local actualDistance: number = (actualEndPos - sPos).Magnitude
                
                local tracer: Part = (function(sp, ep, ad): Part
                    local p = Instance.new("Part") :: Part
                    p.Anchored = true
                    p.CanCollide = false
                    p.TopSurface, p.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
                    p.CastShadow = false
                    p.Material = Enum.Material.Neon
                    p.Color = Color3.fromRGB(255, 255, 255)
                    p.Size = Vector3.new(0.25, 0.25, ad)
                    p.CFrame = CFrame.new(sp, ep) * CFrame.new(0, 0, -ad / 2)
                    return p
                end)(sPos, actualEndPos, actualDistance)
                
                CollectionService:AddTag(tracer, "IgnoreProjectiles")
                
                (function(tr)
                    for face = 0, 5 do
                        local light: SurfaceLight = Instance.new("SurfaceLight", tr) :: SurfaceLight
                        light.Range = 10
                        light.Brightness = 1.5
                        light.Color = Color3.fromRGB(255, 255, 255)
                        light.Face = Enum.NormalId:GetEnumItems()[face + 1]
                        TweenService:Create(light, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), { Brightness = 0 }):Play()
                    end
                end)(tracer)
                
                Debris:AddItem(tracer, 1)
                tracer.Parent = projectileContainer
                TweenService:Create(tracer, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), { Transparency = 1, Size = Vector3.new(0.01, 0.01, actualDistance) }):Play()
            end)
        end
        
        Debris:AddItem(projectileModel, 3)
        projectileModel.Parent = projectileContainer
    end)(knifeTool, appearanceInfo, startPos, endPos, attacker)
end

function MvSLibrary:LineOfSightEstablished(targetPart: Instance?, isKnife: boolean): boolean
    return (function(tp, ik): boolean
        if not tp or not tp:IsA("BasePart") then return false end
        local targetChar: Instance? = CRS.getCharacterFromPart(tp) or tp.Parent
        local myChar: Model? = self.lp.Character
        if not targetChar or not myChar then return false end
        
        local origin: Vector3? = if ik then
            (if myChar:FindFirstChild("Head") then (myChar:FindFirstChild("Head") :: BasePart).Position else nil)
        else
            (function(mc): Vector3?
                local tool: Tool? = mc:FindFirstChildOfClass("Tool") :: Tool?
                local barrel: BasePart? = tool and (tool:FindFirstChild("Barrel") or tool:FindFirstChild("Handle")) :: BasePart?
                return if barrel then barrel.Position else nil
            end)(myChar)
            
        if not origin then return false end
        
        self.CachedRayParams.FilterDescendantsInstances = {myChar}
        local direction: Vector3 = tp.Position - origin
        local raycastResult = Workspace:Raycast(origin, direction, self.CachedRayParams)
        
        if raycastResult then
            if CRS.getCharacterFromPart(raycastResult.Instance) == targetChar then
                return true
            end
            local checkOffsets = { Vector3.new(1.2, 0, 0), Vector3.new(-1.2, 0, 0) }
            for _, offset in checkOffsets do
                local edgePos: Vector3 = tp.Position + offset
                local edgeResult = Workspace:Raycast(origin, edgePos - origin, self.CachedRayParams)
                if edgeResult and CRS.getCharacterFromPart(edgeResult.Instance) == targetChar then
                    return true
                end
            end
            return false
        end
        return true
    end)(targetPart, isKnife)
end

function MvSLibrary:GetClosestTarget(isKnife: boolean): (Player?, BasePart?)
    return (function(ik): (Player?, BasePart?)
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
                    if distSq < minDistanceSq and self:LineOfSightEstablished(targetPart, ik) then
                        minDistanceSq = distSq
                        candidateTarget, candidatePart = player, targetPart
                    end
                end
            end
        end
        return candidateTarget, candidatePart
    end)(isKnife)
end

function MvSLibrary:Shoot(targetPlayer: Player?, targetPart: BasePart?)
    (function(tp, tPart)
        if self.IsShoot or not tp or not tp.Character or not tPart then return end
        local char: Model? = self.lp.Character
        if not char then return end
        
        local tool: Tool? = char:FindFirstChildOfClass("Tool") :: Tool?
        if not tool or not VALID_GUNS[tool.Name] then return end
        
        local barrel: BasePart? = (tool:FindFirstChild("Barrel") or tool:FindFirstChild("Handle")) :: BasePart?
        local damageRemote: RemoteEvent? = tool:FindFirstChild("Damage") :: RemoteEvent?
        local remotes: Instance? = ReplicatedStorage:FindFirstChild("Remotes")
        local replicateBullet: RemoteEvent? = remotes and remotes:FindFirstChild("ReplicateBullet") :: RemoteEvent?
        if not barrel or not damageRemote or not replicateBullet then return end
        
        local safeOrigin: Vector3 = barrel.Position
        local hitPos: Vector3 = tPart.Position
        
        self.CachedRayParams.FilterDescendantsInstances = {char}
        local raycastResult = Workspace:Raycast(safeOrigin, hitPos - safeOrigin, self.CachedRayParams)
        if raycastResult and CRS.getCharacterFromPart(raycastResult.Instance) ~= tp.Character then
            return
        end
        
        self.IsShoot = true
        task.delay(2.5, function()
            self.IsShoot = false
        end)
        
        local hrp: BasePart? = char:FindFirstChild("HumanoidRootPart") :: BasePart?
        if not hrp then return end
        
        local bulletData: BulletPayload = { safeOrigin, hitPos, { PartType = "Character" }, tool }
        CRS.createBullet(unpack(bulletData))
        replicateBullet:FireServer(bulletData)
        damageRemote:FireServer(tPart, hitPos, hrp.Position)
    end)(targetPlayer, targetPart)
end

function MvSLibrary:Throw(targetPlayer: Player?, targetPart: BasePart?)
    (function(tp, tPart)
        if self.IsThrow or not tp or not tp.Character or not tPart then return end
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
        task.delay(0.85, function()
            self.IsThrow = false
        end)
        
        self:PlayKnifeAnimation(char, self.AutoWait)
        if not tp or not tp.Character or not tPart or not tPart.Parent then return end
        
        local startPos: Vector3 = handle.Position
        local endPos: Vector3 = tPart.Position
        local appearanceInfo: AppearanceInfo = {
            TextureID = (handle :: BasePart?).TextureID,
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
        local actualHitPart: Instance = tPart
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
        replicateKnife:FireServer({ Action = "CreateKnife", Handle = handle, AppearanceInfo = appearanceInfo, StartPosition = startPos, EndPosition = endPos, Attacker = self.lp } :: KnifePayload)
        self:CreateKnife(handle, appearanceInfo, startPos, endPos, self.lp)
        
        if not isWallBlocked then
            task.delay(math.clamp(distance / 1500, 0.02, 0.12), function()
                if actualHitPart and actualHitPart.Parent then
                    damageRemote:FireServer(actualHitPart, "Throw")
                end
            end)
        end
    end)(targetPlayer, targetPart)
end

function MvSLibrary:SetAutoWait(state: boolean)
    (function(s)
        self.AutoWait = s
    end)(state)
end

function MvSLibrary:ToggleEffects(state: boolean)
    (function(s)
        if self.Folder then
            self.Folder.Parent = if s then nil else workspace
        end
    end)(state)
end

return MvSLibrary
