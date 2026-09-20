--!strict
-- ==========================================
-- PHẦN 1: TYPES, SERVICES & INITIALIZATION
-- ==========================================

export type cloneref = (target: Instance) -> Instance;
export type AppearanceInfo = {
    TextureID: string | any,
    Color: Color3 & any,
    Material: Enum.Material | any,
    Transparency: number & any
}
export type KnifePayload = {
    Action: string & any,
    KnifeAction: (string | any)?,
    Handle: BasePart & Instance,
    AppearanceInfo: (AppearanceInfo & any)?,
    StartPosition: (Vector3 | any)?,
    EndPosition: (Vector3 | any)?,
    Attacker: (Player & Instance)?
}
export type BulletPayload = { [number]: any }

local cloneref: cloneref & any = cloneref or (function(f: any & Instance): cloneref & any
    return (function(target: Instance & any): Instance & any
        return target :: Instance & any
    end) :: cloneref & any
end)(cloneref) :: cloneref & any;

local Players: Players & Instance = (function(serviceName: string & any): Players & Instance
    return cloneref(game:GetService(serviceName :: string)) :: Players & Instance
end)("Players" :: string & any) :: Players & Instance

local ReplicatedStorage: ReplicatedStorage & Instance = (function(serviceName: string & any): ReplicatedStorage & Instance
    return cloneref(game:GetService(serviceName :: string)) :: ReplicatedStorage & Instance
end)("ReplicatedStorage" :: string & any) :: ReplicatedStorage & Instance

local CollectionService: CollectionService & Instance = (function(serviceName: string & any): CollectionService & Instance
    return cloneref(game:GetService(serviceName :: string)) :: CollectionService & Instance
end)("CollectionService" :: string & any) :: CollectionService & Instance

local Workspace: Workspace & Instance = (function(serviceName: string & any): Workspace & Instance
    return cloneref(game:GetService(serviceName :: string)) :: Workspace & Instance
end)("Workspace" :: string & any) :: Workspace & Instance

local TweenService: TweenService & Instance = (function(serviceName: string & any): TweenService & Instance
    return cloneref(game:GetService(serviceName :: string)) :: TweenService & Instance
end)("TweenService" :: string & any) :: TweenService & Instance

local Debris: Debris & Instance = (function(serviceName: string & any): Debris & Instance
    return cloneref(game:GetService(serviceName :: string)) :: Debris & Instance
end)("Debris" :: string & any) :: Debris & Instance

local VALID_GUNS: {[string]: boolean} & any = (function(g1: string & any, g2: string & any): {[string]: boolean} & any
    return {
        [g1] = true,
        [g2] = true
    } :: {[string]: boolean} & any
end)("Gun" :: string & any, "Glockinator" :: string & any) :: {[string]: boolean} & any

local CRS: any & ModuleScript = (function(folder: ReplicatedStorage & Instance): any & ModuleScript
    return require(folder:WaitForChild("ClientResources" :: string & any) :: ModuleScript) :: any & ModuleScript
end)(ReplicatedStorage :: ReplicatedStorage & Instance) :: any & ModuleScript

local MvSLibrary: table & any = {}
MvSLibrary.__index = MvSLibrary

