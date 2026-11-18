--// XUANBACH HUB | Blox Fruits | Full Ultimate Custom UI Edition
if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local VirtualUser = game:GetService("VirtualUser")
local HttpService = game:GetService("HttpService")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local LP = Players.LocalPlayer
local IS_MOBILE = UIS.TouchEnabled and not UIS.KeyboardEnabled
local CommF = RS:WaitForChild("Remotes"):WaitForChild("CommF_")

--// HỆ THỐNG ANTI-BAN AN TOÀN CAO CẤP
pcall(function()
	local mt = getrawmetatable(game)
	setreadonly(mt, false)
	local old_namecall = mt.__namecall
	mt.__namecall = newcclosure(function(self, ...)
		local method = getnamecallmethod()
		if method == "FireServer" and self.Name == "CommF_" then
			task.wait(math.random(15, 35) / 1000)
		end
		return old_namecall(self, ...)
	end)
	setreadonly(mt, true)
end)

--// DATA DANH SÁCH TOÀN BỘ GAME
local QUESTS = {
	{Min = 1, Max = 9, Mob = "Bandit", Quest = "BanditQuest1", QLv = 1},
	{Min = 10, Max = 14, Mob = "Monkey", Quest = "JungleQuest", QLv = 1},
	{Min = 15, Max = 29, Mob = "Gorilla", Quest = "JungleQuest", QLv = 2},
	{Min = 30, Max = 39, Mob = "Pirate", Quest = "BuggyQuest1", QLv = 1},
	{Min = 40, Max = 59, Mob = "Brute", Quest = "BuggyQuest1", QLv = 2},
	{Min = 60, Max = 74, Mob = "Desert Bandit", Quest = "DesertQuest", QLv = 1},
	{Min = 75, Max = 89, Mob = "Desert Officer", Quest = "DesertQuest", QLv = 2},
	{Min = 90, Max = 99, Mob = "Snow Bandit", Quest = "SnowQuest", QLv = 1},
	{Min = 100, Max = 119, Mob = "Snowman", Quest = "SnowQuest", QLv = 2},
	{Min = 120, Max = 149, Mob = "Chief Petty Officer", Quest = "MarineQuest2", QLv = 1},
	{Min = 150, Max = 174, Mob = "Sky Bandit", Quest = "SkyQuest", QLv = 1},
	{Min = 175, Max = 209, Mob = "Dark Master", Quest = "SkyQuest", QLv = 2},
	{Min = 210, Max = 249, Mob = "Prisoner", Quest = "PrisonerQuest", QLv = 1},
	{Min = 250, Max = 299, Mob = "Dangerous Prisoner", Quest = "PrisonerQuest", QLv = 2},
	{Min = 300, Max = 324, Mob = "Toga Warrior", Quest = "ColosseumQuest", QLv = 1},
	{Min = 325, Max = 374, Mob = "Gladiator", Quest = "ColosseumQuest", QLv = 2},
	{Min = 375, Max = 399, Mob = "Military Soldier", Quest = "MagmaQuest", QLv = 1},
	{Min = 400, Max = 449, Mob = "Military Spy", Quest = "MagmaQuest", QLv = 2},
	{Min = 450, Max = 474, Mob = "Fishman Warrior", Quest = "FishmanQuest", QLv = 1},
	{Min = 475, Max = 524, Mob = "Fishman Commando", Quest = "FishmanQuest", QLv = 2},
	{Min = 525, Max = 549, Mob = "God's Guard", Quest = "SkyExp1Quest", QLv = 1},
	{Min = 550, Max = 624, Mob = "Shanda", Quest = "SkyExp1Quest", QLv = 2},
	{Min = 625, Max = 699, Mob = "Royal Squad", Quest = "FountainQuest", QLv = 1},
	{Min = 700, Max = 724, Mob = "Raider", Quest = "Area1Quest", QLv = 1},
	{Min = 725, Max = 774, Mob = "Mercenary", Quest = "Area1Quest", QLv = 2},
	{Min = 775, Max = 799, Mob = "Swan Pirate", Quest = "Area2Quest", QLv = 1},
	{Min = 800, Max = 874, Mob = "Factory Staff", Quest = "Area2Quest", QLv = 2},
	{Min = 875, Max = 899, Mob = "Marine Lieutenant", Quest = "MarineQuest3", QLv = 1},
	{Min = 900, Max = 949, Mob = "Marine Captain", Quest = "MarineQuest3", QLv = 2},
	{Min = 950, Max = 974, Mob = "Zombie", Quest = "ZombieQuest", QLv = 1},
	{Min = 975, Max = 999, Mob = "Vampire", Quest = "ZombieQuest", QLv = 2},
	{Min = 1000, Max = 1049, Mob = "Snow Trooper", Quest = "SnowMountainQuest", QLv = 1},
	{Min = 1050, Max = 1099, Mob = "Winter Warrior", Quest = "SnowMountainQuest", QLv = 2},
	{Min = 1100, Max = 1149, Mob = "Lab Subordinate", Quest = "IceSideQuest", QLv = 1},
	{Min = 1150, Max = 1199, Mob = "Horned Warrior", Quest = "IceSideQuest", QLv = 2},
	{Min = 1200, Max = 1249, Mob = "Magma Ninja", Quest = "FireSideQuest", QLv = 1},
	{Min = 1250, Max = 1299, Mob = "Lava Pirate", Quest = "FireSideQuest", QLv = 2},
	{Min = 1300, Max = 1349, Mob = "Ship Deckhand", Quest = "ShipQuest1", QLv = 1},
	{Min = 1350, Max = 1424, Mob = "Ship Engineer", Quest = "ShipQuest1", QLv = 2},
	{Min = 1425, Max = 1449, Mob = "Navy Commander", Quest = "IceCreamQuest", QLv = 1},
	{Min = 1450, Max = 1499, Mob = "Mini Tusk", Quest = "IceCreamQuest", QLv = 2},
	{Min = 1500, Max = 1524, Mob = "Pirate Millionaire", Quest = "PortTownQuest", QLv = 1},
	{Min = 1525, Max = 1574, Mob = "Pistol Billionaire", Quest = "PortTownQuest", QLv = 2},
	{Min = 1575, Max = 1624, Mob = "Dragon Crew Warrior", Quest = "HydraQuest", QLv = 1},
	{Min = 1625, Max = 1699, Mob = "Dragon Crew Archer", Quest = "HydraQuest", QLv = 2},
	{Min = 1700, Max = 1749, Mob = "Female Islander", Quest = "GreatTreeQuest", QLv = 1},
	{Min = 1750, Max = 1799, Mob = "Giant Islander", Quest = "GreatTreeQuest", QLv = 2},
	{Min = 1800, Max = 1849, Mob = "Marine Commodore", Quest = "SeaIslandQuest", QLv = 1},
	{Min = 1850, Max = 1899, Mob = "Marine Rear Admiral", Quest = "SeaIslandQuest", QLv = 2},
	{Min = 1900, Max = 1949, Mob = "Fishman Raider", Quest = "ForgottenQuest", QLv = 1},
	{Min = 1950, Max = 1999, Mob = "Fishman Captain", Quest = "ForgottenQuest", QLv = 2},
	{Min = 2000, Max = 2049, Mob = "Forest Pirate", Quest = "HauntedQuest1", QLv = 1},
	{Min = 2050, Max = 2074, Mob = "Mythological Pirate", Quest = "HauntedQuest1", QLv = 2},
	{Min = 2075, Max = 2124, Mob = "Reborn Skeleton", Quest = "HauntedQuest2", QLv = 1},
	{Min = 2125, Max = 2199, Mob = "Living Zombie", Quest = "HauntedQuest2", QLv = 2},
	{Min = 2200, Max = 2249, Mob = "Demonic Soul", Quest = "NutIslandQuest", QLv = 1},
	{Min = 2250, Max = 2299, Mob = "Posessed Mummy", Quest = "NutIslandQuest", QLv = 2},
	{Min = 2300, Max = 2349, Mob = "Peanut Scout", Quest = "IceCreamLandQuest", QLv = 1},
	{Min = 2350, Max = 2399, Mob = "Peanut President", Quest = "IceCreamLandQuest", QLv = 2},
	{Min = 2400, Max = 2449, Mob = "Ice Cream Chef", Quest = "CakeQuest1", QLv = 1},
	{Min = 2450, Max = 2499, Mob = "Ice Cream Commander", Quest = "CakeQuest1", QLv = 2},
	{Min = 2500, Max = 2549, Mob = "Cocoa Warrior", Quest = "CakeQuest2", QLv = 1},
	{Min = 2550, Max = 2599, Mob = "Chocolate Bar Battler", Quest = "CakeQuest2", QLv = 2},
	{Min = 2600, Max = 2649, Mob = "Sweet Thief", Quest = "CandyQuest1", QLv = 1},
	{Min = 2650, Max = 2700, Mob = "Candy Rebel", Quest = "CandyQuest1", QLv = 2},
	{Min = 2701, Max = 3000, Mob = "Tiki Officer", Quest = "TikiQuest1", QLv = 1},
}

