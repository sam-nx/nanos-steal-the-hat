---@class STHPerk: StaticMesh
STHPerk = StaticMesh.Inherit("STHPerk")

---@return string
function STHPerk:GetPerk()
	return (self:GetValue("SNX::STH::sPerk", ""))
end
