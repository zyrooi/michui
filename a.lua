local UILib = loadstring(game:HttpGet("https://raw.githubusercontent.com/zyrooi/michui/refs/heads/main/uihub.lua"))()
local Window = UILib:CreateWindow("Michael Hub - Verison: Dead Rail")

local MainTab = Window:CreateTab("General")
local MiscTab = Window:CreateTab("Misc")

MainTab:Button({
Title = "Esp Player/Mob",
Callback = function()

end
})

MainTab:Toggle({
Title = "Esp User",
Default = false,
Callback = function(state)
local function createESP(player)
    if player.Character and player.Character:FindFirstChild("Head") then
        local head = player.Character.Head
        local billboardGui = Instance.new("BillboardGui")
        billboardGui.Adornee = head
        billboardGui.Parent = player.Character
        billboardGui.Size = UDim2.new(0, 200, 0, 50)  -- Cố định kích thước BillboardGui
        billboardGui.StudsOffset = Vector3.new(0, 3, 0)  -- Điều chỉnh vị trí đúng
        billboardGui.AlwaysOnTop = true

        -- Khoảng cách giữa người chơi và người chạy script
        local distance = (player.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude
        local distanceTag = Instance.new("TextLabel")
        distanceTag.Parent = billboardGui
        distanceTag.Text = string.format("%.2f studs", distance)
        distanceTag.TextColor3 = Color3.fromRGB(255, 255, 255)  -- Màu chữ trắng
        distanceTag.TextStrokeTransparency = 0.5  -- Giảm giá trị để viền chữ dày hơn
        distanceTag.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)  -- Viền đen
        distanceTag.BackgroundTransparency = 1
        distanceTag.Size = UDim2.new(1, 0, 0.3, 0)  -- Khoảng cách chiếm 30% chiều cao
        distanceTag.Position = UDim2.new(0, 0, 0, 0)  -- Đặt ở trên cùng
        distanceTag.TextScaled = false  -- Không tự động thay đổi kích thước chữ
        distanceTag.Font = Enum.Font.SourceSansBold
        distanceTag.TextSize = 22

        -- Tạo TextLabel cho tên người chơi
        local nameTag = Instance.new("TextLabel")
        nameTag.Parent = billboardGui
        nameTag.Text = player.Name
        nameTag.TextColor3 = Color3.fromRGB(255, 255, 255)  -- Màu chữ trắng
        nameTag.TextStrokeTransparency = 0.5  -- Giảm giá trị để viền chữ dày hơn
        nameTag.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)  -- Viền đen
        nameTag.BackgroundTransparency = 1
        nameTag.Size = UDim2.new(1, 0, 0.7, 0)  -- Chiếm 70% chiều cao
        nameTag.Position = UDim2.new(0, 0, 0.3, 0)  -- Đặt dưới khoảng cách
        nameTag.TextScaled = false  -- Không tự động thay đổi kích thước chữ
        nameTag.Font = Enum.Font.SourceSansBold
        nameTag.TextSize = 22

        -- Cập nhật vị trí liên tục khi người chơi di chuyển
        game:GetService("RunService").Heartbeat:Connect(function()
            if player.Character and player.Character:FindFirstChild("Head") then
                local distance = (player.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude
                distanceTag.Text = string.format("%.2f studs", distance)
                billboardGui.StudsOffset = Vector3.new(0, 3, 0)  -- Đảm bảo vị trí được cập nhật
            end
        end)
    end
end

game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        createESP(player)
    end)
end)

for _, player in ipairs(game.Players:GetPlayers()) do
    if player.Character then
        createESP(player)
    end
