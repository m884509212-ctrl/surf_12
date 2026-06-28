-- ============================================
-- HEART CLIENT v3 | ULTIMATE MM2 MENU
-- by em (Full Rework)
-- ============================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = game:GetService("Workspace").CurrentCamera
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualInputManager = game:GetService("VirtualInputManager")

local Player = Players.LocalPlayer

-- ============================================
-- НАСТРОЙКИ
-- ============================================
local Settings = {
    HeadSize = 75,
    HitboxEnabled = false,
    ShowHitboxes = false,
    SkinList = {
        "Icebreaker", "Luger", "Slasher", "Sparkle", "BattleAxe",
        "Ghost", "Mint", "Pixel", "Skull", "Nightmare"
    },
    SelectedSkin = nil,
}

local GUIEnabled = true
local SkinInventory = {}

-- ============================================
-- СОЗДАНИЕ GUI
-- ============================================
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleLabel = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")

local HitboxSection = Instance.new("Frame")
local HitboxLabel = Instance.new("TextLabel")
local HitboxToggle = Instance.new("TextButton")
local HitboxSlider = Instance.new("Frame")
local HitboxSliderFill = Instance.new("Frame")
local HitboxValueLabel = Instance.new("TextLabel")
local ShowHitboxToggle = Instance.new("TextButton")

local SkinSection = Instance.new("Frame")
local SkinLabel = Instance.new("TextLabel")
local SkinListFrame = Instance.new("ScrollingFrame")
local SkinButtons = {}

local XPButton = Instance.new("TextButton")
local LevelButton = Instance.new("TextButton")

local StatusLabel = Instance.new("TextLabel")
local CloseHint = Instance.new("TextLabel")

ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "HeartClientGUI"
ScreenGui.ResetOnSpawn = false

-- Главное окно
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderColor3 = Color3.fromRGB(255, 51, 102)
MainFrame.BorderSizePixel = 2
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -250)
MainFrame.Size = UDim2.new(0, 600, 0, 500)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.Visible = true

-- Тень
local Shadow = Instance.new("Frame")
Shadow.Parent = MainFrame
Shadow.BackgroundColor3 = Color3.fromRGB(255, 51, 102)
Shadow.BackgroundTransparency = 0.9
Shadow.Position = UDim2.new(0.01, 0, 0.01, 0)
Shadow.Size = UDim2.new(0.98, 0, 0.98, 0)

-- Заголовок
TitleLabel.Parent = MainFrame
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 10, 0, 10)
TitleLabel.Size = UDim2.new(0, 300, 0, 30)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "❤️ HEART CLIENT v3"
TitleLabel.TextColor3 = Color3.fromRGB(255, 51, 102)
TitleLabel.TextSize = 20
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Кнопка закрытия
CloseButton.Parent = MainFrame
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 51, 102)
CloseButton.BackgroundTransparency = 0.8
CloseButton.Position = UDim2.new(1, -40, 0, 10)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 18
CloseButton.MouseButton1Click:Connect(function()
    GUIEnabled = false
    MainFrame.Visible = false
end)

-- Подсказка закрытия
CloseHint.Parent = MainFrame
CloseHint.BackgroundTransparency = 1
CloseHint.Position = UDim2.new(0, 10, 0, 45)
CloseHint.Size = UDim2.new(0, 300, 0, 20)
CloseHint.Font = Enum.Font.Gotham
CloseHint.Text = "Нажми Left Alt для открытия/закрытия"
CloseHint.TextColor3 = Color3.fromRGB(150, 150, 150)
CloseHint.TextSize = 12
CloseHint.TextXAlignment = Enum.TextXAlignment.Left

-- ============================================
-- СЕКЦИЯ ХИТБОКСОВ
-- ============================================
HitboxSection.Parent = MainFrame
HitboxSection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
HitboxSection.BackgroundTransparency = 0.95
HitboxSection.Position = UDim2.new(0, 10, 0, 75)
HitboxSection.Size = UDim2.new(0, 280, 0, 140)

HitboxLabel.Parent = HitboxSection
HitboxLabel.BackgroundTransparency = 1
HitboxLabel.Position = UDim2.new(0, 10, 0, 5)
HitboxLabel.Size = UDim2.new(0, 250, 0, 20)
HitboxLabel.Font = Enum.Font.GothamBold
HitboxLabel.Text = "🎯 ХИТБОКСЫ (ГОЛОВА)"
HitboxLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
HitboxLabel.TextSize = 14
HitboxLabel.TextXAlignment = Enum.TextXAlignment.Left

