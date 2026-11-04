if game.Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("LoadingGui") then
	game.Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("LoadingGui"):Destroy()
end

local TargetFurthest = false  -- false = nearest, true = furthest

local GUI = Instance.new("ScreenGui")
GUI.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
GUI.IgnoreGuiInset = true
GUI.DisplayOrder = 100000
GUI.Name = "LoadingGui"
GUI.ResetOnSpawn = false
GUI.Enabled = true

local ButtonD = Instance.new("TextButton")
ButtonD.Size = UDim2.fromScale(0.1, 0.04)
ButtonD.Position = UDim2.fromScale(0.71, 0.08)

ButtonD.Text = TargetFurthest and "Furthest" or "Nearest"
ButtonD.TextScaled = true
ButtonD.TextColor3 = Color3.fromRGB(255, 255, 255)
ButtonD.TextStrokeTransparency = 0
ButtonD.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

ButtonD.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ButtonD.BackgroundTransparency = 0.5

ButtonD.BorderColor3 = Color3.fromRGB(255, 255, 255)
ButtonD.BorderSizePixel = 1

ButtonD.Parent = GUI

ButtonD.MouseButton1Click:Connect(function()
	TargetFurthest = not TargetFurthest
	ButtonD.Text = TargetFurthest and "Furthest" or "Nearest"
end)


local Button = Instance.new("TextButton")
Button.Size = UDim2.fromScale(0.06, 0.04)
Button.Position = UDim2.fromScale(0.93, 0.03)

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
Button0.Position = UDim2.fromScale(0.93, 0.08)

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
	if tonumber(Button0.Text) ~= nil then
		Range = tonumber(Button0.Text)
		Button0.Text = Range
	else
		Button0.Text = Range
	end
end)

local Button1 = Instance.new("TextButton")
Button1.Size = UDim2.fromScale(0.1, 0.04)
Button1.Position = UDim2.fromScale(0.82, 0.08)

Button1.Text = "TP After Kill"
Button1.TextScaled = true
Button1.TextColor3 = Color3.fromRGB(0, 255, 0)
Button1.TextStrokeTransparency = 0
Button1.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

Button1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Button1.BackgroundTransparency = 0.5

Button1.BorderColor3 = Color3.fromRGB(255, 255, 255)
Button1.BorderSizePixel = 1

Button1.Parent = GUI

Button1.MouseButton1Click:Connect(function()
	if Button1.TextColor3 == Color3.fromRGB(0, 255, 0) then
		Button1.TextColor3 = Color3.fromRGB(255, 0, 0)
	else
		Button1.TextColor3 = Color3.fromRGB(0, 255, 0)
	end
end)

local Ally = Instance.new("TextButton")
Ally.Size = UDim2.fromScale(0.1, 0.04)
Ally.Position = UDim2.fromScale(0.82, 0.03)

Ally.Text = "Toggle Player"
Ally.TextScaled = true
Ally.TextColor3 = Color3.fromRGB(255, 0, 0)
Ally.TextStrokeTransparency = 0
Ally.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

Ally.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Ally.BackgroundTransparency = 0.5

Ally.BorderColor3 = Color3.fromRGB(255, 255, 255)
Ally.BorderSizePixel = 1

Ally.Parent = GUI

local TT = Instance.new("TextButton")
TT.Size = UDim2.fromScale(0.1, 0.04)
TT.Position = UDim2.fromScale(0.71, 0.03)

TT.Text = "Toggle Titan"
TT.TextScaled = true
TT.TextColor3 = Color3.fromRGB(255, 0, 0)
TT.TextStrokeTransparency = 0
TT.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

TT.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TT.BackgroundTransparency = 0.5

TT.BorderColor3 = Color3.fromRGB(255, 255, 255)
TT.BorderSizePixel = 1

