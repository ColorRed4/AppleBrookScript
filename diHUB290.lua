local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

pcall(function()
    local old = PlayerGui:FindFirstChild("EtraxonMenu")
    if old then
        old:Destroy()
    end
end)

local Language = "RU"
local CurrentPage = "HOME"
local MenuOpen = true

local SelectedColor = Color3.fromRGB(255, 0, 0)
local AnimationSpeed = 2
local RGBEnabled = false
local RGBGeneration = 0

local DARK = Color3.fromRGB(7, 7, 7)
local DARK2 = Color3.fromRGB(12, 12, 12)
local RED = Color3.fromRGB(220, 0, 0)
local RED2 = Color3.fromRGB(145, 0, 0)
local WHITE = Color3.fromRGB(255, 255, 255)
local BLACK = Color3.fromRGB(0, 0, 0)

local gui = Instance.new("ScreenGui")
gui.Name = "EtraxonMenu"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999
gui.Parent = PlayerGui

local function createCorner(parent, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius)
    c.Parent = parent
    return c
end

local function createStroke(parent, color, thickness)
    local s = Instance.new("UIStroke")
    s.Color = color
    s.Thickness = thickness
    s.Transparency = 0
    s.Parent = parent
    return s
end

local function createText(parent, text, size, position, fontSize)
    local t = Instance.new("TextLabel")
    t.BackgroundTransparency = 1
    t.Size = size
    t.Position = position
    t.Text = text
    t.TextColor3 = WHITE
    t.Font = Enum.Font.GothamBold
    t.TextSize = fontSize
    t.TextXAlignment = Enum.TextXAlignment.Left
    t.TextYAlignment = Enum.TextYAlignment.Center
    t.Parent = parent
    return t
end

local function createButton(parent, text, size, position, color)
    local b = Instance.new("TextButton")
    b.AutoButtonColor = false
    b.Size = size
    b.Position = position
    b.BackgroundColor3 = color or RED
    b.BorderSizePixel = 0
    b.Text = text
    b.TextColor3 = WHITE
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.Parent = parent
    createCorner(b, 7)
    return b
end

local function makeDraggable(object, handle)
    handle = handle or object

    local dragging = false
    local dragStart
    local startPosition

    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

            dragging = true
            dragStart = input.Position
            startPosition = object.Position

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

            object.Position = UDim2.new(
                startPosition.X.Scale,
                startPosition.X.Offset + delta.X,
                startPosition.Y.Scale,
                startPosition.Y.Offset + delta.Y
            )
        end
    end)
end

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 550, 0, 310)
Main.Position = UDim2.new(0.5, -275, 0.5, -155)
Main.BackgroundColor3 = DARK
Main.BorderSizePixel = 0
Main.Parent = gui

createCorner(Main, 10)

local MainStroke = createStroke(
    Main,
    Color3.fromRGB(150, 0, 0),
    2
)

local Header = Instance.new("Frame")
Header.BackgroundTransparency = 1
Header.Size = UDim2.new(1, -105, 0, 42)
Header.Position = UDim2.new(0, 8, 0, 0)
Header.Parent = Main

local Title = createText(
    Header,
    "home",
    UDim2.new(0, 150, 1, 0),
    UDim2.new(0, 0, 0, 0),
    18
)

local Credit = createText(
    Header,
    "script made by Etraxon community",
    UDim2.new(1, -145, 1, 0),
    UDim2.new(0, 140, 0, 0),
    16
)

Credit.TextXAlignment = Enum.TextXAlignment.Right
Credit.Active = true

Credit.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        pcall(function()
            if setclipboard then
                setclipboard("https://t.me/Etraxon")
            end
        end)
    end
end)

local Side = Instance.new("Frame")
Side.Name = "Side"
Side.Size = UDim2.new(0, 92, 1, -10)
Side.Position = UDim2.new(1, -97, 0, 5)
Side.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
Side.BorderSizePixel = 0
Side.Parent = Main

