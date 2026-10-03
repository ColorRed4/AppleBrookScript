local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

pcall(function()
    local old = PlayerGui:FindFirstChild("EtraxonCommunity")
    if old then
        old:Destroy()
    end
end)

local CurrentLanguage = "EN"
local MainOpen = true

local SelectedColor = Color3.fromRGB(255, 0, 0)
local AnimationSpeed = 10
local RGBEnabled = true
local CurrentPage = "home"

local DARK = Color3.fromRGB(8, 9, 14)
local DARK2 = Color3.fromRGB(13, 14, 22)
local PANEL = Color3.fromRGB(16, 17, 26)
local PANEL2 = Color3.fromRGB(20, 21, 31)
local TEXT = Color3.fromRGB(245, 245, 250)
local MUTED = Color3.fromRGB(155, 158, 175)
local BORDER = Color3.fromRGB(70, 75, 100)
local SIDE = Color3.fromRGB(110, 0, 35)
local SIDE_HOVER = Color3.fromRGB(145, 0, 45)

local Gui = Instance.new("ScreenGui")
Gui.Name = "EtraxonCommunity"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.DisplayOrder = 999
Gui.Parent = PlayerGui

local function corner(obj, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 10)
    c.Parent = obj
    return c
end

local function stroke(obj, thickness)
    local s = Instance.new("UIStroke")
    s.Thickness = thickness or 1.5
    s.Transparency = 0
    s.Parent = obj
    return s
end

local function makeText(parent, text, size, font)
    local t = Instance.new("TextLabel")
    t.BackgroundTransparency = 1
    t.Text = text
    t.TextColor3 = TEXT
    t.TextSize = size or 14
    t.Font = font or Enum.Font.GothamBold
    t.Parent = parent
    return t
end

local function makeButton(parent, text)
    local b = Instance.new("TextButton")
    b.AutoButtonColor = false
    b.BackgroundColor3 = PANEL2
    b.Text = text
    b.TextColor3 = TEXT
    b.TextSize = 15
    b.Font = Enum.Font.GothamBold
    b.Parent = parent
    corner(b, 9)
    stroke(b, 1)
    return b
end

local function rainbowStroke(s)
    task.spawn(function()
        local h = 0
        while s and s.Parent do
            h = (h + 0.003) % 1
            s.Color = Color3.fromHSV(h, 0.9, 1)
            RunService.RenderStepped:Wait()
        end
    end)
end

local function makeRainbowBorder(obj, thickness)
    local s = stroke(obj, thickness or 2)
    rainbowStroke(s)
    return s
end

local function makeDraggable(obj)
    local dragging = false
    local dragStart
    local startPos

    obj.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then

            dragging = true
            dragStart = input.Position
            startPos = obj.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if not dragging then
            return
        end

        if input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch then

            local delta = input.Position - dragStart

            obj.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

local translations = {
    EN = {
        home = "home",
        name = "name / skin",
        codes = "codes",
        all = "All script",
        language = "language",
        ruseng = "RUS / ENG",
        made = "script made by Etraxon community",
        community = "Etraxon community",
        brookhaven = "Brookhaven RP",
        rgbname = "RGB NAME",
        speed = "speed animation",
        menu = "MENU",
        version = "V1.0",
        copy = "Copied!",
        animation = "Animation Hub"
    },

    RU = {
        home = "главная",
        name = "имя / скин",
        codes = "коды",
        all = "Все скрипты",
        language = "язык",
        ruseng = "РУС / ENG",
        made = "скрипт сделан сообществом Etraxon",
        community = "Сообщество Etraxon",
        brookhaven = "Brookhaven RP",
        rgbname = "ЦВЕТ ИМЕНИ",
        speed = "скорость переливания",
        menu = "МЕНЮ",
        version = "V1.0",
        copy = "Скопировано!",
        animation = "Animation Hub"
    }
}

local function T(key)
    return translations[CurrentLanguage][key] or key
end

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 760, 0, 590)
Main.Position = UDim2.new(0.5, -380, 0.5, -295)
Main.BackgroundColor3 = DARK
Main.BackgroundTransparency = 0.08
Main.Parent = Gui
corner(Main, 18)
makeRainbowBorder(Main, 2.5)
makeDraggable(Main)

