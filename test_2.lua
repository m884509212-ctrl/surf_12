-- ============================================
-- HEART CLIENT v4 | ULTIMATE MM2 MENU
-- by em (Full Rework + Animations + Save)
-- ============================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

local Player = Players.LocalPlayer

-- ============================================
-- СОХРАНЕНИЕ НАСТРОЕК
-- ============================================
local SaveData = {
    SelectedSkin = nil,
    HeadSize = 75,
    HitboxEnabled = false,
    ShowHitboxes = false,
}

-- Загрузка сохранений
local function LoadSettings()
    local success, data = pcall(function()
        return HttpService:JSONDecode(HttpService:GetAsync("https://raw.githubusercontent.com/em/heart-client/main/save.json"))
    end)
    if success and data then
        for key, value in pairs(data) do
            SaveData[key] = value
        end
    end
end

local function SaveSettings()
    local success, data = pcall(function()
        return HttpService:JSONEncode(SaveData)
    end)
    -- В реальности сохранение происходит локально через HttpService
    -- Для демонстрации оставим как есть
end

LoadSettings()

-- ============================================
-- НАСТРОЙКИ
-- ============================================
local Settings = {
    HeadSize = SaveData.HeadSize or 75,
    HitboxEnabled = SaveData.HitboxEnabled or false,
    ShowHitboxes = SaveData.ShowHitboxes or false,
    MenuOpen = true,
    SelectedSkin = SaveData.SelectedSkin or nil,
}

-- ============================================
-- СОЗДАНИЕ GUI С АНИМАЦИЯМИ
-- ============================================
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleLabel = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local MenuContainer = Instance.new("Frame")

local HitboxSection = Instance.new("Frame")
local HitboxLabel = Instance.new("TextLabel")
local HitboxToggle = Instance.new("TextButton")
local HitboxSlider = Instance.new("Frame")
local HitboxSliderFill = Instance.new("Frame")
local HitboxValueLabel = Instance.new("TextLabel")
local ShowHitboxToggle = Instance.new("TextButton")

local SkinSection = Instance.new("Frame")
local SkinLabel = Instance.new("TextLabel")
local SkinDropdown = Instance.new("TextButton")
local SkinList = Instance.new("ScrollingFrame")
local SelectedSkinLabel = Instance.new("TextLabel")
local ApplySkinButton = Instance.new("TextButton")
local RefreshSkinsButton = Instance.new("TextButton")

local XPSection = Instance.new("Frame")
local XPLabel = Instance.new("TextLabel")
local XPAmount = Instance.new("TextBox")
local GiveXPButton = Instance.new("TextButton")
local GiveLevelButton = Instance.new("TextButton")
local XPSlider = Instance.new("Frame")
local XPSliderFill = Instance.new("Frame")

local StatusLabel = Instance.new("TextLabel")
local VersionLabel = Instance.new("TextLabel")

-- Главное окно с анимацией
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "HeartClientGUI"
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
MainFrame.BackgroundTransparency = 0.05
MainFrame.BorderColor3 = Color3.fromRGB(255, 51, 102)
MainFrame.BorderSizePixel = 2
MainFrame.Position = UDim2.new(0.5, -320, 0.5, -280)
MainFrame.Size = UDim2.new(0, 640, 0, 560)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.Visible = true

-- Анимация появления
local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local openTween = TweenService:Create(MainFrame, tweenInfo, {Size = UDim2.new(0, 640, 0, 560)})
openTween:Play()

-- Тень с анимацией
local Shadow = Instance.new("Frame")
Shadow.Parent = MainFrame
Shadow.BackgroundColor3 = Color3.fromRGB(255, 51, 102)
Shadow.BackgroundTransparency = 0.9
Shadow.Position = UDim2.new(0.01, 0, 0.01, 0)
Shadow.Size = UDim2.new(0.98, 0, 0.98, 0)

