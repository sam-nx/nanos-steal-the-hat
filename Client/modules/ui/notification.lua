SNX = SNX or {}
SNX.StealTheHat = SNX.StealTheHat or {}

---@param tData { sText: string, sClass: string }[]
function SNX.StealTheHat:Notify(tData)
	Events.Call("SNX::STH::UI::AddNotification", tData)
end

---@param tData { sText: string, sClass: string }[]
Events.SubscribeRemote("SNX::STH::UI::Notify", function(tData)
	SNX.StealTheHat:Notify(tData)
end)