local BONE_MOBS = {"Reborn Skeleton", "Living Zombie", "Demonic Soul", "Posessed Mummy"}
local CAKE_MOBS = {"Cookie Crafter", "Cake Guard", "Baking Staff", "Head Baker"}
local BOSSES = {"Gorilla King", "Bobby", "Yeti", "Vice Admiral", "Saber Expert", "Warden", "Chief Warden", "Swan", "Magma Admiral", "Fishman Lord", "Wysper", "Thunder God", "Cyborg", "Ice Admiral", "Greybeard", "Cursed Captain", "Darkbeard", "Order", "Stone", "Island Empress", "Kilo Admiral", "Captain Elephant", "Beautiful Pirate", "Longma", "Soul Reaper", "Cake Prince"}
local SEA_EVENTS = {"Cake Prince", "Dough King", "Rip_Indra", "Terrorshark", "Leviathan"}
local SEA_MONSTERS = {"Terrorshark", "Piranha", "Sea Beast", "Fish Crew Member"}
local STYLES = {"Superhuman", "Sharkman Karate", "Death Step", "Electric Claw", "Dragon Talon", "Godhuman", "Sanguine Art"}
local STYLE_REMOTE = {
	["Superhuman"] = "BuySuperhuman", ["Sharkman Karate"] = "BuySharkmanKarate", ["Death Step"] = "BuyDeathStep",
	["Electric Claw"] = "BuyElectricClaw", ["Dragon Talon"] = "BuyDragonTalon", ["Godhuman"] = "BuyGodhuman", ["Sanguine Art"] = "BuySanguineArt"
}
local CHIPS = {"Flame", "Ice", "Quake", "Light", "Dark", "Spider", "Rumble", "Magma", "Buddha", "Sand", "Phoenix", "Dough"}

