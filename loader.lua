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

local function createClickSound(parent)
    local sound = Instance.new("Sound")
    sound.Name = "ClickSound"
    sound.SoundId = "rbxassetid://9118823106" -- soft click/ding
    sound.Volume = 1
    sound.PlayOnRemove = true
    sound.Parent = parent
    return sound
end

local function createDivineAgeUI()
    local gui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
    gui.Name = "SetAgeTo50Gui"
    gui.ResetOnSpawn = false

    local button = Instance.new("TextButton", gui)
    button.Size = UDim2.new(0.5, 0, 0.07, 0)
    button.Position = UDim2.new(0.25, 0, 0.45, 0)
    button.BackgroundColor3 = Color3.fromRGB(0, 170, 90)
    button.Text = "Auto Lvl 50 Divine Pets"
    button.TextScaled = true
    button.Font = Enum.Font.GothamBold
    button.TextColor3 = Color3.new(1, 1, 1)

    local corner = Instance.new("UICorner", button)
    corner.CornerRadius = UDim.new(0, 12)

    local sound = createClickSound(button)

    button.MouseButton1Click:Connect(function()
        local found = findAllDivineLabels()
        local originalColor = button.BackgroundColor3
        button.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
        task.delay(0.2, function()
            button.BackgroundColor3 = originalColor
        end)

        sound:Destroy()

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
