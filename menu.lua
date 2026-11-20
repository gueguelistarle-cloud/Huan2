-- PURPLE MENU v2 • celular e PC

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local PASSWORD = "xitomesmovaichorar?"

local PURPLE = Color3.fromRGB(170, 90, 255)
local DARK = Color3.fromRGB(12, 10, 18)
local PANEL = Color3.fromRGB(30, 24, 42)
local PANEL2 = Color3.fromRGB(40, 32, 55)
local WHITE = Color3.fromRGB(245, 240, 255)
local GREEN = Color3.fromRGB(80, 255, 80)
local RED = Color3.fromRGB(255, 80, 80)

local options = {
    ESP = true,
    Box = true,
    BoxColor = Color3.fromRGB(80, 255, 80),
    Skeleton = false,
    Names = true,
    Distance = true,
    Health = true,
    Aim = false,
    TeamCheck = true,
    FOV = 180,
    Smoothness = 0.18,
    AimPart = "Head",
    ShowFOVCircle = true,
    Crosshair = false,
    ESPThickness = 2,
    NamesSize = 13,
}

local parent = (gethui and gethui()) or player:WaitForChild("PlayerGui")

local old = parent:FindFirstChild("PurpleMenu")
if old then old:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "PurpleMenu"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = parent

local function rounded(obj, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 8)
    c.Parent = obj
end

local function outline(obj, color, t)
    local s = Instance.new("UIStroke")
    s.Color = color or PURPLE
    s.Thickness = t or 1.5
    s.Parent = obj
end

local function label(parentObj, text, size, pos, ts)
    local l = Instance.new("TextLabel")
    l.BackgroundTransparency = 1
    l.Size = size
    l.Position = pos
    l.Text = text
    l.TextColor3 = WHITE
    l.TextSize = ts or 14
    l.Font = Enum.Font.Gotham
    l.Parent = parentObj
    return l
end

local function btn(parentObj, text, size, pos)
    local b = Instance.new("TextButton")
    b.Size = size
    b.Position = pos
    b.BackgroundColor3 = PANEL
    b.TextColor3 = WHITE
    b.Text = text
    b.TextSize = 14
    b.Font = Enum.Font.GothamBold
    b.Parent = parentObj
    rounded(b, 7)
    return b
end

local function tween(obj, time, props)
    TweenService:Create(obj, TweenInfo.new(time, Enum.EasingStyle.Quint), props):Play()
end

local function notify(text)
    local n = Instance.new("TextLabel")
    n.Size = UDim2.fromOffset(220, 38)
    n.Position = UDim2.new(1, 10, 1, -55)
    n.BackgroundColor3 = DARK
    n.TextColor3 = WHITE
    n.Font = Enum.Font.GothamBold
    n.TextSize = 13
    n.Text = text
    n.Parent = gui
    rounded(n, 8)
    outline(n)
    tween(n, 0.4, {Position = UDim2.new(1, -235, 1, -55)})
    task.delay(2.5, function()
        tween(n, 0.4, {Position = UDim2.new(1, 10, 1, -55)})
        task.wait(0.4)
        n:Destroy()
    end)
end

-- ========================
-- TELA DE SENHA
-- ========================

local login = Instance.new("Frame")
login.Size = UDim2.fromOffset(310, 200)
login.AnchorPoint = Vector2.new(0.5, 0.5)
login.Position = UDim2.fromScale(0.5, 0.5)
login.BackgroundColor3 = DARK
login.Parent = gui
rounded(login, 14)
outline(login, PURPLE, 2)

local lt = label(login, "PURPLE • ACESSO",
    UDim2.new(1, 0, 0, 45),
    UDim2.fromOffset(0, 5), 22)
lt.Font = Enum.Font.GothamBlack
lt.TextColor3 = PURPLE

