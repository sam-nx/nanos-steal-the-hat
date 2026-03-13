SNX = SNX or {}
SNX.StealTheHat = SNX.StealTheHat or {}
SNX.StealTheHat.Data = SNX.StealTheHat.Data or {}
SNX.StealTheHat.UI = SNX.StealTheHat.UI or {}

Events.SubscribeRemote("SNX::StealTheHat::SyncData", function(tData)
	print("SNX::StealTheHat::SyncData", JSON.stringify(tData))
	if (not tData) then return end

	SNX.StealTheHat.Data.bGAME_STATUS = tData.bGameStatus
	SNX.StealTheHat.Data.nGAME_PHASE = tData.nGamePhase
	SNX.StealTheHat.Data.nPREP_PHASE_END = (tData.nPrepPhaseEnd == -1) and -1 or
		Client.GetTime() + (tData.nPrepPhaseEnd - tData.nServerTime)
	SNX.StealTheHat.Data.nMATCH_PHASE_END = (tData.nMatchPhaseEnd == -1) and -1 or
		Client.GetTime() + (tData.nMatchPhaseEnd - tData.nServerTime)
	SNX.StealTheHat.Data.nENDGAME_PHASE_END = (tData.nEndGamePhaseEnd == -1) and -1 or
		Client.GetTime() + (tData.nEndGamePhaseEnd - tData.nServerTime)
	SNX.StealTheHat.Data.tLEADERBOARD = tData.tLeaderboard

	SNX.StealTheHat.UI.uiMainUI:CallEvent("SNX::STH::Main::SyncData", {
		bGameStatus = SNX.StealTheHat.Data.bGAME_STATUS,
		nGamePhase = SNX.StealTheHat.Data.nGAME_PHASE
	})

	if (SNX.StealTheHat.Data.nGAME_PHASE == 2) then
		Input.SetMouseEnabled(true)
		local tLeaderboard = SNX.StealTheHat.Data.tLEADERBOARD
		for _, tPlayer in pairs(tLeaderboard) do
			if (tPlayer.sSteamID == Client.GetLocalPlayer():GetSteamID()) then
				tPlayer.bLocalPlayer = true
			end
		end
		SNX.StealTheHat.UI.uiMainUI:CallEvent("SNX::STH::LeaderboardHUD::SyncData", {
			tLeaderboard = tLeaderboard
		})
	else
		Input.SetMouseEnabled(false)
	end
end)

Timer.SetInterval(function()
	if (SNX.StealTheHat.Data.bGAME_STATUS) then
		if (SNX.StealTheHat.Data.nGAME_PHASE == 0) then
			local nTimeLeft = math.floor((SNX.StealTheHat.Data.nPREP_PHASE_END - Client.GetTime()) / 1000)
			SNX.StealTheHat.UI.uiMainUI:CallEvent("SNX::STH::PrepHUD::SyncData", {
				nTimeLeft = (nTimeLeft < 0) and 0 or nTimeLeft
			})
		elseif (SNX.StealTheHat.Data.nGAME_PHASE == 1) then
			-- SNX.StealTheHat.UI.uiMainUI:CallEvent("SNX::STH::MatchHUD::TimeSync", {
			-- 	bGameStatus = SNX.StealTheHat.Data.bGAME_STATUS,
			-- 	nGamePhase = SNX.StealTheHat.Data.nGAME_PHASE
			-- })
		elseif (SNX.StealTheHat.Data.nGAME_PHASE == 2) then
			local nTimeLeft = math.floor((SNX.StealTheHat.Data.nENDGAME_PHASE_END - Client.GetTime()) / 1000)
			SNX.StealTheHat.UI.uiMainUI:CallEvent("SNX::STH::LeaderboardHUD::SyncTime", (nTimeLeft < 0 and 0 or nTimeLeft))
		end
	end
end, 100)

Package.Subscribe("Load", function()
	if (Client.GetLocalPlayer() and Client.GetLocalPlayer():IsValid()) then
		Events.CallRemote("SNX::StealTheHat::SyncData")
	end
end)

Package.Subscribe("Spawn", function()
	Events.CallRemote("SNX::StealTheHat::SyncData")
end)
