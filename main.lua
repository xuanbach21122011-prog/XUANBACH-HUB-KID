--// XUANBACH HUB | EZScript + Ultra Anti-Ban & Full Features Ultimate Edition
if not game:IsLoaded() then game.Loaded:Wait() end

-- Cấu hình thông tin giao diện EZScript
getgenv().ScriptTitle = "XUANBACH HUB"
getgenv().ScriptSubTitle = "Blox Fruits Full Ultimate"
getgenv().ScriptImage = "https://i.ibb.co/7dNHzCWR/1794582536330.png"
getgenv().ScriptAuthorName = "Bach"
getgenv().ScriptAuthorSubTitle = "Developer"

-- Tải khung giao diện gốc từ EZScript
pcall(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/hoannhatz/Script/refs/heads/main/EZScript.lua"))()
end)

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

--// HỆ THỐNG ANTI-BAN AN TOÀN CAO CẤP (BYPASS & MASKING)
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

--// DATA (Full Sea 1, 2, 3)
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

local BOSSES = {
	"Gorilla King", "Bobby", "Yeti", "Vice Admiral", "Saber Expert", "Warden", "Chief Warden",
	"Swan", "Magma Admiral", "Fishman Lord", "Wysper", "Thunder God", "Cyborg", "Ice Admiral",
	"Greybeard", "Cursed Captain", "Darkbeard", "Order", "Stone", "Island Empress",
	"Kilo Admiral", "Captain Elephant", "Beautiful Pirate", "Longma", "Soul Reaper", "Cake Prince",
}

local SEA_EVENTS = {"Cake Prince", "Dough King", "Rip_Indra", "Terrorshark", "Leviathan"}
local SEA_MONSTERS = {"Terrorshark", "Piranha", "Sea Beast", "Fish Crew Member", "Sloop"}

local STYLES = {
	"Black Leg", "Electro", "Fishman Karate", "Dragon Claw", "Superhuman",
	"Sharkman Karate", "Death Step", "Electric Claw", "Dragon Talon", "Godhuman", "Sanguine Art",
}
local STYLE_REMOTE = {
	["Black Leg"] = "BuyBlackLeg", ["Electro"] = "BuyElectro", ["Fishman Karate"] = "BuyFishmanKarate",
	["Dragon Claw"] = "BuyDragonClaw", ["Superhuman"] = "BuySuperhuman", ["Sharkman Karate"] = "BuySharkmanKarate",
	["Death Step"] = "BuyDeathStep", ["Electric Claw"] = "BuyElectricClaw", ["Dragon Talon"] = "BuyDragonTalon",
	["Godhuman"] = "BuyGodhuman", ["Sanguine Art"] = "BuySanguineArt",
}

local ISLANDS = {
	"Starter Island", "Jungle", "Pirate Village", "Desert", "Frozen Village", "Marine Fortress",
	"Skylands", "Prison", "Colosseum", "Magma Village", "Underwater City", "Fountain City",
	"Kingdom of Rose", "Green Zone", "Graveyard", "Snow Mountain", "Hot and Cold", "Cursed Ship",
	"Ice Castle", "Forgotten Island", "Port Town", "Hydra Island", "Great Tree", "Castle on the Sea", "Tiki Outpost",
}

local CHIPS = {"Flame", "Ice", "Quake", "Light", "Dark", "Spider", "Rumble", "Magma", "Buddha", "Sand", "Phoenix", "Dough"}

--// STATE
local S = {
	Running = true, Farm = false, FarmMode = "Level", Weapon = "Melee",
	BringMob = true, BringRange = 280, SafeMode = true,
	AutoStats = false, StatType = "Melee", StatPoints = 3,
	AutoSkill = false, SkillZ = true, SkillX = true, SkillC = true, SkillV = false,
	AutoChest = false, AutoFactory = false, AutoPirateRaid = false,
	AutoRaid = false, SelectedChip = "Flame", AutoNextIsland = false,
	Boss = false, SelectedBoss = BOSSES[1], AutoAllBoss = false,
	SeaEvent = false, SelectedSea = SEA_EVENTS[1], SeaMonster = false,
	Style = false, StyleList = {STYLES[1]}, HiddenQuest = false,
	Fast = false, Haki = false, Ken = false, Aura = false, AuraRange = 80,
	Hitbox = false, HitboxSize = 20,
	PlayerESP = false, ChestESP = false, FruitPick = false, FruitStore = false, FruitESP = false,
	RaceV4 = false, SpeedOn = false, Speed = 16, JumpOn = false, JumpPower = 50,
	Fly = false, FlySpeed = 80, Noclip = false, InfJump = false, WalkOnWater = false,
	AntiAFK = true, TweenSpeed = 350, Perf = IS_MOBILE,
	Tweening = false, SelectedIsland = ISLANDS[1],
}