--// TRẠNG THÁI (STATE)
local S = {
	Running = true, Farm = false, FarmMode = "Level", Weapon = "Melee",
	BringMob = true, BringRange = 300, AutoSkill = true,
	AutoChest = false, AutoBoss = false, SelectedBoss = BOSSES[1],
	AutoRaid = false, SelectedChip = "Flame", AutoNextIsland = true,
	SeaMonster = false, AutoBuyStyle = false, SelectedStyle = STYLES[1],
	FastAttack = true, Haki = false, Ken = false, FruitESP = false, PlayerESP = false,
	TweenSpeed = 350, Tweening = false
}

--// GIAO DIỆN ĐỘC LẬP THỜI TRANG & GỌN NHẸ
local ScreenGui = Instance.new("ScreenGui", (gethui and gethui()) or CoreGui)
ScreenGui.Name = "XuanBachHub_Ultimate"
ScreenGui.ResetOnSpawn = false

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.fromOffset(480, 360)
Main.Position = UDim2.new(0.5, -240, 0.5, -180)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
Main.BorderSizePixel = 0
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

local TopBar = Instance.new("Frame", Main)
TopBar.Size = UDim2.new(1, 0, 0, 45)
TopBar.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel", TopBar)
Title.Size = UDim2.new(1, -20, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Text = "⚡ XUANBACH HUB | Blox Fruits Ultimate Edition"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 15
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Kéo thả UI
local dragging, dragInput, dragStart, startPos
TopBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true dragStart = input.Position startPos = Main.Position
	end
end)
UIS.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - dragStart
		Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)
UIS.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = false end end)

