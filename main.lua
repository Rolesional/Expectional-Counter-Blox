local function GetExecutorName()
if identifyexecutor then
local success, name = pcall(identifyexecutor)
if success and name then return name end
end
if getexecutorname then
local success, name = pcall(getexecutorname)
if success and name then return name end
end
if syn and syn.request then return "Synapse X" end
if is_synapse_function or syn_checkcaller then return "Synapse X" end
if Xeno or XENO_LOADED or (xeno and xeno.is_loaded) then return "Xeno" end
if Solara or SOLARA_LOADED then return "Solara" end
if is_sirhurt_closure or SCRIPT_WARE_LOADED then return "Script-Ware" end
if SIRHURT_LOADED or sirhurt then return "SirHurt" end
if KRNL_LOADED or is_krnl_function then return "KRNL" end
if fluxus or FLUXUS_LOADED or getgenv().Fluxus then return "Fluxus" end
if is_electron_function or electron then return "Electron" end
if delta or DELTA_LOADED then return "Delta" end
if Wave or WAVE_LOADED or getgenv().Wave then return "Wave" end
if Arceus or ARCEUS_LOADED then return "Arceus X" end
if codex or CODEX_LOADED then return "Codex" end
if hydrogen or HYDROGEN_LOADED then return "Hydrogen" end
if JJSPLOIT_LOADED or jjsploit then return "JJSploit" end
if OXYGEN_LOADED or Oxygen then return "Oxygen U" end
if TRIGON_LOADED or Trigon then return "Trigon" end
if EVON_LOADED or Evon then return "Evon" end
if Drawing and mousemoverel then return "Unknown Executor" end
return "Unsupported Executor"
end

local ExecutorName = GetExecutorName()
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("🚀 Detected Executor: " .. ExecutorName)
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")

local Players = game:GetService("Players")
local Teams = game:GetService("Teams")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

wait(1)

local ConfigFolder = "EXPECTIONALCBRO"
local ConfigsFolder = ConfigFolder .. "/configs"

local Config = {
    -- AIMBOT
    AimbotEnabled = false,
    FOV = 300,
    Smoothness = 5,
    ShowFOV = true,
    WallCheck = false,
    AimKey = Enum.KeyCode.E,
    HoldToAim = true,
    EnemiesOnly = true,
    AimPart = "Head",

    -- SPRAY CONTROL
    SprayControlEnabled = false,
    SprayStrength = 1.0,
    SpraySmoothing = 0.7,

    -- VISUALS
    ESPEnabled = true,
    BoxESP = true,
    NameESP = true,
    DistanceESP = true,
    TracerESP = true,
    HealthESP = true,
    ChamsEnabled = false,
    ShowTeammates = true,

    -- COLORS
    EnemyColor = Color3.fromRGB(255, 100, 100),
    TeamColor = Color3.fromRGB(100, 255, 100),
    NeutralColor = Color3.fromRGB(200, 200, 200),

    -- MISC
    MenuVisible = true,
    MenuKey = Enum.KeyCode.F5,
    WallbangEnabled = false,
    DebugMode = true,

    -- THEME
    AccentColor = Color3.fromRGB(89, 119, 239),
    BackgroundColor = Color3.fromRGB(17, 17, 17),
    SecondaryColor = Color3.fromRGB(25, 25, 25),
    TextColor = Color3.fromRGB(200, 200, 200),
    ActiveColor = Color3.fromRGB(89, 119, 239),
}

local ESPObjects = {}
local currentTab = "AIMBOT"
local currentConfigName = nil
local availableConfigs = {}

local sprayStartTime = 0
local isShooting = false
local sprayBulletCount = 0

local AK47_SPRAY_PATTERN = {
    {x = 0, y = -30},
    {x = 0, y = -35},
    {x = 0, y = -40},
    {x = 0, y = -42},
    {x = 0, y = -44},
    {x = 0, y = -45},
    {x = 2, y = -46},
    {x = 4, y = -46},
    {x = 6, y = -45},
    {x = 8, y = -44},
    {x = 6, y = -43},
    {x = 4, y = -42},
    {x = 2, y = -41},
    {x = -2, y = -40},
    {x = -4, y = -39},
    {x = -6, y = -38},
    {x = -8, y = -37},
    {x = -10, y = -36},
    {x = -8, y = -35},
    {x = -6, y = -34},
    {x = -4, y = -33},
    {x = -2, y = -32},
    {x = 2, y = -31},
    {x = 4, y = -30},
    {x = 6, y = -29},
    {x = 8, y = -28},
    {x = 6, y = -27},
    {x = 4, y = -26},
    {x = 2, y = -25},
    {x = 0, y = -24},
}

local function DebugPrint(category, ...)
    if not Config.DebugMode then return end
    local args = {...}
    local message = ""
    for i, v in ipairs(args) do
        message = message .. tostring(v)
        if i < #args then message = message .. " " end
    end
    print("[" .. category .. "]", message)
end

local function GetFileName(path)
    return path:match("([^/\\]+)$") or path:match("([^/]+)$") or path:match("([^\\]+)$") or path
end

local function GetConfigPath(configName)
    return ConfigsFolder .. "/" .. configName .. ".json"
end

