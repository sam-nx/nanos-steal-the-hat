---@param tLocation Vector
---@param tRotation Rotator
---@param sMesh string
function STHCharacter:Constructor(tLocation, tRotation, sMesh)
	self.Super:Constructor(tLocation, tRotation, sMesh)
	self:SetValue("SNX::STH::bStuned", false, true)
	self:SetValue("SNX::STH::bHasHat", false, true)
	self:SetValue("SNX::STH::nScore", 0, true)
	self:SetValue("SNX::STH::nPRScore", 0, true)
	self:SetValue("SNX::STH::nHatScoreInterval", 0)
end

---@param bStuned boolean
function STHCharacter:SetStuned(bStuned)
	self:SetValue("SNX::STH::bStuned", bStuned, true)
	self:SetRagdollMode(bStuned)
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
	eHat:AttachTo(self, AttachmentRule.SnapToTarget, "head", 0)
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

function STHCharacter:GiveHat()
	self:SetHasHat(true)
	self:AttachHat()
	local nHatInterval = self:GetValue("SNX::STH::nHatScoreInterval", 0)
	Timer.ClearInterval(nHatInterval)
	nHatInterval = Timer.SetInterval(function()
		if (not self or not self:IsValid()) then return end
		if (not self:GetPlayer() or not self:GetHasHat()) then
			Timer.ClearInterval(self:GetValue("SNX::STH::nHatScoreInterval", 0))
		else
			self:AddScore(50)
		end
	end, 1500)
	self:SetValue("SNX::STH::nHatScoreInterval", nHatInterval)
end

function STHCharacter:RemoveHat()
	self:SetHasHat(false)
	self:DetachHat()
	local nHatInterval = self:GetValue("SNX::STH::nHatScoreInterval", 0)
	Timer.ClearInterval(nHatInterval)
end

---@param tDeck STHPerk[]
function STHCharacter:SetDeck(tDeck)
	return (self:SetValue("SNX::STH::Deck::tDeck", tDeck, true))
end

---@param tPerk STHPerk
---@return boolean
function STHCharacter:AddToDeck(tPerk)
	local bAdded = false
	if (not tPerk) then return (false) end
	local tDeck = self:GetDeck()
	for nIndex = 1, 3 do
		if (not tDeck[nIndex]) then
			tDeck[nIndex] = {
				sPerkUID = tPerk.__sPerkUID,
				sPerkName = tPerk.__sPerkName,
				sPerkIcon = tPerk.__sUIIcon,
				sPerkColor = tPerk.__sUIColor,
			}
			bAdded = true
			break
		end
	end
	self:SetDeck(tDeck)
	return (bAdded)
end

---@param eCharacter STHCharacter
---@param eCauser STHCharacter
STHCharacter.Subscribe("TakeDamage", function(eCharacter, nDamage, _, _, _, pInstigator, eCauser)
	if (not eCharacter or not eCharacter:IsValid()) then return end
	if (not eCauser or not eCauser:IsValid()) then return end
	if (not eCharacter:IsA(STHCharacter) or not eCauser:IsA(STHCharacter)) then return end

	if (eCharacter:GetHealth() - nDamage <= 1) then
		if (not eCharacter:GetStuned()) then
			eCharacter:SetHealth(1)
			eCharacter:SetStuned(true)
			Events.Call("SNX::STH::Character::Stun", eCharacter, eCauser, pInstigator)
		end
		return (false)
	end
	return (true)
end)

---@param eCharacter STHCharacter
---@param eCauser STHCharacter
---@param pInstigator Player
Events.Subscribe("SNX::STH::Character::Stun", function(eCharacter, eCauser, pInstigator)
	if (not eCharacter or not eCharacter:IsValid()) then return end
	if (not eCauser or not eCauser:IsValid()) then return end
	if (not eCharacter:IsA(STHCharacter) or not eCauser:IsA(STHCharacter)) then return end

	-- TODO: If the player dies from unknown cause, drop the hat to the ground

	local pPlayer = eCharacter:GetPlayer()

	SNX.StealTheHat:Broadcast({
		SNX.StealTheHat:FormatText(pPlayer and pPlayer:GetName() or "Unknown", NOTIF_COLORS.orange, true),
		SNX.StealTheHat:FormatText("was knocked out by", NOTIF_COLORS.gray),
		SNX.StealTheHat:FormatText(pInstigator:GetName() or "Unknown", NOTIF_COLORS.blue, true)
	})

	eCauser:AddScore(100)

	Timer.SetTimeout(function()
		if (eCharacter and eCharacter:IsValid() and eCharacter:GetStuned()) then
			eCharacter:SetHealth(eCharacter:GetMaxHealth())
			eCharacter:SetStuned(false)
		end
	end, 3000)

	if (eCharacter:GetHasHat()) then
		eCharacter:RemoveHat()
		eCauser:GiveHat()
		SNX.StealTheHat:Broadcast({
			SNX.StealTheHat:FormatText(pInstigator:GetName() or "Unknown", NOTIF_COLORS.orange, true),
			SNX.StealTheHat:FormatText("stole the hat !", NOTIF_COLORS.gray),
		})
	end
end)
