--!strict

export type ObfuscatedType<T> = T?
export type ComplexMap<K, V> = { [K]: V }
export type FunctionWrapper<T, R> = (T) -> R

export type cloneref = <T>(target: Instance) -> Instance;
export type AppearanceInfo = {
    TextureID: ObfuscatedType<string>,
    Color: ObfuscatedType<Color3>,
    Material: ObfuscatedType<Enum.Material>,
    Transparency: ObfuscatedType<number>
}
export type KnifePayload = {
    Action: ObfuscatedType<string>,
    KnifeAction: ObfuscatedType<string>,
    Handle: ObfuscatedType<BasePart>,
    AppearanceInfo: ObfuscatedType<AppearanceInfo>,
    StartPosition: ObfuscatedType<Vector3>,
    EndPosition: ObfuscatedType<Vector3>,
    Attacker: ObfuscatedType<Player>
}
export type BulletPayload = ComplexMap<number, any>

local cloneref: ObfuscatedType<cloneref> = cloneref or (function<T>(f: any): ObfuscatedType<cloneref>
    return (function<I>(target: ObfuscatedType<Instance>): ObfuscatedType<Instance>
        return target :: any
    end) :: any
end)(cloneref) :: any;

local Players: Players = (function<S>(serviceName: ObfuscatedType<string>): Players
    return cloneref(game:GetService(serviceName :: string)) :: any
end)("Players") :: Players

local ReplicatedStorage: ReplicatedStorage = (function<S>(serviceName: ObfuscatedType<string>): ReplicatedStorage
    return cloneref(game:GetService(serviceName :: string)) :: any
end)("ReplicatedStorage") :: ReplicatedStorage

local CollectionService: CollectionService = (function<S>(serviceName: ObfuscatedType<string>): CollectionService
    return cloneref(game:GetService(serviceName :: string)) :: any
end)("CollectionService") :: CollectionService

local Workspace: Workspace = (function<S>(serviceName: ObfuscatedType<string>): Workspace
    return cloneref(game:GetService(serviceName :: string)) :: any
end)("Workspace") :: Workspace

local TweenService: TweenService = (function<S>(serviceName: ObfuscatedType<string>): TweenService
    return cloneref(game:GetService(serviceName :: string)) :: any
end)("TweenService") :: TweenService

local Debris: Debris = (function<S>(serviceName: ObfuscatedType<string>): Debris
    return cloneref(game:GetService(serviceName :: string)) :: any
end)("Debris") :: Debris

local UserInputService: UserInputService = (function<S>(serviceName: ObfuscatedType<string>): UserInputService
    return cloneref(game:GetService(serviceName :: string)) :: any
end)("UserInputService") :: UserInputService

local VALID_GUNS: ComplexMap<string, boolean> = (function<G1, G2>(g1: ObfuscatedType<string>, g2: ObfuscatedType<string>): ComplexMap<string, boolean>
    return {
        [g1 :: string] = true,
        [g2 :: string] = true
    } :: any
end)("Gun", "Glockinator") :: ComplexMap<string, boolean>

local CRS: any = (function<F>(folder: ObfuscatedType<ReplicatedStorage>): any
    return require(folder:WaitForChild("ClientResources") :: ModuleScript) :: any
end)(ReplicatedStorage) :: any

local MvSLibrary: ComplexMap<string, any> = {}
MvSLibrary.__index = MvSLibrary