TT.Parent = GUI

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

			-- Build valid candidate list
			local candidates = {}
			for _, v in ipairs(titans) do
				if pcall(function() return v.Main.Died, v.Nape end) and not v.Main.Died.Value then
					v.Nape.Transparency = 0.3
					local dist = (root.Position - v.Nape.Position).Magnitude
					if dist <= Range then
						table.insert(candidates, { titan = v, dist = dist, height = v.Nape.Position.Y })
					end
				end
			end

			-- Sort: highest Nape Y first, then by dist (nearest or furthest)
			table.sort(candidates, function(a, b)
				if a.height ~= b.height then
					return a.height > b.height  -- always highest nape first
				end
				if TargetFurthest then
					return a.dist > b.dist      -- furthest mode
				else
					return a.dist < b.dist      -- nearest mode
				end
			end)

			local target = candidates[1] and candidates[1].titan

			local TS = game:GetService("TweenService")
			local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)

			if target then
				local cap = 0
				root.Anchored = true

				local tween = TS:Create(root, tweenInfo, { CFrame = CFrame.new(target.Nape.Position) })
				tween:Play()
				tween.Completed:Wait()
				root.CFrame = CFrame.new(target.Nape.Position)
				root.Anchored = false
				task.wait()
				repeat
					cap += 1
					pcall(function()
						root.Anchored = false
						root.CFrame = CFrame.new(target.Nape.Position)
					end)
					wait(0.1)
				until target.Main.Died.Value or not Enabled or cap >= 5

				task.wait()
				root.Anchored = true
				if Button1.TextColor3 == Color3.fromRGB(0, 255, 0) then
					pcall(function()
						local returnTween = TS:Create(root, tweenInfo, { CFrame = SavedPos })
						returnTween:Play()
						returnTween.Completed:Wait()  -- wait for return tween too
					end)
				end

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
	if input.KeyCode == Enum.KeyCode.G  then
		local root = player.Character.HumanoidRootPart
		local targetCFrame = CFrame.new(workspace:FindFirstChildOfClass("SpawnLocation").Position + Vector3.new(0, 5, 0))

		root.Anchored = true

		local TS = game:GetService("TweenService")
		local tween = TS:Create(root, TweenInfo.new(
			1,     
			Enum.EasingStyle.Quad, 
			Enum.EasingDirection.Out 
			), { CFrame = targetCFrame })

		tween:Play()
		wait(1.1)
		root.Anchored = false
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

local FolderAlly = Instance.new("Folder")
FolderAlly.Name = "Ally"
FolderAlly.Parent = GUI

local BilTemplate = Instance.new("BillboardGui")
BilTemplate.Size = UDim2.new(20, 200, 0.6, 12)
BilTemplate.StudsOffset = Vector3.new(0, 5, 0)
BilTemplate.AlwaysOnTop = true
BilTemplate.MaxDistance = 100000
BilTemplate.Parent = GUI
BilTemplate.Enabled = false

local Txt = Instance.new("TextLabel")
Txt.Size = UDim2.fromScale(1, 1)
Txt.Name = "Txt"
Txt.BackgroundTransparency = 1
Txt.TextScaled = true
Txt.TextColor3 = Color3.fromRGB(255, 0, 0)
Txt.TextStrokeTransparency = 0
Txt.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
Txt.Parent = BilTemplate


local IsAlly = false
Ally.MouseButton1Click:Connect(function()
	if IsAlly == false then
		IsAlly = true
		Ally.TextColor3 = Color3.fromRGB(0, 255, 0)
		for _,i : Player in game.Players:GetChildren() do
			task.spawn(function()
				if i.Name ~= game.Players.LocalPlayer.Name and i.Character ~= nil and i.Character:FindFirstChild("Head") then
					local Clone = BilTemplate:Clone()
					Clone.Parent = FolderAlly
					Clone.Adornee = i.Character:FindFirstChild("Head")
					Clone.Txt.Text = i.Name
					Clone.Txt.TextColor3 = Color3.fromRGB(85, 255, 0)
					Clone.Enabled = true
				end
			end)
		end
	else
		IsAlly = false
		Ally.TextColor3 = Color3.fromRGB(255, 0, 0)
		FolderAlly:ClearAllChildren()
	end
end)

local FolderTT = Instance.new("Folder")
FolderTT.Name = "TT"
FolderTT.Parent = GUI

local IsTT = false
TT.MouseButton1Click:Connect(function()
	if IsTT == false then
		IsTT = true
		TT.TextColor3 = Color3.fromRGB(0, 255, 0)
		for _,i : Instance in workspace:WaitForChild("Titans"):GetChildren() do
			task.spawn(function()
				if i:IsA("Model") and i:FindFirstChild("Nape") then
					local Clone = BilTemplate:Clone()
					Clone.Parent = FolderTT
					Clone.Adornee = i:FindFirstChild("Nape")
					Clone.Txt.Text = i.Name
					Clone.Txt.TextColor3 = Color3.fromRGB(255, 170, 0)
					Clone.Enabled = true
				end
			end)
		end
	else
		IsTT = false
		TT.TextColor3 = Color3.fromRGB(255, 0, 0)
		FolderTT:ClearAllChildren()
	end
end)
