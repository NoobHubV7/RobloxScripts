local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

if CoreGui:FindFirstChild("FPS_FFlag_UI") then
    CoreGui.FPS_FFlag_UI:Destroy()
end

-- 1. ÉP ENGINE BẰNG FFLAG & UNCAP FPS
pcall(function()
    setfpscap(999)
    if setfflag then
        setfflag("TaskSchedulerTargetFps", "999")
        setfflag("FFlagTargetFps", "999")
        setfflag("DFIntTaskSchedulerTargetFps", "999")
    end
end)

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FPS_FFlag_UI"
screenGui.ResetOnSpawn = false
screenGui.Parent = CoreGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 180, 0, 50)
frame.Position = UDim2.new(0.01, 0, 0.01, 0)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BackgroundTransparency = 0.2
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame

local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, 0, 1, 0)
label.BackgroundTransparency = 1
label.TextColor3 = Color3.fromRGB(0, 255, 127)
label.TextSize = 13
label.Font = Enum.Font.GothamBold
label.Text = "Render (GPU): -- FPS\nLogic (PreSim): -- Hz"
label.Parent = frame

-- 2. ĐO RENDER FPS (Vẽ khung hình)
local renderFrames = 0
local lastRenderTime = os.clock()
local currentRenderFPS = 0

RunService.RenderStepped:Connect(function()
    renderFrames = renderFrames + 1
end)

-- 3. ĐO LOGIC RATE QUA PRESIMULATION (Xử lý FFlag)
local logicTicks = 0
local lastLogicTime = os.clock()
local currentLogicFPS = 0

RunService.PreSimulation:Connect(function()
    logicTicks = logicTicks + 1
end)

-- Cập nhật giao diện đếm
task.spawn(function()
    while true do
        task.wait(1)
        local now = os.clock()
        
        currentRenderFPS = math.floor(renderFrames / (now - lastRenderTime))
        renderFrames = 0
        lastRenderTime = now

        currentLogicFPS = math.floor(logicTicks / (now - lastLogicTime))
        logicTicks = 0
        lastLogicTime = now

        label.Text = "Render (GPU): " .. currentRenderFPS .. " FPS\nLogic (PreSim): " .. currentLogicFPS .. " Hz"
    end
end)
