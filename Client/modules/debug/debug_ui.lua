SNX = SNX or {}
SNX.StealTheHat = SNX.StealTheHat or {}
SNX.StealTheHat._DATA = SNX.StealTheHat._DATA or {}

local oCanvas = Canvas(
	true,
	Color.TRANSPARENT,
	0,
	true
)

oCanvas:Subscribe("Update", function(self, nW, nH)
	self:DrawText("Game status: " .. tostring(SNX.StealTheHat._DATA.bGAME_STATUS), Vector2D(10, 10))
	self:DrawText("Current phase: " .. tostring(SNX.StealTheHat._DATA.nGAME_PHASE), Vector2D(10, 30))
	self:DrawText("Prep phase end: " .. tostring(SNX.StealTheHat._DATA.nPREP_PHASE_END), Vector2D(10, 50))
	self:DrawText("Match phase end: " .. tostring(SNX.StealTheHat._DATA.nPREP_PHASE_END), Vector2D(10, 70))
	self:DrawText("End game phase end: " .. tostring(SNX.StealTheHat._DATA.nPREP_PHASE_END), Vector2D(10, 90))
	self:DrawText(JSON.stringify(SNX.StealTheHat._DATA), Vector2D(10, 110))
end)

oCanvas:Repaint()
