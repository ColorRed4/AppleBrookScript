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
local RGBThread = nil

local DARK = Color3.fromRGB(8, 9, 13)
local DARK2 = Color3.fromRGB(13, 14, 20)
local BUTTON = Color3.fromRGB(17, 18, 25)
local BUTTON_HOVER = Color3.fromRGB(25, 27, 38)

local WHITE = Color3.fromRGB(255, 255, 255)
local GRAY = Color3.fromRGB(170, 175, 185)

local CYAN = Color3.fromRGB(0, 220, 255)
local PURPLE = Color3.fromRGB(150, 70, 255)

local BURGUNDY = Color3.fromRGB(105, 0, 20)

local gui = Instance.new("ScreenGui")
gui.Name = "EtraxonMenu"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999
gui.Parent = PlayerGui

local function corner(parent, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius)
    c.Parent = parent
    return c
end

local function stroke(parent, color, thickness, transparency)
    local s = Instance.new("UIStroke")
    s.Color = color or WHITE
    s.Thickness = thickness or 1
    s.Transparency = transparency or 0
    s.Parent = parent
    return s
end

local function textLabel(parent, text, size, position, textSize)
    local t = Instance.new("TextLabel")
    t.BackgroundTransparency = 1
    t.Size = size
    t.Position = position
    t.Text = text
    t.TextColor3 = WHITE
    t.Font = Enum.Font.GothamBold
    t.TextSize = textSize or 14
    t.TextXAlignment = Enum.TextXAlignment.Left
    t.TextYAlignment = Enum.TextYAlignment.Center
    t.Parent = parent
    return t
end

local function button(parent, text, size, position)
    local b = Instance.new("TextButton")
    b.AutoButtonColor = false
    b.Size = size
    b.Position = position
    b.BackgroundColor3 = BUTTON
    b.BorderSizePixel = 0
    b.Text = text
    b.TextColor3 = WHITE
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.Parent = parent

    corner(b, 7)
    stroke(b, Color3.fromRGB(50, 55, 70), 1, 0.15)

    b.MouseEnter:Connect(function()
        b.BackgroundColor3 = BUTTON_HOVER
    end)

    b.MouseLeave:Connect(function()
        b.BackgroundColor3 = BUTTON
    end)

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
Main.Size = UDim2.new(0, 625, 0, 355)
Main.Position = UDim2.new(0.5, -312, 0.5, -177)
Main.BackgroundColor3 = DARK
Main.BackgroundTransparency = 0.16
Main.BorderSizePixel = 0
Main.Parent = gui

corner(Main, 12)

local MainStroke = stroke(
    Main,
    CYAN,
    2
)

local MainGradient = Instance.new("UIGradient")
MainGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 190, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(90, 90, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(190, 50, 255))
})
MainGradient.Rotation = 25
MainGradient.Parent = Main

local TopBar = Instance.new("Frame")
TopBar.BackgroundTransparency = 1
TopBar.Size = UDim2.new(1, -145, 0, 48)
TopBar.Position = UDim2.new(0, 12, 0, 0)
TopBar.Parent = Main

local Title = textLabel(
    TopBar,
    "home",
    UDim2.new(0, 170, 1, 0),
    UDim2.new(0, 5, 0, 0),
    20
)

local Credit = textLabel(
    TopBar,
    "script made by Etraxon community",
    UDim2.new(1, -170, 1, 0),
    UDim2.new(0, 170, 0, 0),
    14
)

Credit.TextXAlignment = Enum.TextXAlignment.Right
Credit.TextColor3 = Color3.fromRGB(205, 210, 225)
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

local Divider = Instance.new("Frame")
Divider.Size = UDim2.new(1, -24, 0, 1)
Divider.Position = UDim2.new(0, 12, 0, 47)
Divider.BackgroundColor3 = Color3.fromRGB(80, 90, 110)
Divider.BackgroundTransparency = 0.35
Divider.BorderSizePixel = 0
Divider.Parent = Main

local Side = Instance.new("Frame")
Side.Name = "Side"
Side.Size = UDim2.new(0, 118, 1, -64)
Side.Position = UDim2.new(0, 10, 0, 55)
Side.BackgroundColor3 = Color3.fromRGB(7, 8, 12)
Side.BackgroundTransparency = 0.12
Side.BorderSizePixel = 0
Side.Parent = Main

corner(Side, 10)

local SideStroke = stroke(
    Side,
    PURPLE,
    1.5,
    0.05
)

local function sideButton(text, y)
    local b = button(
        Side,
        text,
        UDim2.new(1, -12, 0, 43),
        UDim2.new(0, 6, 0, y)
    )

    b.TextSize = 13

    return b
