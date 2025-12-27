local v0 = game:GetService("Players")
local v1 = game:GetService("RunService")
local v2 = v0.LocalPlayer
local v3 = game:GetService("TweenService")

local v4 = Instance.new("ScreenGui")
v4.Name = "UltraGui"
v4.Parent = game.CoreGui

local v5 = Instance.new("Frame")
local v6 = Instance.new("UICorner")
local v7 = Instance.new("TextBox")
local v9 = Instance.new("TextButton")
local v11 = Instance.new("TextButton")
local v14 = Instance.new("TextButton")

v5.Parent = v4
v5.Size = UDim2.new(0, 160, 0, 150)
v5.Position = UDim2.new(0.5, -80, 0.5, -75)
v5.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
v5.BackgroundTransparency = 0.2
v5.Active = true
v5.Draggable = true
v5.ClipsDescendants = true

v6.Parent = v5
v7.Parent = v5
v9.Parent = v5
v11.Parent = v5
v14.Parent = v5

v11.Size = UDim2.new(1, 0, 0, 20)
v11.Text = "▼"
v11.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
v11.TextColor3 = Color3.new(1, 1, 1)

v7.Size = UDim2.new(0, 140, 0, 25)
v7.Position = UDim2.new(0, 10, 0, 30)
v7.Text = "10"
v7.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
v7.TextColor3 = Color3.new(1, 1, 1)

v9.Size = UDim2.new(0, 140, 0, 30)
v9.Position = UDim2.new(0, 10, 0, 65)
v9.Text = "Enable Hitbox"
v9.BackgroundColor3 = Color3.fromRGB(50, 100, 50)
v9.TextColor3 = Color3.new(1, 1, 1)

v14.Size = UDim2.new(0, 140, 0, 30)
v14.Position = UDim2.new(0, 10, 0, 105)
v14.Text = "Visuals: ON"
v14.BackgroundColor3 = Color3.fromRGB(50, 50, 100)
v14.TextColor3 = Color3.new(1, 1, 1)

_G.HeadSize = 10
_G.Disabled = true
_G.Visuals = true
local collapsed = false
local v52 = {}

v11.MouseButton1Click:Connect(function()
    collapsed = not collapsed
    if collapsed then
        v5:TweenSize(UDim2.new(0, 160, 0, 20), "Out", "Quad", 0.3, true)
        v11.Text = "▲"
    else
        v5:TweenSize(UDim2.new(0, 160, 0, 150), "Out", "Quad", 0.3, true)
        v11.Text = "▼"
    end
end)

local function updatePlayers()
    v52 = {}
    for _, p in ipairs(v0:GetPlayers()) do
        if p ~= v2 and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            table.insert(v52, p)
        end
    end
end

v7.FocusLost:Connect(function()
    _G.HeadSize = tonumber(v7.Text) or 10
end)

v9.MouseButton1Click:Connect(function()
    _G.Disabled = not _G.Disabled
    v9.Text = _G.Disabled and "Enable Hitbox" or "Disable Hitbox"
    v9.BackgroundColor3 = _G.Disabled and Color3.fromRGB(50, 100, 50) or Color3.fromRGB(100, 50, 50)
end)

v14.MouseButton1Click:Connect(function()
    _G.Visuals = not _G.Visuals
    v14.Text = _G.Visuals and "Visuals: ON" or "Visuals: OFF"
    v14.BackgroundColor3 = _G.Visuals and Color3.fromRGB(50, 50, 100) or Color3.fromRGB(70, 70, 70)
end)

v1.RenderStepped:Connect(function()
    if not _G.Disabled then
        for _, p in ipairs(v52) do
            if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = p.Character.HumanoidRootPart
                hrp.Size = Vector3.new(_G.HeadSize, _G.HeadSize, _G.HeadSize)
                if _G.Visuals then
                    hrp.Transparency = 0.7
                    hrp.BrickColor = BrickColor.new("Really blue")
                    hrp.Material = Enum.Material.Neon
                else
                    hrp.Transparency = 1
                end
                hrp.CanCollide = false
            end
        end
    end
end)

task.spawn(function()
    while true do
        updatePlayers()
        task.wait(1)
    end
end)