createCorner(Side, 8)

local SideStroke = createStroke(
    Side,
    Color3.fromRGB(120, 0, 0),
    1.5
)

local HomeButton = createButton(
    Side,
    "home",
    UDim2.new(1, -8, 0, 43),
    UDim2.new(0, 4, 0, 4),
    RED
)

local NameButton = createButton(
    Side,
    "name / skin",
    UDim2.new(1, -8, 0, 43),
    UDim2.new(0, 4, 0, 52),
    RED
)

local TrollButton = createButton(
    Side,
    "troll",
    UDim2.new(1, -8, 0, 43),
    UDim2.new(0, 4, 0, 100),
    RED2
)

local CodesButton = createButton(
    Side,
    "codes",
    UDim2.new(1, -8, 0, 43),
    UDim2.new(0, 4, 0, 148),
    RED2
)

local Version = createText(
    Side,
    "V1.0",
    UDim2.new(1, 0, 0, 28),
    UDim2.new(0, 0, 0, 195),
    17
)

Version.TextColor3 = RED
Version.TextXAlignment = Enum.TextXAlignment.Center

local AllScripts = createButton(
    Side,
    "All scripts",
    UDim2.new(1, -8, 0, 43),
    UDim2.new(0, 4, 1, -47),
    RED2
)

local HomePage = Instance.new("Frame")
HomePage.Name = "HomePage"
HomePage.BackgroundTransparency = 1
HomePage.Size = UDim2.new(1, -105, 1, -50)
HomePage.Position = UDim2.new(0, 8, 0, 45)
HomePage.Parent = Main

local HomeLanguage = createText(
    HomePage,
    "language:",
    UDim2.new(0, 250, 0, 35),
    UDim2.new(0, 32, 0, 115),
    19
)

local LanguageButton = Instance.new("TextButton")
LanguageButton.BackgroundTransparency = 1
LanguageButton.Size = UDim2.new(0, 220, 0, 45)
LanguageButton.Position = UDim2.new(0, 30, 0, 150)
LanguageButton.Text = "RUS / ENG"
LanguageButton.TextColor3 = WHITE
LanguageButton.Font = Enum.Font.GothamBold
LanguageButton.TextSize = 23
LanguageButton.Parent = HomePage

local NamePage = Instance.new("Frame")
NamePage.Name = "NamePage"
NamePage.BackgroundTransparency = 1
NamePage.Size = UDim2.new(1, -105, 1, -50)
NamePage.Position = UDim2.new(0, 8, 0, 45)
NamePage.Visible = false
NamePage.Parent = Main

local RGBTitle = createText(
    NamePage,
    "RGB NAME",
    UDim2.new(1, -15, 0, 30),
    UDim2.new(0, 5, 0, 0),
    19
)

RGBTitle.TextXAlignment = Enum.TextXAlignment.Center

local PaletteHolder = Instance.new("Frame")
PaletteHolder.Size = UDim2.new(1, -30, 0, 42)
PaletteHolder.Position = UDim2.new(0, 15, 0, 37)
PaletteHolder.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
PaletteHolder.BorderSizePixel = 0
PaletteHolder.Parent = NamePage

createCorner(PaletteHolder, 9)

local Palette = Instance.new("Frame")
Palette.Size = UDim2.new(1, -16, 0, 16)
Palette.Position = UDim2.new(0, 8, 0.5, -8)
Palette.BackgroundColor3 = WHITE
Palette.BorderSizePixel = 0
Palette.Parent = PaletteHolder

createCorner(Palette, 8)