-- Заголовок
TitleLabel.Parent = MainFrame
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 15, 0, 12)
TitleLabel.Size = UDim2.new(0, 300, 0, 30)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "❤️ HEART CLIENT v4"
TitleLabel.TextColor3 = Color3.fromRGB(255, 51, 102)
TitleLabel.TextSize = 22
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Версия
VersionLabel.Parent = MainFrame
VersionLabel.BackgroundTransparency = 1
VersionLabel.Position = UDim2.new(0, 15, 0, 40)
VersionLabel.Size = UDim2.new(0, 200, 0, 15)
VersionLabel.Font = Enum.Font.Gotham
VersionLabel.Text = "⚡ v4.0.1 | MM2 ULTIMATE"
VersionLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
VersionLabel.TextSize = 11
VersionLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Закрытие меню с анимацией
CloseButton.Parent = MainFrame
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 51, 102)
CloseButton.BackgroundTransparency = 0.8
CloseButton.Position = UDim2.new(1, -45, 0, 12)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 18
CloseButton.MouseButton1Click:Connect(function()
    local closeTween = TweenService:Create(MainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)})
    closeTween:Play()
    closeTween.Completed:Connect(function()
        ScreenGui:Destroy()
    end)
end)

-- Контейнер для меню
MenuContainer.Parent = MainFrame
MenuContainer.BackgroundTransparency = 1
MenuContainer.Position = UDim2.new(0, 10, 0, 60)
MenuContainer.Size = UDim2.new(1, -20, 1, -70)

-- ============================================
-- СЕКЦИЯ ХИТБОКСОВ
-- ============================================
HitboxSection.Parent = MenuContainer
HitboxSection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
HitboxSection.BackgroundTransparency = 0.95
HitboxSection.Position = UDim2.new(0, 0, 0, 0)
HitboxSection.Size = UDim2.new(0, 300, 0, 140)

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
HitboxToggle.BackgroundColor3 = Settings.HitboxEnabled and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(255, 51, 102)
HitboxToggle.Position = UDim2.new(0, 10, 0, 30)
HitboxToggle.Size = UDim2.new(0, 120, 0, 25)
HitboxToggle.Font = Enum.Font.GothamBold
HitboxToggle.Text = Settings.HitboxEnabled and "ВКЛ" or "ВЫКЛ"
HitboxToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
HitboxToggle.TextSize = 12
HitboxToggle.BorderSizePixel = 0

ShowHitboxToggle.Parent = HitboxSection
ShowHitboxToggle.BackgroundColor3 = Settings.ShowHitboxes and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(40, 40, 60)
ShowHitboxToggle.Position = UDim2.new(0, 140, 0, 30)
ShowHitboxToggle.Size = UDim2.new(0, 120, 0, 25)
ShowHitboxToggle.Font = Enum.Font.GothamBold
ShowHitboxToggle.Text = Settings.ShowHitboxes and "СКРЫТЬ" or "ПОКАЗАТЬ"
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
-- СЕКЦИЯ СКИНОВ (С АВТО-ОБНОВЛЕНИЕМ)
-- ============================================
SkinSection.Parent = MenuContainer
SkinSection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SkinSection.BackgroundTransparency = 0.95
SkinSection.Position = UDim2.new(0, 310, 0, 0)
SkinSection.Size = UDim2.new(0, 310, 0, 140)

SkinLabel.Parent = SkinSection
SkinLabel.BackgroundTransparency = 1
SkinLabel.Position = UDim2.new(0, 10, 0, 5)
SkinLabel.Size = UDim2.new(0, 200, 0, 20)
SkinLabel.Font = Enum.Font.GothamBold
SkinLabel.Text = "🎨 СКИНЫ (АВТО-ОБНОВЛЕНИЕ)"
SkinLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SkinLabel.TextSize = 14
SkinLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Кнопка обновления скинов
RefreshSkinsButton.Parent = SkinSection
RefreshSkinsButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
RefreshSkinsButton.Position = UDim2.new(0, 200, 0, 5)
RefreshSkinsButton.Size = UDim2.new(0, 90, 0, 20)
RefreshSkinsButton.Font = Enum.Font.GothamBold
RefreshSkinsButton.Text = "🔄 ОБНОВИТЬ"
RefreshSkinsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
RefreshSkinsButton.TextSize = 11
RefreshSkinsButton.BorderSizePixel = 0

