Input.Register("Steal The Hat - Use Deck Slot 1", "NumPadOne", "Use the slot #1 of your deck")
Input.Register("Steal The Hat - Use Deck Slot 2", "NumPadTwo", "Use the slot #2 of your deck")
Input.Register("Steal The Hat - Use Deck Slot 3", "NumPadThree", "Use the slot #3 of your deck")

for i = 1, 3 do
	Input.Bind("Steal The Hat - Use Deck Slot " .. i, InputEvent.Released, function()
		local pPlayer = Client.GetLocalPlayer()
		---@type STHCharacter
		local eCharacter = pPlayer:GetControlledCharacter()
		if (eCharacter and eCharacter:IsValid() and eCharacter:IsA(STHCharacter)) then
			eCharacter:UsePerk(i)
		end
	end)
end

-- local tDeckKeys = {
-- 	{ "One", "NumPadOne", "Ampersand" },
-- 	{ "Two", "NumPadTwo", "E_AccentAigu" },
-- 	{ "Three", "NumPadThree", "Quote" }
-- }

-- Input.Subscribe("KeyUp", function(sKey)
-- 	for nIndex, tKeys in pairs(tDeckKeys) do
-- 		for _, sDeckKey in pairs(tKeys) do
-- 			if (sKey == sDeckKey) then
-- 				local pPlayer = Client.GetLocalPlayer()
-- 				---@type STHCharacter
-- 				local eCharacter = pPlayer:GetControlledCharacter()
-- 				if (eCharacter and eCharacter:IsValid() and eCharacter:IsA(STHCharacter)) then
-- 					eCharacter:UsePerk(nIndex)
-- 				end
-- 				break
-- 			end
-- 		end
-- 	end
-- end)
