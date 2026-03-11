local tDeckKeys = { "One", "Two", "Three" }

Input.Subscribe("KeyUp", function(sKey)
	for nIndex, sValue in pairs(tDeckKeys) do
		if (sKey == sValue) then
			local pPlayer = Client.GetLocalPlayer()
			---@type STHCharacter
			local eCharacter = pPlayer:GetControlledCharacter()
			if (eCharacter and eCharacter:IsValid() and eCharacter:IsA(STHCharacter)) then
				eCharacter:UsePerk(nIndex)
			end
			break
		end
	end
end)