local PaletteGradient = Instance.new("UIGradient")
PaletteGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.08, Color3.fromRGB(255, 60, 0)),
    ColorSequenceKeypoint.new(0.16, Color3.fromRGB(255, 150, 0)),
    ColorSequenceKeypoint.new(0.25, Color3.fromRGB(255, 255, 0)),
    ColorSequenceKeypoint.new(0.33, Color3.fromRGB(80, 255, 0)),
    ColorSequenceKeypoint.new(0.42, Color3.fromRGB(0, 255, 80)),
    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(0.58, Color3.fromRGB(0, 120, 255)),
    ColorSequenceKeypoint.new(0.67, Color3.fromRGB(80, 0, 255)),
    ColorSequenceKeypoint.new(0.76, Color3.fromRGB(180, 0, 255)),
    ColorSequenceKeypoint.new(0.86, Color3.fromRGB(255, 0, 180)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 0))
})
PaletteGradient.Parent = Palette

local PaletteButton = Instance.new("TextButton")
PaletteButton.BackgroundTransparency = 1
PaletteButton.Size = UDim2.new(1, 0, 1, 0)
PaletteButton.Text = ""
PaletteButton.ZIndex = 2
PaletteButton.Parent = Palette

local ColorKnob = Instance.new("Frame")
ColorKnob.Size = UDim2.new(0, 24, 0, 24)
ColorKnob.AnchorPoint = Vector2.new(0.5, 0.5)
ColorKnob.Position = UDim2.new(0, 0, 0.5, 0)
ColorKnob.BackgroundColor3 = SelectedColor
ColorKnob.BorderSizePixel = 0
ColorKnob.ZIndex = 5
ColorKnob.Parent = Palette

createCorner(ColorKnob, 50)

createStroke(
    ColorKnob,
    WHITE,
    2
)

local ColorPreview = Instance.new("Frame")
ColorPreview.Size = UDim2.new(0, 20, 0, 20)
ColorPreview.AnchorPoint = Vector2.new(0.5, 0.5)
ColorPreview.Position = UDim2.new(0.5, 0, 0.5, 0)
ColorPreview.BackgroundColor3 = SelectedColor
ColorPreview.BorderSizePixel = 0
ColorPreview.ZIndex = 6
ColorPreview.Parent = ColorKnob

createCorner(ColorPreview, 50)

local SpeedTitle = createText(
    NamePage,
    "speed animation",
    UDim2.new(1, -15, 0, 30),
    UDim2.new(0, 5, 0, 94),
    19
)

SpeedTitle.TextXAlignment = Enum.TextXAlignment.Center

local SpeedBox = Instance.new("TextBox")
SpeedBox.Size = UDim2.new(1, -30, 0, 43)
SpeedBox.Position = UDim2.new(0, 15, 0, 128)
SpeedBox.BackgroundColor3 = WHITE
SpeedBox.BorderSizePixel = 0
SpeedBox.Text = "2"
SpeedBox.PlaceholderText = "2"
SpeedBox.TextColor3 = BLACK
SpeedBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
SpeedBox.Font = Enum.Font.GothamBold
SpeedBox.TextSize = 18
SpeedBox.ClearTextOnFocus = false
SpeedBox.Parent = NamePage

createCorner(SpeedBox, 7)

local SpeedHint = createText(
    NamePage,
    "0.1 - 100",
    UDim2.new(1, -30, 0, 20),
    UDim2.new(0, 15, 0, 174),
    11
)

SpeedHint.TextColor3 = Color3.fromRGB(130, 130, 130)
SpeedHint.TextXAlignment = Enum.TextXAlignment.Center

local RGBButton = createButton(
    NamePage,
    "RGB: OFF",
    UDim2.new(0, 120, 0, 36),
    UDim2.new(0.5, -60, 1, -45),
    RED2
)

local CodesPage = Instance.new("Frame")
CodesPage.Name = "CodesPage"
CodesPage.BackgroundTransparency = 1
CodesPage.Size = UDim2.new(1, -105, 1, -50)
CodesPage.Position = UDim2.new(0, 8, 0, 45)
CodesPage.Visible = false
CodesPage.Parent = Main

local CodesTitle = createText(
    CodesPage,
    "codes",
    UDim2.new(1, -15, 0, 30),
    UDim2.new(0, 5, 0, 0),
    19
)

