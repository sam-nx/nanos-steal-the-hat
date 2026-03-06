---@class STHCharacter: Character
STHCharacter = Character.Inherit("STHCharacter")

---@return boolean
function STHCharacter:GetStuned()
	return (self:GetValue("SNX::STH::bStuned", false))
end

---@return boolean
function STHCharacter:GetHasHat()
	return (self:GetValue("SNX::STH::bHasHat", false))
end

---@return number
function STHCharacter:GetScore()
	return (self:GetValue("SNX::STH::nScore", 0))
end

---@return number
function STHCharacter:GetPRScore()
	return (self:GetValue("SNX::STH::nPRScore", 0))
end