local box = Instance.new("TextBox")
box.Size = UDim2.new(1, -40, 0, 40)
box.Position = UDim2.fromOffset(20, 58)
box.BackgroundColor3 = PANEL
box.TextColor3 = WHITE
box.PlaceholderText = "Digite a senha"
box.PlaceholderColor3 = Color3.fromRGB(150, 140, 165)
box.Text = ""
box.ClearTextOnFocus = false
box.Font = Enum.Font.Gotham
box.TextSize = 15
box.Parent = login
rounded(box)

local enter = btn(login, "ENTRAR",
    UDim2.new(1, -40, 0, 38),
    UDim2.fromOffset(20, 110))
enter.BackgroundColor3 = Color3.fromRGB(110, 45, 190)

local status = label(login, "",
    UDim2.new(1, 0, 0, 25),
    UDim2.fromOffset(0, 155), 13)
status.TextColor3 = Color3.fromRGB(255, 100, 130)

-- ========================
-- MENU PRINCIPAL
-- ========================

local menu = Instance.new("Frame")
menu.Size = UDim2.fromOffset(340, 400)
menu.AnchorPoint = Vector2.new(0.5, 0.5)
menu.Position = UDim2.fromScale(0.5, 0.5)
menu.BackgroundColor3 = DARK
menu.Visible = false
menu.Active = true
menu.Parent = gui
rounded(menu, 14)
outline(menu, PURPLE, 2)

local top = Instance.new("Frame")
top.Size = UDim2.new(1, 0, 0, 42)
top.BackgroundTransparency = 1
top.Parent = menu

-- Drag
local dragging, startPos, startInput
top.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        startInput = input.Position
        startPos = menu.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)
UIS.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch) then
        local d = input.Position - startInput
        menu.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + d.X,
            startPos.Y.Scale, startPos.Y.Offset + d.Y
        )
    end
end)

local title = label(menu, "PURPLE • MENU",
    UDim2.new(1, -60, 0, 40),
    UDim2.fromOffset(15, 2), 19)
title.Font = Enum.Font.GothamBlack
title.TextColor3 = PURPLE
title.TextXAlignment = Enum.TextXAlignment.Left

local close = btn(menu, "X",
    UDim2.fromOffset(30, 30),
    UDim2.new(1, -38, 0, 7))
close.MouseButton1Click:Connect(function()
    menu.Visible = false
end)

-- Abas laterais
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 100, 1, -55)
sidebar.Position = UDim2.fromOffset(8, 48)
sidebar.BackgroundColor3 = PANEL
sidebar.Parent = menu
rounded(sidebar, 8)

local sideLayout = Instance.new("UIListLayout")
sideLayout.Padding = UDim.new(0, 4)
sideLayout.Parent = sidebar

local sidePad = Instance.new("UIPadding")
sidePad.PaddingTop = UDim.new(0, 5)
sidePad.PaddingLeft = UDim.new(0, 5)
sidePad.PaddingRight = UDim.new(0, 5)
sidePad.Parent = sidebar

local content = Instance.new("Frame")
content.Size = UDim2.new(1, -122, 1, -58)
content.Position = UDim2.fromOffset(114, 52)
content.BackgroundTransparency = 1
content.Parent = menu

local tabs = {}

local function createTab(name)
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.fromScale(1, 1)
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 3
    page.ScrollBarImageColor3 = PURPLE
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.CanvasSize = UDim2.new()
    page.Visible = false
    page.Parent = content

    local pl = Instance.new("UIListLayout")
    pl.Padding = UDim.new(0, 5)
    pl.Parent = page

    local b = btn(sidebar, "", UDim2.new(1, 0, 0, 30), UDim2.new())
    b.BackgroundColor3 = DARK
    b.TextColor3 = Color3.fromRGB(160, 150, 175)
    b.Text = name
    b.TextSize = 12

    b.MouseButton1Click:Connect(function()
        for _, t in pairs(tabs) do
            t.Page.Visible = false
            t.Button.TextColor3 = Color3.fromRGB(160, 150, 175)
            t.Button.BackgroundColor3 = DARK
        end
        page.Visible = true
        b.TextColor3 = WHITE
        b.BackgroundColor3 = Color3.fromRGB(110, 45, 190)
    end)

    table.insert(tabs, {Page = page, Button = b})
    return page
