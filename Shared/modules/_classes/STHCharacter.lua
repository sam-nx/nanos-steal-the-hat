---@class STHCharacter: Character
STHCharacter = Character.Inherit("STHCharacter")

---@return boolean
function STHCharacter:GetStuned()
	return (self:GetValue("SNX::STH::bStuned", false))
end

---@return boolean
function STHCharacter:GetHasHat()
	return (self:GetValue("SNX::STH::bHasHat", false))
end

---@return number
function STHCharacter:GetScore()
	return (self:GetValue("SNX::STH::nScore", 0))
end

---@return number
function STHCharacter:GetPRScore()
	return (self:GetValue("SNX::STH::nPRScore", 0))
end

---@return table
function STHCharacter:GetDeck()
	return (self:GetValue("SNX::STH::Deck::tDeck", {}))
end

---@param nSlotID number
function STHCharacter:UsePerk(nSlotID)
	if (not nSlotID or nSlotID < 1 or nSlotID > 3) then return end
	if (self:GetCurrentPerk()) then return end
	if (Client) then
		Events.CallRemote("SNX::STH::Deck::UsePerk", nSlotID)
	else
		local tDeck = self:GetDeck()
		local tPerk = tDeck[nSlotID]
		tPerk = SNX.StealTheHat.Perks:GetPerk(tPerk and tPerk.sPerkUID or nil)
		if (not tPerk) then return end
		tDeck[nSlotID] = nil
		self:SetDeck(tDeck)
		tPerk:Execute(self)
	end
end

---@return STHPerk
function STHCharacter:GetCurrentPerk()
	return (SNX.StealTheHat.Perks:GetPerk(self:GetValue("SNX::STH::sCurrentPerk", nil)))
end

---@param nDuration number
function STHCharacter:StartPerkTimer(nDuration)
	if (Client) then
		self:SetValue("SNX::STH::Perks::nCurrentPerkTimeLeft", Client.GetTime() + (nDuration * 1000))
	else
		local pPlayer = self:GetPlayer()
		if (not pPlayer or not pPlayer:IsValid()) then return end
		Events.CallRemote("SNX::STH::Perks::StartTimer", pPlayer, nDuration)
	end
end
