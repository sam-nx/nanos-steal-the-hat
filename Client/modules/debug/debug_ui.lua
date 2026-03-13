SNX = SNX or {}
SNX.StealTheHat = SNX.StealTheHat or {}
SNX.StealTheHat.Data = SNX.StealTheHat.Data or {}

local oCanvas = Canvas(
	true,
	Color.TRANSPARENT,
	0,
	true
)

oCanvas:Subscribe("Update", function(self, nW, nH)
	self:DrawText("Game status: " .. tostring(SNX.StealTheHat.Data.bGAME_STATUS), Vector2D(10, 120))
	self:DrawText("Current phase: " .. tostring(SNX.StealTheHat.Data.nGAME_PHASE), Vector2D(10, 140))
	self:DrawText("Prep phase end: " .. tostring(SNX.StealTheHat.Data.nPREP_PHASE_END), Vector2D(10, 160))
	self:DrawText("Match phase end: " .. tostring(SNX.StealTheHat.Data.nPREP_PHASE_END), Vector2D(10, 180))
	self:DrawText("End game phase end: " .. tostring(SNX.StealTheHat.Data.nPREP_PHASE_END), Vector2D(10, 200))
	self:DrawText(JSON.stringify(SNX.StealTheHat.Data), Vector2D(10, 220))

	---@param eCharacter STHCharacter
	for _, eCharacter in ipairs(STHCharacter.GetAll()) do
		local pPlayer = eCharacter:GetPlayer()
		self:DrawText(pPlayer and pPlayer:GetName() or "Unknown",
			Viewport.ProjectWorldToScreen(eCharacter:GetLocation()) + Vector2D(0, -200))
		self:DrawText(eCharacter:GetHealth() .. "/" .. eCharacter:GetMaxHealth(),
			Viewport.ProjectWorldToScreen(eCharacter:GetLocation()) + Vector2D(0, -180))
	end
end)

oCanvas:Repaint()
