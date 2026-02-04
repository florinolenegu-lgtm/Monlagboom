-- On nettoie les anciens menus
for _, v in pairs(game.CoreGui:GetChildren()) do
    if v.Name == "NeguHub" then v:Destroy() end
end

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local SpeedBtn = Instance.new("TextButton")
local LagBtn = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local UIListLayout = Instance.new("UIListLayout")

ScreenGui.Name = "NeguHub"
ScreenGui.Parent = game.CoreGui

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Position = UDim2.new(0.05, 0, 0.4, 0)
MainFrame.Size = UDim2.new(0, 140, 0, 110)
MainFrame.Active = true
MainFrame.Draggable = true -- Pour bouger le menu sur ton iPhone

UIListLayout.Parent = MainFrame
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Bouton Vitesse
SpeedBtn.Size = UDim2.new(0, 130, 0, 45)
SpeedBtn.Parent = MainFrame
SpeedBtn.Text = "SPEED: OFF"
SpeedBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SpeedBtn.TextColor3 = Color3.new(1, 1, 1)

-- Bouton LAG PRO
LagBtn.Size = UDim2.new(0, 130, 0, 45)
LagBtn.Parent = MainFrame
LagBtn.Text = "LAG PRO: OFF"
LagBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
LagBtn.TextColor3 = Color3.new(1, 1, 1)

local speedActive = false
local lagActive = false
local lp = game.Players.LocalPlayer

SpeedBtn.MouseButton1Click:Connect(function()
    speedActive = not speedActive
    SpeedBtn.Text = speedActive and "SPEED: ON" or "SPEED: OFF"
    SpeedBtn.TextColor3 = speedActive and Color3.new(0, 1, 0) or Color3.new(1, 1, 1)
end)

LagBtn.MouseButton1Click:Connect(function()
    lagActive = not lagActive
    LagBtn.Text = lagActive and "LAG PRO: ON" or "LAG PRO: OFF"
    LagBtn.TextColor3 = lagActive and Color3.new(0, 1, 0) or Color3.new(1, 1, 1)
end)

-- Boucle de fonctionnement (Bypass CFrame & Physics Lag)
game:GetService("RunService").RenderStepped:Connect(function()
    if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
        local root = lp.Character.HumanoidRootPart
        
        -- Speed Hack
        if speedActive then
            local hum = lp.Character:FindFirstChildOfClass("Humanoid")
            if hum.MoveDirection.Magnitude > 0 then
                root.CFrame = root.CFrame + (hum.MoveDirection * 1.3)
            end
        end
        
        -- Lag Pro Aura
        if lagActive then
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    local tRoot = v.Character.HumanoidRootPart
                    local dist = (tRoot.Position - root.Position).Magnitude
                    if dist < 25 then
                        -- Methode de Lag "Network"
                        tRoot.Velocity = Vector3.new(math.random(-100,100), 50, math.random(-100,100))
                        tRoot.RotVelocity = Vector3.new(0, 150, 0)
                    end
                end
            end
        end
    end
end)