local function RefreshConfigList()
    availableConfigs = {}

    if not isfolder or not listfiles then 
        DebugPrint("CONFIG", "⚠️ File system not available")
        return availableConfigs 
    end

    if not isfolder(ConfigFolder) then 
        makefolder(ConfigFolder) 
    end
    if not isfolder(ConfigsFolder) then 
        makefolder(ConfigsFolder) 
    end

    local success, files = pcall(function()
        return listfiles(ConfigsFolder)
    end)

    if not success then 
        DebugPrint("CONFIG", "❌ Failed to list files")
        return availableConfigs 
    end

    for _, filePath in pairs(files) do
        local fileName = GetFileName(filePath)
        if fileName and fileName:match("%.json$") then
            local configName = fileName:gsub("%.json$", "")
            table.insert(availableConfigs, configName)
        end
    end

    DebugPrint("CONFIG", "📂 Found", #availableConfigs, "configs")
    return availableConfigs
end

local function SaveConfig(configName)
    if not isfolder or not writefile then
        warn("❌ File functions not available")
        return false
    end

    if not isfolder(ConfigFolder) then makefolder(ConfigFolder) end
    if not isfolder(ConfigsFolder) then makefolder(ConfigsFolder) end

    local configData = {
        -- AIMBOT
        AimbotEnabled = Config.AimbotEnabled,
        FOV = Config.FOV,
        Smoothness = Config.Smoothness,
        ShowFOV = Config.ShowFOV,
        WallCheck = Config.WallCheck,
        AimKey = Config.AimKey.Name,
        HoldToAim = Config.HoldToAim,
        EnemiesOnly = Config.EnemiesOnly,
        AimPart = Config.AimPart,
        
        -- SPRAY
        SprayControlEnabled = Config.SprayControlEnabled,
        SprayStrength = Config.SprayStrength,
        SpraySmoothing = Config.SpraySmoothing,
        
        -- VISUALS
        ESPEnabled = Config.ESPEnabled,
        BoxESP = Config.BoxESP,
        NameESP = Config.NameESP,
        DistanceESP = Config.DistanceESP,
        TracerESP = Config.TracerESP,
        HealthESP = Config.HealthESP,
        ChamsEnabled = Config.ChamsEnabled,
        ShowTeammates = Config.ShowTeammates,
        
        -- MISC
        DebugMode = Config.DebugMode,
        MenuKey = Config.MenuKey.Name,
        WallbangEnabled = Config.WallbangEnabled,
        
        Version = "2.0"
    }

    local success, err = pcall(function()
        local jsonData = HttpService:JSONEncode(configData)
        writefile(GetConfigPath(configName), jsonData)
    end)

    if success then
        currentConfigName = configName
        RefreshConfigList()
        DebugPrint("CONFIG", "✅ Saved:", configName)
        return true
    else
        warn("❌ Config save error:", err)
        return false
    end
end

local function LoadConfig(configName)
    if not isfile or not readfile then
        warn("❌ File functions not available")
        return false
    end

    local configPath = GetConfigPath(configName)
    if not isfile(configPath) then 
        warn("❌ Config not found:", configPath)
        return false 
    end

    local success, configData = pcall(function()
        local jsonData = readfile(configPath)
        return HttpService:JSONDecode(jsonData)
    end)

    if not success then 
        warn("❌ Config load error")
        return false 
    end

    Config.AimbotEnabled = configData.AimbotEnabled or false
    Config.FOV = configData.FOV or 300
    Config.Smoothness = configData.Smoothness or 5
    Config.ShowFOV = configData.ShowFOV ~= false
    Config.WallCheck = configData.WallCheck or false
    Config.AimKey = Enum.KeyCode[configData.AimKey] or Enum.KeyCode.E
    Config.HoldToAim = configData.HoldToAim ~= false
    Config.EnemiesOnly = configData.EnemiesOnly ~= false
    Config.AimPart = configData.AimPart or "Head"

    Config.SprayControlEnabled = configData.SprayControlEnabled or false
    Config.SprayStrength = configData.SprayStrength or 1.0
    Config.SpraySmoothing = configData.SpraySmoothing or 0.7

    Config.ESPEnabled = configData.ESPEnabled ~= false
    Config.BoxESP = configData.BoxESP ~= false
    Config.NameESP = configData.NameESP ~= false
    Config.DistanceESP = configData.DistanceESP ~= false
    Config.TracerESP = configData.TracerESP ~= false
    Config.HealthESP = configData.HealthESP ~= false
    Config.ChamsEnabled = configData.ChamsEnabled or false
    Config.ShowTeammates = configData.ShowTeammates ~= false

    Config.DebugMode = configData.DebugMode ~= false
    Config.MenuKey = Enum.KeyCode[configData.MenuKey] or Enum.KeyCode.F5
    Config.WallbangEnabled = configData.WallbangEnabled or false

    currentConfigName = configName
    DebugPrint("CONFIG", "✅ Loaded:", configName)
    return true
end

local function DeleteConfig(configName)
    if not delfile or not isfile then return false end
    local configPath = GetConfigPath(configName)
    if isfile(configPath) then
        delfile(configPath)
        if currentConfigName == configName then currentConfigName = nil end
        RefreshConfigList()
        DebugPrint("CONFIG", "🗑️ Deleted:", configName)
        return true
    end
    return false
end

-- ROBLOX TEAM SYSTEM
local function GetPlayerTeam(player)
    local success, result = pcall(function()
        return player.Team
    end)
    return success and result or nil
end

local function IsSameTeam(player1, player2)
    local team1 = GetPlayerTeam(player1)
    local team2 = GetPlayerTeam(player2)
    
    if not team1 or not team2 then return false end
    
    return team1 == team2
end

local function GetTeamColor(player)
    local team = GetPlayerTeam(player)
    
    if team and team.TeamColor then
        return team.TeamColor.Color
    end
    
    local localTeam = GetPlayerTeam(LocalPlayer)
    
    if not localTeam or not team then
        return Config.NeutralColor
    end
    
    if team == localTeam then
        return Config.TeamColor
    else
        return Config.EnemyColor
    end
end

local function ShowNotification(text, duration)
    local ScreenGui = LocalPlayer.PlayerGui:FindFirstChild("GameSenseGUI")
    if not ScreenGui then return end

    local Notif = Instance.new("Frame")
    Notif.Size = UDim2.new(0, 300, 0, 50)
    Notif.Position = UDim2.new(1, -310, 0, 100)
    Notif.BackgroundColor3 = Config.SecondaryColor
    Notif.BorderSizePixel = 0

    local NotifCorner = Instance.new("UICorner")
    NotifCorner.CornerRadius = UDim.new(0, 6)
    NotifCorner.Parent = Notif

    local NotifText = Instance.new("TextLabel")
    NotifText.Size = UDim2.new(1, -20, 1, 0)
    NotifText.Position = UDim2.new(0, 10, 0, 0)
    NotifText.BackgroundTransparency = 1
    NotifText.Font = Enum.Font.GothamBold
    NotifText.Text = text
    NotifText.TextColor3 = Config.AccentColor
    NotifText.TextSize = 13
    NotifText.TextXAlignment = Enum.TextXAlignment.Left
    NotifText.Parent = Notif

    Notif.Parent = ScreenGui
    Notif:TweenPosition(UDim2.new(1, -310, 0, 100), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)

    task.delay(duration or 3, function()
        Notif:TweenPosition(UDim2.new(1, 10, 0, 100), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.3, true, function()
            Notif:Destroy()
        end)
    end)
end

-- GUI CREATION
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GameSenseGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MainWindow = Instance.new("Frame")
MainWindow.Name = "MainWindow"
MainWindow.Size = UDim2.new(0, 700, 0, 500)
MainWindow.Position = UDim2.new(0.5, -350, 0.5, -250)
MainWindow.BackgroundColor3 = Config.BackgroundColor
MainWindow.BorderSizePixel = 0
MainWindow.Visible = Config.MenuVisible
MainWindow.Parent = ScreenGui

local MainWindowCorner = Instance.new("UICorner")
MainWindowCorner.CornerRadius = UDim.new(0, 8)
MainWindowCorner.Parent = MainWindow

local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 50)
TopBar.BackgroundColor3 = Config.SecondaryColor
TopBar.BorderSizePixel = 0
TopBar.Active = true
TopBar.Parent = MainWindow

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 8)
TopBarCorner.Parent = TopBar

local TopBarFix = Instance.new("Frame")
TopBarFix.Size = UDim2.new(1, 0, 0, 8)
TopBarFix.Position = UDim2.new(0, 0, 1, -8)
TopBarFix.BackgroundColor3 = Config.SecondaryColor
TopBarFix.BorderSizePixel = 0
TopBarFix.Parent = TopBar

local Logo = Instance.new("TextLabel")
Logo.Size = UDim2.new(0, 200, 0, 18)
Logo.Position = UDim2.new(0, 20, 0, 3)
Logo.BackgroundTransparency = 1
Logo.Font = Enum.Font.GothamBold
Logo.Text = "EXPECTIONAL - Counter Blox"
Logo.TextColor3 = Config.AccentColor
Logo.TextSize = 17
Logo.TextXAlignment = Enum.TextXAlignment.Left
Logo.Parent = TopBar

local ExecutorLabel = Instance.new("TextLabel")
ExecutorLabel.Size = UDim2.new(0, 250, 0, 14)
ExecutorLabel.Position = UDim2.new(0, 20, 0, 22)
ExecutorLabel.BackgroundTransparency = 1
ExecutorLabel.Font = Enum.Font.Gotham
ExecutorLabel.Text = "🚀 " .. ExecutorName
ExecutorLabel.TextColor3 = Color3.fromRGB(150, 200, 255)
ExecutorLabel.TextSize = 11
ExecutorLabel.TextXAlignment = Enum.TextXAlignment.Left
ExecutorLabel.Parent = TopBar

local SubLogo = Instance.new("TextLabel")
SubLogo.Size = UDim2.new(0, 200, 0, 12)
SubLogo.Position = UDim2.new(0, 20, 0, 37)
SubLogo.BackgroundTransparency = 1
SubLogo.Font = Enum.Font.Gotham
SubLogo.Text = "Coded By rolesional | Undetected"
SubLogo.TextColor3 = Config.TextColor
SubLogo.TextSize = 10
SubLogo.TextXAlignment = Enum.TextXAlignment.Left
SubLogo.Parent = TopBar

local Version = Instance.new("TextLabel")
Version.Size = UDim2.new(0, 100, 1, 0)
Version.Position = UDim2.new(1, -120, 0, 0)
Version.BackgroundTransparency = 1
Version.Font = Enum.Font.GothamBold
Version.Text = "V2 | " .. Config.MenuKey.Name
Version.TextColor3 = Config.TextColor
Version.TextSize = 12
Version.TextXAlignment = Enum.TextXAlignment.Right
Version.Parent = TopBar


local dragging = false
local dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    MainWindow.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainWindow.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TopBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)