local Header = Instance.new("Frame")
Header.BackgroundTransparency = 1
Header.Size = UDim2.new(1, -30, 0, 70)
Header.Position = UDim2.new(0, 15, 0, 10)
Header.Parent = Main

local Title = makeText(Header, "home", 28)
Title.Position = UDim2.new(0, 15, 0, 8)
Title.Size = UDim2.new(0, 300, 0, 35)
Title.TextXAlignment = Enum.TextXAlignment.Left

local Credits = makeText(Header, T("made"), 17)
Credits.Position = UDim2.new(0, 300, 0, 13)
Credits.Size = UDim2.new(1, -300, 0, 30)
Credits.TextXAlignment = Enum.TextXAlignment.Right

local CreditsButton = Instance.new("TextButton")
CreditsButton.BackgroundTransparency = 1
CreditsButton.Text = ""
CreditsButton.Size = Credits.Size
CreditsButton.Position = Credits.Position
CreditsButton.Parent = Header

CreditsButton.MouseButton1Click:Connect(function()
    pcall(function()
        setclipboard("https://t.me/Etraxon")
    end)
end)

local HeaderLine = Instance.new("Frame")
HeaderLine.BorderSizePixel = 0
HeaderLine.BackgroundColor3 = BORDER
HeaderLine.Size = UDim2.new(1, 0, 0, 1)
HeaderLine.Position = UDim2.new(0, 0, 1, -1)
HeaderLine.Parent = Header

local Sidebar = Instance.new("Frame")
Sidebar.BackgroundColor3 = Color3.fromRGB(11, 12, 19)
Sidebar.Size = UDim2.new(0, 200, 1, -105)
Sidebar.Position = UDim2.new(0, 15, 0, 90)
Sidebar.Parent = Main
corner(Sidebar, 15)
makeRainbowBorder(Sidebar, 2)

local SidePadding = Instance.new("UIPadding")
SidePadding.PaddingTop = UDim.new(0, 12)
SidePadding.PaddingLeft = UDim.new(0, 10)
SidePadding.PaddingRight = UDim.new(0, 10)
SidePadding.Parent = Sidebar

local SideLayout = Instance.new("UIListLayout")
SideLayout.Padding = UDim.new(0, 10)
SideLayout.SortOrder = Enum.SortOrder.LayoutOrder
SideLayout.Parent = Sidebar

local HomeButton = makeButton(Sidebar, T("home"))
local NameButton = makeButton(Sidebar, T("name"))
local CodesButton = makeButton(Sidebar, T("codes"))
local AllButton = makeButton(Sidebar, T("all"))

HomeButton.Size = UDim2.new(1, 0, 0, 65)
NameButton.Size = UDim2.new(1, 0, 0, 65)
CodesButton.Size = UDim2.new(1, 0, 0, 65)
AllButton.Size = UDim2.new(1, 0, 0, 65)

local Version = makeText(Sidebar, T("version"), 16)
Version.Size = UDim2.new(1, 0, 0, 30)
Version.Position = UDim2.new(0, 0, 1, -45)
Version.TextColor3 = MUTED

local Content = Instance.new("Frame")
Content.BackgroundColor3 = Color3.fromRGB(7, 8, 13)
Content.BackgroundTransparency = 0.18
Content.Size = UDim2.new(1, -240, 1, -105)
Content.Position = UDim2.new(0, 225, 0, 90)
Content.Parent = Main
corner(Content, 15)
stroke(Content, 1.5)

local MenuButton = Instance.new("TextButton")
MenuButton.Name = "MenuButton"
MenuButton.Size = UDim2.new(0, 175, 0, 60)
MenuButton.Position = UDim2.new(0.5, -87, 0, 12)
MenuButton.BackgroundColor3 = Color3.fromRGB(11, 12, 19)
MenuButton.Text = T("menu")
MenuButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MenuButton.TextSize = 18
MenuButton.Font = Enum.Font.GothamBold
MenuButton.AutoButtonColor = false
MenuButton.Parent = Gui
corner(MenuButton, 14)
makeRainbowBorder(MenuButton, 2.5)
makeDraggable(MenuButton)