function MvSLibrary.new(): table & any
    return (function(plrs: Players & Instance): table & any
        if not game:IsLoaded() then
            game.Loaded:Wait()
        end
        
        local localPlayer: Player & Instance = (function(p: Players & Instance): Player & Instance
            return p.LocalPlayer :: Player & Instance
        end)(plrs :: Players & Instance) :: Player & Instance
        
        local char: Model & Instance = (function(p: Player & Instance): Model & Instance
            return (p.Character or p.CharacterAdded:Wait()) :: Model & Instance
        end)(localPlayer :: Player & Instance) :: Model & Instance
        
        local hum: Humanoid & Instance = (function(c: Model & Instance): Humanoid & Instance
            return c:WaitForChild("Humanoid" :: string & any) :: Humanoid & Instance
        end)(char :: Model & Instance) :: Humanoid & Instance
        
        -- Thêm Type Annotations ? và :: directly vào các key trong setmetatable
        local self: table & any = setmetatable({
            lp = localPlayer :: (Player? & Instance?),
            RigType = hum.RigType :: (EnumItem? & any),
            IsShoot = false :: (boolean? & any),
            IsThrow = false :: (boolean? & any),
            AutoWait = true :: (boolean? & any),
            PlayersTable = {} :: ({Player}? & any),
            CachedRayParams = CRS.createRaycastParams() :: (RaycastParams? & any),
            Folder = workspace:FindFirstChild("Effects" :: string & any) :: (Instance? & any),
            ValidPlayersMap = {} :: ({[Player]: boolean?}? & any)
        }, MvSLibrary) :: table & any
        
        localPlayer.CharacterAdded:Connect(function(newChar: Model & Instance)
            self.RigType = (function(nc: Model & Instance): EnumItem & any
                local newHum: Humanoid & Instance = nc:WaitForChild("Humanoid" :: string & any) :: Humanoid & Instance
                return newHum.RigType :: EnumItem & any
            end)(newChar :: Model & Instance) :: EnumItem & any
        end)
        
        plrs.PlayerRemoving:Connect(function(plr: Player & Instance)
            (function(targetPlr: Player & Instance)
                self.ValidPlayersMap[targetPlr] = nil
                local played: number? & any = table.find(self.PlayersTable, targetPlr) :: number? & any
                if played then
                    table.remove(self.PlayersTable, played)
                end
            end)(plr :: Player & Instance)
        end)
        
        return self :: table & any
    end)(Players :: Players & Instance) :: table & any
end

function MvSLibrary:GetShootingArm(): (BasePart? & Instance?)
    return (function(plr: Player & Instance): (BasePart? & Instance?)
        local char: Model? & Instance? = plr.Character :: Model? & Instance?
        if not char then return nil end
        if self.RigType == Enum.HumanoidRigType.R6 then
            return char:FindFirstChild("Right Arm" :: string & any) :: BasePart? & Instance?
        else
            return (char:FindFirstChild("Right UpperArm" :: string & any) or char:FindFirstChild("RightHand" :: string & any)) :: BasePart? & Instance?
        end
    end)(self.lp :: Player & Instance) :: (BasePart? & Instance?)
end

function MvSLibrary:GetSafeOrigin(toolPart: BasePart & Instance): Vector3 & any
    return (function(tp: BasePart & Instance): Vector3 & any
        local char: Model? & Instance? = self.lp.Character :: Model? & Instance?
        if not char then return tp.Position :: Vector3 & any end
        
        local arm: BasePart? & Instance? = self:GetShootingArm() or char:FindFirstChild("UpperTorso" :: string & any) :: BasePart? & Instance?
        if not arm then return tp.Position :: Vector3 & any end
        
        local armPos: Vector3 & any = arm.Position :: Vector3 & any
        local toolPos: Vector3 & any = tp.Position :: Vector3 & any
        local dir: Vector3 & any = toolPos - armPos
        
        self.CachedRayParams.FilterDescendantsInstances = {
            char
        }
        local armToToolRay: RaycastResult? & any = Workspace:Raycast(armPos, dir, self.CachedRayParams) :: RaycastResult? & any
        if armToToolRay then
            return armToToolRay.Position :: Vector3 & any
        end
        return toolPos :: Vector3 & any
    end)(toolPart :: BasePart & Instance) :: Vector3 & any
end