local TabContainer = Instance.new("Frame")
TabContainer.Name = "TabContainer"
TabContainer.Size = UDim2.new(0, 180, 1, -70)
TabContainer.Position = UDim2.new(0, 10, 0, 60)
TabContainer.BackgroundColor3 = Config.SecondaryColor
TabContainer.BorderSizePixel = 0
TabContainer.Parent = MainWindow

local TabContainerCorner = Instance.new("UICorner")
TabContainerCorner.CornerRadius = UDim.new(0, 6)
TabContainerCorner.Parent = TabContainer

local TabList = Instance.new("UIListLayout")
TabList.Padding = UDim.new(0, 5)
TabList.SortOrder = Enum.SortOrder.LayoutOrder
TabList.Parent = TabContainer

local ContentArea = Instance.new("ScrollingFrame")
ContentArea.Name = "ContentArea"
ContentArea.Size = UDim2.new(0, 490, 1, -70)
ContentArea.Position = UDim2.new(0, 200, 0, 60)
ContentArea.BackgroundColor3 = Config.SecondaryColor
ContentArea.BorderSizePixel = 0
ContentArea.ScrollBarThickness = 4
ContentArea.ScrollBarImageColor3 = Config.AccentColor
ContentArea.CanvasSize = UDim2.new(0, 0, 0, 0)
ContentArea.Parent = MainWindow

local ContentAreaCorner = Instance.new("UICorner")
ContentAreaCorner.CornerRadius = UDim.new(0, 6)
ContentAreaCorner.Parent = ContentArea

local ContentList = Instance.new("UIListLayout")
ContentList.Padding = UDim.new(0, 10)
ContentList.SortOrder = Enum.SortOrder.LayoutOrder
ContentList.Parent = ContentArea

local ContentPadding = Instance.new("UIPadding")
ContentPadding.PaddingTop = UDim.new(0, 15)
ContentPadding.PaddingLeft = UDim.new(0, 15)
ContentPadding.PaddingRight = UDim.new(0, 15)
ContentPadding.PaddingBottom = UDim.new(0, 15)
ContentPadding.Parent = ContentArea

ContentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ContentArea.CanvasSize = UDim2.new(0, 0, 0, ContentList.AbsoluteContentSize.Y + 30)
end)

local function ClearContentArea()
    for _, child in pairs(ContentArea:GetChildren()) do
        if not child:IsA("UIListLayout") and not child:IsA("UIPadding") then
            child:Destroy()
        end
    end
end

local function CreateTab(name, icon)
    local TabButton = Instance.new("TextButton")
    TabButton.Name = name
    TabButton.Size = UDim2.new(1, -10, 0, 40)
    TabButton.BackgroundColor3 = currentTab == name and Config.AccentColor or Color3.fromRGB(30, 30, 30)
    TabButton.BorderSizePixel = 0
    TabButton.Font = Enum.Font.GothamSemibold
    TabButton.Text = "  " .. icon .. "  " .. name
    TabButton.TextColor3 = Color3.new(1, 1, 1)
    TabButton.TextSize = 14
    TabButton.TextXAlignment = Enum.TextXAlignment.Left
    TabButton.Parent = TabContainer

    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 4)
    TabCorner.Parent = TabButton

    local TabPadding = Instance.new("UIPadding")
    TabPadding.PaddingLeft = UDim.new(0, 10)
    TabPadding.Parent = TabButton

    TabButton.MouseButton1Click:Connect(function()
        currentTab = name
        for _, tab in pairs(TabContainer:GetChildren()) do
            if tab:IsA("TextButton") then
                tab.BackgroundColor3 = tab.Name == name and Config.AccentColor or Color3.fromRGB(30, 30, 30)
            end
        end
        ClearContentArea()
        LoadTabContent(name)
    end)

    return TabButton
end

local function CreateSection(title)
    local Section = Instance.new("Frame")
    Section.Name = title
    Section.Size = UDim2.new(1, 0, 0, 35)
    Section.BackgroundColor3 = Config.BackgroundColor
    Section.BorderSizePixel = 0
    Section.Parent = ContentArea

    local SectionCorner = Instance.new("UICorner")
    SectionCorner.CornerRadius = UDim.new(0, 4)
    SectionCorner.Parent = Section

    local SectionTitle = Instance.new("TextLabel")
    SectionTitle.Size = UDim2.new(1, -20, 1, 0)
    SectionTitle.Position = UDim2.new(0, 10, 0, 0)
    SectionTitle.BackgroundTransparency = 1
    SectionTitle.Font = Enum.Font.GothamBold
    SectionTitle.Text = title
    SectionTitle.TextColor3 = Config.AccentColor
    SectionTitle.TextSize = 14
    SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
    SectionTitle.Parent = Section

    return Section
end

local function CreateToggle(title, configKey, callback)
    local Toggle = Instance.new("Frame")
    Toggle.Name = title
    Toggle.Size = UDim2.new(1, 0, 0, 35)
    Toggle.BackgroundColor3 = Config.BackgroundColor
    Toggle.BorderSizePixel = 0
    Toggle.Parent = ContentArea

    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 4)
    ToggleCorner.Parent = Toggle

    local ToggleLabel = Instance.new("TextLabel")
    ToggleLabel.Size = UDim2.new(1, -60, 1, 0)
    ToggleLabel.Position = UDim2.new(0, 10, 0, 0)
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Font = Enum.Font.Gotham
    ToggleLabel.Text = title
    ToggleLabel.TextColor3 = Config.TextColor
    ToggleLabel.TextSize = 13
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    ToggleLabel.Parent = Toggle

    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Size = UDim2.new(0, 45, 0, 20)
    ToggleButton.Position = UDim2.new(1, -55, 0.5, -10)
    ToggleButton.BackgroundColor3 = Config[configKey] and Config.AccentColor or Color3.fromRGB(50, 50, 50)
    ToggleButton.BorderSizePixel = 0
    ToggleButton.Text = ""
    ToggleButton.Parent = Toggle

    local ToggleButtonCorner = Instance.new("UICorner")
    ToggleButtonCorner.CornerRadius = UDim.new(1, 0)
    ToggleButtonCorner.Parent = ToggleButton

    local ToggleCircle = Instance.new("Frame")
    ToggleCircle.Size = UDim2.new(0, 16, 0, 16)
    ToggleCircle.Position = Config[configKey] and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
    ToggleCircle.BackgroundColor3 = Color3.new(1, 1, 1)
    ToggleCircle.BorderSizePixel = 0
    ToggleCircle.Parent = ToggleButton

    local ToggleCircleCorner = Instance.new("UICorner")
    ToggleCircleCorner.CornerRadius = UDim.new(1, 0)
    ToggleCircleCorner.Parent = ToggleCircle

    ToggleButton.MouseButton1Click:Connect(function()
        Config[configKey] = not Config[configKey]
        
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        TweenService:Create(ToggleButton, tweenInfo, {BackgroundColor3 = Config[configKey] and Config.AccentColor or Color3.fromRGB(50, 50, 50)}):Play()
        TweenService:Create(ToggleCircle, tweenInfo, {Position = Config[configKey] and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)}):Play()
        
        if callback then callback(Config[configKey]) end
    end)

    return Toggle
end

