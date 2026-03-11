---@class STHPerk
---@overload fun(sUID: string): STHPerk
---@field __sPerkName string
---@field __sPerkUID string
---@field __nDuration number
---@field __perkExecute fun(eCharacter: STHCharacter)
STHPerk = {}
STHPerk.__index = STHPerk

setmetatable(STHPerk, {
	__call = function(tClass, ...)
		return (tClass.new(...))
	end
})

---@param sUID string
---@return STHPerk
function STHPerk.new(sUID)
	---@type STHPerk
	local self = setmetatable({}, STHPerk)

	self.__sPerkName = ""
	self.__sPerkUID = sUID
	self.__nDuration = 0
	self.__sUIIcon = ""
	self.__sUIColor = ""
	self.__perkExecute = function() end
	self.__perkOnEnd = function() end

	return (self)
end

---@param sName string
function STHPerk:SetName(sName)
	self.__sPerkName = sName
end

---@param callback fun(eCharacter: STHCharacter)
function STHPerk:SetExecute(callback)
	self.__perkExecute = callback
end

---@param callback fun(eCharacter: STHCharacter)
function STHPerk:SetOnEnd(callback)
	self.__perkOnEnd = callback
end

---@param nDuration number Perk duration in seconds
--- If the duration is < 0, you have to call STHPerk:End manually
function STHPerk:SetDuration(nDuration)
	self.__nDuration = nDuration
end

---@param sUIIcon string Perk UI Icon from RemixIcon (e.g. RiHand)
---@param sUIColor string Perk UI CSS Color (e.g. #0085FF)
function STHPerk:SetUIIcon(sUIIcon, sUIColor)
	self.__sUIIcon = sUIIcon
	self.__sUIColor = sUIColor
end

---@return string
function STHPerk:GetUID()
	return (self.__sPerkUID)
end

---@return string
function STHPerk:GetName()
	return (self.__sPerkName)
end

---@param eCharacter STHCharacter
function STHPerk:End(eCharacter)
	eCharacter:SetValue("SNX::STH::sCurrentPerk", nil, true)
	self.__perkOnEnd(eCharacter)
end

---@param eCharacter STHCharacter
function STHPerk:Execute(eCharacter)
	eCharacter:SetValue("SNX::STH::sCurrentPerk", self.__sPerkUID, true)
	if (self.__nDuration > 0) then
		eCharacter:StartPerkTimer(self.__nDuration)
		Timer.SetTimeout(function()
			self:End(eCharacter)
		end, self.__nDuration * 1000)
	end
	self.__perkExecute(eCharacter)
end
