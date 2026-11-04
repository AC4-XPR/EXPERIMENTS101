--// Version 1.5

local GUI = Instance.new("ScreenGui")
GUI.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
GUI.IgnoreGuiInset = true
GUI.DisplayOrder = 100000
GUI.Name = "LoadingGui"
GUI.ResetOnSpawn = false
GUI.Enabled = true

local Button = Instance.new("TextButton")
Button.Size = UDim2.fromScale(0.06, 0.04)
Button.Position = UDim2.fromScale(0.93, 0.03)

Button.Text = "Tharo888"
Button.TextScaled = true
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.TextStrokeTransparency = 0
Button.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

Button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Button.BackgroundTransparency = 0.5

Button.BorderColor3 = Color3.fromRGB(255, 255, 255)
Button.BorderSizePixel = 1

Button.Parent = GUI

local Frame = Instance.new("Frame")
Frame.Size = UDim2.fromScale(0.2, 0.5)
Frame.Position = UDim2.fromScale(0.99, 0.5)
Frame.AnchorPoint = Vector2.new(1, 0.5)

Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame.BackgroundTransparency = 0.5

Frame.BorderColor3 = Color3.fromRGB(255, 255, 255)
Frame.BorderSizePixel = 1

Frame.Parent = GUI

Button.MouseButton1Click:Connect(function()
	Frame.Visible = not Frame.Visible
end)

local War = Instance.new("TextButton")
War.Size = UDim2.fromScale(0.9, 0.1)
War.Position = UDim2.fromScale(0.05, 0.05)

War.Text = "Mark All warroir"
War.TextScaled = true
War.TextColor3 = Color3.fromRGB(255, 0, 0)
War.TextStrokeTransparency = 0
War.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

War.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
War.BackgroundTransparency = 0.5

War.BorderColor3 = Color3.fromRGB(255, 255, 255)
War.BorderSizePixel = 1

War.Parent = Frame

local TT = Instance.new("TextButton")
TT.Size = UDim2.fromScale(0.9, 0.1)
TT.Position = UDim2.fromScale(0.05, 0.88)

TT.Text = "Toggle Titans Mark"
TT.TextScaled = true
TT.TextColor3 = Color3.fromRGB(255, 0, 0)
TT.TextStrokeTransparency = 0
TT.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

TT.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TT.BackgroundTransparency = 0.5

TT.BorderColor3 = Color3.fromRGB(255, 255, 255)
TT.BorderSizePixel = 1

TT.Parent = Frame

local Ally = Instance.new("TextButton")
Ally.Size = UDim2.fromScale(0.9, 0.1)
Ally.Position = UDim2.fromScale(0.05, 0.75)

Ally.Text = "Toggle Ally Mark"
Ally.TextScaled = true
Ally.TextColor3 = Color3.fromRGB(255, 0, 0)
Ally.TextStrokeTransparency = 0
Ally.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

Ally.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Ally.BackgroundTransparency = 0.5

Ally.BorderColor3 = Color3.fromRGB(255, 255, 255)
Ally.BorderSizePixel = 1

Ally.Parent = Frame

local FolderWar = Instance.new("Folder")
FolderWar.Name = "Warroir"
FolderWar.Parent = GUI

local FolderTT = Instance.new("Folder")
FolderTT.Name = "TT"
FolderTT.Parent = GUI

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

local IsWar = false
War.MouseButton1Click:Connect(function()
	if IsWar == false then
		IsWar = true
		War.TextColor3 = Color3.fromRGB(0, 255, 0)
		for _,i : Player in game.Players:GetChildren() do
			task.spawn(function()
				if i.Character ~= nil and i.Character:FindFirstChild("Head") then
					if workspace:WaitForChild("WarriorsCampaignLog"):FindFirstChild(i.Name) then
						local TitanName = ""
						for _, v in workspace:WaitForChild("WarriorsCandidatesFolder"):WaitForChild("ShifterHolders"):GetChildren() do
							if v:IsA("StringValue") and i.Name == v.Value then
								TitanName = v.Name
							end
						end
						local Clone = BilTemplate:Clone()
						Clone.Parent = FolderWar
						Clone.Adornee = i.Character:FindFirstChild("Head")
						Clone.Txt.Text = i.Name .. " — " .. TitanName
						Clone.Txt.TextColor3 = Color3.fromRGB(255, 0, 0)
						Clone.Enabled = true
					end
				end
			end)
		end
	else
		IsWar = false
		War.TextColor3 = Color3.fromRGB(255, 0, 0)
		FolderWar:ClearAllChildren()
	end
end)

local function TTUpdate()
	FolderTT:ClearAllChildren()
	for _,i : Instance in workspace:WaitForChild("OnGameTitans"):GetChildren() do
		task.spawn(function()
			if i:IsA("Model") and i:FindFirstChild("Nape") and i:FindFirstChild("Type") then
				local Clone = BilTemplate:Clone()
				Clone.Parent = FolderTT
				Clone.Adornee = i:FindFirstChild("Nape")
				Clone.Txt.Text = i.Type.Value
				Clone.Txt.TextColor3 = Color3.fromRGB(255, 170, 0)
				Clone.Enabled = true
			end
		end)
	end
end

local IsTT = false
TT.MouseButton1Click:Connect(function()
	if IsTT == false then
		IsTT = true
		TT.TextColor3 = Color3.fromRGB(0, 255, 0)
		TTUpdate()
	else
		IsTT = false
		TT.TextColor3 = Color3.fromRGB(255, 0, 0)
		FolderTT:ClearAllChildren()
	end
end)

workspace:WaitForChild("OnGameTitans").ChildAdded:Connect(function()
	if IsTT == true then
		TTUpdate()
	end
end)
workspace:WaitForChild("OnGameTitans").ChildRemoved:Connect(function()
	if IsTT == true then
		TTUpdate()
	end
end)

local IsAlly = false
Ally.MouseButton1Click:Connect(function()
	if IsAlly == false then
		IsAlly = true
		Ally.TextColor3 = Color3.fromRGB(0, 255, 0)
		for _,i : Player in game.Players:GetChildren() do
			task.spawn(function()
				if i.Name ~= game.Players.LocalPlayer.Name and i.Character ~= nil and i.Character:FindFirstChild("Head") then
					if not workspace:WaitForChild("WarriorsCampaignLog"):FindFirstChild(i.Name) then
						local Clone = BilTemplate:Clone()
						Clone.Parent = FolderAlly
						Clone.Adornee = i.Character:FindFirstChild("Head")
						Clone.Txt.Text = i.Name
						Clone.Txt.TextColor3 = Color3.fromRGB(85, 255, 0)
						Clone.Enabled = true
					end
				end
			end)
		end
	else
		IsAlly = false
		Ally.TextColor3 = Color3.fromRGB(255, 0, 0)
		FolderAlly:ClearAllChildren()
	end
end)