local function CreateSlider(title, configKey, min, max, increment, callback)
    local Container = Instance.new("Frame")
    Container.Name = title
    Container.Size = UDim2.new(1, 0, 0, 50)
    Container.BackgroundColor3 = Config.BackgroundColor
    Container.BorderSizePixel = 0
    Container.Parent = ContentArea

    local ContainerCorner = Instance.new("UICorner")
    ContainerCorner.CornerRadius = UDim.new(0, 4)
    ContainerCorner.Parent = Container

    local SliderLabel = Instance.new("TextLabel")
    SliderLabel.Size = UDim2.new(0.7, 0, 0, 20)
    SliderLabel.Position = UDim2.new(0, 10, 0, 5)
    SliderLabel.BackgroundTransparency = 1
    SliderLabel.Font = Enum.Font.Gotham
    SliderLabel.Text = title
    SliderLabel.TextColor3 = Config.TextColor
    SliderLabel.TextSize = 13
    SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
    SliderLabel.Parent = Container

    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Size = UDim2.new(0.3, -20, 0, 20)
    ValueLabel.Position = UDim2.new(0.7, 0, 0, 5)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Font = Enum.Font.GothamBold
    ValueLabel.Text = string.format("%.2f", Config[configKey])
    ValueLabel.TextColor3 = Config.AccentColor
    ValueLabel.TextSize = 13
    ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
    ValueLabel.Parent = Container

    local SliderBack = Instance.new("Frame")
    SliderBack.Size = UDim2.new(1, -20, 0, 6)
    SliderBack.Position = UDim2.new(0, 10, 1, -15)
    SliderBack.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    SliderBack.BorderSizePixel = 0
    SliderBack.Active = true
    SliderBack.Parent = Container

    local SliderBackCorner = Instance.new("UICorner")
    SliderBackCorner.CornerRadius = UDim.new(1, 0)
    SliderBackCorner.Parent = SliderBack

    local SliderFill = Instance.new("Frame")
    SliderFill.Size = UDim2.new((Config[configKey] - min) / (max - min), 0, 1, 0)
    SliderFill.BackgroundColor3 = Config.AccentColor
    SliderFill.BorderSizePixel = 0
    SliderFill.Parent = SliderBack

    local SliderFillCorner = Instance.new("UICorner")
    SliderFillCorner.CornerRadius = UDim.new(1, 0)
    SliderFillCorner.Parent = SliderFill

    local sliderDragging = false

    local function UpdateSlider()
        local mousePos = UserInputService:GetMouseLocation()
        local relativePos = mousePos.X - SliderBack.AbsolutePosition.X
        local percentage = math.clamp(relativePos / SliderBack.AbsoluteSize.X, 0, 1)
        local value = min + (max - min) * percentage
        
        if increment then
            value = math.floor(value / increment + 0.5) * increment
        end
        
        Config[configKey] = value
        ValueLabel.Text = string.format("%.2f", value)
        SliderFill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
        if callback then callback(value) end
    end

    SliderBack.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            sliderDragging = true
            UpdateSlider()
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            sliderDragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if sliderDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            UpdateSlider()
        end
    end)

    return Container
end

local function CreateKeybind(title, configKey, callback)
    local Keybind = Instance.new("Frame")
    Keybind.Name = title
    Keybind.Size = UDim2.new(1, 0, 0, 35)
    Keybind.BackgroundColor3 = Config.BackgroundColor
    Keybind.BorderSizePixel = 0
    Keybind.Parent = ContentArea

    local KeybindCorner = Instance.new("UICorner")
    KeybindCorner.CornerRadius = UDim.new(0, 4)
    KeybindCorner.Parent = Keybind

    local KeybindLabel = Instance.new("TextLabel")
    KeybindLabel.Size = UDim2.new(0.6, 0, 1, 0)
    KeybindLabel.Position = UDim2.new(0, 10, 0, 0)
    KeybindLabel.BackgroundTransparency = 1
    KeybindLabel.Font = Enum.Font.Gotham
    KeybindLabel.Text = title
    KeybindLabel.TextColor3 = Config.TextColor
    KeybindLabel.TextSize = 13
    KeybindLabel.TextXAlignment = Enum.TextXAlignment.Left
    KeybindLabel.Parent = Keybind

    local KeybindButton = Instance.new("TextButton")
    KeybindButton.Size = UDim2.new(0, 80, 0, 25)
    KeybindButton.Position = UDim2.new(1, -90, 0.5, -12.5)
    KeybindButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    KeybindButton.BorderSizePixel = 0
    KeybindButton.Font = Enum.Font.GothamBold
    KeybindButton.Text = Config[configKey].Name
    KeybindButton.TextColor3 = Config.AccentColor
    KeybindButton.TextSize = 12
    KeybindButton.Parent = Keybind

    local KeybindButtonCorner = Instance.new("UICorner")
    KeybindButtonCorner.CornerRadius = UDim.new(0, 4)
    KeybindButtonCorner.Parent = KeybindButton

    local changingKey = false

    KeybindButton.MouseButton1Click:Connect(function()
        if changingKey then return end
        changingKey = true
        KeybindButton.Text = "..."
        
        local connection
        connection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if input.UserInputType == Enum.UserInputType.Keyboard then
                Config[configKey] = input.KeyCode
                KeybindButton.Text = input.KeyCode.Name
                
                if configKey == "MenuKey" then
                    Version.Text = "V2 | " .. input.KeyCode.Name
                end
                
                changingKey = false
                connection:Disconnect()
                if callback then callback(input.KeyCode) end
            end
        end)
    end)

    return Keybind
end

local function CreateButton(title, callback)
    local Button = Instance.new("TextButton")
    Button.Name = title
    Button.Size = UDim2.new(1, 0, 0, 35)
    Button.BackgroundColor3 = Config.AccentColor
    Button.BorderSizePixel = 0
    Button.Font = Enum.Font.GothamBold
    Button.Text = title
    Button.TextColor3 = Color3.new(1, 1, 1)
    Button.TextSize = 13
    Button.Parent = ContentArea

    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 4)
    ButtonCorner.Parent = Button

    Button.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)

    return Button
end

local function CreateTextBox(title, configKey, placeholder, callback)
    local Container = Instance.new("Frame")
    Container.Name = title
    Container.Size = UDim2.new(1, 0, 0, 35)
    Container.BackgroundColor3 = Config.BackgroundColor
    Container.BorderSizePixel = 0
    Container.Parent = ContentArea

    local ContainerCorner = Instance.new("UICorner")
    ContainerCorner.CornerRadius = UDim.new(0, 4)
    ContainerCorner.Parent = Container

    local TextBoxLabel = Instance.new("TextLabel")
    TextBoxLabel.Size = UDim2.new(0.35, 0, 1, 0)
    TextBoxLabel.Position = UDim2.new(0, 10, 0, 0)
    TextBoxLabel.BackgroundTransparency = 1
    TextBoxLabel.Font = Enum.Font.Gotham
    TextBoxLabel.Text = title
    TextBoxLabel.TextColor3 = Config.TextColor
    TextBoxLabel.TextSize = 13
    TextBoxLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextBoxLabel.Parent = Container

    local TextBox = Instance.new("TextBox")
    TextBox.Size = UDim2.new(0.6, -20, 0, 25)
    TextBox.Position = UDim2.new(0.4, 0, 0.5, -12.5)
    TextBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TextBox.BorderSizePixel = 0
    TextBox.Font = Enum.Font.Gotham
    TextBox.PlaceholderText = placeholder
    TextBox.Text = configKey and Config[configKey] or ""
    TextBox.TextColor3 = Color3.new(1, 1, 1)
    TextBox.TextSize = 12
    TextBox.ClearTextOnFocus = false
    TextBox.Parent = Container

    local TextBoxCorner = Instance.new("UICorner")
    TextBoxCorner.CornerRadius = UDim.new(0, 4)
    TextBoxCorner.Parent = TextBox

    TextBox.FocusLost:Connect(function()
        if callback then callback(TextBox.Text) end
    end)

    return Container, TextBox
end

