local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

local allowedUsers = {
    1158632168,
    87654321
}

local player = Players.LocalPlayer

local function isUserAllowed(userId)
    for _, id in ipairs(allowedUsers) do
        if id == userId then
            return true
        end
    end
    return false
end

if not isUserAllowed(player.UserId) then
    player:Kick("비타 스크립트 구매 후 이용해 주세요")
    return
end

local playerGui = player:WaitForChild("PlayerGui")
local camera = workspace.CurrentCamera
local targetLocation = Vector3.new(8.35, 16.79, -60.06)
local scriptStartTime = os.time()

local function saveConfig(miniX, miniY)
    local data = {
        miniX = miniX, miniY = miniY
    }
    pcall(function()
        if writefile then
            writefile("VitaVitaHub_MiniConfig.json", HttpService:JSONEncode(data))
        end
    end)
end

local function loadConfig()
    local success, result = pcall(function()
        if readfile and isfile and isfile("VitaVitaHub_MiniConfig.json") then
            return HttpService:JSONDecode(readfile("VitaVitaHub_MiniConfig.json"))
        end
    end)
    if success and result then
        return result
    end
    return nil
end

local savedPos = loadConfig()

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "비타비타"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local loadingFrame = Instance.new("Frame")
loadingFrame.Name = "LoadingFrame"
loadingFrame.Size = UDim2.new(0, 300, 0, 150)
loadingFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
loadingFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
loadingFrame.BorderSizePixel = 0
loadingFrame.Parent = screenGui

local loadingCorner = Instance.new("UICorner")
loadingCorner.CornerRadius = UDim.new(0, 12)
loadingCorner.Parent = loadingFrame

local loadingStroke = Instance.new("UIStroke")
loadingStroke.Thickness = 1.5
loadingStroke.Color = Color3.fromRGB(0, 200, 255)
loadingStroke.Parent = loadingFrame

local loadingTitle = Instance.new("TextLabel")
loadingTitle.Size = UDim2.new(1, 0, 0, 40)
loadingTitle.Position = UDim2.new(0, 0, 0, 20)
loadingTitle.BackgroundTransparency = 1
loadingTitle.Text = "VITA VITA HUB"
loadingTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
loadingTitle.Font = Enum.Font.GothamBold
loadingTitle.TextSize = 18
loadingTitle.Parent = loadingFrame

local loadingStatus = Instance.new("TextLabel")
loadingStatus.Size = UDim2.new(1, 0, 0, 20)
loadingStatus.Position = UDim2.new(0, 0, 0, 60)
loadingStatus.BackgroundTransparency = 1
loadingStatus.Text = "Loading Systems... 0%"
loadingStatus.TextColor3 = Color3.fromRGB(0, 200, 255)
loadingStatus.Font = Enum.Font.Gotham
loadingStatus.TextSize = 12
loadingStatus.Parent = loadingFrame

local barBackground = Instance.new("Frame")
barBackground.Size = UDim2.new(0, 240, 0, 6)
barBackground.Position = UDim2.new(0.5, -120, 0, 100)
barBackground.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
barBackground.BorderSizePixel = 0
barBackground.Parent = loadingFrame

local barBgCorner = Instance.new("UICorner")
barBgCorner.CornerRadius = UDim.new(1, 0)
barBgCorner.Parent = barBackground

local barFill = Instance.new("Frame")
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
barFill.BorderSizePixel = 0
barFill.Parent = barBackground

local barFillCorner = Instance.new("UICorner")
barFillCorner.CornerRadius = UDim.new(1, 0)
barFillCorner.Parent = barFill

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 440, 0, 320)
mainFrame.Position = UDim2.new(0.5, -220, 0.5, -160)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
mainFrame.BackgroundTransparency = 0.15
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Visible = false
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 16)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Thickness = 2
mainStroke.Color = Color3.fromRGB(0, 200, 255)
mainStroke.Transparency = 0.2
mainStroke.Parent = mainFrame

local dragBar = Instance.new("Frame")
dragBar.Name = "DragBar"
dragBar.Size = UDim2.new(1, 0, 0, 45)
dragBar.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
dragBar.BackgroundTransparency = 0.15
dragBar.BorderSizePixel = 0
dragBar.Parent = mainFrame

local dragBarCorner = Instance.new("UICorner")
dragBarCorner.CornerRadius = UDim.new(0, 16)
dragBarCorner.Parent = dragBar

local dragBarFix = Instance.new("Frame")
dragBarFix.Name = "Fix"
dragBarFix.Size = UDim2.new(1, 0, 0, 15)
dragBarFix.Position = UDim2.new(0, 0, 1, -15)
dragBarFix.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
dragBarFix.BackgroundTransparency = 0.15
dragBarFix.BorderSizePixel = 0
dragBarFix.Parent = dragBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(1, -80, 1, 0)
titleLabel.Position = UDim2.new(0, 18, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "비타비타"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 16
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = dragBar

local titleGradient = Instance.new("UIGradient")
titleGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 150, 255))
})
titleGradient.Parent = titleLabel