HitboxToggle.Parent = HitboxSection
HitboxToggle.BackgroundColor3 = Color3.fromRGB(255, 51, 102)
HitboxToggle.Position = UDim2.new(0, 10, 0, 30)
HitboxToggle.Size = UDim2.new(0, 120, 0, 25)
HitboxToggle.Font = Enum.Font.GothamBold
HitboxToggle.Text = "ВЫКЛ"
HitboxToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
HitboxToggle.TextSize = 12
HitboxToggle.BorderSizePixel = 0

ShowHitboxToggle.Parent = HitboxSection
ShowHitboxToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
ShowHitboxToggle.Position = UDim2.new(0, 140, 0, 30)
ShowHitboxToggle.Size = UDim2.new(0, 120, 0, 25)
ShowHitboxToggle.Font = Enum.Font.GothamBold
ShowHitboxToggle.Text = "ПОКАЗАТЬ"
ShowHitboxToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
ShowHitboxToggle.TextSize = 12
ShowHitboxToggle.BorderSizePixel = 0

HitboxSlider.Parent = HitboxSection
HitboxSlider.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
HitboxSlider.Position = UDim2.new(0, 10, 0, 65)
HitboxSlider.Size = UDim2.new(0, 220, 0, 8)
HitboxSlider.BorderSizePixel = 0

HitboxSliderFill.Parent = HitboxSlider
HitboxSliderFill.BackgroundColor3 = Color3.fromRGB(255, 51, 102)
HitboxSliderFill.Size = UDim2.new(Settings.HeadSize / 1000, 0, 1, 0)
HitboxSliderFill.BorderSizePixel = 0

HitboxValueLabel.Parent = HitboxSection
HitboxValueLabel.BackgroundTransparency = 1
HitboxValueLabel.Position = UDim2.new(0, 235, 0, 60)
HitboxValueLabel.Size = UDim2.new(0, 35, 0, 20)
HitboxValueLabel.Font = Enum.Font.GothamBold
HitboxValueLabel.Text = tostring(Settings.HeadSize)
HitboxValueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
HitboxValueLabel.TextSize = 12

-- ============================================
-- СЕКЦИЯ СКИНОВ (НОВАЯ)
-- ============================================
SkinSection.Parent = MainFrame
SkinSection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SkinSection.BackgroundTransparency = 0.95
SkinSection.Position = UDim2.new(0, 300, 0, 75)
SkinSection.Size = UDim2.new(0, 280, 0, 280)

SkinLabel.Parent = SkinSection
SkinLabel.BackgroundTransparency = 1
SkinLabel.Position = UDim2.new(0, 10, 0, 5)
SkinLabel.Size = UDim2.new(0, 250, 0, 20)
SkinLabel.Font = Enum.Font.GothamBold
SkinLabel.Text = "🎨 ВЫБОР СКИНА"
SkinLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SkinLabel.TextSize = 14
SkinLabel.TextXAlignment = Enum.TextXAlignment.Left

SkinListFrame.Parent = SkinSection
SkinListFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
SkinListFrame.Position = UDim2.new(0, 10, 0, 30)
SkinListFrame.Size = UDim2.new(0, 260, 0, 200)
SkinListFrame.ScrollBarThickness = 4
SkinListFrame.BorderSizePixel = 0

