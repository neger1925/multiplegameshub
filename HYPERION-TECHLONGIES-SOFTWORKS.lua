-- [[ EXECUTOR WHITELIST ]]
do
	local supportedExecutors = {
		["Umbra"] = "Umbra-Fingerprint",
                ["Isaeva"] = "Isaeva-Fingerprint",
                ["Seliware"]  = "Seliware-Fingerprint",
                ["Potassium"] = "Potassium-Fingerprint",
                ["Wave"] = "Wave-Fingerprint",
                ["Volt"] = "Volt-Fingerprint",
                ["Madium"] = "Madium-Fingerprint",
                ["Real"] = "Real-Fingerprint",
                ["Velocity"] = "Velocity-Fingerprint",
                ["SirHurt"] = "SirHurt-Fingerprint",
                ["Solara"] = "Solara-Fingerprint",
		        ["ZigZag"] = "ZigZag-Fingerprint",
                ["Xeno"] = "Xeno-Fingerprint",
                ["Nexomia"] = "Nexomia-Fingerprint",
                ["Synapse Z"] = "Syn-Fingerprint",
                ["Delta"] = "Delta-Fingerprint",
		        ["JohnnySins"] = "JohnnySinsSploit-Fingerprint",
		        ["supQ"] = "supQ-Fingerprint",
		        ["YuBX"] = "YuBX-Fingerprint",
		        ["Fluxus"] = "Fluxus-Fingerprint",
		        ["Exol"] = "Exol-Fingerprint",
		        ["MacSploit"] = "MacSploit-Fingerprint",
		        ["macsploitagain"] = "Macsploit-Fingerprint",
		        ["Opiumware"]  = "Opiumware-Fingerprint",
		        ["bunny"] = "Bunni-Fingerprint",
		        ["Luna"] = "Luna-Fingerprint",
		        ["Nam"] = "Nam-Fingerprint",
	}

	local executorName = "Unknown"
	local success, result = pcall(function()
		return identifyexecutor()
	end)
	if success and result then
		executorName = tostring(result)
	end

	local isWhitelisted = false
	for name, fingerprint in pairs(supportedExecutors) do
		if executorName:find(name, 1, true) then
			local fingerprintSuccess, fpResult = pcall(function()
				return fingerprint
			end)
			if fingerprintSuccess and fpResult then
				getgenv().UmbraFingerprint = fpResult
			end
			isWhitelisted = true
			break
		end
	end

	if not isWhitelisted then
		pcall(function()
			game:GetService("StarterGui"):SetCore("SendNotification", {
				Title = "Umbra Hub",
				Text = "Exploit Not Supported: " .. executorName,
				Duration = 5,
			})
		end)
		task.wait(1)
		pcall(function()
			game:Kick("Exploit Not Supported as it can be Unstable for the script " .. executorName)
		end)
		return
	end
end

if getgenv().UmbraUnload then
	pcall(getgenv().UmbraUnload)
	task.wait(0.2)
end

local PlaceId = game.PlaceId
local GameId = game.GameId

local DOORS_UNIVERSE_ID = 2440500124
local MM2_UNIVERSE_ID = 66654135
local TAG_GAME_PLACE_ID = 14044547200
local ARSENAL_PLACE_ID = 286090429
local RIVALS_PLACE_ID = 17625359962
local ANIMAL_HOSPITAL_PLACE_ID = 111304265646194

local isDoors = (GameId == DOORS_UNIVERSE_ID)
local isMM2 = (GameId == MM2_UNIVERSE_ID or PlaceId == 142823291)
local isTagGame = (PlaceId == TAG_GAME_PLACE_ID)
local isArsenal = (PlaceId == ARSENAL_PLACE_ID)
local isRivals = (PlaceId == RIVALS_PLACE_ID or PlaceId == 117398147513099)
local isAnimalHospital = (PlaceId == ANIMAL_HOSPITAL_PLACE_ID or GameId == 10148749921)

if not isDoors and not isMM2 and not isTagGame and not isArsenal and not isRivals and not isAnimalHospital then
pcall(function()
game:GetService("StarterGui"):SetCore("SendNotification", {
Title = "Umbra Hub",
Text = "Unsupported game! DOORS, MM2, Untitled Tag Game, Arsenal, Rivals, and Animal Hospital are supported.",
Duration = 5
})
end)
return
end

local UmbraLogoPath = "UmbraHubLogo.webp"
if not isfile(UmbraLogoPath) then
	writefile(UmbraLogoPath, game:HttpGet("https://i.ibb.co/3mRvgsk6/umbra-logo-without-background.webp"))
end
local UmbraLogoAsset = getcustomasset(UmbraLogoPath)

if isMM2 then

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

if getgenv().ScriptLibrary ~= "Linoria" and getgenv().ScriptLibrary ~= "Obsidian" then
getgenv().ScriptLibrary = "Linoria"
end

local repo = getgenv().ScriptLibrary == "Obsidian"
and 'https://raw.githubusercontent.com/mstudio45/Obsidian/main/'
or 'https://raw.githubusercontent.com/mstudio45/LinoriaLib/main/'
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
local LibraryName = "Umbra Hub"
local Options = Library.Options
local Toggles = Library.Toggles
local Connections = {}

local Window = Library:CreateWindow({
Title = LibraryName .. " - Murder Mystery 2",
Center = true,
ToggleKeybind = Enum.KeyCode.RightControl,
AutoShow = true,
NotifySide = "Right",
ShowCustomCursor = true,
})

local function Notify(txt, duration)
Library:Notify(txt, duration)
local Sound = Instance.new("Sound", game:GetService("SoundService"))
Sound.SoundId = "rbxassetid://101511361468852"
Sound.PlaybackSpeed = 0.77
Sound.Volume = 2
Sound:Play()
game:GetService("Debris"):AddItem(Sound, 3)
end

local Tabs = {
Main = Window:AddTab('Player', "star"),
ESP = Window:AddTab('ESP', "eye"),
Misc = Window:AddTab('Misc', "settings"),
Info = Window:AddTab('Info', "info"),
Settings = Window:AddTab('Settings', "settings"),
}

local function GetLocalRole()
local leaderstats = LocalPlayer:FindFirstChild("leaderstats")
if leaderstats then
local role = leaderstats:FindFirstChild("Role")
if role then return role.Value end
end
return "Unknown"
end

local function IsMurderer()
return GetLocalRole() == "Murderer"
end

local function IsSheriff()
return GetLocalRole() == "Sheriff"
end

local PlayerBox = Tabs.Main:AddLeftGroupbox('Player')
PlayerBox:AddSlider("MM2Speed", {
Text = "Walk Speed",
Default = 16,
Min = 16,
Max = 100,
Rounding = 0,
Compact = false,
Callback = function() end
})
PlayerBox:AddToggle('EnableMM2Speed', {
Text = "Enable Speed",
Default = false,
Callback = function(Value)
if not Value and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
LocalPlayer.Character.Humanoid.WalkSpeed = 16
end
end
})
PlayerBox:AddToggle('MM2NoClip', {
Text = "No Clip",
Default = false,
}):AddKeyPicker("MM2NoclipKey", {
Default = "N",
SyncToggleState = true,
Mode = "Toggle",
Text = "No Clip",
})
PlayerBox:AddToggle('MM2Flight', {
Text = "Flight",
Default = false,
Callback = function(Value)
if not Value and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
local vel = LocalPlayer.Character.HumanoidRootPart:FindFirstChild("FlightVelocity")
if vel then vel:Destroy() end
end
end
}):AddKeyPicker("MM2FlightKey", {
Default = "F",
SyncToggleState = true,
Mode = "Toggle",
Text = "Flight",
})
PlayerBox:AddSlider("MM2FlightSpeed", {
Text = "Flight Speed",
Default = 50,
Min = 20,
Max = 200,
Rounding = 0,
Compact = false,
Callback = function() end
})
PlayerBox:AddToggle('MM2InfJump', {
Text = "Infinite Jump",
Default = false,
})
PlayerBox:AddToggle('MM2AntiAFK', {
Text = "Anti AFK",
Default = false,
Callback = function(Value)
if Value then
if not getgenv().UmbraMMAntiAfk then
getgenv().UmbraMMAntiAfk = true
task.spawn(function()
while getgenv().UmbraMMAntiAfk do
task.wait(math.random(30, 60))
pcall(function()
local vu = game:GetService("VirtualUser")
vu:CaptureController()
vu:ClickButton2(Vector2.new())
end)
end
end)
end
else
getgenv().UmbraMMAntiAfk = false
end
end
})

local ESPBox = Tabs.ESP:AddLeftGroupbox('ESP')
ESPBox:AddToggle('MM2MurdererESP', {
Text = "Murderer ESP",
Default = false,
}):AddColorPicker("MurdererColor", {
Default = Color3.fromRGB(255, 0, 0),
Title = "Murderer Color",
})
ESPBox:AddToggle('MM2SheriffESP', {
Text = "Sheriff ESP",
Default = false,
}):AddColorPicker("SheriffColor", {
Default = Color3.fromRGB(0, 100, 255),
Title = "Sheriff Color",
})
ESPBox:AddToggle('MM2GunESP', {
Text = "Gun ESP",
Default = false,
}):AddColorPicker("GunColor", {
Default = Color3.fromRGB(255, 255, 0),
Title = "Gun Color",
})
ESPBox:AddToggle('MM2InnocentESP', {
Text = "Innocent ESP",
Default = false,
}):AddColorPicker("InnocentColor", {
Default = Color3.fromRGB(0, 255, 8),
Title = "Innocent ESP Color",
})
ESPBox:AddToggle('MM2GoldESP', {
Text = "Gold ESP",
Default = false,
}):AddColorPicker("GoldColor", {
Default = Color3.fromRGB(255, 215, 0),
Title = "Gold Color",
})

local MiscBox = Tabs.Misc:AddLeftGroupbox('Misc')
MiscBox:AddToggle('MM2AutoCollect', {
Text = "Auto Collect Gold",
Default = false,
})
MiscBox:AddSlider("MM2CollectRange", {
Text = "Collect Range",
Default = 15,
Min = 5,
Max = 50,
Rounding = 0,
Compact = false,
Callback = function() end
})
MiscBox:AddDivider()
MiscBox:AddButton({
Text = "Shoot Murderer",
Func = function()
	if FindSheriff() ~= LocalPlayer then
		Notify("You're not the Sheriff!", 3)
		return
	end
	local murderer = FindMurderer()
	if not murderer or not murderer.Character then
		Notify("No murderer found!", 3)
		return
	end
	local murdererHRP = murderer.Character:FindFirstChild("HumanoidRootPart")
	if not murdererHRP then return end
	local gun = LocalPlayer.Character:FindFirstChild("Gun") or LocalPlayer.Backpack:FindFirstChild("Gun")
	if not gun then
		Notify("You don't have the gun!", 3)
		return
	end
	if not LocalPlayer.Character:FindFirstChild("Gun") then
		LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):EquipTool(gun)
		task.wait(0.3)
	end
	local predictedPos = murdererHRP.Position + murdererHRP.AssemblyLinearVelocity * 0.15
	local args = {
		CFrame.new(murdererHRP.Position + Vector3.new(0, 1, 0)),
		CFrame.new(predictedPos)
	}
	pcall(function()
		LocalPlayer.Character:WaitForChild("Gun"):WaitForChild("Shoot"):FireServer(unpack(args))
	end)
end
})
MiscBox:AddButton({
Text = "Teleport to Gun",
Func = function()
	local map = nil
	for _, obj in ipairs(workspace:GetChildren()) do
		if obj:FindFirstChild("CoinContainer") and obj:FindFirstChild("Spawns") then
			map = obj
			break
		end
	end
	local gunDrop = map and map:FindFirstChild("GunDrop")
	if not gunDrop then
		Notify("No dropped gun found!", 3)
		return
	end
	local char = LocalPlayer.Character
	if not char or not char:FindFirstChild("HumanoidRootPart") then return end
	local prevPos = char:GetPivot()
	char:PivotTo(gunDrop:GetPivot())
	task.wait(0.3)
	local backpackConn
	backpackConn = LocalPlayer.Backpack.ChildAdded:Connect(function(child)
		if child.Name == "Gun" then
			if backpackConn then backpackConn:Disconnect() end
			char:PivotTo(prevPos)
			Notify("Gun picked up!", 3)
		end
	end)
	task.delay(3, function()
		if backpackConn then backpackConn:Disconnect() end
		char:PivotTo(prevPos)
	end)
end
})
MiscBox:AddDivider()

local ESPScreenGui = Instance.new("ScreenGui")
ESPScreenGui.Name = "UmbraESP"
ESPScreenGui.DisplayOrder = 999
ESPScreenGui.IgnoreGuiInset = true
ESPScreenGui.Parent = game:GetService("CoreGui")

local ESPHighlights = {}
local ESPLabels = {}

local playerData = {}

local function FindMurderer()
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= LocalPlayer and p.Backpack:FindFirstChild("Knife") then return p end
	end
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Knife") then return p end
	end
	if playerData then
		for name, data in pairs(playerData) do
			if data.Role == "Murderer" then
				local p = Players:FindFirstChild(name)
				if p and p ~= LocalPlayer then return p end
			end
		end
	end
	return nil
end

local function FindSheriff()
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= LocalPlayer and p.Backpack:FindFirstChild("Gun") then return p end
	end
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Gun") then return p end
	end
	if playerData then
		for name, data in pairs(playerData) do
			if data.Role == "Sheriff" then
				local p = Players:FindFirstChild(name)
				if p and p ~= LocalPlayer then return p end
			end
		end
	end
	return nil
end

local function GetOrCreateHighlight(target, name, fillColor, fillTransparency)
	local key = tostring(target) .. name
	if ESPHighlights[key] and ESPHighlights[key].Parent then
		ESPHighlights[key].FillColor = fillColor
		return ESPHighlights[key]
	end
	local hl = Instance.new("Highlight")
	hl.Name = "Umbra_" .. name
	hl.FillColor = fillColor
	hl.FillTransparency = fillTransparency or 0.7
	hl.OutlineColor = fillColor
	hl.OutlineTransparency = 0
	hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	hl.Adornee = target
	hl.Parent = ESPScreenGui
	ESPHighlights[key] = hl
	return hl
end

local function RemoveHighlight(target, name)
	local key = tostring(target) .. name
	if ESPHighlights[key] then
		pcall(function() ESPHighlights[key]:Destroy() end)
		ESPHighlights[key] = nil
	end
end

local function GetOrCreateLabel(target, name, text, color)
	local key = tostring(target) .. "Label_" .. name
	if ESPLabels[key] and ESPLabels[key].Parent then return ESPLabels[key] end
	local bb = Instance.new("BillboardGui")
	bb.Name = "Umbra_Label_" .. name
	bb.AlwaysOnTop = true
	bb.Size = UDim2.new(0, 80, 0, 30)
	bb.StudsOffset = Vector3.new(0, 3, 0)
	bb.Adornee = target
	bb.Parent = ESPScreenGui
	local tl = Instance.new("TextLabel")
	tl.Size = UDim2.new(1, 0, 1, 0)
	tl.BackgroundTransparency = 1
	tl.Font = Enum.Font.SourceSansBold
	tl.TextScaled = true
	tl.TextColor3 = color
	tl.Text = text
	tl.Parent = bb
	local stroke = Instance.new("UIStroke", tl)
	stroke.Color = Color3.new(0, 0, 0)
	stroke.Thickness = 2
	ESPLabels[key] = bb
	return bb
end

local function RemoveLabel(target, name)
	local key = tostring(target) .. "Label_" .. name
	if ESPLabels[key] then
		pcall(function() ESPLabels[key]:Destroy() end)
		ESPLabels[key] = nil
	end
end

local function ClearAllESP()
	for key, hl in pairs(ESPHighlights) do
		pcall(function() hl:Destroy() end)
	end
	ESPHighlights = {}
	for key, bb in pairs(ESPLabels) do
		pcall(function() bb:Destroy() end)
	end
	ESPLabels = {}
end

local function ClearGroup(prefix)
	for key, hl in pairs(ESPHighlights) do
		if key:find(prefix, 1, true) then
			pcall(function() hl:Destroy() end)
			ESPHighlights[key] = nil
		end
	end
	for key, bb in pairs(ESPLabels) do
		if key:find(prefix, 1, true) then
			pcall(function() bb:Destroy() end)
			ESPLabels[key] = nil
		end
	end
end

local espTick = 0
local function UpdateESP()
	local now = tick()
	if now - espTick < 0.25 then return end
	espTick = now

	local murderer = FindMurderer()
	local sheriff = FindSheriff()

	for _, player in ipairs(Players:GetPlayers()) do
		if player == LocalPlayer then continue end
		local char = player.Character
		if not char or not char:FindFirstChild("HumanoidRootPart") then continue end

		if player == murderer and Toggles.MM2MurdererESP.Value then
			GetOrCreateHighlight(char, "Murderer", Options.MurdererColor.Value, 0.5)
			GetOrCreateLabel(char:FindFirstChild("HumanoidRootPart") or char, "Murderer", "MURDERER", Options.MurdererColor.Value)
		else
			RemoveHighlight(char, "Murderer")
			RemoveLabel(char:FindFirstChild("HumanoidRootPart") or char, "Murderer")
		end

		if player == sheriff and Toggles.MM2SheriffESP.Value then
			GetOrCreateHighlight(char, "Sheriff", Options.SheriffColor.Value, 0.5)
			GetOrCreateLabel(char:FindFirstChild("HumanoidRootPart") or char, "Sheriff", "SHERIFF", Options.SheriffColor.Value)
		else
			RemoveHighlight(char, "Sheriff")
			RemoveLabel(char:FindFirstChild("HumanoidRootPart") or char, "Sheriff")
		end

		if player ~= murderer and player ~= sheriff and Toggles.MM2InnocentESP.Value then
			GetOrCreateHighlight(char, "Innocent", Options.InnocentColor.Value, 0.7)
		else
			RemoveHighlight(char, "Innocent")
		end
	end

	ClearGroup("Gun")
	if Toggles.MM2GunESP.Value then
		for _, obj in ipairs(workspace:GetChildren()) do
			if obj.Name == "GunDrop" or (obj.Name == "Gun" and obj.Parent == workspace) then
				local part = obj:FindFirstChildWhichIsA("BasePart") or obj.PrimaryPart
				if part then
					GetOrCreateHighlight(obj, "Gun", Options.GunColor.Value, 0.3)
					GetOrCreateLabel(part, "Gun", "GUN", Options.GunColor.Value)
				end
			end
		end
	end

	ClearGroup("Gold")
	if Toggles.MM2GoldESP.Value then
		for _, obj in ipairs(workspace:GetChildren()) do
			if obj.Name == "GoldDrop" or obj.Name == "Gold" then
				local part = obj:FindFirstChildWhichIsA("BasePart") or obj.PrimaryPart
				if part then
					GetOrCreateHighlight(obj, "Gold", Options.GoldColor.Value, 0.3)
				end
			end
		end
	end
end

local function CleanupAllHighlights()
	ClearAllESP()
end

local pDataRemotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
if pDataRemotes then
	local gameplay = pDataRemotes:FindFirstChild("Gameplay")
	if gameplay then
		local pdRemote = gameplay:FindFirstChild("PlayerDataChanged", true) or gameplay:FindFirstChild("PlayerDataChanged")
		if pdRemote then
			pdRemote.OnClientEvent:Connect(function(data)
				playerData = data or {}
			end)
		end
	end
end

local espUpdateConn = RunService.Heartbeat:Connect(function()
	if Library and Library.Unloaded then return end
	pcall(UpdateESP)
end)
table.insert(Connections, espUpdateConn)

local speedConn = RunService.Heartbeat:Connect(function()
	if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
	local char = LocalPlayer.Character
	local hrp = char:FindFirstChild("HumanoidRootPart")
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hum then return end

	if Toggles.EnableMM2Speed.Value then
		hum.WalkSpeed = Options.MM2Speed.Value
	end

	if Toggles.MM2NoClip.Value then
		for _, v in ipairs(char:GetChildren()) do
			if v:IsA("BasePart") then
				v.CanCollide = false
			end
		end
	end

	if Toggles.MM2Flight.Value then
		if not hrp:FindFirstChild("FlightVelocity") then
			local vel = Instance.new("BodyVelocity", hrp)
			vel.Name = "FlightVelocity"
			vel.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
			vel.Velocity = Vector3.zero
			vel.P = math.huge
		end
		local moveDir = hum.MoveDirection
		local speed = Options.MM2FlightSpeed.Value
		hrp.FlightVelocity.Velocity = moveDir * speed + Vector3.new(0, (UserInputService:IsKeyDown(Enum.KeyCode.Space) and speed or 0) - (UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) and speed or 0), 0)
	end
end)
table.insert(Connections, speedConn)

task.spawn(function()
	while Connections and #Connections > 0 do
		if Toggles.MM2AutoCollect.Value then
			pcall(function()
				local char = LocalPlayer.Character
				local hrp = char and char:FindFirstChild("HumanoidRootPart")
				if hrp then
					local collectRange = Options.MM2CollectRange.Value
					for _, obj in ipairs(workspace:GetChildren()) do
						if obj.Name == "GoldDrop" or obj.Name == "Gold" then
							local prompt = obj:FindFirstChildWhichIsA("ProximityPrompt", true)
							if prompt and prompt.Enabled then
								local targetPart = obj:FindFirstChildWhichIsA("BasePart") or obj.PrimaryPart
								if targetPart and (hrp.Position - targetPart.Position).Magnitude <= collectRange then
									prompt:InputHoldBegin()
									prompt:InputHoldEnd(0)
								end
							end
						end
					end
				end
			end)
		end
		task.wait(0.25)
	end
end)

table.insert(Connections, UserInputService.JumpRequest:Connect(function()
	if Toggles.MM2InfJump and Toggles.MM2InfJump.Value and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
		LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping, true)
	end
end))

Players.PlayerRemoving:Connect(function(player)
	local char = player.Character
	if char then
		for key, hl in pairs(ESPHighlights) do
			if key:find(tostring(char), 1, true) then
				pcall(function() hl:Destroy() end)
				ESPHighlights[key] = nil
			end
		end
		for key, bb in pairs(ESPLabels) do
			if key:find(tostring(char), 1, true) then
				pcall(function() bb:Destroy() end)
				ESPLabels[key] = nil
			end
		end
	end
end)

local MenuGroup = Tabs.Settings:AddLeftGroupbox('UI Settings')
local UtilityBox = Tabs.Settings:AddRightGroupbox('Hub Utilities')
local InfoGroup = Tabs.Info:AddLeftGroupbox('Credits')
InfoGroup:AddLabel("Umbra Hub v1.0", true)
InfoGroup:AddDivider()
InfoGroup:AddLabel("Credits to Umbra [vynxiscool_1]", true)
InfoGroup:AddLabel("On Discord", true)
InfoGroup:AddDivider()
InfoGroup:AddLabel("AI Hub for helping on the UI", true)
InfoGroup:AddDivider()
InfoGroup:AddLabel("Thank you for using Umbra Hub!", true)
UtilityBox:AddLabel("Umbra Hub - MM2", true)
UtilityBox:AddButton({
Text = "Unload Hub",
Func = function()
for _, conn in ipairs(Connections) do
pcall(function() conn:Disconnect() end)
end
CleanupAllHighlights()
pcall(function() Library:Unload() end)
end
})
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({'MenuKeybind'})
ThemeManager:SetFolder("Umbra")
SaveManager:SetFolder("Umbra/MM2")
SaveManager:BuildConfigSection(Tabs['Settings'])
ThemeManager:ApplyToTab(Tabs['Settings'])
Notify("Umbra Hub Loaded for Murder Mystery 2!", 4)

do
local mobileGui = Instance.new("ScreenGui")
mobileGui.Name = "UmbraMobileToggle"
mobileGui.ResetOnSpawn = false
mobileGui.IgnoreGuiInset = true
mobileGui.DisplayOrder = 99998
mobileGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local toggleBtn = Instance.new("TextButton")
toggleBtn.Name = "ToggleUI"
toggleBtn.Size = UDim2.new(0, 50, 0, 50)
toggleBtn.Position = UDim2.new(0, 12, 0.5, -25)
toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggleBtn.BackgroundTransparency = 0
toggleBtn.Text = ""
toggleBtn.Image = UmbraLogoAsset
toggleBtn.ImageColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.ScaleType = Enum.ScaleType.Fit
toggleBtn.BorderSizePixel = 0
toggleBtn.AutoButtonColor = true
toggleBtn.ZIndex = 99998
toggleBtn.Parent = mobileGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = toggleBtn

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(150, 150, 150)
stroke.Thickness = 2
stroke.Parent = toggleBtn

local dragging = false
local dragStart = nil
local startPos = nil
local hasDragged = false

toggleBtn.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
dragging = true
hasDragged = false
dragStart = input.Position
startPos = toggleBtn.Position
input.Changed:Connect(function()
if input.UserInputState == Enum.UserInputState.End then
dragging = false
end
end)
end
end)

UserInputService.InputChanged:Connect(function(input)
if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
local delta = input.Position - dragStart
if math.abs(delta.X) > 5 or math.abs(delta.Y) > 5 then
hasDragged = true
end
toggleBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end
end)

toggleBtn.MouseButton1Click:Connect(function()
if hasDragged then return end
pcall(function()
if Library and Library.Toggle then
Library:Toggle()
end
end)
end)
end

return
end

if isTagGame then

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

if getgenv().ScriptLibrary ~= "Linoria" and getgenv().ScriptLibrary ~= "Obsidian" then
getgenv().ScriptLibrary = "Linoria"
end

local repo = getgenv().ScriptLibrary == "Obsidian"
and 'https://raw.githubusercontent.com/mstudio45/Obsidian/main/'
or 'https://raw.githubusercontent.com/mstudio45/LinoriaLib/main/'
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
local LibraryName = "Umbra Hub"
local Options = Library.Options
local Toggles = Library.Toggles
local Connections = {}

local Window = Library:CreateWindow({
Title = LibraryName .. " - Untitled Tag Game",
Center = true,
ToggleKeybind = Enum.KeyCode.RightControl,
AutoShow = true,
NotifySide = "Right",
ShowCustomCursor = true,
})

local function Notify(txt, duration)
Library:Notify(txt, duration)
end

local Tabs = {
Game = Window:AddTab("Game"),
["UI Settings"] = Window:AddTab("UI Settings"),
}

local LocalPlayer = Players.LocalPlayer

local hitboxSize = Vector3.new(12, 12, 12)
local normalSpeed = 16
local boostedSpeed = normalSpeed * 6

local function GetCharacter()
return LocalPlayer.Character, LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
end

-- Hitbox Expander
local HitboxGroup = Tabs.Game:AddLeftGroupbox("Hitbox Expander")

HitboxGroup:AddToggle("ExpandHitboxes", {
Text = "Expand Hitboxes",
Default = false,
})

HitboxGroup:AddSlider("HitboxSize", {
Text = "Hitbox Size",
Default = 12,
Min = 4,
Max = 50,
Rounding = 0,
})

HitboxGroup:AddToggle("HitboxTransparency", {
Text = "Show Hitboxes",
Default = true,
})

-- Speed Boost
local SpeedGroup = Tabs.Game:AddRightGroupbox("Speed Boost")

SpeedGroup:AddToggle("SpeedBoost", {
Text = "Speed Boost",
Default = false,
})

SpeedGroup:AddSlider("SpeedMultiplier", {
Text = "Speed Multiplier",
Default = 6,
Min = 2,
Max = 16,
Rounding = 0,
})

-- Movement
local MovementGroup = Tabs.Game:AddRightGroupbox("Movement")

MovementGroup:AddToggle("InfiniteJump", {
Text = "Infinite Jump",
Default = false,
})

MovementGroup:AddToggle("NoClip", {
Text = "No Clip",
Default = false,
})

-- ESP for taggers
local ESPGroup = Tabs.Game:AddLeftGroupbox("ESP")

ESPGroup:AddToggle("PlayerESP", {
Text = "Show Tagger ESP",
Default = false,
})

ESPGroup:AddSlider("PlayerESPRange", {
Text = "ESP Range",
Default = 200,
Min = 50,
Max = 500,
Rounding = 0,
})

-- === LOGIC BELOW ===

local origSizes = {}

local function ExpandAllHitboxes()
if not (Toggles.ExpandHitboxes and Toggles.ExpandHitboxes.Value) then return end
local size = Options.HitboxSize and Options.HitboxSize.Value or 12
local showTrans = Toggles.HitboxTransparency and Toggles.HitboxTransparency.Value
local curSize = Vector3.new(size, size, size)
for _, plr in ipairs(Players:GetPlayers()) do
if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
local hrp = plr.Character.HumanoidRootPart
local hum = plr.Character:FindFirstChild("Humanoid")
if hum and hum.Health > 0 then
if not origSizes[plr] then
origSizes[plr] = hrp.Size
end
hrp.Size = curSize
hrp.Transparency = showTrans and 0.5 or 1
hrp.CanCollide = false
elseif origSizes[plr] then
hrp.Size = origSizes[plr]
hrp.Transparency = 1
origSizes[plr] = nil
end
end
end
end

local function ResetAllHitboxes()
for plr, origSize in pairs(origSizes) do
if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
plr.Character.HumanoidRootPart.Size = origSize
plr.Character.HumanoidRootPart.Transparency = 1
end
end
table.clear(origSizes)
end

Toggles.ExpandHitboxes:OnChanged(function()
ExpandAllHitboxes()
end)

Toggles.HitboxTransparency:OnChanged(function()
if Toggles.ExpandHitboxes and Toggles.ExpandHitboxes.Value then
ExpandAllHitboxes()
end
end)

Toggles.SpeedBoost:OnChanged(function()
local _, hum = GetCharacter()
if hum then
if Toggles.SpeedBoost and Toggles.SpeedBoost.Value then
local mult = Options.SpeedMultiplier and Options.SpeedMultiplier.Value or 6
hum.WalkSpeed = normalSpeed * mult
else
hum.WalkSpeed = normalSpeed
end
end
end)

LocalPlayer.CharacterAdded:Connect(function(char)
task.wait(0.5)
local hum = char:WaitForChild("Humanoid", 5)
if hum then
if Toggles.SpeedBoost and Toggles.SpeedBoost.Value then
local mult = Options.SpeedMultiplier and Options.SpeedMultiplier.Value or 6
hum.WalkSpeed = normalSpeed * mult
else
hum.WalkSpeed = normalSpeed
end
end
end)

local noClipConn = nil

Toggles.NoClip:OnChanged(function()
if Toggles.NoClip and Toggles.NoClip.Value then
noClipConn = RunService.Stepped:Connect(function()
local char = LocalPlayer.Character
if char then
for _, part in ipairs(char:GetDescendants()) do
if part:IsA("BasePart") then
part.CanCollide = false
end
end
end
end)
else
if noClipConn then
noClipConn:Disconnect()
noClipConn = nil
end
end
end)

UserInputService.JumpRequest:Connect(function()
if Toggles.InfiniteJump and Toggles.InfiniteJump.Value then
local _, hum = GetCharacter()
if hum then
hum:ChangeState(Enum.HumanoidStateType.Jumping)
end
end
end)

local playerHighlights = {}

local function UpdatePlayerESP()
local range = Options.PlayerESPRange and Options.PlayerESPRange.Value or 200
local char = LocalPlayer.Character
local myHRP = char and char:FindFirstChild("HumanoidRootPart")

for _, plr in ipairs(Players:GetPlayers()) do
if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
local hrp = plr.Character.HumanoidRootPart
local dist = myHRP and (hrp.Position - myHRP.Position).Magnitude or 0
local hum = plr.Character:FindFirstChild("Humanoid")
local isAlive = hum and hum.Health > 0

if Toggles.PlayerESP and Toggles.PlayerESP.Value and isAlive and dist <= range then
if not playerHighlights[plr] then
local hl = Instance.new("Highlight")
hl.Name = "Umbra_PlayerESP"
hl.FillTransparency = 0.7
hl.OutlineTransparency = 0
hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
hl.Parent = plr.Character
playerHighlights[plr] = hl
end
local isTagger = false
local leaderstats = plr:FindFirstChild("leaderstats")
if leaderstats then
local tagValue = leaderstats:FindFirstChild("Tagger")
if tagValue and tagValue.Value == true then
isTagger = true
end
end
if plr.Character:FindFirstChild("Tagged") or plr.Character:GetAttribute("Tagged") then
isTagger = true
end
playerHighlights[plr].FillColor = isTagger and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(50, 255, 50)
playerHighlights[plr].OutlineColor = isTagger and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(0, 255, 0)
else
if playerHighlights[plr] then
playerHighlights[plr]:Destroy()
playerHighlights[plr] = nil
end
end
else
if playerHighlights[plr] then
playerHighlights[plr]:Destroy()
playerHighlights[plr] = nil
end
end
end
end

Toggles.PlayerESP:OnChanged(function()
if not (Toggles.PlayerESP and Toggles.PlayerESP.Value) then
for plr, hl in pairs(playerHighlights) do
hl:Destroy()
end
table.clear(playerHighlights)
end
end)

RunService.RenderStepped:Connect(function()
pcall(UpdatePlayerESP)
end)

Players.PlayerRemoving:Connect(function(plr)
if playerHighlights[plr] then
playerHighlights[plr]:Destroy()
playerHighlights[plr] = nil
end
origSizes[plr] = nil
end)

-- Unload
getgenv().UmbraUnload = function()
for _, conn in ipairs(Connections) do
if conn and conn.Disconnect then pcall(function() conn:Disconnect() end) end
end
table.clear(Connections)
for _, hl in pairs(playerHighlights) do
hl:Destroy()
end
table.clear(playerHighlights)
ResetAllHitboxes()
pcall(function() Library:Unload() end)
getgenv().UmbraUnload = nil
end

-- Theme/Save
ThemeManager:SetFolder("Umbra/TagGame")
SaveManager:SetFolder("Umbra/TagGame")
SaveManager:BuildConfigSection(Tabs["UI Settings"])
ThemeManager:ApplyToTab(Tabs["UI Settings"])

SaveManager:LoadAutoloadConfig()

Notify("Umbra Hub Loaded for Untitled Tag Game!", 4)

do
local mobileGui = Instance.new("ScreenGui")
mobileGui.Name = "UmbraMobileToggle"
mobileGui.ResetOnSpawn = false
mobileGui.IgnoreGuiInset = true
mobileGui.DisplayOrder = 99998
mobileGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local toggleBtn = Instance.new("TextButton")
toggleBtn.Name = "ToggleUI"
toggleBtn.Size = UDim2.new(0, 50, 0, 50)
toggleBtn.Position = UDim2.new(0, 12, 0.5, -25)
toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggleBtn.BackgroundTransparency = 0
toggleBtn.Text = ""
toggleBtn.Image = UmbraLogoAsset
toggleBtn.ImageColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.ScaleType = Enum.ScaleType.Fit
toggleBtn.BorderSizePixel = 0
toggleBtn.AutoButtonColor = true
toggleBtn.ZIndex = 99998
toggleBtn.Parent = mobileGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = toggleBtn

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(150, 150, 150)
stroke.Thickness = 2
stroke.Parent = toggleBtn

local dragging = false
local dragStart = nil
local startPos = nil
local hasDragged = false

toggleBtn.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
dragging = true
hasDragged = false
dragStart = input.Position
startPos = toggleBtn.Position
input.Changed:Connect(function()
if input.UserInputState == Enum.UserInputState.End then
dragging = false
end
end)
end
end)

UserInputService.InputChanged:Connect(function(input)
if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
local delta = input.Position - dragStart
if math.abs(delta.X) > 5 or math.abs(delta.Y) > 5 then
hasDragged = true
end
toggleBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end
end)

toggleBtn.MouseButton1Click:Connect(function()
if hasDragged then return end
pcall(function()
if Library and Library.Toggle then
Library:Toggle()
end
end)
end)
end

return
end

if isArsenal then

local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace        = game:GetService("Workspace")
local StarterGui       = game:GetService("StarterGui")
local VIM              = game:GetService("VirtualInputManager")

if getgenv().ScriptLibrary ~= "Linoria" and getgenv().ScriptLibrary ~= "Obsidian" then
getgenv().ScriptLibrary = "Linoria"
end

local repo = getgenv().ScriptLibrary == "Obsidian"
and 'https://raw.githubusercontent.com/mstudio45/Obsidian/main/'
or 'https://raw.githubusercontent.com/mstudio45/LinoriaLib/main/'
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
local LibraryName = "Umbra Hub"
local Options = Library.Options
local Toggles = Library.Toggles

local LocalPlayer = Players.LocalPlayer
local Camera      = Workspace.CurrentCamera
local Mouse       = LocalPlayer:GetMouse()

local Window = Library:CreateWindow({
Title = LibraryName .. " - Arsenal",
Center = true,
ToggleKeybind = Enum.KeyCode.RightControl,
AutoShow = true,
NotifySide = "Right",
ShowCustomCursor = true,
})

local function Notify(txt, duration)
Library:Notify(txt, duration)
end

local Tabs = {
Combat    = Window:AddTab("Combat"),
Movement  = Window:AddTab("Movement"),
Visuals   = Window:AddTab("Visuals"),
Utility   = Window:AddTab("Utility"),
["UI Settings"] = Window:AddTab("UI Settings"),
}

-- === HELPERS ===
local function getChar() return LocalPlayer.Character end
local function getHRP()
local c = getChar(); return c and c:FindFirstChild("HumanoidRootPart")
end
local function getHum()
local c = getChar(); return c and c:FindFirstChildOfClass("Humanoid")
end

local function hasLOS(origin, target)
local dir = target - origin
local rp  = RaycastParams.new()
rp.FilterType = Enum.RaycastFilterType.Exclude
local ex = {}
for _, p in ipairs(Players:GetPlayers()) do
if p.Character then table.insert(ex, p.Character) end
end
rp.FilterDescendantsInstances = ex
return Workspace:Raycast(origin, dir.Unit * dir.Magnitude, rp) == nil
end

local function worldToViewport(pos)
local vp, onScreen = Camera:WorldToViewportPoint(pos)
return Vector2.new(vp.X, vp.Y), onScreen, vp.Z
end

-- === TEAM CHECK ===
local function isEnemy(p)
if p == LocalPlayer then return false end
local myTeam    = LocalPlayer.Team
local theirTeam = p.Team
if myTeam and theirTeam then return myTeam ~= theirTeam end
return true
end

-- === HITBOX EXPANDER ===
local hitboxOriginals = {}
local defaultWalkSpeed = 16
local HITBOX_SIZE = 10

local function applyHitbox(p)
if not isEnemy(p) then return end
local char = p.Character; if not char then return end
local hrp  = char:FindFirstChild("HumanoidRootPart"); if not hrp then return end
if not hitboxOriginals[p] then hitboxOriginals[p] = hrp.Size end
hrp.Size = Vector3.new(HITBOX_SIZE, HITBOX_SIZE, HITBOX_SIZE)
hrp.Transparency = 1
end

local function restoreHitbox(p)
local orig = hitboxOriginals[p]; if not orig then return end
local char = p.Character; if not char then return end
local hrp  = char:FindFirstChild("HumanoidRootPart"); if not hrp then return end
hrp.Size = orig
hitboxOriginals[p] = nil
end

local function enableHitbox() for _, p in ipairs(Players:GetPlayers()) do applyHitbox(p) end end
local function disableHitbox() for _, p in ipairs(Players:GetPlayers()) do restoreHitbox(p) end; hitboxOriginals = {} end

RunService.Heartbeat:Connect(function()
if not Toggles.HitboxExpander or not Toggles.HitboxExpander.Value then return end
for _, p in ipairs(Players:GetPlayers()) do
if not isEnemy(p) then continue end
local char = p.Character; if not char then continue end
local hrp  = char:FindFirstChild("HumanoidRootPart"); if not hrp then continue end
local sz = Options.HitboxSize and Options.HitboxSize.Value or 10
if hrp.Size.X < sz then applyHitbox(p) end
end
end)

Players.PlayerRemoving:Connect(function(p) hitboxOriginals[p] = nil end)

-- === FLY ===
local flyBV, flyBG
local FLY_SPEED = 60

local function enableFly()
local hrp = getHRP(); if not hrp then return end
flyBG = Instance.new("BodyGyro")
flyBG.MaxTorque = Vector3.new(9e9,9e9,9e9); flyBG.P = 9e4
flyBG.CFrame = hrp.CFrame; flyBG.Parent = hrp
flyBV = Instance.new("BodyVelocity")
flyBV.Velocity = Vector3.zero
flyBV.MaxForce = Vector3.new(9e9,9e9,9e9); flyBV.Parent = hrp
end
local function disableFly()
if flyBV then flyBV:Destroy(); flyBV = nil end
if flyBG then flyBG:Destroy(); flyBG = nil end
end

RunService.Heartbeat:Connect(function()
if not (Toggles.Fly and Toggles.Fly.Value) then return end
local hrp = getHRP(); if not hrp or not flyBV or not flyBG then return end
local v = Vector3.zero
if UserInputService:IsKeyDown(Enum.KeyCode.W)         then v = v + Camera.CFrame.LookVector  end
if UserInputService:IsKeyDown(Enum.KeyCode.S)         then v = v - Camera.CFrame.LookVector  end
if UserInputService:IsKeyDown(Enum.KeyCode.A)         then v = v - Camera.CFrame.RightVector end
if UserInputService:IsKeyDown(Enum.KeyCode.D)         then v = v + Camera.CFrame.RightVector end
if UserInputService:IsKeyDown(Enum.KeyCode.Space)     then v = v + Vector3.yAxis             end
if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then v = v - Vector3.yAxis             end
flyBV.Velocity = v * FLY_SPEED
flyBG.CFrame   = Camera.CFrame
end)

-- === NOCLIP ===
RunService.Stepped:Connect(function()
if not (Toggles.NoClip and Toggles.NoClip.Value) then return end
local c = getChar(); if not c then return end
for _, p in ipairs(c:GetDescendants()) do
if p:IsA("BasePart") then p.CanCollide = false end
end
end)

-- === SHOOT THROUGH WALLS ===
local shootWallConn
local function enableShootWall()
if shootWallConn then return end
shootWallConn = RunService.Heartbeat:Connect(function()
if not (Toggles.ShootWalls and Toggles.ShootWalls.Value) then return end
local t = Mouse.Target
if not t or not t:IsA("BasePart") then return end
local inChar = false
for _, p in ipairs(Players:GetPlayers()) do
if p.Character and t:IsDescendantOf(p.Character) then inChar = true; break end
end
if inChar then return end
local orig = t.CanCollide; t.CanCollide = false
task.defer(function() if t and t.Parent then t.CanCollide = orig end end)
end)
end
local function disableShootWall()
if shootWallConn then shootWallConn:Disconnect(); shootWallConn = nil end
end

-- === TRIGGERBOT ===
local triggerbotConn
local function getEnemyAtCrosshair()
	local vp = Camera.ViewportSize
	local center = Vector2.new(vp.X / 2, vp.Y / 2)
	local rp = RaycastParams.new()
	rp.FilterType = Enum.RaycastFilterType.Exclude
	local exclude = {}; local myChar = getChar()
	if myChar then table.insert(exclude, myChar) end
	rp.FilterDescendantsInstances = exclude
	-- Primary: raycast check
	local unitRay = Camera:ScreenPointToRay(center.X, center.Y)
	local result = workspace:Raycast(unitRay.Origin, unitRay.Direction * 1000, rp)
	if result then
		local hitPart = result.Instance
		for _, p in ipairs(Players:GetPlayers()) do
			if not isEnemy(p) then continue end
			local char = p.Character; if not char then continue end
			if not hitPart:IsDescendantOf(char) then continue end
			local hum = char:FindFirstChildOfClass("Humanoid")
			if hum and hum.Health > 0 then return char, hitPart end
		end
	end
	-- Fallback: closest enemy head/HRP to screen center
	local bestChar, bestPart, bestDist2 = nil, nil, 50
	for _, p in ipairs(Players:GetPlayers()) do
		if not isEnemy(p) then continue end
		local char = p.Character; if not char then continue end
		local hum = char:FindFirstChildOfClass("Humanoid")
		if not hum or hum.Health <= 0 then continue end
		local part = char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")
		if not part then continue end
		local vPos, onScreen = Camera:WorldToViewportPoint(part.Position)
		if not onScreen or vPos.Z <= 0 then continue end
		local d = (Vector2.new(vPos.X, vPos.Y) - center).Magnitude
		if d < bestDist2 then bestChar, bestPart, bestDist2 = char, part, d end
	end
	return bestChar, bestPart
end

local function triggerFireTool(enemyChar, hitPart)
	local char = getChar(); if not char then return end
	local tool = char:FindFirstChildOfClass("Tool"); if not tool then return end
	local targetPos = hitPart and hitPart.Position or Mouse.Hit.Position
	-- Arsenal primary: mouse1click (native exploit API, instant down+up)
	if mouse1click then
		pcall(mouse1click)
	end
	-- Arsenal fallback: VIM rapid fire (no yield between down/up)
	pcall(function()
		VIM:SendMouseButtonEvent(Mouse.X, Mouse.Y, 0, true, game, 1)
		VIM:SendMouseButtonEvent(Mouse.X, Mouse.Y, 0, false, game, 1)
	end)
	-- tool:Activate as extra fallback
	pcall(function() tool:Activate() end)
	-- Fire weapon remotes as last resort
	for _, obj in ipairs(tool:GetDescendants()) do
		if obj:IsA("RemoteEvent") then
			pcall(function() obj:FireServer(targetPos, hitPart) end)
		end
	end
end

local triggerbotConn
local triggerbotCooldown = 0
local function enableTriggerbot()
	if triggerbotConn then return end
	triggerbotConn = RunService.RenderStepped:Connect(function()
		if not (Toggles.Triggerbot and Toggles.Triggerbot.Value) then return end
		local now = tick()
		if (now - triggerbotCooldown) < 0.05 then return end
		local enemyChar, hitPart = getEnemyAtCrosshair()
		if not enemyChar then return end
		triggerbotCooldown = now
		triggerFireTool(enemyChar, hitPart)
	end)
end
local function disableTriggerbot()
	if triggerbotConn then triggerbotConn:Disconnect(); triggerbotConn = nil end
end

-- === ESP ===
local espObjects = {}
local ESP_COLOR    = Color3.fromRGB(255, 105, 180)
local TRACER_COLOR = Color3.fromRGB(255, 105, 180)

local function newDrawing(type_, props)
local d = Drawing.new(type_)
for k, v in pairs(props) do d[k] = v end
return d
end

local function removeESPForPlayer(p)
local objs = espObjects[p]
if not objs then return end
for _, d in pairs(objs) do
if typeof(d) == "table" then
for _, dd in pairs(d) do pcall(function() dd:Remove() end) end
else pcall(function() d:Remove() end) end
end
espObjects[p] = nil
end

local function createESPForPlayer(p)
if p == LocalPlayer then return end
removeESPForPlayer(p)
local objs = {}
objs.boxLines = {}
for i = 1, 4 do objs.boxLines[i] = newDrawing("Line", {Visible=false, Color=ESP_COLOR, Thickness=1.5, Transparency=1, ZIndex=5}) end
objs.cornerLines = {}
for i = 1, 8 do objs.cornerLines[i] = newDrawing("Line", {Visible=false, Color=Color3.fromRGB(255,255,255), Thickness=2, Transparency=1, ZIndex=6}) end
objs.nameLabel = newDrawing("Text", {Visible=false, Color=Color3.fromRGB(255,255,255), Size=13, Font=Drawing.Fonts.UI, Outline=true, OutlineColor=Color3.fromRGB(0,0,0), Center=true, ZIndex=7})
objs.distLabel = newDrawing("Text", {Visible=false, Color=Color3.fromRGB(255,192,203), Size=11, Font=Drawing.Fonts.UI, Outline=true, OutlineColor=Color3.fromRGB(0,0,0), Center=true, ZIndex=7})
objs.healthBg = newDrawing("Line", {Visible=false, Color=Color3.fromRGB(0,0,0), Thickness=4, Transparency=1, ZIndex=4})
objs.healthBar = newDrawing("Line", {Visible=false, Color=Color3.fromRGB(255,20,147), Thickness=3, Transparency=1, ZIndex=5})
objs.tracer = newDrawing("Line", {Visible=false, Color=TRACER_COLOR, Thickness=1, Transparency=0.7, ZIndex=3})
espObjects[p] = objs
end

local function updateESP()
if not (Toggles.ESP and Toggles.ESP.Value) then
for _, objs in pairs(espObjects) do
for _, v in pairs(objs) do
if typeof(v) == "table" then for _, d in pairs(v) do pcall(function() d.Visible = false end) end
else pcall(function() v.Visible = false end) end
end
end
return
end

local vp = Camera.ViewportSize
local tracerOrigin = Vector2.new(vp.X / 2, vp.Y)

for _, p in ipairs(Players:GetPlayers()) do
	if p == LocalPlayer then continue end
	if Toggles.ESPTeamCheck and Toggles.ESPTeamCheck.Value and not isEnemy(p) then
		if espObjects[p] then
			for _, v in pairs(espObjects[p]) do
				if typeof(v) == "table" then for _, d in pairs(v) do pcall(function() d.Visible = false end) end
				else pcall(function() v.Visible = false end) end
			end
		end
		continue
	end
	if not espObjects[p] then createESPForPlayer(p) end

local objs = espObjects[p]
local char = p.Character
local hrp  = char and char:FindFirstChild("HumanoidRootPart")
local hum  = char and char:FindFirstChildOfClass("Humanoid")

if not hrp or not hum or hum.Health <= 0 then
for _, v in pairs(objs) do
if typeof(v) == "table" then for _, d in pairs(v) do pcall(function() d.Visible = false end) end
else pcall(function() v.Visible = false end) end
end
continue
end

local myHRP = getHRP()
if Toggles.ESPWallCheck and Toggles.ESPWallCheck.Value and myHRP and not hasLOS(myHRP.Position, hrp.Position) then
for _, v in pairs(objs) do
if typeof(v) == "table" then for _, d in pairs(v) do pcall(function() d.Visible = false end) end
else pcall(function() v.Visible = false end) end
end
continue
end

local head = char:FindFirstChild("Head")
local headPos = head and head.Position or (hrp.Position + Vector3.new(0, 2.5, 0))
local feetPos = hrp.Position - Vector3.new(0, 2.8, 0)
local topScreen, topOn, topZ = worldToViewport(headPos + Vector3.new(0, 0.4, 0))
local bottomScreen, bottomOn, _ = worldToViewport(feetPos)

if not (topOn or bottomOn) or topZ < 0 then
for _, v in pairs(objs) do
if typeof(v) == "table" then for _, d in pairs(v) do pcall(function() d.Visible = false end) end
else pcall(function() v.Visible = false end) end
end
continue
end

local height = math.abs(topScreen.Y - bottomScreen.Y)
local width  = height * 0.5
local cx     = topScreen.X
local L, R, T, B = cx - width / 2, cx + width / 2, topScreen.Y, bottomScreen.Y
local dist = myHRP and math.floor((myHRP.Position - hrp.Position).Magnitude) or 0
local hpRatio = hum.MaxHealth > 0 and math.clamp(hum.Health / hum.MaxHealth, 0, 1) or 0
local hpColor = Color3.fromRGB(255, math.floor(20 + (100 * hpRatio)), math.floor(100 + (80 * hpRatio)))

if Toggles.ESPBoxes and Toggles.ESPBoxes.Value then
local bl = objs.boxLines
bl[1].From = Vector2.new(L, T); bl[1].To = Vector2.new(R, T); bl[1].Visible = true; bl[1].Color = ESP_COLOR
bl[2].From = Vector2.new(L, B); bl[2].To = Vector2.new(R, B); bl[2].Visible = true; bl[2].Color = ESP_COLOR
bl[3].From = Vector2.new(L, T); bl[3].To = Vector2.new(L, B); bl[3].Visible = true; bl[3].Color = ESP_COLOR
bl[4].From = Vector2.new(R, T); bl[4].To = Vector2.new(R, B); bl[4].Visible = true; bl[4].Color = ESP_COLOR
local cw, ch, cl = width * 0.28, height * 0.18, objs.cornerLines
cl[1].From=Vector2.new(L,T); cl[1].To=Vector2.new(L+cw,T); cl[1].Visible=true
cl[2].From=Vector2.new(L,T); cl[2].To=Vector2.new(L,T+ch); cl[2].Visible=true
cl[3].From=Vector2.new(R,T); cl[3].To=Vector2.new(R-cw,T); cl[3].Visible=true
cl[4].From=Vector2.new(R,T); cl[4].To=Vector2.new(R,T+ch); cl[4].Visible=true
cl[5].From=Vector2.new(L,B); cl[5].To=Vector2.new(L+cw,B); cl[5].Visible=true
cl[6].From=Vector2.new(L,B); cl[6].To=Vector2.new(L,B-ch); cl[6].Visible=true
cl[7].From=Vector2.new(R,B); cl[7].To=Vector2.new(R-cw,B); cl[7].Visible=true
cl[8].From=Vector2.new(R,B); cl[8].To=Vector2.new(R,B-ch); cl[8].Visible=true
else
for _, l in ipairs(objs.boxLines) do l.Visible = false end
for _, l in ipairs(objs.cornerLines) do l.Visible = false end
end

objs.nameLabel.Text, objs.nameLabel.Position, objs.nameLabel.Visible = p.DisplayName, Vector2.new(cx, T - 16), (Toggles.ESPNames and Toggles.ESPNames.Value)
objs.distLabel.Text, objs.distLabel.Position, objs.distLabel.Visible = dist .. "m", Vector2.new(cx, B + 3), (Toggles.ESPDistance and Toggles.ESPDistance.Value)

if Toggles.ESPHealth and Toggles.ESPHealth.Value then
local barX = L - 5
objs.healthBg.From, objs.healthBg.To, objs.healthBg.Visible = Vector2.new(barX, T), Vector2.new(barX, B), true
objs.healthBar.From, objs.healthBar.To, objs.healthBar.Color, objs.healthBar.Visible = Vector2.new(barX, B - (B - T) * hpRatio), Vector2.new(barX, B), hpColor, true
else
objs.healthBg.Visible, objs.healthBar.Visible = false, false
end

if Toggles.ESPTracers and Toggles.ESPTracers.Value then
local centerScreen, _, _ = worldToViewport(hrp.Position)
objs.tracer.From, objs.tracer.To, objs.tracer.Visible = tracerOrigin, centerScreen, true
else
objs.tracer.Visible = false
end
end
end

Players.PlayerRemoving:Connect(removeESPForPlayer)
for _, p in ipairs(Players:GetPlayers()) do if p ~= LocalPlayer then createESPForPlayer(p) end end
Players.PlayerAdded:Connect(function(p) task.wait(1); createESPForPlayer(p) end)

-- === AIMBOT ===
local fovCircle = Drawing.new("Circle")
fovCircle.Visible, fovCircle.Color, fovCircle.Thickness, fovCircle.NumSides, fovCircle.Filled, fovCircle.Transparency = false, Color3.fromRGB(255, 105, 180), 2, 64, false, 1

local AIMBOT_FOV = 200
local aimbotHue = 0
local function getBestAimTarget(fov)
	fov = fov or AIMBOT_FOV
	local mPos, myHRP, best, bestDist = UserInputService:GetMouseLocation(), getHRP(), nil, math.huge
for _, p in ipairs(Players:GetPlayers()) do
if p == LocalPlayer or not isEnemy(p) then continue end
local char = p.Character; if not char then continue end
local hum = char:FindFirstChildOfClass("Humanoid")
if not hum or hum.Health <= 0 then continue end
local aimPart = (Toggles.AimbotHead and Toggles.AimbotHead.Value and char:FindFirstChild("Head")) or char:FindFirstChild("HumanoidRootPart")
if not aimPart or (myHRP and not hasLOS(myHRP.Position, aimPart.Position)) then continue end
local vPos, onScreen = Camera:WorldToViewportPoint(aimPart.Position)
if not onScreen or vPos.Z <= 0 then continue end
local d = (Vector2.new(vPos.X, vPos.Y) - mPos).Magnitude
if d < fov and d < bestDist then best, bestDist = aimPart, d end
end
return best
end

local aimbotConn
local function enableAimbot()
if aimbotConn then return end
aimbotConn = RunService.RenderStepped:Connect(function(dt)
		aimbotHue = (aimbotHue + dt * 0.4) % 1
		local fov = Options.AimbotFOV and Options.AimbotFOV.Value or AIMBOT_FOV
		fovCircle.Position, fovCircle.Radius, fovCircle.Color, fovCircle.Visible = UserInputService:GetMouseLocation(), fov, Color3.fromHSV(aimbotHue, 0.6, 1), (Toggles.Aimbot and Toggles.Aimbot.Value)
		if not (Toggles.Aimbot and Toggles.Aimbot.Value) then return end
		local target = getBestAimTarget(fov)
		if not target then return end
		local goalCF = CFrame.lookAt(Camera.CFrame.Position, target.Position)
		if Toggles.AimbotSmooth and Toggles.AimbotSmooth.Value then
			local sm = Options.AimbotSmoothFactor and Options.AimbotSmoothFactor.Value or 85
			Camera.CFrame = Camera.CFrame:Lerp(goalCF, sm / 100)
		else
			Camera.CFrame = goalCF
		end
end)
end
local function disableAimbot()
if aimbotConn then aimbotConn:Disconnect(); aimbotConn = nil end
fovCircle.Visible = false
end

-- === KILL AURA ===
local killAuraConn, killAuraCooldown = nil, {}
local KILLAURA_R = 15
local function enableKillAura()
if killAuraConn then return end
killAuraConn = RunService.Heartbeat:Connect(function()
if not (Toggles.KillAura and Toggles.KillAura.Value) then return end
local char = getChar(); local hrp = getHRP(); local tool = char and char:FindFirstChildOfClass("Tool")
if not hrp then return end
for _, p in ipairs(Players:GetPlayers()) do
if not isEnemy(p) then continue end
local eChar = p.Character; local eHRP = eChar and eChar:FindFirstChild("HumanoidRootPart")
local eHum = eChar and eChar:FindFirstChildOfClass("Humanoid")
if not eHRP or not eHum or eHum.Health <= 0 or (hrp.Position - eHRP.Position).Magnitude > KILLAURA_R then continue end
local now = tick(); if killAuraCooldown[p] and (now - killAuraCooldown[p]) < 0.12 then continue end
killAuraCooldown[p] = now
local prevCT, prevCF = Camera.CameraType, Camera.CFrame
Camera.CameraType, Camera.CFrame = Enum.CameraType.Scriptable, CFrame.new(Camera.CFrame.Position, eHRP.Position)
pcall(function() VIM:SendMouseButtonEvent(Mouse.X, Mouse.Y, 0, true, game, 1); VIM:SendMouseButtonEvent(Mouse.X, Mouse.Y, 0, false, game, 1) end)
if tool then
for _, obj in ipairs(tool:GetDescendants()) do
if obj:IsA("RemoteEvent") then pcall(function() obj:FireServer(eHRP, 100) end) end
end
end
task.defer(function() pcall(function() Camera.CameraType, Camera.CFrame = prevCT, prevCF end) end)
end
end)
end
local function disableKillAura() if killAuraConn then killAuraConn:Disconnect(); killAuraConn = nil end; killAuraCooldown = {} end

-- === ANTI-AFK ===
local antiAfkConn
local function enableAntiAfk()
if antiAfkConn then return end
antiAfkConn = task.spawn(function()
while Toggles.AntiAfk and Toggles.AntiAfk.Value do
task.wait(110); if not (Toggles.AntiAfk and Toggles.AntiAfk.Value) then break end
local hum = getHum(); if hum then hum.Jump = true end
pcall(function() game:GetService("VirtualUser"):CaptureController(); game:GetService("VirtualUser"):ClickButton2(Vector2.new()) end)
end
end)
end
local function disableAntiAfk() antiAfkConn = nil end

-- === GOD MODE ===
RunService.Heartbeat:Connect(function()
if not (Toggles.GodMode and Toggles.GodMode.Value) then return end
local hum = getHum(); if hum and hum.Health < hum.MaxHealth then hum.Health = hum.MaxHealth end
end)

-- === UI CREATION (all groupboxes first) ===

-- Combat
local AimbotGroup   = Tabs.Combat:AddLeftGroupbox("Aimbot")
local TriggerGroup  = Tabs.Combat:AddLeftGroupbox("Triggerbot")
local HitboxGroup   = Tabs.Combat:AddRightGroupbox("Hitbox Expander")
local CombatMisc    = Tabs.Combat:AddRightGroupbox("Combat Misc")

AimbotGroup:AddToggle("Aimbot", { Text = "Aimbot", Default = false })
AimbotGroup:AddToggle("AimbotHead", { Text = "Aim at Head", Default = true })
AimbotGroup:AddToggle("AimbotSmooth", { Text = "Smooth Aim", Default = true })
AimbotGroup:AddToggle("TeamCheck", { Text = "Team Check", Default = true })
AimbotGroup:AddSlider("AimbotFOV", { Text = "FOV Size", Default = 200, Min = 50, Max = 500, Rounding = 0 })
AimbotGroup:AddSlider("AimbotSmoothFactor", { Text = "Smooth Strength", Default = 85, Min = 10, Max = 100, Rounding = 0 })

TriggerGroup:AddToggle("Triggerbot", { Text = "Triggerbot", Default = false })

HitboxGroup:AddToggle("HitboxExpander", { Text = "Hitbox Expander", Default = false })
HitboxGroup:AddSlider("HitboxSize", { Text = "Hitbox Size", Default = 10, Min = 4, Max = 50, Rounding = 0 })

CombatMisc:AddToggle("ShootWalls", { Text = "Shoot Through Walls", Default = false })
CombatMisc:AddToggle("KillAura", { Text = "Kill Aura", Default = false })

-- Movement
local FlyGroup      = Tabs.Movement:AddLeftGroupbox("Fly")
local MoveGroup     = Tabs.Movement:AddLeftGroupbox("Movement")

FlyGroup:AddToggle("Fly", { Text = "Fly", Default = false })
FlyGroup:AddLabel("W/A/S/D + Space / Shift")

MoveGroup:AddToggle("SpeedBoost", { Text = "Speed Boost", Default = false })
MoveGroup:AddSlider("SpeedMultiplier", { Text = "Speed Multiplier", Default = 2, Min = 1, Max = 10, Rounding = 1 })
MoveGroup:AddToggle("NoClip", { Text = "No Clip", Default = false })
MoveGroup:AddToggle("InfiniteJump", { Text = "Infinite Jump", Default = false })

-- Visuals
local ESPGroup      = Tabs.Visuals:AddLeftGroupbox("ESP")
local ESPSubGroup   = Tabs.Visuals:AddRightGroupbox("ESP Settings")

ESPGroup:AddToggle("ESP", { Text = "ESP", Default = false })
ESPGroup:AddToggle("ESPTeamCheck", { Text = "Team Check (hide allies)", Default = true })
ESPGroup:AddToggle("ESPNames", { Text = "Show Names", Default = true })
ESPGroup:AddToggle("ESPBoxes", { Text = "Show Boxes", Default = true })
ESPGroup:AddToggle("ESPHealth", { Text = "Show Health Bar", Default = true })
ESPGroup:AddToggle("ESPTracers", { Text = "Show Tracers", Default = true })
ESPGroup:AddToggle("ESPDistance", { Text = "Show Distance", Default = true })

ESPSubGroup:AddToggle("ESPWallCheck", { Text = "Wall Check", Default = false })

-- Utility
local UtilityGroup  = Tabs.Utility:AddLeftGroupbox("Utility")

UtilityGroup:AddToggle("GodMode", { Text = "God Mode", Default = false })
UtilityGroup:AddToggle("AntiAfk", { Text = "Anti-AFK", Default = false })

-- === UI SETTINGS ===
local MenuGroup = Tabs["UI Settings"]:AddLeftGroupbox("UI Settings")
local InfoGroup = Tabs["UI Settings"]:AddRightGroupbox("Credits")

InfoGroup:AddLabel("Umbra Hub v1.0", true)
InfoGroup:AddDivider()
InfoGroup:AddLabel("Arsenal Cheat", true)
InfoGroup:AddDivider()
InfoGroup:AddLabel("Thank you for using Umbra Hub!", true)

-- === EVENT CONNECTIONS ===

Toggles.Fly:OnChanged(function()
if Toggles.Fly.Value then enableFly() else disableFly() end
end)

Toggles.NoClip:OnChanged(function()
if not Toggles.NoClip.Value then
local c = getChar()
if c then for _, p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = true end end end
end
end)

Toggles.SpeedBoost:OnChanged(function()
local h = getHum()
if h and not Toggles.SpeedBoost.Value then h.WalkSpeed = defaultWalkSpeed end
end)

RunService.Heartbeat:Connect(function()
if Toggles.SpeedBoost and Toggles.SpeedBoost.Value then
local h = getHum()
if h then
local mult = Options.SpeedMultiplier and Options.SpeedMultiplier.Value or 2
h.WalkSpeed = defaultWalkSpeed * mult
end
end
end)

UserInputService.JumpRequest:Connect(function()
if Toggles.InfiniteJump and Toggles.InfiniteJump.Value then
local hum = getHum()
if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
end
end)

Toggles.Aimbot:OnChanged(function()
if Toggles.Aimbot.Value then enableAimbot() else disableAimbot() end
end)

Toggles.Triggerbot:OnChanged(function()
if Toggles.Triggerbot.Value then enableTriggerbot() else disableTriggerbot() end
end)

Toggles.HitboxExpander:OnChanged(function()
if Toggles.HitboxExpander.Value then enableHitbox() else disableHitbox() end
end)

Toggles.ShootWalls:OnChanged(function()
if Toggles.ShootWalls.Value then enableShootWall() else disableShootWall() end
end)

Toggles.KillAura:OnChanged(function()
if Toggles.KillAura.Value then enableKillAura() else disableKillAura() end
end)

Toggles.GodMode:OnChanged(function()
-- handled by heartbeat above
end)

Toggles.AntiAfk:OnChanged(function()
if Toggles.AntiAfk.Value then enableAntiAfk() else disableAntiAfk() end
end)

RunService.RenderStepped:Connect(updateESP)

-- === UNLOAD ===
getgenv().UmbraUnload = function()
disableFly()
disableAimbot()
disableTriggerbot()
disableShootWall()
disableKillAura()
disableHitbox()
for _, objs in pairs(espObjects) do
for _, d in pairs(objs) do
if typeof(d) == "table" then for _, dd in pairs(d) do pcall(function() dd:Remove() end) end
else pcall(function() d:Remove() end) end
end
end
table.clear(espObjects)
fovCircle:Remove()
pcall(function() Library:Unload() end)
getgenv().UmbraUnload = nil
end

-- === SAVE/THEME ===
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({'MenuKeybind'})
ThemeManager:SetFolder("Umbra")
SaveManager:SetFolder("Umbra/Arsenal")
SaveManager:BuildConfigSection(Tabs["UI Settings"])
ThemeManager:ApplyToTab(Tabs["UI Settings"])

SaveManager:LoadAutoloadConfig()

Notify("Umbra Hub Loaded for Arsenal!", 4)

-- === MOBILE TOGGLE ===
do
local mobileGui = Instance.new("ScreenGui")
mobileGui.Name = "UmbraMobileToggle"
mobileGui.ResetOnSpawn = false
mobileGui.IgnoreGuiInset = true
mobileGui.DisplayOrder = 99998
mobileGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local toggleBtn = Instance.new("TextButton")
toggleBtn.Name = "ToggleUI"
toggleBtn.Size = UDim2.new(0, 50, 0, 50)
toggleBtn.Position = UDim2.new(0, 12, 0.5, -25)
toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggleBtn.BackgroundTransparency = 0
toggleBtn.Text = ""
toggleBtn.Image = UmbraLogoAsset
toggleBtn.ImageColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.ScaleType = Enum.ScaleType.Fit
toggleBtn.BorderSizePixel = 0
toggleBtn.AutoButtonColor = true
toggleBtn.ZIndex = 99998
toggleBtn.Parent = mobileGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = toggleBtn

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(150, 150, 150)
stroke.Thickness = 2
stroke.Parent = toggleBtn

local dragging = false
local dragStart = nil
local startPos = nil
local hasDragged = false

toggleBtn.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
dragging = true
hasDragged = false
dragStart = input.Position
startPos = toggleBtn.Position
input.Changed:Connect(function()
if input.UserInputState == Enum.UserInputState.End then
dragging = false
end
end)
end
end)

UserInputService.InputChanged:Connect(function(input)
if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
local delta = input.Position - dragStart
if math.abs(delta.X) > 5 or math.abs(delta.Y) > 5 then
hasDragged = true
end
toggleBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end
end)

toggleBtn.MouseButton1Click:Connect(function()
if hasDragged then return end
pcall(function()
if Library and Library.Toggle then
Library:Toggle()
end
end)
end)
end

return
end

if isRivals then
task.spawn(function()

local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Camera = workspace.CurrentCamera
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- [[ RAGE GUNS HOOK LOGIC WITH RESET FIX ]]
_G.RageSettings = {
	Enabled = false,
	Recoil = 0,
	Spread = 0,
	ProjSpeed = 0,
	Cooldown = 0
}
local OriginalStats = {}
local clientItemModule = require(LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientFighter.ClientItem)
local inputFunc = clientItemModule.Input
local oldRage;
if hookfunction then
	oldRage = hookfunction(inputFunc, function(...)
		local args = {...}
		if type(args[1]) == "table" and args[1].Info then
			local gunName = args[1].Name or "Default"
			if not OriginalStats[gunName] then
				OriginalStats[gunName] = {
					Recoil = args[1].Info.ShootRecoil,
					Spread = args[1].Info.ShootSpread,
					Speed = args[1].Info.ProjectileSpeed,
					CD = args[1].Info.ShootCooldown,
					QCD = args[1].Info.QuickShotCooldown
				}
			end
			if _G.RageSettings.Enabled then
				args[1].Info.ShootRecoil = _G.RageSettings.Recoil
				args[1].Info.ShootSpread = _G.RageSettings.Spread
				args[1].Info.ProjectileSpeed = _G.RageSettings.ProjSpeed
				args[1].Info.ShootCooldown = _G.RageSettings.Cooldown
				args[1].Info.QuickShotCooldown = _G.RageSettings.Cooldown
			else
				local orig = OriginalStats[gunName]
				args[1].Info.ShootRecoil = orig.Recoil
				args[1].Info.ShootSpread = orig.Spread
				args[1].Info.ProjectileSpeed = orig.Speed
				args[1].Info.ShootCooldown = orig.CD
				args[1].Info.QuickShotCooldown = orig.QCD
			end
		end
		return oldRage(...)
	end)
end

-- [[ SETTINGS & AUTO-SAVE LOGIC ]]
_G.NvSettings = {
	AimEnabled = false, AimBind = "MouseButton2", AimPart = "Head", Hardlock = false,
	SmoothEnabled = false, SmoothValue = 0, ShakeEnabled = false, ShakeValue = 0,
	WallCheck = true, TeamCheck = true, KatanaCheck = true,
	UnlockRivalsActive = false,
	FOVVisible = true, FOVSize = 150,
	Box = false, Corners = false, Health = false, Names = false,
	WeaponESP = false,
	CharmsFill = false, CharmsOutline = false,
	Crosshair = true, CrossSpin = false, CrossSpinSpeed = 5,
	Watermark = true, WMOutline = true,
	Rainbow = false, RainbowSpeed = 2,
	Fly = false, FlySpeed = 50, FlyBind = "F",
	HvHMovement = false,
	JumpEnabled = false, JumpPower = 50, Noclip = false,
	NoArms = false,
	TriggerBot = false, StickEnabled = false, StickBind = "J", StickTarget = nil,
	StickSpin = false, SpinBotSpeed = 10, StickHeight = 0, StickDistance = 5,
	StickLookAt = false,
	MenuBind = "RightShift", CurrentAngle = 0, ShowArrayList = true,
	ShowMobileButton = true,
	StaffDetectorActive = false,
	DeviceSpoofer = false,
	SpoofedDevice = "MouseKeyboard",
	RageGunsEnabled = false
}
local NS = _G.NvSettings
local ConfigFile = "umbrahub.json"
local function SaveSettings()
	local success, encoded = pcall(function() return HttpService:JSONEncode(NS) end)
	if success then writefile(ConfigFile, encoded) end
end
local function LoadSettings()
	if isfile(ConfigFile) then
		local success, decoded = pcall(function() return HttpService:JSONDecode(readfile(ConfigFile)) end)
		if success then for k, v in pairs(decoded) do NS[k] = v end end
	end
end
LoadSettings()

-- [[ NO ARMS LOGIC ]]
local function disableIfArm(obj)
	if NS.NoArms and obj:IsA("BasePart") then
		if obj.Name == "RightArm" or obj.Name == "LeftArm" then
			obj.Transparency = 1
			obj.CanCollide = false
			obj.Anchored = true
		end
	end
end
for _, obj in pairs(workspace:GetDescendants()) do disableIfArm(obj) end
workspace.DescendantAdded:Connect(disableIfArm)

-- [[ AUTO REDEEM CODES LOGIC ]]
local function RedeemCodes()
	local codes = {"COMMUNITY20", "FREE146", "BONUS", "BOOST", "ROBLOX_RTC", "MERRYMERRYXMAS<3"}
	for _, code in ipairs(codes) do
		pcall(function()
			game:GetService("ReplicatedStorage").Remotes.Data.RedeemCode:InvokeServer(code)
		end)
	end
end

-- [[ CUSTOM BUTTONS CONFIGURATION ]]
local CUSTOM_BUTTON_NAME = "Unlock all rivals"
local function CUSTOM_SCRIPT_LOGIC()
	NS.UnlockRivalsActive = not NS.UnlockRivalsActive
	if NS.UnlockRivalsActive then
		loadstring(game:HttpGet("https://pastefy.app/EBhPhzTz/raw"))()
	end
	SaveSettings()
end
local CUSTOM_BUTTON_2_NAME = "Staff Detector"
local function CUSTOM_SCRIPT_2_LOGIC()
	NS.StaffDetectorActive = not NS.StaffDetectorActive
	if NS.StaffDetectorActive then
		loadstring(game:HttpGet("https://pastefy.app/IgRHJvgY/raw"))()
	end
	SaveSettings()
end
if NS.StaffDetectorActive then
	task.spawn(function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/Itsnvfr/NvHub/refs/heads/main/ng %20staff %20detector"))()
	end)
end
if NS.UnlockRivalsActive then
	task.spawn(function()
		loadstring(game:HttpGet("https://pastefy.app/EBhPhzTz/raw"))()
	end)
end

-- [[ DEVICE SPOOFER LOGIC ]]
local function ApplyDeviceSpoof(deviceName)
	NS.SpoofedDevice = deviceName
	SaveSettings()
	pcall(function()
		local ControlRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Replication"):WaitForChild("Fighter"):WaitForChild("SetControls")
		ControlRemote:FireServer(deviceName)
	end)
end

-- Colors
local ESP_COLOR = Color3.fromRGB(255, 105, 180)
local Accent = Color3.fromRGB(255, 105, 180)
local TrueDark = Color3.fromRGB(10, 10, 10)
local FontStyle = Enum.Font.Arcade

-- [[ CURSOR & TRAIL LOGIC ]]
local CustomCursor = Drawing.new("Square")
CustomCursor.Size = Vector2.new(6, 6)
CustomCursor.Color = Accent
CustomCursor.Filled = true
CustomCursor.Thickness = 1
CustomCursor.Visible = false
local CursorOutline = Drawing.new("Square")
CursorOutline.Size = Vector2.new(8, 8)
CursorOutline.Color = Color3.new(0, 0, 0)
CursorOutline.Filled = false
CursorOutline.Thickness = 1
CursorOutline.Visible = false
local CursorTrail = Drawing.new("Text")
CursorTrail.Text = "Umbra Hub"
CursorTrail.Color = Color3.new(1, 1, 1)
CursorTrail.Size = 14
CursorTrail.Font = 2
CursorTrail.Outline = true
CursorTrail.Visible = false
local trailPos = UIS:GetMouseLocation()

local function UpdateArrayList() end

-- [[ BLUR LOGIC ]]
local MenuBlur = Instance.new("BlurEffect", Lighting)
MenuBlur.Size = 0
MenuBlur.Enabled = true

-- [[ DRAWING OBJECTS ]]
local FOVCircle = Drawing.new("Circle")
local CrossLines = {T = Drawing.new("Line"), B = Drawing.new("Line"), L = Drawing.new("Line"), R = Drawing.new("Line")}

-- [[ LINORIA UI ]]
if getgenv().ScriptLibrary ~= "Linoria" and getgenv().ScriptLibrary ~= "Obsidian" then
	getgenv().ScriptLibrary = "Linoria"
end
local repo = getgenv().ScriptLibrary == "Obsidian"
	and 'https://raw.githubusercontent.com/mstudio45/Obsidian/main/'
	or 'https://raw.githubusercontent.com/mstudio45/LinoriaLib/main/'
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
local Options = Library.Options
local Toggles = Library.Toggles
local Window = Library:CreateWindow({
	Title = "Umbra Hub - Rivals",
	Center = true,
	AutoShow = false,
	ToggleKeybind = nil,
	NotifySide = "Right",
	ShowCustomCursor = false,
})
local MenuOpen = false
local function ToggleMenu()
	MenuOpen = not MenuOpen
	Library:Toggle()
	MenuBlur.Size = MenuOpen and 20 or 0
	if MenuOpen then
		Library.ShowCustomCursor = false
	end
end

-- [[ MOBILE TOGGLE BUTTON ]]
local mobileGui = Instance.new("ScreenGui")
mobileGui.Name = "UmbraMobileToggle"
mobileGui.ResetOnSpawn = false
mobileGui.IgnoreGuiInset = true
mobileGui.DisplayOrder = 99998
mobileGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
local MobBtn = Instance.new("TextButton")
MobBtn.Name = "MobileToggle"
MobBtn.Size = UDim2.new(0, 50, 0, 50)
MobBtn.Position = UDim2.new(0, 12, 0.5, -25)
MobBtn.BackgroundColor3 = TrueDark
MobBtn.Text = ""
MobBtn.Image = UmbraLogoAsset
MobBtn.ImageColor3 = Accent
MobBtn.ScaleType = Enum.ScaleType.Fit
MobBtn.Visible = NS.ShowMobileButton
MobBtn.Parent = mobileGui
Instance.new("UICorner", MobBtn).CornerRadius = UDim.new(0, 10)
local MobStroke = Instance.new("UIStroke", MobBtn)
MobStroke.Color = Color3.fromRGB(5, 5, 5)
MobStroke.Thickness = 1.5
MobStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
local dragging, dragStart, startPos, hasDragged = false, nil, nil, false
MobBtn.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true; hasDragged = false
		dragStart = input.Position; startPos = MobBtn.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then dragging = false end
		end)
	end
end)
UIS.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - dragStart
		if math.abs(delta.X) > 5 or math.abs(delta.Y) > 5 then hasDragged = true end
		MobBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)
MobBtn.MouseButton1Click:Connect(function()
	if hasDragged then return end
	ToggleMenu()
end)
MobBtn.Visible = NS.ShowMobileButton

-- [[ TABS & GROUPS ]]
local Tabs = {
	Aimbot = Window:AddTab("Aimbot"),
	Visuals = Window:AddTab("Visuals"),
	Movement = Window:AddTab("Movement"),
	Bots = Window:AddTab("Bots"),
	Settings = Window:AddTab("Settings"),
	["UI Settings"] = Window:AddTab("UI Settings"),
}

local AimbotLeft = Tabs.Aimbot:AddLeftGroupbox("Aimbot")
local AimbotRight = Tabs.Aimbot:AddRightGroupbox("Aim Settings")
local VisualLeft = Tabs.Visuals:AddLeftGroupbox("Player ESP")
local VisualRight = Tabs.Visuals:AddRightGroupbox("Visual Misc")
local MoveLeft = Tabs.Movement:AddLeftGroupbox("Movement")
local BotLeft = Tabs.Bots:AddLeftGroupbox("Combat Bots")
local BotRight = Tabs.Bots:AddRightGroupbox("Stick Settings")
local RageRight = Tabs.Bots:AddRightGroupbox("Rage Guns")
local SetLeft = Tabs.Settings:AddLeftGroupbox("Game Settings")
local SetRight = Tabs.Settings:AddRightGroupbox("Device Spoof")
local UILeft = Tabs["UI Settings"]:AddLeftGroupbox("UI Settings")
local CreditRight = Tabs["UI Settings"]:AddRightGroupbox("Credits")

-- [[ AIMBOT TOGGLES ]]
AimbotLeft:AddToggle("R_AimEnabled", {Text = "Aimbot enabled", Default = NS.AimEnabled})
AimbotLeft:AddToggle("R_Hardlock", {Text = "Hardlock", Default = NS.Hardlock})

AimbotLeft:AddLabel("Aim Bind"):AddKeyPicker("R_AimBind", {Text = "Aim bind", Default = NS.AimBind, Mode = "Toggle"})
AimbotRight:AddDropdown("R_AimPart", {Text = "Part", Default = NS.AimPart, Values = {"Head", "HumanoidRootPart", "Closest"}})

AimbotLeft:AddToggle("R_SmoothEnabled", {Text = "Smoothness", Default = NS.SmoothEnabled})
AimbotLeft:AddSlider("R_SmoothValue", {Text = "Smoothness", Default = NS.SmoothValue, Min = 0, Max = 50, Rounding = 0})
AimbotLeft:AddToggle("R_ShakeEnabled", {Text = "Shake", Default = NS.ShakeEnabled})
AimbotLeft:AddSlider("R_ShakeValue", {Text = "Shake power", Default = NS.ShakeValue, Min = 0, Max = 50, Rounding = 0})
AimbotLeft:AddToggle("R_WallCheck", {Text = "Wall check", Default = NS.WallCheck})
AimbotLeft:AddToggle("R_TeamCheck", {Text = "Team check", Default = NS.TeamCheck})
AimbotLeft:AddToggle("R_KatanaCheck", {Text = "Katana check", Default = NS.KatanaCheck})
AimbotRight:AddToggle("R_FOVVisible", {Text = "Show FOV", Default = NS.FOVVisible})
AimbotRight:AddSlider("R_FOVSize", {Text = "FOV size", Default = NS.FOVSize, Min = 10, Max = 500, Rounding = 0})

-- [[ VISUAL TOGGLES ]]
VisualLeft:AddToggle("R_ESP", {Text = "ESP", Default = false})
VisualLeft:AddToggle("R_TeamCheck", {Text = "Team Check (hide allies)", Default = true})
VisualLeft:AddToggle("R_ESPNames", {Text = "Show Names", Default = true})
VisualLeft:AddToggle("R_ESPBoxes", {Text = "Show Boxes", Default = true})
VisualLeft:AddToggle("R_ESPHealth", {Text = "Show Health Bar", Default = true})
VisualLeft:AddToggle("R_ESPTracers", {Text = "Show Tracers", Default = true})
VisualLeft:AddToggle("R_ESPDistance", {Text = "Show Distance", Default = true})
VisualRight:AddToggle("R_ESPWallCheck", {Text = "Wall Check", Default = false})
VisualRight:AddToggle("R_Crosshair", {Text = "Crosshair", Default = NS.Crosshair})
VisualRight:AddToggle("R_CrossSpin", {Text = "Crosshair spin", Default = NS.CrossSpin})
VisualRight:AddSlider("R_CrossSpinSpeed", {Text = "Spin speed", Default = NS.CrossSpinSpeed, Min = 1, Max = 30, Rounding = 0})
VisualRight:AddToggle("R_Rainbow", {Text = "Rainbow mode", Default = NS.Rainbow})
VisualRight:AddSlider("R_RainbowSpeed", {Text = "Rain speed", Default = NS.RainbowSpeed, Min = 1, Max = 10, Rounding = 0})

-- [[ MOVEMENT TOGGLES ]]
MoveLeft:AddToggle("R_Fly", {Text = "Fly enabled", Default = NS.Fly})
MoveLeft:AddSlider("R_FlySpeed", {Text = "Fly speed", Default = NS.FlySpeed, Min = 10, Max = 200, Rounding = 0})
MoveLeft:AddToggle("R_HvHMovement", {Text = "HvH movement", Default = NS.HvHMovement})
MoveLeft:AddToggle("R_JumpEnabled", {Text = "Custom jump", Default = NS.JumpEnabled})
MoveLeft:AddSlider("R_JumpPower", {Text = "Jump power", Default = NS.JumpPower, Min = 10, Max = 200, Rounding = 0})
MoveLeft:AddToggle("R_Noclip", {Text = "Noclip", Default = NS.Noclip})

-- [[ BOT TOGGLES ]]
BotLeft:AddToggle("R_TriggerBot", {Text = "Trigger bot", Default = NS.TriggerBot})
BotLeft:AddToggle("R_StickEnabled", {Text = "Stick to player", Default = NS.StickEnabled})
BotLeft:AddToggle("R_StickSpin", {Text = "Spin around", Default = NS.StickSpin})
BotLeft:AddSlider("R_SpinBotSpeed", {Text = "Spin speed", Default = NS.SpinBotSpeed, Min = 1, Max = 50, Rounding = 0})
BotLeft:AddToggle("R_StickLookAt", {Text = "Look at target", Default = NS.StickLookAt})
BotRight:AddSlider("R_StickDistance", {Text = "Distance", Default = NS.StickDistance, Min = 1, Max = 20, Rounding = 0})
BotRight:AddSlider("R_StickHeight", {Text = "Height", Default = NS.StickHeight, Min = -10, Max = 20, Rounding = 0})
RageRight:AddToggle("R_RageGunsEnabled", {Text = "Enable rage guns", Default = NS.RageGunsEnabled})
RageRight:AddSlider("R_RageRecoil", {Text = "Recoil", Default = 0, Min = 0, Max = 10, Rounding = 1})
RageRight:AddSlider("R_RageSpread", {Text = "Spread", Default = 0, Min = 0, Max = 10, Rounding = 1})
RageRight:AddSlider("R_RageProjSpeed", {Text = "Proj speed", Default = 0, Min = 0, Max = 5000, Rounding = 0})
RageRight:AddSlider("R_RageCD", {Text = "Cooldown", Default = 0, Min = 0, Max = 1, Rounding = 2})

-- [[ SETTINGS TOGGLES ]]
SetLeft:AddToggle("R_NoArms", {Text = "No arms", Default = NS.NoArms})
SetLeft:AddButton("Auto redeem codes", function() RedeemCodes() Library:Notify("Codes redeemed!", 3) end)
SetRight:AddToggle("R_DeviceSpoofer", {Text = "Device spoofer", Default = NS.DeviceSpoofer})
SetRight:AddButton("MouseKeyboard", function() ApplyDeviceSpoof("MouseKeyboard"); Library:Notify("Spoofed to MouseKeyboard", 2) end)
SetRight:AddButton("Gamepad", function() ApplyDeviceSpoof("Gamepad"); Library:Notify("Spoofed to Gamepad", 2) end)
SetRight:AddButton("Touch", function() ApplyDeviceSpoof("Touch"); Library:Notify("Spoofed to Touch", 2) end)
SetRight:AddButton("VR", function() ApplyDeviceSpoof("VR"); Library:Notify("Spoofed to VR", 2) end)
UILeft:AddToggle("R_ShowMobileButton", {Text = "Mobile hide button", Default = NS.ShowMobileButton})
CreditRight:AddLabel("Umbra Hub v1.0", true)
CreditRight:AddDivider()
CreditRight:AddLabel("Rivals Cheat", true)
CreditRight:AddDivider()
CreditRight:AddLabel("Thank you for using Umbra Hub!", true)

-- [[ WIRE TOGGLES TO NS ]]
Toggles.R_AimEnabled:OnChanged(function() NS.AimEnabled = Toggles.R_AimEnabled.Value; UpdateArrayList(); SaveSettings() end)
Toggles.R_Hardlock:OnChanged(function() NS.Hardlock = Toggles.R_Hardlock.Value; UpdateArrayList(); SaveSettings() end)
Toggles.R_SmoothEnabled:OnChanged(function() NS.SmoothEnabled = Toggles.R_SmoothEnabled.Value; SaveSettings() end)
Options.R_SmoothValue:OnChanged(function() NS.SmoothValue = Options.R_SmoothValue.Value; SaveSettings() end)
Toggles.R_ShakeEnabled:OnChanged(function() NS.ShakeEnabled = Toggles.R_ShakeEnabled.Value; SaveSettings() end)
Options.R_ShakeValue:OnChanged(function() NS.ShakeValue = Options.R_ShakeValue.Value; SaveSettings() end)
Toggles.R_WallCheck:OnChanged(function() NS.WallCheck = Toggles.R_WallCheck.Value; SaveSettings() end)
Toggles.R_TeamCheck:OnChanged(function() NS.TeamCheck = Toggles.R_TeamCheck.Value; SaveSettings() end)
Toggles.R_KatanaCheck:OnChanged(function() NS.KatanaCheck = Toggles.R_KatanaCheck.Value; SaveSettings() end)
Toggles.R_FOVVisible:OnChanged(function() NS.FOVVisible = Toggles.R_FOVVisible.Value; SaveSettings() end)
Options.R_FOVSize:OnChanged(function() NS.FOVSize = Options.R_FOVSize.Value; SaveSettings() end)

Options.R_AimBind:OnChanged(function() NS.AimBind = Options.R_AimBind.Value; SaveSettings() end)
Options.R_AimPart:OnChanged(function() NS.AimPart = Options.R_AimPart.Value; SaveSettings() end)

Toggles.R_ESP:OnChanged(function() SaveSettings() end)
Toggles.R_ESPNames:OnChanged(function() SaveSettings() end)
Toggles.R_ESPBoxes:OnChanged(function() SaveSettings() end)
Toggles.R_ESPHealth:OnChanged(function() SaveSettings() end)
Toggles.R_ESPTracers:OnChanged(function() SaveSettings() end)
Toggles.R_ESPDistance:OnChanged(function() SaveSettings() end)
Toggles.R_ESPWallCheck:OnChanged(function() SaveSettings() end)
Toggles.R_Crosshair:OnChanged(function() NS.Crosshair = Toggles.R_Crosshair.Value; SaveSettings() end)
Toggles.R_CrossSpin:OnChanged(function() NS.CrossSpin = Toggles.R_CrossSpin.Value; SaveSettings() end)
Options.R_CrossSpinSpeed:OnChanged(function() NS.CrossSpinSpeed = Options.R_CrossSpinSpeed.Value; SaveSettings() end)
Toggles.R_Rainbow:OnChanged(function() NS.Rainbow = Toggles.R_Rainbow.Value; SaveSettings() end)
Options.R_RainbowSpeed:OnChanged(function() NS.RainbowSpeed = Options.R_RainbowSpeed.Value; SaveSettings() end)

Toggles.R_Fly:OnChanged(function() NS.Fly = Toggles.R_Fly.Value; UpdateArrayList(); SaveSettings() end)
Options.R_FlySpeed:OnChanged(function() NS.FlySpeed = Options.R_FlySpeed.Value; SaveSettings() end)
Toggles.R_HvHMovement:OnChanged(function() NS.HvHMovement = Toggles.R_HvHMovement.Value; UpdateArrayList(); SaveSettings() end)
Toggles.R_JumpEnabled:OnChanged(function() NS.JumpEnabled = Toggles.R_JumpEnabled.Value; UpdateArrayList(); SaveSettings() end)
Options.R_JumpPower:OnChanged(function() NS.JumpPower = Options.R_JumpPower.Value; SaveSettings() end)
Toggles.R_Noclip:OnChanged(function() NS.Noclip = Toggles.R_Noclip.Value; UpdateArrayList(); SaveSettings() end)

Toggles.R_TriggerBot:OnChanged(function() NS.TriggerBot = Toggles.R_TriggerBot.Value; UpdateArrayList(); SaveSettings() end)
Toggles.R_StickEnabled:OnChanged(function()
	NS.StickEnabled = Toggles.R_StickEnabled.Value
	if NS.StickEnabled then NS.StickTarget = GetStickTarget() end
	UpdateArrayList(); SaveSettings()
end)
Toggles.R_StickSpin:OnChanged(function() NS.StickSpin = Toggles.R_StickSpin.Value; SaveSettings() end)
Options.R_SpinBotSpeed:OnChanged(function() NS.SpinBotSpeed = Options.R_SpinBotSpeed.Value; SaveSettings() end)
Toggles.R_StickLookAt:OnChanged(function() NS.StickLookAt = Toggles.R_StickLookAt.Value; SaveSettings() end)
Options.R_StickDistance:OnChanged(function() NS.StickDistance = Options.R_StickDistance.Value; SaveSettings() end)
Options.R_StickHeight:OnChanged(function() NS.StickHeight = Options.R_StickHeight.Value; SaveSettings() end)
Toggles.R_RageGunsEnabled:OnChanged(function() NS.RageGunsEnabled = Toggles.R_RageGunsEnabled.Value; _G.RageSettings.Enabled = NS.RageGunsEnabled; UpdateArrayList(); SaveSettings() end)
Options.R_RageRecoil:OnChanged(function() _G.RageSettings.Recoil = Options.R_RageRecoil.Value end)
Options.R_RageSpread:OnChanged(function() _G.RageSettings.Spread = Options.R_RageSpread.Value end)
Options.R_RageProjSpeed:OnChanged(function() _G.RageSettings.ProjSpeed = Options.R_RageProjSpeed.Value end)
Options.R_RageCD:OnChanged(function() _G.RageSettings.Cooldown = Options.R_RageCD.Value end)

Toggles.R_NoArms:OnChanged(function() NS.NoArms = Toggles.R_NoArms.Value; UpdateArrayList(); SaveSettings() end)
Toggles.R_DeviceSpoofer:OnChanged(function()
	NS.DeviceSpoofer = Toggles.R_DeviceSpoofer.Value
	if NS.DeviceSpoofer then ApplyDeviceSpoof(NS.SpoofedDevice) end
	UpdateArrayList(); SaveSettings()
end)
Toggles.R_ShowMobileButton:OnChanged(function() NS.ShowMobileButton = Toggles.R_ShowMobileButton.Value; MobBtn.Visible = NS.ShowMobileButton; SaveSettings() end)

-- ThemeManager & SaveManager
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({'MenuKeybind'})
ThemeManager:SetFolder("Umbra")
SaveManager:SetFolder("Umbra/Rivals")
SaveManager:BuildConfigSection(Tabs["UI Settings"])
ThemeManager:ApplyToTab(Tabs["UI Settings"])

-- [[ GAMEPLAY LOGIC — EXACT ORIGINAL FUNCTIONS ]]
local function IsVisible(part, character)
	if not NS.WallCheck then return true end
	local rayParams = RaycastParams.new()
	rayParams.FilterType = Enum.RaycastFilterType.Exclude
	rayParams.FilterDescendantsInstances = {LocalPlayer.Character, Camera}
	local result = workspace:Raycast(Camera.CFrame.Position, (part.Position - Camera.CFrame.Position).Unit * 1000, rayParams)
	return not result or result.Instance:IsDescendantOf(character)
end
local function GetStickTarget()
	local target, closestDist = nil, 9999
	local mousePos = UIS:GetMouseLocation()
	for _, v in pairs(Players:GetPlayers()) do
		if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character.Humanoid.Health > 0 then
			if NS.KatanaCheck and v.Character:FindFirstChild("Katana") then continue end
			local screenPos, onScreen = Camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
			local mag = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
			if mag < closestDist then closestDist = mag;
				target = v.Character.HumanoidRootPart end
		end
	end
	return target
end
local function GetClosestTarget()
	local target, closestDist = nil, NS.FOVSize
	local mousePos = UIS:GetMouseLocation()
	for _, v in pairs(Players:GetPlayers()) do
		if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
			if NS.TeamCheck and v.Team ~= nil and v.Team == LocalPlayer.Team then continue end
			if NS.KatanaCheck and v.Character:FindFirstChild("Katana") then continue end
			local part = nil
			if NS.AimPart == "Closest" then
				local minPartDist = 9999
				for _, child in pairs(v.Character:GetChildren()) do
					if child:IsA("BasePart") then
						local screenPos, onScreen = Camera:WorldToViewportPoint(child.Position)
						if onScreen then
							local mag = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
							if mag < minPartDist then minPartDist = mag;
								part = child end
						end
					end
				end
			else part = v.Character:FindFirstChild(NS.AimPart) end
			if part then
				local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position)
				if onScreen then
					local mag = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
					if mag < closestDist and IsVisible(part, v.Character) then closestDist = mag;
						target = part end
				end
			end
		end
	end
	return target
end
task.spawn(function()
	while true do
		task.wait(0.05)
		if NS.TriggerBot then
			local target = LocalPlayer:GetMouse().Target
			if target and target.Parent:FindFirstChild("Humanoid") then
				local player = Players:GetPlayerFromCharacter(target.Parent)
				if player and player ~= LocalPlayer then
					if not (NS.TeamCheck and player.Team ~= nil and player.Team == LocalPlayer.Team) then
						mouse1click()
					end
				end
			end
		end
	end
end)

-- [[ AIMBOT — ARSENAL STYLE: Camera.CFrame + Smooth Lerp ]]
local aimbotHue = 0

local function hasLOS(origin, target)
	local dir = target - origin
	local rp = RaycastParams.new()
	rp.FilterType = Enum.RaycastFilterType.Exclude
	local ex = {}
	for _, p in ipairs(Players:GetPlayers()) do
		if p.Character then table.insert(ex, p.Character) end
	end
	rp.FilterDescendantsInstances = ex
	return workspace:Raycast(origin, dir.Unit * dir.Magnitude, rp) == nil
end

local function getBestAimTarget(fov)
	fov = fov or NS.FOVSize
	local mPos = UIS:GetMouseLocation()
	local myHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	local best, bestDist = nil, math.huge
	for _, v in pairs(Players:GetPlayers()) do
		if v == LocalPlayer then continue end
		if NS.TeamCheck and v.Team and v.Team == LocalPlayer.Team then continue end
		local char = v.Character
		if not char then continue end
		local hum = char:FindFirstChildOfClass("Humanoid")
		if not hum or hum.Health <= 0 then continue end
		if NS.KatanaCheck and char:FindFirstChild("Katana") then continue end
		local aimPart = nil
		if NS.AimPart == "Closest" then
			local minPartDist = math.huge
			for _, child in pairs(char:GetChildren()) do
				if child:IsA("BasePart") then
					local vPos, onScreen = Camera:WorldToViewportPoint(child.Position)
					if onScreen then
						local d = (Vector2.new(vPos.X, vPos.Y) - mPos).Magnitude
						if d < minPartDist then minPartDist = d; aimPart = child end
					end
				end
			end
		else
			aimPart = char:FindFirstChild(NS.AimPart)
		end
		if not aimPart then continue end
		if myHRP and NS.WallCheck and not hasLOS(myHRP.Position, aimPart.Position) then continue end
		local vPos, onScreen = Camera:WorldToViewportPoint(aimPart.Position)
		if not onScreen or vPos.Z <= 0 then continue end
		local d = (Vector2.new(vPos.X, vPos.Y) - mPos).Magnitude
		if d < fov and d < bestDist then best, bestDist = aimPart, d end
	end
	return best
end

RunService.RenderStepped:Connect(function()
	Camera = workspace.CurrentCamera
	local mouse = UIS:GetMouseLocation()
	local mid = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
	aimbotHue = (aimbotHue + 0.003) % 1
	local fovColor = Color3.fromHSV(aimbotHue, 0.6, 1)
	local col = NS.Rainbow and Color3.fromHSV(tick() * (NS.RainbowSpeed / 10) % 1, 1, 1) or ESP_COLOR

	CustomCursor.Visible = MenuOpen
	CursorOutline.Visible = MenuOpen
	CursorTrail.Visible = MenuOpen
	if MenuOpen then
		UIS.MouseIconEnabled = false
		CustomCursor.Position = mouse - Vector2.new(3, 3)
		CursorOutline.Position = mouse - Vector2.new(4, 4)
		trailPos = trailPos:Lerp(mouse, 0.15)
		CursorTrail.Position = trailPos + Vector2.new(12, 12)
	else
		UIS.MouseIconEnabled = true
	end

	FOVCircle.Visible = NS.FOVVisible
	FOVCircle.Position = mouse
	FOVCircle.Radius = NS.FOVSize
	FOVCircle.Color = fovColor

	if NS.CrossSpin then NS.CurrentAngle = (NS.CurrentAngle + NS.CrossSpinSpeed) % 360 end
	for i, v in pairs(CrossLines) do
		local angle = math.rad((NS.CurrentAngle + (i == "T" and 0 or i == "B" and 180 or i == "L" and 90 or 270)))
		v.Visible = NS.Crosshair
		v.Color = col
		v.From = mid + (Vector2.new(math.cos(angle), math.sin(angle)) * 5)
		v.To = mid + (Vector2.new(math.cos(angle), math.sin(angle)) * 15)
	end

	-- Arsenal-style aimbot: Camera.CFrame direct
	if NS.AimEnabled then
		local target = getBestAimTarget()
		if target then
			local goalCF = CFrame.lookAt(Camera.CFrame.Position, target.Position)
			if NS.Hardlock then
				Camera.CFrame = goalCF
			else
				local sm = NS.SmoothEnabled and NS.SmoothValue or 0
				if sm <= 1 then
					Camera.CFrame = goalCF
				else
					Camera.CFrame = Camera.CFrame:Lerp(goalCF, math.clamp(sm / 50, 0.05, 0.95))
				end
			end
		end
	end

	-- Stick look-at (keep mousemoverel for this since it's orbit-based)
	if NS.StickEnabled and NS.StickLookAt and NS.StickTarget then
		local head = NS.StickTarget.Parent and NS.StickTarget.Parent:FindFirstChild("Head")
		if head then
			local tPos = Camera:WorldToViewportPoint(head.Position)
			mousemoverel(tPos.X - mouse.X, tPos.Y - mouse.Y)
		end
	end

	-- ESP update
	updateESP()
end)

RunService.Heartbeat:Connect(function()
	if not LocalPlayer.Character then return end
	local Hum = LocalPlayer.Character:FindFirstChild("Humanoid")
	local Root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if Hum and NS.JumpEnabled then Hum.UseJumpPower = true;
		Hum.JumpPower = NS.JumpPower end
	if NS.HvHMovement and Root then
		local actualVelocity = Root.Velocity
		Root.Velocity = actualVelocity + Vector3.new(math.random(-250, 250), math.random(-5, 5), math.random(-250, 250))
		RunService.RenderStepped:Wait()
		Root.Velocity = actualVelocity
		Root.CFrame = Root.CFrame * CFrame.Angles(0, math.rad(math.random(-5, 5)), 0)
	end
	if NS.Fly and Root then
		local vel = Vector3.new(0,0,0)
		if UIS:IsKeyDown(Enum.KeyCode.W) then vel = vel + (Camera.CFrame.LookVector * NS.FlySpeed) end
		if UIS:IsKeyDown(Enum.KeyCode.S) then vel = vel - (Camera.CFrame.LookVector * NS.FlySpeed) end
		if UIS:IsKeyDown(Enum.KeyCode.A) then vel = vel - (Camera.CFrame.RightVector * NS.FlySpeed) end
		if UIS:IsKeyDown(Enum.KeyCode.D) then vel = vel + (Camera.CFrame.RightVector * NS.FlySpeed) end
		if UIS:IsKeyDown(Enum.KeyCode.Space) then vel = vel + (Vector3.new(0, 1, 0) * NS.FlySpeed) end
		Root.Velocity = Vector3.new(0,0,0);
		Root.CFrame = Root.CFrame + (vel * RunService.Heartbeat:Wait())
	end
	if NS.StickEnabled and Root then
		if not NS.StickTarget or not NS.StickTarget.Parent or NS.StickTarget.Parent.Humanoid.Health <= 0 then NS.StickTarget = GetStickTarget() end
		if NS.StickTarget then
			local angle = NS.StickSpin and tick() * NS.SpinBotSpeed or 0
			local offset = Vector3.new(math.cos(angle) * NS.StickDistance, NS.StickHeight, math.sin(angle) * NS.StickDistance)
			Root.CFrame = CFrame.new(NS.StickTarget.Position + offset, NS.StickTarget.Position)
			Root.Velocity = Vector3.new(0,0,0)
		end
	else NS.StickTarget = nil end
	if NS.Noclip then for _,v in pairs(LocalPlayer.Character:GetChildren()) do if v:IsA("BasePart") then v.CanCollide = false end end end
end)

UIS.InputBegan:Connect(function(i,g)
	if not g then
		if i.KeyCode.Name == NS.FlyBind then NS.Fly = not NS.Fly;
			Toggles.R_Fly:SetValue(NS.Fly); UpdateArrayList() end
		if i.KeyCode.Name == "J" then
			NS.StickEnabled = not NS.StickEnabled
			if NS.StickEnabled then NS.StickTarget = GetStickTarget() end
			Toggles.R_StickEnabled:SetValue(NS.StickEnabled); UpdateArrayList()
		end
		if i.KeyCode.Name == NS.MenuBind then ToggleMenu() end
	end
end)

-- [[ ESP — ARSENAL 1:1 PASTE ]]
local espObjects = {}
local ESP_COLOR = Color3.fromRGB(255, 105, 180)
local TRACER_COLOR = Color3.fromRGB(255, 105, 180)

local function newDrawing(type_, props)
	local d = Drawing.new(type_)
	for k, v in pairs(props) do d[k] = v end
	return d
end

local function removeESPForPlayer(p)
	local objs = espObjects[p]
	if not objs then return end
	for _, d in pairs(objs) do
		if typeof(d) == "table" then
			for _, dd in pairs(d) do pcall(function() dd:Remove() end) end
		else pcall(function() d:Remove() end) end
	end
	espObjects[p] = nil
end

local function worldToViewport(pos)
	local vp, onScreen = Camera:WorldToViewportPoint(pos)
	return Vector2.new(vp.X, vp.Y), onScreen, vp.Z
end

local function hasLOSRival(origin, target)
	local dir = target - origin
	local rp = RaycastParams.new()
	rp.FilterType = Enum.RaycastFilterType.Exclude
	local ex = {}
	for _, p in ipairs(Players:GetPlayers()) do
		if p.Character then table.insert(ex, p.Character) end
	end
	rp.FilterDescendantsInstances = ex
	return workspace:Raycast(origin, dir.Unit * dir.Magnitude, rp) == nil
end

local function createESPForPlayer(p)
	if p == LocalPlayer then return end
	removeESPForPlayer(p)
	local objs = {}
	objs.boxLines = {}
	for i = 1, 4 do objs.boxLines[i] = newDrawing("Line", {Visible=false, Color=ESP_COLOR, Thickness=1.5, Transparency=1, ZIndex=5}) end
	objs.cornerLines = {}
	for i = 1, 8 do objs.cornerLines[i] = newDrawing("Line", {Visible=false, Color=Color3.fromRGB(255,255,255), Thickness=2, Transparency=1, ZIndex=6}) end
	objs.nameLabel = newDrawing("Text", {Visible=false, Color=Color3.fromRGB(255,255,255), Size=13, Font=Drawing.Fonts.UI, Outline=true, OutlineColor=Color3.fromRGB(0,0,0), Center=true, ZIndex=7})
	objs.distLabel = newDrawing("Text", {Visible=false, Color=Color3.fromRGB(255,192,203), Size=11, Font=Drawing.Fonts.UI, Outline=true, OutlineColor=Color3.fromRGB(0,0,0), Center=true, ZIndex=7})
	objs.healthBg = newDrawing("Line", {Visible=false, Color=Color3.fromRGB(0,0,0), Thickness=4, Transparency=1, ZIndex=4})
	objs.healthBar = newDrawing("Line", {Visible=false, Color=Color3.fromRGB(255,20,147), Thickness=3, Transparency=1, ZIndex=5})
	objs.tracer = newDrawing("Line", {Visible=false, Color=TRACER_COLOR, Thickness=1, Transparency=0.7, ZIndex=3})
	espObjects[p] = objs
end

local function updateESP()
	if not (Toggles.R_ESP and Toggles.R_ESP.Value) then
		for _, objs in pairs(espObjects) do
			for _, v in pairs(objs) do
				if typeof(v) == "table" then for _, d in pairs(v) do pcall(function() d.Visible = false end) end
				else pcall(function() v.Visible = false end) end
			end
		end
		return
	end

	local vp = Camera.ViewportSize
	local tracerOrigin = Vector2.new(vp.X / 2, vp.Y)

	for _, p in ipairs(Players:GetPlayers()) do
		if p == LocalPlayer then continue end
		if Toggles.R_TeamCheck and Toggles.R_TeamCheck.Value and p.Team and p.Team == LocalPlayer.Team then
			if espObjects[p] then
				for _, v in pairs(espObjects[p]) do
					if typeof(v) == "table" then for _, d in pairs(v) do pcall(function() d.Visible = false end) end
					else pcall(function() v.Visible = false end) end
				end
			end
			continue
		end
		if not espObjects[p] then createESPForPlayer(p) end

		local objs = espObjects[p]
		local char = p.Character
		local hrp  = char and char:FindFirstChild("HumanoidRootPart")
		local hum  = char and char:FindFirstChildOfClass("Humanoid")

		if not hrp or not hum or hum.Health <= 0 then
			for _, v in pairs(objs) do
				if typeof(v) == "table" then for _, d in pairs(v) do pcall(function() d.Visible = false end) end
				else pcall(function() v.Visible = false end) end
			end
			continue
		end

		local myHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		if Toggles.R_ESPWallCheck and Toggles.R_ESPWallCheck.Value and myHRP and not hasLOSRival(myHRP.Position, hrp.Position) then
			for _, v in pairs(objs) do
				if typeof(v) == "table" then for _, d in pairs(v) do pcall(function() d.Visible = false end) end
				else pcall(function() v.Visible = false end) end
			end
			continue
		end

		local head = char:FindFirstChild("Head")
		local headPos = head and head.Position or (hrp.Position + Vector3.new(0, 2.5, 0))
		local feetPos = hrp.Position - Vector3.new(0, 2.8, 0)
		local topScreen, topOn, topZ = worldToViewport(headPos + Vector3.new(0, 0.4, 0))
		local bottomScreen, bottomOn, _ = worldToViewport(feetPos)

		if not (topOn or bottomOn) or topZ < 0 then
			for _, v in pairs(objs) do
				if typeof(v) == "table" then for _, d in pairs(v) do pcall(function() d.Visible = false end) end
				else pcall(function() v.Visible = false end) end
			end
			continue
		end

		local height = math.abs(topScreen.Y - bottomScreen.Y)
		local width  = height * 0.5
		local cx     = topScreen.X
		local L, R, T, B = cx - width / 2, cx + width / 2, topScreen.Y, bottomScreen.Y
		local col = NS.Rainbow and Color3.fromHSV(tick() * (NS.RainbowSpeed / 10) % 1, 1, 1) or ESP_COLOR
		local dist = myHRP and math.floor((myHRP.Position - hrp.Position).Magnitude) or 0
		local hpRatio = hum.MaxHealth > 0 and math.clamp(hum.Health / hum.MaxHealth, 0, 1) or 0
		local hpColor = Color3.fromRGB(255, math.floor(20 + (100 * hpRatio)), math.floor(100 + (80 * hpRatio)))

		if Toggles.R_ESPBoxes and Toggles.R_ESPBoxes.Value then
			local bl = objs.boxLines
			bl[1].From = Vector2.new(L, T); bl[1].To = Vector2.new(R, T); bl[1].Visible = true; bl[1].Color = col
			bl[2].From = Vector2.new(L, B); bl[2].To = Vector2.new(R, B); bl[2].Visible = true; bl[2].Color = col
			bl[3].From = Vector2.new(L, T); bl[3].To = Vector2.new(L, B); bl[3].Visible = true; bl[3].Color = col
			bl[4].From = Vector2.new(R, T); bl[4].To = Vector2.new(R, B); bl[4].Visible = true; bl[4].Color = col
			local cw, ch, cl = width * 0.28, height * 0.18, objs.cornerLines
			cl[1].From=Vector2.new(L,T); cl[1].To=Vector2.new(L+cw,T); cl[1].Visible=true; cl[1].Color=col
			cl[2].From=Vector2.new(L,T); cl[2].To=Vector2.new(L,T+ch); cl[2].Visible=true; cl[2].Color=col
			cl[3].From=Vector2.new(R,T); cl[3].To=Vector2.new(R-cw,T); cl[3].Visible=true; cl[3].Color=col
			cl[4].From=Vector2.new(R,T); cl[4].To=Vector2.new(R,T+ch); cl[4].Visible=true; cl[4].Color=col
			cl[5].From=Vector2.new(L,B); cl[5].To=Vector2.new(L+cw,B); cl[5].Visible=true; cl[5].Color=col
			cl[6].From=Vector2.new(L,B); cl[6].To=Vector2.new(L,B-ch); cl[6].Visible=true; cl[6].Color=col
			cl[7].From=Vector2.new(R,B); cl[7].To=Vector2.new(R-cw,B); cl[7].Visible=true; cl[7].Color=col
			cl[8].From=Vector2.new(R,B); cl[8].To=Vector2.new(R,B-ch); cl[8].Visible=true; cl[8].Color=col
		else
			for _, l in ipairs(objs.boxLines) do l.Visible = false end
			for _, l in ipairs(objs.cornerLines) do l.Visible = false end
		end

		objs.nameLabel.Text, objs.nameLabel.Position, objs.nameLabel.Visible = p.DisplayName, Vector2.new(cx, T - 16), (Toggles.R_ESPNames and Toggles.R_ESPNames.Value)
		objs.nameLabel.Color = col
		objs.distLabel.Text, objs.distLabel.Position, objs.distLabel.Visible = dist .. "m", Vector2.new(cx, B + 3), (Toggles.R_ESPDistance and Toggles.R_ESPDistance.Value)
		objs.distLabel.Color = Color3.fromRGB(255, 192, 203)

		if Toggles.R_ESPHealth and Toggles.R_ESPHealth.Value then
			local barX = L - 5
			objs.healthBg.From, objs.healthBg.To, objs.healthBg.Visible = Vector2.new(barX, T), Vector2.new(barX, B), true
			objs.healthBar.From, objs.healthBar.To, objs.healthBar.Color, objs.healthBar.Visible = Vector2.new(barX, B - (B - T) * hpRatio), Vector2.new(barX, B), hpColor, true
		else
			objs.healthBg.Visible, objs.healthBar.Visible = false, false
		end

		if Toggles.R_ESPTracers and Toggles.R_ESPTracers.Value then
			local centerScreen, _, _ = worldToViewport(hrp.Position)
			objs.tracer.From, objs.tracer.To, objs.tracer.Visible = tracerOrigin, centerScreen, true
			objs.tracer.Color = col
		else
			objs.tracer.Visible = false
		end
	end
end

Players.PlayerRemoving:Connect(removeESPForPlayer)
for _, p in ipairs(Players:GetPlayers()) do if p ~= LocalPlayer then createESPForPlayer(p) end end
Players.PlayerAdded:Connect(function(p) task.wait(1); createESPForPlayer(p) end)

-- [[ STARTUP ]]
MenuOpen = true
Library:Toggle()
MenuBlur.Size = 20
task.wait(2)
Library:Toggle()
MenuOpen = false
MenuBlur.Size = 0

Library:Notify("Umbra Hub Loaded for Rivals!", 4)
end)
return
end

if isAnimalHospital then

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local MarketplaceService = game:GetService("MarketplaceService")
local GuiService = game:GetService("GuiService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer
local playerGui = LocalPlayer:WaitForChild("PlayerGui", 15)
if not playerGui then return end
local Camera = workspace.CurrentCamera

if getgenv().ScriptLibrary ~= "Linoria" and getgenv().ScriptLibrary ~= "Obsidian" then
getgenv().ScriptLibrary = "Linoria"
end

local repo = getgenv().ScriptLibrary == "Obsidian"
and 'https://raw.githubusercontent.com/mstudio45/Obsidian/main/'
or 'https://raw.githubusercontent.com/mstudio45/LinoriaLib/main/'
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
local LibraryName = "Umbra Hub"
local Options = Library.Options
local Toggles = Library.Toggles
local Connections = {}

local Window = Library:CreateWindow({
Title = LibraryName .. " - Animal Hospital",
Center = true,
ToggleKeybind = Enum.KeyCode.RightControl,
AutoShow = true,
NotifySide = "Right",
ShowCustomCursor = true,
})

local function Notify(txt, duration)
Library:Notify(txt, duration)
end

local Tabs = {
ESP = Window:AddTab('ESP', "eye"),
Player = Window:AddTab('Player', "user"),
Auto = Window:AddTab('Auto', "bot"),
Items = Window:AddTab('Items', "package"),
Teleport = Window:AddTab('Teleport', "map-pin"),
Misc = Window:AddTab('Misc', "settings"),
Settings = Window:AddTab('Settings', "settings"),
}

-- [[ STATE ]]
local state = {
anomaliesESP = false,
patientsESP = false,
itemsESP = false,
playerESP = false,
drawLines = false,
infSanity = false,
thirdPerson = false,
fasterActions = false,
autoMinigames = false,
autoTasks = false,
autoHeal = false,
antiAfk = true,
speed = 16,
}

local highlightCache = {}
local lineCache = {}
local minigameClicked = {}
local minigameQueue = {}
local sanityConns = {}
local helperParts = {}
local dead = false

local function track(conn) table.insert(Connections, conn) return conn end

-- [[ CHARACTER HELPERS ]]
local function getChar() return LocalPlayer.Character end
local function getRoot()
local c = getChar()
return c and c:FindFirstChild("HumanoidRootPart")
end
local function getHumanoid()
local c = getChar()
return c and c:FindFirstChildOfClass("Humanoid")
end

-- [[ ANOMALY DETECTOR ]]
local function isAnomaly(model)
if model:GetAttribute("Always Patient") == true then return false end
if model:GetAttribute("Skinwalker") == true
or model:GetAttribute("SkinwalkerEasy") == true
or model:GetAttribute("PenaltyWhenLettingIn") == true
or model:GetAttribute("HasCameraEffect") == true then
return true
end
local camFx = model:GetAttribute("Camera Effect")
local photoFx = model:GetAttribute("Photo Effect")
if (camFx and camFx ~= "" and camFx ~= "None")
or (photoFx and photoFx ~= "" and photoFx ~= "None") then
return true
end
local originalFace = model:GetAttribute("OriginalFace")
local head = model:FindFirstChild("Head")
local decal = head and head:FindFirstChildOfClass("Decal")
if originalFace and decal then
if tostring(decal.Texture) ~= tostring(originalFace) then
return true
end
end
return false
end

-- [[ ESP HIGHLIGHTS ]]
local function applyHighlight(target, fillColor, espType)
if not target or not target.Parent then return end
if highlightCache[target] then
highlightCache[target].FillColor = fillColor
highlightCache[target]:SetAttribute("ESPType", espType)
return
end
local hl = Instance.new("Highlight")
hl.FillColor = fillColor
hl.FillTransparency = 0.4
hl.OutlineColor = Color3.fromRGB(255, 255, 255)
hl.Adornee = target
hl:SetAttribute("ESPType", espType)
hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
hl.Parent = target
highlightCache[target] = hl
end

local function clearESPByType(espType)
for target, hl in pairs(highlightCache) do
if hl and hl.Parent and hl:GetAttribute("ESPType") == espType then
hl:Destroy()
highlightCache[target] = nil
end
end
end

local function applyObjectHighlight(part, fillColor)
if not part or not part.Parent then return end
local target = (part:IsA("Model") and part) or part.Parent
applyHighlight(target, fillColor, "ObjectItem")
end

-- [[ ESP DRAW LINES ]]
local espLineGui = Instance.new("ScreenGui")
espLineGui.Name = "Umbra_Lines"
espLineGui.ResetOnSpawn = false
espLineGui.IgnoreGuiInset = true
espLineGui.DisplayOrder = 9999
espLineGui.Parent = playerGui

local function addLineFor(target, color)
if not target or not target.Parent then return end
if lineCache[target] then
lineCache[target].Frame.BackgroundColor3 = color
return
end
local frame = Instance.new("Frame")
frame.BorderSizePixel = 0
frame.BackgroundColor3 = color
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Visible = false
frame.Parent = espLineGui
lineCache[target] = { Frame = frame }
end

local function clearAllLines()
for _, entry in pairs(lineCache) do
if entry.Frame then entry.Frame:Destroy() end
end
lineCache = {}
end

local function clearLineFor(target)
if lineCache[target] then
if lineCache[target].Frame then
lineCache[target].Frame:Destroy()
end
lineCache[target] = nil
end
end

track(RunService.RenderStepped:Connect(function()
if dead then return end
if not state.drawLines then
if next(lineCache) then clearAllLines() end
return
end
local vpSize = Camera.ViewportSize
local screenBottom = Vector2.new(vpSize.X / 2, vpSize.Y)
for target, entry in pairs(lineCache) do
if not target or not target.Parent then
clearLineFor(target)
else
local part = nil
if target:IsA("Model") then
part = target:FindFirstChild("HumanoidRootPart")
or target:FindFirstChildWhichIsA("BasePart")
elseif target:IsA("BasePart") then
part = target
end
if part and part.Parent and part:IsDescendantOf(workspace) then
local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position)
if onScreen then
local target2D = Vector2.new(screenPos.X, screenPos.Y)
local delta = target2D - screenBottom
local dist = delta.Magnitude
local angle = math.atan2(delta.Y, delta.X)
entry.Frame.Size = UDim2.new(0, dist, 0, 1.5)
entry.Frame.Position = UDim2.new(0, (screenBottom.X + target2D.X) / 2,
0, (screenBottom.Y + target2D.Y) / 2)
entry.Frame.Rotation = math.deg(angle)
entry.Frame.Visible = true
else
entry.Frame.Visible = false
end
else
entry.Frame.Visible = false
end
end
end
end))

-- [[ ESP SCAN LOOP ]]
task.spawn(function()
while not dead do
task.wait(0.5)
for target, hl in pairs(highlightCache) do
if not target or not target.Parent then
if hl and hl.Parent then hl:Destroy() end
highlightCache[target] = nil
end
end

if not state.anomaliesESP then clearESPByType("Anomaly") end
if not state.patientsESP then clearESPByType("Patient") end
if not state.itemsESP then clearESPByType("ObjectItem") end

local candidates = {}
for _, child in ipairs(workspace:GetChildren()) do
if child:IsA("Model") and child ~= LocalPlayer.Character then
table.insert(candidates, child)
else
local name = string.lower(child.Name)
if string.find(name, "item") or string.find(name, "tool")
or string.find(name, "npc") or string.find(name, "patient") then
for _, desc in ipairs(child:GetDescendants()) do
if desc:IsA("Model") then
table.insert(candidates, desc)
end
end
end
end
end

for _, model in ipairs(candidates) do
if model:IsA("Model") and model:FindFirstChildOfClass("Humanoid") then
if not Players:GetPlayerFromCharacter(model) then
if isAnomaly(model) then
if state.anomaliesESP then
if highlightCache[model]
and highlightCache[model]:GetAttribute("ESPType") == "Patient" then
highlightCache[model]:Destroy()
highlightCache[model] = nil
end
applyHighlight(model, Color3.fromRGB(255, 0, 0), "Anomaly")
if state.drawLines then
addLineFor(model, Color3.fromRGB(255, 0, 0))
end
end
else
if state.patientsESP then
if highlightCache[model]
and highlightCache[model]:GetAttribute("ESPType") == "Anomaly" then
highlightCache[model]:Destroy()
highlightCache[model] = nil
end
applyHighlight(model, Color3.fromRGB(0, 255, 0), "Patient")
if state.drawLines then
addLineFor(model, Color3.fromRGB(0, 255, 0))
end
end
end
end
end
end

if state.itemsESP then
pcall(function()
for _, desc in ipairs(workspace:GetDescendants()) do
if desc:IsA("ProximityPrompt") then
local parent = desc.Parent
if parent then
local hasHumanoid =
(parent:IsA("Model") and parent:FindFirstChildOfClass("Humanoid"))
or (parent:FindFirstChild("Humanoid"))
or (parent.Name == "Head" and parent.Parent
and parent.Parent:FindFirstChild("Humanoid"))
or (parent.Parent and parent.Parent:IsA("Model")
and parent.Parent:FindFirstChildOfClass("Humanoid"))
if not hasHumanoid then
local target = (parent:IsA("Model") or parent:IsA("BasePart"))
and parent or nil
if target then
applyObjectHighlight(target, Color3.fromRGB(255, 255, 0))
if state.drawLines then
addLineFor(target, Color3.fromRGB(255, 255, 0))
end
end
end
end
end
end
end)
end
end
end)

-- [[ PLAYER ESP ]]
local function applyPlayerESP(player)
local char = player.Character
if not char or char == LocalPlayer.Character then return end
if not char:FindFirstChild("UmbraHighlight") then
local hl = Instance.new("Highlight")
hl.Name = "UmbraHighlight"
hl.Adornee = char
hl.FillColor = Color3.fromRGB(0, 255, 255)
hl.FillTransparency = 0.6
hl.OutlineColor = Color3.fromRGB(255, 255, 255)
hl.OutlineTransparency = 0
hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
hl.Parent = char
end
if state.drawLines then
addLineFor(char, Color3.fromRGB(0, 255, 255))
end
end

local function removePlayerESP(player)
local char = player.Character
if char then
local hl = char:FindFirstChild("UmbraHighlight")
if hl then hl:Destroy() end
clearLineFor(char)
end
end

track(RunService.RenderStepped:Connect(function()
if dead or not state.playerESP then return end
for _, p in ipairs(Players:GetPlayers()) do
if p ~= LocalPlayer then applyPlayerESP(p) end
end
end))

-- [[ WALKSPEED ]]
local colaBoostUntil = 0
local COLA_SPEED = 32

task.spawn(function()
while not dead do
task.wait(0.4)
local hum = getHumanoid()
if hum and hum.WalkSpeed ~= 0 then
local target = (os.clock() < colaBoostUntil) and COLA_SPEED or state.speed
if hum.WalkSpeed ~= target then
hum.WalkSpeed = target
end
end
end
end)

-- [[ INF SANITY ]]
local function hookSanityValue(valueObj)
if valueObj:IsA("ValueBase") then
local name = string.lower(valueObj.Name)
if string.find(name, "sanity") or string.find(name, "sanidad")
or string.find(name, "cordura") then
valueObj.Value = 100
if not sanityConns[valueObj] then
sanityConns[valueObj] = valueObj.Changed:Connect(function(newVal)
if state.infSanity and newVal ~= 100 then
valueObj.Value = 100
end
end)
end
end
end
end

task.spawn(function()
while not dead do
task.wait(0.25)
if state.infSanity then
pcall(function()
if LocalPlayer:GetAttribute("Sanity") ~= 100 then
LocalPlayer:SetAttribute("Sanity", 100)
end
if LocalPlayer:GetAttribute("Sanidad") ~= 100 then
LocalPlayer:SetAttribute("Sanidad", 100)
end
local char = getChar()
if char then
if char:GetAttribute("Sanity") ~= 100 then
char:SetAttribute("Sanity", 100)
end
if char:GetAttribute("Sanidad") ~= 100 then
char:SetAttribute("Sanidad", 100)
end
for _, child in ipairs(char:GetChildren()) do
hookSanityValue(child)
end
end
local stats = LocalPlayer:FindFirstChild("leaderstats")
or LocalPlayer:FindFirstChild("Data")
or LocalPlayer:FindFirstChild("Stats")
if stats then
for _, child in ipairs(stats:GetChildren()) do
hookSanityValue(child)
end
end
end)
end
end
end)

-- [[ 3RD PERSON CAMERA ]]
local function applyThirdPerson()
local hum = getHumanoid()
if hum then
hum.CameraOffset = state.thirdPerson
and Vector3.new(0, 3, 12)
or Vector3.new(0, 0, 0)
end
end

-- [[ FASTER ACTIONS ]]
local function applyFasterActions()
pcall(function()
for _, desc in ipairs(workspace:GetDescendants()) do
if desc:IsA("ProximityPrompt") then
desc.HoldDuration = state.fasterActions and 0 or 1
end
end
end)
end

track(workspace.DescendantAdded:Connect(function(inst)
if dead then return end
if state.fasterActions and inst:IsA("ProximityPrompt") then
task.wait(0.1)
pcall(function() inst.HoldDuration = 0 end)
end
end))

-- [[ ANTI AFK ]]
track(LocalPlayer.Idled:Connect(function()
if dead or not state.antiAfk then return end
pcall(function()
VirtualUser:CaptureController()
VirtualUser:ClickButton2(Vector2.new())
end)
end))

-- [[ AUTO MINIGAMES ]]
local minigameLastTrigger = os.clock()

local function clickGuiButton(btn)
if not btn or not btn.Parent then return end
if minigameClicked[btn] then return end
local absPos = btn.AbsolutePosition
local absSize = btn.AbsoluteSize
if absSize.X == 0 or absSize.Y == 0 or (absPos.X == 0 and absPos.Y == 0) then
return
end
minigameClicked[btn] = true
task.spawn(function()
pcall(function()
local inset = GuiService:GetGuiInset()
local x = absPos.X + (absSize.X / 2) + inset.X
local y = absPos.Y + (absSize.Y / 2) + inset.Y
VirtualInputManager:SendMouseMoveEvent(x, y, game)
task.wait(0.04)
VirtualInputManager:SendMouseButtonEvent(x, y, 0, true, game, 0)
task.wait(0.01)
VirtualInputManager:SendMouseButtonEvent(x, y, 0, false, game, 0)
end)
pcall(function()
if firesignal then
firesignal(btn.MouseButton1Click)
firesignal(btn.Activated)
end
end)
end)
task.delay(1.5, function() minigameClicked[btn] = nil end)
end

local function hookColorMinigame()
local rooms = workspace:FindFirstChild("Rooms")
local emergency = rooms and rooms:FindFirstChild("Emergency")
local emergRooms = emergency and emergency:FindFirstChild("Rooms")
local room6 = emergRooms and emergRooms:FindFirstChild("Room6")
local minigame = room6 and room6:FindFirstChild("Minigame")
if minigame and minigame:FindFirstChild("Colors") then
for _, colorBtn in ipairs(minigame.Colors:GetChildren()) do
local button = colorBtn:FindFirstChild("Button")
if button and not button:GetAttribute("UmbraHooked") then
button:SetAttribute("UmbraHooked", true)
button:SetAttribute("UmbraOriginalColor", tostring(button.Color))
track(button:GetPropertyChangedSignal("Color"):Connect(function()
if state.autoMinigames then
local origStr = button:GetAttribute("UmbraOriginalColor")
if origStr and tostring(button.Color) ~= origStr then
if not minigameClicked[button] then
table.insert(minigameQueue, button)
minigameLastTrigger = os.clock()
end
end
end
end))
end
end
end
end

local function isExitButton(btn)
local name = string.lower(btn.Name)
local text = (btn:IsA("TextButton") and string.lower(btn.Text)) or ""
return string.find(name, "close") or string.find(name, "exit")
or string.find(name, "leave") or string.find(name, "salir")
or name == "x" or text == "x" or string.find(text, "salir")
end

local function isDangerButton(btn)
local name = string.lower(btn.Name)
return string.find(name, "danger") or btn:FindFirstChild("Skull")
or btn:FindFirstChild("skull")
end

track(RunService.Heartbeat:Connect(function()
if dead or not state.autoMinigames then return end
local hbUI = playerGui:FindFirstChild("HeartbeatMinigameUI")
if hbUI then
local frame = hbUI:FindFirstChild("Frame")
if frame and frame.Visible then
for _, desc in ipairs(frame:GetDescendants()) do
if desc:IsA("GuiButton") and desc.Visible
and desc.Parent.Name ~= "Folder" then
if not isExitButton(desc) and not isDangerButton(desc) then
clickGuiButton(desc)
end
end
end
end
end
local mg = playerGui:FindFirstChild("Minigame")
if mg then
local frame = mg:FindFirstChild("Frame")
if frame and frame.Visible then
local holder = frame:FindFirstChild("ButtonsHolder")
if holder then
for _, btn in ipairs(holder:GetChildren()) do
if btn:IsA("GuiButton") and btn.Visible then
clickGuiButton(btn)
end
end
end
end
end
end))

task.spawn(function()
while not dead do
if state.autoMinigames and #minigameQueue > 0
and (os.clock() - minigameLastTrigger) > 3 then
for _, btn in ipairs(minigameQueue) do
if btn and btn.Parent then
local cd = btn:FindFirstChild("ClickDetector")
local pp = btn:FindFirstChild("PP")
or btn:FindFirstChildOfClass("ProximityPrompt")
pcall(function()
if cd and fireclickdetector then
fireclickdetector(cd)
elseif pp and fireproximityprompt then
fireproximityprompt(pp)
end
end)
task.wait(0.6)
end
end
minigameQueue = {}
minigameClicked = {}
end
task.wait(0.2)
end
end)

task.spawn(function()
while not dead do
task.wait(0.25)
if state.autoMinigames then
for btn in pairs(minigameClicked) do
if not btn or not btn.Parent or btn.Visible == false
or (btn.Parent and btn.Parent.Name == "Folder") then
minigameClicked[btn] = nil
end
end
end
end
end)

-- [[ AUTO TASKS ]]
local taskStepCFrames = {
[1] = {
Camera = CFrame.new(-104.082085, 5.211154, 0.033473, 0.999763, 0.012997, -0.017454, 0, 0.802057, -0.597106, 0.021762, 0.597248, 0.801867),
Root   = CFrame.new(-104.073357, 3.412531, -0.367461, 0.999763, 0, -0.021764, 0, 1, 0, 0.021764, 0, 0.999763),
},
[2] = {
Camera = CFrame.new(-108.414391, 5.097577, 0.123036, 0.991486, -0.048192, 0.12097, 0, 0.928995, 0.370083, -0.130216, -0.366942, 0.921085),
Root   = CFrame.new(-108.474876, 3.412531, -0.337506, 0.991485, 0, 0.130218, 0, 1, 0, -0.130218, 0, 0.991485),
},
[3] = {
Camera = CFrame.new(-99.982895, 5.015163, 0.411147, 0.706237, 0.145322, -0.6929, 0, 0.978707, 0.205264, 0.707976, -0.144965, 0.69119),
Root   = CFrame.new(-99.636444, 3.412531, 0.065548, 0.706236, 0, -0.707976, 0, 1, 0, 0.707976, 0, 0.706236),
},
[4] = {
Camera = CFrame.new(-99.491142, 5.3251, 1.201594, -0.018005, 0.825005, -0.564838, 0, 0.56493, 0.825139, 0.999838, 0.014857, -0.010172),
Root   = CFrame.new(-99.208725, 3.412531, 1.20668, -0.018005, 0, -0.999838, 0, 1, 0, 0.999838, 0, -0.018005),
},
[5] = {
Camera = CFrame.new(-106.80722, 5.164389, -6.988466, 0.04727, 0.513142, -0.857001, 0, 0.85796, 0.513117, 0.998882, -0.024283, 0.040556),
Root   = CFrame.new(-106.378723, 3.407531, -7.008744, 0.047271, 0, -0.998882, 0, 1, 0, 0.998882, 0, 0.047271),
},
[6] = {
Root = CFrame.new(-99.208725, 3.412531, 1.20668, -0.018005, 0, -0.999838, 0, 1, 0, 0.999838, 0, -0.018005),
},
}

local checkinSubTargets = { "Form", "Camera", "Computer", "PatientBadgeBase", "Printer", "Photo" }

local function doTaskAtPrompt(prompt, stepIndex)
local char = getChar()
local root = char and char:FindFirstChild("HumanoidRootPart")
local hum = char and char:FindFirstChildOfClass("Humanoid")
if not root or not prompt or not hum then return end
root.Anchored = true
local step = taskStepCFrames[stepIndex]
if step then
if step.Camera then Camera.CFrame = step.Camera end
if step.Root then root.CFrame = step.Root end
if stepIndex == 6 and prompt.Parent then
local targetPos = prompt.Parent:GetPivot().Position
root.CFrame = step.Root
Camera.CFrame = CFrame.lookAt(Vector3.new(-99.208725, 5, 1.20668), targetPos)
end
end
task.wait(0.6)
pcall(function()
if fireproximityprompt then fireproximityprompt(prompt) end
end)
task.wait(0.6)
Camera.CameraSubject = hum
root.Anchored = false
end

local function autoTasksLoop()
local cubo1 = Instance.new("Part")
cubo1.Name = "UmbraRef"
cubo1.Size = Vector3.new(2, 2, 2)
cubo1.Position = Vector3.new(-107.448, 7.435, 7.999)
cubo1.Anchored = true
cubo1.Transparency = 1
cubo1.CanCollide = false
cubo1.Parent = workspace
table.insert(helperParts, cubo1)

local npcsFolder = workspace:FindFirstChild("NPCs")
local checkinFolder = workspace:FindFirstChild("Misc")
and workspace.Misc:FindFirstChild("Checkin")

while state.autoTasks and not dead do
if npcsFolder then
local npc = npcsFolder:GetChildren()[1]
if npc and npc:IsA("Model") and npc:FindFirstChildOfClass("Humanoid") then
local isAnom = (npc:GetAttribute("Skinwalker") == true)
or (npc:GetAttribute("SkinwalkerEasy") == true)
or (npc:GetAttribute("PenaltyWhenLettingIn") == true)
or (npc:GetAttribute("HasCameraEffect") == true)
if isAnom then
if checkinFolder then
local shutter = checkinFolder:FindFirstChild("ShutterButton")
local pp = shutter and (shutter:FindFirstChild("PP")
or shutter:FindFirstChildOfClass("ProximityPrompt"))
if pp then
pcall(function()
if fireproximityprompt then fireproximityprompt(pp) end
end)
task.wait(4)
pcall(function()
if fireproximityprompt then fireproximityprompt(pp) end
end)
end
end
else
if checkinFolder then
for idx, name in ipairs(checkinSubTargets) do
if not state.autoTasks or dead then break end
local obj = checkinFolder:FindFirstChild(name)
local pp = obj and (obj:FindFirstChild("PP")
or obj:FindFirstChildOfClass("ProximityPrompt"))
if pp then
doTaskAtPrompt(pp, idx)
task.wait(1.4)
end
end
task.wait(2)
end
end
end
end
end
local char = getChar()
local root = char and char:FindFirstChild("HumanoidRootPart")
if root and cubo1 and cubo1.Parent then
root.Anchored = true
root.CFrame = CFrame.new(cubo1.Position + Vector3.new(0, 3, 0))
task.wait(0.1)
root.Anchored = false
end
task.wait(0.5)
end

if cubo1 and cubo1.Parent then cubo1:Destroy() end

-- [[ AUTO HEAL ]]
local function autoHealLoop()
while state.autoHeal and not dead do
local rooms = workspace:FindFirstChild("Misc")
and workspace.Misc:FindFirstChild("Rooms")
local prompt, roomParent
if rooms then
for _, r in ipairs(rooms:GetChildren()) do
local inner = r:FindFirstChildOfClass("Model")
if inner then
local pp = inner:FindFirstChild("PP")
or inner:FindFirstChildOfClass("ProximityPrompt")
if pp and pp.Enabled then
prompt, roomParent = pp, inner
break
end
end
end
end

if prompt and roomParent then
local root = getRoot()
if root then
root.CFrame = roomParent:GetPivot() * CFrame.new(0, 0, 2)
task.wait(0.3)
pcall(function()
if fireproximityprompt then fireproximityprompt(prompt) end
end)
task.wait(4)

local analyzer = roomParent:FindFirstChild("Analyzer")
or roomParent:FindFirstChild("Processor")
local analyzerPP = analyzer and (analyzer:FindFirstChild("PP")
or analyzer:FindFirstChildOfClass("ProximityPrompt"))
if analyzerPP and analyzerPP.Enabled then
root.CFrame = analyzerPP.Parent:GetPivot() * CFrame.new(0, 0, 2)
task.wait(0.3)
pcall(function()
if fireproximityprompt then fireproximityprompt(analyzerPP) end
end)
task.wait(5)
end

local comp = roomParent:FindFirstChild("Computer")
or roomParent:FindFirstChild("PC")
local compPP = comp and (comp:FindFirstChild("PP")
or comp:FindFirstChildOfClass("ProximityPrompt"))
if compPP and compPP.Enabled then
root.CFrame = compPP.Parent:GetPivot() * CFrame.new(0, 0, 3)
task.wait(0.3)
pcall(function()
if fireproximityprompt then fireproximityprompt(compPP) end
end)
task.wait(1.5)
end

local supplies = workspace:FindFirstChild("Misc")
and workspace.Misc:FindFirstChild("Supplies")
if supplies then
for _, desc in ipairs(supplies:GetDescendants()) do
if desc:IsA("ProximityPrompt") and desc.Enabled then
root.CFrame = desc.Parent:GetPivot() * CFrame.new(0, 0, 3)
task.wait(0.3)
pcall(function()
if fireproximityprompt then fireproximityprompt(desc) end
end)
task.wait(1)
break
end
end
end
end
end
task.wait(1)
end
end

-- [[ RUN FAST COLA ]]
local function findRealCola()
local lowered = function(s) return string.lower(s) end
for _, spot in ipairs({ ReplicatedStorage, workspace, game:GetService("Lighting") }) do
for _, d in ipairs(spot:GetDescendants()) do
if d:IsA("Tool") then
local n = lowered(d.Name)
if string.find(n, "cola") or string.find(n, "run fast")
or string.find(n, "speed boost") then
return d
end
end
end
end
return nil
end

local function craftCola()
local backpack = LocalPlayer:FindFirstChildOfClass("Backpack")
if not backpack then return false end

local tool = Instance.new("Tool")
tool.Name = "Run Fast Cola"
tool.ToolTip = "zoom juice - 30s of purple speed"
tool.RequiresHandle = true

local handle = Instance.new("Part")
handle.Name = "Handle"
handle.Size = Vector3.new(0.8, 1.4, 0.8)
handle.Color = Color3.fromRGB(160, 60, 255)
handle.Parent = tool

local drinking = false
tool.Activated:Connect(function()
if drinking or dead then return end
drinking = true
local char = LocalPlayer.Character
local hum = char and char:FindFirstChildOfClass("Humanoid")
if hum then
colaBoostUntil = os.clock() + 30
local sparkles = Instance.new("Sparkles")
sparkles.SparkleColor = Color3.fromRGB(170, 0, 255)
local torso = char:FindFirstChild("UpperTorso")
or char:FindFirstChild("Torso")
or char:FindFirstChild("HumanoidRootPart")
if torso then sparkles.Parent = torso end
task.delay(30, function()
if sparkles and sparkles.Parent then
pcall(function() sparkles:Destroy() end)
end
end)
end
task.wait(2)
drinking = false
end)

tool.Parent = backpack
return true
end

local function getRunFastCola()
local real = findRealCola()
if real then
local backpack = LocalPlayer:FindFirstChildOfClass("Backpack")
if backpack then
local okClone = pcall(function()
real:Clone().Parent = backpack
end)
if okClone then return true end
end
end
return craftCola()
end

-- [[ GET OBJECT ]]
local busy = false
local function fetchObject(itemName)
if busy then return false end
busy = true

local char = getChar()
local root = char and char:FindFirstChild("HumanoidRootPart")
local hum = char and char:FindFirstChildOfClass("Humanoid")
local head = char and char:FindFirstChild("Head")
if not root or not hum or not head then
busy = false
return false
end

for _, desc in ipairs(workspace:GetDescendants()) do
if desc:IsA("ProximityPrompt") then
if desc.ActionText == itemName or desc.ObjectText == itemName then
local parent = desc.Parent
local basePart = (parent:IsA("BasePart") and parent)
or parent:FindFirstChildWhichIsA("BasePart")
if basePart then
local savedCFrame = root.CFrame
local savedLOS = desc.RequiresLineOfSight
local savedCollide = basePart.CanCollide

desc.RequiresLineOfSight = false
basePart.CanCollide = false
pcall(function() desc.HoldDuration = 0 end)

local targetPos = basePart.Position
local attachment = parent:FindFirstChildOfClass("Attachment")
if attachment then targetPos = attachment.WorldPosition end

local platform = Instance.new("Part")
platform.Size = Vector3.new(5, 1, 5)
platform.Anchored = true
platform.Transparency = 1
platform.CanCollide = true
platform.CFrame = CFrame.new(targetPos + Vector3.new(0, -2, 0))
platform.Parent = workspace

root.CFrame = CFrame.new(targetPos + Vector3.new(0, 0, 2))
task.wait(0.05)
root.Velocity = Vector3.new(0, 0, 0)

task.wait(0.2)
Camera.CFrame = CFrame.lookAt(head.Position, targetPos)
task.wait(0.05)
pcall(function()
if fireproximityprompt then fireproximityprompt(desc) end
end)

task.wait(0.3)
desc.RequiresLineOfSight = savedLOS
basePart.CanCollide = savedCollide
platform:Destroy()

root.CFrame = savedCFrame
root.Velocity = Vector3.new(0, 0, 0)
task.wait(0.05)
Camera.CameraSubject = hum

busy = false
return true
end
end
end
end

busy = false
return false
end

-- [[ DELETE ALL DOORS ]]
local function deleteAllDoors()
pcall(function()
for _, desc in ipairs(workspace:GetDescendants()) do
if desc:IsA("BasePart") or desc:IsA("Model") then
local name = string.lower(desc.Name)
if string.find(name, "door") or string.find(name, "puerta")
or string.find(name, "porton") then
pcall(function() desc:Destroy() end)
end
end
end
end)
Notify("Doors wiped!", 2)
end

-- [[ ROOM TELEPORTS ]]
local roomCFrames = {
["checkzone"]            = CFrame.new(-107.333389, 3.412531, 8.237826, -0.954479, 0, -0.298277, 0, 1, 0, 0.298277, 0, -0.954479),
["entrance"]             = CFrame.new(-78.983574, 3.407531, -12.504811, -0.021113, 0, -0.999777, 0, 1, 0, 0.999777, 0, -0.021113),
["room halfway A (1-5)"] = CFrame.new(-145.037628, 3.457531, -65.147362, -0.996587, 0, 0.08254, 0, 1, 0, -0.082549, 0, -0.996587),
["room 1"]               = CFrame.new(-169.766663, 3.457531, -50.727806, 0.025003, 0, -0.999687, 0, 1, 0, 0.999687, 0, 0.025003),
["room 2"]               = CFrame.new(-123.374763, 3.457531, -51.833504, -0.611116, 0, 0.79154, 0, 1, 0, -0.791541, 0, -0.611116),
["room 3"]               = CFrame.new(-173.209396, 3.457531, -90.922246, 0.008945, 0, -0.99996, 0, 1, 0, 0.99996, 0, 0.008945),
["room 4"]               = CFrame.new(-117.447639, 3.457531, -89.03093, 0.020848, 0, 0.999783, 0, 1, 0, -0.999783, 0, 0.020848),
["room 5"]               = CFrame.new(-145.94075, 3.457531, -113.268204, 0.999244, 0, 0.03886, 0, 1, 0, -0.038867, 0, 0.999244),
["shop"]                 = CFrame.new(-166.514618, 3.45753, -12.773237, 0.012568, 0, 0.999921, 0, 1, 0, -0.999921, 0, 0.012568),
["halfway B (6-8)"]      = CFrame.new(-144.837326, 3.45753, 36.86932, 0.99922, 0, 0.039477, 0, 1, 0, -0.039477, 0, 0.99922),
["room 6"]               = CFrame.new(-171.039078, 3.45753, 52.27216, 0.399193, 0, -0.916867, 0, 1, 0, 0.916867, 0, 0.399193),
["room 7"]               = CFrame.new(-124.463058, 3.45753, 45.395046, -0.985264, 0, -0.171038, 0, 1, 0, 0.171038, 0, -0.985264),
["room 8"]               = CFrame.new(-145.123749, 3.45753, 77.844215, -0.999892, 0, 0.014681, 0, 1, 0, -0.014681, 0, -0.999892),
}

local tpCooldown = false
local function teleportTo(roomName)
if tpCooldown then
Notify("Cooldown! Wait a moment.", 2)
return
end
local cf = roomCFrames[roomName]
local root = getRoot()
if cf and root then
pcall(function()
root.CFrame = cf
end)
tpCooldown = true
Notify("Teleported to " .. roomName, 2)
task.wait(0.5)
tpCooldown = false
else
Notify("Could not teleport!", 2)
end
end

-- [[ KEYBINDS ]]
track(UserInputService.InputBegan:Connect(function(input, processed)
if dead or processed then return end
if input.KeyCode == Enum.KeyCode.H then
state.anomaliesESP = not state.anomaliesESP
if not state.anomaliesESP then clearESPByType("Anomaly") end
elseif input.KeyCode == Enum.KeyCode.J then
state.patientsESP = not state.patientsESP
if not state.patientsESP then clearESPByType("Patient") end
elseif input.KeyCode == Enum.KeyCode.K then
state.itemsESP = not state.itemsESP
if not state.itemsESP then clearESPByType("ObjectItem") end
end
end))

-- ==========================================
-- UI TABS (Linoria)
-- ==========================================

-- [[ ESP TAB ]]
local ESPBox = Tabs.ESP:AddLeftGroupbox('ESP')
Toggles.AnomalyESP = ESPBox:AddToggle("AnomalyESP", {
	Text = "Anomaly ESP",
	Default = false,
	Callback = function(s)
	state.anomaliesESP = s
	if not s then clearESPByType("Anomaly") end
	end,
	})
ESPBox:AddLabel("Anomalies glow RED - skinwalkers & camera effects")

Toggles.PatientESP = ESPBox:AddToggle("PatientESP", {
	Text = "Patient ESP",
	Default = false,
	Callback = function(s)
	state.patientsESP = s
	if not s then clearESPByType("Patient") end
	end,
	})
ESPBox:AddLabel("Normal patients glow GREEN")

Toggles.ItemsESP = ESPBox:AddToggle("ItemsESP", {
	Text = "Items ESP",
	Default = false,
	Callback = function(s)
	state.itemsESP = s
	if not s then clearESPByType("ObjectItem") end
	end,
	})
ESPBox:AddLabel("Grab-able tools & items glow YELLOW")

Toggles.PlayerESP = ESPBox:AddToggle("PlayerESP", {
	Text = "Player ESP",
	Default = false,
	Callback = function(s)
	state.playerESP = s
	if not s then
	for _, p in ipairs(Players:GetPlayers()) do
	removePlayerESP(p)
	end
	end
	end,
	})
ESPBox:AddLabel("Other players glow CYAN")

Toggles.DrawLines = ESPBox:AddToggle("DrawLines", {
	Text = "Draw Lines",
	Default = false,
	Callback = function(s)
	state.drawLines = s
	if not s then clearAllLines() end
	end,
	})
ESPBox:AddLabel("Lines from screen bottom to every ESP target")

-- [[ PLAYER TAB ]]
local PlayerBox = Tabs.Player:AddLeftGroupbox('Player')
Options.WalkSpeed = PlayerBox:AddInput("WalkSpeed", {
	Text = "WalkSpeed",
	Default = "16",
	Placeholder = "e.g. 16 or 40",
	Callback = function(text)
	local n = tonumber(text)
	if n then
	state.speed = n
	Notify("Speed set to " .. n, 2)
	end
	end,
	})

PlayerBox:AddButton({
	Text = "Reset Speed",
	Func = function()
	state.speed = 16
	Options.WalkSpeed:SetValue("16")
	Notify("Speed reset to 16", 2)
	end,
	})

Toggles.FasterActions = PlayerBox:AddToggle("FasterActions", {
	Text = "Faster Actions",
	Default = false,
	Callback = function(s)
	state.fasterActions = s
	applyFasterActions()
	end,
	})
PlayerBox:AddLabel("All hold-to-interact prompts become instant")

Toggles.InfSanity = PlayerBox:AddToggle("InfSanity", {
	Text = "Infinite Sanity",
	Default = false,
	Callback = function(s) state.infSanity = s end,
	})
PlayerBox:AddLabel("Your sanity never drops")

Toggles.ThirdPerson = PlayerBox:AddToggle("ThirdPerson", {
	Text = "3rd Person Camera",
	Default = false,
	Callback = function(s)
	state.thirdPerson = s
	applyThirdPerson()
	end,
	})
PlayerBox:AddLabel("Camera offset behind you")

Toggles.AntiAFK = PlayerBox:AddToggle("AntiAFK", {
	Text = "Anti-AFK",
	Default = true,
	Callback = function(s) state.antiAfk = s end,
	})
PlayerBox:AddLabel("Prevents idle kick")

-- [[ AUTO TAB ]]
local AutoBox = Tabs.Auto:AddLeftGroupbox('Auto')
AutoBox:AddLabel("Beta features - may hiccup")

Toggles.AutoMinigames = AutoBox:AddToggle("AutoMinigames", {
	Text = "Auto Play Minigames",
	Default = false,
	Callback = function(s)
	state.autoMinigames = s
	if s then
	minigameQueue = {}
	minigameClicked = {}
	hookColorMinigame()
	minigameLastTrigger = os.clock()
	end
	end,
	})
AutoBox:AddLabel("Plays color game & heartbeat game automatically")

Toggles.AutoTasks = AutoBox:AddToggle("AutoTasks", {
	Text = "Auto Tasks (Beta)",
	Default = false,
	Callback = function(s)
	state.autoTasks = s
	if s then
	task.spawn(autoTasksLoop)
	else
	local hum = getHumanoid()
	if hum then Camera.CameraSubject = hum end
	end
	end,
	})
AutoBox:AddLabel("Runs the full check-in circuit per patient")

Toggles.AutoHeal = AutoBox:AddToggle("AutoHeal", {
	Text = "Auto Heal (Beta)",
	Default = false,
	Callback = function(s)
	state.autoHeal = s
	if s then
	task.spawn(autoHealLoop)
	end
	end,
	})
AutoBox:AddLabel("Walks the fix-a-patient loop by itself")

-- [[ ITEMS TAB ]]
local ItemsBox = Tabs.Items:AddLeftGroupbox('Items')
ItemsBox:AddButton({
	Text = "Get Run Fast Cola",
	Func = function()
	local got = getRunFastCola()
	if got then
	Notify("Cola secured! Check your backpack", 2)
	else
	Notify("Could not grab cola", 3)
	end
	end,
	})
ItemsBox:AddLabel("Drink for 30s of speed + purple sparkles")

ItemsBox:AddDivider()
ItemsBox:AddLabel("Fetch Object - blink there, grab, blink back")

local itemNames = {
"Herbs", "Eye Drops", "IV Drops", "Medkit", "Thermo",
"Ointment", "Bandages", "Maple Syrup", "Cough Syrup", "Medicine",
}

for _, itemName in ipairs(itemNames) do
	ItemsBox:AddButton({
	Text = itemName,
	Func = function()
	Notify("Grabbing " .. itemName .. "...", 2)
	local got = fetchObject(itemName)
	if got then
	Notify(itemName .. " secured!", 2)
	else
	Notify("Could not find " .. itemName, 3)
	end
	end,
	})
	end

-- [[ TELEPORT TAB ]]
local TeleportBox = Tabs.Teleport:AddLeftGroupbox('Teleport')
TeleportBox:AddLabel("General")
for _, name in ipairs({ "checkzone", "entrance", "shop" }) do
	TeleportBox:AddButton({
	Text = name,
	Func = function() teleportTo(name) end,
	})
	end

	TeleportBox:AddLabel("Patient Rooms")
	for _, name in ipairs({ "room 1", "room 2", "room 3", "room 4",
	"room 5", "room 6", "room 7", "room 8" }) do
	TeleportBox:AddButton({
	Text = name,
	Func = function() teleportTo(name) end,
	})
	end

	TeleportBox:AddLabel("Hallways")
	for _, name in ipairs({ "room halfway A (1-5)", "halfway B (6-8)" }) do
	TeleportBox:AddButton({
	Text = name,
	Func = function() teleportTo(name) end,
	})
	end

-- [[ MISC TAB ]]
local MiscBox = Tabs.Misc:AddLeftGroupbox('Misc')
MiscBox:AddButton({
	Text = "Delete All Doors",
	Func = function() deleteAllDoors() end,
	})
MiscBox:AddLabel("Every door in the hospital, gone")

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetFolder(LibraryName .. "/AnimalHospital")
SaveManager:BuildConfigSection(Tabs.Settings)
ThemeManager:ApplyToTab(Tabs.Settings)

-- [[ STARTUP ]]
Library:Notify("Umbra Hub Loaded for Animal Hospital!", 4)

-- [[ CLEANUP ]]
getgenv().UmbraUnload = function()
dead = true
for k in pairs(state) do
if type(state[k]) == "boolean" then state[k] = false end
end
for _, p in ipairs(helperParts) do
if p and p.Parent then pcall(function() p:Destroy() end) end
end
helperParts = {}
for _, conn in pairs(sanityConns) do
pcall(function() conn:Disconnect() end)
end
sanityConns = {}
clearAllLines()
for target, hl in pairs(highlightCache) do
if hl and hl.Parent then pcall(function() hl:Destroy() end) end
end
highlightCache = {}
for _, p in ipairs(Players:GetPlayers()) do
removePlayerESP(p)
end
for _, c in ipairs(Connections) do
pcall(function() c:Disconnect() end)
end
Connections = {}
pcall(function()
if espLineGui and espLineGui.Parent then espLineGui:Destroy() end
end)
pcall(function() Library:Destroy() end)
end

return
end

-- DOORS SCRIPT BELOW
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local PathfindingService = game:GetService("PathfindingService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local OriginalWalkSpeed = (LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed) or 15
local OriginalLighting = {
Ambient = Lighting.Ambient,
OutdoorAmbient = Lighting.OutdoorAmbient,
Brightness = Lighting.Brightness,
GlobalShadows = Lighting.GlobalShadows,
FogEnd = Lighting.FogEnd,
AtmosphereDensity = nil
}
local currentAtmosphere = Lighting:FindFirstChildOfClass("Atmosphere")
if currentAtmosphere then
OriginalLighting.AtmosphereDensity = currentAtmosphere.Density
end
local ESPLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/TheHunterSolo1/Scripts/main/ESPLibrary"))()
ESPLibrary:SetShowDistance(true)
ESPLibrary:SetTracers(false)
ESPLibrary:SetESPMode("Highlight/Text")
ESPLibrary:SetFont("Legacy")
local RemotesFolder = ReplicatedStorage:FindFirstChild("EntityInfo")
or ReplicatedStorage:FindFirstChild("Bricks")
or ReplicatedStorage:FindFirstChild("RemotesFolder")
or ReplicatedStorage:WaitForChild("RemotesFolder", 5)
local MotorReplication = RemotesFolder:FindFirstChild("MotorReplication")
local ClientModules = ReplicatedStorage:FindFirstChild("ModulesClient") or ReplicatedStorage:FindFirstChild("ClientModules")
local FakeScreech = Instance.new("RemoteEvent", RemotesFolder)
FakeScreech.Name = "Screech_"
local FakeA90 = Instance.new("RemoteEvent", RemotesFolder)
FakeA90.Name = "A90_"
local CollisionClone = nil
local ManipulationNoClipForced = false
local gotToggled = false
local gotToggled2 = false
local Surge = Instance.new("RemoteEvent", ReplicatedStorage)
Surge.Name = "SurgeRemote"
local ExecutorSupport = getgenv().ExecutorSupport or {}
local ReplicateSignal = ExecutorSupport.replicatesignal or replicatesignal
local Firepp = ExecutorSupport.fireproximityprompt or fireproximityprompt
local FireTouch = ExecutorSupport.firetouchinterest or firetouchinterest
if getgenv().ScriptLibrary ~= "Linoria" and getgenv().ScriptLibrary ~= "Obsidian" then
getgenv().ScriptLibrary = "Linoria"
end
local function IsJamminModifierActive()
local liveMod = ReplicatedStorage:FindFirstChild("LiveModifiers")
return liveMod and liveMod:FindFirstChild("Jammin") ~= nil
end
function GetLibraryCode()
local CodeLength = game.ReplicatedStorage.GameData.Floor.Value == "Fools" and 10 or 5
local Slot = table.create(CodeLength, "_")
local Paper
for _, plr in pairs(Players:GetPlayers()) do
local char = plr.Character
if char then
Paper = char:FindFirstChild("LibraryHintPaper") or char:FindFirstChild("LibraryHintPaperHard") or
plr.Backpack:FindFirstChild("LibraryHintPaper") or plr.Backpack:FindFirstChild("LibraryHintPaperHard")
if Paper then break end
end
end
if not Paper then return table.concat(Slot) end
local Hints = LocalPlayer.PlayerGui.PermUI.Hints:GetChildren()
for _, i in pairs(Paper.UI:GetChildren()) do
if i:IsA("ImageLabel") and i.Name ~= "Image" then
local Pos = tonumber(i.Name)
if Pos and Slot[Pos] then
for _, v in pairs(Hints) do
if v.Name == "Icon" and v.ImageRectOffset.X == i.ImageRectOffset.X then
local Label = v:FindFirstChild("TextLabel")
if Label then
Slot[Pos] = Label.Text
end
break
end
end
end
end
end
return table.concat(Slot)
end
local OldFogEnd = nil
local RequiredMainGame = nil
task.spawn(function()
local mainUI = LocalPlayer:WaitForChild("PlayerGui", 5) and LocalPlayer.PlayerGui:WaitForChild("MainUI", 5)
if mainUI then
local mainGame = mainUI:FindFirstChild("Initiator") and mainUI.Initiator:FindFirstChild("Main_Game")
if mainGame then
local req = getgenv().ExecutorSupport and getgenv().ExecutorSupport.require or require
if req then
pcall(function() RequiredMainGame = req(mainGame) end)
end
end
end
end)
function Breaker(part)
local surfaceGui = part:WaitForChild("SurfaceGui", 5)
if not surfaceGui then return end
local frame = surfaceGui:WaitForChild("Frame", 5)
if not frame then return end
local label = frame:WaitForChild("Code", 5)
if not label then return end
local function run()
task.wait(0.05)
if not (Toggles.AutoBreaker and Toggles.AutoBreaker.Value) then return end
local target = tonumber(label.Text)
if target then
for _, v in pairs(part:GetChildren()) do
if v.Name == "BreakerSwitch" and v:GetAttribute("ID") == target then
local codeFrame = label:FindFirstChild("Frame")
if not codeFrame then break end
local trans = codeFrame.BackgroundTransparency
local pc = v:FindFirstChild("PrismaticConstraint")
local light = v:FindFirstChild("Light")
local sound = v:FindFirstChild("Sound")
if trans == 0 then
if v:GetAttribute("Enabled") then return end
v:SetAttribute("Enabled", true)
if pc then pc.TargetPosition = -0.2 end
if light then
light.Material = Enum.Material.Neon
local spark = light:FindFirstChild("Spark", true)
if spark then spark:Emit(1) end
end
if sound then sound:Play() end
elseif trans == 1 then
if not v:GetAttribute("Enabled") then return end
v:SetAttribute("Enabled", false)
if pc then pc.TargetPosition = 0.2 end
if light then light.Material = Enum.Material.Glass end
if sound then sound:Play() end
end
break
end
end
end
end
table.insert(Connections, label:GetPropertyChangedSignal("Text"):Connect(run))
run()
end
local repo = getgenv().ScriptLibrary == "Obsidian"
and 'https://raw.githubusercontent.com/mstudio45/Obsidian/main/'
or 'https://raw.githubusercontent.com/mstudio45/LinoriaLib/main/'
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
local LibraryName = "Umbra's Hub"
local Options = Library.Options
local Toggles = Library.Toggles
local Connections = {}
local Window = Library:CreateWindow({
Title = LibraryName,
Center = true,
ToggleKeybind = Enum.KeyCode.RightControl,
AutoShow = true,
NotifySide = "Right",
ShowCustomCursor = true,
})
local Notifying = "Library"
local PlaySound = true
local function Notify(txt, duration)
if Notifying == "Library" then
Library:Notify(txt, duration)
end
if PlaySound then
local Sound = Instance.new("Sound", game:GetService("SoundService"))
Sound.SoundId = "rbxassetid://101511361468852"
Sound.PlaybackSpeed = 0.77
Sound.Volume = 2
Sound:Play()
game:GetService("Debris"):AddItem(Sound, 3)
end
end
if workspace:FindFirstChild("Lobby") then
getgenv().UmbraUnload = function()
pcall(function() Library:Unload() end)
getgenv().UmbraUnload = nil
end
local Tabs = {
Main = Window:AddTab('Teleports', "star"),
Settings = Window:AddTab('Settings', "settings"),
}
local Tp = Tabs.Main:AddLeftGroupbox("Teleport")
Tp:AddLabel('Main menu appears after teleport', true)
Tp:AddButton("Teleport to Hotel", function()
if RemotesFolder:FindFirstChild("CreateElevator") then
RemotesFolder.CreateElevator:FireServer({
Mods = {"AdminPanel"},
Settings = {},
Destination = "Hotel",
FriendsOnly = false,
MaxPlayers = "1"
})
end
end)
Tp:AddButton("Teleport to Mines", function()
if RemotesFolder:FindFirstChild("CreateElevator") then
RemotesFolder.CreateElevator:FireServer({
Mods = {"AdminPanel"},
Settings = {},
Destination = "Mines",
FriendsOnly = false,
MaxPlayers = "1"
})
end
end)
Tp:AddButton("Teleport to Rooms (FREE)", function()
if RemotesFolder:FindFirstChild("CreateElevator") then
RemotesFolder.CreateElevator:FireServer({
Mods = {"AdminPanel"},
Settings = {},
Destination = "Rooms",
FriendsOnly = false,
MaxPlayers = "1"
})
end
end)
Tp:AddButton("Teleport to Backdoors", function()
if RemotesFolder:FindFirstChild("CreateElevator") then
RemotesFolder.CreateElevator:FireServer({
Mods = {"AdminPanel"},
Settings = {},
Destination = "Backdoor",
FriendsOnly = false,
MaxPlayers = "1"
})
end
end)
Tp:AddButton("Teleport to Outdoors (FREE)", function()
if RemotesFolder:FindFirstChild("CreateElevator") then
RemotesFolder.CreateElevator:FireServer({
Mods = {},
Settings = {},
Destination = "Garden",
FriendsOnly = false,
MaxPlayers = "1"
})
end
end)
Tp:AddButton("Teleport to Retro Mode", function()
if RemotesFolder:FindFirstChild("CreateElevator") then
RemotesFolder.CreateElevator:FireServer({
Mods = {},
Settings = {},
Destination = "Retro",
FriendsOnly = false,
MaxPlayers = "1"
})
end
end)
Tp:AddButton("Teleport to Super Hard Mode", function()
if RemotesFolder:FindFirstChild("CreateElevator") then
RemotesFolder.CreateElevator:FireServer({
Mods = {},
Settings = {},
Destination = "SuperHardMode",
FriendsOnly = false,
MaxPlayers = "1"
})
end
end)
Tp:AddButton("Teleport to Endless", function()
if RemotesFolder:FindFirstChild("CreateElevator") then
RemotesFolder.CreateElevator:FireServer({
Mods = {},
Settings = {},
Destination = "Endless",
FriendsOnly = false,
MaxPlayers = "1"
})
end
end)
Tp:AddButton("Teleport to Rush Mode", function()
if RemotesFolder:FindFirstChild("CreateElevator") then
RemotesFolder.CreateElevator:FireServer({
Mods = {},
Settings = {},
Destination = "Fools26",
FriendsOnly = false,
MaxPlayers = "1"
})
end
end)
Tp:AddButton("Teleport to Battle Mode", function()
if RemotesFolder:FindFirstChild("CreateElevator") then
RemotesFolder.CreateElevator:FireServer({
Mods = {},
Settings = {},
Destination = "Party",
FriendsOnly = false,
MaxPlayers = "1"
})
end
end)
Tp:AddButton("Teleport to Chaos", function()
if RemotesFolder:FindFirstChild("CreateElevator") then
RemotesFolder.CreateElevator:FireServer({
Mods = {},
Settings = { youtube = "", twitch = "" },
Destination = "Curated",
FriendsOnly = false,
MaxPlayers = "1"
})
end
end)
Tp:AddButton("Teleport to Daily Run", function()
if RemotesFolder:FindFirstChild("CreateElevator") then
RemotesFolder.CreateElevator:FireServer({
Mods = {},
Settings = {},
Destination = "Daily",
FriendsOnly = false,
MaxPlayers = "1"
})
end
end)
Tp:AddButton("Teleport to Cringles Workshop", function()
if RemotesFolder:FindFirstChild("CreateElevator") then
RemotesFolder.CreateElevator:FireServer({
Mods = {},
Settings = {},
Destination = "CringlesWorkshop",
FriendsOnly = false,
MaxPlayers = "1"
})
end
end)
Tp:AddButton("Teleport to Trick Or Treat", function()
if RemotesFolder:FindFirstChild("CreateElevator") then
RemotesFolder.CreateElevator:FireServer({
Mods = {},
Settings = {},
Destination = "Halloween25",
FriendsOnly = false,
MaxPlayers = "1"
})
end
end)
Tp:AddButton("Teleport to Hotel-", function()
if RemotesFolder:FindFirstChild("CreateElevator") then
RemotesFolder.CreateElevator:FireServer({
Mods = {},
Settings = {},
Destination = "BeforePlus",
FriendsOnly = false,
MaxPlayers = "1"
})
end
end)
local MenuGroup = Tabs.Settings:AddLeftGroupbox('UI Settings')
local UtilityBox = Tabs.Settings:AddRightGroupbox('Hub Utilities')
local MenuPicker = MenuGroup:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", {
Default = "RightShift",
NoUI = true,
Text = "Menu keybind"
})
Library.ToggleKeybind = Options.MenuKeybind
function MenuPicker:OnClick()
local Event
Event = game:GetService("UserInputService").InputBegan:Connect(function(Input)
if Input.UserInputType ~= Enum.UserInputType.Keyboard then return end
local Key = Input.KeyCode.Name
if Key == "Escape" then
Event:Disconnect()
self:Update()
return
end
self.Value = Key
self.Modifiers = {}
Event:Disconnect()
self:Update()
if Library and Library.UpdateKeybinds then
Library:UpdateKeybinds()
end
end)
end
UtilityBox:AddButton({
Text = "Unload Hub",
Func = function()
if getgenv().UmbraUnload then
getgenv().UmbraUnload()
end
end
})
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({'MenuKeybind'})
ThemeManager:SetFolder("Umbra")
SaveManager:SetFolder("Umbra/DOORSLOBBY")
SaveManager:BuildConfigSection(Tabs['Settings'])
ThemeManager:ApplyToTab(Tabs['Settings'])
Notify("Successfully Loaded for DOORS Lobby", 4)
return
end
local Floor = ReplicatedStorage:FindFirstChild("GameData") and ReplicatedStorage.GameData:FindFirstChild("Floor")
or ReplicatedStorage:WaitForChild("GameData"):WaitForChild("Floor")
local LatestRoom = ReplicatedStorage:WaitForChild("GameData"):WaitForChild("LatestRoom")
local PL = RemotesFolder:FindFirstChild("PL") or RemotesFolder:WaitForChild("PL")
local function RemoveDoorESP(part)
if part and ESPLibrary then
ESPLibrary:RemoveESP(part)
end
end
local function ClearAllDoorESP()
local currentRoomsFolder = workspace:FindFirstChild("CurrentRooms")
if currentRoomsFolder then
for _, v in ipairs(currentRoomsFolder:GetChildren()) do
if v:FindFirstChild("Door") and v.Door:FindFirstChild("Door") then
RemoveDoorESP(v.Door.Door)
if v.Door.Door:FindFirstChild("CrossBoards") then
RemoveDoorESP(v.Door.Door.CrossBoards)
end
end
end
end
end
local function IsDoorLocked(doorParent)
if not doorParent then return false end
if doorParent:GetAttribute("Locked") then return true end
if doorParent:FindFirstChild("Padlock") then return true end
local door = doorParent:FindFirstChild("Door")
if door then
if door:GetAttribute("Locked") then return true end
if door:FindFirstChild("Padlock") then return true end
for _, desc in ipairs(door:GetDescendants()) do
if desc.Name == "Padlock" and desc:IsA("Model") then return true end
if desc.Name == "Padlock" and desc:IsA("BasePart") and desc.Transparency < 1 then return true end
end
end
return false
end
local function UpdateDoorESP()
if not (Toggles.EnableESP and Toggles.EnableESP.Value) then ClearAllDoorESP() return end
if not (Toggles.Door and Toggles.Door.Value) then
ClearAllDoorESP()
return
end
local DoorColor = Options.ColorPicker2 and Options.ColorPicker2.Value or Color3.fromRGB(0, 255, 0)
local currentRoomNum = LocalPlayer:GetAttribute("CurrentRoom")
if not currentRoomNum then return end
local currentRoomsFolder = workspace:FindFirstChild("CurrentRooms")
if not currentRoomsFolder then return end
local oldRoom = currentRoomsFolder:FindFirstChild(tostring(currentRoomNum - 1))
if oldRoom and oldRoom:FindFirstChild("Door") and oldRoom.Door:FindFirstChild("Door") then
local oldDoor = oldRoom.Door.Door
RemoveDoorESP(oldDoor)
if oldDoor:FindFirstChild("CrossBoards") then
RemoveDoorESP(oldDoor.CrossBoards)
end
end
local curRoom = currentRoomsFolder:FindFirstChild(tostring(currentRoomNum))
if curRoom and curRoom:FindFirstChild("Door") and curRoom.Door:FindFirstChild("Door") then
local curDoor = curRoom.Door.Door
local curRoomID = curRoom.Door:GetAttribute("RoomID") or "?"
local lockedSuffix = IsDoorLocked(curRoom.Door) and " (Locked)" or ""
ESPLibrary:AddESP({ Object = curDoor, Text = "Door " .. curRoomID .. lockedSuffix, Color = DoorColor })
if curDoor:FindFirstChild("CrossBoards") then
ESPLibrary:AddESP({ Object = curDoor.CrossBoards, Text = "", Color = DoorColor })
end
end
local nextRoom = currentRoomsFolder:FindFirstChild(tostring(currentRoomNum + 1))
if nextRoom and nextRoom:FindFirstChild("Door") and nextRoom.Door:FindFirstChild("Door") then
local nextDoor = nextRoom.Door.Door
local nextRoomID = nextDoor.Parent:GetAttribute("RoomID") or "?"
local lockedSuffix = IsDoorLocked(nextRoom.Door) and " (Locked)" or ""
ESPLibrary:AddESP({ Object = nextDoor, Text = "Door " .. nextRoomID .. lockedSuffix, Color = DoorColor })
if nextDoor:FindFirstChild("CrossBoards") then
ESPLibrary:AddESP({ Object = nextDoor.CrossBoards, Text = "", Color = DoorColor })
end
end
end
local HidingPlaces = {
["Wardrobe"] = "Closet",
["Rooms_Locker"] = "Locker",
["Rooms_Locker_Fridge"] = "Fridge",
["Locker_Large"] = "Locker",
["Backdoor_Wardrobe"] = "Closet",
["Bed"] = "Bed",
["Double_Bed"] = "Double Bed",
["Toolshed"] = "Closet",
["RetroWardrobe"] = "Closet",
["CircularVent"] = "Vent",
}
local Closets = {}
local HidingPlaceColor = Color3.new(0, 0.4, 0)
if workspace:FindFirstChild("CurrentRooms") then
for _, v in pairs(workspace.CurrentRooms:GetDescendants()) do
if HidingPlaces[v.Name] then
table.insert(Closets, v)
end
end
end
local ObjectiveItems = {
["Bandage"] = "Bandage",
["Flashlight"] = "Flash light",
["Battery"] = "Battery",
["BatteryPack"] = "Battery Pack",
["SkeletonKey"] = "Skeleton Key",
["Crucifix"] = "Crucifix",
["Straplight"] = "Strap Light",
["Lockpick"] = "Lockpick",
["Bulklight"] = "Bulk Light",
["Vitamins"] = "Vitamin",
["Shears"] = "Shears",
["LaserPointer"] = "Laser Pointer",
["Candle"] = "Candle",
["Smoothie"] = "Smoothie",
["StarJug"] = "Jug of Bottle",
["StardustPickup"] = "Stardust",
["ChestBoxLocked"] = "Locked Chest",
["ChestBox"] = "Chest",
["Chest_Vine"] = "Chest Vine",
["Toolbox_Locked"] = "Locked Toolbox",
["Toolshed_Small"] = "Toolshed",
["TimerLever"] = "Lever",
["HolyGrenade"] = "Holy Grenade",
["ShieldMini"] = "Mini Shield",
["ShieldBig"] = "Big Shield",
["CrucifixWall"] = "Crucifix",
["Glowsticks"] = "Glow Sticks",
["BandagePack"] = "Bandage Pack",
["AlarmClock"] = "Alarm Clock",
["MouseHole"] = "Louie Mouse",
["StarVial"] = "Star Vial",
["StarBottle"] = "Star Bottle",
["Compass"] = "Compass",
["Lantern"] = "Lantern",
["KeyIron"] = "Iron Key",
["GoldGun"] = "Golden Gun",
["Candy"] = "Candy",
["WaterPump"] = "Water Pump",
["VineGuillotine"] = "Vine Lever",
["Shakelight"] = "Shake Light",
["LibraryHintPaper"] = "Hint Paper",
["LotusPetalPickup"] = "Lotus Petal",
["KeyObtain"] = "Key",
["ElectrialKeyObtain"] = "Electrical Key"
}
local ActiveObjectiveESPs = {}
local function RemoveObjectiveESP(inst)
if inst and ActiveObjectiveESPs[inst] then
ActiveObjectiveESPs[inst] = nil
if ESPLibrary then
ESPLibrary:RemoveESP(inst)
end
end
end
local function ClearAllObjectiveESP()
for inst in pairs(ActiveObjectiveESPs) do
if ESPLibrary then
ESPLibrary:RemoveESP(inst)
end
end
table.clear(ActiveObjectiveESPs)
end
local function ClearObjectiveESPInRoom(roomFolder)
if not roomFolder then return end
for inst in pairs(ActiveObjectiveESPs) do
if inst:IsDescendantOf(roomFolder) then
RemoveObjectiveESP(inst)
end
end
end
local function AddObjectiveESPToObject(v)
if not (Toggles.EnableESP and Toggles.EnableESP.Value) then return end
if not (Toggles.Objective and Toggles.Objective.Value) then return end
if ActiveObjectiveESPs[v] then return end
if v.Name == "Candle" then
if v.Parent and v.Parent.Name == "Candle" then return end
if v.Parent and v.Parent.Parent and v.Parent.Parent.Name == "Candle" then return end
end
local ObjColor = Options.ColorPicker3 and Options.ColorPicker3.Value or Color3.fromRGB(0, 120, 255)
local label = ObjectiveItems[v.Name]
if label then
ActiveObjectiveESPs[v] = true
ESPLibrary:AddESP({ Object = v, Text = label, Color = ObjColor })
elseif v.Name == "MinesAnchor" then
local text = ""
local sign = v:FindFirstChild("Sign")
if sign then
local textLabel = sign:FindFirstChild("TextLabel", true)
if textLabel then
text = textLabel.Text
end
end
ActiveObjectiveESPs[v] = true
ESPLibrary:AddESP({ Object = v, Text = "Anchor " .. text, Color = ObjColor })
end
end
local function UpdateObjectiveESP()
if not (Toggles.EnableESP and Toggles.EnableESP.Value) then ClearAllObjectiveESP() return end
if not (Toggles.Objective and Toggles.Objective.Value) then
ClearAllObjectiveESP()
return
end
local currentRoomNum = LocalPlayer:GetAttribute("CurrentRoom")
if not currentRoomNum then return end
local currentRoomsFolder = workspace:FindFirstChild("CurrentRooms")
if not currentRoomsFolder then return end
local oldRoom = currentRoomsFolder:FindFirstChild(tostring(currentRoomNum - 1))
if oldRoom then
ClearObjectiveESPInRoom(oldRoom)
end
for inst in pairs(ActiveObjectiveESPs) do
local parentRoom = inst:FindFirstAncestorOfClass("Model")
if parentRoom and parentRoom.Parent == currentRoomsFolder then
local rNum = tonumber(parentRoom.Name)
if rNum and rNum < currentRoomNum then
RemoveObjectiveESP(inst)
end
end
end
local curRoom = currentRoomsFolder:FindFirstChild(tostring(currentRoomNum))
if curRoom then
for _, v in ipairs(curRoom:GetDescendants()) do
AddObjectiveESPToObject(v)
end
local floorVal = Floor and Floor.Value or "Hotel"
if floorVal == "Mines" and currentRoomNum == 100 then
local ObjColor = Options.ColorPicker3 and Options.ColorPicker3.Value or Color3.fromRGB(0, 120, 255)
for _, v in ipairs(curRoom:GetDescendants()) do
if v.Name == "WaterPump" or v.Name == "Wheel" then
local prompt = v:FindFirstChildWhichIsA("ProximityPrompt", true) or v.Parent:FindFirstChildWhichIsA("ProximityPrompt", true)
if prompt and prompt.Enabled and not ActiveObjectiveESPs[v] then
ActiveObjectiveESPs[v] = true
ESPLibrary:AddESP({ Object = v, Text = "Valve", Color = ObjColor })
local conn
conn = prompt:GetPropertyChangedSignal("Enabled"):Connect(function()
if not prompt.Enabled then
RemoveObjectiveESP(v)
if conn then conn:Disconnect() end
end
end)
table.insert(Connections, conn)
end
end
end
end
end
local nextRoom = currentRoomsFolder:FindFirstChild(tostring(currentRoomNum + 1))
if nextRoom then
for _, v in ipairs(nextRoom:GetDescendants()) do
AddObjectiveESPToObject(v)
end
end
end
local ActiveCurrentRoomESPs = {}
local LocalEntityNames = {
	["Snare"] = "Snare",
	["FigureRig"] = "Figure",
	["FigureRagdoll"] = "Figure",
	["Groundskeeper"] = "Ground Keeper",
	["MandrakeLive"] = "Man Drake",
	["JeffTheKiller"] = "Jeff",
	["BashMoving"] = "Bash",
	["HonchoRig"] = "Honcho"
}
local UtilityNames = {
["Root"] = true,
["HumanoidRootPart"] = true,
["Hitbox"] = true,
["Collision"] = true,
["CollisionPart"] = true,
["Box"] = true,
["Sight"] = true,
["Raycast"] = true,
["Anchor"] = true,
["Pivot"] = true
}
local function SetupEntityForESP(part, callback)
if not part then return end
task.spawn(function()
if part:IsA("Model") then
local visualPart = part:FindFirstChildWhichIsA("MeshPart", true) or part.PrimaryPart or part:FindFirstChildWhichIsA("BasePart", true)
if visualPart then
part.PrimaryPart = visualPart
if visualPart.Transparency >= 1 then
visualPart.Transparency = 0.99
end
end
for _, child in ipairs(part:GetChildren()) do
if child:IsA("BasePart") then
if UtilityNames[child.Name] then
child.Transparency = 1
end
end
end
if not part:FindFirstChildOfClass("Humanoid") then
local hum = Instance.new("Humanoid")
hum.Parent = part
end
end
if callback then callback() end
end)
end
local function ClearCurrentRoomESPs()
for inst in pairs(ActiveCurrentRoomESPs) do
if ESPLibrary then
ESPLibrary:RemoveESP(inst)
end
end
table.clear(ActiveCurrentRoomESPs)
end
local function UpdateCurrentRoomESPs()
ClearCurrentRoomESPs()
if not (Toggles.EnableESP and Toggles.EnableESP.Value) then return end
local currentRoomNum = LocalPlayer:GetAttribute("CurrentRoom")
if not currentRoomNum then return end
local currentRoomsFolder = workspace:FindFirstChild("CurrentRooms")
if not currentRoomsFolder then return end
local curRoom = currentRoomsFolder:FindFirstChild(tostring(currentRoomNum))
if not curRoom then return end
local floorVal = Floor and Floor.Value or "Hotel"
local entityColor = Options.ColorPicker9 and Options.ColorPicker9.Value or Color3.fromRGB(255, 0, 0)
if Toggles.Books and Toggles.Books.Value then
local presentColor = Options.ColorPicker6 and Options.ColorPicker6.Value or Color3.fromRGB(255, 100, 100)
for _, v in ipairs(curRoom:GetDescendants()) do
if v.Name == "CringlePresent" then
local boxPart = v:FindFirstChild("Box", true) or v:FindFirstChildWhichIsA("BasePart", true)
if boxPart and not ActiveCurrentRoomESPs[boxPart] then
ActiveCurrentRoomESPs[boxPart] = true
ESPLibrary:AddESP({ Object = boxPart, Text = "Present", Color = presentColor })
end
end
end
end
if Toggles.Entity and Toggles.Entity.Value then
for _, v in ipairs(curRoom:GetDescendants()) do
local label = LocalEntityNames[v.Name]
if label then
if (v.Name == "Eyes" or v.Name == "Lookman" or v.Name == "Egg") and
(v:FindFirstAncestor("ScreechPiles") or v:FindFirstAncestor("ScreechPile") or v:FindFirstAncestor("GloomPile") or v:FindFirstAncestor("GloomEgg") or v:FindFirstAncestor("GiggleCeiling")) then
continue
end
if v.Name == "Snare" then
if v:FindFirstChild("Hitbox") then
SetupEntityForESP(v)
ActiveCurrentRoomESPs[v] = true
ESPLibrary:AddESP({ Object = v, Text = label, Color = entityColor })
end
else
SetupEntityForESP(v)
ActiveCurrentRoomESPs[v] = true
ESPLibrary:AddESP({ Object = v, Text = label, Color = entityColor })
end
elseif v.Name == "DoorFake" and v.Parent and v.Parent.Name == "SideroomDupe" then
local door = v:FindFirstChild("Door")
if door then
SetupEntityForESP(door)
ActiveCurrentRoomESPs[door] = true
ESPLibrary:AddESP({ Object = door, Text = "Dupe", Color = entityColor })
end
elseif v.Name == "GiggleCeiling" then
if v:FindFirstChild("Hitbox") then
SetupEntityForESP(v)
ActiveCurrentRoomESPs[v] = true
ESPLibrary:AddESP({ Object = v, Text = "Giggle", Color = entityColor })
end
end
end
if floorVal == "Mines" and currentRoomNum == 50 then
for _, v in ipairs(curRoom:GetDescendants()) do
if v.Name == "GrumbleRig" or v.Name == "LiveEntityBramble" then
local label = v.Name == "GrumbleRig" and "Grumble" or "Bramble"
SetupEntityForESP(v)
ActiveCurrentRoomESPs[v] = true
ESPLibrary:AddESP({ Object = v, Text = label, Color = entityColor })
end
end
end
end
if Toggles.Books and Toggles.Books.Value then
if (floorVal == "Hotel" or floorVal == "Fools") and currentRoomNum == 50 then
local bookColor = Options.ColorPicker6 and Options.ColorPicker6.Value or Color3.fromRGB(0, 0, 128)
for _, v in ipairs(curRoom:GetDescendants()) do
if v.Name == "LiveHintBook" then
ActiveCurrentRoomESPs[v] = true
ESPLibrary:AddESP({ Object = v, Text = "Library Book", Color = bookColor })
end
end
end
end
if Toggles.Breakers and Toggles.Breakers.Value then
if (floorVal == "Hotel" or floorVal == "Fools") and currentRoomNum == 100 then
local breakerColor = Options.ColorPicker7 and Options.ColorPicker7.Value or Color3.fromRGB(128, 255, 128)
for _, v in ipairs(curRoom:GetDescendants()) do
if v.Name == "LiveBreakerPolePickup" then
ActiveCurrentRoomESPs[v] = true
ESPLibrary:AddESP({ Object = v, Text = "Breaker", Color = breakerColor })
end
end
end
end
if Toggles.Gold and Toggles.Gold.Value then
local goldColor = Options.ColorPicker8 and Options.ColorPicker8.Value or Color3.fromRGB(255, 255, 0)
for _, v in ipairs(curRoom:GetDescendants()) do
if v.Name == "GoldPile" then
local val = v:GetAttribute("GoldValue")
local label = val and ("Gold [" .. tostring(val) .. "]") or "Gold"
ActiveCurrentRoomESPs[v] = true
ESPLibrary:AddESP({ Object = v, Text = label, Color = goldColor })
end
end
end
if Toggles.Ladder and Toggles.Ladder.Value then
local ladderColor = Options.ColorPicker10 and Options.ColorPicker10.Value or Color3.fromRGB(0, 0, 255)
for _, v in ipairs(curRoom:GetDescendants()) do
if v.Name == "Ladder" then
ActiveCurrentRoomESPs[v] = true
ESPLibrary:AddESP({ Object = v, Text = "Ladder", Color = ladderColor })
end
end
end
if Toggles.Fuse and Toggles.Fuse.Value then
local fuseColor = Options.ColorPicker11 and Options.ColorPicker11.Value or Color3.fromRGB(255, 170, 0)
for _, v in ipairs(curRoom:GetDescendants()) do
local name = v.Name
local label = nil
if (name == "FuseObtain" or name == "Fuse") and not v:FindFirstAncestor("MinesGenerator") then
label = "Fuse"
elseif name == "MinesGenerator" then
label = "Generator"
elseif name == "MinesGateButton" then
label = "Gate Button"
elseif name == "ElevatorBreaker" then
label = "Breaker Switch"
end
if label then
ActiveCurrentRoomESPs[v] = true
ESPLibrary:AddESP({ Object = v, Text = label, Color = fuseColor })
end
end
end
if Toggles.HidingPlace and Toggles.HidingPlace.Value then
for _, v in ipairs(curRoom:GetDescendants()) do
local label = HidingPlaces[v.Name]
if label then
ActiveCurrentRoomESPs[v] = true
ESPLibrary:AddESP({ Object = v, Text = label, Color = HidingPlaceColor })
end
end
end
if Toggles.GateLever and Toggles.GateLever.Value then
local leverColor = Options.ColorPicker5 and Options.ColorPicker5.Value or Color3.fromRGB(128, 128, 128)
for _, v in ipairs(curRoom:GetDescendants()) do
if v.Name == "LeverForGate" then
ActiveCurrentRoomESPs[v] = true
ESPLibrary:AddESP({ Object = v, Text = "Gate Lever", Color = leverColor })
end
end
end
end
local FastMovingEntityNames = {
	["FrozenAmbush"] = "Ambush",
	["CringleScreech"] = "Screech",
	["RushMoving"] = "Rush",
	["AmbushMoving"] = "Ambush",
	["A60"] = "A-60",
	["A120"] = "A-120",
	["GlitchRush"] = "Glitch Rush",
	["GlitchAmbush"] = "Glitch Ambush",
	["BackdoorRush"] = "Blitz",
	["Eyes"] = "Eyes",
	["Lookman"] = "Eyes",
	["BackdoorLookman"] = "Lookman",
	["Screech"] = "Screech",
	["BashMoving"] = "Bash",
	["Scribbles"] = "Scribbles"
}
local GlobalEntityESPs = {}
local function ClearGlobalEntityESPs()
for inst in pairs(GlobalEntityESPs) do
if ESPLibrary then ESPLibrary:RemoveESP(inst) end
end
table.clear(GlobalEntityESPs)
end
local function AddGlobalEntityESP(v)
if not (Toggles.EnableESP and Toggles.EnableESP.Value) then return end
if not (Toggles.Entity and Toggles.Entity.Value) then return end
local label = FastMovingEntityNames[v.Name]
if label and not GlobalEntityESPs[v] then
SetupEntityForESP(v, function()
if not GlobalEntityESPs[v] and Toggles.Entity and Toggles.Entity.Value and v and v.Parent then
local entityColor = Options.ColorPicker9 and Options.ColorPicker9.Value or Color3.fromRGB(255, 0, 0)
GlobalEntityESPs[v] = true
ESPLibrary:AddESP({ Object = v, Text = label, Color = entityColor })
end
end)
end
end

local VineDoorESPs = {}
local PaperPlaneESPs = {}
local VineDoorEventConns = {}
local GodmodeAnchorPos = nil

local function DetectDoorAnomaly(doorModel)
	if doorModel:GetAttribute("Anomaly") == true or doorModel:GetAttribute("IsAnomaly") == true then
		return "ANOMALY"
	end
	if doorModel:GetAttribute("Safe") == true or doorModel:GetAttribute("Correct") == true then
		return "SAFE"
	end
	local base = doorModel:FindFirstChild("Base")
	if base then
		if base:GetAttribute("Anomaly") == true or base:GetAttribute("IsAnomaly") == true then
			return "ANOMALY"
		end
		if base:GetAttribute("Safe") == true or base:GetAttribute("Correct") == true then
			return "SAFE"
		end
		if base:GetAttribute("Setting") == "ON" or base:GetAttribute("Setting") == true then
			return "ANOMALY"
		end
	end
	for _, child in ipairs(doorModel:GetChildren()) do
		if child:IsA("BasePart") or child:IsA("Model") then
			if child:GetAttribute("Anomaly") == true or child:GetAttribute("IsAnomaly") == true then
				return "ANOMALY"
			end
			if child:GetAttribute("Safe") == true or child:GetAttribute("Correct") == true then
				return "SAFE"
			end
			for _, vinePart in ipairs(child:GetDescendants()) do
				if vinePart:IsA("BasePart") or vinePart:IsA("Model") then
					if vinePart:GetAttribute("Anomaly") == true or vinePart:GetAttribute("IsAnomaly") == true then
						return "ANOMALY"
					end
					if vinePart:GetAttribute("Safe") == true or vinePart:GetAttribute("Correct") == true then
						return "SAFE"
					end
				end
			end
		end
	end
	return nil
end

local function RefreshVineDoorESPForModel(doorModel)
	if not (Toggles.EnableESP and Toggles.EnableESP.Value) then return end
	local vineColor = Options.VineDoorColor and Options.VineDoorColor.Value or Color3.fromRGB(0, 255, 128)
	local flowerColor = Options.FlowerDoorColor and Options.FlowerDoorColor.Value or Color3.fromRGB(255, 105, 180)
	local anomalyColor = Options.VineDoorAnomalyColor and Options.VineDoorAnomalyColor.Value or Color3.fromRGB(255, 0, 0)
	local safeColor = Options.VineDoorSafeColor and Options.VineDoorSafeColor.Value or Color3.fromRGB(0, 255, 0)

	local function GetVineAnomaly(vinePart)
		if not vinePart then return nil end
		if vinePart:GetAttribute("Anomaly") == true or vinePart:GetAttribute("IsAnomaly") == true then return "ANOMALY" end
		if vinePart:GetAttribute("Safe") == true or vinePart:GetAttribute("Correct") == true then return "SAFE" end
		for _, desc in ipairs(vinePart:GetDescendants()) do
			if desc:IsA("BasePart") or desc:IsA("Model") then
				if desc:GetAttribute("Anomaly") == true or desc:GetAttribute("IsAnomaly") == true then return "ANOMALY" end
				if desc:GetAttribute("Safe") == true or desc:GetAttribute("Correct") == true then return "SAFE" end
			end
		end
		return nil
	end

	if Toggles.VineDoors and Toggles.VineDoors.Value then
		for _, doorName in ipairs({"LeftVines", "RightVines"}) do
			local door = doorModel:FindFirstChild(doorName)
			if door then
				if ESPLibrary then ESPLibrary:RemoveESP(door) end
				VineDoorESPs[door] = nil
				local vineAnomaly = GetVineAnomaly(door)
				local color = vineColor
				local label = "Vine Door"
				if vineAnomaly == "ANOMALY" then
					color = anomalyColor
					label = "Vine Door [ANOMALY]"
				elseif vineAnomaly == "SAFE" then
					color = safeColor
					label = "Vine Door [SAFE]"
				else
					local modelAnomaly = DetectDoorAnomaly(doorModel)
					if modelAnomaly == "ANOMALY" then
						color = anomalyColor
						label = "Vine Door [ANOMALY]"
					elseif modelAnomaly == "SAFE" then
						color = safeColor
						label = "Vine Door [SAFE]"
					end
				end
				VineDoorESPs[door] = true
				ESPLibrary:AddESP({ Object = door, Text = label, Color = color })
			end
		end
	end

	if Toggles.FlowerDoors and Toggles.FlowerDoors.Value then
		local flowers = doorModel:FindFirstChild("Flowers")
		if flowers then
			if ESPLibrary then ESPLibrary:RemoveESP(flowers) end
			VineDoorESPs[flowers] = nil
			local flowerAnomaly = GetVineAnomaly(flowers)
			local color = flowerColor
			local label = "Flower Door"
			if flowerAnomaly == "ANOMALY" then
				color = anomalyColor
				label = "Flower Door [ANOMALY]"
			elseif flowerAnomaly == "SAFE" then
				color = safeColor
				label = "Flower Door [SAFE]"
			else
				local modelAnomaly = DetectDoorAnomaly(doorModel)
				if modelAnomaly == "ANOMALY" then
					color = anomalyColor
					label = "Flower Door [ANOMALY]"
				elseif modelAnomaly == "SAFE" then
					color = safeColor
					label = "Flower Door [SAFE]"
				end
			end
			VineDoorESPs[flowers] = true
			ESPLibrary:AddESP({ Object = flowers, Text = label, Color = color })
		end
	end
end

local function SetupVineDoorEvents(doorModel)
	if VineDoorEventConns[doorModel] then return end
	local base = doorModel:FindFirstChild("Base")
	if not base then return end
	VineDoorEventConns[doorModel] = {}
	for _, eventName in ipairs({"PlayerOpen", "PlayerOpenWrong", "Open", "OpenWrong", "OtherOpen", "PlayerOpenWrong"}) do
		local ev = base:FindFirstChild(eventName)
		if ev then
			local conn
			if ev:IsA("BindableEvent") then
				conn = ev.Event:Connect(function()
					task.delay(0.15, function()
						RefreshVineDoorESPForModel(doorModel)
					end)
				end)
			elseif ev:IsA("RemoteEvent") then
				conn = ev.OnClientEvent:Connect(function()
					task.delay(0.15, function()
						RefreshVineDoorESPForModel(doorModel)
					end)
				end)
			end
			if conn then
				table.insert(VineDoorEventConns[doorModel], conn)
				table.insert(Connections, conn)
			end
		end
	end
end

local function UpdateVineDoorESP()
	for inst in pairs(VineDoorESPs) do
		if ESPLibrary then ESPLibrary:RemoveESP(inst) end
	end
	table.clear(VineDoorESPs)
	for model, conns in pairs(VineDoorEventConns) do
		for _, conn in ipairs(conns) do
			if conn and conn.Connected then conn:Disconnect() end
		end
	end
	table.clear(VineDoorEventConns)
	if not (Toggles.EnableESP and Toggles.EnableESP.Value) then return end
	if not ((Toggles.VineDoors and Toggles.VineDoors.Value) or (Toggles.FlowerDoors and Toggles.FlowerDoors.Value)) then return end

	local function ScanForDoors(parent)
		for _, v in ipairs(parent:GetDescendants()) do
			if v.Name == "ForgetMeNotVineDoors" and v:IsA("Model") then
				SetupVineDoorEvents(v)
				RefreshVineDoorESPForModel(v)
			end
		end
	end

	local currentRooms = workspace:FindFirstChild("CurrentRooms")
	if currentRooms then ScanForDoors(currentRooms) end
	ScanForDoors(workspace)
end

local function UpdatePaperPlaneESP()
	for inst in pairs(PaperPlaneESPs) do
		if ESPLibrary then ESPLibrary:RemoveESP(inst) end
	end
	table.clear(PaperPlaneESPs)
	if not (Toggles.EnableESP and Toggles.EnableESP.Value) then return end
	if not (Toggles.PaperPlane and Toggles.PaperPlane.Value) then return end

	local planeColor = Options.PaperPlaneColor and Options.PaperPlaneColor.Value or Color3.fromRGB(255, 200, 100)

	local function ScanForPlane(parent)
		for _, v in ipairs(parent:GetDescendants()) do
			if v.Name == "PaperPlanePickup" and v:IsA("Model") then
				local plane = v:FindFirstChild("Plane")
				if plane and not PaperPlaneESPs[v] then
					PaperPlaneESPs[v] = true
					ESPLibrary:AddESP({ Object = plane, Text = "Paper Plane", Color = planeColor })
				end
			end
		end
	end

	local currentRooms = workspace:FindFirstChild("CurrentRooms")
	if currentRooms then ScanForPlane(currentRooms) end
	ScanForPlane(workspace)
end

local function ClearVineDoorESP()
	for inst in pairs(VineDoorESPs) do
		if ESPLibrary then ESPLibrary:RemoveESP(inst) end
	end
	table.clear(VineDoorESPs)
	for model, conns in pairs(VineDoorEventConns) do
		for _, conn in ipairs(conns) do
			if conn and conn.Connected then conn:Disconnect() end
		end
	end
	table.clear(VineDoorEventConns)
end

local function ClearPaperPlaneESP()
	for inst in pairs(PaperPlaneESPs) do
		if ESPLibrary then ESPLibrary:RemoveESP(inst) end
	end
	table.clear(PaperPlaneESPs)
end

local function RemoveFloorLootESP(inst)
	if inst and ESPLibrary then
		ESPLibrary:RemoveESP(inst)
	end
end
local function ClearAllFloorLootESP()
	local currentRoomsFolder = workspace:FindFirstChild("CurrentRooms")
	if currentRoomsFolder then
		for _, room in ipairs(currentRoomsFolder:GetChildren()) do
			for _, v in ipairs(room:GetDescendants()) do
				if v.Name == "FloorLootItem" then
					RemoveFloorLootESP(v)
				end
			end
		end
	end
end
local function UpdateFloorLootESP()
	if not (Toggles.EnableESP and Toggles.EnableESP.Value) then ClearAllFloorLootESP() return end
	if not (Toggles.FloorLoot and Toggles.FloorLoot.Value) then
		ClearAllFloorLootESP()
		return
	end
	local lootColor = Options.FloorLootColor and Options.FloorLootColor.Value or Color3.fromRGB(255, 165, 0)
	local currentRoomNum = LocalPlayer:GetAttribute("CurrentRoom")
	if not currentRoomNum then return end
	local currentRoomsFolder = workspace:FindFirstChild("CurrentRooms")
	if not currentRoomsFolder then return end
	local oldRoom = currentRoomsFolder:FindFirstChild(tostring(currentRoomNum - 1))
	if oldRoom then
		for _, v in ipairs(oldRoom:GetDescendants()) do
			if v.Name == "FloorLootItem" then
				RemoveFloorLootESP(v)
			end
		end
	end
	local function AddLootESP(roomFolder)
		if not roomFolder then return end
		for _, v in ipairs(roomFolder:GetDescendants()) do
			if v.Name == "FloorLootItem" then
				local prompt = v:FindFirstChildWhichIsA("ProximityPrompt", true)
				if prompt and prompt.Enabled then
					local itemName = ""
					for _, child in ipairs(v:GetChildren()) do
						if child:IsA("Model") or child:IsA("BasePart") then
							itemName = child.Name
							break
						end
					end
					local label = itemName ~= "" and itemName or "Loot"
					ESPLibrary:AddESP({ Object = v, Text = label, Color = lootColor })
				end
			end
		end
	end
	local curRoom = currentRoomsFolder:FindFirstChild(tostring(currentRoomNum))
	AddLootESP(curRoom)
	local nextRoom = currentRoomsFolder:FindFirstChild(tostring(currentRoomNum + 1))
	AddLootESP(nextRoom)
end
local function ClearFloorLootESP()
	ClearAllFloorLootESP()
end

-- Locker ESP
local ActiveLockerESPs = {}
local function ClearLockerESP()
	for inst in pairs(ActiveLockerESPs) do
		if ESPLibrary then ESPLibrary:RemoveESP(inst) end
	end
	table.clear(ActiveLockerESPs)
end
local function UpdateLockerESP()
	if not (Toggles.EnableESP and Toggles.EnableESP.Value) then ClearLockerESP() return end
	if not (Toggles.Locker and Toggles.Locker.Value) then
		ClearLockerESP()
		return
	end
	ClearLockerESP()
	local lockerColor = Options.LockerColor and Options.LockerColor.Value or Color3.fromRGB(100, 200, 255)
	local currentRoomNum = LocalPlayer:GetAttribute("CurrentRoom")
	if not currentRoomNum then return end
	local currentRoomsFolder = workspace:FindFirstChild("CurrentRooms")
	if not currentRoomsFolder then return end
	local function ScanForLockers(roomFolder)
		if not roomFolder then return end
		for _, v in ipairs(roomFolder:GetDescendants()) do
			if v.Name == "Locker_Small" and v:IsA("Model") then
				local doorPart = v:FindFirstChild("Door")
				if doorPart then
					ActiveLockerESPs[v] = true
					ESPLibrary:AddESP({ Object = v, Text = "Locker", Color = lockerColor })
				end
			end
		end
	end
	ScanForLockers(currentRoomsFolder:FindFirstChild(tostring(currentRoomNum)))
	ScanForLockers(currentRoomsFolder:FindFirstChild(tostring(currentRoomNum + 1)))
end

-- Toolbox ESP
local ActiveToolboxESPs = {}
local function ClearToolboxESP()
	for inst in pairs(ActiveToolboxESPs) do
		if ESPLibrary then ESPLibrary:RemoveESP(inst) end
	end
	table.clear(ActiveToolboxESPs)
end
local function UpdateToolboxESP()
	if not (Toggles.EnableESP and Toggles.EnableESP.Value) then ClearToolboxESP() return end
	if not (Toggles.Toolbox and Toggles.Toolbox.Value) then
		ClearToolboxESP()
		return
	end
	ClearToolboxESP()
	local toolboxColor = Options.ToolboxColor and Options.ToolboxColor.Value or Color3.fromRGB(255, 180, 50)
	local currentRoomNum = LocalPlayer:GetAttribute("CurrentRoom")
	if not currentRoomNum then return end
	local currentRoomsFolder = workspace:FindFirstChild("CurrentRooms")
	if not currentRoomsFolder then return end
	local function ScanForToolboxes(roomFolder)
		if not roomFolder then return end
		for _, v in ipairs(roomFolder:GetDescendants()) do
			if v.Name == "Toolbox" and v:IsA("Model") then
				local mainPart = v:FindFirstChild("Main")
				if mainPart then
					ActiveToolboxESPs[v] = true
					ESPLibrary:AddESP({ Object = v, Text = "Toolbox", Color = toolboxColor })
				end
			end
		end
	end
	ScanForToolboxes(currentRoomsFolder:FindFirstChild(tostring(currentRoomNum)))
	ScanForToolboxes(currentRoomsFolder:FindFirstChild(tostring(currentRoomNum + 1)))
end

-- Drones ESP
local ActiveDronesESPs = {}
local function RemoveDronesESP(inst)
	if inst and ESPLibrary then
		ESPLibrary:RemoveESP(inst)
	end
end
local function ClearDronesESP()
	for inst in pairs(ActiveDronesESPs) do
		RemoveDronesESP(inst)
	end
	table.clear(ActiveDronesESPs)
	for _, v in ipairs(workspace:GetChildren()) do
		if v.Name == "Drones" and v:IsA("Model") then
			RemoveDronesESP(v)
			local root = v:FindFirstChild("Root")
			if root then RemoveDronesESP(root) end
		end
	end
end
local function UpdateDronesESP()
	if not (Toggles.EnableESP and Toggles.EnableESP.Value) then ClearDronesESP() return end
	if not (Toggles.Drones and Toggles.Drones.Value) then
		ClearDronesESP()
		return
	end
	ClearDronesESP()
	local dronesColor = Options.DronesColor and Options.DronesColor.Value or Color3.fromRGB(200, 50, 255)
	for _, v in ipairs(workspace:GetChildren()) do
		if v.Name == "Drones" and v:IsA("Model") then
			local root = v:FindFirstChild("Root")
			local part = root or v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart")
			if part then
				ActiveDronesESPs[v] = true
				ESPLibrary:AddESP({ Object = v, Text = "Drone", Color = dronesColor })
			end
		end
	end
end

local function ClearOldRoomESPs()
	local currentRoomNum = LocalPlayer:GetAttribute("CurrentRoom")
	if not currentRoomNum then return end
	local currentRoomsFolder = workspace:FindFirstChild("CurrentRooms")
	if not currentRoomsFolder then return end

	local function BelongsToOldRoom(inst)
		if not inst or not inst.Parent then return false end
		local room = inst:FindFirstAncestorOfClass("Model")
		while room do
			if room.Parent == currentRoomsFolder then
				local num = tonumber(room.Name)
				if num and num < currentRoomNum then
					return true
				end
				return false
			end
			room = room.Parent and room.Parent:FindFirstAncestorOfClass("Model")
		end
		return false
	end

	for inst in pairs(VineDoorESPs) do
		if not inst.Parent or BelongsToOldRoom(inst) then
			if ESPLibrary then ESPLibrary:RemoveESP(inst) end
			VineDoorESPs[inst] = nil
		end
	end

	for inst in pairs(PaperPlaneESPs) do
		if not inst.Parent or BelongsToOldRoom(inst) then
			if ESPLibrary then ESPLibrary:RemoveESP(inst) end
			PaperPlaneESPs[inst] = nil
		end
	end

	for inst in pairs(ActiveCurrentRoomESPs) do
		if not inst.Parent or BelongsToOldRoom(inst) then
			if ESPLibrary then ESPLibrary:RemoveESP(inst) end
			ActiveCurrentRoomESPs[inst] = nil
		end
	end

	for inst in pairs(ActiveObjectiveESPs) do
		if not inst.Parent or BelongsToOldRoom(inst) then
			if ESPLibrary then ESPLibrary:RemoveESP(inst) end
			ActiveObjectiveESPs[inst] = nil
		end
	end

	for model, conns in pairs(VineDoorEventConns) do
		if not model.Parent or BelongsToOldRoom(model) then
			for _, conn in ipairs(conns) do
				if conn and conn.Connected then conn:Disconnect() end
			end
			VineDoorEventConns[model] = nil
		end
	end

	for inst in pairs(ActiveLockerESPs) do
		if not inst.Parent or BelongsToOldRoom(inst) then
			if ESPLibrary then ESPLibrary:RemoveESP(inst) end
			ActiveLockerESPs[inst] = nil
		end
	end

	for inst in pairs(ActiveToolboxESPs) do
		if not inst.Parent or BelongsToOldRoom(inst) then
			if ESPLibrary then ESPLibrary:RemoveESP(inst) end
			ActiveToolboxESPs[inst] = nil
		end
	end
end

table.insert(Connections, LocalPlayer:GetAttributeChangedSignal("CurrentRoom"):Connect(function()
	task.spawn(ClearOldRoomESPs)
	task.spawn(UpdateDoorESP)
	task.spawn(UpdateObjectiveESP)
	task.spawn(UpdateCurrentRoomESPs)
	task.spawn(UpdateVineDoorESP)
	task.spawn(UpdatePaperPlaneESP)
	task.spawn(UpdateFloorLootESP)
	task.spawn(UpdateLockerESP)
	task.spawn(UpdateToolboxESP)
	task.spawn(UpdateDronesESP)
end))
table.insert(Connections, LocalPlayer:GetAttributeChangedSignal("Alive"):Connect(function()
if LocalPlayer:GetAttribute("Alive") == false and Toggles.InfRevive and Toggles.InfRevive.Value then
task.wait(0.1)
if RemotesFolder:FindFirstChild("Revive") then
RemotesFolder.Revive:FireServer()
end
end
end))
local Tabs = {
Main = Window:AddTab('Player', "star"),
Bypass = Window:AddTab('Bypass', "ban"),
Visuals = Window:AddTab('Visuals', "eye"),
Floor = Window:AddTab('Floor', "sparkles"),
Settings = Window:AddTab('Settings', "settings"),
Info = Window:AddTab('Info', "info"),
}
local DuckBoards = {}
local Nodes = {}
local DefaultMoveControl = nil
pcall(function()
DefaultMoveControl = require(LocalPlayer.PlayerScripts.PlayerModule):GetControls().GetMoveVector
end)
local EntityNotifyNames = {
	["FrozenAmbush"] = "Ambush",
	["CringleScreech"] = "Screech",
	["RushMoving"] = "Rush",
	["AmbushMoving"] = "Ambush",
	["A60"] = "A-60",
	["A120"] = "A-120",
	["GlitchRush"] = "GlitchRush",
	["GlitchAmbush"] = "GlitchAmbush",
	["BackdoorRush"] = "Blitz",
	["Eyes"] = "Eyes",
	["Lookman"] = "Lookman",
	["BackdoorLookman"] = "Lookman",
	["JeffTheKiller"] = "Jeff",
	["Screech"] = "Screech",
	["BashMoving"] = "Bash",
	["Scribbles"] = "Scribbles"
}
local Debris = game:GetService("Debris")
local PathFolder = Instance.new("Folder", workspace)
PathFolder.Name = "Umbra_PathFolder"
local SeekPathFolder = Instance.new("Folder", workspace)
SeekPathFolder.Name = "Umbra_SeekPath"
local Figures = {}
local Anchors = {}
local AutoClosetTable = {
RushMoving = 150,
AmbushMoving = 190,
A60 = 210,
A120 = 120,
GlitchRush = 150,
GlitchAmbush = 190,
BackdoorRush = 160,
}
local function ShowSeekPath(v)
if not v then return end
local Part = Instance.new("Part", SeekPathFolder)
Part.Size = Vector3.new(1.5, 1.5, 1.5)
Part.Anchored = true
Part.Shape = Enum.PartType.Ball
Part.Position = v.Position
Part.CanCollide = false
Part.Color = Color3.fromRGB(0, 255, 0)
Part.Material = Enum.Material.Neon
Debris:AddItem(Part, 60)
end
local function FixBridge(v)
if not v then return end
for _, i in ipairs(v:GetChildren()) do
if i.Name == "PlayerBarrier" and (i.Rotation.X == 180 or math.abs(i.Rotation.X) >= 170) then
if not v:FindFirstChild("BridgeBarrier") then
local Barrier = i:Clone()
Barrier.CFrame = CFrame.new(i.Position.X, i.Position.Y, i.Position.Z) * CFrame.new(0, -7, 0)
Barrier.Size = Vector3.new(40, 0.1, 40)
Barrier.Transparency = 0.5
Barrier.Color = Color3.fromRGB(128, 0, 128)
Barrier.Material = Enum.Material.ForceField
Barrier.Parent = v
Barrier.Name = "BridgeBarrier"
Barrier.Anchored = true
Barrier.CanCollide = true
end
end
end
end
local function PathTo(Pos)
local Character = LocalPlayer.Character
local Root = Character and Character:FindFirstChild("HumanoidRootPart")
local Humanoid = Character and Character:FindFirstChild("Humanoid")
if not Root or not Humanoid or not Pos then return end
local p = PathfindingService:CreatePath({
AgentRadius = 2,
AgentHeight = 5,
AgentCanJump = true,
WaypointSpacing = 2,
AgentCanSprint = false,
AgentMaxSlope = 45,
AgentJumpHeight = 0
})
local AdjustedPos = Pos + Vector3.new(0, 0, 1)
p:ComputeAsync(Root.Position, AdjustedPos)
if p.Status ~= Enum.PathStatus.Success then return end
for _, waypoint in ipairs(p:GetWaypoints()) do
if not (Toggles.AutoRooms and Toggles.AutoRooms.Value) or (Library and Library.Unloaded) then break end
local Dist = (Root.Position - waypoint.Position).Magnitude
if Dist >= 2 then
Humanoid:MoveTo(waypoint.Position)
Humanoid.MoveToFinished:Wait()
end
end
end
local function SolveAnchors()
if not (Toggles.AutoAnchorSolver and Toggles.AutoAnchorSolver.Value) then return end
local latestRoomVal = ReplicatedStorage:FindFirstChild("GameData") and ReplicatedStorage.GameData:FindFirstChild("LatestRoom")
if not latestRoomVal or latestRoomVal.Value ~= 50 then return end
local mainUI = LocalPlayer.PlayerGui:FindFirstChild("MainUI")
local Hint = mainUI and mainUI:FindFirstChild("AnchorHintFrame")
if Hint and Hint.Visible then
local ID = Hint.AnchorCode.Text
for _, v in pairs(Anchors) do
if v and v.Parent and v:FindFirstChild("Sign") and v.Sign:FindFirstChild("TextLabel") and v.Sign.TextLabel.Text == ID then
local Code = Hint.Code.Text
local Note = v:FindFirstChild("Note")
local NoteText = (Note and Note:FindFirstChild("SurfaceGui") and Note.SurfaceGui:FindFirstChild("TextLabel")) and Note.SurfaceGui.TextLabel.Text or ""
local Mod = tonumber(string.match(NoteText, "%d+")) or 0
local Final = ""
for i = 1, #Code do
local Digit = tonumber(string.sub(Code, i, i)) or 0
local Res = string.find(NoteText, "+") and (Digit + Mod) % 10 or (Digit - Mod) % 10
Final = Final .. tostring(Res < 0 and Res + 10 or Res)
end
local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
if hrp and (hrp.Position - v:GetPivot().Position).Magnitude < 20 then
local AnchorRemote = v:FindFirstChildOfClass("RemoteFunction")
if AnchorRemote then
AnchorRemote:InvokeServer(tostring(Code))
end
Notify("Anchor Solved: " .. Final, 2)
end
end
end
end
end

local function CheckAndNotifyEntity(v)
if not (Toggles.NotifySpawn and Toggles.NotifySpawn.Value) then return end
if not Options.Notify or not Options.Notify.Value then return end
local notifyKey = EntityNotifyNames[v.Name]
if notifyKey and Options.Notify.Value[notifyKey] then
Notify(notifyKey .. " has Spawned!", 5)
end
end
table.insert(Connections, workspace.ChildAdded:Connect(function(v)
if Toggles.Entity and Toggles.Entity.Value then
AddGlobalEntityESP(v)
end
CheckAndNotifyEntity(v)
if v.Name == "BananaPeel" and Toggles.AntiBanana and Toggles.AntiBanana.Value then
v.CanTouch = false
end
	if v.Name == "JeffTheKiller" and Toggles.AntiJeff and Toggles.AntiJeff.Value then
		task.spawn(function()
			local isOwnerFunc = ExecutorSupport and ExecutorSupport.isnetworkowner or isnetworkowner
			local timeout = 0
			repeat
				task.wait(0.1)
				timeout = timeout + 0.1
			until (v.PrimaryPart and isOwnerFunc and isOwnerFunc(v.PrimaryPart)) or timeout > 3 or not v.Parent
			for _, i in ipairs(v:GetChildren()) do
				if i:IsA("BasePart") then
					i.CanTouch = false
				end
			end
			local hum = v:FindFirstChildOfClass("Humanoid")
			if hum then
				hum.Health = 0
			end
		end)
	end
	if v.Name == "Drones" and Toggles.AntiDrones and Toggles.AntiDrones.Value then
		task.spawn(function()
			local rem = v:FindFirstChild("WalkedInto")
			if rem then rem:Destroy() end
			for _, desc in ipairs(v:GetDescendants()) do
				if desc.Name == "WalkedInto" then
					pcall(function() desc:Destroy() end)
				end
			end
		end)
	end
end))
table.insert(Connections, workspace.CurrentCamera.ChildAdded:Connect(function(v)
if v.Name == "Screech" then
if Toggles.Entity and Toggles.Entity.Value then
AddGlobalEntityESP(v)
end
CheckAndNotifyEntity(v)
end
end))
local PlayerBox = Tabs.Main:AddLeftGroupbox('Player')
local GameBox = Tabs.Main:AddLeftGroupbox('Game Management')
local AutoBox = Tabs.Main:AddRightGroupbox('Auto')
local ReachBox = Tabs.Main:AddRightGroupbox('Reach')
local BypassEntityBox = Tabs.Bypass:AddLeftGroupbox('Bypass Entities')
local BypassBox = Tabs.Bypass:AddRightGroupbox('Bypass')
local CameraBox = Tabs.Visuals:AddLeftGroupbox('Camera')
local LightingBox = Tabs.Visuals:AddLeftGroupbox('Lighting')
local ESPBox = Tabs.Visuals:AddRightGroupbox('ESP')
local ESPSettings = Tabs.Visuals:AddRightGroupbox('Settings')
local NotifyBox = Tabs.Visuals:AddRightGroupbox('Notifying')
local HotelFloor = Tabs.Floor:AddLeftGroupbox('Hotel')
local MinesFloor = Tabs.Floor:AddRightGroupbox('Mines')
local FoolsFloor = Tabs.Floor:AddRightGroupbox('Fools')
local RetroFloor = Tabs.Floor:AddLeftGroupbox('Retro')
local RoomsFloor = Tabs.Floor:AddLeftGroupbox('Rooms')
local OldAccel = nil
PlayerBox:AddSlider("MovementSpeed", { Text = "Movement Speed", Default = 15, Min = 15, Max = 21, Rounding = 1, Compact = false, Callback = function() end })
PlayerBox:AddToggle('EnableMovementSpeed', {
Text = "Enable Movement Speed",
Default = false,
Callback = function(Value)
if not Value and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
LocalPlayer.Character.Humanoid.WalkSpeed = 15
end
end
})
PlayerBox:AddSlider("ClimbingSpeed", {
Text = "Climbing Speed",
Default = 15,
Min = 15,
Max = 30,
Rounding = 1,
Compact = false,
Callback = function() end,
Tooltip = "Climbing Speed"
})
PlayerBox:AddToggle('EnableClimbingSpeed', {
Text = "Enable Climbing Speed",
Default = false,
Callback = function(Value)
if not Value and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
LocalPlayer.Character.Humanoid.WalkSpeed = 15
end
end
})
PlayerBox:AddDivider()
PlayerBox:AddToggle('NoAcc', {
Text = "No Slipping",
Default = false,
Callback = function(Value)
if Value then
if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
OldAccel = LocalPlayer.Character.HumanoidRootPart.CustomPhysicalProperties
end
else
if OldAccel and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
LocalPlayer.Character.HumanoidRootPart.CustomPhysicalProperties = OldAccel
OldAccel = nil
end
end
end
})
PlayerBox:AddToggle('NoClip', {
Text = "No Clip",
Default = false,
Tooltip = "You Can Move Through Wall",
Callback = function(Value)
if not Value and LocalPlayer.Character then
for _, v in pairs(LocalPlayer.Character:GetChildren()) do
if v.Name ~= "CollisionClone" then
if v:IsA("BasePart") then
v.CanCollide = true
end
end
end
end
end
}):AddKeyPicker("NoclipKeybind", {
Default = "N",
SyncToggleState = true,
Mode = "Toggle",
Text = "No Clip",
NoUI = false,
})
PlayerBox:AddToggle('Flight', {
Text = "Flight",
Default = false,
Callback = function(Value)
if not Value then
if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
if LocalPlayer.Character.HumanoidRootPart:FindFirstChild("FlightVelocity") then
LocalPlayer.Character.HumanoidRootPart:FindFirstChild("FlightVelocity"):Destroy()
end
end
end
end
}):AddKeyPicker("FlightKeybind", {
Default = "F",
SyncToggleState = true,
Mode = "Toggle",
Text = "Flight",
NoUI = false,
})
PlayerBox:AddSlider("FlightSpeed", {
Text = "Flight Speed",
Default = 15,
Min = 15,
Max = 21,
Rounding = 1,
Compact = false,
Callback = function() end,
Tooltip = "Flight Speed",
})
PlayerBox:AddDivider()
PlayerBox:AddToggle('EnableJump', {
Text = "Enable Jumping",
Default = false,
Tooltip = "You Can Move Jump",
Callback = function(Value)
if not Value and LocalPlayer.Character then
LocalPlayer.Character:SetAttribute("CanJump", false)
end
end
})
PlayerBox:AddDivider()
PlayerBox:AddToggle('InstaInteract', {
Text = "Instant Interact",
Default = false,
Tooltip = "Interactions are Instantly",
Callback = function(Value)
if Value then
for _, v in ipairs(workspace:GetDescendants()) do
if v:IsA("ProximityPrompt") then
v:SetAttribute("Duration", v.HoldDuration)
v.HoldDuration = 0
end
end
else
for _, v in ipairs(workspace:GetDescendants()) do
if v:IsA("ProximityPrompt") then
v.HoldDuration = v:GetAttribute("Duration") or 0
end
end
end
end
})
PlayerBox:AddToggle('InfJump', {
Text = "Infinite Jump",
Default = false
})
if UserInputService.KeyboardEnabled then
local d = false
table.insert(Connections, UserInputService.JumpRequest:Connect(function()
if Toggles.InfJump and Toggles.InfJump.Value and not d and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
d = true
LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping, true)
task.wait(0.1)
d = false
end
end))
elseif UserInputService.TouchEnabled then
table.insert(Connections, LocalPlayer.CharacterAdded:Connect(function()
task.wait(1)
if LocalPlayer.PlayerGui:FindFirstChild("MainUI") and LocalPlayer.PlayerGui.MainUI.MainFrame.MobileButtons:FindFirstChild("JumpButton") then
table.insert(Connections, LocalPlayer.PlayerGui.MainUI.MainFrame.MobileButtons.JumpButton.MouseButton1Click:Connect(function()
if Toggles.InfJump and Toggles.InfJump.Value and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping, true)
end
end))
end
end))
if LocalPlayer.PlayerGui:FindFirstChild("MainUI") and LocalPlayer.PlayerGui.MainUI.MainFrame.MobileButtons:FindFirstChild("JumpButton") then
table.insert(Connections, LocalPlayer.PlayerGui.MainUI.MainFrame.MobileButtons.JumpButton.MouseButton1Click:Connect(function()
if Toggles.InfJump and Toggles.InfJump.Value and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping, true)
end
end))
end
end
PlayerBox:AddDivider()
PlayerBox:AddToggle('ExitClosetFast', {
Text = "Exit Closet Fast",
Default = false,
Tooltip = "Exits hiding spots faster than usual",
Callback = function() end
})
PlayerBox:AddLabel("Flat surfaces only. Height changes or launches = DEATH", true)
PlayerBox:AddToggle('Godmode', {
Text = "Godmode",
Default = false,
Tooltip = "Can Lagback you or not work",
Risky = true,
Callback = function(Value)
	local Char = LocalPlayer.Character
	if not Char then return end
	if Value then
		if Toggles.FigureHearing then
			if not Toggles.FigureHearing.Value then
				Toggles.FigureHearing:SetValue(true)
			elseif RemotesFolder:FindFirstChild("Crouch") then
				RemotesFolder.Crouch:FireServer(true, true)
			end
		end
		if RemotesFolder.Name ~= "RemotesFolder" then
			if Char:FindFirstChild("Collision") and Char:FindFirstChild("HumanoidRootPart") then
				GodmodeAnchorPos = Char.HumanoidRootPart.Position.Y
				Char.Collision.Position = Vector3.new(Char.Collision.Position.X, Char.HumanoidRootPart.Position.Y - 4, Char.Collision.Position.Z)
			end
		else
			if Char:FindFirstChild("CollisionPart") then
				GodmodeAnchorPos = Char.CollisionPart.Position.Y - 2
				Char:PivotTo(Char.CollisionPart.CFrame * CFrame.new(0, -2, 0))
			end
		end
	else
		GodmodeAnchorPos = nil
		if RemotesFolder.Name == "RemotesFolder" then
if Char:FindFirstChild("Humanoid") then Char.Humanoid.HipHeight = 2.4 end
if Char:FindFirstChild("Collision") then Char.Collision.Size = Vector3.new(5.5, 3, 3) end
if Char:FindFirstChild("LowerTorso") and Char.LowerTorso:FindFirstChild("Root") and Char.LowerTorso.Root:IsA("Motor6D") then
pcall(function() Char.LowerTorso.Root.C1 = CFrame.new(0, 0, 0) end)
end
if Char:FindFirstChild("Collision") and Char.Collision:FindFirstChild("CollisionCrouch") then
Char.Collision.CollisionCrouch.Size = Vector3.new(5.5, 3, 3)
end
if Char:FindFirstChild("CollisionPart") then
Char:PivotTo(Char.CollisionPart.CFrame * CFrame.new(0, 2, 0))
end
else
if Char:FindFirstChild("Collision") and Char:FindFirstChild("HumanoidRootPart") then
Char.Collision.Position = Char.HumanoidRootPart.Position
end
end
if RemotesFolder:FindFirstChild("Crouch") then
if Toggles.FigureHearing and Toggles.FigureHearing.Value then
RemotesFolder.Crouch:FireServer(true, true)
else
RemotesFolder.Crouch:FireServer(false, false)
end
end
end
end
}):AddKeyPicker("GodmodeKeybind", {
Default = "G",
SyncToggleState = true,
Mode = "Toggle",
Text = "Godmode",
NoUI = false,
})
GameBox:AddButton({
Text = "Revive",
DoubleClick = true,
Func = function()
if RemotesFolder:FindFirstChild("Revive") then
RemotesFolder.Revive:FireServer()
end
end
})
GameBox:AddButton({
Text = "Play Again",
DoubleClick = true,
Func = function()
if RemotesFolder:FindFirstChild("PlayAgain") then
RemotesFolder.PlayAgain:FireServer()
end
end
})
local ResetPressed = false
GameBox:AddButton({
Text = "Reset",
DoubleClick = true,
Func = function()
ResetPressed = not ResetPressed
if not ResetPressed then
if RemotesFolder:FindFirstChild("Underwater") then
RemotesFolder.Underwater:FireServer(false)
end
return
end
if ReplicateSignal then
ReplicateSignal(LocalPlayer.Kill)
else
Notify("Double Click to stop", 5)
task.spawn(function()
while ResetPressed and LocalPlayer:GetAttribute("Alive") ~= false do
if RemotesFolder:FindFirstChild("Underwater") then
RemotesFolder.Underwater:FireServer(true)
end
task.wait()
end
if RemotesFolder:FindFirstChild("Underwater") then
RemotesFolder.Underwater:FireServer(false)
end
ResetPressed = false
end)
end
end
})
GameBox:AddButton({
Text = "Lobby",
DoubleClick = true,
Func = function()
if RemotesFolder:FindFirstChild("Lobby") then
RemotesFolder.Lobby:FireServer()
end
end
})
table.insert(Connections, LocalPlayer.CharacterAdded:Connect(function(char)
task.wait(1.5)
if Toggles.Godmode and Toggles.Godmode.Value and RemotesFolder.Name ~= "RemotesFolder" then
	if char:FindFirstChild("Collision") and char:FindFirstChild("HumanoidRootPart") then
		GodmodeAnchorPos = char.HumanoidRootPart.Position.Y
		char.Collision.Position = Vector3.new(char.Collision.Position.X, char.HumanoidRootPart.Position.Y - 4, char.Collision.Position.Z)
	end
end
if Toggles.Dread and Toggles.Dread.Value then
local Dread = LocalPlayer:FindFirstChild("Dread", true) or LocalPlayer:FindFirstChild("_Dread", true)
if Dread then
Dread.Name = "_Dread"
end
end
if Toggles.Halt and Toggles.Halt.Value then
local Dread = ClientModules and ClientModules:FindFirstChild("EntityModules") and (ClientModules.EntityModules:FindFirstChild("Shade", true) or ClientModules.EntityModules:FindFirstChild("_Shade", true))
if Dread then
Dread.Name = "_Shade"
end
end
if Toggles.Jamming and Toggles.Jamming.Value then
pcall(function()
local jam = LocalPlayer.PlayerGui.MainUI.Initiator:FindFirstChild("Main_Game").Health.Jam
if jam then jam.Playing = false end
local jammingSound = game:GetService("SoundService").Main:FindFirstChild("Jamming")
if jammingSound then jammingSound.Enabled = false end
end)
end
if Toggles.FigureHearing and Toggles.FigureHearing.Value then
if RemotesFolder:FindFirstChild("Crouch") then
RemotesFolder.Crouch:FireServer(true)
end
end
end))
local lastDoorReachCheck = 0
local InfItemsDelay = 0
local Stored = {}
local Names = {
Lock = true,
ChestBoxLocked = true,
Cellar = true,
Chest_Vine = true,
CuttableVines = true,
SkullLock = true,
Toolbox_Locked = true,
Lock1 = true,
Lock2 = true,
}
local function IsInfItemTarget(prompt)
if not prompt or not prompt:IsA("ProximityPrompt") then return false end
if prompt.Name == "FusesPrompt" then return true end
local parent = prompt.Parent
if not parent then return false end
local parentName = parent.Name
local grandParentName = parent.Parent and parent.Parent.Name
if Names[parentName] or (grandParentName and Names[grandParentName]) then return true end
if grandParentName == "Locker_Small_Locked" then return true end
return false
end
local InfCrucfixTable = {
RushMoving = 90,
AmbushMoving = 160,
A60 = 140,
A120 = 99,
GlitchRush = 150,
GlitchAmbush = 110,
}
local InfParams = RaycastParams.new()
InfParams.FilterType = Enum.RaycastFilterType.Exclude
local function GetDistanceToPlayer(Pos)
if not Pos then return 999999 end
local DisA = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character.HumanoidRootPart.Position
or (workspace.CurrentCamera and workspace.CurrentCamera.CFrame.Position)
or Vector3.new(0, 0, 0)
return (DisA - Pos).Magnitude
end
local PromptIgnore = {
HidePrompt = true,
ClimbPrompt = true,
PropPrompt = true,
InteractPrompt = true,
RiftPrompt = true,
StarRiftPrompt = true,
NoHidingLilBro = true,
AnimatePrompt = true,
RevivePrompt = true,
}
local Interactions = {}
local Stored = {}
local AutoInteractTimer = 0
local Names = {
Lock = true,
ChestBoxLocked = true,
Cellar = true,
Chest_Vine = true,
CuttableVines = true,
SkullLock = true,
Toolbox_Locked = true,
Lock1 = true,
Lock2 = true,
}
local function InfPrompt(Prompt)
local Char = LocalPlayer.Character
if not Char then return end
local RootPart = Char:FindFirstChild("HumanoidRootPart")
if not RootPart then return end
local Tool = Char:FindFirstChild("Lockpick") or Char:FindFirstChild("SkeletonKey") or Char:FindFirstChild("Shears")
local Name = Tool and Tool.Name
if Tool then
if Prompt:GetAttribute("InfItems") and Prompt:GetAttribute("Tool") ~= Name then
if Prompt.Parent then
local ExistingPrompt = Prompt.Parent:FindFirstChild("InfPrompt")
if ExistingPrompt then
ExistingPrompt:Destroy()
end
Prompt:SetAttribute("InfItems", nil)
Prompt.Enabled = true
end
end
if not Prompt:GetAttribute("InfItems") then
Prompt.Enabled = false
Prompt:SetAttribute("InfItems", true)
Prompt:SetAttribute("Tool", Name)
Prompt.ClickablePrompt = false
local Clone = Prompt:Clone()
Clone.Name = "InfPrompt"
Clone.MaxActivationDistance = Prompt.MaxActivationDistance * 0.5
Clone.Parent = Prompt.Parent
Clone.Enabled = true
Clone.ClickablePrompt = true
local Con, ConEnded
ConEnded = Clone.PromptButtonHoldEnded:Connect(function()
task.delay(0.15, function()
if Clone and Clone.Parent then
if Con then Con:Disconnect() end
if ConEnded then ConEnded:Disconnect() end
Clone:Destroy()
Prompt:SetAttribute("InfItems", nil)
Prompt:SetAttribute("Tool", nil)
Prompt.Enabled = true
Prompt.ClickablePrompt = true
end
end)
end)
Con = Clone.Triggered:Connect(function()
if ConEnded then ConEnded:Disconnect() end
Con:Disconnect()
Clone:Destroy()
if Char:FindFirstChild(Name) then
task.spawn(function()
local Drop = nil
local StartTime = tick()
repeat
RemotesFolder.DropItem:FireServer(Tool)
task.wait(0.01)
local ClosestDist = 15
if workspace:FindFirstChild("Drops") then
for _, v in ipairs(workspace.Drops:GetChildren()) do
if v.Name == Name then
local Dist = GetDistanceToPlayer(v:GetPivot().Position)
if Dist < ClosestDist then
ClosestDist = Dist
Drop = v
end
end
end
end
until Drop or not Char:FindFirstChild(Name) or (tick() - StartTime) > 3
local firePromptFunc = Firepp or fireproximityprompt
if Name == "Shears" then
if firePromptFunc then firePromptFunc(Prompt) end
if Drop then
local DropPrompt = Drop:FindFirstChildWhichIsA("ProximityPrompt", true)
if DropPrompt and firePromptFunc then firePromptFunc(DropPrompt) end
end
else
if Drop then
local DropPrompt = Drop:FindFirstChildWhichIsA("ProximityPrompt", true)
if DropPrompt and firePromptFunc then firePromptFunc(DropPrompt) end
end
if firePromptFunc then firePromptFunc(Prompt) end
end
Prompt:SetAttribute("InfItems", nil)
Prompt:SetAttribute("Tool", nil)
Prompt.Enabled = true
Prompt.ClickablePrompt = true
end)
else
Prompt:SetAttribute("InfItems", nil)
Prompt:SetAttribute("Tool", nil)
Prompt.Enabled = true
Prompt.ClickablePrompt = true
end
end)
end
else
if Prompt:GetAttribute("InfItems") then
if Prompt.Parent then
local ExistingPrompt = Prompt.Parent:FindFirstChild("InfPrompt")
if ExistingPrompt then
ExistingPrompt:Destroy()
end
end
Prompt:SetAttribute("InfItems", nil)
Prompt:SetAttribute("Tool", nil)
Prompt.Enabled = true
Prompt.ClickablePrompt = true
end
end
end
table.insert(Connections, RunService.RenderStepped:Connect(function(dt)
if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") or not LocalPlayer.Character:FindFirstChild("Humanoid") then
return
end
if Toggles.AutoMinecart and Toggles.AutoMinecart.Value and Camera:FindFirstChild("MinecartRig") then
if LatestRoom and LatestRoom.Value < 49 then
if not LocalPlayer:GetAttribute("NotifyMinecart") then
Notify("[Auto Minecart] DONT MOVE", 5)
LocalPlayer:SetAttribute("NotifyMinecart", true)
end
local Root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
if Root then
local ClosestDuckDist = math.huge
for _, v in pairs(DuckBoards) do
local Dist = GetDistanceToPlayer(v:GetPivot().Position)
if Dist < ClosestDuckDist then ClosestDuckDist = Dist end
end
if RequiredMainGame and RequiredMainGame.crouching ~= (ClosestDuckDist < 30) then
RequiredMainGame.crouching = (ClosestDuckDist < 30)
end
local CurrentNode = nil
local MinDist = math.huge
for _, Node in pairs(Nodes) do
if Node:GetAttribute("ForceConnect") then
local Dist = (Root.Position - Node.Position).Magnitude
if Dist < MinDist then
MinDist = Dist
CurrentNode = Node
end
end
end
if CurrentNode then
local CurrentNum = tonumber(string.match(CurrentNode.Name, "%d+"))
if CurrentNum then
local Node1
for _, Node in pairs(Nodes) do
if Node.Name == "MinecartNode" .. tostring(CurrentNum + 3) then
Node1 = Node
break
end
end
if Node1 then
local DistToNode = GetDistanceToPlayer(CurrentNode.Position)
local controls = require(LocalPlayer.PlayerScripts.PlayerModule):GetControls()
if DistToNode > 30 then
controls.GetMoveVector = function()
return Vector3.new(0, 0, -1)
end
else
local DirectionToNode = (CurrentNode.Position - Node1.Position).Unit
local Dot = DirectionToNode:Dot(CurrentNode.CFrame.RightVector)
controls.GetMoveVector = function()
if Dot > 0.15 then
return Vector3.new(1, 0, 0)
elseif Dot < -0.15 then
return Vector3.new(1, 0, 0)
end
return Vector3.new(0, 0, -1)
end
end
end
end
end
end
elseif LatestRoom and LatestRoom.Value >= 50 then
if LocalPlayer:GetAttribute("NotifyMinecart") then
Notify("[Auto Minecart] YOU CAN MOVE", 5)
LocalPlayer:SetAttribute("NotifyMinecart", false)
end
if Toggles.AutoMinecart then Toggles.AutoMinecart:SetValue(false) end
if DefaultMoveControl then
pcall(function()
require(LocalPlayer.PlayerScripts.PlayerModule):GetControls().GetMoveVector = DefaultMoveControl
end)
end
end
end
if Toggles.AutoRooms and Toggles.AutoRooms.Value then
if Toggles.IgnoreA60 and Toggles.IgnoreA60.Value and Toggles.Godmode and not Toggles.Godmode.Value then
Toggles.Godmode:SetValue(true)
Notify("Godmode Enabled Automatically For Ignore A-60", 4)
end
if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Collision") then
LocalPlayer.Character.Collision.Size = Vector3.new(1, 1, 3)
end
local DangerousEntity = workspace:FindFirstChild("A120") or workspace:FindFirstChild("GlitchRush") or workspace:FindFirstChild("GlitchAmbush")
local A60 = workspace:FindFirstChild("A60")
local ShouldHide = false
if DangerousEntity and DangerousEntity.PrimaryPart and DangerousEntity.PrimaryPart.Position.Y > -4 then
ShouldHide = true
elseif A60 and A60.PrimaryPart and A60.PrimaryPart.Position.Y > -4 then
if not (Toggles.IgnoreA60 and Toggles.IgnoreA60.Value) then
ShouldHide = true
end
end
if ShouldHide then
local Closet = GetNearestHidingSpot()
if Closet then
if Closet:FindFirstChild("Base") then Closet.Base.CanCollide = false end
PathTo(Closet:GetPivot().Position)
local prompt = Closet:FindFirstChildWhichIsA("ProximityPrompt", true)
if prompt and Firepp then
Firepp(prompt)
end
end
else
if LocalPlayer.Character then LocalPlayer.Character:SetAttribute("Hiding", false) end
local currentRoomNum = LocalPlayer:GetAttribute("CurrentRoom")
local currentRoomsFolder = workspace:FindFirstChild("CurrentRooms")
if currentRoomsFolder and currentRoomNum then
local CurrentRoom = currentRoomsFolder:FindFirstChild(tostring(currentRoomNum))
if CurrentRoom and CurrentRoom:FindFirstChild("Door") and CurrentRoom.Door:FindFirstChild("Door") then
PathTo(CurrentRoom.Door.Door.Position)
end
end
end
end
if Toggles.ExitClosetFast and Toggles.ExitClosetFast.Value then
local char = LocalPlayer.Character
if char and char:GetAttribute("Hiding") then
char:SetAttribute("Hiding", false)
if char:FindFirstChild("HumanoidRootPart") then
char.HumanoidRootPart.Anchored = false
end
pcall(function()
local mainUI = LocalPlayer.PlayerGui:FindFirstChild("MainUI")
if mainUI then
local initiator = mainUI:FindFirstChild("Initiator", true)
if initiator then
local mainGame = initiator:FindFirstChild("Main_Game", true)
if mainGame then
local remoteListener = mainGame:FindFirstChild("RemoteListener", true)
if remoteListener then
for _, remote in ipairs(remoteListener:GetChildren()) do
if remote.Name == "Interact" or remote.Name == "Interact_" then
if remote:IsA("RemoteEvent") then
remote:FireServer()
end
end
end
end
end
end
end
end)
end
end
if Toggles.DeleteFigureFE and Toggles.DeleteFigureFE.Value and #Figures > 0 then
for _, v in ipairs(Figures) do
if v and v.Parent then
local Root = v:FindFirstChild("Root")
local isOwnerFunc = ExecutorSupport and ExecutorSupport.isnetworkowner or isnetworkowner
if Root and isOwnerFunc and isOwnerFunc(Root) then
if Root:FindFirstChild("BodyForce") then
Root.BodyForce.Force = Vector3.new(0, -50000, 0)
else
v:PivotTo(CFrame.new(0, -50000, 0))
end
for _, part in ipairs(v:GetDescendants()) do
if part:IsA("BasePart") then
part.CanCollide = false
part.Anchored = false
end
end
if Root.Position.Y < -1000 and not v:GetAttribute("Deleted") then
Notify("Deleted Figure Successfully!", 4)
v:SetAttribute("Deleted", true)
end
end
end
end
end
SolveAnchors()
if Toggles.NotifyLibraryCode and Toggles.NotifyLibraryCode.Value then
if LatestRoom and LatestRoom.Value == 50 then
local Code = GetLibraryCode()
if Code and not LocalPlayer:GetAttribute("LastNotifiedCode") or LocalPlayer:GetAttribute("LastNotifiedCode") ~= Code then
LocalPlayer:SetAttribute("LastNotifiedCode", Code)
Notify("Library Code: " .. Code, 5)
end
end
end
if Toggles.InfRevive and Toggles.InfRevive.Value then
if LocalPlayer:GetAttribute("Alive") == false then
if RemotesFolder:FindFirstChild("Revive") then
RemotesFolder.Revive:FireServer()
end
end
end
if LocalPlayer.Character and not LocalPlayer.Character:FindFirstChild("CollisionClone") then
local cp = LocalPlayer.Character:FindFirstChild("CollisionPart")
if cp then
CollisionClone = cp:Clone()
CollisionClone.Name = "CollisionClone"
CollisionClone.Parent = LocalPlayer.Character
CollisionClone.RootPriority = 127
CollisionClone.Anchored = false
CollisionClone.CanCollide = false
local weld = CollisionClone:FindFirstChildWhichIsA("Weld") or CollisionClone:FindFirstChildWhichIsA("WeldConstraint") or CollisionClone:FindFirstChildWhichIsA("Motor6D")
if weld then
weld.Part0 = LocalPlayer.Character:FindFirstChild("HumanoidRootPart") or cp
weld.Part1 = CollisionClone
end
local crouch = CollisionClone:FindFirstChild("CollisionCrouch")
if crouch then
crouch:Destroy()
end
end
end
if Toggles.AutoInteract and Toggles.AutoInteract.Value then
AutoInteractTimer = AutoInteractTimer + (dt or 0.016)
local interactDelay = Options.AutoInteractDelay and Options.AutoInteractDelay.Value or 0.05
if AutoInteractTimer > interactDelay then
AutoInteractTimer = 0
if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
local hrpPos = LocalPlayer.Character.HumanoidRootPart.Position
local reachDist = Options.AutoInteractreach and Options.AutoInteractreach.Value or 7
local fireppFunc = Firepp or fireproximityprompt
for i = #Interactions, 1, -1 do
local prompt = Interactions[i]
if not prompt or not prompt.Parent then
table.remove(Interactions, i)
continue
end
if (prompt.Parent.Name == "GoldPile" and Floor and Floor.Value == "Fools") or prompt.Parent.Name == "KeyObtainFake" then
continue
end
if prompt.Parent.Parent and prompt.Parent.Parent.Parent and prompt.Parent.Parent.Parent.Name == "ItemSpawns" then
continue
end
if prompt:GetAttribute("InfItems") and prompt.Name ~= "InfPrompt" then
continue
end
if prompt.Parent.Name == "Mandrake" then
continue
end
if prompt:GetAttribute("Interactions") and prompt:GetAttribute("Interactions") > 0 then
table.remove(Interactions, i)
continue
end
if prompt.Parent:IsA("BasePart") or prompt.Parent:IsA("Model") then
local TargetPart = prompt.Parent:IsA("BasePart") and prompt.Parent or (prompt.Parent.PrimaryPart or prompt.Parent:FindFirstChildWhichIsA("BasePart"))
if TargetPart then
if (hrpPos - TargetPart.Position).Magnitude <= reachDist then
if not prompt.Enabled then
prompt.Enabled = true
end
if fireppFunc then
fireppFunc(prompt)
else
prompt:InputHoldBegin()
prompt:InputHoldEnd(prompt.HoldDuration or 0)
end
end
end
end
end
end
end
end
if Options.AutoInteractKeybind then
if Options.AutoInteractKeybind:GetState() and not Toggles.AutoInteract.Value then
Toggles.AutoInteract:SetValue(true)
elseif not Options.AutoInteractKeybind:GetState() and Toggles.AutoInteract.Value then
Toggles.AutoInteract:SetValue(false)
end
end
if Toggles.AutoPickUpGold and Toggles.AutoPickUpGold.Value then
local goldChar = LocalPlayer.Character
local goldHRP = goldChar and goldChar:FindFirstChild("HumanoidRootPart")
if goldHRP then
local goldRange = Options.GoldPickupRange and Options.GoldPickupRange.Value or 15
local fireppFunc = Firepp or fireproximityprompt
local currentRoomsFolder = workspace:FindFirstChild("CurrentRooms")
if currentRoomsFolder then
for _, room in ipairs(currentRoomsFolder:GetChildren()) do
for _, v in ipairs(room:GetDescendants()) do
if v.Name == "GoldPile" then
local prompt = v:FindFirstChildWhichIsA("ProximityPrompt", true)
if prompt and prompt.Enabled then
local targetPart = v:FindFirstChildWhichIsA("BasePart") or v.PrimaryPart
if targetPart then
local dist = (goldHRP.Position - targetPart.Position).Magnitude
if dist <= goldRange then
if fireppFunc then
fireppFunc(prompt)
else
prompt:InputHoldBegin()
prompt:InputHoldEnd(0)
end
end
end
end
end
end
end
end
end
end
local Char = LocalPlayer.Character
local HRP = Char.HumanoidRootPart
local Hum = Char.Humanoid
Camera = workspace.CurrentCamera
local LightingService = game:GetService("Lighting")
local InfItemsToggle = Toggles and Toggles.InfItems
local InfCrucifixToggle = Toggles and Toggles.InfCrucifix
InfItemsDelay += 0.0166666667
if InfItemsToggle and InfItemsToggle.Value and InfItemsDelay > 0.15 then
InfItemsDelay = 0
for _, Prompt in pairs(Stored) do
InfPrompt(Prompt)
end
end
if InfCrucifixToggle and InfCrucifixToggle.Value and (not Toggles.Godmode or not Toggles.Godmode.Value) then
local Origin = HRP.Position
for _, Entity in pairs(workspace:GetChildren()) do
local Range = InfCrucfixTable[Entity.Name]
if Range and Entity.PrimaryPart then
local Target = Entity.PrimaryPart.Position
if (Origin - Target).Magnitude < Range then
InfParams.FilterDescendantsInstances = {Char, Entity}
if not workspace:Raycast(Origin, Target - Origin, InfParams) then
local Tool = Char:FindFirstChild("Crucifix")
if Tool then
RemotesFolder.DropItem:FireServer(Tool)
repeat task.wait()
local dropsFolder = workspace:FindFirstChild("Drops")
local Drop = dropsFolder and dropsFolder:FindFirstChild("Crucifix")
local dropPrompt = Drop and Drop:FindFirstChildOfClass("ProximityPrompt")
if dropPrompt then
if Firepp then Firepp(dropPrompt) elseif fireproximityprompt then fireproximityprompt(dropPrompt) end
end
until Char:FindFirstChild("Crucifix")
end
end
end
end
end
end
if Char and Hum then
if Char:GetAttribute("Climbing") and Toggles.EnableClimbingSpeed and Toggles.EnableClimbingSpeed.Value then
if Hum.WalkSpeed ~= Options.ClimbingSpeed.Value then
Hum.WalkSpeed = Options.ClimbingSpeed.Value
end
elseif not Char:GetAttribute("Climbing") and Toggles.EnableMovementSpeed and Toggles.EnableMovementSpeed.Value then
if Hum.WalkSpeed ~= Options.MovementSpeed.Value then
Hum.WalkSpeed = Options.MovementSpeed.Value
end
end
end
if Toggles.Flight and Toggles.Flight.Value then
if not HRP:FindFirstChild("FlightVelocity") then
local Velocity = Instance.new("BodyVelocity", HRP)
Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
Velocity.Velocity = Vector3.zero
Velocity.Name = "FlightVelocity"
Velocity.P = math.huge
end
if OldAccel then
HRP.CustomPhysicalProperties = OldAccel
end
local moveDir = Hum.MoveDirection
local flatLook = Camera.CFrame.LookVector * Vector3.new(1, 0, 1)
if flatLook.Magnitude < 0.001 then
flatLook = Camera.CFrame.UpVector * Vector3.new(1, 0, 1) * math.sign(-Camera.CFrame.LookVector.Y)
end
local flatCam = CFrame.lookAt(Vector3.zero, flatLook)
local localInput = flatCam:VectorToObjectSpace(moveDir)
if HRP:FindFirstChild("FlightVelocity") then
HRP.FlightVelocity.Velocity = Camera.CFrame:VectorToWorldSpace(localInput) * Options.FlightSpeed.Value
end
end
if Toggles.NoAcc and Toggles.NoAcc.Value then
if not (Toggles.Flight and Toggles.Flight.Value) then
if HRP.CustomPhysicalProperties ~= PhysicalProperties.new(100, 0.1, 0.1, 0.1, 0.1) then
HRP.CustomPhysicalProperties = PhysicalProperties.new(100, 0.1, 0.1, 0.1, 0.1)
end
end
end
if Toggles.EnableJump and Toggles.EnableJump.Value then
if not Char:GetAttribute("CanJump") then
Char:SetAttribute("CanJump", true)
end
end
if Toggles.AutoLibraryCode and Toggles.AutoLibraryCode.Value then
if LatestRoom and LatestRoom.Value == 50 then
local Code = GetLibraryCode()
if Code then
if Toggles.BruteForceLibCode and Toggles.BruteForceLibCode.Value and string.find(Code, "_") then
local Bruted = ""
for i = 1, #Code do
local char = string.sub(Code, i, i)
Bruted ..= (char == "_" and math.random(0, 9) or char)
end
Code = Bruted
end
if PL then
PL:FireServer(Code)
end
end
end
end
if Toggles and Toggles.EyesDamage and Toggles.EyesDamage.Value then
if workspace:FindFirstChild("Eyes") and not Char:GetAttribute("Hiding") then
if MotorReplication then
if RemotesFolder.Name ~= "RemotesFolder" then
MotorReplication:FireServer(0, -650, 0, false)
else
MotorReplication:FireServer(-650)
end
end
end
end
if Toggles and Toggles.LookmanDamage and Toggles.LookmanDamage.Value then
if (workspace:FindFirstChild("Lookman") or workspace:FindFirstChild("BackdoorLookman")) and not Char:GetAttribute("Hiding") then
if MotorReplication then
MotorReplication:FireServer(-650)
end
end
end
if Toggles.Godmode and Toggles.Godmode.Value then
if RemotesFolder.Name == "RemotesFolder" then
if Toggles.FigureHearing and not Toggles.FigureHearing.Value then
Notify("Enabled Figure Hearing Automaticlly cause Godmode needs it", 3)
Toggles.FigureHearing:SetValue(true)
end
if Char:FindFirstChild("LowerTorso") and Char.LowerTorso:FindFirstChild("Root") and Char.LowerTorso.Root:IsA("Motor6D") then
pcall(function()
if Char.LowerTorso.Root.C1 ~= CFrame.new(0, -2.3, 0) then
Char.LowerTorso.Root.C1 = CFrame.new(0, -2.3, 0)
end
end)
end
if Hum.HipHeight ~= 0.22 then
Hum.HipHeight = 0.22
end
if Char:FindFirstChild("Collision") then
if Char.Collision.Size ~= Vector3.new(1, 1, 4) then
Char.Collision.Size = Vector3.new(1, 1, 4)
end
if Char.Collision:FindFirstChild("CollisionCrouch") and Char.Collision.CollisionCrouch.Size ~= Vector3.new(1, 1, 4) then
Char.Collision.CollisionCrouch.Size = Vector3.new(1, 1, 4)
end
end
if GodmodeAnchorPos and HRP then
if math.abs(HRP.Position.Y - GodmodeAnchorPos) > 1 then
HRP.Velocity = Vector3.new(HRP.Velocity.X, 0, HRP.Velocity.Z)
HRP.CFrame = CFrame.new(HRP.Position.X, GodmodeAnchorPos, HRP.Position.Z) * HRP.CFrame.Rotation
end
end
else
if Char:FindFirstChild("Collision") and HRP then
local targetY = HRP.Position.Y - 4
if math.abs(Char.Collision.Position.Y - targetY) > 0.1 then
Char.Collision.Position = Vector3.new(HRP.Position.X, targetY, HRP.Position.Z)
end
end
if GodmodeAnchorPos and HRP then
if math.abs(HRP.Position.Y - GodmodeAnchorPos) > 1 then
HRP.Velocity = Vector3.new(HRP.Velocity.X, 0, HRP.Velocity.Z)
HRP.CFrame = CFrame.new(HRP.Position.X, GodmodeAnchorPos, HRP.Position.Z) * HRP.CFrame.Rotation
end
end
end
end
if (Floor and (Floor.Value == "Fools" or RemotesFolder.Name == "Bricks")) and Toggles.NoClip and not Toggles.NoClip.Value then
Toggles.NoClip:SetValue(true)
end
if Toggles.AntiCheatMani and Toggles.AntiCheatMani.Value then
if Options.AntiCheatManiMethod and Options.AntiCheatManiMethod.Value == "Velocity" then
if Toggles.NoClip and not Toggles.NoClip.Value then
Toggles.NoClip:SetValue(true)
ManipulationNoClipForced = true
end
	local BodyVelocity = HRP:FindFirstChild("VelocityMani") or Instance.new("BodyVelocity", HRP)
	BodyVelocity.Name = "VelocityMani"
	BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
	local LookingVector = HRP.CFrame.LookVector * 4
	BodyVelocity.Velocity = Vector3.new(LookingVector.X, LookingVector.Y, LookingVector.Z)
else
local currentPivot = Char:GetPivot()
Char:PivotTo(currentPivot * CFrame.new(0, 0, 10000))
end
else
if HRP:FindFirstChild("VelocityMani") then
HRP.VelocityMani:Destroy()
end
if ManipulationNoClipForced and Toggles.NoClip and Toggles.NoClip.Value then
Toggles.NoClip:SetValue(false)
end
ManipulationNoClipForced = false
end
if Toggles.NoClip and Toggles.NoClip.Value then
for _, v in ipairs(Char:GetChildren()) do
if v:IsA("BasePart") and v.Name ~= "CollisionClone" and v.CanCollide then
v.CanCollide = false
end
end
if Char:FindFirstChild("Collision") then
Char.Collision.CanCollide = false
if Char.Collision:FindFirstChild("CollisionCrouch") then
Char.Collision.CollisionCrouch.CanCollide = false
end
end
else
for _, v in pairs(Char:GetChildren()) do
if v.Name ~= "CollisionClone" and v.Name ~= "Collision" then
if v:IsA("BasePart") and not v.CanCollide then
v.CanCollide = true
end
end
end
if Char:FindFirstChild("Collision") then
Char.Collision.CanCollide = (Char.Collision.CollisionGroup == "PlayerCrouching" and false or Char.Collision.CollisionGroup ~= "PlayerCrouching" and true)
if Char.Collision:FindFirstChild("CollisionCrouch") then
Char.Collision.CollisionCrouch.CanCollide = Char.Collision.CanCollide
end
end
end
if Toggles and Toggles.DoorReach and Toggles.DoorReach.Value then
local now = os.clock()
if now - lastDoorReachCheck >= 0.2 then
lastDoorReachCheck = now
local gameData = ReplicatedStorage:FindFirstChild("GameData")
local latestRoomVal = gameData and gameData:FindFirstChild("LatestRoom")
if latestRoomVal and workspace:FindFirstChild("CurrentRooms") then
local roomObj = workspace.CurrentRooms:FindFirstChild(tostring(latestRoomVal.Value))
if roomObj and roomObj:FindFirstChild("Door") then
local Door = roomObj.Door
if Door and Door.Parent and Door.Parent.Name ~= "101" then
local doorPart = Door:FindFirstChild("Door") or Door.PrimaryPart or Door:FindFirstChildWhichIsA("BasePart", true)
if doorPart and doorPart.Position then
local dist = GetDistanceToPlayer(doorPart.Position)
if dist and dist < 30 then
local clientOpen = Door:FindFirstChild("ClientOpen")
if clientOpen then
clientOpen:FireServer()
end
end
end
end
end
end
end
end
if Options.FOV then
Camera.FieldOfView = Options.FOV.Value
end
local isThirdPerson = Toggles.ThirdPerson and Toggles.ThirdPerson.Value
local isFreecam = Toggles.Freecam and Toggles.Freecam.Value
for _, v in ipairs(Char:GetChildren()) do
if v:IsA("BasePart") and (v.Name == "Head" or v.Name == "FakeHead") then
v.LocalTransparencyModifier = (isThirdPerson or isFreecam) and 0 or 1
elseif v:IsA("Accessory") then
local handle = v:FindFirstChild("Handle")
if handle then
handle.LocalTransparencyModifier = (isThirdPerson or isFreecam) and 0 or 1
end
end
end
if isThirdPerson then
Camera.CFrame = Camera.CFrame * CFrame.new(Options.X.Value, Options.Y.Value, Options.Z.Value)
end
if isFreecam then
Camera.CameraType = Enum.CameraType.Scriptable
if HRP and not HRP.Anchored then HRP.Anchored = true end
if not getgenv().FreecamCFrame then
getgenv().FreecamCFrame = Camera.CFrame
end
local speed = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) and 1.5 or 0.6
local moveVec = Vector3.zero
if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveVec += Vector3.new(0, 0, -1) end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveVec += Vector3.new(0, 0, 1) end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveVec += Vector3.new(-1, 0, 0) end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveVec += Vector3.new(1, 0, 0) end
if UserInputService:IsKeyDown(Enum.KeyCode.E) or UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveVec += Vector3.new(0, 1, 0) end
if UserInputService:IsKeyDown(Enum.KeyCode.Q) then moveVec += Vector3.new(0, -1, 0) end
local delta = UserInputService:GetMouseDelta()
local yaw = CFrame.Angles(0, -math.rad(delta.X * 0.3), 0)
local pitch = CFrame.Angles(-math.rad(delta.Y * 0.3), 0, 0)
getgenv().FreecamCFrame = CFrame.new(getgenv().FreecamCFrame.Position) * yaw * getgenv().FreecamCFrame.Rotation * pitch
local worldMove = getgenv().FreecamCFrame:VectorToWorldSpace(moveVec)
getgenv().FreecamCFrame = getgenv().FreecamCFrame + (worldMove * speed)
Camera.CFrame = getgenv().FreecamCFrame
end
if Toggles.NoCamShake and Toggles.NoCamShake.Value then
if RequiredMainGame and RequiredMainGame.csgo then
RequiredMainGame.csgo = CFrame.identity
end
if Hum then
Hum.CameraOffset = Vector3.zero
end
end
local latestRoomVal = ReplicatedStorage:FindFirstChild("GameData") and ReplicatedStorage.GameData:FindFirstChild("LatestRoom")
if latestRoomVal and latestRoomVal.Value == 100 then
if Toggles.NoScenes and Toggles.NoScenes.Value then
Toggles.NoScenes:SetValue(false)
end
end
if Toggles.NoFog and Toggles.NoFog.Value then
if LightingService.FogEnd < 100000 then
LightingService.FogEnd = 100000
end
for _, v in pairs(LightingService:GetChildren()) do
if v:IsA("Atmosphere") and v.Density > 0 then
v.Density = 0
end
end
end
if Toggles.FullBright and Toggles.FullBright.Value then
if LightingService.Ambient ~= Color3.new(1, 1, 1) then
LightingService.Ambient = Color3.new(1, 1, 1)
end
local currentRoomNum = LocalPlayer:GetAttribute("CurrentRoom")
local currentRoomsFolder = workspace:FindFirstChild("CurrentRooms")
if currentRoomNum and currentRoomsFolder then
local curRoom = currentRoomsFolder:FindFirstChild(tostring(currentRoomNum))
if curRoom then
if not curRoom:GetAttribute("OldAmbient") then
curRoom:SetAttribute("OldAmbient", curRoom:GetAttribute("Ambient") or Color3.new(0, 0, 0))
end
curRoom:SetAttribute("Ambient", Color3.new(1, 1, 1))
end
local nextRoom = currentRoomsFolder:FindFirstChild(tostring(currentRoomNum + 1))
if nextRoom then
if not nextRoom:GetAttribute("OldAmbient") then
nextRoom:SetAttribute("OldAmbient", nextRoom:GetAttribute("Ambient") or Color3.new(0, 0, 0))
end
nextRoom:SetAttribute("Ambient", Color3.new(1, 1, 1))
end
end
end
if Options.NoclipKeybind and Options.NoclipKeybind:GetState() and not Toggles.NoClip.Value then
Toggles.NoClip:SetValue(true)
elseif Options.NoclipKeybind and not Options.NoclipKeybind:GetState() and Toggles.NoClip.Value then
Toggles.NoClip:SetValue(false)
end
if Options.ThirdpersonKeybind then
if Options.ThirdpersonKeybind:GetState() and not Toggles.ThirdPerson.Value then
Toggles.ThirdPerson:SetValue(true)
elseif not Options.ThirdpersonKeybind:GetState() and Toggles.ThirdPerson.Value then
Toggles.ThirdPerson:SetValue(false)
end
end
if Options.FreecamKeybind then
if Options.FreecamKeybind:GetState() and not Toggles.Freecam.Value then
Toggles.Freecam:SetValue(true)
elseif not Options.FreecamKeybind:GetState() and Toggles.Freecam.Value then
Toggles.Freecam:SetValue(false)
end
end
end))
table.insert(Connections, workspace.DescendantAdded:Connect(function(v)
	if HidingPlaces[v.Name] then
		table.insert(Closets, v)
	end
	CheckAndNotifyEntity(v)
	if v.Name == "FigureRig" or v.Name == "FigureRagdoll" then
if Toggles.DeleteFigureFE and Toggles.DeleteFigureFE.Value then
table.insert(Figures, v)
end
end
if v.Name == "MinesAnchor" then
if Toggles.AutoAnchorSolver and Toggles.AutoAnchorSolver.Value then
table.insert(Anchors, v)
end
end
if v.Name == "SeekGuidingLight" and Toggles.ShowPath and Toggles.ShowPath.Value then
ShowSeekPath(v)
end
if v.Name == "SeekFloodline" and Toggles.AntiSeekFlood and Toggles.AntiSeekFlood.Value then
v.CanCollide = true
end
if v.Name == "BananaPeel" and Toggles.AntiBanana and Toggles.AntiBanana.Value then
v.CanTouch = false
end
if v.Name == "JeffTheKiller" and Toggles.AntiJeff and Toggles.AntiJeff.Value then
task.spawn(function()
for _, i in ipairs(v:GetChildren()) do
if i:IsA("BasePart") then i.CanTouch = false end
end
if v:FindFirstChildOfClass("Humanoid") then
v:FindFirstChildOfClass("Humanoid").Health = 0
end
end)
end

if (v.Name == "Seek_Arm" or v.Name == "ChandelierObstruction") and Toggles.SeekObf and Toggles.SeekObf.Value then
for _, i in ipairs(v:GetChildren()) do
if i:IsA("BasePart") then i.CanTouch = false end
end
end
if v.Name == "Lava" and Toggles.AntiLava and Toggles.AntiLava.Value then
v.CanTouch = false
end
if v.Name == "ScaryWall" and Toggles.AntiWall and Toggles.AntiWall.Value then
for _, i in ipairs(v:GetChildren()) do
if i:IsA("BasePart") then i.CanTouch = false end
end
end
if Toggles.AutoMinecart and Toggles.AutoMinecart.Value then
if v.Name == "DuckBoard" then
table.insert(DuckBoards, v)
end
if string.find(v.Name, "MinecartNode") then
table.insert(Nodes, v)
end
end
if v.Name == "Bridge" and Toggles.FixBrokenBridge and Toggles.FixBrokenBridge.Value then
task.spawn(function()
task.wait(0.1)
FixBridge(v)
end)
end
if v:IsA("ProximityPrompt") then
if not (PromptIgnore[v.Name] or (v.Parent and v.Parent.Name == "Padlock") or (v.Parent and v.Parent:GetAttribute("JeffShop"))) or (v.Parent and v.Parent.Name == "RetroWardrobe") then
if not table.find(Interactions, v) then
table.insert(Interactions, v)
end
end
if Toggles.InstaInteract and Toggles.InstaInteract.Value then
v:SetAttribute("Duration", v.HoldDuration)
v.HoldDuration = 0
end
if Toggles.InfItems and Toggles.InfItems.Value then
if IsInfItemTarget(v) then
if not table.find(Stored, v) then
table.insert(Stored, v)
end
end
end
end
if Toggles and Toggles.Objective and Toggles.Objective.Value then
local name = v.Name
if ObjectiveItems[name] or name == "MinesAnchor" then
local currentRoomNum = LocalPlayer:GetAttribute("CurrentRoom")
if currentRoomNum then
local currentRoomsFolder = workspace:FindFirstChild("CurrentRooms")
if currentRoomsFolder then
local curRoom = currentRoomsFolder:FindFirstChild(tostring(currentRoomNum))
local nextRoom = currentRoomsFolder:FindFirstChild(tostring(currentRoomNum + 1))
if (curRoom and v:IsDescendantOf(curRoom)) or (nextRoom and v:IsDescendantOf(nextRoom)) then
AddObjectiveESPToObject(v)
end
end
end
end
end
if Toggles.Snare and Toggles.Snare.Value and v.Name == "Snare" then
task.spawn(function()
local hb = v:WaitForChild("Hitbox", 3)
if hb then hb.CanTouch = false end
end)
end
if Toggles.Giggle and Toggles.Giggle.Value and v.Name == "GiggleCeiling" then
task.spawn(function()
local hb = v:WaitForChild("Hitbox", 3)
if hb then hb.CanTouch = false end
end)
end
if Toggles.Dupe and Toggles.Dupe.Value then
if v.Name == "DoorFake" and v.Parent and v.Parent.Name == "SideroomDupe" then
local hidden = v:FindFirstChild("Hidden")
if hidden then hidden.CanTouch = false end
end
end
if Toggles.GloomEggDamage and Toggles.GloomEggDamage.Value and v.Name == "GloomEgg" then
task.spawn(function()
for _, i in ipairs(v:GetChildren()) do
if i:IsA("BasePart") then i.CanTouch = false end
end
end)
end
if Toggles.AntiLag and Toggles.AntiLag.Value then
if v:IsA("BasePart") then
v:SetAttribute("Mat", v.Material)
v.Material = Enum.Material.Plastic
end
end
if Toggles.AutoBreaker and Toggles.AutoBreaker.Value then
					if v.Name == "ElevatorBreaker" then
						Breaker(v)
					end
				end
				if v.Name == "ForgetMeNotVineDoors" and v:IsA("Model") then
					if Toggles.EnableESP and Toggles.EnableESP.Value and ((Toggles.VineDoors and Toggles.VineDoors.Value) or (Toggles.FlowerDoors and Toggles.FlowerDoors.Value)) then
						task.delay(0.5, function()
							SetupVineDoorEvents(v)
							RefreshVineDoorESPForModel(v)
						end)
					end
				end
				if v.Name == "PaperPlanePickup" and v:IsA("Model") then
					if Toggles.EnableESP and Toggles.EnableESP.Value and Toggles.PaperPlane and Toggles.PaperPlane.Value then
						task.delay(0.3, function()
							local plane = v:FindFirstChild("Plane")
							if plane and not PaperPlaneESPs[v] then
								local planeColor = Options.PaperPlaneColor and Options.PaperPlaneColor.Value or Color3.fromRGB(255, 200, 100)
								PaperPlaneESPs[v] = true
								ESPLibrary:AddESP({ Object = plane, Text = "Paper Plane", Color = planeColor })
							end
						end)
					end
				end
end))
table.insert(Connections, workspace.DescendantRemoving:Connect(function(v)
local closetIndex = table.find(Closets, v)
if closetIndex then
table.remove(Closets, closetIndex)
end
if v:IsA("ProximityPrompt") then
local index = table.find(Stored, v)
if index then table.remove(Stored, index) end
local intIndex = table.find(Interactions, v)
if intIndex then table.remove(Interactions, intIndex) end
end
if ActiveCurrentRoomESPs[v] then
ActiveCurrentRoomESPs[v] = nil
if ESPLibrary then ESPLibrary:RemoveESP(v) end
end
if GlobalEntityESPs[v] then
GlobalEntityESPs[v] = nil
if ESPLibrary then ESPLibrary:RemoveESP(v) end
end
if ActiveObjectiveESPs[v] then
			RemoveObjectiveESP(v)
		end
		if v.Name == "ForgetMeNotVineDoors" and v:IsA("Model") then
			for _, child in ipairs(v:GetDescendants()) do
				if VineDoorESPs[child] then
					if ESPLibrary then ESPLibrary:RemoveESP(child) end
					VineDoorESPs[child] = nil
				end
			end
			if VineDoorEventConns[v] then
				for _, conn in ipairs(VineDoorEventConns[v]) do
					if conn and conn.Connected then conn:Disconnect() end
				end
				VineDoorEventConns[v] = nil
			end
		end
		if v.Name == "PaperPlanePickup" and v:IsA("Model") then
		if PaperPlaneESPs[v] then
				if ESPLibrary then ESPLibrary:RemoveESP(v) end
				PaperPlaneESPs[v] = nil
			end
		end
end))
AutoBox:AddToggle("AutoInteract", {
Text = "Auto Interact",
Default = false,
Tooltip = "Automatically Interacts with things when near",
Callback = function(Value)
if Value then
table.clear(Interactions)
local currentRoomsFolder = workspace:FindFirstChild("CurrentRooms")
if currentRoomsFolder then
for _, v in ipairs(currentRoomsFolder:GetDescendants()) do
if v:IsA("ProximityPrompt") then
if not (PromptIgnore[v.Name] or (v.Parent and v.Parent.Name == "Padlock") or (v.Parent and v.Parent:GetAttribute("JeffShop"))) or (v.Parent and v.Parent.Name == "RetroWardrobe") or (v.Parent and v.Parent.Name == "KeyObtainFake") then
table.insert(Interactions, v)
end
end
end
end
else
table.clear(Interactions)
end
end
}):AddKeyPicker("AutoInteractKeybind", {
Default = "R",
SyncToggleState = true,
Mode = Library.IsMobile and "Toggle" or "Hold",
Text = "Auto Interact"
})
AutoBox:AddSlider("AutoInteractDelay", {
Text = "Auto Interact Delay",
Default = 0,
Min = 0,
Max = 0.2,
Rounding = 2,
Compact = false,
Callback = function() end
})
AutoBox:AddSlider("AutoInteractreach", {
Text = "Auto Interact Range",
Default = 12,
Min = 7,
Max = 12,
Rounding = 2,
Compact = false,
Callback = function() end
})
AutoBox:AddDivider()
AutoBox:AddToggle('AutoLibraryCode', { Text = "Auto Library Code", Default = false, Callback = function() end })
AutoBox:AddToggle('BruteForceLibCode', { Text = "Bruteforce Library Code", Default = false, Callback = function() end })
AutoBox:AddToggle('AutoHeartbeat', { Text = "Auto Heartbeat Minigame", Default = false, Callback = function() end })
AutoBox:AddToggle('AutoPickUpGold', {
Text = "Auto Pick Up Gold",
Default = false,
Tooltip = "Automatically picks up nearby gold piles",
}):AddKeyPicker("AutoPickUpGoldKeybind", {
Default = "U",
SyncToggleState = true,
Mode = "Toggle",
Text = "Auto Pick Up Gold",
})
AutoBox:AddSlider("GoldPickupRange", {
Text = "Gold Pickup Range",
Default = 15,
Min = 5,
Max = 30,
Rounding = 0,
Compact = false,
Callback = function() end
})
AutoBox:AddDivider()
local function SolveBreaker(breaker)
if not breaker or not breaker.Parent then return end
local surfaceGui = breaker:FindFirstChild("SurfaceGui", true)
if not surfaceGui then return end
local frame = surfaceGui:FindFirstChild("Frame", true)
if not frame then return end
local codeLabel = frame:FindFirstChild("Code", true)
if not codeLabel then return end
local targetNum = tonumber(codeLabel.Text)
if not targetNum then return end
local indicatorFrame = codeLabel:FindFirstChild("Frame")
local shouldBeOn = indicatorFrame and (indicatorFrame.BackgroundTransparency == 0) or false
for _, switch in ipairs(breaker:GetChildren()) do
if switch.Name == "BreakerSwitch" and switch:GetAttribute("ID") == targetNum then
local pc = switch:FindFirstChild("PrismaticConstraint")
local light = switch:FindFirstChild("Light")
local sound = switch:FindFirstChild("Sound")
if shouldBeOn then
if not switch:GetAttribute("Enabled") then
switch:SetAttribute("Enabled", true)
if pc then pc.TargetPosition = -0.2 end
if light then
light.Material = Enum.Material.Neon
local spark = light:FindFirstChild("Spark", true)
if spark then spark:Emit(1) end
end
if sound then sound:Play() end
end
else
if switch:GetAttribute("Enabled") then
switch:SetAttribute("Enabled", false)
if pc then pc.TargetPosition = 0.2 end
if light then light.Material = Enum.Material.Glass end
if sound then sound:Play() end
end
end
break
end
end
end
AutoBox:AddToggle('AutoBreaker', {
Text = "Auto Breaker Minigame",
Disabled = Floor and (Floor.Value == "Mines" or Floor.Value == "Retro" or Floor.Value == "Outdoors") or false,
Default = false,
Callback = function() end
})
task.spawn(function()
while task.wait(0.1) do
if Toggles and Toggles.AutoBreaker and Toggles.AutoBreaker.Value then
local breakerObj = workspace:FindFirstChild("ElevatorBreaker", true)
if breakerObj then
SolveBreaker(breakerObj)
end
end
end
end)
task.spawn(function()
	while task.wait(1) do
		pcall(function()
			if Library and Library.Unloaded then return end
			if not (Toggles.EnableESP and Toggles.EnableESP.Value) then return end
			if (Toggles.VineDoors and Toggles.VineDoors.Value) or (Toggles.FlowerDoors and Toggles.FlowerDoors.Value) then
				local function RescanVineDoors(parent)
					for _, v in ipairs(parent:GetDescendants()) do
						if v.Name == "ForgetMeNotVineDoors" and v:IsA("Model") then
							if not VineDoorEventConns[v] then
								SetupVineDoorEvents(v)
							end
							RefreshVineDoorESPForModel(v)
						end
					end
				end
				local currentRooms = workspace:FindFirstChild("CurrentRooms")
				if currentRooms then RescanVineDoors(currentRooms) end
				RescanVineDoors(workspace)
			end
			if Toggles.PaperPlane and Toggles.PaperPlane.Value then
				local function RescanPlanes(parent)
					for _, v in ipairs(parent:GetDescendants()) do
						if v.Name == "PaperPlanePickup" and v:IsA("Model") then
							if not PaperPlaneESPs[v] then
								local plane = v:FindFirstChild("Plane")
								if plane then
									local planeColor = Options.PaperPlaneColor and Options.PaperPlaneColor.Value or Color3.fromRGB(255, 200, 100)
									PaperPlaneESPs[v] = true
									ESPLibrary:AddESP({ Object = plane, Text = "Paper Plane", Color = planeColor })
								end
							end
						end
					end
				end
				local currentRooms = workspace:FindFirstChild("CurrentRooms")
				if currentRooms then RescanPlanes(currentRooms) end
				RescanPlanes(workspace)
			end
		end)
	end
end)
ReachBox:AddToggle('DoorReach', {
Text = "Door Reach",
Default = false,
Callback = function() end
})
BypassEntityBox:AddToggle('Screech', {
Text = "Anti Screech Damage",
Default = false,
Callback = function(Value)
if Value then
gotToggled = true
if RemotesFolder:FindFirstChild("Screech") then
RemotesFolder.Screech.Name = "Screech_"
end
FakeScreech.Name = "Screech"
else
if gotToggled then
if RemotesFolder:FindFirstChild("Screech_") then
RemotesFolder["Screech_"].Name = "Screech"
end
FakeScreech.Name = "Screech_"
end
end
end
})
local HookMeta = hookmetamethod or hookfunction
if HookMeta then
local Old
Old = hookmetamethod(game, "__namecall", function(Self, ...)
if Library and Library.Unloaded then
return Old(Self, ...)
end
local Method = getnamecallmethod()
if Method == "FireServer" or Method == "InvokeServer" then
if Toggles.AutoHeartbeat and Toggles.AutoHeartbeat.Value and Self.Name == "ClutchHeartbeat" then
return Old(Self, true)
end
if Method == "FireServer" and Self.Name == "Crouch" then
local isSpeedBypass = Toggles.BypassSpeed and Toggles.BypassSpeed.Value
local isFigHearing = Toggles.FigureHearing and Toggles.FigureHearing.Value
if isSpeedBypass or isFigHearing then
return Old(Self, true, true)
end
end
end
return Old(Self, ...)
end)
end
BypassEntityBox:AddToggle('A90', {
Text = "Anti A90 Damage",
Default = false,
Callback = function(Value)
if Value then
gotToggled2 = true
if RemotesFolder:FindFirstChild("A90") then
RemotesFolder.A90.Name = "A90_"
end
FakeA90.Name = "A90"
else
if gotToggled2 then
if RemotesFolder:FindFirstChild("A90_") then
RemotesFolder["A90_"].Name = "A90"
end
FakeA90.Name = "A90_"
end
end
end
})
BypassEntityBox:AddToggle('Dread', {
Text = "Anti Dread",
Default = false,
Callback = function(Value)
local DreadObj = LocalPlayer:FindFirstChild("Dread", true) or LocalPlayer:FindFirstChild("_Dread", true)
if DreadObj then
DreadObj.Name = Value and "_Dread" or "Dread"
end
end
})
BypassEntityBox:AddToggle('Halt', {
Text = "Anti Halt",
Default = false,
Callback = function(Value)
if ClientModules and ClientModules:FindFirstChild("EntityModules") then
local ShadeObj = ClientModules.EntityModules:FindFirstChild("Shade", true) or ClientModules.EntityModules:FindFirstChild("_Shade", true)
if ShadeObj then
ShadeObj.Name = Value and "_Shade" or "Shade"
end
end
end
})
BypassEntityBox:AddToggle('Jamming', {
Text = "Anti Jamming",
Default = false,
Callback = function(Value)
pcall(function()
local mainUI = LocalPlayer:FindFirstChild("PlayerGui") and LocalPlayer.PlayerGui:FindFirstChild("MainUI")
if mainUI then
local jam = mainUI:FindFirstChild("Initiator", true) and mainUI.Initiator:FindFirstChild("Main_Game", true) and mainUI.Initiator.Main_Game:FindFirstChild("Health", true) and mainUI.Initiator.Main_Game.Health:FindFirstChild("Jam")
if jam and Value then jam.Playing = false end
end
local jammingSound = game:GetService("SoundService"):FindFirstChild("Main") and game:GetService("SoundService").Main:FindFirstChild("Jamming")
if jammingSound then
if Value then
jammingSound.Enabled = false
else
jammingSound.Enabled = IsJamminModifierActive()
end
end
end)
end
})
BypassEntityBox:AddToggle('BypassSurgeDamage', {
Text = "Anti Surge Damage",
Default = false,
Callback = function(Value)
if Value then
if RemotesFolder:FindFirstChild("SurgeRemote") then
RemotesFolder.SurgeRemote.Parent = ReplicatedStorage
Surge.Parent = RemotesFolder
end
else
if ReplicatedStorage:FindFirstChild("SurgeRemote") then
ReplicatedStorage.SurgeRemote.Parent = RemotesFolder
Surge.Parent = ReplicatedStorage
end
end
end
})
BypassEntityBox:AddToggle('Snare', {
Text = "Anti Snare",
Default = false,
Callback = function(Value)
if workspace:FindFirstChild("CurrentRooms") then
for _, v in pairs(workspace.CurrentRooms:GetDescendants()) do
if v.Name == "Snare" and v:FindFirstChild("Hitbox") then
v.Hitbox.CanTouch = not Value
end
end
end
end
})
BypassEntityBox:AddToggle('Giggle', {
Text = "Anti Giggle",
Default = false,
Disabled = Floor and Floor.Value == "Fools" and RemotesFolder.Name == "Bricks" and true or false,
Callback = function(Value)
if workspace:FindFirstChild("CurrentRooms") then
for _, v in pairs(workspace.CurrentRooms:GetDescendants()) do
if v.Name == "GiggleCeiling" and v:FindFirstChild("Hitbox") then
v.Hitbox.CanTouch = not Value
end
end
end
end
})
BypassEntityBox:AddToggle('Dupe', {
Text = "Anti Dupe",
Default = false,
Callback = function(Value)
if workspace:FindFirstChild("CurrentRooms") then
for _, v in pairs(workspace.CurrentRooms:GetDescendants()) do
if v.Name == "DoorFake" and v.Parent and v.Parent.Name == "SideroomDupe" then
local hidden = v:FindFirstChild("Hidden")
if hidden then hidden.CanTouch = not Value end
end
end
end
end
})

BypassEntityBox:AddToggle('EyesDamage', {
Text = "Anti Eyes Damage",
Default = false,
Callback = function() end
})
BypassEntityBox:AddToggle('LookmanDamage', {
Text = "Anti Lookman Damage",
Default = false,
Callback = function() end
})
BypassEntityBox:AddToggle('GloomEggDamage', {
Text = "Anti Gloom Egg",
Default = false,
Callback = function(Value)
if workspace:FindFirstChild("CurrentRooms") then
for _, v in ipairs(workspace.CurrentRooms:GetDescendants()) do
if v.Name == "GloomEgg" or v.Name == "GloomPile" then
for _, p in ipairs(v:GetDescendants()) do
if p:IsA("BasePart") then
p.CanTouch = not Value
end
end
end
end
end
end
})
BypassEntityBox:AddToggle('FigureHearing', {
Text = "Anti Figure Hearing",
Default = false,
Disabled = Floor and Floor.Value == "Fools" and true or false,
DisabledTooltip = "This floor wont support this feature",
Callback = function(Value)
if RemotesFolder:FindFirstChild("Crouch") then
local speedBypassOn = Toggles.BypassSpeed and Toggles.BypassSpeed.Value
if not speedBypassOn then
if Value then
RemotesFolder.Crouch:FireServer(true, true)
else
RemotesFolder.Crouch:FireServer(false, false)
end
end
end
end
})
BypassEntityBox:AddToggle('AntiLag', {
Text = "Anti Lag",
Default = false,
Callback = function(Value)
if workspace:FindFirstChild("CurrentRooms") then
for _, v in pairs(workspace.CurrentRooms:GetDescendants()) do
if v:IsA("BasePart") then
if Value then
if not v:GetAttribute("Mat") then
v:SetAttribute("Mat", v.Material)
end
v.Material = Enum.Material.Plastic
else
if v:GetAttribute("Mat") then
v.Material = v:GetAttribute("Mat")
end
end
end
end
end
end
})
BypassEntityBox:AddLabel('Anti Lag if it Lags you Turn it off', true)
BypassEntityBox:AddToggle('AntiDrones', {
	Text = "Anti Drones",
	Default = false,
})
BypassBox:AddToggle('BypassSpeed', {
Text = "Speed Bypass",
Default = false,
Callback = function(Value)
Options.MovementSpeed:SetMax(Value and 75 or 21)
Options.FlightSpeed:SetMax(Value and 75 or 21)
end
})
BypassBox:AddDivider()
BypassBox:AddDropdown("AntiCheatManiMethod", { Values = { "Velocity", "Anticheat" }, Default = 1, Text = "Manipulation Method", Callback = function() end })
BypassBox:AddToggle('AntiCheatMani', { Text = "Manipulation", Default = false, Callback = function() end }):AddKeyPicker("AntiCheatMan", { Default = "V", SyncToggleState = true, Mode = "Hold", Text = "Manipulation" })
BypassBox:AddDivider()
BypassBox:AddLabel("Infinite Crucfix Only Works on A-60 A-120 Rush And Ambush and it have a chance to fail so take it at your own risk", true)
BypassBox:AddToggle('InfCrucifix', {
Text = "Infinite Crucifix",
Risky = true,
Default = false,
Callback = function() end
})
BypassBox:AddDivider()
BypassBox:AddLabel("Works ONLY with Auto Interact Highly sensitive, breaks easily", true)
BypassBox:AddToggle('InfItems', {
Text = "Infinite Items",
Risky = true,
Default = false,
Tooltip = "Works ONLY with Auto Interact Highly sensitive, breaks easily",
Callback = function(Value)
if Value then
if workspace:FindFirstChild("CurrentRooms") then
for _, v in pairs(workspace.CurrentRooms:GetDescendants()) do
if v:IsA("ProximityPrompt") then
if IsInfItemTarget(v) then
if not table.find(Stored, v) then
table.insert(Stored, v)
end
end
end
end
end
else
if workspace:FindFirstChild("CurrentRooms") then
for _, Prompt in pairs(workspace.CurrentRooms:GetDescendants()) do
if Prompt:IsA("ProximityPrompt") then
if Prompt:GetAttribute("InfItems") then
local Fake = Prompt.Parent and Prompt.Parent:FindFirstChild("InfPrompt")
if Fake then
Fake:Destroy()
end
Prompt:SetAttribute("InfItems", nil)
Prompt:SetAttribute("Tool", nil)
Prompt.Enabled = true
Prompt.ClickablePrompt = true
end
end
end
end
table.clear(Stored)
end
end
})
table.insert(Connections, LocalPlayer.CharacterAdded:Connect(function()
if CollisionClone then
CollisionClone = nil
end
end))
task.spawn(function()
while task.wait(0.05) do
if Library and Library.Unloaded then break end
if Toggles.BypassSpeed and Toggles.BypassSpeed.Value then
if CollisionClone and CollisionClone.Parent then
CollisionClone.Massless = true
end
if RemotesFolder and RemotesFolder:FindFirstChild("Crouch") then
RemotesFolder.Crouch:FireServer(true, true)
end
end
end
end)
CameraBox:AddSlider("FOV", { Text = "FOV", Default = 70, Min = 70, Max = 120, Rounding = 1, Compact = false, Callback = function() end })
CameraBox:AddDivider()
CameraBox:AddToggle('ThirdPerson', {
Text = "Third Person",
Default = false,
Callback = function(Value)
if not Value and LocalPlayer.Character then
for _, v in pairs(LocalPlayer.Character:GetChildren()) do
if v:IsA("BasePart") and (v.Name == "Head" or v.Name == "FakeHead") then
v.Transparency = 0
v.LocalTransparencyModifier = 0
elseif v:IsA("Accessory") and v:FindFirstChild("Handle") then
v.Handle.Transparency = 0
v.Handle.LocalTransparencyModifier = 0
end
end
end
end
}):AddKeyPicker("ThirdpersonKeybind", { Default = "T", SyncToggleState = true, Mode = "Toggle", Text = "Third Person" })
CameraBox:AddSlider("X", { Text = "X", Default = 2, Min = -10, Max = 10, Rounding = 1, Compact = false, Callback = function() end })
CameraBox:AddSlider("Y", { Text = "Y", Default = 0, Min = -10, Max = 10, Rounding = 1, Compact = false, Callback = function() end })
CameraBox:AddSlider("Z", { Text = "Z", Default = 4, Min = -10, Max = 10, Rounding = 1, Compact = false, Callback = function() end })
CameraBox:AddToggle('NoCamShake', { Text = "No Camera Shake", Default = false, Callback = function() end })
CameraBox:AddToggle('Freecam', {
Text = "Freecam",
Default = false,
Callback = function(Value)
local char = LocalPlayer.Character
local hrp = char and char:FindFirstChild("HumanoidRootPart")
if Value then
if hrp then hrp.Anchored = true end
workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
getgenv().FreecamCFrame = workspace.CurrentCamera.CFrame
else
if hrp then hrp.Anchored = false end
workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
if char and char:FindFirstChildOfClass("Humanoid") then
workspace.CurrentCamera.CameraSubject = char:FindFirstChildOfClass("Humanoid")
end
end
end
}):AddKeyPicker("FreecamKeybind", { Default = "B", SyncToggleState = true, Mode = "Toggle", Text = "Freecam" })
CameraBox:AddToggle('NoScenes', {
Text = "No Cutscenes",
Default = false,
Callback = function(Value)
local latestRoom = ReplicatedStorage:FindFirstChild("GameData") and ReplicatedStorage.GameData:FindFirstChild("LatestRoom")
if latestRoom and latestRoom.Value == 100 and Value then
Notify("No Cutscenes disabled for Room 100 to prevent softlock", 3)
task.spawn(function()
Toggles.NoScenes:SetValue(false)
end)
return
end
pcall(function()
local mainUI = LocalPlayer.PlayerGui:FindFirstChild("MainUI")
local remoteListener = mainUI and mainUI.Initiator.Main_Game:FindFirstChild("RemoteListener")
if remoteListener then
for _, v in ipairs(remoteListener:GetChildren()) do
if v.Name == "Cutscenes" or v.Name == "Cutscenes_" then
v.Name = Value and "Cutscenes_" or "Cutscenes"
end
end
end
end)
end
})
LightingBox:AddToggle('NoFog', {
Text = "No Fog",
Default = false,
Callback = function(Value)
if not Value then
for _, v in pairs(Lighting:GetChildren()) do
if v:IsA("Atmosphere") then
v.Density = 0.94
end
end
if OldFogEnd then
Lighting.FogEnd = OldFogEnd
OldFogEnd = nil
end
else
OldFogEnd = Lighting.FogEnd
end
end
})
LightingBox:AddToggle('FullBright', {
Text = "Fullbright",
Default = false,
Callback = function(Value)
if not Value then
Lighting.Ambient = Color3.fromRGB(0, 0, 0)
Lighting.GlobalShadows = true
local currentRoomsFolder = workspace:FindFirstChild("CurrentRooms")
if currentRoomsFolder then
for _, v in pairs(currentRoomsFolder:GetChildren()) do
if v:GetAttribute("OldAmbient") then
v:SetAttribute("Ambient", v:GetAttribute("OldAmbient"))
end
end
end
end
end
})
ESPBox:AddToggle('EnableESP', {
Text = "Enable ESP",
Default = false,
Callback = function(Value)
if Value then
if Toggles.Door and Toggles.Door.Value then UpdateDoorESP() end
if Toggles.Objective and Toggles.Objective.Value then UpdateObjectiveESP() end
if Toggles.Entity and Toggles.Entity.Value then
UpdateCurrentRoomESPs()
for _, v in ipairs(workspace:GetChildren()) do
AddGlobalEntityESP(v)
end
end
if Toggles.Books and Toggles.Books.Value then UpdateCurrentRoomESPs() end
if Toggles.Breakers and Toggles.Breakers.Value then UpdateCurrentRoomESPs() end
if Toggles.Gold and Toggles.Gold.Value then UpdateCurrentRoomESPs() end
if Toggles.Ladder and Toggles.Ladder.Value then UpdateCurrentRoomESPs() end
if Toggles.Fuse and Toggles.Fuse.Value then UpdateCurrentRoomESPs() end
if Toggles.HidingPlace and Toggles.HidingPlace.Value then UpdateCurrentRoomESPs() end
if Toggles.GateLever and Toggles.GateLever.Value then UpdateCurrentRoomESPs() end
            if Toggles.Player and Toggles.Player.Value then PlayerESPModule:RefreshAll() end
            if Toggles.VineDoors and Toggles.VineDoors.Value then UpdateVineDoorESP() end
            if Toggles.FlowerDoors and Toggles.FlowerDoors.Value then UpdateVineDoorESP() end
            if Toggles.PaperPlane and Toggles.PaperPlane.Value then UpdatePaperPlaneESP() end
            if Toggles.FloorLoot and Toggles.FloorLoot.Value then UpdateFloorLootESP() end
            if Toggles.Locker and Toggles.Locker.Value then UpdateLockerESP() end
            if Toggles.Toolbox and Toggles.Toolbox.Value then UpdateToolboxESP() end
            if Toggles.Drones and Toggles.Drones.Value then UpdateDronesESP() end
        else
            ClearAllDoorESP()
            ClearAllObjectiveESP()
            ClearCurrentRoomESPs()
            ClearGlobalEntityESPs()
            ClearVineDoorESP()
            ClearPaperPlaneESP()
            ClearFloorLootESP()
            ClearLockerESP()
            ClearToolboxESP()
            ClearDronesESP()
for _, player in ipairs(Players:GetPlayers()) do
if player ~= LocalPlayer and player.Character then
ESPLibrary:RemoveESP(player.Character)
end
end
end
end
}):AddKeyPicker("EnableESPKeybind", {
Default = "J",
SyncToggleState = true,
Mode = "Toggle",
Text = "Enable ESP",
})
ESPBox:AddToggle('Door', {
Text = "Door",
Default = false,
Callback = function(Value)
if not (Toggles.EnableESP and Toggles.EnableESP.Value) then ClearAllDoorESP() return end
if Value then UpdateDoorESP() else ClearAllDoorESP() end
end
}):AddColorPicker("ColorPicker2", {
Default = Color3.fromRGB(0, 255, 0),
Title = "Door Color",
Callback = function() if Toggles.EnableESP and Toggles.EnableESP.Value and Toggles.Door and Toggles.Door.Value then UpdateDoorESP() end end
})
ESPBox:AddToggle('Objective', {
Text = "Objective",
Default = false,
Callback = function(Value)
if not (Toggles.EnableESP and Toggles.EnableESP.Value) then ClearAllObjectiveESP() return end
if Value then UpdateObjectiveESP() else ClearAllObjectiveESP() end
end
}):AddColorPicker("ColorPicker3", {
Default = Color3.fromRGB(0, 120, 255),
Title = "Objective Color",
Callback = function() if Toggles.EnableESP and Toggles.EnableESP.Value and Toggles.Objective and Toggles.Objective.Value then UpdateObjectiveESP() end end
})
ESPBox:AddToggle('HidingPlace', {
Text = "Hiding Place",
Default = false,
Callback = function() if Toggles.EnableESP and Toggles.EnableESP.Value then UpdateCurrentRoomESPs() else ClearCurrentRoomESPs() end end
}):AddColorPicker("ColorPicker4", {
Default = HidingPlaceColor,
Title = "Hiding Place Color",
Callback = function(Value) HidingPlaceColor = Value; if Toggles.EnableESP and Toggles.EnableESP.Value then UpdateCurrentRoomESPs() end end
})
ESPBox:AddToggle('GateLever', {
Text = "Gate Lever",
Default = false,
Callback = function() if Toggles.EnableESP and Toggles.EnableESP.Value then UpdateCurrentRoomESPs() else ClearCurrentRoomESPs() end end
}):AddColorPicker("ColorPicker5", {
Default = Color3.fromRGB(128, 128, 128),
Title = "Lever Color",
Callback = function() if Toggles.EnableESP and Toggles.EnableESP.Value then UpdateCurrentRoomESPs() end end
})
ESPBox:AddToggle('Books', {
Text = "Library Book",
Default = false,
Callback = function() if Toggles.EnableESP and Toggles.EnableESP.Value then UpdateCurrentRoomESPs() else ClearCurrentRoomESPs() end end
}):AddColorPicker("ColorPicker6", {
Default = Color3.fromRGB(0, 0, 128),
Title = "Book Color",
Callback = function() if Toggles.EnableESP and Toggles.EnableESP.Value then UpdateCurrentRoomESPs() end end
})
ESPBox:AddToggle('Breakers', {
Text = "Breaker",
Default = false,
Callback = function() if Toggles.EnableESP and Toggles.EnableESP.Value then UpdateCurrentRoomESPs() else ClearCurrentRoomESPs() end end
}):AddColorPicker("ColorPicker7", {
Default = Color3.fromRGB(128, 255, 128),
Title = "Breaker Color",
Callback = function() if Toggles.EnableESP and Toggles.EnableESP.Value then UpdateCurrentRoomESPs() end end
})
ESPBox:AddToggle('Gold', {
Text = "Gold",
Default = false,
Callback = function() if Toggles.EnableESP and Toggles.EnableESP.Value then UpdateCurrentRoomESPs() else ClearCurrentRoomESPs() end end
}):AddColorPicker("ColorPicker8", {
Default = Color3.fromRGB(255, 255, 0),
Title = "Gold Color",
Callback = function() if Toggles.EnableESP and Toggles.EnableESP.Value then UpdateCurrentRoomESPs() end end
})
ESPBox:AddToggle('Entity', {
Text = "Entity",
Default = false,
Callback = function(Value)
if not (Toggles.EnableESP and Toggles.EnableESP.Value) then ClearGlobalEntityESPs() return end
if Value then
UpdateCurrentRoomESPs()
for _, v in ipairs(workspace:GetChildren()) do
AddGlobalEntityESP(v)
end
else
ClearGlobalEntityESPs()
UpdateCurrentRoomESPs()
end
end
}):AddColorPicker("ColorPicker9", {
Default = Color3.fromRGB(255, 0, 0),
Title = "Entity Color",
Callback = function()
if Toggles.EnableESP and Toggles.EnableESP.Value and Toggles.Entity and Toggles.Entity.Value then
ClearGlobalEntityESPs()
UpdateCurrentRoomESPs()
end
end
})
ESPBox:AddToggle('Ladder', {
Text = "Ladder",
Default = false,
Callback = function() if Toggles.EnableESP and Toggles.EnableESP.Value then UpdateCurrentRoomESPs() else ClearCurrentRoomESPs() end end
}):AddColorPicker("ColorPicker10", {
Default = Color3.fromRGB(0, 0, 255),
Title = "Ladder Color",
Callback = function() if Toggles.EnableESP and Toggles.EnableESP.Value then UpdateCurrentRoomESPs() end end
})
ESPBox:AddToggle('Fuse', {
Text = "Fuse",
Default = false,
Callback = function() UpdateCurrentRoomESPs() end
}):AddColorPicker("ColorPicker11", {
Default = Color3.fromRGB(255, 170, 0),
Title = "Fuse Color",
Callback = function() UpdateCurrentRoomESPs() end
})
local PlayerESPModule = {
CharConnections = {}
}
function PlayerESPModule:UpdatePlayerESP(player)
if not (Toggles.EnableESP and Toggles.EnableESP.Value) then
if player and player.Character then
ESPLibrary:RemoveESP(player.Character)
end
return
end
if not (Toggles.Player and Toggles.Player.Value) then
if player and player.Character then
ESPLibrary:RemoveESP(player.Character)
end
return
end
if not player or player == LocalPlayer then return end
local char = player.Character
if not char then return end
local hum = char:FindFirstChildOfClass("Humanoid")
if hum and hum.Health > 0 then
local maxHp = math.max(hum.MaxHealth, 1)
local currentHp = math.clamp(hum.Health, 0, maxHp)
local hpPercent = math.floor((currentHp / maxHp) * 100)
local color = Options.ColorPicker99 and Options.ColorPicker99.Value or PlayerColor or Color3.fromRGB(255, 255, 255)
local text = string.format("%s [%d%%]", player.Name, hpPercent)
ESPLibrary:AddESP({
Object = char,
Text = text,
Color = color
})
else
ESPLibrary:RemoveESP(char)
end
end
function PlayerESPModule:ClearCharConnections(userId)
if self.CharConnections[userId] then
for _, conn in ipairs(self.CharConnections[userId]) do
if conn and conn.Connected then
conn:Disconnect()
end
end
self.CharConnections[userId] = nil
end
end
function PlayerESPModule:TrackCharacter(player, char)
if not player or player == LocalPlayer or not char then return end
local userId = player.UserId
self:ClearCharConnections(userId)
self.CharConnections[userId] = {}
local hum = char:FindFirstChildOfClass("Humanoid") or char:WaitForChild("Humanoid", 5)
if hum then
local hpConn = hum.HealthChanged:Connect(function()
self:UpdatePlayerESP(player)
end)
local maxHpConn = hum:GetPropertyChangedSignal("MaxHealth"):Connect(function()
self:UpdatePlayerESP(player)
end)
table.insert(self.CharConnections[userId], hpConn)
table.insert(self.CharConnections[userId], maxHpConn)
end
self:UpdatePlayerESP(player)
end
function PlayerESPModule:TrackPlayer(player)
if not player or player == LocalPlayer then return end
if player.Character then
task.spawn(function()
self:TrackCharacter(player, player.Character)
end)
end
local charAddedConn = player.CharacterAdded:Connect(function(char)
self:TrackCharacter(player, char)
end)
local charRemovingConn = player.CharacterRemoving:Connect(function(char)
ESPLibrary:RemoveESP(char)
self:ClearCharConnections(player.UserId)
end)
table.insert(Connections, charAddedConn)
table.insert(Connections, charRemovingConn)
end
function PlayerESPModule:RefreshAll()
for _, player in ipairs(Players:GetPlayers()) do
if player ~= LocalPlayer then
self:UpdatePlayerESP(player)
end
end
end
function PlayerESPModule:Init()
table.insert(Connections, Players.PlayerAdded:Connect(function(player)
self:TrackPlayer(player)
end))
table.insert(Connections, Players.PlayerRemoving:Connect(function(player)
if player.Character then
ESPLibrary:RemoveESP(player.Character)
end
self:ClearCharConnections(player.UserId)
end))
for _, player in ipairs(Players:GetPlayers()) do
if player ~= LocalPlayer then
self:TrackPlayer(player)
end
end
end
ESPBox:AddToggle('Player', {
Text = "Player",
Default = false,
Callback = function() PlayerESPModule:RefreshAll() end
}):AddColorPicker("ColorPicker99", {
Default = Color3.fromRGB(255, 255, 255),
Title = "Player ESP Color",
Callback = function(Value)
PlayerColor = Value
PlayerESPModule:RefreshAll()
end,
})
PlayerESPModule:Init()
ESPBox:AddDivider()
ESPBox:AddToggle('VineDoors', {
	Text = "Vine Doors",
	Default = false,
	Callback = function() if Toggles.EnableESP and Toggles.EnableESP.Value then UpdateVineDoorESP() else ClearVineDoorESP() end end
}):AddColorPicker("VineDoorColor", {
	Default = Color3.fromRGB(0, 255, 128),
	Title = "Vine Door Color",
	Callback = function() if Toggles.EnableESP and Toggles.EnableESP.Value and Toggles.VineDoors and Toggles.VineDoors.Value then UpdateVineDoorESP() end end
})
ESPBox:AddToggle('FlowerDoors', {
	Text = "Flower Doors",
	Default = false,
	Callback = function() if Toggles.EnableESP and Toggles.EnableESP.Value then UpdateVineDoorESP() else ClearVineDoorESP() end end
}):AddColorPicker("FlowerDoorColor", {
	Default = Color3.fromRGB(255, 105, 180),
	Title = "Flower Door Color",
	Callback = function() if Toggles.EnableESP and Toggles.EnableESP.Value and Toggles.FlowerDoors and Toggles.FlowerDoors.Value then UpdateVineDoorESP() end end
})
ESPBox:AddToggle('VineDoorAnomalyDetection', {
	Text = "Door Anomaly Detection",
	Default = true,
	Tooltip = "Detects if vine/flower door is Anomaly or Safe",
	Callback = function() if Toggles.EnableESP and Toggles.EnableESP.Value and (Toggles.VineDoors or Toggles.FlowerDoors) then UpdateVineDoorESP() end end
}):AddColorPicker("VineDoorAnomalyColor", {
	Default = Color3.fromRGB(255, 0, 0),
	Title = "Anomaly Color",
	Callback = function() if Toggles.EnableESP and Toggles.EnableESP.Value then UpdateVineDoorESP() end end
}):AddColorPicker("VineDoorSafeColor", {
	Default = Color3.fromRGB(0, 255, 0),
	Title = "Safe Color",
	Callback = function() if Toggles.EnableESP and Toggles.EnableESP.Value then UpdateVineDoorESP() end end
})
ESPBox:AddDivider()
	ESPBox:AddToggle('PaperPlane', {
	Text = "Paper Plane",
	Default = false,
	Callback = function() if Toggles.EnableESP and Toggles.EnableESP.Value then UpdatePaperPlaneESP() else ClearPaperPlaneESP() end end
}):AddColorPicker("PaperPlaneColor", {
	Default = Color3.fromRGB(255, 200, 100),
	Title = "Paper Plane Color",
	Callback = function() if Toggles.EnableESP and Toggles.EnableESP.Value and Toggles.PaperPlane and Toggles.PaperPlane.Value then UpdatePaperPlaneESP() end end
})
ESPBox:AddToggle('FloorLoot', {
	Text = "Floor Loot",
	Default = false,
	Callback = function() if Toggles.EnableESP and Toggles.EnableESP.Value then UpdateFloorLootESP() else ClearFloorLootESP() end end
}):AddColorPicker("FloorLootColor", {
	Default = Color3.fromRGB(255, 165, 0),
	Title = "Floor Loot Color",
	Callback = function() if Toggles.EnableESP and Toggles.EnableESP.Value and Toggles.FloorLoot and Toggles.FloorLoot.Value then UpdateFloorLootESP() end end
})
ESPBox:AddToggle('Locker', {
	Text = "Locker",
	Default = false,
	Callback = function() if Toggles.EnableESP and Toggles.EnableESP.Value then UpdateLockerESP() else ClearLockerESP() end end
}):AddColorPicker("LockerColor", {
	Default = Color3.fromRGB(100, 200, 255),
	Title = "Locker Color",
	Callback = function() if Toggles.EnableESP and Toggles.EnableESP.Value and Toggles.Locker and Toggles.Locker.Value then UpdateLockerESP() end end
})
ESPBox:AddToggle('Toolbox', {
	Text = "Toolbox",
	Default = false,
	Callback = function() if Toggles.EnableESP and Toggles.EnableESP.Value then UpdateToolboxESP() else ClearToolboxESP() end end
}):AddColorPicker("ToolboxColor", {
	Default = Color3.fromRGB(255, 180, 50),
	Title = "Toolbox Color",
	Callback = function() if Toggles.EnableESP and Toggles.EnableESP.Value and Toggles.Toolbox and Toggles.Toolbox.Value then UpdateToolboxESP() end end
})
ESPBox:AddToggle('Drones', {
	Text = "Drones",
	Default = false,
	Callback = function() if Toggles.EnableESP and Toggles.EnableESP.Value then UpdateDronesESP() else ClearDronesESP() end end
}):AddColorPicker("DronesColor", {
	Default = Color3.fromRGB(200, 50, 255),
	Title = "Drones Color",
	Callback = function() if Toggles.EnableESP and Toggles.EnableESP.Value and Toggles.Drones and Toggles.Drones.Value then UpdateDronesESP() end end
})
ESPSettings:AddToggle('ShowDistance', {
Text = "Show ESP Distance",
Default = true,
Callback = function(Value)
if ESPLibrary then ESPLibrary:SetShowDistance(Value) end
end
})
ESPSettings:AddToggle('ShowTracers', {
Text = "Show ESP Tracers",
Default = false,
Callback = function(Value)
if ESPLibrary then ESPLibrary:SetTracers(Value) end
end
})
ESPSettings:AddToggle('ShowRainbow', {
Text = "Show ESP Rainbow",
Default = false,
Callback = function(Value)
ESPLibrary:SetRainbow(Value)
end
})
ESPSettings:AddDropdown("SetESPMode", {
Text = "Set ESP Mode",
Values = {"Highlight/Text", "Text", "Highlight"},
Default = 1,
Callback = function(Value)
if ESPLibrary then ESPLibrary:SetESPMode(Value) end
end
})
ESPSettings:AddDropdown("SetFont", {
Text = "Set Font",
Values = {
"Legacy", "Arial", "ArialBold", "SourceSans", "SourceSansBold",
"SourceSansLight", "SourceSansItalic", "Bodoni", "Garamond",
"Cartoon", "Code", "Highway", "SciFi", "Arcade", "Fantasy",
"Antique", "Gotham", "GothamMedium", "GothamBold", "GothamBlack",
"AmaticSC", "Bangers", "Creepster", "DenkOne", "FredokaOne",
"IndieFlower", "LuckiestGuy", "Michroma", "Nunito", "Oswald",
"PatrickHand", "PermanentMarker", "Roboto", "RobotoCondensed",
"RobotoMono", "Sarpanch", "SpecialElite", "TitilliumWeb", "Ubuntu"
},
Default = "Legacy",
Callback = function(Value)
if ESPLibrary and ESPLibrary.SetFont then
ESPLibrary:SetFont(Value)
end
end
})
NotifyBox:AddDropdown("Notify", {
	Values = { "Rush", "Ambush", "GlitchRush", "GlitchAmbush", "A-60", "A-120", "Eyes", "Blitz", "Lookman", "Jeff", "Screech", "Bash", "Scribbles" },
Default = 1,
Multi = true,
Text = "Choose to Notify",
Callback = function() end
})
NotifyBox:AddToggle('NotifySpawn', {
Text = "Notify Entity",
Default = false,
Tooltip = "Notify Entity On Spawn",
Callback = function(Value)
if Value then
for _, v in ipairs(workspace:GetChildren()) do
CheckAndNotifyEntity(v)
end
for _, v in ipairs(workspace.CurrentCamera:GetChildren()) do
CheckAndNotifyEntity(v)
end
end
end
})
HotelFloor:AddToggle('NotifyLibraryCode', {
Text = "Notify Library Code",
Default = false,
Disabled = Floor and Floor.Value ~= "Hotel" and Floor.Value ~= "Fools" or false,
Callback = function(Value)
if Value and LatestRoom and LatestRoom.Value == 50 then
local Code = GetLibraryCode()
if Code then Notify("Code: " .. Code, 5) end
end
end
})
HotelFloor:AddToggle('SeekObf', {
Text = "Anti Seek Obstacles",
Default = false,
Disabled = Floor and Floor.Value == "Retro" or false,
Callback = function(Value)
if workspace:FindFirstChild("CurrentRooms") then
for _, v in ipairs(workspace.CurrentRooms:GetDescendants()) do
if v.Name == "Seek_Arm" or v.Name == "ChandelierObstruction" then
for _, i in ipairs(v:GetChildren()) do
if i:IsA("BasePart") then
i.CanTouch = not Value
end
end
end
end
end
end
})
MinesFloor:AddToggle('DeleteFigureFE', {
Text = "Delete Figure (FE)",
Default = false,
Disabled = Floor and Floor.Value ~= "Mines" and RemotesFolder.Name ~= "Bricks" or false,
Callback = function(Value)
if Value then
table.clear(Figures)
if workspace:FindFirstChild("CurrentRooms") then
for _, v in ipairs(workspace.CurrentRooms:GetDescendants()) do
if v.Name == "FigureRig" or v.Name == "FigureRagdoll" then
table.insert(Figures, v)
end
end
end
else
table.clear(Figures)
end
end
})
MinesFloor:AddToggle('ShowPath', {
Text = "Show Seek Path",
Default = false,
Disabled = Floor and Floor.Value ~= "Mines" or false,
Callback = function(Value)
if Value then
if workspace:FindFirstChild("CurrentRooms") then
for _, v in ipairs(workspace.CurrentRooms:GetDescendants()) do
if v.Name == "SeekGuidingLight" then
ShowSeekPath(v)
end
end
end
else
if SeekPathFolder then SeekPathFolder:ClearAllChildren() end
end
end
})
MinesFloor:AddToggle('FixBrokenBridge', {
Text = "Fix Broken Bridge",
Default = false,
Disabled = Floor and Floor.Value ~= "Mines" or false,
Callback = function(Value)
if workspace:FindFirstChild("CurrentRooms") then
for _, v in ipairs(workspace.CurrentRooms:GetDescendants()) do
if v.Name == "Bridge" then
if Value then
FixBridge(v)
else
local barrier = v:FindFirstChild("BridgeBarrier")
if barrier then barrier:Destroy() end
end
end
end
end
end
})
MinesFloor:AddToggle('AutoMinecart', {
Text = "Auto Minecart",
Risky = true,
Default = false,
Disabled = Floor and Floor.Value ~= "Mines" or false,
Callback = function(Value)
if Value then
table.clear(DuckBoards)
table.clear(Nodes)
if workspace:FindFirstChild("CurrentRooms") then
for _, v in ipairs(workspace.CurrentRooms:GetDescendants()) do
if v.Name == "DuckBoard" then table.insert(DuckBoards, v) end
if string.find(v.Name, "MinecartNode") then table.insert(Nodes, v) end
end
end
else
if DefaultMoveControl then
pcall(function()
require(LocalPlayer.PlayerScripts.PlayerModule):GetControls().GetMoveVector = DefaultMoveControl
end)
end
table.clear(Nodes)
table.clear(DuckBoards)
end
end
})
MinesFloor:AddToggle('AutoAnchorSolver', {
Text = "Auto Anchor Solver",
Default = false,
Disabled = Floor and Floor.Value ~= "Mines" or false,
Callback = function(Value)
if Value then
table.clear(Anchors)
if workspace:FindFirstChild("CurrentRooms") then
for _, v in ipairs(workspace.CurrentRooms:GetDescendants()) do
if v.Name == "MinesAnchor" then table.insert(Anchors, v) end
end
end
else
table.clear(Anchors)
end
end
})
MinesFloor:AddToggle('AntiSeekFlood', {
Text = "Anti Seek Flood",
Default = false,
Disabled = Floor and Floor.Value ~= "Mines" or false,
Callback = function(Value)
if workspace:FindFirstChild("CurrentRooms") then
for _, v in ipairs(workspace.CurrentRooms:GetDescendants()) do
if v.Name == "SeekFloodline" then v.CanCollide = Value end
end
end
end
})
FoolsFloor:AddToggle('AntiBanana', {
Text = "Anti Banana",
Default = false,
Disabled = Floor and Floor.Value ~= "Fools" and RemotesFolder.Name ~= "Bricks" or false,
Callback = function(Value)
for _, v in ipairs(workspace:GetChildren()) do
if v.Name == "BananaPeel" then v.CanTouch = not Value end
end
end
})
FoolsFloor:AddToggle('AntiJeff', {
Text = "Anti Jeff",
Default = false,
Disabled = Floor and Floor.Value ~= "Fools" and RemotesFolder.Name ~= "Bricks" or false,
Callback = function(Value)
local jf = workspace:FindFirstChild("JeffTheKiller")
if jf then
for _, p in ipairs(jf:GetChildren()) do
if p:IsA("BasePart") then p.CanTouch = not Value end
end
if Value and jf:FindFirstChildOfClass("Humanoid") then
jf:FindFirstChildOfClass("Humanoid").Health = 0
end
end
end
})
FoolsFloor:AddToggle('InfRevive', {
Text = "Infinite Revive",
Default = false,
Disabled = Floor and Floor.Value ~= "Fools" and RemotesFolder.Name ~= "Bricks" or false,
Callback = function(Value)
if Value and LocalPlayer:GetAttribute("Alive") == false then
if RemotesFolder:FindFirstChild("Revive") then
RemotesFolder.Revive:FireServer()
end
end
end
})

RoomsFloor:AddToggle('AutoRooms', {
Text = "Auto A-1000",
Default = false,
Disabled = Floor and Floor.Value ~= "Rooms" or false,
Callback = function(Value)
if not Value then
if PathFolder then PathFolder:ClearAllChildren() end
if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
LocalPlayer.Character.Humanoid:MoveTo(LocalPlayer.Character.HumanoidRootPart.Position)
end
end
end
})
RoomsFloor:AddToggle('IgnoreA60', {
Text = "Ignore A-60",
Default = false,
Disabled = Floor and Floor.Value ~= "Rooms" or false,
Callback = function() end
})
RetroFloor:AddToggle('AntiLava', {
Text = "Anti Lava",
Default = false,
Disabled = Floor and Floor.Value ~= "Retro" or false,
Callback = function(Value)
if workspace:FindFirstChild("CurrentRooms") then
for _, v in ipairs(workspace.CurrentRooms:GetDescendants()) do
if v.Name == "Lava" then v.CanTouch = not Value end
end
end
end
})
RetroFloor:AddToggle('AntiWall', {
Text = "Anti SeekWall",
Default = false,
Disabled = Floor and Floor.Value ~= "Retro" or false,
Callback = function(Value)
if workspace:FindFirstChild("CurrentRooms") then
for _, v in ipairs(workspace.CurrentRooms:GetDescendants()) do
if v.Name == "ScaryWall" then
for _, i in ipairs(v:GetChildren()) do
if i:IsA("BasePart") then i.CanTouch = not Value end
end
end
end
end
end
})
RetroFloor:AddToggle('RealBridge', {
Text = "Show Real Bridge",
Default = false,
Disabled = Floor and Floor.Value ~= "Retro" or false,
Callback = function(Value)
if workspace:FindFirstChild("CurrentRooms") then
for _, v in ipairs(workspace.CurrentRooms:GetDescendants()) do
if v.Name == "Bridge" and v.CanCollide == false then
v.Transparency = Value and 1 or 0
end
end
end
end
})
local MenuGroup = Tabs.Settings:AddLeftGroupbox('UI Settings')
local UtilityBox = Tabs.Settings:AddRightGroupbox('Hub Utilities')
local MenuPicker = MenuGroup:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", {
Default = "RightShift",
NoUI = true,
Text = "Menu keybind"
})
Library.ToggleKeybind = Options.MenuKeybind
function MenuPicker:OnClick()
local Event
Event = game:GetService("UserInputService").InputBegan:Connect(function(Input)
if Input.UserInputType ~= Enum.UserInputType.Keyboard then return end
local Key = Input.KeyCode.Name
if Key == "Escape" then
Event:Disconnect()
self:Update()
return
end
self.Value = Key
self.Modifiers = {}
Event:Disconnect()
self:Update()
if Library and Library.UpdateKeybinds then
Library:UpdateKeybinds()
end
end)
end
MenuGroup:AddToggle("ShowKeybinds", { Text = "Show Keybinds Overlay", Default = false }):OnChanged(function()
if Library.KeybindFrame then
Library.KeybindFrame.Visible = Toggles.ShowKeybinds.Value
end
end)
MenuGroup:AddToggle("ShowCustomCursor", { Text = "Custom Cursor", Default = true, Callback = function(Value)
Library.ShowCustomCursor = Value
pcall(function()
local pg = LocalPlayer:FindFirstChild("PlayerGui")
if pg and pg:FindFirstChild("UmbraCursor") then
pg.UmbraCursor.Enabled = Value
end
end)
end })
MenuGroup:AddDivider()
MenuGroup:AddToggle('PlayNotifySound', { Text = "Play Notification Sound", Default = true, Callback = function(Value) PlaySound = Value end })
MenuGroup:AddDropdown("NotificationSide", { Values = { "Left", "Right" }, Default = "Right", Text = "Notification Side", Callback = function(Value) Library:SetNotifySide(Value) end })
MenuGroup:AddButton('Test Notification', function() Notify("Hello World", 2) end)
MenuGroup:AddDivider()
MenuGroup:AddToggle('AntiAfk', {
Text = "Anti AFK",
Default = false,
Callback = function(Value)
if Value then
if not getgenv().UmbraAntiAfk then
getgenv().UmbraAntiAfk = true
task.spawn(function()
while getgenv().UmbraAntiAfk do
task.wait(math.random(30, 60))
pcall(function()
local VirtualUser = game:GetService("VirtualUser")
VirtualUser:CaptureController()
VirtualUser:ClickButton2(Vector2.new())
end)
end
end)
end
else
getgenv().UmbraAntiAfk = false
end
end
})
MenuGroup:AddDivider()
MenuGroup:AddToggle('ThemeColorToggle', {
Text = "UI Theme Color",
Default = false,
Callback = function() end
}):AddColorPicker("ThemeColor", {
Default = Color3.fromRGB(125, 125, 255),
Title = "Accent Color",
Callback = function(Value)
pcall(function()
Library.Accent = Value
if ThemeManager and ThemeManager.SetTheme then
ThemeManager:SetTheme({Accent = Value})
end
end)
end
})
MenuGroup:AddDropdown("Library", {
Values = { "Obsidian", "Linoria" },
Default = getgenv().ScriptLibrary,
Text = "Library",
Callback = function(Value)
getgenv().ScriptLibrary = tostring(Value)
Notify('Please Unload Script and Execute Again to Take Effect', 4)
end
})
MenuGroup:AddDropdown("RenderESPSpeed", {
Values = { "10", "30", "60", "90", "120", "144", "240" },
Default = Library.IsMobile and 2 or 6,
Text = "ESP Rendering Speed",
Callback = function(Value)
if ESPLibrary and ESPLibrary.SetRenderingSpeed then
ESPLibrary:SetRenderingSpeed(tonumber(Value))
end
end
})
MenuGroup:AddDivider()
MenuGroup:AddDropdown("DPIDropdown", {
Values = { "50%", "75%", "100%", "125%", "150%", "175%", "200%" },
Default = "100%",
Text = "DPI Scale",
Callback = function(Value)
Value = Value:gsub("%%", "")
Library:SetDPIScale(tonumber(Value))
end
})
UtilityBox:AddLabel("Umbra Hub", true)
local InfoGroup = Tabs.Info:AddLeftGroupbox('Credits')
InfoGroup:AddLabel("Umbra Hub v1.0", true)
InfoGroup:AddDivider()
InfoGroup:AddLabel("Credits to Umbra [vynxiscool_1]", true)
InfoGroup:AddLabel("On Discord", true)
InfoGroup:AddDivider()
InfoGroup:AddLabel("AI Hub for helping on the UI", true)
InfoGroup:AddDivider()
InfoGroup:AddLabel("Thank you for using Umbra Hub!", true)
local function UnloadHubLogic()
for _, v in ipairs(workspace:GetChildren()) do
if v.Name == "BananaPeel" then
pcall(function() v.CanTouch = true end)
elseif v.Name == "JeffTheKiller" then
for _, p in ipairs(v:GetChildren()) do
if p:IsA("BasePart") then
pcall(function() p.CanTouch = true end)
end
end
end
end
if PathFolder then pcall(function() PathFolder:Destroy() end) end
if SeekPathFolder then pcall(function() SeekPathFolder:Destroy() end) end
table.clear(Figures)
table.clear(Anchors)
table.clear(DuckBoards)
table.clear(Nodes)
if DefaultMoveControl then
pcall(function()
require(LocalPlayer.PlayerScripts.PlayerModule):GetControls().GetMoveVector = DefaultMoveControl
end)
end
if workspace:FindFirstChild("CurrentRooms") then
for _, v in ipairs(workspace.CurrentRooms:GetDescendants()) do
if v.Name == "BridgeBarrier" then
pcall(function() v:Destroy() end)
end
end
end
for _, v in pairs(Closets) do
if ESPLibrary then ESPLibrary:RemoveESP(v) end
end
table.clear(Closets)
getgenv().FreecamCFrame = nil
if workspace.CurrentCamera then
workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
workspace.CurrentCamera.CameraSubject = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
end
end
if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
LocalPlayer.Character.HumanoidRootPart.Anchored = false
end
if workspace.CurrentCamera then
workspace.CurrentCamera.FieldOfView = 70
end
pcall(function()
local mainUI = LocalPlayer.PlayerGui:FindFirstChild("MainUI")
local remoteListener = mainUI and mainUI.Initiator.Main_Game:FindFirstChild("RemoteListener")
if remoteListener then
for _, v in ipairs(remoteListener:GetChildren()) do
if v.Name == "Cutscenes_" then
v.Name = "Cutscenes"
end
end
end
end)
Lighting.Ambient = OriginalLighting.Ambient
Lighting.OutdoorAmbient = OriginalLighting.OutdoorAmbient
Lighting.Brightness = OriginalLighting.Brightness
Lighting.GlobalShadows = OriginalLighting.GlobalShadows
Lighting.FogEnd = OriginalLighting.FogEnd
local atm = Lighting:FindFirstChildOfClass("Atmosphere")
if atm and OriginalLighting.AtmosphereDensity then
atm.Density = OriginalLighting.AtmosphereDensity
end
local currentRoomsFolder = workspace:FindFirstChild("CurrentRooms")
if currentRoomsFolder then
for _, v in pairs(currentRoomsFolder:GetChildren()) do
if v:GetAttribute("OldAmbient") then
v:SetAttribute("Ambient", v:GetAttribute("OldAmbient"))
v:SetAttribute("OldAmbient", nil)
end
end
end
	pcall(function() ClearAllDoorESP() end)
	pcall(function() ClearAllObjectiveESP() end)
	pcall(function() ClearCurrentRoomESPs() end)
	pcall(function() ClearGlobalEntityESPs() end)
	pcall(function() ClearVineDoorESP() end)
	pcall(function() ClearPaperPlaneESP() end)
	pcall(function() ClearAllFloorLootESP() end)
	pcall(function() ClearLockerESP() end)
	pcall(function() ClearToolboxESP() end)
	pcall(function() ClearDronesESP() end)
if workspace:FindFirstChild("CurrentRooms") then
for _, v in ipairs(workspace.CurrentRooms:GetDescendants()) do
if v.Name == "LiveHintBook" then
ESPLibrary:RemoveESP(v)
end
end
end
if ESPLibrary and type(ESPLibrary.Unload) == "function" then
pcall(function() ESPLibrary:Unload() end)
end
ResetPressed = false
if Connections and type(Connections) == "table" then
for i, con in pairs(Connections) do
if con and type(con.Disconnect) == "function" then
pcall(function() con:Disconnect() end)
elseif con and type(con) == "RBXScriptConnection" then
pcall(function() con:Disconnect() end)
end
end
table.clear(Connections)
end
if LocalPlayer and type(LocalPlayer) == "userdata" then
local Dread = LocalPlayer:FindFirstChild("Dread", true) or LocalPlayer:FindFirstChild("_Dread", true)
if Dread and Dread.Name then Dread.Name = "Dread" end
end
if ClientModules and type(ClientModules) == "userdata" then
local entityModules = ClientModules:FindFirstChild("EntityModules")
if entityModules then
local Shade = entityModules:FindFirstChild("Shade", true) or entityModules:FindFirstChild("_Shade", true)
if Shade and Shade.Name then Shade.Name = "Shade" end
end
end
if RemotesFolder and type(RemotesFolder) == "userdata" then
local crouch = RemotesFolder:FindFirstChild("Crouch")
if crouch and type(crouch.FireServer) == "function" then
pcall(function() crouch:FireServer(false, false) end)
end
end
if FakeA90 and type(FakeA90) == "userdata" then pcall(function() FakeA90:Destroy() end) FakeA90 = nil end
if FakeScreech and type(FakeScreech) == "userdata" then pcall(function() FakeScreech:Destroy() end) FakeScreech = nil end
if ReplicatedStorage and type(ReplicatedStorage) == "userdata" then
local screech = ReplicatedStorage:FindFirstChild("Screech")
if screech and RemotesFolder then pcall(function() screech.Parent = RemotesFolder end) end
local a90 = ReplicatedStorage:FindFirstChild("A90")
if a90 and RemotesFolder then pcall(function() a90.Parent = RemotesFolder end) end
local surgeRemote = ReplicatedStorage:FindFirstChild("SurgeRemote")
if surgeRemote and RemotesFolder then pcall(function() surgeRemote.Parent = RemotesFolder end) end
pcall(function()
local soundService = game:GetService("SoundService")
local mainSound = soundService:FindFirstChild("Main")
if mainSound and mainSound:FindFirstChild("Jamming") then
mainSound.Jamming.Enabled = IsJamminModifierActive()
end
end)
end
if RemotesFolder and type(RemotesFolder) == "userdata" then
local a90_ = RemotesFolder:FindFirstChild("A90_")
if a90_ then pcall(function() a90_.Name = "A90" end) end
local screech_ = RemotesFolder:FindFirstChild("Screech_")
if screech_ then pcall(function() screech_.Name = "Screech" end) end
end
if Surge and type(Surge) == "userdata" then pcall(function() Surge:Destroy() end) Surge = nil end
if LocalPlayer and type(LocalPlayer) == "userdata" then
local char = LocalPlayer.Character
if char and type(char) == "userdata" then
local humanoid = char:FindFirstChild("Humanoid")
local hrp = char:FindFirstChild("HumanoidRootPart")
if humanoid and type(humanoid) == "userdata" then
pcall(function()
humanoid.WalkSpeed = OriginalWalkSpeed
char:SetAttribute("CanJump", false)
if humanoid:FindFirstChild("Root") and humanoid.Root:IsA("Motor6D") then
pcall(function() humanoid.Root.C1 = CFrame.new(0, 0, 0) end)
end
humanoid.HipHeight = 2.4
end)
end
for _, v in pairs(char:GetChildren()) do
if v and type(v) == "userdata" and v:IsA("BasePart") and v.Name ~= "CollisionClone" then
pcall(function() v.CanCollide = true end)
end
end
if OldAccel and hrp then
pcall(function()
hrp.CustomPhysicalProperties = OldAccel
OldAccel = nil
end)
end
if hrp then
local flightVel = hrp:FindFirstChild("FlightVelocity")
if flightVel then pcall(function() flightVel:Destroy() end) end
local velocityMani = hrp:FindFirstChild("VelocityMani")
if velocityMani then pcall(function() velocityMani:Destroy() end) end
end
ManipulationNoClipForced = false
local collision = char:FindFirstChild("Collision")
if collision and hrp then
pcall(function() collision.Position = hrp.Position end)
end
end
end
for _, v in ipairs(workspace:GetDescendants()) do
if v and type(v) == "userdata" and v:IsA("ProximityPrompt") then
pcall(function()
local duration = v:GetAttribute("Duration")
if duration then v.HoldDuration = duration end
end)
end
end
if SaveManager and type(SaveManager) == "table" and type(SaveManager.Save) == "function" then
pcall(function() SaveManager:Save("Umbra/DOORS") end)
end
if Library and type(Library) == "table" and type(Library.Unload) == "function" then
pcall(function() Library:Unload() end)
end
for userId in pairs(PlayerESPModule.CharConnections) do
PlayerESPModule:ClearCharConnections(userId)
end
getgenv().Toggles = nil
getgenv().Options = nil
getgenv().Library = nil
getgenv().Window = nil
getgenv().ScriptLibrary = nil
getgenv().Connections = nil
getgenv().UmbraUnload = nil
end
getgenv().UmbraUnload = UnloadHubLogic
UtilityBox:AddButton({
Text = "Unload Hub",
Func = function()
UnloadHubLogic()
end
})
local HttpService = game:GetService("HttpService")
local KeybindPosFile = "Umbra/DOORS/keybinds_pos.json"
local function SaveKeybindPosition()
if Library and Library.KeybindFrame and writefile then
pcall(function()
local pos = Library.KeybindFrame.Position
local data = {
XScale = pos.X.Scale,
XOffset = pos.X.Offset,
YScale = pos.Y.Scale,
YOffset = pos.Y.Offset
}
writefile(KeybindPosFile, HttpService:JSONEncode(data))
end)
end
end
local function LoadKeybindPosition()
if Library and Library.KeybindFrame and readfile and isfile and isfile(KeybindPosFile) then
pcall(function()
local data = HttpService:JSONDecode(readfile(KeybindPosFile))
if data and data.XScale then
Library.KeybindFrame.Position = UDim2.new(data.XScale, data.XOffset, data.YScale, data.YOffset)
end
end)
end
end
task.spawn(function()
task.wait(0.5)
LoadKeybindPosition()
end)
if Library and Library.KeybindFrame then
Library.KeybindFrame.InputEnded:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
SaveKeybindPosition()
end
end)
end
pcall(function()
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({'MenuKeybind'})
ThemeManager:SetFolder("Umbra")
SaveManager:SetFolder("Umbra/DOORS")
SaveManager:BuildConfigSection(Tabs['Settings'])
ThemeManager:ApplyToTab(Tabs['Settings'])
end)

do
local cursorGui = Instance.new("ScreenGui")
cursorGui.Name = "UmbraCursor"
cursorGui.ResetOnSpawn = false
cursorGui.IgnoreGuiInset = true
cursorGui.DisplayOrder = 99999
cursorGui.Enabled = Library.ShowCustomCursor ~= false
cursorGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local cursorDot = Instance.new("Frame")
cursorDot.Name = "CursorDot"
cursorDot.Size = UDim2.new(0, 6, 0, 6)
cursorDot.AnchorPoint = Vector2.new(0.5, 0.5)
cursorDot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
cursorDot.BorderSizePixel = 0
cursorDot.ZIndex = 99999
cursorDot.Parent = cursorGui

local dotCorner = Instance.new("UICorner")
dotCorner.CornerRadius = UDim.new(1, 0)
dotCorner.Parent = cursorDot

local cursorStroke = Instance.new("UIStroke")
cursorStroke.Color = Color3.fromRGB(0, 0, 0)
cursorStroke.Thickness = 1
cursorStroke.Parent = cursorDot

local cursorConn
cursorConn = RunService.RenderStepped:Connect(function()
if Library and Library.Unloaded then
if cursorConn then cursorConn:Disconnect() end
pcall(function() cursorGui:Destroy() end)
return
end
if cursorDot and cursorDot.Parent then
local mouse = LocalPlayer:GetMouse()
cursorDot.Position = UDim2.new(0, mouse.X, 0, mouse.Y)
end
end)
table.insert(Connections, cursorConn)
end

do
local mobileGui = Instance.new("ScreenGui")
mobileGui.Name = "UmbraMobileToggle"
mobileGui.ResetOnSpawn = false
mobileGui.IgnoreGuiInset = true
mobileGui.DisplayOrder = 99998
mobileGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local toggleBtn = Instance.new("TextButton")
toggleBtn.Name = "ToggleUI"
toggleBtn.Size = UDim2.new(0, 50, 0, 50)
toggleBtn.Position = UDim2.new(0, 12, 0.5, -25)
toggleBtn.AnchorPoint = Vector2.new(0, 0)
toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggleBtn.BackgroundTransparency = 0
toggleBtn.Text = ""
toggleBtn.Image = UmbraLogoAsset
toggleBtn.ImageColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.ScaleType = Enum.ScaleType.Fit
toggleBtn.BorderSizePixel = 0
toggleBtn.AutoButtonColor = true
toggleBtn.ZIndex = 99998
toggleBtn.Parent = mobileGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = toggleBtn

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(150, 150, 150)
stroke.Thickness = 2
stroke.Parent = toggleBtn

local dragging = false
local dragStart = nil
local startPos = nil
local hasDragged = false

toggleBtn.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
dragging = true
hasDragged = false
dragStart = input.Position
startPos = toggleBtn.Position
input.Changed:Connect(function()
if input.UserInputState == Enum.UserInputState.End then
dragging = false
end
end)
end
end)

UserInputService.InputChanged:Connect(function(input)
if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
local delta = input.Position - dragStart
if math.abs(delta.X) > 5 or math.abs(delta.Y) > 5 then
hasDragged = true
end
toggleBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end
end)

toggleBtn.MouseButton1Click:Connect(function()
if hasDragged then return end
pcall(function()
if Library and Library.Toggle then
Library:Toggle()
end
end)
end)
end

Notify("Successfully Loaded ///", 4)
