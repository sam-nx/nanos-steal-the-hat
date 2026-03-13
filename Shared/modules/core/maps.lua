SNX = SNX or {}
SNX.StealTheHat = SNX.StealTheHat or {}
SNX.StealTheHat.Maps = SNX.StealTheHat.Maps or {}

SNX.StealTheHat.Maps.tMaps = SNX.StealTheHat.Maps.tMaps or {}

---@param sMapName string
---@return table
function SNX.StealTheHat.Maps:GetMap(sMapName)
	return (SNX.StealTheHat.Maps.tMaps[sMapName])
end