MenuButton.MouseEnter:Connect(function()
    TweenService:Create(
        MenuButton,
        TweenInfo.new(0.15),
        {BackgroundColor3 = Color3.fromRGB(20, 21, 31)}
    ):Play()
end)

MenuButton.MouseLeave:Connect(function()
    TweenService:Create(
        MenuButton,
        TweenInfo.new(0.15),
        {BackgroundColor3 = Color3.fromRGB(11, 12, 19)}
    ):Play()
end)

local function clearContent()
    for _, v in ipairs(Content:GetChildren()) do
        v:Destroy()
    end
end

local function createContentTitle(text)
    local title = makeText(Content, text, 25)
    title.Position = UDim2.new(0, 25, 0, 18)
    title.Size = UDim2.new(1, -50, 0, 35)
    title.TextXAlignment = Enum.TextXAlignment.Left
    return title
end

local function notify(text)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Etraxon",
            Text = text,
            Duration = 2
        })
    end)
end

local function setRPNameColor(color)
    SelectedColor = color

    pcall(function()
        local re = ReplicatedStorage:FindFirstChild("RE")
        if not re then
            return
        end

        local remote = re:FindFirstChild("1RPNam1eColo1r")
        if remote then
            remote:FireServer("PickingRPNameColor", color)
        end
    end)
end

local function getGradientColor(position)
    position = math.clamp(position, 0, 1)

    if position < 0.5 then
        local alpha = position * 2
        return Color3.new(
            SelectedColor.R * alpha,
            SelectedColor.G * alpha,
            SelectedColor.B * alpha
        )
    else
        local alpha = (position - 0.5) * 2
        return Color3.new(
            SelectedColor.R + (1 - SelectedColor.R) * alpha,
            SelectedColor.G + (1 - SelectedColor.G) * alpha,
            SelectedColor.B + (1 - SelectedColor.B) * alpha
        )
    end
end

local RGBRunning = true

task.spawn(function()
    local hue = 0

    while RGBRunning do
        if RGBEnabled then
            local speed = math.clamp(tonumber(AnimationSpeed) or 10, 0.1, 100)

            hue = (hue + (speed / 10000)) % 1

            local color = Color3.fromHSV(hue, 1, 1)

            setRPNameColor(color)

            task.wait(0.03)
        else
            task.wait(0.1)
        end
    end
end)

local function createHome()
    clearContent()

    local title = createContentTitle(T("home"))

    local community = makeText(Content, T("community"), 28)
    community.Position = UDim2.new(0, 32, 0, 85)
    community.Size = UDim2.new(1, -64, 0, 45)
    community.TextXAlignment = Enum.TextXAlignment.Left

    local brook = makeText(Content, T("brookhaven"), 17)
    brook.Position = UDim2.new(0, 32, 0, 130)
    brook.Size = UDim2.new(1, -64, 0, 30)
    brook.TextXAlignment = Enum.TextXAlignment.Left
    brook.TextColor3 = MUTED

    local LanguageBox = Instance.new("TextButton")
    LanguageBox.BackgroundColor3 = Color3.fromRGB(10, 11, 17)
    LanguageBox.Size = UDim2.new(0, 385, 0, 145)
    LanguageBox.Position = UDim2.new(0, 32, 0, 185)
    LanguageBox.Text = ""
    LanguageBox.AutoButtonColor = false
    LanguageBox.Parent = Content
    corner(LanguageBox, 15)
    stroke(LanguageBox, 2).Color = BORDER

    local languageTitle = makeText(LanguageBox, T("language"), 17)
    languageTitle.Size = UDim2.new(1, 0, 0, 30)
    languageTitle.Position = UDim2.new(0, 0, 0, 20)
    languageTitle.TextColor3 = MUTED

    local languageValue = makeText(LanguageBox, T("ruseng"), 25)
    languageValue.Size = UDim2.new(1, 0, 0, 40)
    languageValue.Position = UDim2.new(0, 0, 0, 67)

    LanguageBox.MouseButton1Click:Connect(function()
        if CurrentLanguage == "EN" then
            CurrentLanguage = "RU"
        else
            CurrentLanguage = "EN"
        end

        HomeButton.Text = T("home")
        NameButton.Text = T("name")
        CodesButton.Text = T("codes")
        AllButton.Text = T("all")
        MenuButton.Text = T("menu")
        Version.Text = T("version")
        Credits.Text = T("made")

        createHome()
    end)
