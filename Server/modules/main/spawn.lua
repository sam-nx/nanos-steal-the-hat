---@param pPlayer Player
local function spawnPlayer(pPlayer)
	local eCharacter = STHCharacter(Vector(0, 0, 0), Rotator(0, 0, 0), "nanos-world::SK_Male")
	pPlayer:Possess(eCharacter)
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
	spawnPlayer(pPlayer)
end)

Player.Subscribe("Destroy", function(pPlayer)
	destroyPlayer(pPlayer)
end)
