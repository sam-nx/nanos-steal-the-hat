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

---@param nScore number
function STHCharacter:AddScore(nScore)
	self:SetValue("SNX::STH::nScore", self:GetValue("SNX::STH::nScore") + nScore, true)
	Events.CallRemote("SNX::STH::UI::AddScore", self:GetPlayer(), nScore)
end

---@param nPRScore number
function STHCharacter:SetPRScore(nPRScore)
	self:SetValue("SNX::STH::nPRScore", nPRScore, true)
end

function STHCharacter:AttachHat()
	if (self:GetHasHat()) then return end

	local eHat = self:GetValue("SNX::STH::eHat")
	if (eHat and eHat:IsValid()) then eHat:Destroy() end

	eHat = Prop(
		Vector(0, 0, 0),
		Rotator(0, 0, 0),
		"nanos-world::SM_Cone",
		CollisionType.NoCollision,
		false,
		GrabMode.Disabled
	)
	eHat:AttachTo(self, AttachmentRule.SnapToTarget, "head")
	eHat:SetScale(Vector(0.3, 0.3, 0.3))
	eHat:SetRelativeLocation(Vector(30, 3, 0))
	eHat:SetRelativeRotation(Rotator(-90, 0, 0))

	self:SetValue("SNX::STH::eHat", eHat)
end

function STHCharacter:DetachHat()
	local eHat = self:GetValue("SNX::STH::eHat")
	if (not eHat or not eHat:IsValid()) then return end
	eHat:Destroy()
end