local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -40, 0, 7)
closeButton.BackgroundTransparency = 1
closeButton.Text = "×"
closeButton.TextColor3 = Color3.fromRGB(255, 75, 75)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 26
closeButton.Parent = dragBar

local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "MinimizeButton"
minimizeButton.Size = UDim2.new(0, 30, 0, 30)
minimizeButton.Position = UDim2.new(1, -75, 0, 7)
minimizeButton.BackgroundTransparency = 1
minimizeButton.Text = "−"
minimizeButton.TextColor3 = Color3.fromRGB(150, 150, 160)
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.TextSize = 22
minimizeButton.Parent = dragBar

local sideBar = Instance.new("Frame")
sideBar.Name = "SideBar"
sideBar.Size = UDim2.new(0, 120, 1, -45)
sideBar.Position = UDim2.new(0, 0, 0, 45)
sideBar.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
sideBar.BackgroundTransparency = 0.55
sideBar.BorderSizePixel = 0
sideBar.Parent = mainFrame

local function createTabButton(name, text, posIndex)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(1, -16, 0, 30)
    btn.Position = UDim2.new(0, 8, 0, 10 + (posIndex * 34))
    btn.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(160, 160, 170)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    btn.Parent = sideBar

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn
    
    return btn
end

local mainTabBtn = createTabButton("MainTabBtn", "이동 및 유틸", 0)
mainTabBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
mainTabBtn.TextColor3 = Color3.fromRGB(0, 200, 255)

local playerTabBtn = createTabButton("PlayerTabBtn", "플레이어", 1)
local visualTabBtn = createTabButton("VisualTabBtn", "비주얼", 2)
local systemTabBtn = createTabButton("SystemTabBtn", "시스템 성능", 3)
local zombieTabBtn = createTabButton("ZombieTabBtn", "좀비 아레나", 4)

local profileFrame = Instance.new("Frame")
profileFrame.Name = "ProfileFrame"
profileFrame.Size = UDim2.new(1, 0, 0, 95)
profileFrame.Position = UDim2.new(0, 0, 1, -95)
profileFrame.BackgroundTransparency = 1
profileFrame.Parent = sideBar

local avatarImage = Instance.new("ImageLabel")
avatarImage.Name = "AvatarImage"
avatarImage.Size = UDim2.new(0, 42, 0, 42)
avatarImage.Position = UDim2.new(0.5, -21, 0, 4)
avatarImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
avatarImage.BackgroundTransparency = 1
avatarImage.BorderSizePixel = 0
avatarImage.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. player.UserId .. "&width=150&height=150&format=png"
avatarImage.Parent = profileFrame

local avatarCorner = Instance.new("UICorner")
avatarCorner.CornerRadius = UDim.new(1, 0)
avatarCorner.Parent = avatarImage

local avatarStroke = Instance.new("UIStroke")
avatarStroke.Thickness = 1.5
avatarStroke.Color = Color3.fromRGB(0, 200, 255)
avatarStroke.Parent = avatarImage

local nameLabel = Instance.new("TextLabel")
nameLabel.Name = "NameLabel"
nameLabel.Size = UDim2.new(1, -10, 0, 18)
nameLabel.Position = UDim2.new(0, 5, 0, 48)
nameLabel.BackgroundTransparency = 1
nameLabel.Text = player.DisplayName
nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
nameLabel.Font = Enum.Font.GothamBold
nameLabel.TextSize = 11
nameLabel.TextTruncate = Enum.TextTruncate.AtEnd
nameLabel.Parent = profileFrame

local timeLabel = Instance.new("TextLabel")
timeLabel.Name = "TimeLabel"
timeLabel.Size = UDim2.new(1, -10, 0, 15)
timeLabel.Position = UDim2.new(0, 5, 0, 66)
timeLabel.BackgroundTransparency = 1
timeLabel.Text = "00:00:00"
timeLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
timeLabel.Font = Enum.Font.Code
timeLabel.TextSize = 11
timeLabel.Parent = profileFrame

