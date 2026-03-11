SNX = SNX or {}
SNX.StealTheHat = SNX.StealTheHat or {}
SNX.StealTheHat.Perks = SNX.StealTheHat.Perks or {}

Timer.SetTimeout(function()
	local tOnePunchMan = STHPerk("test_one_punch_man")
	tOnePunchMan:SetName("One Punch Man")
	tOnePunchMan:SetDuration(10)
	tOnePunchMan:SetUIIcon("RiHand", "#0085FF")
	tOnePunchMan:SetExecute(function(eCharacter)
		print("Executed One Punch Man", eCharacter)
		eCharacter:SetValue("SNX::STH::Perks::bOnePunchMan", true)
	end)
	tOnePunchMan:SetOnEnd(function(eCharacter)
		print("End of One Punch Man")
		eCharacter:SetValue("SNX::STH::Perks::bOnePunchMan", false)
	end)

	SNX.StealTheHat.Perks:RegisterPerk(tOnePunchMan)

	if (Server) then
		---@param eCharacter STHCharacter
		---@param eCauser STHCharacter
		STHCharacter.Subscribe("TakeDamage", function(eCharacter, nDamage, _, _, _, pInstigator, eCauser)
			if (not eCharacter or not eCharacter:IsValid()) then return end
			if (not eCauser or not eCauser:IsValid()) then return end
			if (not eCharacter:IsA(STHCharacter) or not eCauser:IsA(STHCharacter)) then return end

			if (eCauser:GetValue("SNX::STH::Perks::bOnePunchMan", false)) then
				eCharacter:SetHealth(1)
				eCharacter:SetStuned(true)
				Events.Call("SNX::STH::Character::Stun", eCharacter, eCauser, pInstigator)
				return (false)
			end
		end)
	end
end, 100)
