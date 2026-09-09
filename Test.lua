local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

-- Xóa UI cũ nếu đã tồn tại tránh trùng lặp
if CoreGui:FindFirstChild("FPS_Counter_UI") then
    CoreGui.FPS_Counter_UI:Destroy()
end

-- Tạo ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FPS_Counter_UI"
screenGui.ResetOnSpawn = false
screenGui.Parent = CoreGui

-- Tạo Frame hiển thị
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 110, 0, 35)
frame.Position = UDim2.new(0.01, 0, 0.01, 0) -- Góc trên bên trái
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BackgroundTransparency = 0.2
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true -- Có thể di chuyển UI quanh màn hình
frame.Parent = screenGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame

local uiStroke = Instance.new("UIStroke")
uiStroke.Color = Color3.fromRGB(0, 255, 127)
uiStroke.Thickness = 1.5
uiStroke.Parent = frame

-- Tạo Label hiển thị số FPS
local fpsLabel = Instance.new("TextLabel")
fpsLabel.Size = UDim2.new(1, 0, 1, 0)
fpsLabel.BackgroundTransparency = 1
fpsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
fpsLabel.TextSize = 16
fpsLabel.Font = Enum.Font.GothamBold
fpsLabel.Text = "FPS: --"
fpsLabel.Parent = frame

-- Logic tính toán FPS thực tế
local lastTime = os.clock()
local frameCount = 0

RunService.RenderStepped:Connect(function()
    frameCount = frameCount + 1
    local currentTime = os.clock()
    
    if currentTime - lastTime >= 1 then
        local fps = math.floor(frameCount / (currentTime - lastTime))
        fpsLabel.Text = "FPS: " .. tostring(fps)
        
        -- Đổi màu chữ theo mức độ mượt
        if fps >= 55 then
            fpsLabel.TextColor3 = Color3.fromRGB(0, 255, 127) -- Xanh lá (Mượt)
        elseif fps >= 30 then
            fpsLabel.TextColor3 = Color3.fromRGB(255, 200, 0) -- Vàng (Tạm ổn)
        else
            fpsLabel.TextColor3 = Color3.fromRGB(255, 50, 50) -- Đỏ (Giật lag)
        end
        
        frameCount = 0
        lastTime = currentTime
    end
end)
