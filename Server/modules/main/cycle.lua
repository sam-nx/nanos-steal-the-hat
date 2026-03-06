SNX = SNX or {}
SNX.StealTheHat = SNX.StealTheHat or {}
SNX.StealTheHat._DATA = SNX.StealTheHat._DATA or {}

-- Temp Config
local nPrepTime = 1000 * 30 -- 30 seconds
local nMatchTime = 1000 * 60 * 10 -- 10 minutes

local nPlayerCount = 0

Package.Subscribe("Load", function()
	nPlayerCount = Player.GetCount()
	Timer.SetInterval(function()
		-- if (nPlayerCount < 2) then
		-- 	SNX.StealTheHat._DATA.bGAME_STATUS = false
		-- 	SNX.StealTheHat._DATA.nGAME_PHASE = 0
		-- 	SNX.StealTheHat._DATA.nPREP_PHASE_END = -1
		-- 	SNX.StealTheHat._DATA.nMATCH_PHASE_END = -1
		-- 	SNX.StealTheHat._DATA.nENDGAME_PHASE_END = -1
		-- 	return
		-- end
		if (SNX.StealTheHat._DATA.nGAME_PHASE == 0) then -- Attente avant game
			if (SNX.StealTheHat._DATA.nPREP_PHASE_END == -1) then
				SNX.StealTheHat._DATA.nPREP_PHASE_END = Server.GetTime() + nPrepTime
			end
			if (Server.GetTime() >= SNX.StealTheHat._DATA.nPREP_PHASE_END) then
				SNX.StealTheHat._DATA.nGAME_PHASE = 1
				SNX.StealTheHat._DATA.nPREP_PHASE_END = -1
			end
		elseif (SNX.StealTheHat._DATA.nGAME_PHASE == 1) then -- Match
			if (SNX.StealTheHat._DATA.nMATCH_PHASE_END == -1) then
				SNX.StealTheHat._DATA.nMATCH_PHASE_END = Server.GetTime() + nMatchTime
			end
			if (Server.GetTime() >= SNX.StealTheHat._DATA.nMATCH_PHASE_END) then
				SNX.StealTheHat._DATA.nGAME_PHASE = 2
				SNX.StealTheHat._DATA.nMATCH_PHASE_END = -1
			end
		elseif (SNX.StealTheHat._DATA.nGAME_PHASE == 2) then -- End game interface
			if (SNX.StealTheHat._DATA.nENDGAME_PHASE_END == -1) then
				SNX.StealTheHat._DATA.nENDGAME_PHASE_END = Server.GetTime() + SNX.StealTheHat._DATA.nENDGAME_PHASE_END
			end
			if (Server.GetTime() >= SNX.StealTheHat._DATA.nENDGAME_PHASE_END) then
				SNX.StealTheHat._DATA.nGAME_PHASE = 0
				SNX.StealTheHat._DATA.nENDGAME_PHASE_END = -1
			end
		end
		SNX.StealTheHat._DATA.bGAME_STATUS = true
	end, 1000)
end)

Player.Subscribe("Spawn", function(pPlayer)
	nPlayerCount = nPlayerCount + 1
	print("Player joined: " .. pPlayer:GetName())
end)

Player.Subscribe("Destroy", function(pPlayer)
	nPlayerCount = nPlayerCount - 1
	print("Player left: " .. pPlayer:GetName())
end)
