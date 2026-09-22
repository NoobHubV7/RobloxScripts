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

local Players: Players = (function<S>(sn: ObfuscatedType<string>): Players
    local g: any = game :: any
    local gs: any = g[string.char(71, 101, 116, 83, 101, 114, 118, 105, 99, 101)] :: any
    return cloneref(gs(g, sn :: string)) :: any
end)(string.char(80, 108, 97, 121, 101, 114, 115)) :: Players

local ReplicatedStorage: ReplicatedStorage = (function<S>(sn: ObfuscatedType<string>): ReplicatedStorage
    local g: any = game :: any
    local gs: any = g[string.char(71, 101, 116, 83, 101, 114, 118, 105, 99, 101)] :: any
    return cloneref(gs(g, sn :: string)) :: any
end)(string.char(82, 101, 112, 108, 105, 99, 97, 116, 101, 100, 83, 116, 111, 114, 97, 103, 101)) :: ReplicatedStorage

local CollectionService: CollectionService = (function<S>(sn: ObfuscatedType<string>): CollectionService
    local g: any = game :: any
    local gs: any = g[string.char(71, 101, 116, 83, 101, 114, 118, 105, 99, 101)] :: any
    return cloneref(gs(g, sn :: string)) :: any
end)(string.char(67, 111, 108, 108, 101, 99, 116, 105, 111, 110, 83, 101, 114, 118, 105, 99, 101)) :: CollectionService

local Workspace: Workspace = (function<S>(sn: ObfuscatedType<string>): Workspace
    local g: any = game :: any
    local gs: any = g[string.char(71, 101, 116, 83, 101, 114, 118, 105, 99, 101)] :: any
    return cloneref(gs(g, sn :: string)) :: any
end)(string.char(87, 111, 114, 107, 115, 112, 97, 99, 101)) :: Workspace

local TweenService: TweenService = (function<S>(sn: ObfuscatedType<string>): TweenService
    local g: any = game :: any
    local gs: any = g[string.char(71, 101, 116, 83, 101, 114, 118, 105, 99, 101)] :: any
    return cloneref(gs(g, sn :: string)) :: any
end)(string.char(84, 119, 101, 101, 110, 83, 101, 114, 118, 105, 99, 101)) :: TweenService

local Debris: Debris = (function<S>(sn: ObfuscatedType<string>): Debris
    local g: any = game :: any
    local gs: any = g[string.char(71, 101, 116, 83, 101, 114, 118, 105, 99, 101)] :: any
    return cloneref(gs(g, sn :: string)) :: any
end)(string.char(68, 101, 98, 114, 105, 115)) :: Debris

local VALID_GUNS: ComplexMap<string, boolean> = (function<G1, G2>(g1: ObfuscatedType<string>, g2: ObfuscatedType<string>): ComplexMap<string, boolean>
    return {
        [g1 :: string] = true,
        [g2 :: string] = true
    } :: any
end)(string.char(71, 117, 110), string.char(71, 108, 111, 99, 107, 105, 110, 97, 116, 111, 114)) :: ComplexMap<string, boolean>

local CRS: any = (function<F>(folder: ObfuscatedType<ReplicatedStorage>): any
    local wfc: any = (folder :: any)[string.char(87, 97, 105, 116, 70, 111, 114, 67, 104, 105, 108, 100)] :: any
    local mod: Instance = wfc(folder, string.char(67, 108, 105, 101, 110, 116, 82, 101, 115, 111, 117, 114, 99, 101, 115)) :: Instance
    local req: any = require :: any
    return req(mod) :: any
end)(ReplicatedStorage) :: any

local MvSLibrary: ComplexMap<string, any> = {}
MvSLibrary.__index = MvSLibrary