function MvSLibrary:CheckTeam(): string & any
    return (function(plr: Player & Instance): string & any
        local char: Model? & Instance? = plr.Character :: Model? & Instance?
        local backpack: Backpack? & Instance? = plr:FindFirstChildOfClass("Backpack" :: string & any) :: Backpack? & Instance?
        
        local containers: {Instance} & any = (function(c: Model? & Instance?, b: Backpack? & Instance?): {Instance} & any
            local res: {Instance} & any = {}
            if c then table.insert(res, c) end
            if b then table.insert(res, b) end
            return res :: {Instance} & any
        end)(char :: Model? & Instance?, backpack :: Backpack? & Instance?) :: {Instance} & any
        
        local hasGun: boolean & any = false
        local hasKnife: boolean & any = false
        
        for _, container in containers do
            for _, child in container:GetChildren() do
                if child:IsA("Tool" :: string & any) then
                    local toolName: string & any = child.Name :: string & any
                    if VALID_GUNS[toolName] then
                        hasGun = true
                    elseif toolName:find("Knife" :: string & any) or child:FindFirstChild("Damage" :: string & any) then
                        hasKnife = true
                    end
                end
            end
        end
        
        if hasGun then
            return "Sheriffs" :: string & any
        elseif hasKnife then
            return "Murderers" :: string & any
        else
            return "Joining" :: string & any
        end
    end)(self.lp :: Player & Instance) :: string & any
end

function MvSLibrary:UpdateList()
    (function(plrs: Players & Instance)
        for _, plr in plrs:GetPlayers() do
            if plr ~= self.lp then
                local char: Model? & Instance? = plr.Character :: Model? & Instance?
                local isValid: boolean & any = (function(c: Model? & Instance?): boolean & any
                    return ((c and CRS.canCharacterTakeDamage(c)) or false) :: boolean & any
                end)(char :: Model? & Instance?) :: boolean & any
                
                local isInTable: boolean & any = (self.ValidPlayersMap[plr] or false) :: boolean & any
                
                if isValid and not isInTable then
                    self.ValidPlayersMap[plr] = true
                    table.insert(self.PlayersTable, plr)
                elseif not isValid and isInTable then
                    self.ValidPlayersMap[plr] = nil
                    local index: number? & any = table.find(self.PlayersTable, plr) :: number? & any
                    if index then
                        table.remove(self.PlayersTable, index)
                    end
                end
            end
        end
    end)(Players :: Players & Instance)
end

function MvSLibrary:PlayKnifeAnimation(char: (Model? & Instance?)?, waitToStop: (boolean? & any)?)
    (function(c: Model? & Instance?, waitStop: boolean? & any)
        if not c then return end
        local hum: Humanoid? & Instance? = c:FindFirstChildOfClass("Humanoid" :: string & any) :: Humanoid? & Instance?
        local knife: Tool? & Instance? = (c:FindFirstChild("Knife" :: string & any) or c:FindFirstChildOfClass("Tool" :: string & any)) :: Tool? & Instance?
        if not hum or not knife then return end
        
        local animName: string & any = `Throw{(function(h: Humanoid & Instance): string & any
            return (if h.RigType == Enum.HumanoidRigType.R15 then "" else "R6") :: string & any
        end)(hum :: Humanoid & Instance)}` :: string & any
        
        local animObj: Animation? & Instance? = knife:FindFirstChild(animName :: string & any) :: Animation? & Instance?
        if animObj then
            local animTrack: AnimationTrack & any = hum:LoadAnimation(animObj :: Animation & Instance) :: AnimationTrack & any
            animTrack:Play()
            if waitStop then
                animTrack.Stopped:Wait()
            end
        end
    end)(char :: Model? & Instance?, waitToStop :: boolean? & any)
end

