SNX = SNX or {}
SNX.StealTheHat = SNX.StealTheHat or {}

---@param pPlayer Player
---@param tData { sText: string, sClass: string }[]
function SNX.StealTheHat:Notify(pPlayer, tData)
	Events.CallRemote("SNX::STH::UI::Notify", pPlayer, tData)
end

---@param tData { sText: string, sClass: string }[]
function SNX.StealTheHat:Broadcast(tData)
	Events.BroadcastRemote("SNX::STH::UI::Notify", tData)
end