-- Nút thu nhỏ mở giao diện nhanh
local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Size = UDim2.fromOffset(50, 50)
ToggleBtn.Position = UDim2.new(0, 15, 0.5, -25)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 150)
ToggleBtn.Text = "XB"
ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
ToggleBtn.Font = Enum.Font.GothamBlack
ToggleBtn.TextSize = 18
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
ToggleBtn.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)

-- Container chứa các tính năng cuộn
local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size = UDim2.new(1, -20, 1, -60)
Scroll.Position = UDim2.new(0, 10, 0, 50)
Scroll.BackgroundTransparency = 1
Scroll.CanvasSize = UDim2.new(0, 0, 0, 650)
Scroll.ScrollBarThickness = 6

local UIList = Instance.new("UIListLayout", Scroll)
UIList.Padding = UDim.new(0, 8)

local function createToggle(name, callback)
	local btn = Instance.new("TextButton", Scroll)
	btn.Size = UDim2.new(1, 0, 0, 38)
	btn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
	btn.Text = "  " .. name .. ": [ OFF ]"
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.TextSize, btn.Font = 13, Enum.Font.GothamBold
	btn.TextXAlignment = Enum.TextXAlignment.Left
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
	
	local state = false
	btn.MouseButton1Click:Connect(function()
		state = not state
		if state then
			btn.BackgroundColor3 = Color3.fromRGB(40, 160, 90)
			btn.Text = "  " .. name .. ": [ ON ]"
		else
			btn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
			btn.Text = "  " .. name .. ": [ OFF ]"
		end
		callback(state)
	end)
end

-- Tạo các nút chức năng trên giao diện
createToggle("Auto Farm Level", function(v) S.Farm = v end)
createToggle("Bring Mob (Gom Quái Siêu Tốc)", function(v) S.BringMob = v end)
createToggle("Auto Skill (Z, X, C, V)", function(v) S.AutoSkill = v end)
createToggle("Fast Attack (Đánh Nhanh)", function(v) S.FastAttack = v end)
createToggle("Auto Chest (Nhặt Rương Tự Động)", function(v) S.AutoChest = v end)
createToggle("Auto Raid (Đi Raid Tự Động)", function(v) S.AutoRaid = v end)
createToggle("Auto Hunt Boss", function(v) S.AutoBoss = v end)
createToggle("Auto Hunt Quái Biển (Sea Monster)", function(v) S.SeaMonster = v end)
createToggle("ESP Trái Ác Quỷ", function(v) S.FruitESP = v end)
createToggle("ESP Người Chơi", function(v) S.PlayerESP = v end)

--// LOGIC HỆ THỐNG GAME NỀN TẢNG
local function hrp() local c = LP.Character return c and c:FindFirstChild("HumanoidRootPart") end
local function hum() local c = LP.Character return c and c:FindFirstChildOfClass("Humanoid") end
local function alive(m) local h = m and m:FindFirstChildOfClass("Humanoid") return h ~= nil and h.Health > 0 end
local function invoke(...) local ok, res = pcall(CommF.InvokeServer, CommF, ...) if ok then return res end end

RunService.Stepped:Connect(function()
	local c = LP.Character
	if c and S.Tweening then
		for _, p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end
	end
end)

local activeTween
local function tweenTo(cf)
	local root = hrp() if not root then return end
	local dist = (root.Position - cf.Position).Magnitude
	if dist < 4 then root.CFrame = cf return end
	local dur = math.max(dist / S.TweenSpeed, 0.05)
	if activeTween then activeTween:Cancel() end
	S.Tweening = true
	local tw = TweenService:Create(root, TweenInfo.new(dur, Enum.EasingStyle.Linear), {CFrame = cf})
	activeTween = tw tw:Play()
	local t0 = os.clock()
	while tw.PlaybackState == Enum.PlaybackState.Playing and os.clock() - t0 < dur + 1 do
		if not S.Running then tw:Cancel() break end
		task.wait()
	end
	S.Tweening = false
	local r = hrp() if r then r.AssemblyLinearVelocity = Vector3.zero end
end

