SNX = SNX or {}
SNX.StealTheHat = SNX.StealTheHat or {}
SNX.StealTheHat.Data = SNX.StealTheHat.Data or {}

function SNX.StealTheHat.Data:BroadcastData()
	local tData = {
		["bGameStatus"] = SNX.StealTheHat.Data.bGAME_STATUS,
		["nGamePhase"] = SNX.StealTheHat.Data.nGAME_PHASE,
		["nPrepPhaseEnd"] = SNX.StealTheHat.Data.nPREP_PHASE_END,
		["nMatchPhaseEnd"] = SNX.StealTheHat.Data.nMATCH_PHASE_END,
		["nEndGamePhaseEnd"] = SNX.StealTheHat.Data.nENDGAME_PHASE_END,
		["tLeaderboard"] = SNX.StealTheHat.Data.tLEADERBOARD,
		["nServerTime"] = Server.GetTime(),
	}
	Events.BroadcastRemote("SNX::StealTheHat::SyncData", tData)
end

Events.SubscribeRemote("SNX::StealTheHat::SyncData", function(pPlayer)
	local tData = {
		["bGameStatus"] = SNX.StealTheHat.Data.bGAME_STATUS,
		["nGamePhase"] = SNX.StealTheHat.Data.nGAME_PHASE,
		["nPrepPhaseEnd"] = SNX.StealTheHat.Data.nPREP_PHASE_END,
		["nMatchPhaseEnd"] = SNX.StealTheHat.Data.nMATCH_PHASE_END,
		["nEndGamePhaseEnd"] = SNX.StealTheHat.Data.nENDGAME_PHASE_END,
		["tLeaderboard"] = SNX.StealTheHat.Data.tLEADERBOARD,
		["nServerTime"] = Server.GetTime()
	}
	Events.CallRemote("SNX::StealTheHat::SyncData", pPlayer, tData)
end)
