local success, v0 = pcall(function() return loadstring(game:HttpGet("https://sirius.menu/rayfield"))() end)
if not success then
    warn("Failed to load Rayfield library: " .. tostring(v0))
    return
end

local v1 = game:GetService("Players")
local v2 = game:GetService("RunService")
local v3 = game:GetService("VirtualUser")
local v4 = game:GetService("VirtualInputManager")
local v5 = v1.LocalPlayer
if not v5 then
    warn("LocalPlayer not found")
    return
end

local v6 = v0:CreateWindow({Name="Auto Expedition By Joseph",LoadingTitle="Auto Expedition",LoadingSubtitle="by Joseph Starling",Theme="Purple",ConfigurationSaving={Enabled=false},KeySystem=false})
if not v6 then
    warn("Failed to create Rayfield window")
    return
end

local v7 = {
    {Name="Spawn",CFrame=CFrame.new(-(7891.5-(1668+215)),-(143.6+13),-(185.6-132))},
    {Name="Camp 1",CFrame=CFrame.new(-(4236.6-(114+404)),227.4,723.6-(106+382))},
    {Name="Camp 2",CFrame=CFrame.new(2200.7-(306+105),273.8-166,-137)},
    {Name="Camp 2.5",CFrame=CFrame.new(5635.53,341.25,92.76)},
    {Name="Camp 3",CFrame=CFrame.new(5892.1,323.4,-20.3)},
    {Name="Camp 4",CFrame=CFrame.new(8992.2,1942-(1213+131),102.6)},
    {Name="South Pole",CFrame=CFrame.new(11001.9,551.5,24.799999999999997+79)}
}
local v8 = 2
local v9 = 0
local v10 = false
local v11 = 0
local v12 = nil
local v13 = false
local v14 = false
local v15 = nil
local v16 = "Reset"
local v17 = 3
local v18 = 5
local v19 = 100
local v20 = v17
local v21 = v18
local v22 = v19
local v24 = v9
local v23 = 0 -- Variabel cooldown untuk auto jump

local function v25(v48)
    local v50 = v7[1].CFrame.Position
    return (v48-v50).Magnitude <= 100
end

v5.Idled:Connect(function()
    v3:Button2Down(Vector2.zero, workspace.CurrentCamera.CFrame)
    task.wait(1)
    v3:Button2Up(Vector2.zero, workspace.CurrentCamera.CFrame)
end)

local function v26(v52)
    local v53 = v52.RootPart or v52.Parent:FindFirstChild("HumanoidRootPart")
    if not v53 then return false end
    local v54 = v53.Position
    local v55 = Vector3.new(0, -4, 0)
    local v56 = RaycastParams.new()
    v56.FilterDescendantsInstances = {v5.Character}
    v56.FilterType = Enum.RaycastFilterType.Blacklist
    local v60 = workspace:Raycast(v54, v55, v56)
    return v60 and (v60.Instance ~= nil)
end

local function v27()
    if v14 then return end
    local v61 = v5.Character
    if v61 then
        local v102 = v61:FindFirstChildOfClass("Humanoid")
        local v103 = v61:FindFirstChild("HumanoidRootPart")
        local v99 = tick()
        if v102 and v102.Health > 0 and v103 and (v99 - v23) >= 2 then
            v102:ChangeState(Enum.HumanoidStateType.Jumping)
            v23 = v99
            print("Auto jump triggered at " .. tostring(v103.Position))
        else
            print("Auto jump condition not met: Humanoid=" .. tostring(v102 and "found" or "nil") .. ", RootPart=" .. tostring(v103 and "found" or "nil") .. ", Health=" .. tostring(v102 and v102.Health or "nil") .. ", Cooldown=" .. tostring(v99 - v23))
        end
    end
end

local function v28()
    if v12 then return end
    v13 = true
    v12 = task.spawn(function()
        while v13 and v10 do
            v27()
            task.wait(2)
        end
        v12 = nil
    end)
end

local function v29()
    v13 = false
    if v12 then
        task.cancel(v12)
        v12 = nil
    end
end

local function v30()
    if v15 then return end
    v15 = v2.RenderStepped:Connect(function()
        local v93 = workspace.CurrentCamera
        local v94 = v5.Character
        if v94 and v94:FindFirstChild("HumanoidRootPart") then
            local v113 = v94.HumanoidRootPart
            v93.CameraType = Enum.CameraType.Scriptable
            v93.CFrame = v113.CFrame * CFrame.new(0, 5, 10) * CFrame.Angles(math.rad(-20), 0, 0)
        end
    end)
end

local function v31()
    if v15 then
        v15:Disconnect()
        v15 = nil
    end
    local v63 = workspace.CurrentCamera
    v63.CameraType = Enum.CameraType.Custom
end