-- Заполнение списка скинов
for i, skinName in ipairs(Settings.SkinList) do
    local btn = Instance.new("TextButton")
    btn.Parent = SkinListFrame
    btn.Size = UDim2.new(0, 240, 0, 30)
    btn.Position = UDim2.new(0, 0, 0, (i-1) * 32)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    btn.BackgroundTransparency = 0.5
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.Gotham
    btn.Text = "🔪 " .. skinName
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Name = skinName
    
    btn.MouseButton1Click:Connect(function()
        Settings.SelectedSkin = skinName
        -- Применяем скин к руке
        local character = Player.Character
        if character then
            local rightHand = character:FindFirstChild("RightHand")
            if rightHand then
                -- Удаляем старый скин
                for _, child in ipairs(rightHand:GetChildren()) do
                    if child:IsA("Tool") or child:IsA("Handle") then
                        child:Destroy()
                    end
                end
                -- Создаём новый скин (в MM2 это обычно через Handle)
                local tool = Instance.new("Tool")
                tool.Name = skinName
                tool.Parent = rightHand
                tool.RequiresHandle = false
                local handle = Instance.new("Part")
                handle.Parent = tool
                handle.Size = Vector3.new(0.5, 0.1, 0.1)
                handle.BrickColor = BrickColor.new("Really red")
                handle.Material = Enum.Material.Neon
                handle.Anchored = false
                handle.CanCollide = false
                handle.Transparency = 0.3
                
                -- Привязываем к руке
                local weld = Instance.new("Weld")
                weld.Parent = handle
                weld.Part0 = rightHand
                weld.Part1 = handle
                weld.C0 = CFrame.new(0, 0.1, 0.2)
                
                -- Обновляем кнопки
                for _, button in ipairs(SkinButtons) do
                    button.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
                end
                btn.BackgroundColor3 = Color3.fromRGB(100, 0, 50)
            end
        end
        StatusLabel.Text = "✅ СКИН " .. skinName .. " ПРИМЕНЁН!"
        StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
    end
    
    table.insert(SkinButtons, btn)
end

-- ============================================
-- XP И УРОВЕНЬ (НОВЫЕ КНОПКИ)
-- ============================================
XPButton.Parent = MainFrame
XPButton.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
XPButton.Position = UDim2.new(0, 10, 0, 230)
XPButton.Size = UDim2.new(0, 270, 0, 35)
XPButton.Font = Enum.Font.GothamBold
XPButton.Text = "⭐ ДОБАВИТЬ XP (+1000)"
XPButton.TextColor3 = Color3.fromRGB(0, 0, 0)
XPButton.TextSize = 14
XPButton.BorderSizePixel = 0

XPButton.MouseButton1Click:Connect(function()
    -- Попытка добавить XP
    local args = {1000, "XP"} -- Для многих игр это работает
    local remote = ReplicatedStorage:FindFirstChild("AddXP") or ReplicatedStorage:FindFirstChild("GiveXP")
    if remote then
        remote:FireServer(unpack(args))
        StatusLabel.Text = "⭐ XP ДОБАВЛЕНО!"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
    else
        -- Альтернативный способ через локального игрока
        local leaderstats = Player:FindFirstChild("leaderstats")
        if leaderstats then
            local xp = leaderstats:FindFirstChild("XP")
            if xp then
                xp.Value = xp.Value + 1000
                StatusLabel.Text = "⭐ XP ДОБАВЛЕНО!"
                StatusLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
            end
        end
    end
end)

LevelButton.Parent = MainFrame
LevelButton.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
LevelButton.Position = UDim2.new(0, 10, 0, 275)
LevelButton.Size = UDim2.new(0, 270, 0, 35)
LevelButton.Font = Enum.Font.GothamBold
LevelButton.Text = "⬆ ПОВЫСИТЬ УРОВЕНЬ (+1)"
LevelButton.TextColor3 = Color3.fromRGB(255, 255, 255)
LevelButton.TextSize = 14
LevelButton.BorderSizePixel = 0

LevelButton.MouseButton1Click:Connect(function()
    local leaderstats = Player:FindFirstChild("leaderstats")
    if leaderstats then
        local level = leaderstats:FindFirstChild("Level") or leaderstats:FindFirstChild("Rank")
        if level then
            level.Value = level.Value + 1
            StatusLabel.Text = "⬆ УРОВЕНЬ ПОВЫШЕН!"
            StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 0)
        end
    end
end)

-- ============================================
-- СТАТУС
-- ============================================
StatusLabel.Parent = MainFrame
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0, 10, 0, 320)
StatusLabel.Size = UDim2.new(0, 580, 0, 20)
StatusLabel.Font = Enum.Font.GothamBold
StatusLabel.Text = "❤️ HEART CLIENT v3 ACTIVE"
StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
StatusLabel.TextSize = 12
StatusLabel.TextXAlignment = Enum.TextXAlignment.Center

-- ============================================
-- ЛОГИКА ОТКРЫТИЯ/ЗАКРЫТИЯ (Left Alt)
-- ============================================
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.LeftAlt then
        GUIEnabled = not GUIEnabled
        MainFrame.Visible = GUIEnabled
        if GUIEnabled then
            StatusLabel.Text = "❤️ МЕНЮ ОТКРЫТО"
        else
            StatusLabel.Text = "❤️ МЕНЮ ЗАКРЫТО"
        end
    end
end)