local contentFrame = Instance.new("Frame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, -120, 1, -45)
contentFrame.Position = UDim2.new(0, 120, 0, 45)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

local mainPage = Instance.new("Frame")
mainPage.Name = "MainPage"
mainPage.Size = UDim2.new(1, 0, 1, 0)
mainPage.BackgroundTransparency = 1
mainPage.Visible = true
mainPage.Parent = contentFrame

local mainScroll = Instance.new("ScrollingFrame")
mainScroll.Size = UDim2.new(1, 0, 1, -40)
mainScroll.BackgroundTransparency = 1
mainScroll.CanvasSize = UDim2.new(0, 0, 0, 200)
mainScroll.ScrollBarThickness = 4
mainScroll.ScrollBarImageColor3 = Color3.fromRGB(50, 50, 60)
mainScroll.Parent = mainPage

local function createToggleRow(parent, text, position, hasInput)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, -32, 0, 45)
    row.Position = position
    row.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
    row.BorderSizePixel = 0
    row.Parent = parent

    local rowCorner = Instance.new("UICorner")
    rowCorner.CornerRadius = UDim.new(0, 10)
    rowCorner.Parent = row

    local rowStroke = Instance.new("UIStroke")
    rowStroke.Thickness = 1.5
    rowStroke.Color = Color3.fromRGB(50, 50, 60)
    rowStroke.Parent = row

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -120, 1, 0)
    label.Position = UDim2.new(0, 15, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(160, 160, 170)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = row

    local switchBox = Instance.new("TextButton")
    switchBox.Size = UDim2.new(0, 44, 0, 22)
    switchBox.Position = UDim2.new(1, -54, 0.5, -11)
    switchBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    switchBox.BorderSizePixel = 0
    switchBox.Text = ""
    switchBox.Parent = row

    local switchCorner = Instance.new("UICorner")
    switchCorner.CornerRadius = UDim.new(1, 0)
    switchCorner.Parent = switchBox

    local switchCircle = Instance.new("Frame")
    switchCircle.Size = UDim2.new(0, 16, 0, 16)
    switchCircle.Position = UDim2.new(0, 3, 0.5, -8)
    switchCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    switchCircle.BorderSizePixel = 0
    switchCircle.Parent = switchBox

    local circleCorner = Instance.new("UICorner")
    circleCorner.CornerRadius = UDim.new(1, 0)
    circleCorner.Parent = switchCircle

    local textBox
    if hasInput then
        switchBox.Position = UDim2.new(1, -114, 0.5, -11)
        textBox = Instance.new("TextBox")
        textBox.Size = UDim2.new(0, 50, 0, 26)
        textBox.Position = UDim2.new(1, -60, 0.5, -13)
        textBox.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
        textBox.BorderSizePixel = 0
        textBox.Text = hasInput
        textBox.TextColor3 = Color3.fromRGB(0, 200, 255)
        textBox.Font = Enum.Font.GothamBold
        textBox.TextSize = 13
        textBox.ClearTextOnFocus = false
        textBox.Parent = row

        local boxCorner = Instance.new("UICorner")
        boxCorner.CornerRadius = UDim.new(0, 6)
        boxCorner.Parent = textBox

        local boxStroke = Instance.new("UIStroke")
        boxStroke.Thickness = 1
        boxStroke.Color = Color3.fromRGB(0, 200, 255)
        boxStroke.Parent = textBox
    end

    return switchBox, switchCircle, rowStroke, label, textBox
end

local flyBtn, flyCircle, flyStrk, flyLbl, flyBox = createToggleRow(mainScroll, "자유 비행 (Fly)", UDim2.new(0, 16, 0, 15), "50")
local antiAfkBtn, antiAfkCircle, antiAfkStrk, antiAfkLbl = createToggleRow(mainScroll, "24시간 자동 잠수 방지", UDim2.new(0, 16, 0, 70), false)
local noclipBtn, noclipCircle, noclipStrk, noclipLbl = createToggleRow(mainScroll, "벽 통과 (노클립)", UDim2.new(0, 16, 0, 125), false)

local playerPage = Instance.new("Frame")
playerPage.Name = "PlayerPage"
playerPage.Size = UDim2.new(1, 0, 1, 0)
playerPage.BackgroundTransparency = 1
playerPage.Visible = false
playerPage.Parent = contentFrame

local playerScroll = Instance.new("ScrollingFrame")
playerScroll.Size = UDim2.new(1, 0, 1, -40)
playerScroll.BackgroundTransparency = 1
playerScroll.CanvasSize = UDim2.new(0, 0, 0, 200)
playerScroll.ScrollBarThickness = 4
playerScroll.ScrollBarImageColor3 = Color3.fromRGB(50, 50, 60)
playerScroll.Parent = playerPage

local speedBtn, speedCircle, speedStrk, speedLbl, speedBox = createToggleRow(playerScroll, "스피드 핵 설정", UDim2.new(0, 16, 0, 15), "100")
local jumpBtn, jumpCircle, jumpStrk, jumpLbl, jumpBox = createToggleRow(playerScroll, "점프 핵 설정", UDim2.new(0, 16, 0, 70), "120")
local infJumpBtn, infJumpCircle, infJumpStrk, infJumpLbl = createToggleRow(playerScroll, "무한 점프 설정", UDim2.new(0, 16, 0, 125), false)

local visualPage = Instance.new("Frame")
visualPage.Name = "VisualPage"
visualPage.Size = UDim2.new(1, 0, 1, 0)
visualPage.BackgroundTransparency = 1
visualPage.Visible = false
visualPage.Parent = contentFrame

local visualScroll = Instance.new("ScrollingFrame")
visualScroll.Size = UDim2.new(1, 0, 1, -40)
visualScroll.BackgroundTransparency = 1
visualScroll.CanvasSize = UDim2.new(0, 0, 0, 200)
visualScroll.ScrollBarThickness = 4
visualScroll.ScrollBarImageColor3 = Color3.fromRGB(50, 50, 60)
visualScroll.Parent = visualPage

local espBtn, espCircle, espStrk, espLbl = createToggleRow(visualScroll, "플레이어 위치 표시 (ESP)", UDim2.new(0, 16, 0, 15), false)
local optimizeBtn, optimizeCircle, optimizeStrk, optimizeLbl = createToggleRow(visualScroll, "최적화 모드 (Lag Reduce)", UDim2.new(0, 16, 0, 70), false)

local systemPage = Instance.new("Frame")
systemPage.Name = "SystemPage"
systemPage.Size = UDim2.new(1, 0, 1, 0)
systemPage.BackgroundTransparency = 1
systemPage.Visible = false
systemPage.Parent = contentFrame

local systemScroll = Instance.new("ScrollingFrame")
systemScroll.Size = UDim2.new(1, 0, 1, -40)
systemScroll.BackgroundTransparency = 1
systemScroll.CanvasSize = UDim2.new(0, 0, 0, 200)
systemScroll.ScrollBarThickness = 4
systemScroll.ScrollBarImageColor3 = Color3.fromRGB(50, 50, 60)
systemScroll.Parent = systemPage

local fpsBtn, fpsCircle, fpsStrk, fpsLbl = createToggleRow(systemScroll, "실시간 FPS 카운터 표시", UDim2.new(0, 16, 0, 15), false)
local unlockBtn, unlockCircle, unlockStrk, unlockLbl = createToggleRow(systemScroll, "FPS 제한 해제 (Unlock)", UDim2.new(0, 16, 0, 70), false)

local fpsDisplay = Instance.new("TextLabel")
fpsDisplay.Name = "FpsDisplay"
fpsDisplay.Size = UDim2.new(1, -32, 0, 30)
fpsDisplay.Position = UDim2.new(0, 16, 0, 125)
fpsDisplay.BackgroundTransparency = 1
fpsDisplay.Text = "FPS: --"
fpsDisplay.TextColor3 = Color3.fromRGB(200, 200, 210)
fpsDisplay.Font = Enum.Font.Code
fpsDisplay.TextSize = 14
fpsDisplay.TextXAlignment = Enum.TextXAlignment.Left
fpsDisplay.Visible = false
fpsDisplay.Parent = systemScroll

local zombiePage = Instance.new("Frame")
zombiePage.Name = "ZombiePage"
zombiePage.Size = UDim2.new(1, 0, 1, 0)
zombiePage.BackgroundTransparency = 1
zombiePage.Visible = false
zombiePage.Parent = contentFrame

local zombieScroll = Instance.new("ScrollingFrame")
zombieScroll.Size = UDim2.new(1, 0, 1, -40)
zombieScroll.BackgroundTransparency = 1
zombieScroll.CanvasSize = UDim2.new(0, 0, 0, 200)
zombieScroll.ScrollBarThickness = 4
zombieScroll.ScrollBarImageColor3 = Color3.fromRGB(50, 50, 60)
zombieScroll.Parent = zombiePage

local function createTeleportButton(parent, text)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -32, 0, 45)
    btn.Position = UDim2.new(0, 16, 0, 15)
    btn.BackgroundColor3 = Color3.fromRGB(0, 130, 255)
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.Parent = parent

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 10)
    btnCorner.Parent = btn

    local btnGradient = Instance.new("UIGradient")
    btnGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 180, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 90, 220))
    })
    btnGradient.Parent = btn
    
    return btn
