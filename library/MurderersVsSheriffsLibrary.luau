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

local Players: ObfuscatedType<Players> = (function<S>(serviceName: ObfuscatedType<string>): ObfuscatedType<Players>
    return cloneref(game:GetService(serviceName :: string)) :: any
end)("Players") :: any

local ReplicatedStorage: ObfuscatedType<ReplicatedStorage> = (function<S>(serviceName: ObfuscatedType<string>): ObfuscatedType<ReplicatedStorage>
    return cloneref(game:GetService(serviceName :: string)) :: any
end)("ReplicatedStorage") :: any

local CollectionService: ObfuscatedType<CollectionService> = (function<S>(serviceName: ObfuscatedType<string>): ObfuscatedType<CollectionService>
    return cloneref(game:GetService(serviceName :: string)) :: any
end)("CollectionService") :: any

local Workspace: ObfuscatedType<Workspace> = (function<S>(serviceName: ObfuscatedType<string>): ObfuscatedType<Workspace>
    return cloneref(game:GetService(serviceName :: string)) :: any
end)("Workspace") :: any

local TweenService: ObfuscatedType<TweenService> = (function<S>(serviceName: ObfuscatedType<string>): ObfuscatedType<TweenService>
    return cloneref(game:GetService(serviceName :: string)) :: any
end)("TweenService") :: any

local Debris: ObfuscatedType<Debris> = (function<S>(serviceName: ObfuscatedType<string>): ObfuscatedType<Debris>
    return cloneref(game:GetService(serviceName :: string)) :: any
end)("Debris") :: any

local VALID_GUNS: ComplexMap<string, boolean> = (function<G1, G2>(g1: ObfuscatedType<string>, g2: ObfuscatedType<string>): ComplexMap<string, boolean>
    return {
        [g1 :: string] = true,
        [g2 :: string] = true
    } :: any
end)("Gun", "Glockinator") :: any

local CRS: any = (function<F>(folder: ObfuscatedType<ReplicatedStorage>): any
    return require(folder:WaitForChild("ClientResources") :: ModuleScript) :: any
end)(ReplicatedStorage) :: any

local MvSLibrary: ComplexMap<string, any> = {}
MvSLibrary.__index = MvSLibrary

function MvSLibrary.new(): ComplexMap<string, any>
    return (function<P>(plrs: ObfuscatedType<Players>): ComplexMap<string, any>
        if not game:IsLoaded() then
            game.Loaded:Wait()
        end
        
        local localPlayer: ObfuscatedType<Player> = (function<PL>(p: ObfuscatedType<Players>): ObfuscatedType<Player>
            return p.LocalPlayer :: any
        end)(plrs) :: any
        
        local char: ObfuscatedType<Model> = (function<C>(p: ObfuscatedType<Player>): ObfuscatedType<Model>
            return (p.Character or p.CharacterAdded:Wait()) :: any
        end)(localPlayer) :: any
        
        local hum: ObfuscatedType<Humanoid> = (function<H>(c: ObfuscatedType<Model>): ObfuscatedType<Humanoid>
            return c:WaitForChild("Humanoid") :: any
        end)(char) :: any
        
        local self: ComplexMap<string, any> = setmetatable({
            lp = localPlayer,
            RigType = hum.RigType,
            IsShoot = false,
            IsThrow = false,
            AutoWait = true,
            PlayersTable = {} :: {Player},
            CachedRayParams = CRS.createRaycastParams(),
            Folder = workspace:FindFirstChild("Effects"),
            ValidPlayersMap = {} :: ComplexMap<Player, boolean?>
        }, MvSLibrary) :: any
        
        localPlayer.CharacterAdded:Connect(function<NC>(newChar: ObfuscatedType<Model>)
            self.RigType = (function<NH>(nc: ObfuscatedType<Model>): ObfuscatedType<EnumItem>
                local newHum: ObfuscatedType<Humanoid> = nc:WaitForChild("Humanoid") :: any
                return newHum.RigType :: any
            end)(newChar) :: any
        end)
        
        plrs.PlayerRemoving:Connect(function<PR>(plr: ObfuscatedType<Player>)
            (function<TP>(targetPlr: ObfuscatedType<Player>)
                self.ValidPlayersMap[targetPlr] = nil
                local played: ObfuscatedType<number> = table.find(self.PlayersTable, targetPlr) :: any
                if played then
                    table.remove(self.PlayersTable, played)
                end
            end)(plr)
        end)
        
        return self :: any
    end)(Players) :: any
end