end

local function addToggle(page, text, key)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -4, 0, 34)
    b.BackgroundColor3 = PANEL
    b.Text = ""
    b.Parent = page
    rounded(b, 6)

    local l = label(b, "",
        UDim2.new(1, -55, 1, 0),
        UDim2.fromOffset(8, 0), 13)
    l.TextXAlignment = Enum.TextXAlignment.Left

    local sw = Instance.new("Frame")
    sw.Size = UDim2.fromOffset(36, 18)
    sw.Position = UDim2.new(1, -44, 0.5, -9)
    sw.BackgroundColor3 = DARK
    sw.Parent = b
    rounded(sw, 9)

    local dot = Instance.new("Frame")
    dot.Size = UDim2.fromOffset(14, 14)
    dot.Position = UDim2.fromOffset(2, 2)
    dot.BackgroundColor3 = Color3.fromRGB(120, 110, 130)
    dot.Parent = sw
    rounded(dot, 7)

    local function refresh()
        l.Text = text
        l.TextColor3 = options[key] and WHITE or Color3.fromRGB(150, 140, 165)
        tween(dot, 0.2, {
            Position = options[key] and UDim2.fromOffset(20, 2) or UDim2.fromOffset(2, 2),
            BackgroundColor3 = options[key] and WHITE or Color3.fromRGB(120, 110, 130),
        })
        tween(sw, 0.2, {BackgroundColor3 = options[key] and PURPLE or DARK})
    end

    b.MouseButton1Click:Connect(function()
        options[key] = not options[key]
        refresh()
    end)
    refresh()
end

local function addCycle(page, text, key, values, labels)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -4, 0, 34)
    b.BackgroundColor3 = PANEL
    b.Text = ""
    b.Parent = page
    rounded(b, 6)

    local index = 1
    for i, v in ipairs(values) do
        if v == options[key] then index = i end
    end

    local l = label(b, "",
        UDim2.new(1, -10, 1, 0),
        UDim2.fromOffset(8, 0), 13)
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.TextColor3 = WHITE

    local function refresh()
        l.Text = text .. ": " .. (labels[index] or tostring(values[index]))
    end

    b.MouseButton1Click:Connect(function()
        index = index % #values + 1
        options[key] = values[index]
        refresh()
    end)
    refresh()
end