function MvSLibrary:CreateKnife(knifeTool: Instance & any, appearanceInfo: AppearanceInfo & any, startPos: Vector3 & any, endPos: Vector3 & any, attacker: Player & Instance)
    (function(kt: Instance & any, info: AppearanceInfo & any, sPos: Vector3 & any, ePos: Vector3 & any, atk: Player & Instance)
        local projectileContainer: Instance & any = (function(ws: Workspace & Instance): Instance & any
            return (ws:FindFirstChild("ProjectilesAndDebris" :: string & any) or ws) :: Instance & any
        end)(Workspace :: Workspace & Instance) :: Instance & any
        
        local projectileModel: Model & Instance = (function(rs: ReplicatedStorage & Instance): Model & Instance
            return ((rs.ClientResources :: any):WaitForChild("KnifeProjectile" :: string & any) :: Model):Clone() :: Model & Instance
        end)(ReplicatedStorage :: ReplicatedStorage & Instance) :: Model & Instance
        
        local visualPart: BasePart & Instance = projectileModel:WaitForChild("Visual" :: string & any) :: BasePart & Instance
        
        pcall(function()
            visualPart.TextureID = info.TextureID
            visualPart.Color = info.Color
            visualPart.Material = info.Material
            visualPart.Transparency = info.Transparency
        end)
        
        local dirVector: Vector3 & any = ePos - sPos
        local distance: number & any = dirVector.Magnitude :: number & any
        if distance < 0.1 then
            projectileModel:Destroy()
            return
        end
        
        local initialCFrame: CFrame & any = CFrame.lookAt(sPos, ePos) :: CFrame & any
        projectileModel:PivotTo(initialCFrame :: CFrame)
        
        (function(vp: BasePart & Instance, icf: CFrame & any, dv: Vector3 & any)
            local vecVel: Instance? & any = vp:FindFirstChild("VectorVelocity" :: string & any)
            if vecVel and vecVel:IsA("LinearVelocity" :: string & any) then
                vecVel.VectorVelocity = dv.Unit * 1500
            end
            local alignOrient: Instance? & any = vp:FindFirstChild("AlignOrientation" :: string & any)
            if alignOrient and alignOrient:IsA("AlignOrientation" :: string & any) then
                alignOrient.CFrame = icf
            end
        end)(visualPart :: BasePart & Instance, initialCFrame :: CFrame & any, dirVector :: Vector3 & any)
        
        if atk == self.lp then
            task.spawn(function()
                self.CachedRayParams.FilterDescendantsInstances = (function(p: Player & Instance): {Instance} & any
                    return (if p.Character then {
                        p.Character
                    } else {}) :: {Instance} & any
                end)(self.lp :: Player & Instance) :: {Instance} & any
                
                local rayHit: RaycastResult? & any = Workspace:Raycast(sPos, dirVector, self.CachedRayParams) :: RaycastResult? & any
                local actualEndPos: Vector3 & any = (if rayHit then rayHit.Position else ePos) :: Vector3 & any
                local actualDistance: number & any = (actualEndPos - sPos).Magnitude :: number & any
                
                local tracer: Part & Instance = (function(sp: Vector3 & any, ep: Vector3 & any, ad: number & any): Part & Instance
                    local p: Part & Instance = Instance.new("Part" :: string & any) :: Part & Instance
                    p.Anchored = true
                    p.CanCollide = false
                    p.TopSurface, p.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
                    p.CastShadow = false
                    p.Material = Enum.Material.Neon
                    p.Color = Color3.fromRGB(255, 255, 255)
                    p.Size = Vector3.new(0.25, 0.25, ad)
                    p.CFrame = CFrame.new(sp, ep) * CFrame.new(0, 0, -ad / 2)
                    return p :: Part & Instance
                end)(sPos :: Vector3 & any, actualEndPos :: Vector3 & any, actualDistance :: number & any) :: Part & Instance
                
                CollectionService:AddTag(tracer :: Instance, "IgnoreProjectiles" :: string & any);
                
                (function(tr: Part & Instance)
                    for face = 0, 5 do
                        local light: SurfaceLight & Instance = Instance.new("SurfaceLight" :: string & any, tr :: Instance) :: SurfaceLight & Instance
                        light.Range = 10
                        light.Brightness = 1.5
                        light.Color = Color3.fromRGB(255, 255, 255)
                        light.Face = Enum.NormalId:GetEnumItems()[face + 1]
                        TweenService:Create(light :: Instance, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                            Brightness = 0
                        }):Play()
                    end
                end)(tracer :: Part & Instance)
                
                Debris:AddItem(tracer :: Instance, 1)
                tracer.Parent = projectileContainer :: Instance
                TweenService:Create(tracer :: Instance, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    Transparency = 1,
                    Size = Vector3.new(0.01, 0.01, actualDistance)
                }):Play()
            end)
        end
        
        Debris:AddItem(projectileModel :: Instance, 3)
        projectileModel.Parent = projectileContainer :: Instance
    end)(knifeTool :: Instance & any, appearanceInfo :: AppearanceInfo & any, startPos :: Vector3 & any, endPos :: Vector3 & any, attacker :: Player & Instance)