end

local function createColorPicker(parent)
    local picker = Instance.new("Frame")
    picker.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
    picker.Size = UDim2.new(1, -50, 0, 80)
    picker.Position = UDim2.new(0, 25, 0, 65)
    picker.Parent = parent
    corner(picker, 12)
    stroke(picker, 1.5).Color = BORDER

    local hueGradient = Instance.new("UIGradient")
    hueGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
        ColorSequenceKeypoint.new(0.25, SelectedColor),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(0.75, SelectedColor),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
    })
    hueGradient.Parent = picker

    local bar = Instance.new("Frame")
    bar.BackgroundTransparency = 1
    bar.Size = UDim2.new(1, -24, 0, 30)
    bar.Position = UDim2.new(0, 12, 0.5, -15)
    bar.Parent = picker

    local barGradient = Instance.new("UIGradient")
    barGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
        ColorSequenceKeypoint.new(0.5, SelectedColor),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
    })
    barGradient.Parent = bar

    local point = Instance.new("Frame")
    point.Size = UDim2.new(0, 18, 0, 18)
    point.AnchorPoint = Vector2.new(0.5, 0.5)
    point.Position = UDim2.new(0.5, 0, 0.5, 0)
    point.BackgroundColor3 = Color3.new(1, 1, 1)
    point.Parent = bar
    corner(point, 20)
    stroke(point, 2).Color = Color3.new(0, 0, 0)

    local dragging = false

    local function updateColor(x)
        local left = bar.AbsolutePosition.X
        local width = bar.AbsoluteSize.X

        local value = math.clamp((x - left) / width, 0, 1)

        point.Position = UDim2.new(value, 0, 0.5, 0)

        local color

        if value <= 0.5 then
            local a = value * 2
            color = Color3.new(
                SelectedColor.R * a,
                SelectedColor.G * a,
                SelectedColor.B * a
            )
        else
            local a = (value - 0.5) * 2
            color = Color3.new(
                SelectedColor.R + (1 - SelectedColor.R) * a,
                SelectedColor.G + (1 - SelectedColor.G) * a,
                SelectedColor.B + (1 - SelectedColor.B) * a
            )
        end

        setRPNameColor(color)
    end

    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then

            dragging = true
            updateColor(input.Position.X)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if not dragging then
            return
        end

        if input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch then

            updateColor(input.Position.X)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then

            dragging = false
        end
    end)

    return picker
end

local function createNamePage()
    clearContent()

    createContentTitle(T("name"))

    local RGBLabel = makeText(Content, T("rgbname"), 17)
    RGBLabel.Position = UDim2.new(0, 25, 0, 55)
    RGBLabel.Size = UDim2.new(1, -50, 0, 25)
    RGBLabel.TextXAlignment = Enum.TextXAlignment.Center

    createColorPicker(Content)

    local SpeedLabel = makeText(Content, T("speed"), 17)
    SpeedLabel.Position = UDim2.new(0, 25, 0, 175)
    SpeedLabel.Size = UDim2.new(1, -50, 0, 25)
    SpeedLabel.TextXAlignment = Enum.TextXAlignment.Center

    local SpeedBox = Instance.new("TextBox")
    SpeedBox.BackgroundColor3 = Color3.fromRGB(250, 250, 250)
    SpeedBox.TextColor3 = Color3.fromRGB(20, 20, 25)
    SpeedBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 130)
    SpeedBox.Text = tostring(AnimationSpeed)
    SpeedBox.PlaceholderText = "1 - 100"
    SpeedBox.TextSize = 17
    SpeedBox.Font = Enum.Font.GothamBold
    SpeedBox.ClearTextOnFocus = false
    SpeedBox.Size = UDim2.new(1, -50, 0, 45)
    SpeedBox.Position = UDim2.new(0, 25, 0, 210)
    SpeedBox.Parent = Content
    corner(SpeedBox, 8)

    SpeedBox.FocusLost:Connect(function()
        local value = tonumber(SpeedBox.Text)

        if not value then
            SpeedBox.Text = tostring(AnimationSpeed)
            return
        end

        value = math.clamp(value, 0.1, 100)

        AnimationSpeed = value

        SpeedBox.Text = tostring(value)
    end)

    local Hint = makeText(
        Content,
        CurrentLanguage == "RU"
            and "Настрой скорость переливания от 0.1 до 100"
            or "Set animation speed from 0.1 to 100",
        13
    )

    Hint.Position = UDim2.new(0, 25, 0, 265)
    Hint.Size = UDim2.new(1, -50, 0, 25)
    Hint.TextColor3 = MUTED
    Hint.TextXAlignment = Enum.TextXAlignment.Center

    local Toggle = makeButton(
        Content,
        CurrentLanguage == "RU" and "RGB: ВКЛ" or "RGB: ON"
    )

    Toggle.Size = UDim2.new(0, 180, 0, 42)
    Toggle.Position = UDim2.new(0.5, -90, 0, 315)

    Toggle.MouseButton1Click:Connect(function()
        RGBEnabled = not RGBEnabled

        if RGBEnabled then
            Toggle.Text = CurrentLanguage == "RU" and "RGB: ВКЛ" or "RGB: ON"
        else
            Toggle.Text = CurrentLanguage == "RU" and "RGB: ВЫКЛ" or "RGB: OFF"
        end
    end)
