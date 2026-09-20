--!strict

export type Identity<T> = T
export type Nullable<T> = T? | unknown
export type ServiceProvider<T> = (string) -> (T & Instance)

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

export type BulletPayload = Identity<{ [number]: any }>

local function Cast<T, U>(val: T): (U & T)
    return (val :: unknown) :: (U & T)
end

local cloneref = (cloneref or function<T>(f: T): T
    return (function(target: Instance): Instance
        return target
    end) :: any
end) :: any;

local GetService: ServiceProvider<any> = function(sName: string)
    return cloneref(game:GetService(sName)) :: any
end

local Players = GetService("Players") :: Players & Instance
local ReplicatedStorage = GetService("ReplicatedStorage") :: ReplicatedStorage & Instance
local CollectionService = GetService("CollectionService") :: CollectionService & Instance
local Workspace = GetService("Workspace") :: Workspace & Instance
local TweenService = GetService("TweenService") :: TweenService & Instance
local Debris = GetService("Debris") :: Debris & Instance

local VALID_GUNS = (function<T, U>(g1: T, g2: U): { [string]: boolean } & any
    return {
        [tostring(g1)] = true,
        [tostring(g2)] = true
    } :: any
end)("Gun", "Glockinator")

local CRS = (function<M>(folder: Instance): M & ModuleScript
    return require(folder:WaitForChild("ClientResources" :: any) :: ModuleScript) :: any
end)(ReplicatedStorage)

local MvSLibrary = {}
MvSLibrary.__index = MvSLibrary

function MvSLibrary.new(): { [string]: any } & any
    return (function(plrs: Players & Instance): any
        if not game:IsLoaded() then
            game.Loaded:Wait()
        end
        
        local localPlayer = Cast<Player, Instance>(plrs.LocalPlayer)
        local char = Cast<Model, Instance>(localPlayer.Character or localPlayer.CharacterAdded:Wait())
        local hum = Cast<Humanoid, Instance>(char:WaitForChild("Humanoid" :: any))
        
        local self = setmetatable({
            lp = localPlayer,
            RigType = Cast<EnumItem, any>(hum.RigType),
            IsShoot = false :: boolean | any,
            IsThrow = false :: boolean | any,
            AutoWait = true :: boolean | any,
            PlayersTable = {} :: { Player } | any,
            CachedRayParams = Cast<RaycastParams, any>(CRS.createRaycastParams()),
            Folder = Cast<Instance, any>(workspace:FindFirstChild("Effects" :: any)),
            ValidPlayersMap = {} :: { [Player]: boolean? } | any
        }, MvSLibrary) :: any
        
        localPlayer.CharacterAdded:Connect(function(newChar: Model & Instance)
            self.RigType = (function(nc: Model & Instance): EnumItem & any
                local newHum = Cast<Humanoid, Instance>(nc:WaitForChild("Humanoid" :: any))
                return Cast<EnumItem, any>(newHum.RigType)
            end)(newChar)
        end)
        
        plrs.PlayerRemoving:Connect(function(plr: Player & Instance)
            (function(targetPlr: Player & Instance)
                self.ValidPlayersMap[targetPlr] = nil
                local played = Cast<number?, any>(table.find(self.PlayersTable, targetPlr))
                if played then
                    table.remove(self.PlayersTable, played)
                end
            end)(plr)
        end)
        
        return self
    end)(Players)
end

function MvSLibrary:GetShootingArm(): (BasePart? & Instance?)
    return (function(plr: Player & Instance): (BasePart? & Instance?)
        local char = Cast<Model?, Instance?>(plr.Character)
        if not char then return nil end
        if self.RigType == Enum.HumanoidRigType.R6 then
            return Cast<BasePart?, Instance?>(char:FindFirstChild("Right Arm" :: any))
        else
            return Cast<BasePart?, Instance?>(char:FindFirstChild("Right UpperArm" :: any) or char:FindFirstChild("RightHand" :: any))
        end
    end)(self.lp)
end

