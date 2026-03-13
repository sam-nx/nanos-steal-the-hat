SNX = SNX or {}
SNX.StealTheHat = SNX.StealTheHat or {}
SNX.StealTheHat.Maps = SNX.StealTheHat.Maps or {}
SNX.StealTheHat.Maps.tMaps = SNX.StealTheHat.Maps.tMaps or {}

local tDebugEnts = {}

local function debugCleanup()
	---@param eEntity STHCharacter|STHPerkDrop
	for _, eEntity in pairs(tDebugEnts) do
		if (eEntity and eEntity:IsValid()) then
			eEntity:Destroy()
		end
	end
end

function Player:STHSpawn()
	local tCharacterPosition = Vector(0, 0, 0)
	local tMapData = SNX.StealTheHat.Maps:GetMap(Server.GetMapAsset())

	if (tMapData) then
		tCharacterPosition = tMapData.tPlayerSpawns[math.random(1, #tMapData.tPlayerSpawns)]
		for _, tPerkSpawn in ipairs(tMapData.tPerkSpawns) do
			local ePerk = STHPerkDrop("test_one_punch_man", tPerkSpawn, Rotator(0, 0, 0), "nanos-world::SM_Cube",
				CollisionType.NoCollision, Color(0, 0, 1))
			table.insert(tDebugEnts, ePerk)
		end
	end

	local eTestCharacter = STHCharacter(Vector(0, 0, 100), Rotator(0, 0, 0), "nanos-world::SK_Mannequin")
	eTestCharacter:GiveHat()

	table.insert(tDebugEnts, eTestCharacter)

	local eCharacter = STHCharacter(tCharacterPosition, Rotator(0, 0, 0), "nanos-world::SK_Male")
	self:Possess(eCharacter)
end

function Player:STHDestroy()
	local eCharacter = self:GetControlledCharacter()
	if (eCharacter) then
		eCharacter:Destroy()
	end
	debugCleanup()
end

Package.Subscribe("Load", function()
	-- ---@param pPlayer Player
	-- for _, pPlayer in ipairs(Player.GetAll()) do
	-- 	pPlayer:STHSpawn()
	-- end
end)

Player.Subscribe("Spawn", function(pPlayer)
	SNX.StealTheHat:Broadcast({
		SNX.StealTheHat:FormatText(pPlayer:GetName(), NOTIF_COLORS.green, true),
		SNX.StealTheHat:FormatText("joined the game", NOTIF_COLORS.gray),
	})
	-- pPlayer:STHSpawn()
end)

Player.Subscribe("Destroy", function(pPlayer)
	SNX.StealTheHat:Broadcast({
		SNX.StealTheHat:FormatText(pPlayer:GetName(), NOTIF_COLORS.red, true),
		SNX.StealTheHat:FormatText("left the game", NOTIF_COLORS.gray),
	})
	pPlayer:STHDestroy()
end)