MvSLibrary.new = (function<F>(): any
    return function(): ComplexMap<string, any>
        return (function<P>(plrs: Players): ComplexMap<string, any>
            local g: any = game :: any
            local isL: any = g[string.char(73, 115, 76, 111, 97, 100, 101, 100)] :: any
            if not isL(g) then
                local lEv: any = g[string.char(76, 111, 97, 100, 101, 100)] :: any
                lEv[string.char(87, 97, 105, 116)](lEv)
            end
            
            local localPlayer: Player = (function<PL>(p: Players): Player
                return (p :: any)[string.char(76, 111, 99, 97, 108, 80, 108, 97, 121, 101, 114)] :: Player
            end)(plrs) :: Player
            
            local char: Model = (function<C>(p: Player): Model
                local c: Model? = p.Character :: Model?
                if c then return c end
                local ca: any = (p :: any)[string.char(67, 104, 97, 114, 97, 99, 116, 101, 114, 65, 100, 100, 101, 100)] :: any
                return ca[string.char(87, 97, 105, 116)](ca) :: Model
            end)(localPlayer) :: Model
            
            local hum: Humanoid = (function<H>(c: Model): Humanoid
                local wfc: any = (c :: any)[string.char(87, 97, 105, 116, 70, 111, 114, 67, 104, 105, 108, 100)] :: any
                return wfc(c, string.char(72, 117, 109, 97, 110, 111, 105, 100)) :: Humanoid
            end)(char) :: Humanoid
            
            local self: ComplexMap<string, any> = setmetatable({
                lp = localPlayer :: Player,
                RigType = hum.RigType :: Enum.HumanoidRigType,
                IsShoot = false :: boolean,
                IsThrow = false :: boolean,
                AutoWait = true :: boolean,
                PlayersTable = {} :: {Player},
                CachedRayParams = CRS[string.char(99, 114, 101, 97, 116, 101, 82, 97, 121, 99, 97, 115, 116, 80, 97, 114, 97, 109, 115)]() :: RaycastParams,
                Folder = (Workspace :: any)[string.char(70, 105, 110, 100, 70, 105, 114, 115, 116, 67, 104, 105, 108, 100)](Workspace, string.char(69, 102, 102, 101, 99, 116, 115)) :: Instance?,
                ValidPlayersMap = {} :: ComplexMap<Player, boolean?>,
                __index = MvSLibrary,
                __tostring = function(): string
                    return string.char(77, 118, 115, 83, 76, 105, 98, 114, 97, 114, 121)
                end
            }, MvSLibrary) :: ComplexMap<string, any>
            
            local caEvent: any = (localPlayer :: any)[string.char(67, 104, 97, 114, 97, 99, 116, 101, 114, 65, 100, 100, 101, 100)] :: any
            caEvent[string.char(67, 111, 110, 110, 101, 99, 116)](caEvent, function<NC>(newChar: Model)
                self.RigType = (function<NH>(nc: Model): Enum.HumanoidRigType
                    local wfc: any = (nc :: any)[string.char(87, 97, 105, 116, 70, 111, 114, 67, 104, 105, 108, 100)] :: any
                    local newHum: Humanoid = wfc(nc, string.char(72, 117, 109, 97, 110, 111, 105, 100)) :: Humanoid
                    return newHum.RigType :: Enum.HumanoidRigType
                end)(newChar) :: Enum.HumanoidRigType
            end)
            
            local prEvent: any = (plrs :: any)[string.char(80, 108, 97, 121, 101, 114, 82, 101, 109, 111, 118, 105, 110, 103)] :: any
            prEvent[string.char(67, 111, 110, 110, 101, 99, 116)](prEvent, function<PR>(plr: Player)
                (function<TP>(targetPlr: Player)
                    self.ValidPlayersMap[targetPlr] = nil
                    local played: number? = table.find(self.PlayersTable, targetPlr) :: number?
                    if played then
                        table.remove(self.PlayersTable, played)
                    end
                end)(plr)
            end)
            
            return self :: ComplexMap<string, any>
        end)(Players) :: ComplexMap<string, any>
    end
end)() :: any

MvSLibrary.GetShootingArm = (function<F>(lib: any): any
    return function(self: any): BasePart?
        return (function<PLR>(plr: Player): BasePart?
            local char: Model? = plr.Character :: Model?
            if not char then return nil end
            local ffc: any = (char :: any)[string.char(70, 105, 110, 100, 70, 105, 114, 115, 116, 67, 104, 105, 108, 100)] :: any
            if self.RigType == Enum.HumanoidRigType.R6 then
                return ffc(char, string.char(82, 105, 103, 104, 116, 32, 65, 114, 109)) :: BasePart?
            else
                return (ffc(char, string.char(82, 105, 103, 104, 116, 32, 85, 112, 112, 101, 114, 65, 114, 109)) or ffc(char, string.char(82, 105, 103, 104, 116, 72, 97, 110, 100))) :: BasePart?
            end
        end)(self.lp :: Player) :: BasePart?
    end
end)(MvSLibrary) :: any