end

local zombieTpBtn = createTeleportButton(zombieScroll, "버그 자리 이동")

local statusLabel = Instance.new("TextLabel")
statusLabel.Name = "StatusLabel"
statusLabel.Size = UDim2.new(0, 150, 0, 25)
statusLabel.Position = UDim2.new(0, 16, 1, -35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "시스템 준비 완료"
statusLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
statusLabel.Font = Enum.Font.GothamBold
statusLabel.TextSize = 12
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Parent = contentFrame

local creatorLabel = Instance.new("TextLabel")
creatorLabel.Name = "CreatorLabel"
creatorLabel.Size = UDim2.new(0, 120, 0, 25)
creatorLabel.Position = UDim2.new(1, -136, 1, -35)
creatorLabel.BackgroundTransparency = 1
creatorLabel.Text = "by 비타비타"
creatorLabel.TextColor3 = Color3.fromRGB(100, 100, 110)
creatorLabel.Font = Enum.Font.GothamBold
creatorLabel.TextSize = 12
creatorLabel.TextXAlignment = Enum.TextXAlignment.Right
creatorLabel.Parent = contentFrame

local miniButton = Instance.new("TextButton")
miniButton.Name = "MiniButton"
miniButton.Size = UDim2.new(0, 55, 0, 55)

if savedPos and savedPos.miniX and savedPos.miniY then
    miniButton.Position = UDim2.new(0, savedPos.miniX, 0, savedPos.miniY)
else
    miniButton.Position = UDim2.new(0.05, 0, 0.2, 0)
end

miniButton.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
miniButton.BorderSizePixel = 0
miniButton.Text = "비타"
miniButton.TextColor3 = Color3.fromRGB(255, 255, 255)
miniButton.Font = Enum.Font.GothamBold
miniButton.TextSize = 12
miniButton.Visible = false
miniButton.ClipsDescendants = true
miniButton.Parent = screenGui

local miniCorner = Instance.new("UICorner")
miniCorner.CornerRadius = UDim.new(1, 0)
miniCorner.Parent = miniButton

local miniStroke = Instance.new("UIStroke")
miniStroke.Thickness = 2
miniStroke.Color = Color3.fromRGB(0, 200, 255)
miniStroke.Parent = miniButton

local miniGradient = Instance.new("UIGradient")
miniGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 120, 255))
})
miniGradient.Parent = miniStroke

