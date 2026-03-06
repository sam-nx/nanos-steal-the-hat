SNX = SNX or {}
SNX.StealTheHat = SNX.StealTheHat or {}

---@param pPlayer Player
local function spawnPlayer(pPlayer)
	local eCharacter = STHCharacter(Vector(0, 0, 0), Rotator(0, 0, 0), "nanos-world::SK_Male")
	pPlayer:Possess(eCharacter)
	eCharacter:AttachHat()
	Timer.SetTimeout(function()
		eCharacter:SetRagdollMode(true)
		eCharacter:DetachHat()
		SNX.StealTheHat:Broadcast({
			SNX.StealTheHat:FormatText("SamNx", NOTIF_COLORS.orange, true),
			SNX.StealTheHat:FormatText("was knocked out by", NOTIF_COLORS.gray),
			SNX.StealTheHat:FormatText("QuenK", NOTIF_COLORS.blue, true)
		})

		SNX.StealTheHat:Broadcast({
			SNX.StealTheHat:FormatText("QuenK", NOTIF_COLORS.orange, true),
			SNX.StealTheHat:FormatText("stole the hat !", NOTIF_COLORS.gray),
		})
	end, 2000)

	Timer.SetTimeout(function()
		eCharacter:SetRagdollMode(false)
	end, 6000)

	Timer.SetInterval(function()
		eCharacter:AddScore(50)
	end, 1500)
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