local function addSlider(page, text, key, min, max)
    local holder = Instance.new("Frame")
    holder.Size = UDim2.new(1, -4, 0, 48)
    holder.BackgroundColor3 = PANEL
    holder.Parent = page
    rounded(holder, 6)

    local l = label(holder, "",
        UDim2.new(1, -16, 0, 22),
        UDim2.fromOffset(8, 2), 13)
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.TextColor3 = WHITE

    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(1, -16, 0, 6)
    bar.Position = UDim2.fromOffset(8, 30)
    bar.BackgroundColor3 = DARK
    bar.Parent = holder
    rounded(bar, 3)

    local fill = Instance.new("Frame")
    fill.BackgroundColor3 = PURPLE
    fill.Parent = bar
    rounded(fill, 3)

    local function set(v)
        options[key] = math.clamp(math.floor(v + 0.5), min, max)
        fill.Size = UDim2.fromScale((options[key] - min) / (max - min), 1)
        l.Text = text .. ": " .. options[key]
    end

    local sliding = false
    local function update(x)
        local p = math.clamp((x - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
        set(min + (max - min) * p)
    end

    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            sliding = true
            update(input.Position.X)
        end
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            sliding = false
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if sliding and (input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch) then
            update(input.Position.X)
        end
    end)
    set(options[key])
end

local function addButton(page, text, callback)
    local b = btn(page, text, UDim2.new(1, -4, 0, 34), UDim2.new())
    b.BackgroundColor3 = Color3.fromRGB(110, 45, 190)
    b.MouseButton1Click:Connect(callback)
end

-- Abas
local tabESP = createTab("ESP")
local tabAim = createTab("Aimbot")
local tabMisc = createTab("Misc")
local tabInfo = createTab("Info")

-- ESP
addToggle(tabESP, "ESP geral", "ESP")
addToggle(tabESP, "Caixa", "Box")
addToggle(tabESP, "Esqueleto", "Skeleton")
addToggle(tabESP, "Nomes", "Names")
addToggle(tabESP, "Distância", "Distance")
addToggle(tabESP, "Vida", "Health")
addSlider(tabESP, "Espessura", "ESPThickness", 1, 5)
addSlider(tabESP, "Tamanho nome", "NamesSize", 10, 20)

local colorValues = {
    Color3.fromRGB(80, 255, 80),
    Color3.fromRGB(170, 90, 255),
    Color3.fromRGB(255, 80, 80),
    Color3.fromRGB(80, 180, 255),
    Color3.fromRGB(255, 255, 80),
}
local colorNames = {"Verde", "Roxo", "Vermelho", "Azul", "Amarelo"}
addCycle(tabESP, "Cor", "BoxColor", colorValues, colorNames)

-- Aimbot
addToggle(tabAim, "Aimbot", "Aim")
addToggle(tabAim, "Ignorar equipe", "TeamCheck")
addToggle(tabAim, "Mostrar FOV", "ShowFOVCircle")
addToggle(tabAim, "Mira central", "Crosshair")
addCycle(tabAim, "Parte alvo", "AimPart", {"Head", "HumanoidRootPart", "UpperTorso"}, {"Cabeça", "Raiz", "Tronco"})
addSlider(tabAim, "FOV", "FOV", 50, 500)
addSlider(tabAim, "Suavidade", "Smoothness", 5, 100)

-- Misc
addButton(tabMisc, "Notificação teste", function()
    notify("Menu v2 funcionando! 💜")
end)

-- Info
local infoText = label(tabInfo, "PURPLE MENU v2\n\nCria com IA\nAimbot + ESP\nSenhor: " .. player.DisplayName,
    UDim2.new(1, -8, 1, -8),
    UDim2.fromOffset(4, 4), 12)
infoText.TextColor3 = Color3.fromRGB(170, 160, 185)
infoText.TextWrapped = true
infoText.TextYAlignment = Enum.TextYAlignment.Top

tabs[1].Button.BackgroundColor3 = Color3.fromRGB(110, 45, 190)
tabs[1].Button.TextColor3 = WHITE
tabs[1].Page.Visible = true

-- ========================
-- BOTÕES CELULAR
-- ========================

local menuBtn = btn(gui, "MENU",
    UDim2.fromOffset(70, 38),
    UDim2.new(0, 10, 0.5, -20))
menuBtn.BackgroundColor3 = Color3.fromRGB(110, 45, 190)
menuBtn.Visible = false
outline(menuBtn, WHITE, 1)

local aimBtn = btn(gui, "SEGURE\nMIRA",
    UDim2.fromOffset(75, 50),
    UDim2.new(1, -85, 0.5, -25))
aimBtn.BackgroundColor3 = Color3.fromRGB(110, 45, 190)
aimBtn.Visible = false
outline(aimBtn, WHITE, 1)

local authenticated = false
local aiming = false

menuBtn.MouseButton1Click:Connect(function()
    menu.Visible = not menu.Visible
end)

aimBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseButton1 then
        aiming = true
    end
end)

aimBtn.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseButton1 then
        aiming = false
    end
end)