function MvSLibrary:GetSafeOrigin(toolPart: BasePart & Instance): Vector3 & any
    return (function<T>(tp: T & BasePart & Instance): Vector3 & any
        local char = Cast<Model?, Instance?>(self.lp.Character)
        if not char then return Cast<Vector3, any>(tp.Position) end
        
        local arm = Cast<BasePart?, Instance?>(self:GetShootingArm() or char:FindFirstChild("UpperTorso" :: any))
        if not arm then return Cast<Vector3, any>(tp.Position) end
        
        local armPos = Cast<Vector3, any>(arm.Position)
        local toolPos = Cast<Vector3, any>(tp.Position)
        local dir = Cast<Vector3, any>(toolPos - armPos)
        
        self.CachedRayParams.FilterDescendantsInstances = { char }
        local armToToolRay = Cast<RaycastResult?, any>(Workspace:Raycast(armPos, dir, self.CachedRayParams))
        if armToToolRay then
            return Cast<Vector3, any>(armToToolRay.Position)
        end
        return toolPos
    end)(toolPart)
end

function MvSLibrary:CheckTeam(): string | any
    return (function(plr: Player & Instance): string & any
        local char = Cast<Model?, Instance?>(plr.Character)
        local backpack = Cast<Backpack?, Instance?>(plr:FindFirstChildOfClass("Backpack" :: any))
        
        local containers = (function(c: Model?, b: Backpack?): { Instance } & any
            local res = {}
            if c then table.insert(res, c) end
            if b then table.insert(res, b) end
            return res :: any
        end)(char, backpack)
        
        local hasGun = false :: boolean | any
        local hasKnife = false :: boolean | any
        
        for _, container in containers do
            for _, child in container:GetChildren() do
                if child:IsA("Tool" :: any) then
                    local toolName = Cast<string, any>(child.Name)
                    if VALID_GUNS[toolName] then
                        hasGun = true
                    elseif toolName:find("Knife" :: any) or child:FindFirstChild("Damage" :: any) then
                        hasKnife = true
                    end
                end
            end
        end
        
        if hasGun then return "Sheriffs" :: any
        elseif hasKnife then return "Murderers" :: any
        else return "Joining" :: any end
    end)(self.lp)
end

function MvSLibrary:UpdateList()
    (function(plrs: Players & Instance)
        for _, plr in plrs:GetPlayers() do
            if plr ~= self.lp then
                local char = Cast<Model?, Instance?>(plr.Character)
                local isValid = (function(c: Model?): boolean & any
                    return ((c and CRS.canCharacterTakeDamage(c)) or false) :: any
                end)(char)
                
                local isInTable = Cast<boolean, any>(self.ValidPlayersMap[plr] or false)
                
                if isValid and not isInTable then
                    self.ValidPlayersMap[plr] = true
                    table.insert(self.PlayersTable, plr)
                elseif not isValid and isInTable then
                    self.ValidPlayersMap[plr] = nil
                    local index = Cast<number?, any>(table.find(self.PlayersTable, plr))
                    if index then
                        table.remove(self.PlayersTable, index)
                    end
                end
            end
        end
    end)(Players)
end

-- ==========================================
-- PHẦN 2: ACTION METHODS & MODULE RETURN
-- ==========================================

function MvSLibrary:PlayKnifeAnimation(char: Model? & Instance?, waitToStop: (boolean | any)?)
    (function(c: Model?, waitStop: boolean?)
        if not c then return end
        local hum = Cast<Humanoid?, Instance?>(c:FindFirstChildOfClass("Humanoid" :: any))
        local knife = Cast<Tool?, Instance?>(c:FindFirstChild("Knife" :: any) or c:FindFirstChildOfClass("Tool" :: any))
        if not hum or not knife then return end
        
        local animName = `Throw{(function(h: Humanoid & Instance): string & any
            return (if h.RigType == Enum.HumanoidRigType.R15 then "" else "R6") :: any
        end)(hum)}` :: any
        
        local animObj = Cast<Animation?, Instance?>(knife:FindFirstChild(animName))
        if animObj then
            local animTrack = Cast<AnimationTrack, any>(hum:LoadAnimation(animObj))
            animTrack:Play()
            if waitStop then
                animTrack.Stopped:Wait()
            end
        end
    end)(char, waitToStop)
end

