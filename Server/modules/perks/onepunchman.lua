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