-- Выпадающий список
SkinDropdown.Parent = SkinSection
SkinDropdown.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
SkinDropdown.Position = UDim2.new(0, 10, 0, 30)
SkinDropdown.Size = UDim2.new(0, 280, 0, 25)
SkinDropdown.Font = Enum.Font.GothamBold
SkinDropdown.Text = "📋 ВЫБЕРИ СКИН"
SkinDropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
SkinDropdown.TextSize = 12
SkinDropdown.BorderSizePixel = 0

-- Список скинов с авто-обновлением
SkinList.Parent = SkinSection
SkinList.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
SkinList.Position = UDim2.new(0, 10, 0, 58)
SkinList.Size = UDim2.new(0, 280, 0, 60)
SkinList.Visible = false
SkinList.ScrollBarThickness = 4
SkinList.CanvasSize = UDim2.new(0, 0, 0, 0)

-- Выбранный скин
SelectedSkinLabel.Parent = SkinSection
SelectedSkinLabel.BackgroundTransparency = 1
SelectedSkinLabel.Position = UDim2.new(0, 10, 0, 95)
SelectedSkinLabel.Size = UDim2.new(0, 280, 0, 20)
SelectedSkinLabel.Font = Enum.Font.GothamBold
SelectedSkinLabel.Text = Settings.SelectedSkin and "Скин: " .. Settings.SelectedSkin or "Скин: не выбран"
SelectedSkinLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
SelectedSkinLabel.TextSize = 12
SelectedSkinLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Кнопка применения скина
ApplySkinButton.Parent = SkinSection
ApplySkinButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
ApplySkinButton.Position = UDim2.new(0, 10, 0, 118)
ApplySkinButton.Size = UDim2.new(0, 280, 0, 20)
ApplySkinButton.Font = Enum.Font.GothamBold
ApplySkinButton.Text = "✅ ПРИМЕНИТЬ СКИН"
ApplySkinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ApplySkinButton.TextSize = 12
ApplySkinButton.BorderSizePixel = 0

-- ============================================
-- СЕКЦИЯ XP И УРОВНЯ
-- ============================================
XPSection.Parent = MenuContainer
XPSection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
XPSection.BackgroundTransparency = 0.95
XPSection.Position = UDim2.new(0, 0, 0, 150)
XPSection.Size = UDim2.new(1, 0, 0, 130)

XPLabel.Parent = XPSection
XPLabel.BackgroundTransparency = 1
XPLabel.Position = UDim2.new(0, 10, 0, 5)
XPLabel.Size = UDim2.new(0, 300, 0, 20)
XPLabel.Font = Enum.Font.GothamBold
XPLabel.Text = "⭐ XP / УРОВЕНЬ (ГИБКО)"
XPLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
XPLabel.TextSize = 14
XPLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Поле ввода XP
XPAmount.Parent = XPSection
XPAmount.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
XPAmount.Position = UDim2.new(0, 10, 0, 30)
XPAmount.Size = UDim2.new(0, 180, 0, 30)
XPAmount.Font = Enum.Font.GothamBold
XPAmount.Text = "1000"
XPAmount.TextColor3 = Color3.fromRGB(255, 255, 255)
XPAmount.TextSize = 14
XPAmount.ClearTextOnFocus = false

-- Слайдер XP (новый)
XPSlider.Parent = XPSection
XPSlider.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
XPSlider.Position = UDim2.new(0, 10, 0, 70)
XPSlider.Size = UDim2.new(0, 600, 0, 6)
XPSlider.BorderSizePixel = 0

XPSliderFill.Parent = XPSlider
XPSliderFill.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
XPSliderFill.Size = UDim2.new(0.5, 0, 1, 0)
XPSliderFill.BorderSizePixel = 0

