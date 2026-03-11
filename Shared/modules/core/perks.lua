SNX = SNX or {}
SNX.StealTheHat = SNX.StealTheHat or {}
SNX.StealTheHat.Perks = SNX.StealTheHat.Perks or {}

SNX.StealTheHat.Perks.tPerks = {}

---@param tPerk STHPerk
function SNX.StealTheHat.Perks:RegisterPerk(tPerk)
	SNX.StealTheHat.Perks.tPerks[tPerk.__sPerkUID] = tPerk
end

---@param sPerkUID string
---@return STHPerk
function SNX.StealTheHat.Perks:GetPerk(sPerkUID)
	return (SNX.StealTheHat.Perks.tPerks[sPerkUID])
end

if (Client) then
	---@param nDuration number
	Events.SubscribeRemote("SNX::STH::Perks::StartTimer", function(nDuration)
		local pLocal = Client.GetLocalPlayer()
		if (not pLocal or not pLocal:IsValid()) then return end
		---@type STHCharacter
		local eCharacter = pLocal:GetControlledCharacter()
		if (not eCharacter or not eCharacter:IsValid() or not eCharacter:IsA(STHCharacter)) then return end
		eCharacter:StartPerkTimer(nDuration)
	end)
end