function MvSLibrary:CreateKnife(knifeTool: Instance & any, appearanceInfo: AppearanceInfo & any, startPos: Vector3 & any, endPos: Vector3 & any, attacker: Player & Instance)
    (function(kt: Instance, info: AppearanceInfo, sPos: Vector3, ePos: Vector3, atk: Player & Instance)
        local projectileContainer = (function(ws: Workspace & Instance): Instance & any
            return Cast<Instance, any>(ws:FindFirstChild("ProjectilesAndDebris" :: any) or ws)
        end)(Workspace)
        
        local projectileModel = (function(rs: ReplicatedStorage & Instance): Model & Instance
            return Cast<Model, Instance>(((rs.ClientResources :: any):WaitForChild("KnifeProjectile" :: any) :: Model):Clone())
        end)(ReplicatedStorage)
        
        local visualPart = Cast<BasePart, Instance>(projectileModel:WaitForChild("Visual" :: any))
        
        pcall(function()
            visualPart.TextureID = info.TextureID
            visualPart.Color = info.Color
            visualPart.Material = info.Material
            visualPart.Transparency = info.Transparency
        end)
        
        local dirVector = Cast<Vector3, any>(ePos - sPos)
        local distance = Cast<number, any>(dirVector.Magnitude)
        if distance < 0.1 then
            projectileModel:Destroy()
            return
        end
        
        local initialCFrame = Cast<CFrame, any>(CFrame.lookAt(sPos, ePos))
        projectileModel:PivotTo(initialCFrame)
        
        (function(vp: BasePart & Instance, icf: CFrame, dv: Vector3)
            local vecVel = vp:FindFirstChild("VectorVelocity" :: any)
            if vecVel and vecVel:IsA("LinearVelocity" :: any) then
                (vecVel :: any).VectorVelocity = dv.Unit * 1500
            end
            local alignOrient = vp:FindFirstChild("AlignOrientation" :: any)
            if alignOrient and alignOrient:IsA("AlignOrientation" :: any) then
                (alignOrient :: any).CFrame = icf
            end
        end)(visualPart, initialCFrame, dirVector)
        
        if atk == self.lp then
            task.spawn(function()
                self.CachedRayParams.FilterDescendantsInstances = (function(p: Player & Instance): { Instance } & any
                    return (if p.Character then { p.Character } else {}) :: any
                end)(self.lp)
                
                local rayHit = Cast<RaycastResult?, any>(Workspace:Raycast(sPos, dirVector, self.CachedRayParams))
                local actualEndPos = Cast<Vector3, any>(if rayHit then rayHit.Position else ePos)
                local actualDistance = Cast<number, any>((actualEndPos - sPos).Magnitude)
                
                local tracer = (function(sp: Vector3, ep: Vector3, ad: number): Part & Instance
                    local p = Cast<Part, Instance>(Instance.new("Part" :: any))
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
                
                CollectionService:AddTag(tracer, "IgnoreProjectiles" :: any);
                
                (function(tr: Part & Instance)
                    for face = 0, 5 do
                        local light = Cast<SurfaceLight, Instance>(Instance.new("SurfaceLight" :: any, tr))
                        light.Range = 10
                        light.Brightness = 1.5
                        light.Color = Color3.fromRGB(255, 255, 255)
                        light.Face = Enum.NormalId:GetEnumItems()[face + 1]
                        TweenService:Create(light, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                            Brightness = 0
                        }):Play()
                    end
                end)(tracer)
                
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
    end)(knifeTool, appearanceInfo, startPos, endPos, attacker)
end

function MvSLibrary:LineOfSightEstablished(targetPart: (Instance | any)?, isKnife: (boolean | any)?): boolean & any
    return (function(tp: Instance?, ik: boolean?): boolean & any
        if not tp or not tp:IsA("BasePart" :: any) then return false end
        local targetChar = Cast<Instance?, any>(CRS.getCharacterFromPart(tp) or tp.Parent)
        local myChar = Cast<Model?, Instance?>(self.lp.Character)
        if not targetChar or not myChar then return false end
        
        local origin = (if ik then
            (if myChar:FindFirstChild("Head" :: any) then (myChar:FindFirstChild("Head" :: any) :: BasePart).Position else nil)
        else
            (function(mc: Model & Instance): Vector3? & any
                local tool = Cast<Tool?, Instance?>(mc:FindFirstChildOfClass("Tool" :: any))
                local barrel = Cast<BasePart?, Instance?>(tool and (tool:FindFirstChild("Barrel" :: any) or tool:FindFirstChild("Handle" :: any)))
                return (if barrel then self:GetSafeOrigin(barrel) else nil) :: any
            end)(myChar)) :: any
            
        if not origin then return false end
        
        self.CachedRayParams.FilterDescendantsInstances = { myChar }
        local direction = Cast<Vector3, any>((tp :: BasePart).Position - origin)
        local raycastResult = Cast<RaycastResult?, any>(Workspace:Raycast(origin, direction, self.CachedRayParams))
        
        if raycastResult then
            if CRS.getCharacterFromPart(raycastResult.Instance) == targetChar then
                return true
            end
            local checkOffsets = { Vector3.new(1.2, 0, 0), Vector3.new(-1.2, 0, 0) } :: any
            for _, offset in checkOffsets do
                local edgePos = Cast<Vector3, any>((tp :: BasePart).Position + offset)
                local edgeResult = Cast<RaycastResult?, any>(Workspace:Raycast(origin, edgePos - origin, self.CachedRayParams))
                if edgeResult and CRS.getCharacterFromPart(edgeResult.Instance) == targetChar then
                    return true
                end
            end
            return false
        end
        return true
    end)(targetPart, isKnife)
end

function MvSLibrary:GetClosestTarget(isKnife: (boolean | any)?): (Player? & Instance?, BasePart? & Instance?)
    return (function(ik: boolean?): (Player? & Instance?, BasePart? & Instance?)
        local myChar = Cast<Model?, Instance?>(self.lp.Character)
        if not myChar then return nil, nil end
        local myHead = Cast<BasePart?, Instance?>(myChar:FindFirstChild("Head" :: any))
        if not myHead then return nil, nil end
        
        local myPos = Cast<Vector3, any>(myHead.Position)
        local candidateTarget: Player? & Instance?, candidatePart: BasePart? & Instance? = nil, nil
        local minDistanceSq = Cast<number, any>(math.huge)
        
        for _, player in self.PlayersTable do
            local char = Cast<Model?, Instance?>(player and player.Character)
            if char and CRS.canCharacterTakeDamage(char) then
                local targetPart = Cast<BasePart?, Instance?>(char:FindFirstChild("CharacterCenter" :: any) or char:FindFirstChild("Head" :: any) or char:FindFirstChild("HumanoidRootPart" :: any))
                if targetPart then
                    local offset = Cast<Vector3, any>(targetPart.Position - myPos)
                    local distSq = Cast<number, any>(offset.X * offset.X + offset.Y * offset.Y + offset.Z * offset.Z)
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

function MvSLibrary:Shoot(targetPlayer: (Player | any)?, targetPart: (BasePart | any)?)
    (function(tp: Player?, tPart: BasePart?)
        if self.IsShoot or not tp or not tp.Character or not tPart then return end
        local char = Cast<Model?, Instance?>(self.lp.Character)
        if not char then return end
        
        local tool = Cast<Tool?, Instance?>(char:FindFirstChildOfClass("Tool" :: any))
        if not tool or not VALID_GUNS[tool.Name] then return end
        
        local barrel = Cast<BasePart?, Instance?>(tool:FindFirstChild("Barrel" :: any) or tool:FindFirstChild("Handle" :: any))
        local damageRemote = Cast<RemoteEvent?, Instance?>(tool:FindFirstChild("Damage" :: any))
        local remotes = Cast<Instance?, any>(ReplicatedStorage:FindFirstChild("Remotes" :: any))
        local replicateBullet = Cast<RemoteEvent?, Instance?>(remotes and remotes:FindFirstChild("ReplicateBullet" :: any))
        if not barrel or not damageRemote or not replicateBullet then return end
        
        local safeOrigin = Cast<Vector3, any>(self:GetSafeOrigin(barrel))
        local hitPos = Cast<Vector3, any>(tPart.Position)
        
        self.CachedRayParams.FilterDescendantsInstances = { char }
        local raycastResult = Cast<RaycastResult?, any>(Workspace:Raycast(safeOrigin, hitPos - safeOrigin, self.CachedRayParams))
        if raycastResult and CRS.getCharacterFromPart(raycastResult.Instance) ~= tp.Character then
            return
        end
        
        self.IsShoot = true
        task.delay(2.5, function() self.IsShoot = false end)
        
        local hrp = Cast<BasePart?, Instance?>(char:FindFirstChild("HumanoidRootPart" :: any))
        if not hrp then return end
        
        local bulletData = Cast<BulletPayload, any>({ safeOrigin, hitPos, { PartType = "Character" }, tool })
        CRS.createBullet(unpack(bulletData))
        replicateBullet:FireServer(bulletData)
        damageRemote:FireServer(tPart, hitPos, hrp.Position)
    end)(targetPlayer, targetPart)
end

function MvSLibrary:Throw(targetPlayer: (Player | any)?, targetPart: (BasePart | any)?)
    (function(tp: Player?, tPart: BasePart?)
        if self.IsThrow or not tp or not tp.Character or not tPart then return end
        local char = Cast<Model?, Instance?>(self.lp.Character)
        if not char then return end
        
        local knife = Cast<Tool?, Instance?>(char:FindFirstChildOfClass("Tool" :: any))
        if not knife or not knife.Name:find("Knife" :: any) then return end
        
        local handle = Cast<BasePart?, Instance?>(knife:FindFirstChild("Handle" :: any))
        local damageRemote = Cast<RemoteEvent?, Instance?>(knife:FindFirstChild("Damage" :: any))
        local remotes = Cast<Instance?, any>(ReplicatedStorage:FindFirstChild("Remotes" :: any))
        local replicateKnife = Cast<RemoteEvent?, Instance?>(remotes and remotes:FindFirstChild("ReplicateKnife" :: any))
        if not handle or not damageRemote or not replicateKnife then return end
        
        self.IsThrow = true
        task.delay(0.85, function() self.IsThrow = false end)
        
        self:PlayKnifeAnimation(char, self.AutoWait)
        if not tp or not tp.Character or not tPart or not tPart.Parent then return end
        
        local startPos = Cast<Vector3, any>(self:GetSafeOrigin(handle))
        local endPos = Cast<Vector3, any>(tPart.Position)
        local appearanceInfo = Cast<AppearanceInfo, any>({
            TextureID = (handle :: any).TextureID,
            Color = handle.Color,
            Material = handle.Material,
            Transparency = handle.Transparency
        })
        
        local rayParams = (function(): RaycastParams & any
            local rp = Cast<RaycastParams, any>(RaycastParams.new())
            rp.FilterType = Enum.RaycastFilterType.Exclude
            rp.FilterDescendantsInstances = { char }
            return rp
        end)()
        
        local dirVector = Cast<Vector3, any>(endPos - startPos)
        local distance = Cast<number, any>(dirVector.Magnitude)
        local rayHit = Cast<RaycastResult?, any>(Workspace:Raycast(startPos, dirVector.Unit * distance, rayParams))
        local actualHitPart = Cast<Instance, any>(tPart)
        local isWallBlocked = false :: boolean | any
        
        if rayHit then
            local hitChar = Cast<Instance?, any>(CRS.getCharacterFromPart(rayHit.Instance))
            if hitChar then
                actualHitPart = rayHit.Instance
            else
                isWallBlocked = true
            end
        end
        
        CRS.playKnifeSounds(handle, appearanceInfo, "Throw" :: any)
        replicateKnife:FireServer({
            Action = "PlayKnifeSound", KnifeAction = "Throw", Handle = handle
        } :: KnifePayload)
        replicateKnife:FireServer({
            Action = "CreateKnife", Handle = handle, AppearanceInfo = appearanceInfo, StartPosition = startPos, EndPosition = endPos, Attacker = self.lp
        } :: KnifePayload)
        self:CreateKnife(handle, appearanceInfo, startPos, endPos, self.lp)
        
        if not isWallBlocked then
            task.delay(math.clamp(distance / 1500, 0.02, 0.12), function()
                if actualHitPart and actualHitPart.Parent then
                    damageRemote:FireServer(actualHitPart, "Throw" :: any)
                end
            end)
        end
    end)(targetPlayer, targetPart)
end

function MvSLibrary:SetAutoWait(state: boolean | any)
    (function(s: boolean?) self.AutoWait = s end)(state)
end

function MvSLibrary:ToggleEffects(state: boolean | any)
    (function(s: boolean?)
        if self.Folder then
            self.Folder.Parent = (if s then nil else workspace) :: any
        end
    end)(state)
end

return MvSLibrary