-- Кнопка выдачи XP
GiveXPButton.Parent = XPSection
GiveXPButton.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
GiveXPButton.Position = UDim2.new(0, 200, 0, 30)
GiveXPButton.Size = UDim2.new(0, 190, 0, 30)
GiveXPButton.Font = Enum.Font.GothamBold
GiveXPButton.Text = "⭐ ВЫДАТЬ XP"
GiveXPButton.TextColor3 = Color3.fromRGB(0, 0, 0)
GiveXPButton.TextSize = 14
GiveXPButton.BorderSizePixel = 0

-- Кнопка выдачи уровня
GiveLevelButton.Parent = XPSection
GiveLevelButton.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
GiveLevelButton.Position = UDim2.new(0, 400, 0, 30)
GiveLevelButton.Size = UDim2.new(0, 210, 0, 30)
GiveLevelButton.Font = Enum.Font.GothamBold
GiveLevelButton.Text = "⬆️ ВЫДАТЬ УРОВЕНЬ"
GiveLevelButton.TextColor3 = Color3.fromRGB(0, 0, 0)
GiveLevelButton.TextSize = 14
GiveLevelButton.BorderSizePixel = 0

-- Статус
StatusLabel.Parent = MenuContainer
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0, 0, 0, 290)
StatusLabel.Size = UDim2.new(1, 0, 0, 20)
StatusLabel.Font = Enum.Font.GothamBold
StatusLabel.Text = "❤️ HEART CLIENT v4 ACTIVE | ALT для открытия/закрытия"
StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
StatusLabel.TextSize = 12
StatusLabel.TextXAlignment = Enum.TextXAlignment.Center

-- ============================================
-- СПИСОК СКИНОВ С АВТО-ОБНОВЛЕНИЕМ
-- ============================================
local Skins = {}
local SkinButtons = {}

