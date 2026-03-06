---@param tLocation Vector
---@param tRotation Rotator
---@param sMesh string
function STHCharacter:Constructor(tLocation, tRotation, sMesh)
	self.Super:Constructor(tLocation, tRotation, sMesh)
	self:SetValue("SNX::STH::bStuned", false, true)
	self:SetValue("SNX::STH::bHasHat", false, true)
	self:SetValue("SNX::STH::nScore", 0, true)
	self:SetValue("SNX::STH::nPRScore", 0, true)
end

---@param bStuned boolean
function STHCharacter:SetStuned(bStuned)
	self:SetValue("SNX::STH::bStuned", bStuned, true)
end

---@param bHasHat boolean
function STHCharacter:SetHasHat(bHasHat)
	self:SetValue("SNX::STH::bHasHat", bHasHat, true)
end

---@param nScore number
function STHCharacter:SetScore(nScore)
	self:SetValue("SNX::STH::nScore", nScore, true)
end

---@param nPRScore number
function STHCharacter:SetPRScore(nPRScore)
	self:SetValue("SNX::STH::nPRScore", nPRScore, true)
end