end

local HomeButton = sideButton("home", 7)
local NameButton = sideButton("name / skin", 56)
local CodesButton = sideButton("codes", 105)
local AllScriptsButton = sideButton("All scripts", 154)

local Version = textLabel(
    Side,
    "V1.0",
    UDim2.new(1, 0, 0, 25),
    UDim2.new(0, 0, 1, -40),
    13
)

Version.TextXAlignment = Enum.TextXAlignment.Center
Version.TextColor3 = Color3.fromRGB(150, 155, 175)

local Content = Instance.new("Frame")
Content.Name = "Content"
Content.Size = UDim2.new(1, -145, 1, -64)
Content.Position = UDim2.new(0, 140, 0, 55)
Content.BackgroundColor3 = Color3.fromRGB(10, 11, 16)
Content.BackgroundTransparency = 0.22
Content.BorderSizePixel = 0
Content.Parent = Main

corner(Content, 10)
stroke(Content, Color3.fromRGB(50, 55, 70), 1, 0.35)

local function createPage()
    local p = Instance.new("Frame")
    p.BackgroundTransparency = 1
    p.Size = UDim2.new(1, -18, 1, -18)
    p.Position = UDim2.new(0, 9, 0, 9)
    p.Visible = false
    p.Parent = Content
    return p
end

local HomePage = createPage()
local NamePage = createPage()
local CodesPage = createPage()
local AllScriptsPage = createPage()

local HomeDescription = textLabel(
    HomePage,
    "Etraxon community",
    UDim2.new(1, -20, 0, 40),
    UDim2.new(0, 10, 0, 20),
    24
)

HomeDescription.TextColor3 = WHITE

local HomeSub = textLabel(
    HomePage,
    "Brookhaven RP",
    UDim2.new(1, -20, 0, 25),
    UDim2.new(0, 10, 0, 57),
    13
)

HomeSub.TextColor3 = GRAY

local LanguageBox = Instance.new("Frame")
LanguageBox.Size = UDim2.new(0, 230, 0, 86)
LanguageBox.Position = UDim2.new(0, 12, 0, 105)
LanguageBox.BackgroundColor3 = Color3.fromRGB(9, 10, 15)
LanguageBox.BackgroundTransparency = 0.08
LanguageBox.BorderSizePixel = 0
LanguageBox.Parent = HomePage

corner(LanguageBox, 9)

local LanguageStroke = stroke(
    LanguageBox,
    Color3.fromRGB(70, 85, 110),
    1.5
)

local LanguageTitle = textLabel(
    LanguageBox,
    "language",
    UDim2.new(1, -20, 0, 28),
    UDim2.new(0, 10, 0, 7),
    13
)

LanguageTitle.TextColor3 = GRAY
LanguageTitle.TextXAlignment = Enum.TextXAlignment.Center

local LanguageButton = Instance.new("TextButton")
LanguageButton.BackgroundTransparency = 1
LanguageButton.Size = UDim2.new(1, -20, 0, 38)
LanguageButton.Position = UDim2.new(0, 10, 0, 38)
LanguageButton.Text = "RUS / ENG"
LanguageButton.TextColor3 = WHITE
LanguageButton.Font = Enum.Font.GothamBold
LanguageButton.TextSize = 18
LanguageButton.Parent = LanguageBox

local NameTitle = textLabel(
    NamePage,
    "name / skin",
    UDim2.new(1, -20, 0, 35),
    UDim2.new(0, 10, 0, 5),
    20
)

local RGBTitle = textLabel(
    NamePage,
    "RGB NAME",
    UDim2.new(1, -20, 0, 28),
    UDim2.new(0, 10, 0, 42),
    13
)

RGBTitle.TextColor3 = GRAY
RGBTitle.TextXAlignment = Enum.TextXAlignment.Center

local PaletteHolder = Instance.new("Frame")
PaletteHolder.Size = UDim2.new(1, -28, 0, 48)
PaletteHolder.Position = UDim2.new(0, 14, 0, 70)
PaletteHolder.BackgroundColor3 = Color3.fromRGB(8, 9, 13)
PaletteHolder.BackgroundTransparency = 0.1
PaletteHolder.BorderSizePixel = 0
PaletteHolder.Parent = NamePage

corner(PaletteHolder, 9)
stroke(PaletteHolder, Color3.fromRGB(55, 60, 75), 1, 0.2)

local Palette = Instance.new("Frame")
Palette.Size = UDim2.new(1, -22, 0, 17)
Palette.Position = UDim2.new(0, 11, 0.5, -8)
Palette.BackgroundColor3 = WHITE
Palette.BorderSizePixel = 0
Palette.Parent = PaletteHolder