local function CreateBoneSelector(title, configKey, options, callback)
    local Container = Instance.new("Frame")
    Container.Name = title
    Container.Size = UDim2.new(1, 0, 0, 35)
    Container.BackgroundColor3 = Config.BackgroundColor
    Container.BorderSizePixel = 0
    Container.Parent = ContentArea

    local ContainerCorner = Instance.new("UICorner")
    ContainerCorner.CornerRadius = UDim.new(0, 4)
    ContainerCorner.Parent = Container

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.5, 0, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Font = Enum.Font.Gotham
    Label.Text = title
    Label.TextColor3 = Config.TextColor
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Container

    local ButtonsContainer = Instance.new("Frame")
    ButtonsContainer.Size = UDim2.new(0.5, -20, 1, -10)
    ButtonsContainer.Position = UDim2.new(0.5, 0, 0, 5)
    ButtonsContainer.BackgroundTransparency = 1
    ButtonsContainer.Parent = Container

    local ButtonLayout = Instance.new("UIListLayout")
    ButtonLayout.FillDirection = Enum.FillDirection.Horizontal
    ButtonLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    ButtonLayout.Padding = UDim.new(0, 5)
    ButtonLayout.Parent = ButtonsContainer

    for _, option in ipairs(options) do
        local Button = Instance.new("TextButton")
        Button.Size = UDim2.new(0, 80, 1, 0)
        Button.BackgroundColor3 = Config[configKey] == option and Config.AccentColor or Color3.fromRGB(40, 40, 40)
        Button.BorderSizePixel = 0
        Button.Font = Enum.Font.GothamBold
        Button.Text = option
        Button.TextColor3 = Color3.new(1, 1, 1)
        Button.TextSize = 11
        Button.Parent = ButtonsContainer
        
        local ButtonCorner = Instance.new("UICorner")
        ButtonCorner.CornerRadius = UDim.new(0, 4)
        ButtonCorner.Parent = Button
        
        Button.MouseButton1Click:Connect(function()
            Config[configKey] = option
            
            for _, btn in pairs(ButtonsContainer:GetChildren()) do
                if btn:IsA("TextButton") then
                    btn.BackgroundColor3 = btn.Text == option and Config.AccentColor or Color3.fromRGB(40, 40, 40)
                end
            end
            
            if callback then callback(option) end
        end)
    end

    return Container
end

function LoadTabContent(tabName)
    if tabName == "AIMBOT" then
        CreateSection("AIMBOT SETTINGS")
        CreateKeybind("Aimbot Key", "AimKey")
        CreateToggle("Hold to Aim", "HoldToAim")
        CreateToggle("Target Enemies Only", "EnemiesOnly")
        CreateToggle("Show FOV Circle", "ShowFOV")
        CreateToggle("Visible Check", "WallCheck")
        CreateSlider("FOV Size", "FOV", 50, 500, 10)
        CreateSlider("Smoothness", "Smoothness", 1, 20, 1)

        CreateSection("TARGET SETTINGS")
        CreateBoneSelector("Target Bone", "AimPart", {"Head", "UpperTorso", "LowerTorso"}, function(bone)
            ShowNotification("🎯 Aim Part: " .. bone, 2)
        end)
        
    elseif tabName == "SPRAY" then
        CreateSection("SPRAY CONTROL (AK-47 PATTERN)")
        CreateToggle("Enable Spray Control", "SprayControlEnabled", function(enabled)
            if enabled then
                ShowNotification("🔫 Spray Control: ON", 2)
            else
                ShowNotification("🔫 Spray Control: OFF", 2)
            end
        end)
        CreateSlider("Pattern Strength", "SprayStrength", 0.1, 2.0, 0.1)
        CreateSlider("Pattern Smoothing", "SpraySmoothing", 0.1, 1.0, 0.05)
        
    elseif tabName == "VISUALS" then
        CreateSection("PLAYER ESP")
        CreateToggle("Enable ESP", "ESPEnabled")
        CreateToggle("Show Teammates", "ShowTeammates")
        CreateToggle("Box ESP", "BoxESP")
        CreateToggle("Name ESP", "NameESP")
        CreateToggle("Distance ESP", "DistanceESP")
        CreateToggle("Health Bar", "HealthESP")
        CreateToggle("Tracers", "TracerESP")
        CreateToggle("Chams", "ChamsEnabled")
        
    elseif tabName == "MISC" then
        CreateSection("WALLBANG")
        CreateToggle("Enable Wallbang", "WallbangEnabled")
        
        CreateSection("DEBUG")
        CreateToggle("Console Output", "DebugMode", function(enabled)
            if enabled then
                ShowNotification("🐛 Debug Mode: ON", 2)
            else
                ShowNotification("🐛 Debug Mode: OFF", 2)
            end
        end)
        
        CreateSection("MENU SETTINGS")
        CreateKeybind("Menu Key", "MenuKey")
        
    elseif tabName == "CONFIG" then
        CreateSection("📌 CURRENT CONFIG")
        
        local currentConfigDisplay = Instance.new("Frame")
        currentConfigDisplay.Size = UDim2.new(1, 0, 0, 40)
        currentConfigDisplay.BackgroundColor3 = currentConfigName and Config.AccentColor or Color3.fromRGB(60, 60, 60)
        currentConfigDisplay.BorderSizePixel = 0
        currentConfigDisplay.Parent = ContentArea
        
        local currentConfigCorner = Instance.new("UICorner")
        currentConfigCorner.CornerRadius = UDim.new(0, 6)
        currentConfigCorner.Parent = currentConfigDisplay
        
        local currentConfigLabel = Instance.new("TextLabel")
        currentConfigLabel.Size = UDim2.new(1, -20, 1, 0)
        currentConfigLabel.Position = UDim2.new(0, 10, 0, 0)
        currentConfigLabel.BackgroundTransparency = 1
        currentConfigLabel.Font = Enum.Font.GothamBold
        currentConfigLabel.Text = currentConfigName and ("📄 Active: " .. currentConfigName) or "⚠️ No Config Loaded"
        currentConfigLabel.TextColor3 = Color3.new(1, 1, 1)
        currentConfigLabel.TextSize = 14
        currentConfigLabel.TextXAlignment = Enum.TextXAlignment.Left
        currentConfigLabel.Parent = currentConfigDisplay
        
        if currentConfigName then
            CreateButton("💾 Save Current (" .. currentConfigName .. ")", function()
                if SaveConfig(currentConfigName) then
                    ShowNotification("✅ Updated: " .. currentConfigName, 3)
                    ClearContentArea()
                    LoadTabContent("CONFIG")
                else
                    ShowNotification("❌ Failed to save", 3)
                end
            end)
        end
        
        CreateSection("💾 SAVE NEW CONFIG")
        local nameContainer, nameBox = CreateTextBox("Config Name", nil, "my_config")
        CreateButton("💾 Save as New Config", function()
            local configName = nameBox.Text
            if configName and configName ~= "" then
                if SaveConfig(configName) then
                    ShowNotification("✅ Config saved: " .. configName, 3)
                    ClearContentArea()
                    LoadTabContent("CONFIG")
                else
                    ShowNotification("❌ Failed to save config", 3)
                end
            else
                ShowNotification("⚠️ Please enter a config name", 2)
            end
        end)
        
        CreateSection("📂 LOAD CONFIG")
        CreateButton("🔄 Refresh Config List", function()
            RefreshConfigList()
            ShowNotification("🔄 Config list refreshed", 2)
            ClearContentArea()
            LoadTabContent("CONFIG")
        end)
        
        local configList = RefreshConfigList()
        
        if #configList > 0 then
            for _, configName in pairs(configList) do
                local configFrame = Instance.new("Frame")
                configFrame.Size = UDim2.new(1, 0, 0, 35)
                configFrame.BackgroundColor3 = currentConfigName == configName and Config.AccentColor or Config.BackgroundColor
                configFrame.BorderSizePixel = 0
                configFrame.Parent = ContentArea
                
                local configCorner = Instance.new("UICorner")
                configCorner.CornerRadius = UDim.new(0, 4)
                configCorner.Parent = configFrame
                
                local configLabel = Instance.new("TextLabel")
                configLabel.Size = UDim2.new(0.5, 0, 1, 0)
                configLabel.Position = UDim2.new(0, 10, 0, 0)
                configLabel.BackgroundTransparency = 1
                configLabel.Font = Enum.Font.GothamBold
                configLabel.Text = "📄 " .. configName
                configLabel.TextColor3 = currentConfigName == configName and Color3.new(1, 1, 1) or Config.TextColor
                configLabel.TextSize = 12
                configLabel.TextXAlignment = Enum.TextXAlignment.Left
                configLabel.Parent = configFrame
                
                local loadBtn = Instance.new("TextButton")
                loadBtn.Size = UDim2.new(0, 60, 0, 25)
                loadBtn.Position = UDim2.new(1, -130, 0.5, -12.5)
                loadBtn.BackgroundColor3 = Color3.fromRGB(89, 119, 239)
                loadBtn.BorderSizePixel = 0
                loadBtn.Font = Enum.Font.GothamBold
                loadBtn.Text = "Load"
                loadBtn.TextColor3 = Color3.new(1, 1, 1)
                loadBtn.TextSize = 11
                loadBtn.Parent = configFrame
                
                local loadCorner = Instance.new("UICorner")
                loadCorner.CornerRadius = UDim.new(0, 4)
                loadCorner.Parent = loadBtn
                
                loadBtn.MouseButton1Click:Connect(function()
                    if LoadConfig(configName) then
                        ShowNotification("✅ Loaded: " .. configName, 2)
                        Version.Text = "V2 | " .. Config.MenuKey.Name
                        ClearContentArea()
                        LoadTabContent("CONFIG")
                    else
                        ShowNotification("❌ Failed to load", 2)
                    end
                end)
                
                local deleteBtn = Instance.new("TextButton")
                deleteBtn.Size = UDim2.new(0, 60, 0, 25)
                deleteBtn.Position = UDim2.new(1, -65, 0.5, -12.5)
                deleteBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
                deleteBtn.BorderSizePixel = 0
                deleteBtn.Font = Enum.Font.GothamBold
                deleteBtn.Text = "Delete"
                deleteBtn.TextColor3 = Color3.new(1, 1, 1)
                deleteBtn.TextSize = 11
                deleteBtn.Parent = configFrame
                
                local deleteCorner = Instance.new("UICorner")
                deleteCorner.CornerRadius = UDim.new(0, 4)
                deleteCorner.Parent = deleteBtn
                
                deleteBtn.MouseButton1Click:Connect(function()
                    if DeleteConfig(configName) then
                        ShowNotification("🗑️ Deleted: " .. configName, 2)
                        ClearContentArea()
                        LoadTabContent("CONFIG")
                    else
                        ShowNotification("❌ Failed to delete", 2)
                    end
                end)
            end
        else
            local noConfigs = Instance.new("TextLabel")
            noConfigs.Size = UDim2.new(1, 0, 0, 50)
            noConfigs.BackgroundColor3 = Config.BackgroundColor
            noConfigs.BorderSizePixel = 0
            noConfigs.Font = Enum.Font.Gotham
            noConfigs.Text = "No configs found\nCreate one above!"
            noConfigs.TextColor3 = Config.TextColor
            noConfigs.TextSize = 12
            noConfigs.Parent = ContentArea
            
            local noConfigCorner = Instance.new("UICorner")
            noConfigCorner.CornerRadius = UDim.new(0, 4)
            noConfigCorner.Parent = noConfigs
        end
    end
