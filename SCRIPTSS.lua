local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "RestartUI"
gui.ResetOnSpawn = false
gui.Parent = playerGui

-- Marco principal
local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(190, 90)
frame.Position = UDim2.new(0.5, -95, 0.5, -45)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
frame.BorderSizePixel = 0
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

local stroke = Instance.new("UIStroke")
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(80, 80, 90)
stroke.Parent = frame

-- Título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 25)
title.BackgroundTransparency = 1
title.Text = "AntroxHub"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 16
title.Font = Enum.Font.GothamBold
title.Parent = frame

-- Botón reiniciar
local restartButton = Instance.new("TextButton")
restartButton.Size = UDim2.new(1, -20, 0, 42)
restartButton.Position = UDim2.fromOffset(10, 38)
restartButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
restartButton.BorderSizePixel = 0
restartButton.Text = "REINICIAR"
restartButton.TextColor3 = Color3.fromRGB(255, 255, 255)
restartButton.TextSize = 16
restartButton.Font = Enum.Font.GothamBold
restartButton.Parent = frame

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 9)
buttonCorner.Parent = restartButton

-- Reiniciar personaje
restartButton.MouseButton1Click:Connect(function()
	local character = player.Character

	if character then
		local humanoid = character:FindFirstChildOfClass("Humanoid")

		if humanoid then
			humanoid.Health = 0
		end
	end
end)

-- UI movible en PC y celular
local dragging = false
local dragStart
local startPos

frame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then

		dragging = true
		dragStart = input.Position
		startPos = frame.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and (
		input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch
	) then

		local delta = input.Position - dragStart

		frame.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)
