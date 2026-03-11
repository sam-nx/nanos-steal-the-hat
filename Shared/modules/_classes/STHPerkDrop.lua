---@class STHPerkDrop: StaticMesh
STHPerkDrop = StaticMesh.Inherit("STHPerkDrop")

---@return string
function STHPerkDrop:GetPerk()
	return (self:GetValue("SNX::STH::sPerk", ""))
end