end

CreateTab("AIMBOT", "🎯")
CreateTab("SPRAY", "🔫")
CreateTab("VISUALS", "👁️")
CreateTab("MISC", "⚙️")
CreateTab("CONFIG", "📁")

LoadTabContent("AIMBOT")

-- WATERMARK
local Watermark = Instance.new("Frame")
Watermark.Size = UDim2.new(0, 300, 0, 55)
Watermark.Position = UDim2.new(1, -310, 0, 10)
Watermark.BackgroundColor3 = Config.SecondaryColor
Watermark.BorderSizePixel = 0
Watermark.Parent = ScreenGui

local WatermarkCorner = Instance.new("UICorner")
WatermarkCorner.CornerRadius = UDim.new(0, 6)
WatermarkCorner.Parent = Watermark

local WatermarkTitle = Instance.new("TextLabel")
WatermarkTitle.Size = UDim2.new(1, -20, 0, 18)
WatermarkTitle.Position = UDim2.new(0, 10, 0, 3)
WatermarkTitle.BackgroundTransparency = 1
WatermarkTitle.Font = Enum.Font.GothamBold
WatermarkTitle.Text = "EXPECTIONAL | " .. ExecutorName
WatermarkTitle.TextColor3 = Config.AccentColor
WatermarkTitle.TextSize = 14
WatermarkTitle.TextXAlignment = Enum.TextXAlignment.Left
WatermarkTitle.Parent = Watermark

local WatermarkInfo = Instance.new("TextLabel")
WatermarkInfo.Size = UDim2.new(1, -20, 0, 14)
WatermarkInfo.Position = UDim2.new(0, 10, 0, 21)
WatermarkInfo.BackgroundTransparency = 1
WatermarkInfo.Font = Enum.Font.Gotham
WatermarkInfo.Text = LocalPlayer.Name .. " | 0 FPS"
WatermarkInfo.TextColor3 = Config.TextColor
WatermarkInfo.TextSize = 11
WatermarkInfo.TextXAlignment = Enum.TextXAlignment.Left
WatermarkInfo.Parent = Watermark

local WatermarkFooter = Instance.new("TextLabel")
WatermarkFooter.Size = UDim2.new(1, -20, 0, 11)
WatermarkFooter.Position = UDim2.new(0, 10, 0, 35)
WatermarkFooter.BackgroundTransparency = 1
WatermarkFooter.Font = Enum.Font.Gotham
WatermarkFooter.Text = "by rolesional | Undetected"
WatermarkFooter.TextColor3 = Color3.fromRGB(150, 150, 150)
WatermarkFooter.TextSize = 9
WatermarkFooter.TextXAlignment = Enum.TextXAlignment.Left
WatermarkFooter.Parent = Watermark

task.spawn(function()
    while task.wait(1) do
        local fps = math.floor(1 / RunService.RenderStepped:Wait())
        local ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
        WatermarkInfo.Text = string.format("%s | %d FPS | %s", LocalPlayer.Name, fps, ping)
    end
end)

-- AUTO-LOAD CONFIG
task.delay(1, function()
    RefreshConfigList()
    if #availableConfigs > 0 then
        if LoadConfig(availableConfigs[1]) then
            ShowNotification("✅ Auto-loaded: " .. availableConfigs[1], 3)
            Version.Text = "V2 | " .. Config.MenuKey.Name
        end
    end
end)

-- FOV CIRCLE
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 2
FOVCircle.NumSides = 64
FOVCircle.Radius = Config.FOV
FOVCircle.Filled = false
FOVCircle.Color = Config.AccentColor
FOVCircle.Transparency = 1
FOVCircle.Visible = true

-- PLAYER VALIDATION
local function IsPlayerValid(player)
    if not player or not player.Parent then return false end
    if not player.Character then return false end
    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return false end
    if humanoid.Health <= 0 then return false end
    local head = player.Character:FindFirstChild("Head")
    if not head then return false end
    return true
end

local function IsVisible(part, character)
    if not part or not character then return false end
    local rayOrigin = Camera.CFrame.Position
    local rayDirection = (part.Position - rayOrigin).Unit * (part.Position - rayOrigin).Magnitude
    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = {LocalPlayer.Character, character}
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    raycastParams.IgnoreWater = true
    local raycastResult = workspace:Raycast(rayOrigin, rayDirection, raycastParams)
    if not raycastResult then return true end
    if raycastResult.Instance == part then return true end
    return false
end

local function RemoveAllDrawings(esp)
    if not esp then return end
    if esp.Drawings then
        for name, drawing in pairs(esp.Drawings) do
            if drawing then
                pcall(function()
                    drawing.Visible = false
                    drawing:Remove()
                end)
            end
        end
    end
    if esp.Highlight then
        pcall(function()
            esp.Highlight:Destroy()
        end)
        esp.Highlight = nil
    end
end