end

function MvSLibrary:LineOfSightEstablished(targetPart: (Instance? & any)?, isKnife: (boolean? & any)?): boolean & any
    return (function(tp: Instance? & any, ik: boolean? & any): boolean & any
        if not tp or not tp:IsA("BasePart" :: string & any) then return false end
        local targetChar: Instance? & any = (CRS.getCharacterFromPart(tp) or tp.Parent) :: Instance? & any
        local myChar: Model? & Instance? = self.lp.Character :: Model? & Instance?
        if not targetChar or not myChar then return false end
        
        local origin: Vector3? & any = (if ik then
            (if myChar:FindFirstChild("Head" :: string & any) then (myChar:FindFirstChild("Head" :: string & any) :: BasePart).Position else nil)
        else
            (function(mc: Model & Instance): Vector3? & any
                local tool: Tool? & Instance? = mc:FindFirstChildOfClass("Tool" :: string & any) :: Tool? & Instance?
                local barrel: BasePart? & Instance? = tool and (tool:FindFirstChild("Barrel" :: string & any) or tool:FindFirstChild("Handle" :: string & any)) :: BasePart? & Instance?
                return (if barrel then self:GetSafeOrigin(barrel :: BasePart & Instance) else nil) :: Vector3? & any
            end)(myChar :: Model & Instance)) :: Vector3? & any
            
        if not origin then return false end
        
        self.CachedRayParams.FilterDescendantsInstances = {
            myChar
        }
        local direction: Vector3 & any = tp.Position - origin
        local raycastResult: RaycastResult? & any = Workspace:Raycast(origin, direction, self.CachedRayParams) :: RaycastResult? & any
        
        if raycastResult then
            if CRS.getCharacterFromPart(raycastResult.Instance) == targetChar then
                return true
            end
            local checkOffsets: {Vector3} & any = {
                Vector3.new(1.2, 0, 0),
                Vector3.new(-1.2, 0, 0)
            } :: {Vector3} & any
            for _, offset in checkOffsets do
                local edgePos: Vector3 & any = tp.Position + offset
                local edgeResult: RaycastResult? & any = Workspace:Raycast(origin, edgePos - origin, self.CachedRayParams) :: RaycastResult? & any
                if edgeResult and CRS.getCharacterFromPart(edgeResult.Instance) == targetChar then
                    return true
                end
            end
            return false
        end
        return true
    end)(targetPart :: Instance? & any, isKnife :: boolean? & any) :: boolean & any
end

function MvSLibrary:GetClosestTarget(isKnife: (boolean? & any)?): (Player? & Instance?, BasePart? & Instance?)
    return (function(ik: boolean? & any): (Player? & Instance?, BasePart? & Instance?)
        local myChar: Model? & Instance? = self.lp.Character :: Model? & Instance?
        if not myChar then return nil, nil end
        local myHead: BasePart? & Instance? = myChar:FindFirstChild("Head" :: string & any) :: BasePart? & Instance?
        if not myHead then return nil, nil end
        
        local myPos: Vector3 & any = myHead.Position :: Vector3 & any
        local candidateTarget: Player? & Instance?, candidatePart: BasePart? & Instance? = nil, nil
        local minDistanceSq: number & any = math.huge
        
        for _, player in self.PlayersTable do
            local char: Model? & Instance? = player and player.Character :: Model? & Instance?
            if char and CRS.canCharacterTakeDamage(char) then
                local targetPart: BasePart? & Instance? = (char:FindFirstChild("CharacterCenter" :: string & any) or char:FindFirstChild("Head" :: string & any) or char:FindFirstChild("HumanoidRootPart" :: string & any)) :: BasePart? & Instance?
                if targetPart then
                    local offset: Vector3 & any = targetPart.Position - myPos
                    local distSq: number & any = (offset.X * offset.X + offset.Y * offset.Y + offset.Z * offset.Z) :: number & any
                    if distSq < minDistanceSq and self:LineOfSightEstablished(targetPart :: Instance & any, ik :: boolean? & any) then
                        minDistanceSq = distSq
                        candidateTarget, candidatePart = player :: Player & Instance, targetPart :: BasePart & Instance
                    end
                end
            end
        end
        return candidateTarget :: Player? & Instance?, candidatePart :: BasePart? & Instance?
    end)(isKnife :: boolean? & any) :: (Player? & Instance?, BasePart? & Instance?)