MvSLibrary.GetSafeOrigin = (function<F>(lib: any): any
    return function(self: any, toolPart: BasePart): Vector3
        return (function<TP>(tp: BasePart): Vector3
            local char: Model? = (self.lp :: Player).Character :: Model?
            if not char then return tp.Position :: Vector3 end
            
            local ffc: any = (char :: any)[string.char(70, 105, 110, 100, 70, 105, 114, 115, 116, 67, 104, 105, 108, 100)] :: any
            local arm: BasePart? = (self:GetShootingArm() or ffc(char, string.char(85, 112, 112, 101, 114, 84, 111, 114, 115, 111))) :: BasePart?
            if not arm then return tp.Position :: Vector3 end
            
            local armPos: Vector3 = arm.Position :: Vector3
            local toolPos: Vector3 = tp.Position :: Vector3
            local dir: Vector3 = toolPos - armPos :: Vector3
            
            self.CachedRayParams.FilterDescendantsInstances = { char }
            local rc: any = (Workspace :: any)[string.char(82, 97, 121, 99, 97, 115, 116)] :: any
            local armToToolRay: RaycastResult? = rc(Workspace, armPos, dir, self.CachedRayParams) :: RaycastResult?
            if armToToolRay then
                return armToToolRay.Position :: Vector3
            end
            return toolPos :: Vector3
        end)(toolPart) :: Vector3
    end
end)(MvSLibrary) :: any