UIS.InputBegan:Connect(function(input, gp)
    if not gp and authenticated and input.KeyCode == Enum.KeyCode.RightShift then
        menu.Visible = not menu.Visible
    end
end)

enter.MouseButton1Click:Connect(function()
    if box.Text == PASSWORD then
        authenticated = true
        box.Text = ""
        login.Visible = false
        menu.Visible = true
        menuBtn.Visible = true
        aimBtn.Visible = UIS.TouchEnabled
        notify("Acesso liberado!")
    else
        status.Text = "Senha incorreta."
        box.Text = ""
    end
end)

-- ========================
-- FOV CIRCLE
-- ========================

local fovCircle = Instance.new("Frame")
fovCircle.Name = "FOVCircle"
fovCircle.Size = UDim2.fromOffset(options.FOV, options.FOV)
fovCircle.AnchorPoint = Vector2.new(0.5, 0.5)
fovCircle.Position = UDim2.fromScale(0.5, 0.5)
fovCircle.BackgroundTransparency = 1
fovCircle.Visible = false
fovCircle.Parent = gui

local fovCorner = Instance.new("UICorner")
fovCorner.CornerRadius = UDim.new(0.5, 0)
fovCorner.Parent = fovCircle

local fovStroke = Instance.new("UIStroke")
fovStroke.Color = PURPLE
fovStroke.Thickness = 1.5
fovStroke.Transparency = 0.5
fovStroke.Parent = fovCircle

-- Crosshair
local cross = Instance.new("Frame")
cross.Name = "Crosshair"
cross.Size = UDim2.fromOffset(16, 16)
cross.AnchorPoint = Vector2.new(0.5, 0.5)
cross.Position = UDim2.fromScale(0.5, 0.5)
cross.BackgroundTransparency = 1
cross.Visible = false
cross.Parent = gui

local crossLine1 = Instance.new("Frame")
crossLine1.Size = UDim2.fromOffset(16, 2)
crossLine1.Position = UDim2.fromOffset(0, 7)
crossLine1.BackgroundColor3 = PURPLE
crossLine1.Parent = cross

local crossLine2 = Instance.new("Frame")
crossLine2.Size = UDim2.fromOffset(2, 16)
crossLine2.Position = UDim2.fromOffset(7, 0)
crossLine2.BackgroundColor3 = PURPLE
crossLine2.Parent = cross

-- ========================
-- ESP
-- ========================

local overlay = Instance.new("Frame")
overlay.Size = UDim2.fromScale(1, 1)
overlay.BackgroundTransparency = 1
overlay.Parent = gui

local visuals = {}

local R15_BONES = {
    {"Head", "UpperTorso"},
    {"UpperTorso", "LowerTorso"},
    {"UpperTorso", "LeftUpperArm"},
    {"LeftUpperArm", "LeftLowerArm"},
    {"LeftLowerArm", "LeftHand"},
    {"UpperTorso", "RightUpperArm"},
    {"RightUpperArm", "RightLowerArm"},
    {"RightLowerArm", "RightHand"},
    {"LowerTorso", "LeftUpperLeg"},
    {"LeftUpperLeg", "LeftLowerLeg"},
    {"LeftLowerLeg", "LeftFoot"},
    {"LowerTorso", "RightUpperLeg"},
    {"RightUpperLeg", "RightLowerLeg"},
    {"RightLowerLeg", "RightFoot"},
}

local R6_BONES = {
    {"Head", "Torso"},
    {"Torso", "Left Arm"},
    {"Torso", "Right Arm"},
    {"Torso", "Left Leg"},
    {"Torso", "Right Leg"},
}