local function findEnemy(names)
	local root, folder = hrp(), Workspace:FindFirstChild("Enemies")
	if not root or not folder then return nil end
	local best, bd = nil, math.huge
	for _, m in ipairs(folder:GetChildren()) do
		local r = m:FindFirstChild("HumanoidRootPart")
		if r and alive(m) and (not names or table.find(names, m.Name)) then
			local d = (r.Position - root.Position).Magnitude
			if d < bd then best, bd = m, d end
		end
	end
	return best
end

local function bringMobs(targetPos, names)
	if not S.BringMob then return end
	local folder = Workspace:FindFirstChild("Enemies")
	if not folder then return end
	for _, m in ipairs(folder:GetChildren()) do
		local r = m:FindFirstChild("HumanoidRootPart")
		local h = m:FindFirstChildOfClass("Humanoid")
		if r and h and h.Health > 0 and (not names or table.find(names, m.Name)) then
			local dist = (r.Position - targetPos).Magnitude
			if dist <= S.BringRange and dist > 3 then
				r.CFrame = CFrame.new(targetPos + Vector3.new(0, 2, 0))
				r.AssemblyLinearVelocity = Vector3.zero
				pcall(function() h.Sit = true sethiddenproperty(LP, "SimulationRadius", math.huge) end)
			end
		end
	end
end

local function attack()
	local c = LP.Character
	local t = c and c:FindFirstChildOfClass("Tool")
	if t then t:Activate() end
end

local function useSkills()
	if not S.AutoSkill then return end
	local vim = game:GetService("VirtualInputManager")
	for _, k in ipairs({Enum.KeyCode.Z, Enum.KeyCode.X, Enum.KeyCode.C, Enum.KeyCode.V}) do
		pcall(function() vim:SendKeyEvent(true, k, false, game) task.wait(0.04) vim:SendKeyEvent(false, k, false, game) end)
	end
end

local function getQuest()
	local lv = LP.Data.Level.Value
	for _, q in ipairs(QUESTS) do if lv >= q.Min and lv <= q.Max then return q end end
	return QUESTS[#QUESTS]
end

local function questActive(q)
	local ok, txt = pcall(function() return LP.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text end)
	return ok and type(txt) == "string" and txt:find(q.Mob, 1, true) ~= nil
end

-- Vòng lặp Auto Farm & Tính năng chính
task.spawn(function()
	while S.Running do
		if S.Farm then
			pcall(function()
				local q = getQuest()
				if not q then return end
				if not questActive(q) then
					invoke("StartQuest", q.Quest, q.QLv)
					task.wait(0.5)
					return
				end
				local m = findEnemy({q.Mob})
				if m then
					local root, mr = hrp(), m:FindFirstChild("HumanoidRootPart")
					if root and mr then
						if (root.Position - mr.Position).Magnitude > 50 then tweenTo(CFrame.new(mr.Position + Vector3.new(0, 10, 0))) end
						root.CFrame = CFrame.new(mr.Position + Vector3.new(0, 7, 0), mr.Position)
						root.AssemblyLinearVelocity = Vector3.zero
						bringMobs(mr.Position, {q.Mob})
						attack() useSkills()
					end
				end
			end)
		end
		if S.AutoBoss then
			pcall(function()
				local m = findEnemy(BOSSES)
				if m then
					local root, mr = hrp(), m:FindFirstChild("HumanoidRootPart")
					if root and mr then
						if (root.Position - mr.Position).Magnitude > 50 then tweenTo(CFrame.new(mr.Position + Vector3.new(0, 10, 0))) end
						root.CFrame = CFrame.new(mr.Position + Vector3.new(0, 7, 0), mr.Position)
						attack() useSkills()
					end
				end
			end)
		end
		if S.AutoChest then
			pcall(function()
				local root = hrp() if not root then return end
				for _, v in ipairs(Workspace:GetDescendants()) do
					if v:IsA("BasePart") and v.Name:find("Chest") and v.Transparency < 1 then
						tweenTo(v.CFrame)
						pcall(firetouchinterest, root, v, 0) pcall(firetouchinterest, root, v, 1)
						break
					end
				end
			end)
		end
		task.wait(0.04)
	end
end)

-- Fast Attack liên tục
task.spawn(function()
	while S.Running do
		if S.FastAttack and (S.Farm or S.AutoBoss) then attack() end
		task.wait(0.015)
	end
end)

print("XuanBach Hub Ultimate Loaded!")