local miniDragStartPos = Vector3.new(0, 0, 0)
local miniWasDragged = false

local function setupDraggable(frame, handle, isMini)
    local dragging = false
    local dragInput, dragStart, startPos

    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position

            if isMini then
                miniDragStartPos = input.Position
                miniWasDragged = false
            end

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                    
                    if isMini then
                        local mnX = miniButton.Position.X.Offset
                        local mnY = miniButton.Position.Y.Offset
                        saveConfig(mnX, mnY)
                    end
                end
            end)
        end
    end)

    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            
            if isMini then
                local distance = (input.Position - miniDragStartPos).Magnitude
                if distance > 3 then
                    miniWasDragged = true
                end
            end
        end
    end)
end

setupDraggable(mainFrame, dragBar, false)
setupDraggable(miniButton, miniButton, true)

task.spawn(function()
    while true do
        local elapsed = os.time() - scriptStartTime
        local hours = math.floor(elapsed / 3600)
        local minutes = math.floor((elapsed % 3600) / 60)
        local seconds = elapsed % 60
        timeLabel.Text = string.format("%02d:%02d:%02d", hours, minutes, seconds)
        task.wait(1)
    end
end)

local function animateSwitch(state, box, circle, stroke, label)
    local targetPos = state and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
    local targetColor = state and Color3.fromRGB(0, 180, 255) or Color3.fromRGB(40, 40, 50)
    local targetStroke = state and Color3.fromRGB(0, 200, 255) or Color3.fromRGB(50, 50, 60)
    local targetLabel = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(160, 160, 170)

    TweenService:Create(circle, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = targetPos}):Play()
    TweenService:Create(box, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = targetColor}):Play()
    TweenService:Create(stroke, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Color = targetStroke}):Play()
    TweenService:Create(label, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = targetLabel}):Play()
end

local function resetTabs()
    mainTabBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
    mainTabBtn.TextColor3 = Color3.fromRGB(160, 160, 170)
    playerTabBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
    playerTabBtn.TextColor3 = Color3.fromRGB(160, 160, 170)
    visualTabBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
    visualTabBtn.TextColor3 = Color3.fromRGB(160, 160, 170)
    systemTabBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
    systemTabBtn.TextColor3 = Color3.fromRGB(160, 160, 170)
    zombieTabBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
    zombieTabBtn.TextColor3 = Color3.fromRGB(160, 160, 170)
    
    mainPage.Visible = false
    playerPage.Visible = false
    visualPage.Visible = false
    systemPage.Visible = false
    zombiePage.Visible = false
end

mainTabBtn.MouseButton1Click:Connect(function()
    resetTabs()
    mainTabBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
    mainTabBtn.TextColor3 = Color3.fromRGB(0, 200, 255)
    mainPage.Visible = true
end)

playerTabBtn.MouseButton1Click:Connect(function()
    resetTabs()
    playerTabBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
    playerTabBtn.TextColor3 = Color3.fromRGB(0, 200, 255)
    playerPage.Visible = true
end)

visualTabBtn.MouseButton1Click:Connect(function()
    resetTabs()
    visualTabBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
    visualTabBtn.TextColor3 = Color3.fromRGB(0, 200, 255)
    visualPage.Visible = true
end)

systemTabBtn.MouseButton1Click:Connect(function()
    resetTabs()
    systemTabBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
    systemTabBtn.TextColor3 = Color3.fromRGB(0, 200, 255)
    systemPage.Visible = true
end)

zombieTabBtn.MouseButton1Click:Connect(function()
    resetTabs()
    zombieTabBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
    zombieTabBtn.TextColor3 = Color3.fromRGB(0, 200, 255)
    zombiePage.Visible = true
end)

zombieTpBtn.MouseButton1Click:Connect(function()
    local character = player.Character
    if character then
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            rootPart.CFrame = CFrame.new(targetLocation)
            statusLabel.Text = "텔레포트 성공"
            statusLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
            task.spawn(function()
                task.wait(2)
                if statusLabel then
                    statusLabel.Text = "시스템 준비 완료"
                    statusLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
                end
            end)
        else
            statusLabel.Text = "오류: 캐릭터 중심점 없음"
            statusLabel.TextColor3 = Color3.fromRGB(255, 75, 75)
        end
    end
end)

local flyOn = false
local flySpeed = 50
local flyConnection
local bodyVelocity
local bodyGyro

