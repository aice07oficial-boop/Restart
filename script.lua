loadstring([[
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Evitar duplicados
local old = playerGui:FindFirstChild("RyzeHub")
if old then
	old:Destroy()
end

-- GUI principal
local gui = Instance.new("ScreenGui")
gui.Name = "RyzeHub"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = playerGui

-- Ventana
local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(185, 95)
main.Position = UDim2.new(0.5, -92, 0.5, -47)
main.BackgroundColor3 = Color3.fromRGB(18, 18, 23)
main.BorderSizePixel = 0
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = main

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(75, 75, 90)
stroke.Thickness = 1
stroke.Transparency = 0.25
stroke.Parent = main

-- Barra superior
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 34)
header.BackgroundTransparency = 1
header.Active = true
header.Parent = main

-- Nombre
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -45, 1, 0)
title.Position = UDim2.fromOffset(12, 0)
title.BackgroundTransparency = 1
title.Text = "RyzeHub"
title.TextColor3 = Color3.fromRGB(245, 245, 250)
title.TextSize = 15
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

-- Botón cerrar/ocultar
local hide = Instance.new("TextButton")
hide.Size = UDim2.fromOffset(28, 28)
hide.Position = UDim2.new(1, -32, 0, 3)
hide.BackgroundTransparency = 1
hide.Text = "×"
hide.TextColor3 = Color3.fromRGB(170, 170, 180)
hide.TextSize = 20
hide.Font = Enum.Font.GothamMedium
hide.AutoButtonColor = false
hide.Parent = header

-- Botón reiniciar
local restart = Instance.new("TextButton")
restart.Size = UDim2.new(1, -20, 0, 43)
restart.Position = UDim2.fromOffset(10, 45)
restart.BackgroundColor3 = Color3.fromRGB(42, 42, 52)
restart.BorderSizePixel = 0
restart.Text = "↻   REINICIAR"
restart.TextColor3 = Color3.fromRGB(245, 245, 250)
restart.TextSize = 13
restart.Font = Enum.Font.GothamMedium
restart.AutoButtonColor = false
restart.Parent = main

local restartCorner = Instance.new("UICorner")
restartCorner.CornerRadius = UDim.new(0, 8)
restartCorner.Parent = restart

-- Botón flotante
local open = Instance.new("TextButton")
open.Name = "OpenButton"
open.Size = UDim2.fromOffset(42, 42)
open.Position = UDim2.new(0.5, -21, 0.5, -21)
open.BackgroundColor3 = Color3.fromRGB(18, 18, 23)
open.BorderSizePixel = 0
open.Text = "R"
open.TextColor3 = Color3.fromRGB(245, 245, 250)
open.TextSize = 17
open.Font = Enum.Font.GothamBold
open.Visible = false
open.AutoButtonColor = false
open.Parent = gui

local openCorner = Instance.new("UICorner")
openCorner.CornerRadius = UDim.new(1, 0)
openCorner.Parent = open

local openStroke = Instance.new("UIStroke")
openStroke.Color = Color3.fromRGB(75, 75, 90)
openStroke.Thickness = 1
openStroke.Parent = open

-- Sistema para mover la UI
local dragging = false
local dragStart
local startPos

header.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then

		dragging = true
		dragStart = input.Position
		startPos = main.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

UIS.InputChanged:Connect(function(input)
	if not dragging then return end

	if input.UserInputType == Enum.UserInputType.MouseMovement
	or input.UserInputType == Enum.UserInputType.Touch then

		local delta = input.Position - dragStart

		main.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

-- Reiniciar
restart.MouseButton1Click:Connect(function()
	local character = player.Character

	if character then
		local humanoid = character:FindFirstChildOfClass("Humanoid")

		if humanoid then
			humanoid.Health = 0
		end
	end
end)

-- Animación del botón
restart.MouseEnter:Connect(function()
	TweenService:Create(
		restart,
		TweenInfo.new(0.15),
		{BackgroundColor3 = Color3.fromRGB(58, 58, 70)}
	):Play()
end)

restart.MouseLeave:Connect(function()
	TweenService:Create(
		restart,
		TweenInfo.new(0.15),
		{BackgroundColor3 = Color3.fromRGB(42, 42, 52)}
	):Play()
end)

-- Ocultar
hide.MouseButton1Click:Connect(function()
	open.Position = main.Position

	main.Visible = false
	open.Visible = true
end)

-- Abrir
open.MouseButton1Click:Connect(function()
	main.Position = open.Position

	open.Visible = false
	main.Visible = true
end)
]])()