MvSLibrary.CheckTeam = (function<F>(lib: any): any
    return function(self: any): string
        return (function<PLR>(plr: Player): string
            local char: Model? = plr.Character :: Model?
            local ffcoc: any = (plr :: any)[string.char(70, 105, 110, 100, 70, 105, 114, 115, 116, 67, 104, 105, 108, 100, 79, 102, 67, 108, 97, 115, 115)] :: any
            local backpack: Backpack? = ffcoc(plr, string.char(66, 97, 99, 107, 112, 97, 99, 107)) :: Backpack?
            
            local containers: {Instance} = (function<C, B>(c: Model?, b: Backpack?): {Instance}
                local res: {Instance} = {}
                if c then table.insert(res, c) end
                if b then table.insert(res, b) end
                return res :: {Instance}
            end)(char, backpack) :: {Instance}
            
            local hasGun: boolean = false :: boolean
            local hasKnife: boolean = false :: boolean
            
            for _, container in containers do
                local gc: any = (container :: any)[string.char(71, 101, 116, 67, 104, 105, 108, 100, 114, 101, 110)] :: any
                for _, child in gc(container) do
                    local isA: any = (child :: any)[string.char(73, 115, 65)] :: any
                    if isA(child, string.char(84, 111, 111, 108)) then
                        local toolName: string = child.Name :: string
                        local ffc: any = (child :: any)[string.char(70, 105, 110, 100, 70, 105, 114, 115, 116, 67, 104, 105, 108, 100)] :: any
                        if VALID_GUNS[toolName] then
                            hasGun = true
                        elseif toolName:find(string.char(75, 110, 105, 102, 101)) or ffc(child, string.char(68, 97, 109, 97, 103, 101)) then
                            hasKnife = true
                        end
                    end
                end
            end
            
            if hasGun then
                return string.char(83, 104, 101, 114, 105, 102, 102, 115)
            elseif hasKnife then
                return string.char(77, 117, 114, 100, 101, 114, 101, 114, 115)
            else
                return string.char(74, 111, 115, 110, 105, 110, 103)
            end
        end)(self.lp :: Player) :: string
    end
end)(MvSLibrary) :: any
MvSLibrary.UpdateList = (function<F>(lib: any): any
    return function(self: any)
        (function<PLRS>(plrs: Players)
            local gp: any = (plrs :: any)[string.char(71, 101, 116, 80, 108, 97, 121, 101, 114, 115)] :: any
            for _, plr in gp(plrs) do
                if plr ~= (self.lp :: Player) then
                    local char: Model? = plr.Character :: Model?
                    local isValid: boolean = (function<C>(c: Model?): boolean
                        local cctd: any = CRS[string.char(99, 97, 110, 67, 104, 97, 114, 97, 99, 116, 101, 114, 84, 97, 107, 101, 68, 97, 109, 97, 103, 101)] :: any
                        return ((c and cctd(c)) or false) :: boolean
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
end)(MvSLibrary) :: any

MvSLibrary.PlayKnifeAnimation = (function<F>(lib: any): any
    return function(self: any, char: Model, waitToStop: boolean)
        (function<C, W>(c: Model, waitStop: boolean)
            if not c then return end
            local ffcoc: any = (c :: any)[string.char(70, 105, 110, 100, 70, 105, 114, 115, 116, 67, 104, 105, 108, 100, 79, 102, 67, 108, 97, 115, 115)] :: any
            local ffc: any = (c :: any)[string.char(70, 105, 110, 100, 70, 105, 114, 115, 116, 67, 104, 105, 108, 100)] :: any
            local hum: Humanoid? = ffcoc(c, string.char(72, 117, 109, 97, 110, 111, 105, 100)) :: Humanoid?
            local knife: Tool? = (ffc(c, string.char(75, 110, 105, 102, 101)) or ffcoc(c, string.char(84, 111, 111, 108))) :: Tool?
            if not hum or not knife then return end
            
            local animName: string = `Throw{(function<H>(h: Humanoid): string
                return (if h.RigType == Enum.HumanoidRigType.R15 then "" else string.char(82, 54))
            end)(hum)}` :: string
            
            local animObj: Animation? = (knife :: any)[string.char(70, 105, 110, 100, 70, 105, 114, 115, 116, 67, 104, 105, 108, 100)](knife, animName) :: Animation?
            if animObj then
                local la: any = (hum :: any)[string.char(76, 111, 97, 100, 65, 110, 105, 109, 97, 116, 105, 111, 110)] :: any
                local animTrack: AnimationTrack = la(hum, animObj) :: AnimationTrack
                animTrack[string.char(80, 108, 97, 121)](animTrack)
                if waitStop then
                    local stEv: any = (animTrack :: any)[string.char(83, 116, 111, 112, 112, 101, 100)] :: any
                    stEv[string.char(87, 97, 105, 116)](stEv)
                end
            end
        end)(char, waitToStop)
    end
end)(MvSLibrary) :: any

MvSLibrary.CreateKnife = (function<F>(lib: any): any
    return function(self: any, knifeTool: Instance, appearanceInfo: AppearanceInfo, startPos: Vector3, endPos: Vector3, attacker: Player)
        (function<KT, INFO, SP, EP, ATK>(kt: Instance, info: AppearanceInfo, sPos: Vector3, ePos: Vector3, atk: Player)
            local ffc: any = (Workspace :: any)[string.char(70, 105, 110, 100, 70, 105, 114, 115, 116, 67, 104, 105, 108, 100)] :: any
            local projectileContainer: Instance = (ffc(Workspace, string.char(80, 114, 111, 106, 101, 99, 116, 105, 108, 101, 115, 65, 110, 100, 68, 101, 98, 114, 105, 115)) or Workspace) :: Instance
            
            local cr: any = ReplicatedStorage[string.char(67, 108, 105, 101, 110, 116, 82, 101, 115, 111, 117, 114, 99, 101, 115)] :: any
            local wfc: any = cr[string.char(87, 97, 105, 116, 70, 111, 114, 67, 104, 105, 108, 100)] :: any
            local kpModel: Model = wfc(cr, string.char(75, 110, 105, 102, 101, 80, 114, 101, 106, 101, 99, 116, 105, 108, 101)) :: Model
            local projectileModel: Model = kpModel[string.char(67, 108, 111, 110, 101)](kpModel) :: Model
            
            local wfcPart: any = (projectileModel :: any)[string.char(87, 97, 105, 116, 70, 111, 114, 67, 104, 105, 108, 100)] :: any
            local visualPart: BasePart = wfcPart(projectileModel, string.char(86, 105, 115, 117, 97, 108)) :: BasePart
            
            pcall(function()
                (visualPart :: any)[string.char(84, 101, 120, 116, 117, 114, 101, 73, 68)] = info.TextureID
                visualPart.Color = info.Color :: Color3
                visualPart.Material = info.Material :: Enum.Material
                visualPart.Transparency = info.Transparency :: number
            end)
            
            local dirVector: Vector3 = ePos - sPos :: Vector3
            local distance: number = dirVector.Magnitude :: number
            if distance < 0.1 then
                projectileModel[string.char(68, 101, 115, 116, 114, 111, 121)](projectileModel)
                return
            end
            
            local initialCFrame: CFrame = CFrame.lookAt(sPos, ePos) :: CFrame
            (projectileModel :: any)[string.char(80, 105, 118, 111, 116, 84, 111)](projectileModel, initialCFrame);
            
            (function<VP, ICF, DV>(vp: BasePart, icf: CFrame, dv: Vector3)
                local ffcPart: any = (vp :: any)[string.char(70, 105, 110, 100, 70, 105, 114, 115, 116, 67, 104, 105, 108, 100)] :: any
                local vecVel: Instance? = ffcPart(vp, string.char(86, 101, 99, 116, 111, 114, 86, 101, 108, 111, 99, 105, 116, 121)) :: Instance?
                local isA: any = vecVel and (vecVel :: any)[string.char(73, 115, 65)] :: any
                if vecVel and isA(vecVel, string.char(76, 105, 110, 101, 97, 114, 86, 101, 108, 111, 99, 105, 116, 121)) then
                    (vecVel :: LinearVelocity).VectorVelocity = dv.Unit * 1500
                end
                local alignOrient: Instance? = ffcPart(vp, string.char(65, 108, 105, 103, 110, 79, 114, 105, 101, 110, 116, 97, 116, 105, 111, 110)) :: Instance?
                local isA2: any = alignOrient and (alignOrient :: any)[string.char(73, 115, 65)] :: any
                if alignOrient and isA2(alignOrient, string.char(65, 108, 105, 103, 110, 79, 114, 105, 101, 110, 116, 97, 116, 105, 111, 110)) then
                    (alignOrient :: AlignOrientation).CFrame = icf
                end
            end)(visualPart, initialCFrame, dirVector)
            
            if atk == (self.lp :: Player) then
                task.spawn(function()
                    self.CachedRayParams.FilterDescendantsInstances = (function<P>(p: Player): {Instance}
                        return (if p.Character then { p.Character } else {}) :: {Instance}
                    end)(self.lp :: Player) :: {Instance}
                    
                    local rc: any = (Workspace :: any)[string.char(82, 97, 121, 99, 97, 115, 116)] :: any
                    local rayHit: RaycastResult? = rc(Workspace, sPos, dirVector, self.CachedRayParams) :: RaycastResult?
                    local actualEndPos: Vector3 = (if rayHit then rayHit.Position else ePos) :: Vector3
                    local actualDistance: number = (actualEndPos - sPos).Magnitude :: number
                    
                    local tracer: Part = (function<SP2, EP2, AD>(sp: Vector3, ep: Vector3, ad: number): Part
                        local instNew: any = Instance.new :: any
                        local p: Part = instNew(string.char(80, 97, 114, 116)) :: Part
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
                    
                    local addTag: any = (CollectionService :: any)[string.char(65, 100, 100, 84, 97, 103)] :: any
                    addTag(CollectionService, tracer :: Instance, string.char(73, 103, 110, 111, 112, 101, 80, 114, 111, 106, 101, 99, 116, 105, 108, 101, 115));
                    
                    (function<TR>(tr: Part)
                        for face = 0, 5 do
                            local instNew: any = Instance.new :: any
                            local light: SurfaceLight = instNew(string.char(83, 117, 114, 102, 97, 99, 101, 76, 105, 103, 104, 116), tr) :: SurfaceLight
                            light.Range = 10
                            light.Brightness = 1.5
                            light.Color = Color3.fromRGB(255, 255, 255)
                            light.Face = Enum.NormalId:GetEnumItems()[face + 1]
                            
                            local twCreate: any = (TweenService :: any)[string.char(67, 114, 101, 97, 116, 101)] :: any
                            local tw: any = twCreate(TweenService, light, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                                Brightness = 0
                            })
                            tw[string.char(80, 108, 97, 121)](tw)
                        end
                    end)(tracer)
                    
                    local addItem: any = (Debris :: any)[string.char(65, 100, 100, 73, 116, 101, 109)] :: any
                    addItem(Debris, tracer :: Instance, 1)
                    tracer.Parent = projectileContainer :: Instance
                    
                    local twCreate2: any = (TweenService :: any)[string.char(67, 114, 101, 97, 116, 101)] :: any
                    local tw2: any = twCreate2(TweenService, tracer :: Instance, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                        Transparency = 1,
                        Size = Vector3.new(0.01, 0.01, actualDistance)
                    })
                    tw2[string.char(80, 108, 97, 121)](tw2)
                end)
            end
            
            local addItem2: any = (Debris :: any)[string.char(65, 100, 100, 73, 116, 101, 109)] :: any
            addItem2(Debris, projectileModel :: Instance, 3)
            projectileModel.Parent = projectileContainer :: Instance
        end)(knifeTool, appearanceInfo, startPos, endPos, attacker)
    end
end)(MvSLibrary) :: any
MvSLibrary.LineOfSightEstablished = (function<F>(lib: any): any
    return function(self: any, targetPart: Instance, isKnife: boolean): boolean
        return (function<TP, IK>(tp: Instance, ik: boolean): boolean
            local isA: any = tp and (tp :: any)[string.char(73, 115, 65)] :: any
            if not tp or not isA(tp, string.char(66, 97, 115, 101, 80, 97, 114, 116)) then return false end
            
            local gcfp: any = CRS[string.char(103, 101, 116, 67, 104, 97, 114, 97, 99, 116, 101, 114, 70, 114, 111, 109, 80, 97, 114, 116)] :: any
            local targetChar: Instance? = (gcfp(tp) or tp.Parent) :: Instance?
            local myChar: Model? = (self.lp :: Player).Character :: Model?
            if not targetChar or not myChar then return false end
            
            local ffcoc: any = (myChar :: any)[string.char(70, 105, 110, 100, 70, 105, 114, 115, 116, 67, 104, 105, 108, 100, 79, 102, 67, 108, 97, 115, 115)] :: any
            local ffc: any = (myChar :: any)[string.char(70, 105, 110, 100, 70, 105, 114, 115, 116, 67, 104, 105, 108, 100)] :: any
            
            local origin: Vector3? = (if ik then
                (if ffc(myChar, string.char(72, 101, 97, 100)) then (ffc(myChar, string.char(72, 101, 97, 100)) :: BasePart).Position else nil)
            else
                (function<MC>(mc: Model): Vector3?
                    local tool: Tool? = ffcoc(mc, string.char(84, 111, 111, 108)) :: Tool?
                    local ffcTool: any = tool and (tool :: any)[string.char(70, 105, 110, 100, 70, 105, 114, 115, 116, 67, 104, 105, 108, 100)] :: any
                    local barrel: BasePart? = tool and (ffcTool(tool, string.char(66, 97, 114, 114, 101, 108)) or ffcTool(tool, string.char(72, 97, 110, 100, 108, 101))) :: BasePart?
                    return (if barrel then self:GetSafeOrigin(barrel) else nil) :: Vector3?
                end)(myChar)) :: Vector3?
                
            if not origin then return false end
            
            self.CachedRayParams.FilterDescendantsInstances = { myChar }
            local direction: Vector3 = (tp :: BasePart).Position - origin :: Vector3
            local rc: any = (Workspace :: any)[string.char(82, 97, 121, 99, 97, 115, 116)] :: any
            local raycastResult: RaycastResult? = rc(Workspace, origin, direction, self.CachedRayParams) :: RaycastResult?
            
            if raycastResult then
                if gcfp(raycastResult.Instance) == targetChar then
                    return true
                end
                local checkOffsets: {Vector3} = {
                    Vector3.new(1.2, 0, 0),
                    Vector3.new(-1.2, 0, 0)
                }
                for _, offset in checkOffsets do
                    local edgePos: Vector3 = (tp :: BasePart).Position + offset :: Vector3
                    local edgeResult: RaycastResult? = rc(Workspace, origin, edgePos - origin, self.CachedRayParams) :: RaycastResult?
                    if edgeResult and gcfp(edgeResult.Instance) == targetChar then
                        return true
                    end
                end
                return false
            end
            return true
        end)(targetPart, isKnife) :: boolean
    end
end)(MvSLibrary) :: any

MvSLibrary.GetClosestTarget = (function<F>(lib: any): any
    return function(self: any, isKnife: boolean): (Player?, BasePart?)
        return (function<IK>(ik: boolean): (Player?, BasePart?)
            local myChar: Model? = (self.lp :: Player).Character :: Model?
            if not myChar then return nil, nil end
            local ffc: any = (myChar :: any)[string.char(70, 105, 110, 100, 70, 105, 114, 115, 116, 67, 104, 105, 108, 100)] :: any
            local myHead: BasePart? = ffc(myChar, string.char(72, 101, 97, 100)) :: BasePart?
            if not myHead then return nil, nil end
            
            local myPos: Vector3 = myHead.Position :: Vector3
            local candidateTarget: Player? = nil
            local candidatePart: BasePart? = nil
            local minDistanceSq: number = math.huge :: number
            
            for _, player in self.PlayersTable do
                local char: Model? = player and player.Character :: Model?
                local cctd: any = CRS[string.char(99, 97, 110, 67, 104, 97, 114, 97, 99, 116, 101, 114, 84, 97, 107, 101, 68, 97, 109, 97, 103, 101)] :: any
                if char and cctd(char) then
                    local ffcChar: any = (char :: any)[string.char(70, 105, 110, 100, 70, 105, 114, 115, 116, 67, 104, 105, 108, 100)] :: any
                    local targetPart: BasePart? = (ffcChar(char, string.char(67, 104, 97, 114, 97, 99, 116, 101, 114, 67, 101, 110, 116, 101, 114)) or ffcChar(char, string.char(72, 101, 97, 100)) or ffcChar(char, string.char(72, 117, 109, 97, 110, 111, 105, 100, 82, 111, 111, 116, 80, 97, 114, 116))) :: BasePart?
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
end)(MvSLibrary) :: any

MvSLibrary.Shoot = (function<F>(lib: any): any
    return function(self: any, targetPlayer: Player, targetPart: BasePart)
        (function<TP, TPART>(tp: Player, tPart: BasePart)
            if self.IsShoot or not tp or not tp.Character or not tPart then return end
            local char: Model? = (self.lp :: Player).Character :: Model?
            if not char then return end
            
            local ffcoc: any = (char :: any)[string.char(70, 105, 110, 100, 70, 105, 114, 115, 116, 67, 104, 105, 108, 100, 79, 102, 67, 108, 97, 115, 115)] :: any
            local tool: Tool? = ffcoc(char, string.char(84, 111, 111, 108)) :: Tool?
            if not tool or not VALID_GUNS[tool.Name] then return end
            
            local ffcTool: any = (tool :: any)[string.char(70, 105, 110, 100, 70, 105, 114, 115, 116, 67, 104, 105, 108, 100)] :: any
            local barrel: BasePart? = (ffcTool(tool, string.char(66, 97, 114, 114, 101, 108)) or ffcTool(tool, string.char(72, 97, 110, 100, 108, 101))) :: BasePart?
            local damageRemote: RemoteEvent? = ffcTool(tool, string.char(68, 97, 109, 97, 103, 101)) :: RemoteEvent?
            
            local ffcRS: any = (ReplicatedStorage :: any)[string.char(70, 105, 110, 100, 70, 105, 114, 115, 116, 67, 104, 105, 108, 100)] :: any
            local remotes: Instance? = ffcRS(ReplicatedStorage, string.char(82, 101, 109, 111, 116, 101, 115)) :: Instance?
            local ffcRem: any = remotes and (remotes :: any)[string.char(70, 105, 110, 100, 70, 105, 114, 115, 116, 67, 104, 105, 108, 100)] :: any
            local replicateBullet: RemoteEvent? = remotes and ffcRem(remotes, string.char(82, 101, 112, 108, 105, 99, 97, 116, 101, 66, 117, 108, 108, 101, 116)) :: RemoteEvent?
            if not barrel or not damageRemote or not replicateBullet then return end
            
            local safeOrigin: Vector3 = self:GetSafeOrigin(barrel) :: Vector3
            local hitPos: Vector3 = tPart.Position :: Vector3
            
            self.CachedRayParams.FilterDescendantsInstances = { char }
            local rc: any = (Workspace :: any)[string.char(82, 97, 121, 99, 97, 115, 116)] :: any
            local raycastResult: RaycastResult? = rc(Workspace, safeOrigin, hitPos - safeOrigin, self.CachedRayParams) :: RaycastResult?
            local gcfp: any = CRS[string.char(103, 101, 116, 67, 104, 97, 114, 97, 99, 116, 101, 114, 70, 114, 111, 109, 80, 97, 114, 116)] :: any
            if raycastResult and gcfp(raycastResult.Instance) ~= tp.Character then
                return
            end
            
            self.IsShoot = true
            task.delay(2.5, function()
                self.IsShoot = false
            end)
            
            local ffcChar: any = (char :: any)[string.char(70, 105, 110, 100, 70, 105, 114, 115, 116, 67, 104, 105, 108, 100)] :: any
            local hrp: BasePart? = ffcChar(char, string.char(72, 117, 109, 97, 110, 111, 105, 100, 82, 111, 111, 116, 80, 97, 114, 116)) :: BasePart?
            if not hrp then return end
            
            local bulletData: BulletPayload = {
                safeOrigin,
                hitPos,
                { PartType = string.char(67, 104, 97, 114, 97, 99, 116, 101, 114) },
                tool
            } :: BulletPayload
            
            local cb: any = CRS[string.char(99, 114, 101, 97, 116, 101, 66, 117, 108, 108, 101, 116)] :: any
            cb(unpack(bulletData))
            
            local fs: any = (replicateBullet :: any)[string.char(70, 101, 114, 118, 101, 114)] or (replicateBullet :: any)[string.char(70, 105, 114, 101, 83, 101, 114, 118, 101, 114)] :: any
            fs(replicateBullet, bulletData)
            
            local fsDmg: any = (damageRemote :: any)[string.char(70, 105, 114, 101, 83, 101, 114, 118, 101, 114)] :: any
            fsDmg(damageRemote, tPart, hitPos, hrp.Position)
        end)(targetPlayer, targetPart)
    end
end)(MvSLibrary) :: any

MvSLibrary.Throw = (function<F>(lib: any): any
    return function(self: any, targetPlayer: Player, targetPart: BasePart)
        (function<TP, TPART>(tp: Player, tPart: BasePart)
            if self.IsThrow or not tp or not tp.Character or not tPart then return end
            local char: Model? = (self.lp :: Player).Character :: Model?
            if not char then return end
            
            local ffcoc: any = (char :: any)[string.char(70, 105, 110, 100, 70, 105, 114, 115, 116, 67, 104, 105, 108, 100, 79, 102, 67, 108, 97, 115, 115)] :: any
            local knife: Tool? = ffcoc(char, string.char(84, 111, 111, 108)) :: Tool?
            if not knife or not knife.Name:find(string.char(75, 110, 105, 102, 101)) then return end
            
            local ffcTool: any = (knife :: any)[string.char(70, 105, 110, 100, 70, 105, 114, 115, 116, 67, 104, 105, 108, 100)] :: any
            local handle: BasePart? = ffcTool(knife, string.char(72, 97, 110, 100, 108, 101)) :: BasePart?
            local damageRemote: RemoteEvent? = ffcTool(knife, string.char(68, 97, 109, 97, 103, 101)) :: RemoteEvent?
            
            local ffcRS: any = (ReplicatedStorage :: any)[string.char(70, 105, 110, 100, 70, 105, 114, 115, 116, 67, 104, 105, 108, 100)] :: any
            local remotes: Instance? = ffcRS(ReplicatedStorage, string.char(82, 101, 109, 111, 116, 101, 115)) :: Instance?
            local ffcRem: any = remotes and (remotes :: any)[string.char(70, 105, 110, 100, 70, 105, 114, 115, 116, 67, 104, 105, 108, 100)] :: any
            local replicateKnife: RemoteEvent? = remotes and ffcRem(remotes, string.char(82, 101, 112, 108, 105, 99, 97, 116, 101, 75, 110, 105, 102, 101)) :: RemoteEvent?
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
            local rc: any = (Workspace :: any)[string.char(82, 97, 121, 99, 97, 115, 116)] :: any
            local rayHit: RaycastResult? = rc(Workspace, startPos, dirVector.Unit * distance, rayParams) :: RaycastResult?
            local actualHitPart: Instance = tPart :: Instance
            local isWallBlocked: boolean = false :: boolean
            
            local gcfp: any = CRS[string.char(103, 101, 116, 67, 104, 97, 114, 97, 99, 116, 101, 114, 70, 114, 111, 109, 80, 97, 114, 116)] :: any
            if rayHit then
                local hitChar: Instance? = gcfp(rayHit.Instance) :: Instance?
                if hitChar then
                    actualHitPart = rayHit.Instance :: Instance
                else
                    isWallBlocked = true
                end
            end
            
            local pks: any = CRS[string.char(112, 108, 97, 121, 75, 110, 105, 102, 101, 83, 111, 117, 110, 100, 115)] :: any
            pks(handle, appearanceInfo, string.char(84, 104, 112, 111, 119))
            
            local fsK: any = (replicateKnife :: any)[string.char(70, 105, 114, 101, 83, 101, 114, 118, 101, 114)] :: any
            fsK(replicateKnife, {
                Action = string.char(80, 108, 97, 121, 75, 110, 105, 102, 101, 83, 111, 117, 110, 100),
                KnifeAction = string.char(84, 104, 112, 111, 119),
                Handle = handle
            } :: KnifePayload)
            
            fsK(replicateKnife, {
                Action = string.char(67, 114, 101, 97, 116, 101, 75, 110, 105, 102, 101),
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
                        local fsDmg: any = (damageRemote :: any)[string.char(70, 105, 114, 101, 83, 101, 114, 118, 101, 114)] :: any
                        fsDmg(damageRemote, actualHitPart, string.char(84, 104, 112, 111, 119))
                    end
                end)
            end
        end)(targetPlayer, targetPart)
    end
end)(MvSLibrary) :: any

MvSLibrary.SetAutoWait = (function<F>(lib: any): any
    return function(self: any, state: boolean)
        (function<S>(s: boolean)
            self.AutoWait = s
        end)(state)
    end
end)(MvSLibrary) :: any

MvSLibrary.ToggleEffects = (function<F>(lib: any): any
    return function(self: any, state: boolean)
        (function<S>(s: boolean)
            if self.Folder then
                self.Folder.Parent = (if s then nil else Workspace) :: Instance?
            end
        end)(state)
    end
end)(MvSLibrary) :: any

MvSLibrary.GetRealTime = (function<F>(lib: any): any
    return function(self: any): ComplexMap<string, any>
        return (function<T, S>(fnName: ObfuscatedType<string>, wsName: ObfuscatedType<string>): ComplexMap<string, any>
            local g: any = game :: any
            local ws: Instance = g[wsName :: string] :: Instance
            local getStn: any = (ws :: any)[fnName :: string] :: any
            local stamp: number = getStn(ws) :: number
            
            return (os[string.char(100, 97, 116, 101)] :: any)(
                string.char(42, 116), 
                stamp
            ) :: ComplexMap<string, any>
        end)(
            string.char(71, 101, 116, 83, 101, 114, 118, 101, 114, 84, 105, 119, 101, 78, 101, 119),
            string.char(87, 111, 114, 107, 115, 112, 97, 99, 101)
        ) :: ComplexMap<string, any>
    end
end)(MvSLibrary) :: any

return MvSLibrary