flyBtn.MouseButton1Click:Connect(function()
    local character = player.Character
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    
    if not flyOn and (not rootPart or not humanoid) then
        statusLabel.Text = "오류: 캐릭터 구조 불완전"
        statusLabel.TextColor3 = Color3.fromRGB(255, 75, 75)
        return
    end

    flyOn = not flyOn
    animateSwitch(flyOn, flyBtn, flyCircle, flyStrk, flyLbl)
    
    if flyOn then
        statusLabel.Text = "비행 기능 활성화됨"
        statusLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
        
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.Parent = rootPart
        
        bodyGyro = Instance.new("BodyGyro")
        bodyGyro.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
        bodyGyro.CFrame = rootPart.CFrame
        bodyGyro.Parent = rootPart
        
        humanoid.PlatformStand = true
        
        flyConnection = RunService.RenderStepped:Connect(function()
            local char = player.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            
            if root and hum and bodyVelocity and bodyGyro then
                local num = tonumber(flyBox.Text)
                if num then flySpeed = num end
                
                local moveDir = hum.MoveDirection
                local camCFrame = camera.CFrame
                local velocityVector = Vector3.new(0, 0, 0)
                
                if moveDir.Magnitude > 0 then
                    local lookVec = camCFrame.LookVector
                    local rightVec = camCFrame.RightVector
                    local localMove = camCFrame:VectorToObjectSpace(moveDir)
                    velocityVector = (lookVec * -localMove.Z + rightVec * localMove.X).Unit * flySpeed
                end
                
                bodyVelocity.Velocity = velocityVector
                bodyGyro.CFrame = camCFrame
            end
        end)
    else
        statusLabel.Text = "시스템 준비 완료"
        statusLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
        
        if flyConnection then flyConnection:Disconnect() flyConnection = nil end
        if bodyVelocity then bodyVelocity:Destroy() bodyVelocity = nil end
        if bodyGyro then bodyGyro:Destroy() bodyGyro = nil end
        if humanoid then humanoid.PlatformStand = false end
    end
end)

local antiAfkOn = false
local antiAfkThread

antiAfkBtn.MouseButton1Click:Connect(function()
    antiAfkOn = not antiAfkOn
    animateSwitch(antiAfkOn, antiAfkBtn, antiAfkCircle, antiAfkStrk, antiAfkLbl)
    if antiAfkOn then
        statusLabel.Text = "잠수 무한 방지 활성화"
        statusLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
        
        antiAfkThread = task.spawn(function()
            while antiAfkOn do
                pcall(function()
                    VirtualUser:Button2Down(Vector2.new(0, 0), camera.CFrame)
                    task.wait(0.2)
                    VirtualUser:Button2Up(Vector2.new(0, 0), camera.CFrame)
                end)
                task.wait(120)
            end
        end)
    else
        statusLabel.Text = "시스템 준비 완료"
        statusLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
        antiAfkOn = false
    end
end)

local noclipOn = false
local noclipConnection

