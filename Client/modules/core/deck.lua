local tDeckKeys = {
	{ "One", "NumPadOne", "Ampersand" },
	{ "Two", "NumPadTwo", "E_AccentAigu" },
	{ "Three", "NumPadThree", "Quote" }
}

Input.Subscribe("KeyUp", function(sKey)
	for nIndex, tKeys in pairs(tDeckKeys) do
		for _, sDeckKey in pairs(tKeys) do
			if (sKey == sDeckKey) then
				local pPlayer = Client.GetLocalPlayer()
				---@type STHCharacter
				local eCharacter = pPlayer:GetControlledCharacter()
				if (eCharacter and eCharacter:IsValid() and eCharacter:IsA(STHCharacter)) then
					eCharacter:UsePerk(nIndex)
				end
				break
			end
		end
	end
end)
