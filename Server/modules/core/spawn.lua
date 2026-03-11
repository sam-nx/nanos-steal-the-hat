SNX = SNX or {}
SNX.StealTheHat = SNX.StealTheHat or {}

---@param pPlayer Player
local function spawnPlayer(pPlayer)
	local eCharacter = STHCharacter(Vector(0, 0, 0), Rotator(0, 0, 0), "nanos-world::SK_Male")
	pPlayer:Possess(eCharacter)

	local eTestCharacter = STHCharacter(Vector(100, 0, 0), Rotator(0, 0, 0), "nanos-world::SK_Mannequin")
	eTestCharacter:GiveHat()

	local ePerk = STHPerkDrop("test_one_punch_man", Vector(300, 0, 100), Rotator(0, 0, 0), "nanos-world::SM_Cube",
		CollisionType.NoCollision,
		Color(0, 0, 1))

	local ePerk2 = STHPerkDrop("test_one_punch_man", Vector(500, 0, 100), Rotator(0, 0, 0), "nanos-world::SM_Cube",
		CollisionType.NoCollision,
		Color(0, 0, 1))

	local ePerk3 = STHPerkDrop("test_one_punch_man", Vector(700, 0, 100), Rotator(0, 0, 0), "nanos-world::SM_Cube",
		CollisionType.NoCollision,
		Color(0, 0, 1))

	local ePerk4 = STHPerkDrop("test_one_punch_man", Vector(900, 0, 100), Rotator(0, 0, 0), "nanos-world::SM_Cube",
		CollisionType.NoCollision,
		Color(0, 0, 1))

	-- 	eTestCharacter:Destroy()
	-- end, 7000)

	-- Timer.SetInterval(function()
	-- 	eCharacter:AddScore(50)
	-- end, 1500)
end

---@param pPlayer Player
local function destroyPlayer(pPlayer)
	local eCharacter = pPlayer:GetControlledCharacter()
	if (eCharacter) then
		eCharacter:Destroy()
	end
end

Package.Subscribe("Load", function()
	for _, pPlayer in ipairs(Player.GetAll()) do
		spawnPlayer(pPlayer)
	end
end)

Player.Subscribe("Spawn", function(pPlayer)
	SNX.StealTheHat:Broadcast({
		SNX.StealTheHat:FormatText(pPlayer:GetName(), NOTIF_COLORS.green, true),
		SNX.StealTheHat:FormatText("joined the game", NOTIF_COLORS.gray),
	})
	spawnPlayer(pPlayer)
end)

Player.Subscribe("Destroy", function(pPlayer)
	SNX.StealTheHat:Broadcast({
		SNX.StealTheHat:FormatText(pPlayer:GetName(), NOTIF_COLORS.red, true),
		SNX.StealTheHat:FormatText("left the game", NOTIF_COLORS.gray),
	})
	destroyPlayer(pPlayer)
end)