end

local codes = {
    {"Юра Юра", "103953736675768"},
    {"ЧСВ", "121868521456313"},
    {"Да Да Нет Нет", "87021712935974"},
    {"Повод - Морген", "91668250502992"},
    {"Бизнесмен", "99251035171025"},
    {"Да я рок звезда", "82354197666120"},
    {"Коч братан (фулл)", "118574325152271"},

    {"C418 Key", "95772411739290"},
    {"Бабулька", "90243355455318"},
    {"4:30", "118758878350292"},
    {"Antidote", "103819129330228"},
    {"intelligensy", "73896930664817"},
    {"cachalot #2016", "98127054498202"},
    {"i got love", "116105881409379"},

    {"Мало тебя", "119639747686811"},
    {"trench boy", "140420698767512"},
    {"Нежеголь Украина", "135001518170813"},
    {"Лаки текк", "136314627320461"},
    {"Три полоски", "76399771617087"},
    {"Slava", "106746766859677"},
    {"c00lkid", "94635984925376"},

    {"Barbie", "72280182113154"},
    {"Barbie", "132255132560700"},
    {"Да я русский", "74865649597403"},
    {"Чечня", "112928384872852"},
    {"Japan?", "120880053875419"},
    {"Гимн твича", "95677706212116"}
}

local function createCodesPage()
    clearContent()

    createContentTitle(T("codes"))

    local Scroll = Instance.new("ScrollingFrame")
    Scroll.BackgroundTransparency = 1
    Scroll.BorderSizePixel = 0
    Scroll.Size = UDim2.new(1, -40, 1, -70)
    Scroll.Position = UDim2.new(0, 20, 0, 55)
    Scroll.ScrollBarThickness = 5
    Scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    Scroll.Parent = Content

    local Grid = Instance.new("UIGridLayout")
    Grid.CellSize = UDim2.new(0, 125, 0, 52)
    Grid.CellPadding = UDim2.new(0, 7, 0, 7)
    Grid.SortOrder = Enum.SortOrder.LayoutOrder
    Grid.Parent = Scroll

    for i, data in ipairs(codes) do
        local button = Instance.new("TextButton")
        button.BackgroundColor3 = Color3.fromRGB(245, 245, 247)
        button.TextColor3 = Color3.fromRGB(20, 20, 25)
        button.TextSize = 13
        button.Font = Enum.Font.GothamBold
        button.Text = data[1]
        button.AutoButtonColor = false
        button.LayoutOrder = i
        button.Parent = Scroll
        corner(button, 8)

        button.MouseEnter:Connect(function()
            button.BackgroundColor3 = Color3.fromRGB(220, 220, 225)
        end)

        button.MouseLeave:Connect(function()
            button.BackgroundColor3 = Color3.fromRGB(245, 245, 247)
        end)

        button.MouseButton1Click:Connect(function()
            pcall(function()
                setclipboard(data[2])
            end)

            notify(T("copy") .. " " .. data[1])
        end)
    end

    task.defer(function()
        Scroll.CanvasSize = UDim2.new(
            0,
            0,
            0,
            Grid.AbsoluteContentSize.Y + 10
        )
    end)
