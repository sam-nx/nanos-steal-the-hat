Events.SubscribeRemote("SNX::StealTheHat::SyncData", function(tData)
	print("SNX::StealTheHat::SyncData", JSON.stringify(tData))
	if (not tData) then return end

	SNX.StealTheHat._DATA.bGAME_STATUS = tData.bGameStatus
	SNX.StealTheHat._DATA.nGAME_PHASE = tData.nGamePhase
	SNX.StealTheHat._DATA.nPREP_PHASE_END = (tData.nPrepPhaseEnd == -1) and -1 or
		Client.GetTime() + (tData.nPrepPhaseEnd - tData.nServerTime)
	SNX.StealTheHat._DATA.nMATCH_PHASE_END = (tData.nMatchPhaseEnd == -1) and -1 or
		Client.GetTime() + (tData.nMatchPhaseEnd - tData.nServerTime)
	SNX.StealTheHat._DATA.nENDGAME_PHASE_END = (tData.nEndGamePhaseEnd == -1) and -1 or
		Client.GetTime() + (tData.nEndGamePhaseEnd - tData.nServerTime)
end)

Package.Subscribe("Load", function()
	if (Client.GetLocalPlayer() and Client.GetLocalPlayer():IsValid()) then
		Events.CallRemote("SNX::StealTheHat::SyncData")
	end
end)

Package.Subscribe("Spawn", function()
	Events.CallRemote("SNX::StealTheHat::SyncData")
end)