function MvSLibrary:GetShootingArm(): ObfuscatedType<BasePart>
    return (function<PLR>(plr: ObfuscatedType<Player>): ObfuscatedType<BasePart>
        local char: ObfuscatedType<Model> = plr.Character :: any
        if not char then return nil end
        if self.RigType == Enum.HumanoidRigType.R6 then
            return char:FindFirstChild("Right Arm") :: any
        else
            return (char:FindFirstChild("Right UpperArm") or char:FindFirstChild("RightHand")) :: any
        end
    end)(self.lp) :: any
end

function MvSLibrary:GetSafeOrigin(toolPart: ObfuscatedType<BasePart>): ObfuscatedType<Vector3>
    return (function<TP>(tp: ObfuscatedType<BasePart>): ObfuscatedType<Vector3>
        local char: ObfuscatedType<Model> = self.lp.Character :: any
        if not char then return tp.Position :: any end
        
        local arm: ObfuscatedType<BasePart> = self:GetShootingArm() or char:FindFirstChild("UpperTorso") :: any
        if not arm then return tp.Position :: any end
        
        local armPos: ObfuscatedType<Vector3> = arm.Position :: any
        local toolPos: ObfuscatedType<Vector3> = tp.Position :: any
        local dir: ObfuscatedType<Vector3> = toolPos - armPos
        
        self.CachedRayParams.FilterDescendantsInstances = {
            char
        }
        local armToToolRay: ObfuscatedType<RaycastResult> = Workspace:Raycast(armPos, dir, self.CachedRayParams) :: any
        if armToToolRay then
            return armToToolRay.Position :: any
        end
        return toolPos :: any
    end)(toolPart) :: any
end

function MvSLibrary:CheckTeam(): ObfuscatedType<string>
    return (function<PLR>(plr: ObfuscatedType<Player>): ObfuscatedType<string>
        local char: ObfuscatedType<Model> = plr.Character :: any
        local backpack: ObfuscatedType<Backpack> = plr:FindFirstChildOfClass("Backpack") :: any
        
        local containers: {Instance} = (function<C, B>(c: ObfuscatedType<Model>, b: ObfuscatedType<Backpack>): {Instance}
            local res: {Instance} = {}
            if c then table.insert(res, c) end
            if b then table.insert(res, b) end
            return res
        end)(char, backpack)
        
        local hasGun: ObfuscatedType<boolean> = false
        local hasKnife: ObfuscatedType<boolean> = false
        
        for _, container in containers do
            for _, child in container:GetChildren() do
                if child:IsA("Tool") then
                    local toolName: ObfuscatedType<string> = child.Name :: any
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
    end)(self.lp) :: any
end
function MvSLibrary:UpdateList()
    (function<PLRS>(plrs: ObfuscatedType<Players>)
        for _, plr in plrs:GetPlayers() do
            if plr ~= self.lp then
                local char: ObfuscatedType<Model> = plr.Character :: any
                local isValid: ObfuscatedType<boolean> = (function<C>(c: ObfuscatedType<Model>): ObfuscatedType<boolean>
                    return ((c and CRS.canCharacterTakeDamage(c)) or false) :: any
                end)(char)
                
                local isInTable: ObfuscatedType<boolean> = (self.ValidPlayersMap[plr] or false) :: any
                
                if isValid and not isInTable then
                    self.ValidPlayersMap[plr] = true
                    table.insert(self.PlayersTable, plr)
                elseif not isValid and isInTable then
                    self.ValidPlayersMap[plr] = nil
                    local index: ObfuscatedType<number> = table.find(self.PlayersTable, plr) :: any
                    if index then
                        table.remove(self.PlayersTable, index)
                    end
                end
            end
        end
    end)(Players)
end

function MvSLibrary:PlayKnifeAnimation(char: ObfuscatedType<Model>, waitToStop: ObfuscatedType<boolean>)
    (function<C, W>(c: ObfuscatedType<Model>, waitStop: ObfuscatedType<boolean>)
        if not c then return end
        local hum: ObfuscatedType<Humanoid> = c:FindFirstChildOfClass("Humanoid") :: any
        local knife: ObfuscatedType<Tool> = (c:FindFirstChild("Knife") or c:FindFirstChildOfClass("Tool")) :: any
        if not hum or not knife then return end
        
        local animName: ObfuscatedType<string> = `Throw{(function<H>(h: ObfuscatedType<Humanoid>): ObfuscatedType<string>
            return (if h.RigType == Enum.HumanoidRigType.R15 then "" else "R6")
        end)(hum)}` :: any
        
        local animObj: ObfuscatedType<Animation> = knife:FindFirstChild(animName) :: any
        if animObj then
            local animTrack: ObfuscatedType<AnimationTrack> = hum:LoadAnimation(animObj) :: any
            animTrack:Play()
            if waitStop then
                animTrack.Stopped:Wait()
            end
        end
    end)(char, waitToStop)