--// HELPERS
local function hrp()
	local c = LP.Character
	return c and c:FindFirstChild("HumanoidRootPart")
end
local function hum()
	local c = LP.Character
	return c and c:FindFirstChildOfClass("Humanoid")
end
local function alive(m)
	local h = m and m:FindFirstChildOfClass("Humanoid")
	return h ~= nil and h.Health > 0
end
local function invoke(...)
	local ok, res = pcall(CommF.InvokeServer, CommF, ...)
	if ok then return res end
end
local function enemiesFolder()
	return Workspace:FindFirstChild("Enemies")
end
local function locate(name)
	local map = Workspace:FindFirstChild("Map")
	local m = map and map:FindFirstChild(name)
	return m or Workspace:FindFirstChild(name, true)
end
local function modelCF(m)
	if m:IsA("Model") then return m:GetPivot() end
	if m:IsA("BasePart") then return m.CFrame end
end

--// NOCLIP & WALK ON WATER
RunService.Stepped:Connect(function()
	local c = LP.Character
	if c and (S.Noclip or S.Tweening or S.Farm or S.AutoChest) then
		for _, p in ipairs(c:GetDescendants()) do
			if p:IsA("BasePart") then p.CanCollide = false end
		end
	end
	if S.WalkOnWater then
		local map = Workspace:FindFirstChild("Map")
		local water = map and map:FindFirstChild("WaterBase-Plane")
		if water and water:IsA("BasePart") then
			water.CanCollide = true
			water.Size = Vector3.new(10000, 1, 10000)
		end
	end
end)

--// TWEEN AN TOÀN
local activeTween
local function tweenTo(cf)
	local root = hrp()
	if not root then return end
	local dist = (root.Position - cf.Position).Magnitude
	if dist < 4 then root.CFrame = cf return end
	local dur = math.max(dist / S.TweenSpeed, 0.05)
	if activeTween then activeTween:Cancel() end
	S.Tweening = true
	local tw = TweenService:Create(root, TweenInfo.new(dur, Enum.EasingStyle.Linear), {CFrame = cf})
	activeTween = tw
	tw:Play()
	local t0 = os.clock()
	while tw.PlaybackState == Enum.PlaybackState.Playing and os.clock() - t0 < dur + 1 do
		if not S.Running then tw:Cancel() break end
		task.wait()
	end
	S.Tweening = false
	local r = hrp()
	if r then r.AssemblyLinearVelocity = Vector3.zero end
end

--// GOM QUÁI VÀ FARM
local function findEnemy(names, maxDist)
	local root, folder = hrp(), enemiesFolder()
	if not root or not folder then return nil end
	local best, bd = nil, maxDist or math.huge
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
	local folder = enemiesFolder()
	if not folder then return end
	for _, m in ipairs(folder:GetChildren()) do
		local r = m:FindFirstChild("HumanoidRootPart")
		local h = m:FindFirstChildOfClass("Humanoid")
		if r and h and h.Health > 0 and (not names or table.find(names, m.Name)) then
			local dist = (r.Position - targetPos).Magnitude
			if dist <= S.BringRange and dist > 3 then
				r.CFrame = CFrame.new(targetPos + Vector3.new(0, 2, 0))
				r.AssemblyLinearVelocity = Vector3.zero
				pcall(function()
					h.Sit = true
					sethiddenproperty(LP, "SimulationRadius", math.huge)
				end)
			end
		end
	end
end

