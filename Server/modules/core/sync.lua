Events.SubscribeRemote("SNX::StealTheHat::SyncData", function(pPlayer)
	local tData = {
		["bGameStatus"] = SNX.StealTheHat._DATA.bGAME_STATUS,
		["nGamePhase"] = SNX.StealTheHat._DATA.nGAME_PHASE,
		["nPrepPhaseEnd"] = SNX.StealTheHat._DATA.nPREP_PHASE_END,
		["nMatchPhaseEnd"] = SNX.StealTheHat._DATA.nMATCH_PHASE_END,
		["nEndGamePhaseEnd"] = SNX.StealTheHat._DATA.nENDGAME_PHASE_END,
		["nServerTime"] = Server.GetTime()
	}
	Events.CallRemote("SNX::StealTheHat::SyncData", pPlayer, tData)
end)