-- ============================================
-- ЛОГИКА ХИТБОКСОВ
-- ============================================
local function UpdateHitboxes()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= Player and player.Character then
            local head = player.Character:FindFirstChild("Head")
            if head then
                if Settings.HitboxEnabled then
                    head.Size = Vector3.new(Settings.HeadSize, Settings.HeadSize, Settings.HeadSize)
                    head.Transparency = 0.5
                    head.BrickColor = BrickColor.new("Really red")
                    head.Material = Enum.Material.Neon
                    head.CanCollide = false
                else
                    head.Size = Vector3.new(2, 2, 1)
                    head.Transparency = 0
                    head.BrickColor = BrickColor.new("White")
                    head.Material = Enum.Material.Plastic
                    head.CanCollide = true
                end
            end
        end
    end
end

-- ============================================
-- ПОКАЗ ХИТБОКСОВ
-- ============================================
local function ShowHitboxesESP()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= Player and player.Character then
            local head = player.Character:FindFirstChild("Head")
            if head then
                if Settings.ShowHitboxes then
                    local box = Instance.new("BoxHandleAdornment")
                    box.Parent = head
                    box.Adornee = head
                    box.Size = head.Size
                    box.Color3 = Color3.fromRGB(255, 0, 0)
                    box.Transparency = 0.5
                    box.ZIndex = 10
                    box.Name = "HitboxESP"
                    for _, child in ipairs(head:GetChildren()) do
                        if child.Name == "HitboxESP" and child ~= box then
                            child:Destroy()
                        end
                    end
                else
                    for _, child in ipairs(head:GetChildren()) do
                        if child.Name == "HitboxESP" then
                            child:Destroy()
                        end
                    end
                end
            end
        end
    end
end

-- ============================================
-- ОБРАБОТЧИКИ КНОПОК
-- ============================================
HitboxToggle.MouseButton1Click:Connect(function()
    Settings.HitboxEnabled = not Settings.HitboxEnabled
    HitboxToggle.Text = Settings.HitboxEnabled and "ВКЛ" or "ВЫКЛ"
    HitboxToggle.BackgroundColor3 = Settings.HitboxEnabled and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(255, 51, 102)
    UpdateHitboxes()
end)

ShowHitboxToggle.MouseButton1Click:Connect(function()
    Settings.ShowHitboxes = not Settings.ShowHitboxes
    ShowHitboxToggle.Text = Settings.ShowHitboxes and "СКРЫТЬ" or "ПОКАЗАТЬ"
    ShowHitboxToggle.BackgroundColor3 = Settings.ShowHitboxes and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(40, 40, 60)
    ShowHitboxesESP()
end)

-- ============================================
-- СЛАЙДЕРЫ
-- ============================================
local hitboxDragging = false
HitboxSlider.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        hitboxDragging = true
    end
end)

HitboxSlider.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        hitboxDragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and hitboxDragging then
        local mousePos = UserInputService:GetMouseLocation()
        local sliderAbsPos = HitboxSlider.AbsolutePosition
        local sliderSize = HitboxSlider.AbsoluteSize.X
        local percent = math.clamp((mousePos.X - sliderAbsPos.X) / sliderSize, 0, 1)
        Settings.HeadSize = math.floor(percent * 999 + 1)
        HitboxSliderFill.Size = UDim2.new(percent, 0, 1, 0)
        HitboxValueLabel.Text = tostring(Settings.HeadSize)
        if Settings.HitboxEnabled then
            UpdateHitboxes()
        end
        if Settings.ShowHitboxes then
            ShowHitboxesESP()
        end
    end
end)

-- ============================================
-- ОСНОВНОЙ ЦИКЛ
-- ============================================
RunService.RenderStepped:Connect(function()
    if Settings.HitboxEnabled then
        UpdateHitboxes()
    end
    if Settings.ShowHitboxes then
        ShowHitboxesESP()
    end
end)

Players.PlayerAdded:Connect(function()
    task.wait(0.5)
    if Settings.HitboxEnabled then
        UpdateHitboxes()
    end
    if Settings.ShowHitboxes then
        ShowHitboxesESP()
    end
end)

print("❤️ HEART CLIENT v3 ЗАГРУЖЕН!")
print("🎯 ХИТБОКСЫ (ГОЛОВА) до 1000")
print("🎨 ВЫБОР СКИНА И ПРИМЕНЕНИЕ")
print("⭐ ДОБАВЛЕНИЕ XP И УРОВНЯ")
print("⌨️ Left Alt - открыть/закрыть меню")