end

local function executeScript(url)
    task.spawn(function()
        local success, result = pcall(function()
            return loadstring(game:HttpGet(url))()
        end)

        if not success then
            warn("Etraxon script error:", result)
            notify("Script failed to load")
        end
    end)
end

local scripts = {
    {
        "Infinity yield",
        "loadstring(game:HttpGet(\"https://rawscripts.net/raw/Universal-Script-Infinite-Yield-43437\"))()"
    },
    {
        "®4D",
        "loadstring(game:HttpGet(\"https://rawscripts.net/raw/Brookhaven-RP-R4D-script-no-key-17562\"))()"
    },
    {
        "Targeter",
        "loadstring(game:HttpGet(\"https://raw.githubusercontent.com/ColorRed4/Apple-Targeter-V1.1/main/apple.main.lua\"))()"
    },
    {
        "Btr X client",
        "loadstring(game:HttpGet(\"https://btr.btrxclient.workers.dev/loader.lua\"))()"
    },
    {
        "Animation Hub",
        "loadstring(game:HttpGet(\"https://raw.githubusercontent.com/7yd7/Hub/refs/heads/Branch/GUIS/Emotes.lua\"))()"
    }
}

local function createAllPage()
    clearContent()

    createContentTitle(T("all"))

    local Scroll = Instance.new("ScrollingFrame")
    Scroll.BackgroundTransparency = 1
    Scroll.BorderSizePixel = 0
    Scroll.Size = UDim2.new(1, -40, 1, -70)
    Scroll.Position = UDim2.new(0, 20, 0, 55)
    Scroll.ScrollBarThickness = 5
    Scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    Scroll.Parent = Content

    local Layout = Instance.new("UIListLayout")
    Layout.Padding = UDim.new(0, 8)
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Parent = Scroll

    for i, data in ipairs(scripts) do
        local button = Instance.new("TextButton")
        button.BackgroundColor3 = SIDE
        button.TextColor3 = TEXT
        button.TextSize = 15
        button.Font = Enum.Font.GothamBold
        button.Text = data[1]
        button.AutoButtonColor = false
        button.Size = UDim2.new(0, 210, 0, 52)
        button.LayoutOrder = i
        button.Parent = Scroll
        corner(button, 9)

        local s = stroke(button, 1)
        s.Color = Color3.fromRGB(135, 20, 55)

        button.MouseEnter:Connect(function()
            button.BackgroundColor3 = SIDE_HOVER
        end)

        button.MouseLeave:Connect(function()
            button.BackgroundColor3 = SIDE
        end)

        button.MouseButton1Click:Connect(function()
            local fn = loadstring(data[2])
            if fn then
                task.spawn(function()
                    pcall(fn)
                end)
            end
        end)
    end

    task.defer(function()
        Scroll.CanvasSize = UDim2.new(
            0,
            0,
            0,
            Layout.AbsoluteContentSize.Y + 10
        )
    end)
end

local function showPage(page)
    CurrentPage = page

    if page == "home" then
        createHome()
    elseif page == "name" then
        createNamePage()
    elseif page == "codes" then
        createCodesPage()
    elseif page == "all" then
        createAllPage()
    end
end

HomeButton.MouseButton1Click:Connect(function()
    showPage("home")
end)

NameButton.MouseButton1Click:Connect(function()
    showPage("name")
end)

CodesButton.MouseButton1Click:Connect(function()
    showPage("codes")
end)

AllButton.MouseButton1Click:Connect(function()
    showPage("all")
end)

MenuButton.MouseButton1Click:Connect(function()
    MainOpen = not MainOpen

    if MainOpen then
        Main.Visible = true
        MenuButton.Text = T("menu")
    else
        Main.Visible = false
        MenuButton.Text = T("menu")
    end
end)

showPage("home")