corner(Palette, 8)

local PaletteGradient = Instance.new("UIGradient")
PaletteGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.08, Color3.fromRGB(255, 60, 0)),
    ColorSequenceKeypoint.new(0.16, Color3.fromRGB(255, 150, 0)),
    ColorSequenceKeypoint.new(0.25, Color3.fromRGB(255, 255, 0)),
    ColorSequenceKeypoint.new(0.34, Color3.fromRGB(80, 255, 0)),
    ColorSequenceKeypoint.new(0.42, Color3.fromRGB(0, 255, 100)),
    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(0.59, Color3.fromRGB(0, 120, 255)),
    ColorSequenceKeypoint.new(0.68, Color3.fromRGB(90, 0, 255)),
    ColorSequenceKeypoint.new(0.77, Color3.fromRGB(180, 0, 255)),
    ColorSequenceKeypoint.new(0.88, Color3.fromRGB(255, 0, 180)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 0))
})
PaletteGradient.Parent = Palette

local PaletteButton = Instance.new("TextButton")
PaletteButton.BackgroundTransparency = 1
PaletteButton.Size = UDim2.new(1, 0, 1, 0)
PaletteButton.Text = ""
PaletteButton.ZIndex = 3
PaletteButton.Parent = Palette

local ColorKnob = Instance.new("Frame")
ColorKnob.Size = UDim2.new(0, 23, 0, 23)
ColorKnob.AnchorPoint = Vector2.new(0.5, 0.5)
ColorKnob.Position = UDim2.new(0, 0, 0.5, 0)
ColorKnob.BackgroundColor3 = SelectedColor
ColorKnob.BorderSizePixel = 0
ColorKnob.ZIndex = 5
ColorKnob.Parent = Palette

corner(ColorKnob, 50)
stroke(ColorKnob, WHITE, 2)

local ColorPreview = Instance.new("Frame")
ColorPreview.Size = UDim2.new(0, 13, 0, 13)
ColorPreview.AnchorPoint = Vector2.new(0.5, 0.5)
ColorPreview.Position = UDim2.new(0.5, 0, 0.5, 0)
ColorPreview.BackgroundColor3 = SelectedColor
ColorPreview.BorderSizePixel = 0
ColorPreview.ZIndex = 6
ColorPreview.Parent = ColorKnob

corner(ColorPreview, 50)

local SpeedTitle = textLabel(
    NamePage,
    "speed animation",
    UDim2.new(1, -20, 0, 28),
    UDim2.new(0, 10, 0, 133),
    13
)

SpeedTitle.TextColor3 = GRAY
SpeedTitle.TextXAlignment = Enum.TextXAlignment.Center

local SpeedBox = Instance.new("TextBox")
SpeedBox.Size = UDim2.new(0, 180, 0, 40)
SpeedBox.Position = UDim2.new(0.5, -90, 0, 163)
SpeedBox.BackgroundColor3 = Color3.fromRGB(240, 240, 245)
SpeedBox.BackgroundTransparency = 0
SpeedBox.BorderSizePixel = 0
SpeedBox.Text = "2"
SpeedBox.PlaceholderText = "2"
SpeedBox.TextColor3 = Color3.fromRGB(20, 20, 25)
SpeedBox.Font = Enum.Font.GothamBold
SpeedBox.TextSize = 17
SpeedBox.ClearTextOnFocus = false
SpeedBox.Parent = NamePage

corner(SpeedBox, 7)

local SpeedHint = textLabel(
    NamePage,
    "0.1 - 100",
    UDim2.new(1, -20, 0, 18),
    UDim2.new(0, 10, 0, 205),
    10
)

SpeedHint.TextColor3 = Color3.fromRGB(115, 120, 135)
SpeedHint.TextXAlignment = Enum.TextXAlignment.Center

local RGBButton = button(
    NamePage,
    "RGB: OFF",
    UDim2.new(0, 125, 0, 36),
    UDim2.new(0.5, -62, 1, -47)
)

RGBButton.TextSize = 12

local CodesTitle = textLabel(
    CodesPage,
    "codes",
    UDim2.new(1, -20, 0, 32),
    UDim2.new(0, 10, 0, 0),
    20
)

local CodesScroll = Instance.new("ScrollingFrame")
CodesScroll.Size = UDim2.new(1, -20, 1, -42)
CodesScroll.Position = UDim2.new(0, 10, 0, 37)
CodesScroll.BackgroundTransparency = 1
CodesScroll.BorderSizePixel = 0
CodesScroll.ScrollBarThickness = 4
CodesScroll.ScrollBarImageColor3 = CYAN
CodesScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
CodesScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
CodesScroll.ScrollingDirection = Enum.ScrollingDirection.Y
CodesScroll.Parent = CodesPage