local CodesScroll = Instance.new("ScrollingFrame")
CodesScroll.Size = UDim2.new(1, -20, 1, -35)
CodesScroll.Position = UDim2.new(0, 5, 0, 35)
CodesScroll.BackgroundTransparency = 1
CodesScroll.BorderSizePixel = 0
CodesScroll.ScrollBarThickness = 0
CodesScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
CodesScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
CodesScroll.ScrollingDirection = Enum.ScrollingDirection.Y
CodesScroll.Parent = CodesPage

local CodesLayout = Instance.new("UIGridLayout")
CodesLayout.CellSize = UDim2.new(0, 143, 0, 43)
CodesLayout.CellPadding = UDim2.new(0, 4, 0, 5)
CodesLayout.FillDirection = Enum.FillDirection.Horizontal
CodesLayout.FillDirectionMaxCells = 4
CodesLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
CodesLayout.SortOrder = Enum.SortOrder.LayoutOrder
CodesLayout.Parent = CodesScroll

local CodesData = {
    {"Юра Юра", "103953736675768"},
    {"C418 Key", "95772411739290"},
    {"Мало тебя", "119639747686811"},
    {"C00lkid", "94635984925376"},

    {"ЧСВ", "121868521456313"},
    {"Бабулька", "90243355455318"},
    {"trench boy", "140420698767512"},
    {"Barbie", "72280182113154"},

    {"Да Да Нет Нет", "87021712935974"},
    {"4:30", "118758878350292"},
    {"Нежеголь Украина", "135001518170813"},
    {"Barbie", "132255132560700"},

    {"Бизнесмен", "99251035171025"},
    {"AntiDote", "103819129330228"},
    {"Лаки текк", "136314627320461"},
    {"Да я русский", "74865649597403"},

    {"Повод - Морген", "91668250502992"},
    {"Intelligensy", "73896930664817"},
    {"Три полоски", "76399771617087"},
    {"Чечня", "112928384872852"},

    {"Да я рок звезда", "82354197666120"},
    {"cachalot #2016", "98127054498202"},
    {"Slava Гитлеру", "106746766859677"},
    {"Japan?", "120880053875419"},

    {"Коч братан (фулл)", "118574325152271"},
    {"i got love", "116105881409379"},
    {"Фешин", ""},
    {"Гимн твича", "95677706212116"}
}

local function copyText(value)
    if not value or value == "" then
        return
    end

    pcall(function()
        if setclipboard then
            setclipboard(tostring(value))
        end
    end)
end

for index, data in ipairs(CodesData) do
    local button = createButton(
        CodesScroll,
        data[1],
        UDim2.new(0, 143, 0, 43),
        UDim2.new(0, 0, 0, 0),
        WHITE
    )

    button.LayoutOrder = index
    button.TextColor3 = BLACK
    button.Font = Enum.Font.GothamBold
    button.TextSize = 13

    button.MouseButton1Click:Connect(function()
        copyText(data[2])
    end)
end
local AllScriptsPage = Instance.new("Frame")
AllScriptsPage.Name = "AllScriptsPage"
AllScriptsPage.BackgroundTransparency = 1
AllScriptsPage.Size = UDim2.new(1, -105, 1, -50)
AllScriptsPage.Position = UDim2.new(0, 8, 0, 45)
AllScriptsPage.Visible = false
AllScriptsPage.Parent = Main

local AllScriptsTitle = createText(
    AllScriptsPage,
    "All scripts",
    UDim2.new(1, -15, 0, 30),
    UDim2.new(0, 5, 0, 0),
    19
)

local ScriptButton1 = createButton(
    AllScriptsPage,
    "Infinity yield",
    UDim2.new(0, 168, 0, 42),
    UDim2.new(0, 5, 0, 28),
    RED
)

local ScriptButton2 = createButton(
    AllScriptsPage,
    "®4D",
    UDim2.new(0, 168, 0, 42),
    UDim2.new(0, 5, 0, 76),
    RED
)