local function v32(v66)
    v14 = true
    local v68 = v5.Character or v5.CharacterAdded:Wait()
    local v69 = v68:WaitForChild("HumanoidRootPart")
    if v69 then
        v29()
        task.wait(v17)
        v69.Anchored = true
        v69.Velocity = Vector3.zero
        v69.RotVelocity = Vector3.zero
        task.wait(0.1)
        v69.CFrame = v66
        v69.Anchored = false
        task.wait(0.1)
        task.wait(v18)
        if v7[v8].Name == "Camp 2.5" then
            v0:Notify({Title="Camp 2.5", Content="Reached Camp 2.5. Waiting 5 seconds before continuing...", Duration=5})
            task.wait(5)
            v8 = v8 + 1
            print("Before refill, v8 = " .. v8)
            v0:Notify({Title="Refill Water", Content="Teleporting to refill water...", Duration=5})
            v32(CFrame.new(5884.73, 326.13, 6.52)) -- Koordinat baru water refill
            for i = 1, 15 do
                v4:SendMouseButtonEvent(0, 0, 0, true, game, 1)
                task.wait(3)
                v4:SendMouseButtonEvent(0, 0, 0, false, game, 1)
            end
            v0:Notify({Title="Water Refilled", Content="Auto jumping for 2 minutes...", Duration=5})
            v28() -- Aktifkan auto jump
            task.wait(120) -- Tunggu 2 menit
            v29() -- Matikan auto jump setelah 2 menit
            v0:Notify({Title="Auto Jump Complete", Content="Moving to Camp 3...", Duration=5})
            v8 = 5
            print("After refill, v8 set to " .. v8)
            v32(v7[v8].CFrame)
        else
            v14 = false
            if v10 then v28() end
        end
        print("Teleported to " .. tostring(v66) .. ", Anchored=" .. tostring(v69.Anchored))
    end
end

local function v33(v70, v71)
    v4:SendMouseButtonEvent(v70, v71, 0, true, game, 0)
    task.wait(0.05)
    v4:SendMouseButtonEvent(v70, v71, 0, false, game, 0)
end

local function v34()
    local v73 = workspace.CurrentCamera.ViewportSize
    local v74 = v73.X / 2
    local v75 = v73.Y / 2
    v33(v74, v75)
end

local function v35()
    local v77 = workspace.CurrentCamera.ViewportSize
    local v78 = v77.X * 0.1
    local v79 = v77.Y * 0.9
    v33(v78, v79)
end

local function v36()
    v10 = false
    v29()
    v31()
    if v100 then task.cancel(v100) end
    v8 = 2
    v11 = 0
    for _, v96 in ipairs(v39) do
        v96:SetDisabled(false)
    end
end

local function v37()
    local v81 = v5.Character and v5.Character:FindFirstChildOfClass("Humanoid")
    if v81 then
        v81.Health = 0
    end
end

local v100 = nil
local function startAutoClicker()
    if v100 then task.cancel(v100) end
    v100 = task.spawn(function()
        while v10 do
            v4:SendMouseButtonEvent(0, 0, 0, true, game, 1)
            task.wait(0.1)
            v4:SendMouseButtonEvent(0, 0, 0, false, game, 1)
            task.wait(60)
        end
    end)
end

local function pressKey2()
    v4:SendKeyEvent(true, "Two", false, game)
    task.wait(0.1)
    v4:SendKeyEvent(false, "Two", false, game)
end

v5.CharacterAdded:Connect(function()
    if v10 then
        pressKey2()
        startAutoClicker()
        v28()
    end
end)

v2.RenderStepped:Connect(function()
    if not v10 then return end
    for _, v98 in ipairs(v5.PlayerGui:GetDescendants()) do
        if v98:IsA("TextLabel") and v98.Visible and v98.Text and v98.Text:find("You have made it to") then
            local v115 = v7[v8].Name
            if v98.Text:find(v115) then
                v8 = v8 + 1
                if v115 ~= "South Pole" then
                    v0:Notify({Title="Camp Reached", Content=v115 .. " reached. Moving on...", Duration=6})
                    v32(v7[v8].CFrame)
                else
                    v0:Notify({Title="South Pole Reached", Content="Handling ASP...", Duration=6})
                    v11 = v11 + 1
                    if v16 == "WaitThenSpawn" then
                        task.wait(10)
                        v32(v7[1].CFrame)
                        v0:Notify({Title="Spawn", Content="Waiting " .. v19 .. " seconds", Duration=v19})
                        task.wait(v19)
                    else
                        task.wait(5)
                        v37()
                        task.wait(3)
                        v32(v7[1].CFrame)
                        v0:Notify({Title="Spawn", Content="Waiting " .. v19 .. " seconds", Duration=v19})
                        task.wait(v19)
                    end
                    if v9 > 0 and v11 >= v9 then
                        v0:Notify({Title="Expedition Complete", Content="You have completed " .. v9 .. " loops.", Duration=5})
                        v36()
                    else
                        pressKey2()
                        startAutoClicker()
                        v28()
                    end
                end
                break
            end
        end
    end
end)