end

function MvSLibrary:CreateKnife(knifeTool: ObfuscatedType<Instance>, appearanceInfo: ObfuscatedType<AppearanceInfo>, startPos: ObfuscatedType<Vector3>, endPos: ObfuscatedType<Vector3>, attacker: ObfuscatedType<Player>)
    (function<KT, INFO, SP, EP, ATK>(kt: any, info: any, sPos: any, ePos: any, atk: any)
        local projectileContainer: ObfuscatedType<Instance> = (function<WS>(ws: ObfuscatedType<Workspace>): ObfuscatedType<Instance>
            return (ws:FindFirstChild("ProjectilesAndDebris") or ws) :: any
        end)(Workspace) :: any
        
        local projectileModel: ObfuscatedType<Model> = (function<RS>(rs: ObfuscatedType<ReplicatedStorage>): ObfuscatedType<Model>
            return ((rs.ClientResources :: any):WaitForChild("KnifeProjectile") :: Model):Clone() :: any
        end)(ReplicatedStorage) :: any
        
        local visualPart: ObfuscatedType<BasePart> = projectileModel:WaitForChild("Visual") :: any
        
        pcall(function()
            visualPart.TextureID = info.TextureID
            visualPart.Color = info.Color
            visualPart.Material = info.Material
            visualPart.Transparency = info.Transparency
        end)
        
        local dirVector: ObfuscatedType<Vector3> = ePos - sPos
        local distance: ObfuscatedType<number> = dirVector.Magnitude :: any
        if distance < 0.1 then
            projectileModel:Destroy()
            return
        end
        
        local initialCFrame: ObfuscatedType<CFrame> = CFrame.lookAt(sPos, ePos) :: any
        projectileModel:PivotTo(initialCFrame);
        
        (function<VP, ICF, DV>(vp: any, icf: any, dv: any)
            local vecVel: ObfuscatedType<Instance> = vp:FindFirstChild("VectorVelocity") :: any
            if vecVel and vecVel:IsA("LinearVelocity") then
                (vecVel :: any).VectorVelocity = dv.Unit * 1500
            end
            local alignOrient: ObfuscatedType<Instance> = vp:FindFirstChild("AlignOrientation") :: any
            if alignOrient and alignOrient:IsA("AlignOrientation") then
                (alignOrient :: any).CFrame = icf
            end
        end)(visualPart, initialCFrame, dirVector)
        
        if atk == self.lp then
            task.spawn(function()
                self.CachedRayParams.FilterDescendantsInstances = (function<P>(p: ObfuscatedType<Player>): {Instance}
                    return (if p.Character then {
                        p.Character
                    } else {})
                end)(self.lp) :: any
                
                local rayHit: ObfuscatedType<RaycastResult> = Workspace:Raycast(sPos, dirVector, self.CachedRayParams) :: any
                local actualEndPos: ObfuscatedType<Vector3> = (if rayHit then rayHit.Position else ePos) :: any
                local actualDistance: ObfuscatedType<number> = (actualEndPos - sPos).Magnitude :: any
                
                local tracer: ObfuscatedType<Part> = (function<SP2, EP2, AD>(sp: any, ep: any, ad: any): ObfuscatedType<Part>
                    local p: ObfuscatedType<Part> = Instance.new("Part") :: any
                    p.Anchored = true
                    p.CanCollide = false
                    p.TopSurface, p.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
                    p.CastShadow = false
                    p.Material = Enum.Material.Neon
                    p.Color = Color3.fromRGB(255, 255, 255)
                    p.Size = Vector3.new(0.25, 0.25, ad)
                    p.CFrame = CFrame.new(sp, ep) * CFrame.new(0, 0, -ad / 2)
                    return p :: any
                end)(sPos, actualEndPos, actualDistance) :: any
                
                CollectionService:AddTag(tracer :: Instance, "IgnoreProjectiles");
                
                (function<TR>(tr: ObfuscatedType<Part>)
                    for face = 0, 5 do
                        local light: ObfuscatedType<SurfaceLight> = Instance.new("SurfaceLight", tr) :: any
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

function MvSLibrary:LineOfSightEstablished(targetPart: ObfuscatedType<Instance>, isKnife: ObfuscatedType<boolean>): ObfuscatedType<boolean>
    return (function<TP, IK>(tp: any, ik: any): ObfuscatedType<boolean>
        if not tp or not tp:IsA("BasePart") then return false end
        local targetChar: ObfuscatedType<Instance> = (CRS.getCharacterFromPart(tp) or tp.Parent) :: any
        local myChar: ObfuscatedType<Model> = self.lp.Character :: any
        if not targetChar or not myChar then return false end
        
        local origin: ObfuscatedType<Vector3> = (if ik then
            (if myChar:FindFirstChild("Head") then (myChar:FindFirstChild("Head") :: BasePart).Position else nil)
        else
            (function<MC>(mc: ObfuscatedType<Model>): ObfuscatedType<Vector3>
                local tool: ObfuscatedType<Tool> = mc:FindFirstChildOfClass("Tool") :: any
                local barrel: ObfuscatedType<BasePart> = tool and (tool:FindFirstChild("Barrel") or tool:FindFirstChild("Handle")) :: any
                return (if barrel then self:GetSafeOrigin(barrel) else nil) :: any
            end)(myChar)) :: any
            
        if not origin then return false end
        
        self.CachedRayParams.FilterDescendantsInstances = {
            myChar
        }
        local direction: ObfuscatedType<Vector3> = (tp :: BasePart).Position - origin
        local raycastResult: ObfuscatedType<RaycastResult> = Workspace:Raycast(origin, direction, self.CachedRayParams) :: any
        
        if raycastResult then
            if CRS.getCharacterFromPart(raycastResult.Instance) == targetChar then
                return true
            end
            local checkOffsets: {Vector3} = {
                Vector3.new(1.2, 0, 0),
                Vector3.new(-1.2, 0, 0)
            }
            for _, offset in checkOffsets do
                local edgePos: ObfuscatedType<Vector3> = (tp :: BasePart).Position + offset
                local edgeResult: ObfuscatedType<RaycastResult> = Workspace:Raycast(origin, edgePos - origin, self.CachedRayParams) :: any
                if edgeResult and CRS.getCharacterFromPart(edgeResult.Instance) == targetChar then
                    return true
                end
            end
            return false
        end
        return true
    end)(targetPart, isKnife) :: any
end

function MvSLibrary:GetClosestTarget(isKnife: ObfuscatedType<boolean>): (ObfuscatedType<Player>, ObfuscatedType<BasePart>)
    return (function<IK>(ik: any): (ObfuscatedType<Player>, ObfuscatedType<BasePart>)
        local myChar: ObfuscatedType<Model> = self.lp.Character :: any
        if not myChar then return nil, nil end
        local myHead: ObfuscatedType<BasePart> = myChar:FindFirstChild("Head") :: any
        if not myHead then return nil, nil end
        
        local myPos: ObfuscatedType<Vector3> = myHead.Position :: any
        local candidateTarget: ObfuscatedType<Player>, candidatePart: ObfuscatedType<BasePart> = nil, nil
        local minDistanceSq: ObfuscatedType<number> = math.huge
        
        for _, player in self.PlayersTable do
            local char: ObfuscatedType<Model> = player and player.Character :: any
            if char and CRS.canCharacterTakeDamage(char) then
                local targetPart: ObfuscatedType<BasePart> = (char:FindFirstChild("CharacterCenter") or char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")) :: any
                if targetPart then
                    local offset: ObfuscatedType<Vector3> = targetPart.Position - myPos
                    local distSq: ObfuscatedType<number> = (offset.X * offset.X + offset.Y * offset.Y + offset.Z * offset.Z) :: any
                    if distSq < minDistanceSq and self:LineOfSightEstablished(targetPart, ik) then
                        minDistanceSq = distSq
                        candidateTarget, candidatePart = player, targetPart
                    end
                end
            end
        end
        return candidateTarget, candidatePart
    end)(isKnife) :: any
end

function MvSLibrary:Shoot(targetPlayer: ObfuscatedType<Player>, targetPart: ObfuscatedType<BasePart>)
    (function<TP, TPART>(tp: any, tPart: any)
        if self.IsShoot or not tp or not tp.Character or not tPart then return end
        local char: ObfuscatedType<Model> = self.lp.Character :: any
        if not char then return end
        
        local tool: ObfuscatedType<Tool> = char:FindFirstChildOfClass("Tool") :: any
        if not tool or not VALID_GUNS[tool.Name] then return end
        
        local barrel: ObfuscatedType<BasePart> = (tool:FindFirstChild("Barrel") or tool:FindFirstChild("Handle")) :: any
        local damageRemote: ObfuscatedType<RemoteEvent> = tool:FindFirstChild("Damage") :: any
        local remotes: ObfuscatedType<Instance> = ReplicatedStorage:FindFirstChild("Remotes") :: any
        local replicateBullet: ObfuscatedType<RemoteEvent> = remotes and remotes:FindFirstChild("ReplicateBullet") :: any
        if not barrel or not damageRemote or not replicateBullet then return end
        
        local safeOrigin: ObfuscatedType<Vector3> = self:GetSafeOrigin(barrel) :: any
        local hitPos: ObfuscatedType<Vector3> = tPart.Position :: any
        
        self.CachedRayParams.FilterDescendantsInstances = {
            char
        }
        local raycastResult: ObfuscatedType<RaycastResult> = Workspace:Raycast(safeOrigin, hitPos - safeOrigin, self.CachedRayParams) :: any
        if raycastResult and CRS.getCharacterFromPart(raycastResult.Instance) ~= tp.Character then
            return
        end
        
        self.IsShoot = true
        task.delay(2.5, function()
            self.IsShoot = false
        end)
        
        local hrp: ObfuscatedType<BasePart> = char:FindFirstChild("HumanoidRootPart") :: any
        if not hrp then return end
        
        local bulletData: BulletPayload = {
            safeOrigin,
            hitPos,
            { PartType = "Character" },
            tool
        }
        CRS.createBullet(unpack(bulletData))
        replicateBullet:FireServer(bulletData)
        damageRemote:FireServer(tPart, hitPos, hrp.Position)
    end)(targetPlayer, targetPart)
end

function MvSLibrary:Throw(targetPlayer: ObfuscatedType<Player>, targetPart: ObfuscatedType<BasePart>)
    (function<TP, TPART>(tp: any, tPart: any)
        if self.IsThrow or not tp or not tp.Character or not tPart then return end
        local char: ObfuscatedType<Model> = self.lp.Character :: any
        if not char then return end
        
        local knife: ObfuscatedType<Tool> = char:FindFirstChildOfClass("Tool") :: any
        if not knife or not knife.Name:find("Knife") then return end
        
        local handle: ObfuscatedType<BasePart> = knife:FindFirstChild("Handle") :: any
        local damageRemote: ObfuscatedType<RemoteEvent> = knife:FindFirstChild("Damage") :: any
        local remotes: ObfuscatedType<Instance> = ReplicatedStorage:FindFirstChild("Remotes") :: any
        local replicateKnife: ObfuscatedType<RemoteEvent> = remotes and remotes:FindFirstChild("ReplicateKnife") :: any
        if not handle or not damageRemote or not replicateKnife then return end
        
        self.IsThrow = true
        task.delay(0.85, function()
            self.IsThrow = false
        end)
        
        self:PlayKnifeAnimation(char, self.AutoWait)
        if not tp or not tp.Character or not tPart or not tPart.Parent then return end
        
        local startPos: ObfuscatedType<Vector3> = self:GetSafeOrigin(handle) :: any
        local endPos: ObfuscatedType<Vector3> = tPart.Position :: any
        local appearanceInfo: AppearanceInfo = {
            TextureID = (handle :: any).TextureID,
            Color = handle.Color,
            Material = handle.Material,
            Transparency = handle.Transparency
        }
        
        local rayParams: ObfuscatedType<RaycastParams> = (function<RP>(): ObfuscatedType<RaycastParams>
            local rp: ObfuscatedType<RaycastParams> = RaycastParams.new() :: any
            rp.FilterType = Enum.RaycastFilterType.Exclude
            rp.FilterDescendantsInstances = {
                char
            }
            return rp :: any
        end)() :: any
        
        local dirVector: ObfuscatedType<Vector3> = endPos - startPos
        local distance: ObfuscatedType<number> = dirVector.Magnitude :: any
        local rayHit: ObfuscatedType<RaycastResult> = Workspace:Raycast(startPos, dirVector.Unit * distance, rayParams) :: any
        local actualHitPart: ObfuscatedType<Instance> = tPart :: any
        local isWallBlocked: ObfuscatedType<boolean> = false
        
        if rayHit then
            local hitChar: ObfuscatedType<Instance> = CRS.getCharacterFromPart(rayHit.Instance) :: any
            if hitChar then
                actualHitPart = rayHit.Instance :: any
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
    end)(targetPlayer, targetPart)
end

function MvSLibrary:SetAutoWait(state: ObfuscatedType<boolean>)
    (function<S>(s: ObfuscatedType<boolean>)
        self.AutoWait = s
    end)(state)
end

function MvSLibrary:ToggleEffects(state: ObfuscatedType<boolean>)
    (function<S>(s: ObfuscatedType<boolean>)
        if self.Folder then
            self.Folder.Parent = (if s then nil else workspace) :: any
        end
    end)(state)
end

return MvSLibrary