local function createVisual(target)
    if target == player or visuals[target] then return end

    local folder = Instance.new("Folder")
    folder.Name = target.Name
    folder.Parent = overlay

    local box = Instance.new("Frame")
    box.BackgroundTransparency = 1
    box.Visible = false
    box.Parent = folder

    local name = label(folder, "",
        UDim2.fromOffset(220, 20),
        UDim2.new(), 13)
    name.AnchorPoint = Vector2.new(0.5, 1)
    name.TextStrokeTransparency = 0.3
    name.TextColor3 = GREEN
    name.Font = Enum.Font.GothamBold
    name.Visible = false

    local dist = label(folder, "",
        UDim2.fromOffset(220, 18),
        UDim2.new(), 11)
    dist.AnchorPoint = Vector2.new(0.5, 0)
    dist.TextStrokeTransparency = 0.3
    dist.TextColor3 = GREEN
    dist.Font = Enum.Font.Gotham
    dist.Visible = false

    local lines = {}
    for i = 1, #R15_BONES do
        local line = Instance.new("Frame")
        line.BorderSizePixel = 0
        line.BackgroundColor3 = GREEN
        line.AnchorPoint = Vector2.new(0.5, 0.5)
        line.Visible = false
        line.Parent = folder
        lines[i] = line
    end

    visuals[target] = {
        folder = folder, box = box, name = name,
        dist = dist, lines = lines
    }
end

local function hideVisual(data)
    data.box.Visible = false
    data.name.Visible = false
    data.dist.Visible = false
    for _, line in ipairs(data.lines) do
        line.Visible = false
    end
end

local function validTarget(target)
    if target == player then return false end
    if options.TeamCheck and player.Team ~= nil
        and target.Team == player.Team then return false end
    local char = target.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    return char ~= nil and hum ~= nil and hum.Health > 0
end

local function project(cam, pos)
    local p, vis = cam:WorldToViewportPoint(pos)
    return Vector2.new(p.X, p.Y), vis and p.Z > 0
end

local function drawLine(line, a, b)
    local d = b - a
    line.Position = UDim2.fromOffset((a.X + b.X) / 2, (a.Y + b.Y) / 2)
    line.Size = UDim2.fromOffset(d.Magnitude, options.ESPThickness)
    line.Rotation = math.deg(math.atan2(d.Y, d.X))
    line.Visible = true
end

local function updateVisual(cam, target, data)
    hideVisual(data)

    if not authenticated or not options.ESP or not validTarget(target) then
        return
    end

    local char = target.Character
    local head = char:FindFirstChild("Head")
    local root = char:FindFirstChild("HumanoidRootPart")
    if not head or not root then return end

    local top, tv = project(cam, head.Position + Vector3.new(0, 0.7, 0))
    local bot, bv = project(cam, root.Position - Vector3.new(0, 3, 0))
    if not tv or not bv then return end

    local h = math.abs(bot.Y - top.Y)
    local w = h * 0.55
    local cx = (top.X + bot.X) / 2
    local ty = math.min(top.Y, bot.Y)
    local col = options.BoxColor

    if options.Box then
        data.box.Position = UDim2.fromOffset(cx - w / 2, ty)
        data.box.Size = UDim2.fromOffset(w, h)
        data.box.Visible = true

        -- Linhas da caixa (4 bordas)
        for _, line in ipairs(data.lines) do
            line.Visible = false
        end
        -- Desenhar bordas
        local corners = {
            {Vector2.new(cx - w/2, ty), Vector2.new(cx + w/2, ty)}, -- topo
            {Vector2.new(cx + w/2, ty), Vector2.new(cx + w/2, ty + h)}, -- direita
            {Vector2.new(cx + w/2, ty + h), Vector2.new(cx - w/2, ty + h)}, -- baixo
            {Vector2.new(cx - w/2, ty + h), Vector2.new(cx - w/2, ty)}, -- esquerda
        }
        for i, c in ipairs(corners) do
            if data.lines[i] then
                data.lines[i].BackgroundColor3 = col
                drawLine(data.lines[i], c[1], c[2])
            end
        end
    end

    if options.Names then
        data.name.Text = target.DisplayName
        data.name.TextSize = options.NamesSize
        data.name.TextColor3 = col
        data.name.Position = UDim2.fromOffset(cx, ty - 3)
        data.name.Visible = true
    end

    if options.Distance then
        local myRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if myRoot then
            local studs = math.floor((myRoot.Position - root.Position).Magnitude)
            local extra = ""
            if options.Health then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then
                    extra = " | HP: " .. math.floor(hum.Health)
                end
            end
            data.dist.Text = studs .. " Studs" .. extra
            data.dist.TextColor3 = col
            data.dist.Position = UDim2.fromOffset(cx, ty + h + 3)
            data.dist.Visible = true
        end
    elseif options.Health then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            data.dist.Text = "HP: " .. math.floor(hum.Health)
            data.dist.TextColor3 = col
            data.dist.Position = UDim2.fromOffset(cx, ty + h + 3)
            data.dist.Visible = true
        end
    end

    if options.Skeleton then
        local bones = char:FindFirstChild("UpperTorso") and R15_BONES or R6_BONES
        local startIdx = options.Box and 5 or 1
        for i = startIdx, #bones do
            local bi = bones[i]
            local a = char:FindFirstChild(bi[1])
            local b = char:FindFirstChild(bi[2])
            if a and b then
                local p1, v1 = project(cam, a.Position)
                local p2, v2 = project(cam, b.Position)
                if v1 and v2 then
                    if not data.lines[i] then
                        data.lines[i] = Instance.new("Frame")
                        data.lines[i].BorderSizePixel = 0
                        data.lines[i].AnchorPoint = Vector2.new(0.5, 0.5)
                        data.lines[i].Parent = data.folder
                    end
                    data.lines[i].BackgroundColor3 = col
                    drawLine(data.lines[i], p1, p2)
                end
            end
        end
    end
