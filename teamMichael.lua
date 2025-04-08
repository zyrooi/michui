local UILib = {}

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local function getOrCreateGUI(name)
    local existingGui = PlayerGui:FindFirstChild(name)
    if existingGui then
        return existingGui
    else
        local newGui = Instance.new("ScreenGui")
        newGui.Name = name
        newGui.ResetOnSpawn = false
        newGui.Parent = PlayerGui
        return newGui
    end
end

local ToggleGui = getOrCreateGUI("ToggleGUI")

local ToggleButton = Instance.new("ImageButton")
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Position = UDim2.new(0.5, -24, 0, ,0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ToggleButton.Image = "rbxthumb://type=Asset&id=91683227610697&w=420&h=420"
ToggleButton.Parent = ToggleGui
Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(100)

function UILib:CreateWindow(title)
    local ScreenGui = getOrCreateGUI("ExtremeUI")

    local Main = Instance.new("Frame")
    Main.Size = UDim2.new(0, 600, 0, 250)
    Main.Position = UDim2.new(0.5, -290, 0, 10)
    Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Main.BorderSizePixel = 0
    Main.Parent = ScreenGui
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

    local dragging, dragInput, dragStart, startPos
    Main.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = Main.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)

    Main.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    Main.Visible = false

    ToggleButton.MouseButton1Click:Connect(function()
        Main.Visible = not Main.Visible
    end)

    local Top = Instance.new("TextLabel")
    Top.Size = UDim2.new(1, 0, 0, 40)
    Top.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Top.BorderSizePixel = 0
    Top.Text = title or "UI"
    Top.Font = Enum.Font.GothamBold
    Top.TextSize = 20
    Top.TextColor3 = Color3.fromRGB(255, 255, 255)
    Top.Parent = Main
    Instance.new("UICorner", Top).CornerRadius = UDim.new(0, 12)

    local TabsScroll = Instance.new("ScrollingFrame")
    TabsScroll.Size = UDim2.new(1, -20, 0, 40)
    TabsScroll.Position = UDim2.new(0, 10, 0, 45)
    TabsScroll.BackgroundTransparency = 1
    TabsScroll.ScrollBarThickness = 0
    TabsScroll.ScrollingDirection = Enum.ScrollingDirection.X
    TabsScroll.AutomaticCanvasSize = Enum.AutomaticSize.X
    TabsScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabsScroll.Parent = Main

    local TabsLayout = Instance.new("UIListLayout")
    TabsLayout.FillDirection = Enum.FillDirection.Horizontal
    TabsLayout.Padding = UDim.new(0, 8)
    TabsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabsLayout.Parent = TabsScroll

    local Pages = Instance.new("Frame")
    Pages.Size = UDim2.new(1, -20, 1, -95)
    Pages.Position = UDim2.new(0, 10, 0, 90)
    Pages.BackgroundTransparency = 1
    Pages.Parent = Main

    local Tabs = {}

    function Tabs:CreateTab(tabName)
        local TabBtn = Instance.new("TextButton")
        TabBtn.Size = UDim2.new(0, 100, 0, 35)
        TabBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        TabBtn.Text = tabName
        TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabBtn.Font = Enum.Font.GothamMedium
        TabBtn.TextSize = 16
        TabBtn.Parent = TabsScroll
        Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 10)

        local Page = Instance.new("ScrollingFrame")
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.CanvasSize = UDim2.new(0, 0, 0, 0)
        Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
        Page.ScrollBarThickness = 6
        Page.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
        Page.BackgroundTransparency = 1
        Page.Visible = false
        Page.Parent = Pages

        local Layout = Instance.new("UIListLayout", Page)
        Layout.Padding = UDim.new(0, 6)
        Layout.SortOrder = Enum.SortOrder.LayoutOrder

        TabBtn.MouseButton1Click:Connect(function()
            for _, p in pairs(Pages:GetChildren()) do
                if p:IsA("ScrollingFrame") then p.Visible = false end
            end
            for _, b in pairs(TabsScroll:GetChildren()) do
                if b:IsA("TextButton") then
                    TweenService:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
                end
            end
            TweenService:Create(TabBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 120, 255)}):Play()
            Page.Visible = true
        end)

        local functions = {}

        function functions:Button(options)
            local Btn = Instance.new("TextButton")
            Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Btn.Size = UDim2.new(1, 0, 0, 40)
            Btn.Text = options.Title or "Button"
            Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            Btn.Font = Enum.Font.GothamMedium
            Btn.TextSize = 15
            Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)
            Btn.Parent = Page
            Btn.MouseButton1Click:Connect(function()
                if options.Callback then options.Callback() end
            end)
        end

        function functions:Toggle(options)
            local Holder = Instance.new("Frame")
            Holder.Size = UDim2.new(1, 0, 0, 40)
            Holder.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Instance.new("UICorner", Holder).CornerRadius = UDim.new(0, 8)
            Holder.Parent = Page

            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1, -60, 1, 0)
            Label.Position = UDim2.new(0, 10, 0, 0)
            Label.Text = options.Title or "Toggle"
            Label.Font = Enum.Font.GothamMedium
            Label.TextSize = 15
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.BackgroundTransparency = 1
            Label.Parent = Holder

            local ToggleBtn = Instance.new("TextButton")
            ToggleBtn.Size = UDim2.new(0, 40, 0, 20)
            ToggleBtn.Position = UDim2.new(1, -50, 0.5, -10)
            ToggleBtn.BackgroundColor3 = options.Default and Color3.fromRGB(0, 120, 255) or Color3.fromRGB(80, 80, 80)
            ToggleBtn.Text = ""
            Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
            ToggleBtn.Parent = Holder

            local state = options.Default or false
            ToggleBtn.MouseButton1Click:Connect(function()
                state = not state
                TweenService:Create(ToggleBtn, TweenInfo.new(0.2), {
                    BackgroundColor3 = state and Color3.fromRGB(0, 120, 255) or Color3.fromRGB(80, 80, 80)
                }):Play()
                if options.Callback then options.Callback(state) end
            end)
        end

        function functions:Seperator(text)
            local Line = Instance.new("TextLabel")
            Line.Size = UDim2.new(1, 0, 0, 25)
            Line.Text = "— " .. (text or "") .. " —"
            Line.Font = Enum.Font.Gotham
            Line.TextColor3 = Color3.fromRGB(150, 150, 150)
            Line.TextSize = 14
            Line.BackgroundTransparency = 1
            Line.Parent = Page
        end

        return functions
    end

    return Tabs
end

return UILib