end
end
})
MainTab:Toggle({
Title = "Esp MOB and Player",
Default = false,
Callback = function(state)
local function createMobESP(mob)
    if mob:FindFirstChild("HumanoidRootPart") then
        local root = mob.HumanoidRootPart
        local billboardGui = Instance.new("BillboardGui")
        billboardGui.Adornee = root
        billboardGui.Parent = root
        billboardGui.Size = UDim2.new(0, 200, 0, 50)
        billboardGui.StudsOffset = Vector3.new(0, 3, 0)
        billboardGui.AlwaysOnTop = true

        local distanceTag = Instance.new("TextLabel")
        distanceTag.Parent = billboardGui
        distanceTag.Text = "..."
        distanceTag.TextColor3 = Color3.fromRGB(255, 100, 100)
        distanceTag.TextStrokeTransparency = 0.5
        distanceTag.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        distanceTag.BackgroundTransparency = 1
        distanceTag.Size = UDim2.new(1, 0, 0.3, 0)
        distanceTag.Position = UDim2.new(0, 0, 0, 0)
        distanceTag.TextScaled = false
        distanceTag.Font = Enum.Font.SourceSansBold
        distanceTag.TextSize = 22

        local nameTag = Instance.new("TextLabel")
        nameTag.Parent = billboardGui
        nameTag.Text = mob.Name
        nameTag.TextColor3 = Color3.fromRGB(255, 255, 255)
        nameTag.TextStrokeTransparency = 0.5
        nameTag.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        nameTag.BackgroundTransparency = 1
        nameTag.Size = UDim2.new(1, 0, 0.7, 0)
        nameTag.Position = UDim2.new(0, 0, 0.3, 0)
        nameTag.TextScaled = false
        nameTag.Font = Enum.Font.SourceSansBold
        nameTag.TextSize = 22

        game:GetService("RunService").Heartbeat:Connect(function()
            if root and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local distance = (root.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude
                distanceTag.Text = string.format("%.2f studs", distance)
            end
        end)
    end
end

-- Quét mob hiện có
for _, obj in pairs(workspace:GetDescendants()) do
    if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") then
        createMobESP(obj)
    end
end

-- Theo dõi mob mới xuất hiện
workspace.DescendantAdded:Connect(function(obj)
    if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") then
        wait(0.1)
        createMobESP(obj)
    end
end)
end
})
MainTab:Button({
Title = "Teleport 80km",
Callback = function()
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local newPosition = Vector3.new(1358.5087890625, 369.697509765625, -49.35203552246094) -- Tọa độ đích

if character then
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

    -- Dịch chuyển ngay lập tức
    humanoidRootPart.CFrame = CFrame.new(newPosition)
end   
end
})
MainTab:Button({
Title = "Teleport 0Km",
Callback = function()

end
})
MainTab:Button({
Title = "Aimbot",
Callback = function()

end
})

MainTab:Button({
Title = "Aimbot Head",
Callback = function()
_G.aimbothead = true

-- Dịch vụ cần dùng
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- GUI vòng tròn giữa màn hình
local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
gui.ResetOnSpawn = false

local circle = Instance.new("Frame", gui)
circle.Size = UDim2.new(0, 150, 0, 150)
circle.Position = UDim2.new(0.5, -75, 0.5, -75)
circle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
circle.BackgroundTransparency = 0.7

local corner = Instance.new("UICorner", circle)
corner.CornerRadius = UDim.new(1, 0)

-- Line từ tâm tới đầu NPC
local line = Drawing.new("Line")
line.Visible = false
line.Color = Color3.fromRGB(0, 255, 0)
line.Thickness = 2

-- Kiểm tra xem model có phải người chơi không
local function isPlayerModel(model)
	for _, player in pairs(Players:GetPlayers()) do
		if player.Character == model then
			return true
		end
	end
	return false
end

-- Tìm NPC gần nhất trong vòng tròn
local function getClosestNPC()
	local closestDistance = 75
	local target = nil

	for _, npc in pairs(workspace:GetChildren()) do
		if npc:FindFirstChild("Humanoid") and npc:FindFirstChild("Head") and not isPlayerModel(npc) then
			local screenPoint, onScreen = Camera:WorldToViewportPoint(npc.Head.Position)
			if onScreen then
				local distance = (Vector2.new(screenPoint.X, screenPoint.Y) - Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)).Magnitude
				if distance < closestDistance then
					closestDistance = distance
					target = npc
				end
			end
		end
	end

	return target
end

-- Aimbot loop
RunService.RenderStepped:Connect(function()
	if _G.aimbothead then
		local target = getClosestNPC()
		if target then
			local headPosition = target.Head.Position
			Camera.CFrame = CFrame.new(Camera.CFrame.Position, headPosition)

			-- Vẽ đường từ tâm đến đầu
			local screenHead, onScreen = Camera:WorldToViewportPoint(headPosition)
			if onScreen then
				line.Visible = true
				line.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
				line.To = Vector2.new(screenHead.X, screenHead.Y)
			else
				line.Visible = false
			end
		else
			line.Visible = false
		end
	else
		line.Visible = false
	end
end)
end
})
MainTab:Button({
Title = "Off Aimbot Head",
Callback = function()
_G.aimbothead = false
end
})

MiscTab:Button({
Title = " NoClip",
Callback = function()
local noclip = true
game:GetService("RunService").Stepped:Connect(function()
    if noclip and game.Players.LocalPlayer.Character then
        for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide == true then
                part.CanCollide = false
            end
        end
    end
end)
end
})
MiscTab:Button({
Title = "Off NoClip",
Callback = function()
local noclip = false
end
})
MiscTab:Button({
Title = "Only Day",
Callback = function()
game.Lighting.TimeOfDay = "12:00:00"
game.Lighting.Ambient = Color3.fromRGB(255, 255, 255)
game.Lighting.Brightness = 2
game.Lighting.GlobalShadows = false
end
})