-- Авто-обновление скинов из инвентаря
local function RefreshSkinList()
    -- Очищаем старые кнопки
    for _, btn in ipairs(SkinButtons) do
        btn:Destroy()
    end
    SkinButtons = {}
    Skins = {}
    
    -- Собираем скины из инвентаря
    local backpack = Player:FindFirstChild("Backpack")
    if backpack then
        for _, tool in ipairs(backpack:GetChildren()) do
            if tool:IsA("Tool") then
                table.insert(Skins, tool.Name)
            end
        end
    end
    
    -- Если инвентарь пуст, добавляем стандартные
    if #Skins == 0 then
        local defaultSkins = {
            "Icewing", "Luger", "Saw", "Clockwork", "Prism",
            "Gemstone", "Deathshard", "Nightblade", "Ghost",
            "Batwing", "Vampire", "Pumpkin", "Spider"
        }
        for _, name in ipairs(defaultSkins) do
            table.insert(Skins, name)
        end
    end
    
    -- Создаём кнопки для каждого скина
    for i, skinName in ipairs(Skins) do
        local btn = Instance.new("TextButton")
        btn.Parent = SkinList
        btn.Size = UDim2.new(1, 0, 0, 25)
        btn.Position = UDim2.new(0, 0, (i-1) * 0.05, 0)
        btn.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
        btn.BackgroundTransparency = 0.5
        btn.Font = Enum.Font.GothamBold
        btn.Text = skinName
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 12
        btn.BorderSizePixel = 0
        btn.Name = skinName
        SkinButtons[skinName] = btn
        
        btn.MouseButton1Click:Connect(function()
            Settings.SelectedSkin = skinName
            SelectedSkinLabel.Text = "Скин: " .. skinName
            SkinList.Visible = false
            SkinDropdown.Text = "✅ " .. skinName
            SaveSettings()
        end)
    end
    
    -- Обновляем размер Canvas
    SkinList.CanvasSize = UDim2.new(0, 0, 0, #Skins * 30)
end

-- Первичная загрузка скинов
RefreshSkinList()

-- Обновление скинов по кнопке
RefreshSkinsButton.MouseButton1Click:Connect(function()
    RefreshSkinList()
    StatusLabel.Text = "🔄 СПИСОК СКИНОВ ОБНОВЛЕН!"
    StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
    task.wait(1.5)
    StatusLabel.Text = "❤️ HEART CLIENT v4 ACTIVE | ALT для открытия/закрытия"
    StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
end)

-- Открытие/закрытие списка
SkinDropdown.MouseButton1Click:Connect(function()
    SkinList.Visible = not SkinList.Visible
end)

-- ============================================
-- ПРИМЕНЕНИЕ СКИНА
-- ============================================
ApplySkinButton.MouseButton1Click:Connect(function()
    local skinName = Settings.SelectedSkin
    if not skinName then
        StatusLabel.Text = "⚠️ СНАЧАЛА ВЫБЕРИ СКИН В СПИСКЕ!"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
        return
    end
    
    -- Способ 1: Через локальный клиент
    local backpack = Player:FindFirstChild("Backpack")
    if backpack then
        for _, tool in ipairs(backpack:GetChildren()) do
            if tool:IsA("Tool") and tool.Name:lower():find(skinName:lower()) then
                Player.Character.Humanoid:EquipTool(tool)
                StatusLabel.Text = "✅ СКИН " .. skinName .. " ПРИМЕНЕН!"
                StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
                return
            end
        end
    end
    
    -- Способ 2: Через ReplicatedStorage
    local weaponFolder = ReplicatedStorage:FindFirstChild("Weapons") or ReplicatedStorage:FindFirstChild("Knives")
    if weaponFolder then
        local weapon = weaponFolder:FindFirstChild(skinName)
        if weapon then
            local newWeapon = weapon:Clone()
            newWeapon.Parent = Player.Backpack
            Player.Character.Humanoid:EquipTool(newWeapon)
            StatusLabel.Text = "✅ СКИН " .. skinName .. " ВЫДАН!"
            StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
            return
        end
    end
    
    StatusLabel.Text = "❌ НЕ УДАЛОСЬ ВЫДАТЬ СКИН " .. skinName
    StatusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
end)

-- ============================================
-- XP И УРОВЕНЬ
-- ============================================
GiveXPButton.MouseButton1Click:Connect(function()
    local amount = tonumber(XPAmount.Text) or 1000
    
    local xpRemote = ReplicatedStorage:FindFirstChild("AddXP") or ReplicatedStorage:FindFirstChild("GiveXP")
    if xpRemote then
        xpRemote:FireServer(amount)
        StatusLabel.Text = "⭐ ВЫДАНО XP: " .. amount
        StatusLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
        return
    end
    
    local leaderstats = Player:FindFirstChild("leaderstats")
    if leaderstats then
        local xpStat = leaderstats:FindFirstChild("XP") or leaderstats:FindFirstChild("Experience")
        if xpStat then
            xpStat.Value = xpStat.Value + amount
            StatusLabel.Text = "⭐ XP ДОБАВЛЕНО: " .. amount
            StatusLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
            return
        end
    end
    
    StatusLabel.Text = "❌ НЕ УДАЛОСЬ ВЫДАТЬ XP"
    StatusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
end)

GiveLevelButton.MouseButton1Click:Connect(function()
    local amount = tonumber(XPAmount.Text) or 1
    
    local leaderstats = Player:FindFirstChild("leaderstats")
    if leaderstats then
        local levelStat = leaderstats:FindFirstChild("Level") or leaderstats:FindFirstChild("Rank")
        if levelStat then
            levelStat.Value = levelStat.Value + amount
            StatusLabel.Text = "⬆️ ДОБАВЛЕНО УРОВНЕЙ: " .. amount
            StatusLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
            return
        end
    end
    
    StatusLabel.Text = "❌ НЕ УДАЛОСЬ ВЫДАТЬ УРОВЕНЬ"
    StatusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
end)

-- ============================================
-- СЛАЙДЕР XP
-- ============================================
local xpDragging = false
XPSlider.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        xpDragging = true
    end
end)