-- ESP SYSTEM
local function CreateESP(player)
    if ESPObjects[player] then RemoveAllDrawings(ESPObjects[player]) end
    local esp = {Player = player, Drawings = {}}

    local teamColor = GetTeamColor(player)

    esp.Drawings.Box = Drawing.new("Square")
    esp.Drawings.Box.Thickness = 2
    esp.Drawings.Box.Filled = false
    esp.Drawings.Box.Color = teamColor
    esp.Drawings.Box.Transparency = 1
    esp.Drawings.Box.Visible = false

    esp.Drawings.Name = Drawing.new("Text")
    esp.Drawings.Name.Size = 16
    esp.Drawings.Name.Center = true
    esp.Drawings.Name.Outline = true
    esp.Drawings.Name.Color = teamColor
    esp.Drawings.Name.Transparency = 1
    esp.Drawings.Name.Visible = false

    esp.Drawings.Distance = Drawing.new("Text")
    esp.Drawings.Distance.Size = 14
    esp.Drawings.Distance.Center = false
    esp.Drawings.Distance.Outline = true
    esp.Drawings.Distance.Color = teamColor
    esp.Drawings.Distance.Transparency = 1
    esp.Drawings.Distance.Visible = false

    esp.Drawings.HealthBar = Drawing.new("Square")
    esp.Drawings.HealthBar.Thickness = 1
    esp.Drawings.HealthBar.Filled = true
    esp.Drawings.HealthBar.Color = Color3.fromRGB(0, 255, 0)
    esp.Drawings.HealthBar.Transparency = 1
    esp.Drawings.HealthBar.Visible = false

    esp.Drawings.HealthBarOutline = Drawing.new("Square")
    esp.Drawings.HealthBarOutline.Thickness = 1
    esp.Drawings.HealthBarOutline.Filled = false
    esp.Drawings.HealthBarOutline.Color = Color3.fromRGB(0, 0, 0)
    esp.Drawings.HealthBarOutline.Transparency = 1
    esp.Drawings.HealthBarOutline.Visible = false

    esp.Drawings.Tracer = Drawing.new("Line")
    esp.Drawings.Tracer.Thickness = 1
    esp.Drawings.Tracer.Color = teamColor
    esp.Drawings.Tracer.Transparency = 1
    esp.Drawings.Tracer.Visible = false

    if player.Character then
        local highlight = Instance.new("Highlight")
        highlight.Name = "ESPHighlight"
        highlight.FillColor = teamColor
        highlight.FillTransparency = 0.5
        highlight.OutlineColor = teamColor
        highlight.OutlineTransparency = 0
        highlight.Enabled = false
        highlight.Parent = player.Character
        esp.Highlight = highlight
    end

    ESPObjects[player] = esp
end

local function RemoveESP(player)
    if ESPObjects[player] then
        RemoveAllDrawings(ESPObjects[player])
        ESPObjects[player] = nil
    end
end

local function HideAllESP()
    for player, esp in pairs(ESPObjects) do
        if esp.Drawings then
            for _, drawing in pairs(esp.Drawings) do
                if drawing then pcall(function() drawing.Visible = false end) end
            end
        end
        if esp.Highlight then pcall(function() esp.Highlight.Enabled = false end) end
    end
end

local function UpdateESP()
    if not Config.ESPEnabled then HideAllESP() return end

    for player, esp in pairs(ESPObjects) do
        if not IsPlayerValid(player) or player == LocalPlayer then
            for _, drawing in pairs(esp.Drawings) do
                if drawing then drawing.Visible = false end
            end
            if esp.Highlight then esp.Highlight.Enabled = false end
            continue
        end
        
        local isSameTeam = IsSameTeam(LocalPlayer, player)
        if isSameTeam and not Config.ShowTeammates then
            for _, drawing in pairs(esp.Drawings) do
                if drawing then drawing.Visible = false end
            end
            if esp.Highlight then esp.Highlight.Enabled = false end
            continue
        end
        
        local teamColor = GetTeamColor(player)
        if esp.Drawings.Box then esp.Drawings.Box.Color = teamColor end
        if esp.Drawings.Name then esp.Drawings.Name.Color = teamColor end
        if esp.Drawings.Distance then esp.Drawings.Distance.Color = teamColor end
        if esp.Drawings.Tracer then esp.Drawings.Tracer.Color = teamColor end
        if esp.Highlight then 
            esp.Highlight.FillColor = teamColor 
            esp.Highlight.OutlineColor = teamColor
        end
        
        local character = player.Character
        local rootPart = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso")
        local head = character:FindFirstChild("Head")
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        
        if not rootPart or not head or not humanoid then
            for _, drawing in pairs(esp.Drawings) do
                if drawing then drawing.Visible = false end
            end
            if esp.Highlight then esp.Highlight.Enabled = false end
            continue
        end
        
        local screenPos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
        
        if onScreen then
            local headPos = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
            local legPos = Camera:WorldToViewportPoint(rootPart.Position - Vector3.new(0, 3, 0))
            local height = math.abs(headPos.Y - legPos.Y)
            local width = height / 2
            
            if Config.BoxESP and esp.Drawings.Box then
                esp.Drawings.Box.Size = Vector2.new(width, height)
                esp.Drawings.Box.Position = Vector2.new(screenPos.X - width/2, screenPos.Y - height/2)
                esp.Drawings.Box.Visible = true
            elseif esp.Drawings.Box then esp.Drawings.Box.Visible = false end
            
            if Config.NameESP and esp.Drawings.Name then
                esp.Drawings.Name.Text = player.Name
                esp.Drawings.Name.Position = Vector2.new(screenPos.X, headPos.Y - 20)
                esp.Drawings.Name.Visible = true
            elseif esp.Drawings.Name then esp.Drawings.Name.Visible = false end
            
            if Config.DistanceESP and esp.Drawings.Distance then
                local distance = math.floor((rootPart.Position - Camera.CFrame.Position).Magnitude)
                esp.Drawings.Distance.Text = distance .. "m"
                esp.Drawings.Distance.Position = Vector2.new(screenPos.X + width/2 + 5, screenPos.Y - height/2)
                esp.Drawings.Distance.Visible = true
            elseif esp.Drawings.Distance then esp.Drawings.Distance.Visible = false end
            
            if Config.HealthESP and humanoid and esp.Drawings.HealthBar and esp.Drawings.HealthBarOutline then
                local healthPercent = humanoid.Health / humanoid.MaxHealth
                local barHeight = height
                local barWidth = 4
                esp.Drawings.HealthBarOutline.Size = Vector2.new(barWidth, barHeight)
                esp.Drawings.HealthBarOutline.Position = Vector2.new(screenPos.X - width/2 - 8, screenPos.Y - height/2)
                esp.Drawings.HealthBarOutline.Visible = true
                esp.Drawings.HealthBar.Size = Vector2.new(barWidth - 2, barHeight * healthPercent)
                esp.Drawings.HealthBar.Position = Vector2.new(screenPos.X - width/2 - 7, screenPos.Y - height/2 + (barHeight * (1 - healthPercent)) + 1)
                esp.Drawings.HealthBar.Color = Color3.fromRGB(255 * (1 - healthPercent), 255 * healthPercent, 0)
                esp.Drawings.HealthBar.Visible = true
            else
                if esp.Drawings.HealthBar then esp.Drawings.HealthBar.Visible = false end
                if esp.Drawings.HealthBarOutline then esp.Drawings.HealthBarOutline.Visible = false end
            end
            
            if Config.TracerESP and esp.Drawings.Tracer then
                local tracerStart = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                esp.Drawings.Tracer.From = tracerStart
                esp.Drawings.Tracer.To = Vector2.new(screenPos.X, screenPos.Y)
                esp.Drawings.Tracer.Visible = true
            elseif esp.Drawings.Tracer then esp.Drawings.Tracer.Visible = false end
            
            if esp.Highlight then esp.Highlight.Enabled = Config.ChamsEnabled end
        else
            for _, drawing in pairs(esp.Drawings) do
                if drawing then drawing.Visible = false end
            end
            if esp.Highlight then esp.Highlight.Enabled = false end
        end
    end
end

-- PLAYER EVENTS
Players.PlayerAdded:Connect(function(player)
    task.wait(0.5)
    CreateESP(player)
end)

Players.PlayerRemoving:Connect(function(player)
    RemoveESP(player)
end)

for _, player in pairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        CreateESP(player)
        player.CharacterAdded:Connect(function(char)
            task.wait(0.5)
            RemoveESP(player)
            CreateESP(player)
        end)
    end
end