local function equipKind(kind)
	local c = LP.Character
	local bp = LP:FindFirstChild("Backpack")
	if not c or not bp then return end
	local cur = c:FindFirstChildOfClass("Tool")
	if cur and cur.ToolTip == kind then return end
	for _, t in ipairs(bp:GetChildren()) do
		if t:IsA("Tool") and t.ToolTip == kind then
			local h = hum()
			if h then h:EquipTool(t) end
			return
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
	local keys = {}
	if S.SkillZ then table.insert(keys, Enum.KeyCode.Z) end
	if S.SkillX then table.insert(keys, Enum.KeyCode.X) end
	if S.SkillC then table.insert(keys, Enum.KeyCode.C) end
	if S.SkillV then table.insert(keys, Enum.KeyCode.V) end
	for _, k in ipairs(keys) do
		pcall(function()
			vim:SendKeyEvent(true, k, false, game)
			task.wait(0.04)
			vim:SendKeyEvent(false, k, false, game)
		end)
	end
end

local function stick(m, names)
	local root, mr = hrp(), m:FindFirstChild("HumanoidRootPart")
	if root and mr then
		root.CFrame = CFrame.new(mr.Position + Vector3.new(0, 7, 0), mr.Position)
		root.AssemblyLinearVelocity = Vector3.zero
		bringMobs(mr.Position, names)
	end
end

local function huntStep(names, maxDist)
	local m = findEnemy(names, maxDist)
	if not m then return false end
	local root = hrp()
	if not root then return false end
	equipKind(S.Weapon)
	local mr = m:FindFirstChild("HumanoidRootPart")
	if mr and (root.Position - mr.Position).Magnitude > 50 then
		tweenTo(CFrame.new(mr.Position + Vector3.new(0, 10, 0)))
	end
	if mr then stick(m, names) end
	attack()
	useSkills()
	return true
end