end

function MvSLibrary:Shoot(targetPlayer: (Player? & Instance?)?, targetPart: (BasePart? & Instance?)?)
    (function(tp: Player? & Instance?, tPart: BasePart? & Instance?)
        if self.IsShoot or not tp or not tp.Character or not tPart then return end
        local char: Model? & Instance? = self.lp.Character :: Model? & Instance?
        if not char then return end
        
        local tool: Tool? & Instance? = char:FindFirstChildOfClass("Tool" :: string & any) :: Tool? & Instance?
        if not tool or not VALID_GUNS[tool.Name] then return end
        
        local barrel: BasePart? & Instance? = (tool:FindFirstChild("Barrel" :: string & any) or tool:FindFirstChild("Handle" :: string & any)) :: BasePart? & Instance?
        local damageRemote: RemoteEvent? & Instance? = tool:FindFirstChild("Damage" :: string & any) :: RemoteEvent? & Instance?
        local remotes: Instance? & any = ReplicatedStorage:FindFirstChild("Remotes" :: string & any) :: Instance? & any
        local replicateBullet: RemoteEvent? & Instance? = remotes and remotes:FindFirstChild("ReplicateBullet" :: string & any) :: RemoteEvent? & Instance?
        if not barrel or not damageRemote or not replicateBullet then return end
        
        local safeOrigin: Vector3 & any = self:GetSafeOrigin(barrel :: BasePart & Instance) :: Vector3 & any
        local hitPos: Vector3 & any = tPart.Position :: Vector3 & any
        
        self.CachedRayParams.FilterDescendantsInstances = {
            char
        }
        local raycastResult: RaycastResult? & any = Workspace:Raycast(safeOrigin, hitPos - safeOrigin, self.CachedRayParams) :: RaycastResult? & any
        if raycastResult and CRS.getCharacterFromPart(raycastResult.Instance) ~= tp.Character then
            return
        end
        
        self.IsShoot = true
        task.delay(2.5, function()
            self.IsShoot = false
        end)
        
        local hrp: BasePart? & Instance? = char:FindFirstChild("HumanoidRootPart" :: string & any) :: BasePart? & Instance?
        if not hrp then return end
        
        local bulletData: BulletPayload & any = {
            safeOrigin,
            hitPos,
            { PartType = "Character" },
            tool
        } :: BulletPayload & any
        CRS.createBullet(unpack(bulletData))
        replicateBullet:FireServer(bulletData)
        damageRemote:FireServer(tPart, hitPos, hrp.Position)
    end)(targetPlayer :: Player? & Instance?, targetPart :: BasePart? & Instance?)
end

