SNX = SNX or {}
SNX.StealTheHat = SNX.StealTheHat or {}

---@param sText string
---@param sColor notif_colors
---@param bBold? boolean
function SNX.StealTheHat:FormatText(sText, sColor, bBold)
	return ({ sText = sText, sColor = sColor, bBold = bBold })
end