LocalPlayer.CharacterAdded:Connect(function(character)
    task.wait(1)
    for player, esp in pairs(ESPObjects) do
        if esp.Highlight and player.Character then
            pcall(function() esp.Highlight:Destroy() end)

            local teamColor = GetTeamColor(player)
            local highlight = Instance.new("Highlight")
            highlight.Name = "ESPHighlight"
            highlight.FillColor = teamColor
            highlight.FillTransparency = 0.5
            highlight.OutlineColor = teamColor
            highlight.OutlineTransparency = 0
            highlight.Enabled = Config.ChamsEnabled
            highlight.Parent = player.Character
            esp.Highlight = highlight
        end
    end
end)

-- AIMBOT
local function GetClosestPart()
    local closestPart = nil
    local shortestDistance = Config.FOV
    local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            if not IsPlayerValid(player) then continue end
            
            local isSameTeam = IsSameTeam(LocalPlayer, player)
            if Config.EnemiesOnly and isSameTeam then continue end
            
            local character = player.Character
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            
            local targetPart
            if Config.AimPart == "Head" then
                targetPart = character:FindFirstChild("Head")
            elseif Config.AimPart == "UpperTorso" then
                targetPart = character:FindFirstChild("UpperTorso") or character:FindFirstChild("Torso")
            elseif Config.AimPart == "LowerTorso" then
                targetPart = character:FindFirstChild("LowerTorso") or character:FindFirstChild("Torso")
            else
                targetPart = character:FindFirstChild("Head")
            end
            
            if targetPart and humanoid and humanoid.Health > 0 then
                if Config.WallCheck and not IsVisible(targetPart, character) then continue end
                
                local screenPos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
                if onScreen then
                    local screenPos2D = Vector2.new(screenPos.X, screenPos.Y)
                    local distance = (screenPos2D - screenCenter).Magnitude
                    if distance < shortestDistance then
                        shortestDistance = distance
                        closestPart = targetPart
                    end
                end
            end
        end
    end

    return closestPart
end

local function MoveMouseToTarget(targetPart)
    if not targetPart then return end
    local targetScreenPos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
    if not onScreen then return end
    local mousePos = UserInputService:GetMouseLocation()
    local deltaX = targetScreenPos.X - mousePos.X
    local deltaY = targetScreenPos.Y - mousePos.Y
    local moveX = deltaX / Config.Smoothness
    local moveY = deltaY / Config.Smoothness

    if mousemoverel then
        mousemoverel(moveX, moveY)
    elseif Input and Input.MouseMove then
        Input.MouseMove(moveX, moveY)
    end
end

local function ApplySprayPattern()
    if not Config.SprayControlEnabled then return end
    if not isShooting then return end
    
    local index = math.min(sprayBulletCount + 1, #AK47_SPRAY_PATTERN)
    local pattern = AK47_SPRAY_PATTERN[index]
    
    if pattern then
        local compensateX = -pattern.x * Config.SprayStrength * Config.SpraySmoothing
        local compensateY = -pattern.y * Config.SprayStrength * Config.SpraySmoothing
        
        if mousemoverel then
            mousemoverel(compensateX, compensateY)
        elseif Input and Input.MouseMove then
            Input.MouseMove(compensateX, compensateY)
        end
        
        sprayBulletCount = sprayBulletCount + 1
    end
end

local function IsPartOfCharacter(part)
    local model = part:FindFirstAncestorOfClass("Model")
    if model and model:FindFirstChildOfClass("Humanoid") then
        return true
    end
    
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character and part:IsDescendantOf(player.Character) then
            return true
        end
    end
    
    return false
end

-- INPUT HANDLING
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Config.MenuKey then
        Config.MenuVisible = not Config.MenuVisible
        MainWindow.Visible = Config.MenuVisible
    end

    if not gameProcessed and input.KeyCode == Config.AimKey and not Config.HoldToAim then
        Config.AimbotEnabled = not Config.AimbotEnabled
        DebugPrint("AIMBOT", "🎯", Config.AimbotEnabled and "ON" or "OFF")
    end

    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isShooting = true
        sprayStartTime = tick()
        sprayBulletCount = 0
        
        if not gameProcessed and Config.WallbangEnabled then
            local partsToMove = {}
            local ignoreList = {LocalPlayer.Character}
            
            for _, player in pairs(Players:GetPlayers()) do
                if player.Character then
                    table.insert(ignoreList, player.Character)
                end
            end
            
            local rayOrigin = Camera.CFrame.Position
            local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
            local ray = Camera:ViewportPointToRay(screenCenter.X, screenCenter.Y)
            local rayDirection = ray.Direction * 1000
            
            for i = 1, 50 do
                local raycastParams = RaycastParams.new()
                raycastParams.FilterDescendantsInstances = ignoreList
                raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
                raycastParams.IgnoreWater = true
                
                local result = workspace:Raycast(rayOrigin, rayDirection, raycastParams)
                
                if result and result.Instance then
                    local hitPart = result.Instance
                    
                    if IsPartOfCharacter(hitPart) then
                        break
                    end
                    
                    if hitPart:IsA("BasePart") and hitPart.CanCollide then
                        table.insert(partsToMove, {
                            part = hitPart,
                            originalCFrame = hitPart.CFrame
                        })
                        
                        table.insert(ignoreList, hitPart)
                    else
                        break
                    end
                else
                    break
                end
            end
            
            for _, data in pairs(partsToMove) do
                pcall(function()
                    data.part.CFrame = CFrame.new(0, -10000, 0)
                end)
            end
            
            task.delay(0.1, function()
                for _, data in pairs(partsToMove) do
                    pcall(function()
                        if data.part and data.part.Parent then
                            data.part.CFrame = data.originalCFrame
                        end
                    end)
                end
            end)
        end
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isShooting = false
        sprayBulletCount = 0
    end
end)

-- MAIN LOOP
local lastESPUpdate = 0
local ESP_UPDATE_INTERVAL = 1/120

RunService.RenderStepped:Connect(function()
    local now = tick()

    -- FOV Circle
    local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    FOVCircle.Position = screenCenter
    FOVCircle.Radius = Config.FOV
    FOVCircle.Visible = Config.ShowFOV
    FOVCircle.Color = Config.AccentColor

    -- ESP Update
    if now - lastESPUpdate >= ESP_UPDATE_INTERVAL then
        UpdateESP()
        lastESPUpdate = now
    end

    -- Aimbot
    local shouldAim = false
    if Config.HoldToAim then
        shouldAim = UserInputService:IsKeyDown(Config.AimKey)
    else
        shouldAim = Config.AimbotEnabled
    end

    if shouldAim then
        local currentTarget = GetClosestPart()
        if currentTarget then
            MoveMouseToTarget(currentTarget)
        end
    end

    -- Spray Control
    if isShooting and Config.SprayControlEnabled then
        ApplySprayPattern()
    end
end)

-- COMPATIBILITY CHECK
local function CheckCompatibility()
    local issues = {}

    if not Drawing then
        table.insert(issues, "❌ Drawing library missing")
        Config.ESPEnabled = false
    end

    if not mousemoverel then
        table.insert(issues, "❌ Mouse control missing")
    end

    if not (isfolder and writefile and readfile) then
        table.insert(issues, "⚠️ File system missing")
    end

    if #issues > 0 then
        warn("⚠️ COMPATIBILITY ISSUES:")
        for _, issue in pairs(issues) do
            warn(issue)
        end
        task.wait(3)
        ShowNotification("⚠️ Some features disabled", 5)
    else
        print("✅ All features supported!")
    end
end

task.delay(2, CheckCompatibility)

print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("✅ EXPECTIONAL LOADED!")
print("👤 Coded By rolesional")
print("🚀 Executor: " .. ExecutorName)
print("📂 Config: workspace/" .. ConfigsFolder)
print("🔑 Menu Key: " .. Config.MenuKey.Name)
print("💾 Config:", isfolder and "✅" or "❌")
print("🎯 Aimbot:", mousemoverel and "✅" or "❌")
print("👁️ Player ESP: ✅ (120 FPS)")
print("🐛 Debug Mode:", Config.DebugMode and "✅" or "❌")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
