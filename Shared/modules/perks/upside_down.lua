SNX = SNX or {}
SNX.StealTheHat = SNX.StealTheHat or {}
SNX.StealTheHat.Perks = SNX.StealTheHat.Perks or {}

Timer.SetTimeout(function()
	local tUpsideDown = STHPerk("upside_down")
	tUpsideDown:SetName("Tête à l'Envers")
	tUpsideDown:SetDuration(15)
	tUpsideDown:SetUIIcon("RiArrowUpDownLine", "#9B59B6")
	tUpsideDown:SetExecute(function(eCharacter)
		print("Executed upside_down", eCharacter)

		-- Save original values
		local nOriginalCameraMode = eCharacter:GetCameraMode()
		local nOriginalSpeedMultiplier = eCharacter:GetSpeedMultiplier()
		eCharacter:SetValue("SNX::STH::Perks::nOriginalCameraMode", nOriginalCameraMode)
		eCharacter:SetValue("SNX::STH::Perks::nOriginalSpeedMultiplier", nOriginalSpeedMultiplier)

		eCharacter:SetScale(Vector(1, 1, -1))
		eCharacter:SetAirControl(1, 1000)
		eCharacter:SetSpeedMultiplier(nOriginalSpeedMultiplier * 3)
		eCharacter:SetFallDamageTaken(0)

		eCharacter:SetValue("SNX::STH::Perks::bUpsideDown", true)
	end)
	tUpsideDown:SetOnEnd(function(eCharacter)
		print("End of upside_down")

		eCharacter:SetScale(Vector(1, 1, 1))

		local nOriginalSpeedMultiplier = eCharacter:GetValue("SNX::STH::Perks::nOriginalSpeedMultiplier", 1)
		eCharacter:SetAirControl(0.2, 512)
		eCharacter:SetSpeedMultiplier(nOriginalSpeedMultiplier)
		eCharacter:SetFallDamageTaken(10)

		local nOriginalCameraMode = eCharacter:GetValue("SNX::STH::Perks::nOriginalCameraMode", CameraMode.TPS3)
		eCharacter:SetCameraMode(nOriginalCameraMode)

		eCharacter:SetValue("SNX::STH::Perks::bUpsideDown", false)
		eCharacter:SetValue("SNX::STH::Perks::nOriginalCameraMode", nil)
		eCharacter:SetValue("SNX::STH::Perks::nOriginalSpeedMultiplier", nil)
	end)

	SNX.StealTheHat.Perks:RegisterPerk(tUpsideDown)
end, 100)