end

-- Conectar jogadores
for _, t in ipairs(Players:GetPlayers()) do
    createVisual(t)
end

local addConn = Players.PlayerAdded:Connect(createVisual)
local remConn = Players.PlayerRemoving:Connect(function(t)
    local d = visuals[t]
    if d then d.folder:Destroy(); visuals[t] = nil end
end)

-- ========================
-- RENDER LOOP
-- ========================

local renderConn
renderConn = RunService.RenderStepped:Connect(function()
    if not gui.Parent then
        renderConn:Disconnect()
        addConn:Disconnect()
        remConn:Disconnect()
        return
    end

    local cam = workspace.CurrentCamera
    if not cam then return end

    -- ESP
    for t, d in pairs(visuals) do
        updateVisual(cam, t, d)
    end

    -- FOV circle
    fovCircle.Visible = authenticated and options.Aim and options.ShowFOVCircle
    fovCircle.Size = UDim2.fromOffset(options.FOV, options.FOV)

    -- Crosshair
    cross.Visible = authenticated and options.Crosshair

    -- Aimbot
    if not authenticated or not options.Aim then return end

    local rightMouse = UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
    if not aiming and not rightMouse then return end

    local center
    if aiming and UIS.TouchEnabled then
        center = cam.ViewportSize / 2
    else
        center = UIS:GetMouseLocation()
    end

    local bestPart = nil
    local bestDist = options.FOV

    for _, t in ipairs(Players:GetPlayers()) do
        if validTarget(t) then
            local char = t.Character
            local targetPart = char:FindFirstChild(options.AimPart)
                or char:FindFirstChild("Head")
            if targetPart then
                local sp, vis = project(cam, targetPart.Position)
                local d = (sp - center).Magnitude
                if vis and d < bestDist then
                    bestDist = d
                    bestPart = targetPart
                end
            end
        end
    end

    if bestPart then
        local desired = CFrame.lookAt(cam.CFrame.Position, bestPart.Position)
        cam.CFrame = cam.CFrame:Lerp(desired, options.Smoothness / 100)
    end
end)
