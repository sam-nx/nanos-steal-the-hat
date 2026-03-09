---@param tLocation Vector
---@param tRotation Rotator
---@param sMesh string
---@param nCollisionType CollisionType
---@param tColor Color
function STHPerk:Constructor(tLocation, tRotation, sMesh, nCollisionType, tColor)
	self.Super:Constructor(tLocation, tRotation, sMesh, nCollisionType)
	self:SetValue("SNX::STH::sPerk", "", true)

	self:SetScale(Vector(0.5, 0.5, 0.5))

	local eLight = Light(
		Vector(0, 0, 0),
		Rotator(0, 0, 0),
		tColor,
		LightType.Point,
		500,
		500,
		50,
		0,
		5000,
		true,
		true,
		true
	)

	eLight:AttachTo(self, AttachmentRule.SnapToTarget, "", 0)

	local eTrigger = Trigger(
		Vector(0, 0, 0),
		Rotator(0, 0, 0),
		Vector(50),
		TriggerType.Box,
		true,
		Color(1, 0, 0),
		{ "Character" }
	)

	eTrigger:AttachTo(self, AttachmentRule.SnapToTarget, "", 0)

	---@param eEntity STHCharacter
	eTrigger:Subscribe("BeginOverlap", function(eSelf, eEntity)
		if (not eEntity or not eEntity:IsValid() or not eEntity:IsA(STHCharacter)) then return end
		eEntity:SetValue("SNX::STH::Perks::bOnePunchMan", true)
		self:Destroy()
	end)
end

---@param sPerk string
function STHPerk:SetPerk(sPerk)
	self:SetValue("SNX::STH::sPerk", sPerk, true)
end