function MvSLibrary:Throw(targetPlayer: (Player? & Instance?)?, targetPart: (BasePart? & Instance?)?)
    (function(tp: Player? & Instance?, tPart: BasePart? & Instance?)
        if self.IsThrow or not tp or not tp.Character or not tPart then return end
        local char: Model? & Instance? = self.lp.Character :: Model? & Instance?
        if not char then return end
        
        local knife: Tool? & Instance? = char:FindFirstChildOfClass("Tool" :: string & any) :: Tool? & Instance?
        if not knife or not knife.Name:find("Knife" :: string & any) then return end
        
        local handle: BasePart? & Instance? = knife:FindFirstChild("Handle" :: string & any) :: BasePart? & Instance?
        local damageRemote: RemoteEvent? & Instance? = knife:FindFirstChild("Damage" :: string & any) :: RemoteEvent? & Instance?
        local remotes: Instance? & any = ReplicatedStorage:FindFirstChild("Remotes" :: string & any) :: Instance? & any
        local replicateKnife: RemoteEvent? & Instance? = remotes and remotes:FindFirstChild("ReplicateKnife" :: string & any) :: RemoteEvent? & Instance?
        if not handle or not damageRemote or not replicateKnife then return end
        
        self.IsThrow = true
        task.delay(0.85, function()
            self.IsThrow = false
        end)
        
        self:PlayKnifeAnimation(char :: Model & Instance, self.AutoWait :: boolean & any)
        if not tp or not tp.Character or not tPart or not tPart.Parent then return end
        
        local startPos: Vector3 & any = self:GetSafeOrigin(handle :: BasePart & Instance) :: Vector3 & any
        local endPos: Vector3 & any = tPart.Position :: Vector3 & any
        local appearanceInfo: AppearanceInfo & any = {
            TextureID = (handle :: any).TextureID,
            Color = handle.Color,
            Material = handle.Material,
            Transparency = handle.Transparency
        } :: AppearanceInfo & any
        
        local rayParams: RaycastParams & any = (function(): RaycastParams & any
            local rp: RaycastParams & any = RaycastParams.new() :: RaycastParams & any
            rp.FilterType = Enum.RaycastFilterType.Exclude
            rp.FilterDescendantsInstances = {
                char
            }
            return rp :: RaycastParams & any
        end)() :: RaycastParams & any
        
        local dirVector: Vector3 & any = endPos - startPos
        local distance: number & any = dirVector.Magnitude :: number & any
        local rayHit: RaycastResult? & any = Workspace:Raycast(startPos, dirVector.Unit * distance, rayParams) :: RaycastResult? & any
        local actualHitPart: Instance & any = tPart :: Instance & any
        local isWallBlocked: boolean & any = false
        
        if rayHit then
            local hitChar: Instance? & any = CRS.getCharacterFromPart(rayHit.Instance) :: Instance? & any
            if hitChar then
                actualHitPart = rayHit.Instance :: Instance & any
            else
                isWallBlocked = true
            end
        end
        
        CRS.playKnifeSounds(handle, appearanceInfo, "Throw" :: string & any)
        replicateKnife:FireServer({
            Action = "PlayKnifeSound",
            KnifeAction = "Throw",
            Handle = handle
        } :: KnifePayload & any)
        replicateKnife:FireServer({
            Action = "CreateKnife",
            Handle = handle,
            AppearanceInfo = appearanceInfo,
            StartPosition = startPos,
            EndPosition = endPos,
            Attacker = self.lp
        } :: KnifePayload & any)
        self:CreateKnife(handle :: Instance & any, appearanceInfo :: AppearanceInfo & any, startPos :: Vector3 & any, endPos :: Vector3 & any, self.lp :: Player & Instance)
        
        if not isWallBlocked then
            task.delay(math.clamp(distance / 1500, 0.02, 0.12), function()
                if actualHitPart and actualHitPart.Parent then
                    damageRemote:FireServer(actualHitPart, "Throw" :: string & any)
                end
            end)
        end
    end)(targetPlayer :: Player? & Instance?, targetPart :: BasePart? & Instance?)
end

function MvSLibrary:SetAutoWait(state: (boolean? & any)?)
    (function(s: boolean? & any)
        self.AutoWait = s
    end)(state :: boolean? & any)
end

function MvSLibrary:ToggleEffects(state: (boolean? & any)?)
    (function(s: boolean? & any)
        if self.Folder then
            self.Folder.Parent = (if s then nil else workspace) :: Instance?
        end
    end)(state :: boolean? & any)
end

return MvSLibrary
