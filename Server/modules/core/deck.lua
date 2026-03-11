SNX = SNX or {}
SNX.StealTheHat = SNX.StealTheHat or {}
SNX.StealTheHat.Deck = SNX.StealTheHat.Deck or {}

Events.SubscribeRemote("SNX::STH::Deck::UsePerk", function(pPlayer, nSlotID)
	if (not pPlayer or not pPlayer:IsValid()) then return end
	---@type STHCharacter
	local eCharacter = pPlayer:GetControlledCharacter()
	if (not eCharacter or not eCharacter:IsValid()) then return end
	eCharacter:UsePerk(nSlotID)
end)