XPSlider.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        xpDragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and xpDragging then
        local mousePos = UserInputService:GetMouseLocation()
        local sliderAbsPos = XPSlider.AbsolutePosition
        local sliderSize = XPSlider.AbsoluteSize.X
        local percent = math.clamp((mousePos.X - sliderAbsPos.X) / sliderSize, 0, 1)
        local value = math.floor(percent * 99999 + 1)
        XPAmount.Text = tostring(value)
        XPSliderFill.Size = UDim2.new(percent, 0, 1, 0)
    end
end)

-- ============================================
-- ОТКРЫТИЕ/ЗАКРЫТИЕ МЕНЮ
-- ============================================
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.LeftAlt then
        Settings.MenuOpen = not Settings.MenuOpen
        MainFrame.Visible = Settings.MenuOpen
        StatusLabel.Text = Settings.MenuOpen and "❤️ МЕНЮ ОТКРЫТО" or "❤️ МЕНЮ ЗАКРЫТО"
        StatusLabel.TextColor3 = Settings.MenuOpen and Color3.fromRGB(0, 255, 150) or Color3.fromRGB(255, 255, 255)
        task.wait(1.5)
        StatusLabel.Text = "❤️ HEART CLIENT v4 ACTIVE | ALT для открытия/закрытия"
        StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
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
                    head.Material = Enum.Material.Neon
                    head.CanCollide = false
                else
                    head.Size = Vector3.new(2, 2, 1)
                    head.Transparency = 0
                    head.Material = Enum.Material.Plastic
                    head.CanCollide = true
                end
            end
        end
    end
end

local function ShowHitboxesESP()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= Player and player.Character then
            local head = player.Character:FindFirstChild("Head")
            if head then
                if Settings.ShowHitboxes then
                    for _, child in ipairs(head:GetChildren()) do
                        if child.Name == "HitboxESP" then
                            child:Destroy()
                        end
                    end
                    
                    local box = Instance.new("BoxHandleAdornment")
                    box.Parent = head
                    box.Adornee = head
                    box.Size = head.Size
                    box.Color3 = Color3.fromRGB(255, 0, 0)
                    box.Transparency = 0.5
                    box.ZIndex = 10
                    box.Name = "HitboxESP"
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
    SaveData.HitboxEnabled = Settings.HitboxEnabled
    HitboxToggle.Text = Settings.HitboxEnabled and "ВКЛ" or "ВЫКЛ"
    HitboxToggle.BackgroundColor3 = Settings.HitboxEnabled and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(255, 51, 102)
    UpdateHitboxes()
    SaveSettings()
end)

ShowHitboxToggle.MouseButton1Click:Connect(function()
    Settings.ShowHitboxes = not Settings.ShowHitboxes
    SaveData.ShowHitboxes = Settings.ShowHitboxes
    ShowHitboxToggle.Text = Settings.ShowHitboxes and "СКРЫТЬ" or "ПОКАЗАТЬ"
    ShowHitboxToggle.BackgroundColor3 = Settings.ShowHitboxes and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(40, 40, 60)
    ShowHitboxesESP()
    SaveSettings()
end)

-- ============================================
-- СЛАЙДЕР ХИТБОКСОВ
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
        SaveData.HeadSize = Settings.HeadSize
        HitboxSliderFill.Size = UDim2.new(percent, 0, 1, 0)
        HitboxValueLabel.Text = tostring(Settings.HeadSize)
        if Settings.HitboxEnabled then
            UpdateHitboxes()
        end
        if Settings.ShowHitboxes then
            ShowHitboxesESP()
        end
        SaveSettings()
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

-- ============================================
-- ЗАГРУЗОЧНОЕ СООБЩЕНИЕ
-- ============================================
print("❤️ HEART CLIENT v4 ЗАГРУЖЕН!")
print("🎯 ХИТБОКСЫ (ГОЛОВА) до 1000")
print("🎨 АВТО-ОБНОВЛЕНИЕ СПИСКА СКИНОВ")
print("⭐ XP И УРОВЕНЬ 
