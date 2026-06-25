-- ========================================================
-- mini scn god mode (V5.8.50)
-- ========================================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

-- Roblox'un Kendi Mobil Kontrol Sistemini Çekiyoruz
local PlayerModule = require(LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"))
local Controls = PlayerModule:GetControls()

-- 1. ARAYÜZ (GUI) KURULUMU
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ScnFlyHub"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 200, 0, 135) -- KUTU KISA BAŞLAR
MainFrame.Position = UDim2.new(0.1, 0, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Parent = ScreenGui

local FrameCorner = Instance.new("UICorner")
FrameCorner.CornerRadius = UDim.new(0, 10)
FrameCorner.Parent = MainFrame

local DragBar = Instance.new("Frame")
DragBar.Name = "DragBar"
DragBar.Size = UDim2.new(1, 0, 0, 25)
DragBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
DragBar.BorderSizePixel = 0
DragBar.Parent = MainFrame

local BarCorner = Instance.new("UICorner")
BarCorner.CornerRadius = UDim.new(0, 10)
BarCorner.Parent = DragBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.Text = "⚡ mini scn god mode (V5.8.50)"
Title.TextColor3 = Color3.fromRGB(0, 255, 204)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 12
Title.Parent = DragBar

-- BUTON ŞABLONU
local function createButton(name, text, posX, posY)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(0, 88, 0, 40)
    btn.Position = UDim2.new(0, posX, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 12
    btn.Parent = MainFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn
    return btn
end

-- Ana Butonlar
local ToggleBtn = createButton("ToggleBtn", "UÇUŞ: OFF", 8, 35)
local NoclipBtn = createButton("NoclipBtn", "DUVAR: OFF", 104, 35)
local KalkanBtn = createButton("KalkanBtn", "KALKAN: OFF", 8, 85)
local TpBtn = createButton("TpBtn", "TP (2 TIK): OFF", 104, 85)

-- ================= HIZ KONTROL PANELİ =================
local SpeedFrame = Instance.new("Frame")
SpeedFrame.Size = UDim2.new(0, 110, 0, 30) 
SpeedFrame.BackgroundTransparency = 1
SpeedFrame.Visible = false 
SpeedFrame.Parent = MainFrame

local DecBtn = Instance.new("TextButton")
DecBtn.Size = UDim2.new(0, 25, 0, 30)
DecBtn.Position = UDim2.new(0, 0, 0, 0)
DecBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
DecBtn.Text = "<"
DecBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DecBtn.Font = Enum.Font.SourceSansBold
DecBtn.TextSize = 18
DecBtn.Parent = SpeedFrame

local DecCorner = Instance.new("UICorner")
DecCorner.CornerRadius = UDim.new(0, 5)
DecCorner.Parent = DecBtn

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(0, 35, 0, 30)
SpeedLabel.Position = UDim2.new(0, 25, 0, 0)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "16" 
SpeedLabel.TextColor3 = Color3.fromRGB(0, 255, 204)
SpeedLabel.Font = Enum.Font.SourceSansBold
SpeedLabel.TextSize = 14
SpeedLabel.Parent = SpeedFrame

local IncBtn = Instance.new("TextButton")
IncBtn.Size = UDim2.new(0, 25, 0, 30)
IncBtn.Position = UDim2.new(0, 60, 0, 0)
IncBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
IncBtn.Text = ">"
IncBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
IncBtn.Font = Enum.Font.SourceSansBold
IncBtn.TextSize = 18
IncBtn.Parent = SpeedFrame

local IncCorner = Instance.new("UICorner")
IncCorner.CornerRadius = UDim.new(0, 5)
IncCorner.Parent = IncBtn

local RndBtn = Instance.new("TextButton")
RndBtn.Size = UDim2.new(0, 25, 0, 30)
RndBtn.Position = UDim2.new(0, 85, 0, 0)
RndBtn.BackgroundColor3 = Color3.fromRGB(138, 43, 226) 
RndBtn.Text = "🎲"
RndBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RndBtn.Font = Enum.Font.SourceSansBold
RndBtn.TextSize = 14
RndBtn.Parent = SpeedFrame

local RndCorner = Instance.new("UICorner")
RndCorner.CornerRadius = UDim.new(0, 5)
RndCorner.Parent = RndBtn

-- ================= YENİ TP (IŞINLANMA) PANELİ =================
local TpFrame = Instance.new("Frame")
TpFrame.Size = UDim2.new(0, 184, 0, 30) 
TpFrame.BackgroundTransparency = 1
TpFrame.Visible = false 
TpFrame.Parent = MainFrame

local RndPlayerBtn = Instance.new("TextButton")
RndPlayerBtn.Size = UDim2.new(0, 88, 0, 30)
RndPlayerBtn.Position = UDim2.new(0, 8, 0, 0)
RndPlayerBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
RndPlayerBtn.Text = "RND OYUNCU"
RndPlayerBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RndPlayerBtn.Font = Enum.Font.SourceSansBold
RndPlayerBtn.TextSize = 12
RndPlayerBtn.Parent = TpFrame

local RndPlayerCorner = Instance.new("UICorner")
RndPlayerCorner.CornerRadius = UDim.new(0, 5)
RndPlayerCorner.Parent = RndPlayerBtn

local RndGroundBtn = Instance.new("TextButton")
RndGroundBtn.Size = UDim2.new(0, 88, 0, 30)
RndGroundBtn.Position = UDim2.new(0, 104, 0, 0)
RndGroundBtn.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
RndGroundBtn.Text = "RND ZEMİN"
RndGroundBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RndGroundBtn.Font = Enum.Font.SourceSansBold
RndGroundBtn.TextSize = 12
RndGroundBtn.Parent = TpFrame

local RndGroundCorner = Instance.new("UICorner")
RndGroundCorner.CornerRadius = UDim.new(0, 5)
RndGroundCorner.Parent = RndGroundBtn

-- ================= ARAYÜZ DÜZENLEME (AKILLI KUTU) =================
local flying, noclipping, kalkanActive, tpEnabled = false, false, false, false
local flySpeed = 16 

local function updateUI()
    local currentY = 135
    
    if flying then
        SpeedFrame.Position = UDim2.new(0, 45, 0, currentY)
        SpeedFrame.Visible = true
        currentY = currentY + 35
    else
        SpeedFrame.Visible = false
    end
    
    if tpEnabled then
        TpFrame.Position = UDim2.new(0, 0, 0, currentY)
        TpFrame.Visible = true
        currentY = currentY + 35
    else
        TpFrame.Visible = false
    end
    
    MainFrame.Size = UDim2.new(0, 200, 0, currentY)
end

-- 2. KAYDIRMA (DRAG) SİSTEMİ
local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end
DragBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
DragBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then update(input) end
end)

-- 3. MOTORLAR VE FONKSİYONLAR
local bV, bG, flyConnection, noclipConnection, kalkanConnection

-- Hız Artırma/Azaltma Mantığı
DecBtn.MouseButton1Click:Connect(function()
    flySpeed = flySpeed - 20
    if flySpeed < 1 then flySpeed = 1 end 
    SpeedLabel.Text = tostring(flySpeed)
end)

IncBtn.MouseButton1Click:Connect(function()
    flySpeed = flySpeed + 20
    SpeedLabel.Text = tostring(flySpeed)
end)

RndBtn.MouseButton1Click:Connect(function()
    flySpeed = math.random(1, 1000)
    SpeedLabel.Text = tostring(flySpeed)
end)

-- Yeni: Rastgele Oyuncunun TAM İÇİNE TP (Hitbox Birleşimi)
RndPlayerBtn.MouseButton1Click:Connect(function()
    local targets = {}
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            table.insert(targets, p)
        end
    end
    
    if #targets > 0 then
        local target = targets[math.random(1, #targets)]
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            -- Hedefin koordinatına tam olarak ışınlanma
            char.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
        end
    end
end)

-- Yeni: Rastgele Güvenli Zemine TP
RndGroundBtn.MouseButton1Click:Connect(function()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
    local maxTries = 10 
    for i = 1, maxTries do
        local rx = math.random(-800, 800) 
        local rz = math.random(-800, 800)
        
        local origin = Vector3.new(rx, 1000, rz)
        local direction = Vector3.new(0, -2000, 0)
        
        local raycastParams = RaycastParams.new()
        raycastParams.FilterDescendantsInstances = {char} 
        raycastParams.FilterType = Enum.RaycastFilterType.Exclude
        
        local result = workspace:Raycast(origin, direction, raycastParams)
        
        if result and result.Instance and result.Instance.CanCollide then
            char.HumanoidRootPart.CFrame = CFrame.new(result.Position + Vector3.new(0, 3, 0))
            break 
        end
    end
end)

-- Uçuş Motoru
local function startFlying()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local rootPart = char.HumanoidRootPart
    local hum = char:FindFirstChildOfClass("Humanoid")
    if bV then bV:Destroy() end
    if bG then bG:Destroy() end
    bG = Instance.new("BodyGyro", rootPart)
    bG.P, bG.maxTorque = 9e4, Vector3.new(9e9, 9e9, 9e9)
    bG.cframe = rootPart.CFrame
    bV = Instance.new("BodyVelocity", rootPart)
    bV.maxForce = Vector3.new(9e9, 9e9, 9e9)
    bV.velocity = Vector3.new(0,0,0)
    if hum then hum.PlatformStand = true end
    
    flyConnection = RunService.RenderStepped:Connect(function()
        if flying and char and rootPart and hum then
            bG.cframe = Camera.CFrame
            local moveVector = Controls:GetMoveVector()
            local direction = Camera.CFrame:VectorToWorldSpace(moveVector)
            bV.velocity = direction.Magnitude > 0 and direction * flySpeed or Vector3.new(0,0,0)
        end
    end)
end

local function stopFlying()
    if flyConnection then flyConnection:Disconnect() end
    if bV then bV:Destroy() end
    if bG then bG:Destroy() end
    local char = LocalPlayer.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        char:FindFirstChildOfClass("Humanoid").PlatformStand = false
    end
end

-- Noclip Motoru
local function startNoclip()
    if noclipConnection then noclipConnection:Disconnect() end
    noclipConnection = RunService.Stepped:Connect(function()
        if noclipping and LocalPlayer.Character then
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide then
                    part.CanCollide = false
                end
            end
        end
    end)
end

local function stopNoclip()
    if noclipConnection then noclipConnection:Disconnect() end
    if LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                if part.Name == "HumanoidRootPart" or part.Name == "Torso" or part.Name == "UpperTorso" or part.Name == "LowerTorso" or part.Name == "Head" then
                    part.CanCollide = true
                end
            end
        end
    end
end

-- Kalkan ve Auto-Heal Sistemi
local function toggleKalkanEffect()
    local char = LocalPlayer.Character
    if not char then return end
    
    if kalkanActive then
        if not char:FindFirstChild("SCN_Kalkan") then
            local ff = Instance.new("ForceField")
            ff.Visible = true
            ff.Name = "SCN_Kalkan"
            ff.Parent = char
        end
        
        if kalkanConnection then kalkanConnection:Disconnect() end
        kalkanConnection = RunService.RenderStepped:Connect(function()
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 and hum.Health < hum.MaxHealth then
                hum.Health = hum.MaxHealth
            end
        end)
    else
        if char:FindFirstChild("SCN_Kalkan") then
            char.SCN_Kalkan:Destroy()
        end
        if kalkanConnection then
            kalkanConnection:Disconnect()
            kalkanConnection = nil
        end
    end
end

-- Çift Tıkla TP Sistemi
local lastClickTime = 0
local doubleClickThreshold = 0.3
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if tpEnabled and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
        local currentTime = tick()
        if currentTime - lastClickTime < doubleClickThreshold then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") and Mouse.Hit then
                char.HumanoidRootPart.CFrame = CFrame.new(Mouse.Hit.p + Vector3.new(0, 3, 0))
            end
            lastClickTime = 0
        else
            lastClickTime = currentTime
        end
    end
end)

-- 4. BUTON TETİKLEYİCİLERİ
ToggleBtn.MouseButton1Click:Connect(function()
    flying = not flying
    ToggleBtn.BackgroundColor3 = flying and Color3.fromRGB(50, 180, 50) or Color3.fromRGB(200, 50, 50)
    ToggleBtn.Text = flying and "UÇUŞ: ON" or "UÇUŞ: OFF"
    updateUI()
    if flying then startFlying() else stopFlying() end
end)

NoclipBtn.MouseButton1Click:Connect(function()
    noclipping = not noclipping
    NoclipBtn.BackgroundColor3 = noclipping and Color3.fromRGB(50, 180, 50) or Color3.fromRGB(200, 50, 50)
    NoclipBtn.Text = noclipping and "DUVAR: ON" or "DUVAR: OFF"
    if noclipping then startNoclip() else stopNoclip() end
end)

KalkanBtn.MouseButton1Click:Connect(function()
    kalkanActive = not kalkanActive
    KalkanBtn.BackgroundColor3 = kalkanActive and Color3.fromRGB(50, 180, 50) or Color3.fromRGB(200, 50, 50)
    KalkanBtn.Text = kalkanActive and "KALKAN: ON" or "KALKAN: OFF"
    toggleKalkanEffect()
end)

TpBtn.MouseButton1Click:Connect(function()
    tpEnabled = not tpEnabled
    TpBtn.BackgroundColor3 = tpEnabled and Color3.fromRGB(50, 180, 50) or Color3.fromRGB(200, 50, 50)
    TpBtn.Text = tpEnabled and "TP (2 TIK): ON" or "TP (2 TIK): OFF"
    updateUI()
end)

-- Karakter Yeniden Doğduğunda (Veya Ölünce)
LocalPlayer.CharacterAdded:Connect(function()
    flying, noclipping, kalkanActive, tpEnabled = false, false, false, false
    flySpeed = 16 
    SpeedLabel.Text = "16"
    
    updateUI()
    
    ToggleBtn.BackgroundColor3, ToggleBtn.Text = Color3.fromRGB(200, 50, 50), "UÇUŞ: OFF"
    NoclipBtn.BackgroundColor3, NoclipBtn.Text = Color3.fromRGB(200, 50, 50), "DUVAR: OFF"
    KalkanBtn.BackgroundColor3, KalkanBtn.Text = Color3.fromRGB(200, 50, 50), "KALKAN: OFF"
    TpBtn.BackgroundColor3, TpBtn.Text = Color3.fromRGB(200, 50, 50), "TP (2 TIK): OFF"
    stopFlying()
    stopNoclip()
    if kalkanConnection then kalkanConnection:Disconnect() kalkanConnection = nil end
end)
