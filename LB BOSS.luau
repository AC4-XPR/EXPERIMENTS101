if game.Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("LoadingGui0") then
	game.Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("LoadingGui0"):Destroy()
end

local TargetFurthest = false  -- false = nearest, true = furthest

local GUI = Instance.new("ScreenGui")
GUI.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
GUI.IgnoreGuiInset = true
GUI.DisplayOrder = 100000
GUI.Name = "LoadingGui0"
GUI.ResetOnSpawn = false
GUI.Enabled = true

local TargetPart = "LeftKnee"
local TTTT = "Beast"

local Button = Instance.new("TextButton")
Button.Size = UDim2.fromScale(0.06, 0.04)
Button.Position = UDim2.fromScale(0.5, 0.03)

Button.Text = "Tharo888"
Button.TextScaled = true
Button.TextColor3 = Color3.fromRGB(255, 0, 0)
Button.TextStrokeTransparency = 0
Button.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

Button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Button.BackgroundTransparency = 0.5

Button.BorderColor3 = Color3.fromRGB(255, 255, 255)
Button.BorderSizePixel = 1

Button.Parent = GUI

local Range = 1500

local Button0 = Instance.new("TextBox")
Button0.Size = UDim2.fromScale(0.06, 0.04)
Button0.Position = UDim2.fromScale(0.5, 0.08)

Button0.Text = Range
Button0.TextScaled = true
Button0.TextColor3 = Color3.fromRGB(255, 255, 255)
Button0.TextStrokeTransparency = 0
Button0.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

Button0.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Button0.BackgroundTransparency = 0.5

Button0.BorderColor3 = Color3.fromRGB(255, 255, 255)
Button0.BorderSizePixel = 1

Button0.Parent = GUI

Button0.FocusLost:Connect(function()
	if tostring(Button0.Text) ~= nil then
		TargetPart = tostring(Button0.Text)
		Button0.Text = TargetPart
	else
		Button0.Text = TargetPart
	end
end)

local getBypass =true
-- TP Bypass
for i,v in pairs(getgc(true)) do
	if type(v) == "table" and rawget(v,"MaybeHacker") then
		v.MaybeHacker = -math.huge
		getBypass = false
	end
end

-- Check
if getBypass then
	Button.Text = "Bypass didn't work :("
	wait(3)
	Button.Text = "Tharo888"
end

-- Variable
local player = game.Players.LocalPlayer
local Enabled = false
local UIS = game:GetService("UserInputService")
local HasDied = false

local CON = UIS.InputEnded:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if not GUI then return end

	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		if Enabled and not HasDied then
			HasDied = true
			local root = player.Character.HumanoidRootPart
			local SavedPos = root.CFrame
			local titans = workspace.Titans:GetChildren()


			local target = workspace[TTTT]

			local TS = game:GetService("TweenService")
			local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)

			if target then
				local cap = 0
				root.Anchored = true

				local tween = TS:Create(root, tweenInfo, { CFrame = CFrame.new(target[TargetPart].Position) })
				tween:Play()
				tween.Completed:Wait()
				root.CFrame = CFrame.new(target[TargetPart].Position)
				root.Anchored = false
				task.wait()
				repeat
					cap += 1
					pcall(function()
						root.Anchored = false
						root.CFrame = CFrame.new(target[TargetPart].Position)
					end)
					wait(0.1)
				until not Enabled or cap >= 2

				task.wait()
				root.Anchored = true
				pcall(function()
					local returnTween = TS:Create(root, tweenInfo, { CFrame = SavedPos })
					returnTween:Play()
					returnTween.Completed:Wait()  -- wait for return tween too
				end)

				root.Anchored = false
				task.wait(0.2)
			end

			HasDied = false
		end
	end
	if input.KeyCode == Enum.KeyCode.T then
		Enabled = not Enabled
		if Enabled == false then
			Button.TextColor3 = Color3.fromRGB(255, 0, 0)
		else
			Button.TextColor3 = Color3.fromRGB(0, 255, 0)
		end
	end

end)

GUI.Destroying:Connect(function()
	CON:Disconnect()
end)

Button.MouseButton1Click:Connect(function()
	Enabled = not Enabled
	if Enabled == false then
		Button.TextColor3 = Color3.fromRGB(255, 0, 0)
	else
		Button.TextColor3 = Color3.fromRGB(0, 255, 0)
	end
end)