local ScriptButton3 = createButton(
    AllScriptsPage,
    "Targeter",
    UDim2.new(0, 168, 0, 42),
    UDim2.new(0, 5, 0, 124),
    RED
)

local ScriptButton4 = createButton(
    AllScriptsPage,
    "Btr X client",
    UDim2.new(0, 168, 0, 42),
    UDim2.new(0, 5, 0, 172),
    RED
)

local EmptyScriptButton = createButton(
    AllScriptsPage,
    "",
    UDim2.new(0, 168, 0, 42),
    UDim2.new(0, 5, 0, 220),
    RED2
)

local MenuButton = createButton(
    gui,
    "MENU",
    UDim2.new(0, 115, 0, 42),
    UDim2.new(0, 70, 0.5, -21),
    Color3.fromRGB(5, 5, 5)
)

MenuButton.TextSize = 16

createStroke(
    MenuButton,
    Color3.fromRGB(150, 0, 0),
    2
)

makeDraggable(Main, Header)
makeDraggable(MenuButton)

local function getRemote()
    local re = ReplicatedStorage:FindFirstChild("RE")

    if not re then
        return nil
    end

    return re:FindFirstChild("1RPNam1eColo1r")
end

local function setNameColor(color)
    local remote = getRemote()

    if not remote then
        return false
    end

    local success = pcall(function()
        remote:FireServer("PickingRPNameColor", color)
    end)

    return success
end

local function colorFromPalette(x)
    x = math.clamp(x, 0, 1)
    return Color3.fromHSV(x, 1, 1)
end

local function updatePalettePosition(x)
    x = math.clamp(x, 0, 1)

    SelectedColor = colorFromPalette(x)

    ColorKnob.Position = UDim2.new(x, 0, 0.5, 0)
    ColorKnob.BackgroundColor3 = SelectedColor
    ColorPreview.BackgroundColor3 = SelectedColor

    if not RGBEnabled then
        setNameColor(SelectedColor)
    end
end

local paletteDragging = false

local function setPaletteFromInput(inputPosition)
    local absolute = Palette.AbsolutePosition
    local size = Palette.AbsoluteSize

    if size.X <= 0 then
        return
    end

    local x = (inputPosition.X - absolute.X) / size.X

    updatePalettePosition(x)
end

PaletteButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then

        paletteDragging = true
        setPaletteFromInput(input.Position)
    end
end)

ColorKnob.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then

        paletteDragging = true
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if not paletteDragging then
        return
    end

    if input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch then

        setPaletteFromInput(input.Position)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then

        paletteDragging = false
    end
end)

local function applySpeed()
    local value = tonumber(SpeedBox.Text)

    if not value then
        SpeedBox.Text = tostring(AnimationSpeed)
        return
    end

    value = math.clamp(value, 0.1, 100)

    AnimationSpeed = value
    SpeedBox.Text = tostring(value)

    RGBGeneration = RGBGeneration + 1
end

SpeedBox.FocusLost:Connect(function()
    applySpeed()
end)

SpeedBox:GetPropertyChangedSignal("Text"):Connect(function()
    local value = tonumber(SpeedBox.Text)

    if value and value > 100 then
        SpeedBox.Text = "100"
        AnimationSpeed = 100
        RGBGeneration = RGBGeneration + 1
    end
end)

local function blend(a, b, alpha)
    return Color3.new(
        a.R + (b.R - a.R) * alpha,
        a.G + (b.G - a.G) * alpha,
        a.B + (b.B - a.B) * alpha
    )
end

local function stopRGB()
    RGBEnabled = false
    RGBGeneration = RGBGeneration + 1

    setNameColor(SelectedColor)
end