local CodesLayout = Instance.new("UIGridLayout")
CodesLayout.CellSize = UDim2.new(0, 112, 0, 39)
CodesLayout.CellPadding = UDim2.new(0, 5, 0, 5)
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
    local b = button(
        CodesScroll,
        data[1],
        UDim2.new(0, 112, 0, 39),
        UDim2.new(0, 0, 0, 0)
    )

    b.LayoutOrder = index
    b.TextSize = 11

    b.MouseButton1Click:Connect(function()
        copyText(data[2])
    end)
end

local AllScriptsTitle = textLabel(
    AllScriptsPage,
    "All scripts",
    UDim2.new(1, -20, 0, 32),
    UDim2.new(0, 10, 0, 0),
    20
)

local function scriptButton(text, y)
    local b = button(
        AllScriptsPage,
        text,
        UDim2.new(0, 175, 0, 42),
        UDim2.new(0, 10, 0, y)
    )

    b.TextSize = 12

    return b
end

local InfinityButton = scriptButton("Infinity yield", 40)
local R4DButton = scriptButton("®4D", 88)
local TargeterButton = scriptButton("Targeter", 136)
local BTRButton = scriptButton("Btr X client", 184)
local AnimationHubButton = scriptButton("Animation Hub", 232)

local MenuButton = Instance.new("TextButton")
MenuButton.Name = "MenuButton"
MenuButton.Size = UDim2.new(0, 105, 0, 40)
MenuButton.Position = UDim2.new(0, 55, 0.5, -20)
MenuButton.BackgroundColor3 = Color3.fromRGB(8, 9, 13)
MenuButton.BackgroundTransparency = 0.05
MenuButton.BorderSizePixel = 0
MenuButton.Text = "MENU"
MenuButton.TextColor3 = WHITE
MenuButton.Font = Enum.Font.GothamBold
MenuButton.TextSize = 15
MenuButton.AutoButtonColor = false
MenuButton.Parent = gui

corner(MenuButton, 9)

local MenuStroke = stroke(
    MenuButton,
    CYAN,
    2
)

MenuButton.MouseEnter:Connect(function()
    MenuButton.BackgroundColor3 = Color3.fromRGB(18, 20, 30)
end)

MenuButton.MouseLeave:Connect(function()
    MenuButton.BackgroundColor3 = Color3.fromRGB(8, 9, 13)
end)

makeDraggable(Main, TopBar)
makeDraggable(MenuButton)

local function getNameRemote()
    local RE = ReplicatedStorage:FindFirstChild("RE")

    if not RE then
        return nil
    end

    return RE:FindFirstChild("1RPNam1eColo1r")
end

local function setNameColor(color)
    local remote = getNameRemote()

    if not remote then
        return
    end

    pcall(function()
        remote:FireServer("PickingRPNameColor", color)
    end)
end

local function colorFromPalette(x)
    return Color3.fromHSV(
        math.clamp(x, 0, 1),
        1,
        1
    )
end

local function updatePalette(x)
    x = math.clamp(x, 0, 1)

    SelectedColor = colorFromPalette(x)

    ColorKnob.Position = UDim2.new(
        x,
        0,
        0.5,
        0
    )

    ColorKnob.BackgroundColor3 = SelectedColor
    ColorPreview.BackgroundColor3 = SelectedColor

  if not RGBEnabled then
        setNameColor(SelectedColor)
    end
end

local paletteDragging = false

local function updatePaletteFromInput(position)
    local absolute = Palette.AbsolutePosition
    local size = Palette.AbsoluteSize

    if size.X <= 0 then
        return
    end

    local x = (position.X - absolute.X) / size.X

    updatePalette(x)
end

PaletteButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then

        paletteDragging = true
        updatePaletteFromInput(input.Position)
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

        updatePaletteFromInput(input.Position)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then

        paletteDragging = false
    end
end)

local function stopRGB()
    RGBEnabled = false
    RGBGeneration = RGBGeneration + 1
    RGBThread = nil

    setNameColor(SelectedColor)
end

local startRGB