function MvSLibrary.new(): ComplexMap<string, any>
    return (function<P>(plrs: Players): ComplexMap<string, any>
        if not game:IsLoaded() then
            game.Loaded:Wait()
        end
        
        local localPlayer: Player = (function<PL>(p: Players): Player
            return p.LocalPlayer :: Player
        end)(plrs) :: Player
        
        local char: Model = (function<C>(p: Player): Model
            return (p.Character or p.CharacterAdded:Wait()) :: Model
        end)(localPlayer) :: Model
        
        local hum: Humanoid = (function<H>(c: Model): Humanoid
            return c:WaitForChild("Humanoid") :: Humanoid
        end)(char) :: Humanoid
        
        local self: ComplexMap<string, any> = setmetatable({
            lp = localPlayer :: Player,
            RigType = hum.RigType :: Enum.HumanoidRigType,
            IsShoot = false :: boolean,
            IsThrow = false :: boolean,
            AutoWait = true :: boolean,
            PlayersTable = {} :: {Player},
            CachedRayParams = CRS.createRaycastParams() :: RaycastParams,
            Folder = workspace:FindFirstChild("Effects") :: Instance?,
            ValidPlayersMap = {} :: ComplexMap<Player, boolean?>,
            __index = MvSLibrary,
            __tostring = function(): string
                return "MvsSLibrary"
            end
        }, MvSLibrary) :: ComplexMap<string, any>
        
        localPlayer.CharacterAdded:Connect(function<NC>(newChar: Model)
            self.RigType = (function<NH>(nc: Model): Enum.HumanoidRigType
                local newHum: Humanoid = nc:WaitForChild("Humanoid") :: Humanoid
                return newHum.RigType :: Enum.HumanoidRigType
            end)(newChar) :: Enum.HumanoidRigType
        end)
        
        plrs.PlayerRemoving:Connect(function<PR>(plr: Player)
            (function<TP>(targetPlr: Player)
                self.ValidPlayersMap[targetPlr] = nil
                local played: number? = table.find(self.PlayersTable, targetPlr) :: number?
                if played then
                    table.remove(self.PlayersTable, played)
                end
            end)(plr)
        end)
        CRS.spreadVector2 = function(pos)
            return pos
        end
        
        return self :: ComplexMap<string, any>
    end)(Players) :: ComplexMap<string, any>
end

function MvSLibrary:GetShootingArm(): BasePart?
    return (function<PLR>(plr: Player): BasePart?
        local char: Model? = plr.Character :: Model?
        if not char then return nil end
        if self.RigType == Enum.HumanoidRigType.R6 then
            return char:FindFirstChild("Right Arm") :: BasePart?
        else
            return (char:FindFirstChild("Right UpperArm") or char:FindFirstChild("RightHand")) :: BasePart?
        end
    end)(self.lp :: Player) :: BasePart?
end

function MvSLibrary:GetSafeOrigin(toolPart: BasePart): Vector3
    return (function<TP>(tp: BasePart): Vector3
        local char: Model? = (self.lp :: Player).Character :: Model?
        if not char then return tp.Position :: Vector3 end
        
        local arm: BasePart? = (self:GetShootingArm() or char:FindFirstChild("UpperTorso")) :: BasePart?
        if not arm then return tp.Position :: Vector3 end
        
        local armPos: Vector3 = arm.Position :: Vector3
        local toolPos: Vector3 = tp.Position :: Vector3
        local dir: Vector3 = toolPos - armPos :: Vector3
        
        self.CachedRayParams.FilterDescendantsInstances = { char }
        local armToToolRay: RaycastResult? = Workspace:Raycast(armPos, dir, self.CachedRayParams) :: RaycastResult?
        if armToToolRay then
            return armToToolRay.Position :: Vector3
        end
        return toolPos :: Vector3
    end)(toolPart) :: Vector3
end

function MvSLibrary:CheckTeam(): string
    return (function<PLR>(plr: Player): string
        local char: Model? = plr.Character :: Model?
        local backpack: Backpack? = plr:FindFirstChildOfClass("Backpack") :: Backpack?
        
        local containers: {Instance} = (function<C, B>(c: Model?, b: Backpack?): {Instance}
            local res: {Instance} = {}
            if c then table.insert(res, c) end
            if b then table.insert(res, b) end
            return res :: {Instance}
        end)(char, backpack) :: {Instance}
        
        local hasGun: boolean = false :: boolean
        local hasKnife: boolean = false :: boolean
        
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
    end)(self.lp :: Player) :: string