local function startRGB()
    RGBEnabled = true
    RGBGeneration = RGBGeneration + 1

    local generation = RGBGeneration

    task.spawn(function()
        local phase = 0

        while RGBEnabled and generation == RGBGeneration do
            local dt = RunService.RenderStepped:Wait()

            if not RGBEnabled or generation ~= RGBGeneration then
                break
            end

            local speed = math.clamp(
                tonumber(AnimationSpeed) or 2,
                0.1,
                100
            )

            phase = phase + dt * speed

            while phase >= 4 do
                phase = phase - 4
            end

            local color

            if phase < 1 then
                color = blend(
                    BLACK,
                    SelectedColor,
                    phase
                )
            elseif phase < 2 then
                color = blend(
                    SelectedColor,
                    WHITE,
                    phase - 1
                )
            elseif phase < 3 then
                color = blend(
                    WHITE,
                    SelectedColor,
                    phase - 2
                )
            else
                color = blend(
                    SelectedColor,
                    BLACK,
                    phase - 3
                )
            end

            setNameColor(color)
        end
    end)
end

RGBButton.MouseButton1Click:Connect(function()
    if RGBEnabled then
        stopRGB()
        RGBButton.Text = "RGB: OFF"
        RGBButton.BackgroundColor3 = RED2
    else
        startRGB()
        RGBButton.Text = "RGB: ON"
        RGBButton.BackgroundColor3 = RED
    end
end)

local function showPage(page, title)
    HomePage.Visible = false
    NamePage.Visible = false
    CodesPage.Visible = false
    AllScriptsPage.Visible = false

    page.Visible = true
    CurrentPage = title
    Title.Text = title
end

HomeButton.MouseButton1Click:Connect(function()
    showPage(HomePage, "home")
end)

NameButton.MouseButton1Click:Connect(function()
    showPage(NamePage, "name / skin")
end)

CodesButton.MouseButton1Click:Connect(function()
    showPage(CodesPage, "codes")
end)

AllScripts.MouseButton1Click:Connect(function()
    showPage(AllScriptsPage, "All scripts")
end)

TrollButton.MouseButton1Click:Connect(function()
    showPage(HomePage, "troll")
end)

LanguageButton.MouseButton1Click:Connect(function()
    if Language == "RU" then
        Language = "ENG"

        HomeLanguage.Text = "language:"
        RGBTitle.Text = "RGB NAME"
        SpeedTitle.Text = "speed animation"
        SpeedHint.Text = "0.1 - 100"

        HomeButton.Text = "home"
        NameButton.Text = "name / skin"
        TrollButton.Text = "troll"
        CodesButton.Text = "codes"
        AllScripts.Text = "All scripts"
    else
        Language = "RU"

        HomeLanguage.Text = "язык:"
        RGBTitle.Text = "RGB ИМЯ"
        SpeedTitle.Text = "скорость"
        SpeedHint.Text = "0.1 - 100"

        HomeButton.Text = "главная"
        NameButton.Text = "имя / скин"
        TrollButton.Text = "тролль"
        CodesButton.Text = "коды"
        AllScripts.Text = "все скрипты"
    end
end)

MenuButton.MouseButton1Click:Connect(function()
    MenuOpen = not MenuOpen

    Main.Visible = MenuOpen
end)

ScriptButton1.MouseButton1Click:Connect(function()
    pcall(function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Infinite-Yield-43437"))()
    end)
end)

ScriptButton2.MouseButton1Click:Connect(function()
    pcall(function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Brookhaven-RP-R4D-script-no-key-17562"))()
    end)
end)

ScriptButton3.MouseButton1Click:Connect(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ColorRed4/Apple-Targeter-V1.1/main/apple.main.lua"))()
    end)
end)

ScriptButton4.MouseButton1Click:Connect(function()
    pcall(function()
        loadstring(game:HttpGet("https://btr.btrxclient.workers.dev/loader.lua"))()
    end)
end)

local borderConnection

borderConnection = RunService.RenderStepped:Connect(function()
    local t = os.clock() * 0.5

    local color = Color3.fromHSV(
        (t % 3) / 3,
        1,
        1
    )

    MainStroke.Color = color
    SideStroke.Color = color
end)

showPage(HomePage, "home")

updatePalettePosition(0)

setNameColor(SelectedColor)