startRGB = function()
    RGBEnabled = true

    RGBGeneration = RGBGeneration + 1

    local generation = RGBGeneration

    if RGBThread then
        RGBThread = nil
    end

    RGBThread = task.spawn(function()
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
                color = Color3.new(
                    SelectedColor.R * phase,
                    SelectedColor.G * phase,
                    SelectedColor.B * phase
                )

            elseif phase < 2 then
                local a = phase - 1

                color = Color3.new(
                    SelectedColor.R + (1 - SelectedColor.R) * a,
                    SelectedColor.G + (1 - SelectedColor.G) * a,
                    SelectedColor.B + (1 - SelectedColor.B) * a
                )

            elseif phase < 3 then
                local a = phase - 2

                color = Color3.new(
                    1 - (1 - SelectedColor.R) * a,
                    1 - (1 - SelectedColor.G) * a,
                    1 - (1 - SelectedColor.B) * a
                )

            else
                local a = phase - 3

                color = Color3.new(
                    SelectedColor.R * (1 - a),
                    SelectedColor.G * (1 - a),
                    SelectedColor.B * (1 - a)
                )
            end

            setNameColor(color)
        end
    end)
end

local function applySpeed()
    local value = tonumber(SpeedBox.Text)

    if not value then
        SpeedBox.Text = tostring(AnimationSpeed)
        return
    end

    value = math.clamp(value, 0.1, 100)

    AnimationSpeed = value
    SpeedBox.Text = tostring(value)

    if RGBEnabled then
        RGBGeneration = RGBGeneration + 1
        startRGB()
    end
end

SpeedBox.FocusLost:Connect(function()
    applySpeed()
end)

RGBButton.MouseButton1Click:Connect(function()
    if RGBEnabled then
        stopRGB()
        RGBButton.Text = "RGB: OFF"
    else
        startRGB()
        RGBButton.Text = "RGB: ON"
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

AllScriptsButton.MouseButton1Click:Connect(function()
    showPage(AllScriptsPage, "All scripts")
end)

LanguageButton.MouseButton1Click:Connect(function()
    if Language == "RU" then
        Language = "ENG"

        LanguageTitle.Text = "language"
        HomeDescription.Text = "Etraxon community"
        HomeSub.Text = "Brookhaven RP"

        RGBTitle.Text = "RGB NAME"
        SpeedTitle.Text = "speed animation"

        HomeButton.Text = "home"
        NameButton.Text = "name / skin"
        CodesButton.Text = "codes"
        AllScriptsButton.Text = "All scripts"

    else
        Language = "RU"

        LanguageTitle.Text = "язык"
        HomeDescription.Text = "Etraxon community"
        HomeSub.Text = "Brookhaven RP"

        RGBTitle.Text = "RGB ИМЯ"
        SpeedTitle.Text = "скорость"

        HomeButton.Text = "главная"
        NameButton.Text = "имя / скин"
        CodesButton.Text = "коды"
        AllScriptsButton.Text = "все скрипты"
    end
end)

MenuButton.MouseButton1Click:Connect(function()
    MenuOpen = not MenuOpen
    Main.Visible = MenuOpen
end)

InfinityButton.MouseButton1Click:Connect(function()
    pcall(function()
        loadstring(game:HttpGet(
            "https://rawscripts.net/raw/Universal-Script-Infinite-Yield-43437"
        ))()
    end)
end)

R4DButton.MouseButton1Click:Connect(function()
    pcall(function()
        loadstring(game:HttpGet(
            "https://rawscripts.net/raw/Brookhaven-RP-R4D-script-no-key-17562"
        ))()
    end)
end)

TargeterButton.MouseButton1Click:Connect(function()
    pcall(function()
        loadstring(game:HttpGet(
            "https://raw.githubusercontent.com/ColorRed4/Apple-Targeter-V1.1/main/apple.main.lua"
        ))()
    end)
end)

BTRButton.MouseButton1Click:Connect(function()
    pcall(function()
        loadstring(game:HttpGet(
            "https://btr.btrxclient.workers.dev/loader.lua"
        ))()
    end)
end)

AnimationHubButton.MouseButton1Click:Connect(function()
    pcall(function()
        loadstring(game:HttpGet(
            "https://raw.githubusercontent.com/7yd7/Hub/refs/heads/Branch/GUIS/Emotes.lua"
        ))()
    end)
end)

local lastRainbowUpdate = 0

RunService.RenderStepped:Connect(function()
    local now = os.clock()

    if now - lastRainbowUpdate < 0.025 then
        return
    end

    lastRainbowUpdate = now

    local hue = (now * 0.12) % 1

    local c1 = Color3.fromHSV(hue, 0.85, 1)
    local c2 = Color3.fromHSV((hue + 0.18) % 1, 0.85, 1)

    MainStroke.Color = c1
    SideStroke.Color = c2
    MenuStroke.Color = c1
end)

showPage(HomePage, "home")
updatePalette(0)

setNameColor(SelectedColor)