noclipBtn.MouseButton1Click:Connect(function()
    noclipOn = not noclipOn
    animateSwitch(noclipOn, noclipBtn, noclipCircle, noclipStrk, noclipLbl)
    if noclipOn then
        statusLabel.Text = "노클립 활성화 (벽 통과 가능)"
        statusLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
        
        noclipConnection = RunService.Stepped:Connect(function()
            local character = player.Character
            if character then
                for _, part in ipairs(character:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        statusLabel.Text = "시스템 준비 완료"
        statusLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
        if noclipConnection then noclipConnection:Disconnect() noclipConnection = nil end
    end
end)

local speedOn = false
local targetSpeed = 100
local speedConnection

speedBtn.MouseButton1Click:Connect(function()
    speedOn = not speedOn
    animateSwitch(speedOn, speedBtn, speedCircle, speedStrk, speedLbl)
    if speedOn then
        statusLabel.Text = "스피드 변조 기능 활성화됨"
        statusLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
        
        speedConnection = RunService.Heartbeat:Connect(function()
            local character = player.Character
            if character then
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    local num = tonumber(speedBox.Text)
                    if num then targetSpeed = num end
                    humanoid.WalkSpeed = targetSpeed
                end
            end
        end)
    else
        statusLabel.Text = "시스템 준비 완료"
        statusLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
        
        if speedConnection then speedConnection:Disconnect() speedConnection = nil end
        local character = player.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then humanoid.WalkSpeed = 16 end
        end
    end
end)

local jumpOn = false
local targetJump = 120
local jumpConnection

jumpBtn.MouseButton1Click:Connect(function()
    jumpOn = not jumpOn
    animateSwitch(jumpOn, jumpBtn, jumpCircle, jumpStrk, jumpLbl)
    if jumpOn then
        statusLabel.Text = "점프력 변조 기능 활성화됨"
        statusLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
        
        jumpConnection = RunService.Heartbeat:Connect(function()
            local character = player.Character
            if character then
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    local num = tonumber(jumpBox.Text)
                    if num then targetJump = num end
                    humanoid.UseJumpPower = true
                    humanoid.JumpPower = targetJump
                end
            end
        end)
    else
        statusLabel.Text = "시스템 준비 완료"
        statusLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
        
        if jumpConnection then jumpConnection:Disconnect() jumpConnection = nil end
        local character = player.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then humanoid.JumpPower = 50 end
        end
    end
end)

local infJumpOn = false
local infJumpConnection

infJumpBtn.MouseButton1Click:Connect(function()
    infJumpOn = not infJumpOn
    animateSwitch(infJumpOn, infJumpBtn, infJumpCircle, infJumpStrk, infJumpLbl)
    if infJumpOn then
        statusLabel.Text = "무한 점프 활성화됨"
        statusLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
        
        infJumpConnection = UserInputService.JumpRequest:Connect(function()
            local character = player.Character
            if character then
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        end)
    else
        statusLabel.Text = "시스템 준비 완료"
        statusLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
        if infJumpConnection then infJumpConnection:Disconnect() infJumpConnection = nil end
    end
end)

local espOn = false
local espHighlights = {}

local function addEsp(p)
    if p == player then return end
    p.CharacterAdded:Connect(function(char)
        if not espOn then return end
        task.wait(0.5)
        if char and not char:FindFirstChild("EspHighlight") then
            local hl = Instance.new("Highlight")
            hl.Name = "EspHighlight"
            hl.FillColor = Color3.fromRGB(0, 255, 255)
            hl.FillTransparency = 0.5
            hl.OutlineColor = Color3.fromRGB(255, 255, 255)
            hl.OutlineTransparency = 0
            hl.Adornee = char
            hl.Parent = char
            espHighlights[char] = hl
        end
    end)
    
    local char = p.Character
    if char and not char:FindFirstChild("EspHighlight") then
        local hl = Instance.new("Highlight")
        hl.Name = "EspHighlight"
        hl.FillColor = Color3.fromRGB(0, 255, 255)
        hl.FillTransparency = 0.5
        hl.OutlineColor = Color3.fromRGB(255, 255, 255)
        hl.OutlineTransparency = 0
        hl.Adornee = char
        hl.Parent = char
        espHighlights[char] = hl
    end
end

local function removeEsp()
    for char, hl in pairs(espHighlights) do
        if hl and hl.Parent then hl:Destroy() end
    end
    table.clear(espHighlights)
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Character then
            local hl = p.Character:FindFirstChild("EspHighlight")
            if hl then hl:Destroy() end
        end
    end
end

espBtn.MouseButton1Click:Connect(function()
    espOn = not espOn
    animateSwitch(espOn, espBtn, espCircle, espStrk, espLbl)
    if espOn then
        statusLabel.Text = "ESP 레이더가 활성화됨"
        statusLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
        for _, p in ipairs(Players:GetPlayers()) do addEsp(p) end
    else
        statusLabel.Text = "시스템 준비 완료"
        statusLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
        removeEsp()
    end
end)

Players.PlayerAdded:Connect(function(p) if espOn then addEsp(p) end end)
Players.PlayerRemoving:Connect(function(p) if p.Character and espHighlights[p.Character] then espHighlights[p.Character] = nil end end)

local optimizeOn = false
local originalMaterials = {}
local originalShadows = true
local optimizeConnection

local function getZombiesFolder()
    return workspace:FindFirstChild("Zombies") or workspace:FindFirstChild("Enemies") or workspace
end

local function cleanZombie(zombie)
    if not optimizeOn then return end
    if zombie:IsA("Model") and zombie.Name ~= player.Name and not Players:GetPlayerFromCharacter(zombie) then
        for _, child in ipairs(zombie:GetChildren()) do
            if child:IsA("Accessory") or child:IsA("Shirt") or child:IsA("Pants") or child:IsA("CharacterMesh") then
                child:Destroy()
            elseif child:IsA("BasePart") then
                child.Material = Enum.Material.SmoothPlastic
            end
        end
    end
end

optimizeBtn.MouseButton1Click:Connect(function()
    optimizeOn = not optimizeOn
    animateSwitch(optimizeOn, optimizeBtn, optimizeCircle, optimizeStrk, optimizeLbl)
    if optimizeOn then
        statusLabel.Text = "최적화 렌더링 적용 중"
        statusLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
        
        originalShadows = Lighting.GlobalShadows
        Lighting.GlobalShadows = false
        
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and not obj:IsDescendantOf(player.Character) then
                originalMaterials[obj] = obj.Material
                obj.Material = Enum.Material.SmoothPlastic
            elseif obj:IsA("ParticleEmitter") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
                obj.Enabled = false
            end
        end
        
        local zFolder = getZombiesFolder()
        for _, zombie in ipairs(zFolder:GetChildren()) do cleanZombie(zombie) end
        
        optimizeConnection = zFolder.ChildAdded:Connect(function(child)
            task.wait(0.1)
            cleanZombie(child)
        end)
    else
        statusLabel.Text = "시스템 준비 완료"
        statusLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
        if optimizeConnection then optimizeConnection:Disconnect() optimizeConnection = nil end
        Lighting.GlobalShadows = originalShadows
        for obj, mat in pairs(originalMaterials) do
            if obj and obj.Parent then obj.Material = mat end
        end
        table.clear(originalMaterials)
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("ParticleEmitter") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
                obj.Enabled = true
            end
        end
    end
end)

local fpsOn = false
local fpsConnection
local fpsUnlockOn = false

fpsBtn.MouseButton1Click:Connect(function()
    fpsOn = not fpsOn
    animateSwitch(fpsOn, fpsBtn, fpsCircle, fpsStrk, fpsLbl)
    if fpsOn then
        fpsDisplay.Visible = true
        statusLabel.Text = "FPS 카운터 활성화"
        statusLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
        
        local lastTime = os.clock()
        local frameCount = 0
        
        fpsConnection = RunService.RenderStepped:Connect(function()
            frameCount = frameCount + 1
            local currentTime = os.clock()
            if currentTime - lastTime >= 0.5 then
                local fps = math.floor(frameCount / (currentTime - lastTime))
                fpsDisplay.Text = "FPS: " .. tostring(fps)
                frameCount = 0
                lastTime = currentTime
            end
        end)
    else
        fpsDisplay.Visible = false
        statusLabel.Text = "시스템 준비 완료"
        statusLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
        if fpsConnection then fpsConnection:Disconnect() mapConnection = nil end
    end
end)

unlockBtn.MouseButton1Click:Connect(function()
    fpsUnlockOn = not fpsUnlockOn
    animateSwitch(fpsUnlockOn, unlockBtn, unlockCircle, unlockStrk, unlockLbl)
    if fpsUnlockOn then
        statusLabel.Text = "최대 프레임 한계 돌파"
        statusLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
        setfpscap(999)
    else
        statusLabel.Text = "시스템 준비 완료"
        statusLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
        setfpscap(60)
    end
end)

minimizeButton.MouseButton1Click:Connect(function()
    local mainTargetPos = miniButton.Position
    local shrinkTween = TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = mainTargetPos
    })
    shrinkTween:Play()
    shrinkTween.Completed:Connect(function()
        mainFrame.Visible = false
        miniButton.Visible = true
        local currentMiniPos = miniButton.Position
        miniButton.Size = UDim2.new(0, 0, 0, 0)
        miniButton.Position = UDim2.new(currentMiniPos.X.Scale, currentMiniPos.X.Offset + 27, currentMiniPos.Y.Scale, currentMiniPos.Y.Offset + 27)
        TweenService:Create(miniButton, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 55, 0, 55),
            Position = currentMiniPos
        }):Play()
    end)