local v38 = v6:CreateTab("Auto Expedition")
local v39 = {}

local function v40()
    for _, v100 in ipairs(v39) do
        v100:SetDisabled(true)
    end
end

local function v41()
    for _, v117 in ipairs(v39) do
        v117:SetDisabled(false)
    end
end

local v42 = v38:CreateToggle({
    Name = "Start Expedition",
    CurrentValue = false,
    Callback = function(v83)
        if v83 then
            if v10 then return end
            v10 = true
            v8 = 2
            v11 = 0
            pressKey2()
            startAutoClicker()
            v0:Notify({Title="Expedition Started", Content="Starting at Camp 1", Duration=5})
            v28()
            v32(v7[v8].CFrame)
            v40()
        else
            v10 = false
            v29()
            v31()
            if v100 then task.cancel(v100) end
            v0:Notify({Title="Expedition Stopped", Content="Expedition stopped by user.", Duration=5})
            v41()
        end
    end
})
table.insert(v39, v42)

local loopCountInput = v38:CreateInput({
    Name = "Loop Count (0 = infinite)",
    PlaceholderText = "0",
    RemoveTextAfterFocusLost = false,
    Callback = function(v84)
        if v10 then
            v0:Notify({Title="Expedition Active", Content="Restart expedition to apply loop count.", Duration=5})
            loopCountInput:SetText(tostring(v24))
            return
        end
        local v85 = tonumber(v84)
        if v85 and v85 >= 0 then
            v9 = v85
            v24 = v85
        else
            v0:Notify({Title="Warning", Content="Loop count must be 0 or greater.", Duration=5})
            loopCountInput:SetText(tostring(v24))
        end
    end
})
table.insert(v39, loopCountInput)

local jumpPauseInput = v38:CreateInput({
    Name = "Jump Pause Before Teleport (secs)",
    PlaceholderText = tostring(v17),
    RemoveTextAfterFocusLost = false,
    NumberOnly = true,
    Callback = function(v86)
        local v88 = tonumber(v86)
        if v88 and v88 >= 0 then
            if v10 then
                v0:Notify({Title="Expedition Active", Content="Restart expedition to apply jump pause.", Duration=5})
                jumpPauseInput:SetText(tostring(v20))
                return
            end
            v17 = v88
            v20 = v88
        else
            v0:Notify({Title="Warning", Content="Value must be 0 or greater.", Duration=5})
            jumpPauseInput:SetText(tostring(v20))
        end
    end
})
table.insert(v39, jumpPauseInput)

local jumpResumeInput = v38:CreateInput({
    Name = "Jump Resume After Teleport (secs)",
    PlaceholderText = tostring(v18),
    RemoveTextAfterFocusLost = false,
    NumberOnly = true,
    Callback = function(v89)
        local v90 = tonumber(v89)
        if v90 and v90 >= 0 then
            if v10 then
                v0:Notify({Title="Expedition Active", Content="Restart expedition to apply jump resume.", Duration=5})
                jumpResumeInput:SetText(tostring(v21))
                return
            end
            v18 = v90
            v21 = v90
        else
            v0:Notify({Title="Warning", Content="Value must be 0 or greater.", Duration=5})
            jumpResumeInput:SetText(tostring(v21))
        end
    end
})
table.insert(v39, jumpResumeInput)

local spawnWaitInput = v38:CreateInput({
    Name = "Waiting time at spawn (secs)",
    PlaceholderText = tostring(v19),
    RemoveTextAfterFocusLost = false,
    NumberOnly = true,
    Callback = function(v91)
        local v92 = tonumber(v91)
        if v92 and v92 >= 0 then
            if v10 then
                v0:Notify({Title="Expedition Active", Content="Restart expedition to apply spawn wait time.", Duration=5})
                spawnWaitInput:SetText(tostring(v22))
                return
            end
            v19 = v92
            v22 = v92
        else
            v0:Notify({Title="Warning", Content="Value must be 0 or greater.", Duration=5})
            spawnWaitInput:SetText(tostring(v22))
        end
    end
})
table.insert(v39, spawnWaitInput)

local v47 = v6:CreateTab("Updates")
v47:CreateLabel("- Added inputs to configure jump pause, jump resume, and spawn wait seconds")
v47:CreateLabel("- Added 5-second pause and notification for Camp 2.5 after teleport")
v47:CreateLabel("- Added auto clicker (press 2 and 1 click/minute)")
v47:CreateLabel("- Updated water refill teleport to (5884.73, 326.13, 6.52) with 15 clicks")
v47:CreateLabel("- Added 2-minute auto jump after water refill before moving to Camp 3")

return v6