--// QUEST LOOP
local function getQuest()
	local lv = LP.Data.Level.Value
	for _, q in ipairs(QUESTS) do
		if lv >= q.Min and lv <= q.Max then return q end
	end
	return QUESTS[#QUESTS]
end

local function questActive(q)
	local ok, txt = pcall(function()
		return LP.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text
	end)
	return ok and type(txt) == "string" and txt:find(q.Mob, 1, true) ~= nil
end

task.spawn(function()
	while S.Running do
		if S.Farm then
			pcall(function()
				local names
				if S.FarmMode == "Level" then
					local q = getQuest()
					if not q then return end
					if not questActive(q) then
						invoke("StartQuest", q.Quest, q.QLv)
						task.wait(0.5)
						return
					end
					names = {q.Mob}
				elseif S.FarmMode == "Bone" then names = BONE_MOBS
				elseif S.FarmMode == "Cake" then names = CAKE_MOBS
				elseif S.FarmMode == "Nearest" then names = nil end
				huntStep(names)
			end)
		end
		task.wait(0.04)
	end
end)

--// CÁC LUỒNG TỰ ĐỘNG KHÁC
task.spawn(function()
	while S.Running do
		if S.AutoStats then
			pcall(function()
				local pts = LP.Data.Points.Value
				if pts > 0 then invoke("AddPoint", S.StatType, math.min(pts, S.StatPoints)) end
			end)
		end
		if S.AutoChest then
			pcall(function()
				local root = hrp()
				if not root then return end
				local bestChest, dist = nil, math.huge
				for _, v in ipairs(Workspace:GetDescendants()) do
					if v:IsA("BasePart") and v.Name:find("Chest") and v.Transparency < 1 then
						local d = (v.Position - root.Position).Magnitude
						if d < dist then bestChest, dist = v, d end
					end
				end
				if bestChest then
					tweenTo(bestChest.CFrame)
					pcall(firetouchinterest, root, bestChest, 0)
					pcall(firetouchinterest, root, bestChest, 1)
				end
			end)
		end
		task.wait(0.5)
	end
end)

task.spawn(function()
	while S.Running do
		if S.AutoFactory then pcall(huntStep, {"Core"}) end
		if S.AutoPirateRaid then
			pcall(function()
				local castle = locate("Castle on the Sea")
				local cf = castle and modelCF(castle)
				local root = hrp()
				if root and cf and (root.Position - cf.Position).Magnitude > 400 then
					tweenTo(cf + Vector3.new(0, 20, 0))
				else
					huntStep(nil, 450)
				end
			end)
		end
		if S.AutoRaid then
			pcall(function()
				local raidTimer = LP.PlayerGui.Main.Timer.Visible
				if not raidTimer then
					invoke("RaidsNpc", "Select", S.SelectedChip)
					task.wait(1)
				else
					if not huntStep(nil, 800) and S.AutoNextIsland then
						for i = 5, 1, -1 do
							local isl = Workspace:FindFirstChild("Map") and Workspace.Map:FindFirstChild("RaidMap") and Workspace.Map.RaidMap:FindFirstChild("Island " .. i)
							if isl then tweenTo(isl:GetPivot() + Vector3.new(0, 30, 0)) break end
						end
					end
				end
			end)
		end
		if S.AutoAllBoss then pcall(huntStep, BOSSES)
		elseif S.Boss then pcall(huntStep, {S.SelectedBoss}) end
		if S.SeaEvent then pcall(huntStep, {S.SelectedSea}) end
		if S.SeaMonster then pcall(huntStep, SEA_MONSTERS) end
		if S.Style then
			for _, style in ipairs(S.StyleList) do
				local remote = STYLE_REMOTE[style]
				if remote then invoke(remote) end
				task.wait(1)
			end
		end
		task.wait(0.2)
	end
end)

task.spawn(function()
	while S.Running do
		if S.Fast or S.Aura then
			local root, folder = hrp(), enemiesFolder()
			local inRange = false
			if root and folder then
				local range = S.Aura and S.AuraRange or 25
				for _, m in ipairs(folder:GetChildren()) do
					local r = m:FindFirstChild("HumanoidRootPart")
					if r and alive(m) and (r.Position - root.Position).Magnitude <= range then
						inRange = true
						break
					end
				end
			end
			if inRange or S.Fast then attack() end
			task.wait(0.015)
		else
			task.wait(0.2)
		end
	end
end)

task.spawn(function()
	while S.Running do
		local c = LP.Character
		if S.Haki and c and not c:FindFirstChild("HasBuso") then invoke("Buso") end
		if S.Ken then
			pcall(function()
				local vim = game:GetService("VirtualInputManager")
				if not LP.PlayerGui.Main.Observation.Visible then
					vim:SendKeyEvent(true, Enum.KeyCode.E, false, game)
					task.wait(0.05)
					vim:SendKeyEvent(false, Enum.KeyCode.E, false, game)
				end
			end)
		end
		task.wait(1.5)
	end
end)

--// ESP & FRUIT
local function fruitTools()
	local out = {}
	for _, o in ipairs(Workspace:GetChildren()) do
		if o:IsA("Tool") and o:FindFirstChild("Handle") and (o.ToolTip == "Blox Fruit" or o.Name:find("Fruit")) then
			table.insert(out, o)
		end
	end
	return out
end

task.spawn(function()
	while S.Running do
		if S.FruitPick then
			for _, f in ipairs(fruitTools()) do
				if not S.FruitPick then break end
				if f.Parent == Workspace and f:FindFirstChild("Handle") then
					tweenTo(f.Handle.CFrame)
					task.wait(0.2)
					local r = hrp()
					if r and f.Parent == Workspace then
						pcall(firetouchinterest, r, f.Handle, 0)
						pcall(firetouchinterest, r, f.Handle, 1)
					end
				end
			end
		end
		if S.FruitStore then
			for _, t in ipairs(LP.Backpack:GetChildren()) do
				if t:IsA("Tool") and t.ToolTip == "Blox Fruit" then
					local key = (t.Name:gsub("%s*Fruit$", ""))
					invoke("StoreFruit", key, "Inventory")
				end
			end
		end
		task.wait(1)
	end
end)

--// MOVEMENT & ANTI AFK
RunService.Heartbeat:Connect(function()
	local h = hum()
	if not h then return end
	if S.SpeedOn then h.WalkSpeed = S.Speed end
	if S.JumpOn then h.UseJumpPower = true h.JumpPower = S.JumpPower end
end)

LP.Idled:Connect(function()
	if S.AntiAFK then VirtualUser:CaptureController() VirtualUser:ClickButton2(Vector2.new()) end
end)

print("XuanBACH HUB - Full Ultimate Engine Loaded Successfully!")