end

function MvSLibrary:UpdateList()
    (function<PLRS>(plrs: Players)
        for _, plr in plrs:GetPlayers() do
            if plr ~= (self.lp :: Player) then
                local char: Model? = plr.Character :: Model?
                local isValid: boolean = (function<C>(c: Model?): boolean
                    return ((c and CRS.canCharacterTakeDamage(c)) or false) :: boolean
                end)(char) :: boolean
                
                local isInTable: boolean = (self.ValidPlayersMap[plr] or false) :: boolean
                
                if isValid and not isInTable then
                    self.ValidPlayersMap[plr] = true
                    table.insert(self.PlayersTable, plr)
                elseif not isValid and isInTable then
                    self.ValidPlayersMap[plr] = nil
                    local index: number? = table.find(self.PlayersTable, plr) :: number?
                    if index then
                        table.remove(self.PlayersTable, index)
                    end
                end
            end
        end
    end)(Players)
end

function MvSLibrary:PlayKnifeAnimation(char: Model, waitToStop: boolean)
    (function<C, W>(c: Model, waitStop: boolean)
        if not c then return end
        local hum: Humanoid? = c:FindFirstChildOfClass("Humanoid") :: Humanoid?
        local knife: Tool? = (c:FindFirstChild("Knife") or c:FindFirstChildOfClass("Tool")) :: Tool?
        if not hum or not knife then return end
        
        local animName: string = `Throw{(function<H>(h: Humanoid): string
            return (if h.RigType == Enum.HumanoidRigType.R15 then "" else "R6")
        end)(hum)}` :: string
        
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
    (function<KT, INFO, SP, EP, ATK>(kt: Instance, info: AppearanceInfo, sPos: Vector3, ePos: Vector3, atk: Player)
        local projectileContainer: Instance = (function<WS>(ws: Workspace): Instance
            return (ws:FindFirstChild("ProjectilesAndDebris") or ws) :: Instance
        end)(Workspace) :: Instance
        
        local projectileModel: Model = (function<RS>(rs: ReplicatedStorage): Model
            return ((rs.ClientResources :: any):WaitForChild("KnifeProjectile") :: Model):Clone() :: Model
        end)(ReplicatedStorage) :: Model
        
        local visualPart: BasePart = projectileModel:WaitForChild("Visual") :: BasePart
        
        pcall(function()
            (visualPart :: any).TextureID = info.TextureID
            visualPart.Color = info.Color :: Color3
            visualPart.Material = info.Material :: Enum.Material
            visualPart.Transparency = info.Transparency :: number
        end)
        
        local dirVector: Vector3 = ePos - sPos :: Vector3
        local distance: number = dirVector.Magnitude :: number
        if distance < 0.1 then
            projectileModel:Destroy()
            return
        end
        
        local initialCFrame: CFrame = CFrame.lookAt(sPos, ePos) :: CFrame
        projectileModel:PivotTo(initialCFrame);
        
        (function<VP, ICF, DV>(vp: BasePart, icf: CFrame, dv: Vector3)
            local vecVel: Instance? = vp:FindFirstChild("VectorVelocity") :: Instance?
            if vecVel and vecVel:IsA("LinearVelocity") then
                (vecVel :: LinearVelocity).VectorVelocity = dv.Unit * 1500
            end
            local alignOrient: Instance? = vp:FindFirstChild("AlignOrientation") :: Instance?
            if alignOrient and alignOrient:IsA("AlignOrientation") then
                (alignOrient :: AlignOrientation).CFrame = icf
            end
        end)(visualPart, initialCFrame, dirVector)
        
        if atk == (self.lp :: Player) then
            task.spawn(function()
                self.CachedRayParams.FilterDescendantsInstances = (function<P>(p: Player): {Instance}
                    return (if p.Character then { p.Character } else {}) :: {Instance}
                end)(self.lp :: Player) :: {Instance}
                
                local rayHit: RaycastResult? = Workspace:Raycast(sPos, dirVector, self.CachedRayParams) :: RaycastResult?
                local actualEndPos: Vector3 = (if rayHit then rayHit.Position else ePos) :: Vector3
                local actualDistance: number = (actualEndPos - sPos).Magnitude :: number
                
                local tracer: Part = (function<SP2, EP2, AD>(sp: Vector3, ep: Vector3, ad: number): Part
                    local p: Part = Instance.new("Part") :: Part
                    p.Anchored = true
                    p.CanCollide = false
                    p.TopSurface, p.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
                    p.CastShadow = false
                    p.Material = Enum.Material.Neon
                    p.Color = Color3.fromRGB(255, 255, 255)
                    p.Size = Vector3.new(0.25, 0.25, ad)
                    p.CFrame = CFrame.new(sp, ep) * CFrame.new(0, 0, -ad / 2)
                    return p :: Part
                end)(sPos, actualEndPos, actualDistance) :: Part
                
                CollectionService:AddTag(tracer :: Instance, "IgnoreProjectiles");
                
                (function<TR>(tr: Part)
                    for face = 0, 5 do
                        local light: SurfaceLight = Instance.new("SurfaceLight", tr) :: SurfaceLight
                        light.Range = 10
                        light.Brightness = 1.5
                        light.Color = Color3.fromRGB(255, 255, 255)
                        light.Face = Enum.NormalId:GetEnumItems()[face + 1]
                        TweenService:Create(light, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                            Brightness = 0
                        }):Play()
                    end
                end)(tracer)
                
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
    end)(knifeTool, appearanceInfo, startPos, endPos, attacker)
end
function MvSLibrary:LineOfSightEstablished(targetPart: Instance, isKnife: boolean): boolean
    return (function<TP, IK>(tp: Instance, ik: boolean): boolean
        if not tp or not tp:IsA("BasePart") then return false end
        local targetChar: Instance? = (CRS.getCharacterFromPart(tp) or tp.Parent) :: Instance?
        local myChar: Model? = (self.lp :: Player).Character :: Model?
        if not targetChar or not myChar then return false end
        
        local origin: Vector3? = (if ik then
            (if myChar:FindFirstChild("Head") then (myChar:FindFirstChild("Head") :: BasePart).Position else nil)
        else
            (function<MC>(mc: Model): Vector3?
                local tool: Tool? = mc:FindFirstChildOfClass("Tool") :: Tool?
                local barrel: BasePart? = tool and (tool:FindFirstChild("Barrel") or tool:FindFirstChild("Handle")) :: BasePart?
                return (if barrel then self:GetSafeOrigin(barrel) else nil) :: Vector3?
            end)(myChar)) :: Vector3?
            
        if not origin then return false end
        
        self.CachedRayParams.FilterDescendantsInstances = { myChar }
        local direction: Vector3 = (tp :: BasePart).Position - origin :: Vector3
        local raycastResult: RaycastResult? = Workspace:Raycast(origin, direction, self.CachedRayParams) :: RaycastResult?
        
        if raycastResult then
            if CRS.getCharacterFromPart(raycastResult.Instance) == targetChar then
                return true
            end
            local checkOffsets: {Vector3} = if isKnife then {
                Vector3.new(0.7, 0, 0),
                Vector3.new(-0.7, 0, 0)
            } else {
                Vector3.new(0.2, 0, 0),
                Vector3.new(-0.2, 0, 0)
            }
            for _, offset in checkOffsets do
                local edgePos: Vector3 = (tp :: BasePart).Position + offset :: Vector3
                local edgeResult: RaycastResult? = Workspace:Raycast(origin, edgePos - origin, self.CachedRayParams) :: RaycastResult?
                if edgeResult and CRS.getCharacterFromPart(edgeResult.Instance) == targetChar then
                    return true
                end
            end
            return false
        end
        return true
    end)(targetPart, isKnife) :: boolean
end

function MvSLibrary:GetClosestTarget(isKnife: boolean): (Player?, BasePart?)
    return (function<IK>(ik: boolean): (Player?, BasePart?)
        local myChar: Model? = (self.lp :: Player).Character :: Model?
        if not myChar then return nil, nil end
        local myHead: BasePart? = myChar:FindFirstChild("Head") :: BasePart?
        if not myHead then return nil, nil end
        
        local myPos: Vector3 = myHead.Position :: Vector3
        local candidateTarget: Player? = nil
        local candidatePart: BasePart? = nil
        local minDistanceSq: number = math.huge :: number
        
        for _, player in self.PlayersTable do
            local char: Model? = player and player.Character :: Model?
            if char and CRS.canCharacterTakeDamage(char) then
                local targetPart: BasePart? = (char:FindFirstChild("CharacterCenter") or char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")) :: BasePart?
                if targetPart then
                    local offset: Vector3 = targetPart.Position - myPos :: Vector3
                    local distSq: number = (offset.X * offset.X + offset.Y * offset.Y + offset.Z * offset.Z) :: number
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

function MvSLibrary:GetShootConn()
    local char = (self.lp :: Player).Character
    if not char then return nil end

    -- 1. Check xem Tool đang cầm trên tay (Character) hoặc trong Backpack có phải là Súng hợp lệ không
    local toolOnChar = char:FindFirstChildOfClass("Tool")
    local hasGunOnChar = toolOnChar and VALID_GUNS[toolOnChar.Name]

    local hasGunInBackpack = false
    if not hasGunOnChar then
        local backpack = (self.lp :: Player):FindFirstChildOfClass("Backpack")
        if backpack then
            for _, item in backpack:GetChildren() do
                if item:IsA("Tool") and VALID_GUNS[item.Name] then
                    hasGunInBackpack = true
                    break
                end
            end
        end
    end

    -- Nếu cả tay lẫn balo đều không có súng -> Cancel luôn
    if not hasGunOnChar and not hasGunInBackpack then
        return nil
    end

    -- 2. Đã xác nhận sở hữu Súng -> Trả về connection
    for _, conn in getconnections(UserInputService.TouchTapInWorld) do
        if conn.Function and conn.Enabled and not conn.ForeignState then
            return conn
        end
    end

    return nil
end

function MvSLibrary:GetPosition(targetPart: BasePart?): Vector3
    return (function<TP>(tp: BasePart?): Vector3
        if not tp or not tp:IsA("BasePart") then return Vector3.zero end
        
        local currentPos: Vector3 = tp.Position
        local velocity: Vector3 = tp.AssemblyLinearVelocity
        local flatVel = Vector3.new(velocity.X, 0, velocity.Z)
        local speed = flatVel.Magnitude
        
        -- Nếu đứng yên thì trả về vị trí gốc luôn
        if speed < 0.1 then
            return currentPos
        end
        
        -- Lấy hướng di chuyển và cộng cố định 0.35 offset
        local moveDir = flatVel.Unit
        local predOffset = moveDir * 0.1375
        
        local isAir = true
        local char = (CRS.getCharacterFromPart(tp) or tp.Parent)
        if char and char:IsA("Model") then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.FloorMaterial ~= Enum.Material.Air then
                isAir = false
            end
        end
        
        -- Trả về vị trí cộng offset 0.35 theo hướng di chuyển
        if isAir then
            return currentPos + predOffset
        else
            return Vector3.new(
                currentPos.X + predOffset.X,
                currentPos.Y,
                currentPos.Z + predOffset.Z
            )
        end
    end)(targetPart)
end

function MvSLibrary:Shoot(targetPlayer: Player, targetPart: BasePart)
    if self.IsShoot or not targetPlayer or not targetPart then return end

    local char = (self.lp :: Player).Character
    if not char then return end

    -- 1. Lấy vị trí bắn tính toán
    local targetPos = self:GetPosition(targetPart)

    local tool = char:FindFirstChildOfClass("Tool")
    local barrel = tool and (tool:FindFirstChild("Barrel") or tool:FindFirstChild("Handle"))
    local originPos = barrel and barrel.Position or (char:FindFirstChild("Head") and char.Head.Position)
    
    if originPos then
        self.CachedRayParams.FilterDescendantsInstances = { char }
        local rayResult = Workspace:Raycast(originPos, targetPos - originPos, self.CachedRayParams)
        
        -- Nếu tia ray đập vào vật thể nào đó không thuộc Character của đối thủ -> Dính tường -> Hủy bắn
        if rayResult and not rayResult.Instance:IsDescendantOf(targetPlayer.Character) then
            return 
        end
    end

    -- 3. Lấy connection bắn
    local conn = self:GetShootConn()
    if not conn then return end

    -- 4. Chuyển vị trí 3D sang màn hình 2D
    local screenPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(targetPos)
    if not onScreen then return end

    self.IsShoot = true
    task.delay(2.5, function()
        self.IsShoot = false
    end)

    -- Kích hoạt sự kiện bắn
    conn:Fire(Vector2.new(screenPos.X, screenPos.Y), false)
end

function MvSLibrary:ShootOld(targetPlayer: Player, targetPart: BasePart)
    (function<TP, TPART>(tp: Player, tPart: BasePart)
        if self.IsShoot or not tp or not tp.Character or not tPart then return end
        local char: Model? = (self.lp :: Player).Character :: Model?
        if not char then return end
        
        local tool: Tool? = char:FindFirstChildOfClass("Tool") :: Tool?
        if not tool or not VALID_GUNS[tool.Name] then return end
        
        local barrel: BasePart? = (tool:FindFirstChild("Barrel") or tool:FindFirstChild("Handle")) :: BasePart?
        local damageRemote: RemoteEvent? = tool:FindFirstChild("Damage") :: RemoteEvent?
        local remotes: Instance? = ReplicatedStorage:FindFirstChild("Remotes") :: Instance?
        local replicateBullet: RemoteEvent? = remotes and remotes:FindFirstChild("ReplicateBullet") :: RemoteEvent?
        if not barrel or not damageRemote or not replicateBullet then return end
        
        local safeOrigin: Vector3 = self:GetSafeOrigin(barrel) :: Vector3
        local hitPos: Vector3 = tPart.Position :: Vector3
        
        self.CachedRayParams.FilterDescendantsInstances = { char }
        local raycastResult: RaycastResult? = Workspace:Raycast(safeOrigin, hitPos - safeOrigin, self.CachedRayParams) :: RaycastResult?
        if raycastResult and CRS.getCharacterFromPart(raycastResult.Instance) ~= tp.Character then
            return
        end
        
        self.IsShoot = true
        task.delay(2.5, function()
            self.IsShoot = false
        end)
        
        local hrp: BasePart? = char:FindFirstChild("HumanoidRootPart") :: BasePart?
        if not hrp then return end
        
        local bulletData: BulletPayload = {
            safeOrigin,
            hitPos,
            { PartType = "Character" },
            tool
        } :: BulletPayload
        CRS.createBullet(unpack(bulletData))
        replicateBullet:FireServer(bulletData)
        damageRemote:FireServer(tPart, hitPos, hrp.Position)
    end)(targetPlayer, targetPart)
end

function MvSLibrary:Throw(targetPlayer: Player, targetPart: BasePart)
    (function<TP, TPART>(tp: Player, tPart: BasePart)
        if self.IsThrow or not tp or not tp.Character or not tPart then return end
        local char: Model? = (self.lp :: Player).Character :: Model?
        if not char then return end
        
        local knife: Tool? = char:FindFirstChildOfClass("Tool") :: Tool?
        if not knife or not knife.Name:find("Knife") then return end
        
        local handle: BasePart? = knife:FindFirstChild("Handle") :: BasePart?
        local damageRemote: RemoteEvent? = knife:FindFirstChild("Damage") :: RemoteEvent?
        local remotes: Instance? = ReplicatedStorage:FindFirstChild("Remotes") :: Instance?
        local replicateKnife: RemoteEvent? = remotes and remotes:FindFirstChild("ReplicateKnife") :: RemoteEvent?
        if not handle or not damageRemote or not replicateKnife then return end
        
        self.IsThrow = true
        task.delay(0.85, function()
            self.IsThrow = false
        end)
        
        self:PlayKnifeAnimation(char, self.AutoWait)
        if not tp or not tp.Character or not tPart or not tPart.Parent then return end
        
        local startPos: Vector3 = self:GetSafeOrigin(handle) :: Vector3
        local endPos: Vector3 = tPart.Position :: Vector3
        local appearanceInfo: AppearanceInfo = {
            TextureID = (handle :: any).TextureID,
            Color = handle.Color,
            Material = handle.Material,
            Transparency = handle.Transparency
        } :: AppearanceInfo
        
        local rayParams: RaycastParams = (function<RP>(): RaycastParams
            local rp: RaycastParams = RaycastParams.new() :: RaycastParams
            rp.FilterType = Enum.RaycastFilterType.Exclude
            rp.FilterDescendantsInstances = { char }
            return rp :: RaycastParams
        end)() :: RaycastParams
        
        local dirVector: Vector3 = endPos - startPos :: Vector3
        local distance: number = dirVector.Magnitude :: number
        local rayHit: RaycastResult? = Workspace:Raycast(startPos, dirVector.Unit * distance, rayParams) :: RaycastResult?
        local actualHitPart: Instance = tPart :: Instance
        local isWallBlocked: boolean = false :: boolean
        
        if rayHit then
            local hitChar: Instance? = CRS.getCharacterFromPart(rayHit.Instance) :: Instance?
            if hitChar then
                actualHitPart = rayHit.Instance :: Instance
            else
                isWallBlocked = true
            end
        end
        
        CRS.playKnifeSounds(handle, appearanceInfo, "Throw")
        replicateKnife:FireServer({
            Action = "PlayKnifeSound",
            KnifeAction = "Throw",
            Handle = handle
        } :: KnifePayload)
        replicateKnife:FireServer({
            Action = "CreateKnife",
            Handle = handle,
            AppearanceInfo = appearanceInfo,
            StartPosition = startPos,
            EndPosition = endPos,
            Attacker = self.lp :: Player
        } :: KnifePayload)
        self:CreateKnife(handle, appearanceInfo, startPos, endPos, self.lp :: Player)
        
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
    (function<S>(s: boolean)
        self.AutoWait = s
    end)(state)
end

function MvSLibrary:ToggleEffects(state: boolean)
    (function<S>(s: boolean)
        if self.Folder then
            self.Folder.Parent = (if s then workspace else nil) :: Instance?
        end
    end)(state)
end

function MvSLibrary:GetRealTime(): table
    return (function<W>(time: number): table
        return os.date("*t", time) :: table
    end)(workspace:GetServerTimeNow())
end

function MvSLibrary:UpdateEffects(): boolean
    -- Check xem self.Folder có tồn tại và Parent của nó có thuộc Workspace không
    local isFolderAlive = (self.Folder and self.Folder.Parent == workspace) :: boolean

    if isFolderAlive then
        print("Folder status: TRUE (Vẫn còn trên Workspace!)")
        return true
    else
        print("Folder status: FALSE (Còn cái nịt!)")
        
        -- Nếu bị ngắt Parent (nil) hoặc chưa gán, thử tìm/đợi lại Folder Effects trên Workspace
        if not self.Folder or self.Folder.Parent == nil then
            self.Folder = workspace:WaitForChild("Effects", 0.5) :: Instance?
            
            if self.Folder then
                print("UpdateEffects: Đã gán lại self.Folder thành công!")
                return true
            else
                print("UpdateEffects: Vẫn không tìm thấy Effects trên Workspace.")
                return false
            end
        end
        
        return false
    end
end

return MvSLibrary