end)

miniButton.MouseButton1Click:Connect(function()
    if miniWasDragged then
        miniWasDragged = false
        return
    end
    
    local hideMini = TweenService:Create(miniButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(miniButton.Position.X.Scale, miniButton.Position.X.Offset + 27, miniButton.Position.Y.Scale, miniButton.Position.Y.Offset + 27)
    })
    hideMini:Play()
    hideMini.Completed:Connect(function()
        miniButton.Visible = false
        mainFrame.Visible = true
        
        mainFrame.Size = UDim2.new(0, 0, 0, 0)
        mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        
        TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 440, 0, 320),
            Position = UDim2.new(0.5, -220, 0.5, -160)
        }):Play()
    end)
end)

closeButton.MouseButton1Click:Connect(function()
    antiAfkOn = false
    fpsUnlockOn = false
    setfpscap(60)
    if flyConnection then flyConnection:Disconnect() end
    if bodyVelocity then bodyVelocity:Destroy() end
    if bodyGyro then bodyGyro:Destroy() end
    if noclipConnection then noclipConnection:Disconnect() end
    if speedConnection then speedConnection:Disconnect() end
    if jumpConnection then jumpConnection:Disconnect() end
    if infJumpConnection then infJumpConnection:Disconnect() end
    if optimizeConnection then optimizeConnection:Disconnect() end
    if fpsConnection then fpsConnection:Disconnect() end
    removeEsp()
    
    Lighting.GlobalShadows = originalShadows
    for obj, mat in pairs(originalMaterials) do
        if obj and obj.Parent then obj.Material = mat end
    end
    
    local character = player.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = 16
        humanoid.JumpPower = 50
        humanoid.PlatformStand = false
    end
    
    local closeTween = TweenService:Create(mainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(mainFrame.Position.X.Scale, mainFrame.Position.X.Offset + 220, mainFrame.Position.Y.Scale, mainFrame.Position.Y.Offset + 160)
    })
    closeTween:Play()
    closeTween.Completed:Connect(function()
        screenGui:Destroy()
    end)
end)

task.spawn(function()
    local currentProgress = 0
    while currentProgress < 100 do
        currentProgress = currentProgress + 1
        loadingStatus.Text = "Loading Systems... " .. tostring(currentProgress) .. "%"
        barFill.Size = UDim2.new(currentProgress / 100, 0, 1, 0)
        task.wait(0.01)
    end
    
    loadingStatus.Text = "Setup Complete!"
    task.wait(0.2)
    
    local fadeLoading = TweenService:Create(loadingFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    })
    fadeLoading:Play()
    fadeLoading.Completed:Connect(function()
        loadingFrame:Destroy()
        
        mainFrame.Size = UDim2.new(0, 0, 0, 0)
        mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        mainFrame.Visible = true
        
        TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 440, 0, 320),
            Position = UDim2.new(0.5, -220, 0.5, -160)
        }):Play()
    end)
end)
