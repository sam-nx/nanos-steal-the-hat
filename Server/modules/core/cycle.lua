SNX = SNX or {}
SNX.StealTheHat = SNX.StealTheHat or {}
SNX.StealTheHat.Data = SNX.StealTheHat.Data or {}

-- Temp Config
local nPrepTime = 1000 * 2 -- 30 seconds
local nMatchTime = 1000 * 10 -- 10 minutes
local nEndGameTime = 1000 * 30 -- 1 minute

local nPlayerCount = 0

Package.Subscribe("Load", function()
	nPlayerCount = Player.GetCount()
	Timer.SetInterval(function()
		-- if (nPlayerCount < 2) then
		-- 	SNX.StealTheHat.Data.nGAME_PHASE = 0
		-- 	SNX.StealTheHat.Data.nPREP_PHASE_END = -1
		-- 	SNX.StealTheHat.Data.nMATCH_PHASE_END = -1
		-- 	SNX.StealTheHat.Data.nENDGAME_PHASE_END = -1
		-- 	if (SNX.StealTheHat.Data.bGAME_STATUS) then
		-- 		SNX.StealTheHat.Data.bGAME_STATUS = false
		-- 		SNX.StealTheHat.Data:BroadcastData()
		-- 	end
		-- 	return
		-- end
		SNX.StealTheHat.Data.bGAME_STATUS = true
		if (SNX.StealTheHat.Data.nGAME_PHASE == 0) then -- Attente avant game
			if (SNX.StealTheHat.Data.nPREP_PHASE_END == -1) then
				SNX.StealTheHat.Data.nPREP_PHASE_END = Server.GetTime() + nPrepTime
				SNX.StealTheHat.Data:BroadcastData()
			end
			if (Server.GetTime() >= SNX.StealTheHat.Data.nPREP_PHASE_END) then
				SNX.StealTheHat.Data.nGAME_PHASE = 1
				SNX.StealTheHat.Data.nPREP_PHASE_END = -1
				SNX.StealTheHat.Data:BroadcastData()
			end
		elseif (SNX.StealTheHat.Data.nGAME_PHASE == 1) then -- Match
			if (SNX.StealTheHat.Data.nMATCH_PHASE_END == -1) then
				SNX.StealTheHat.Data.nMATCH_PHASE_END = Server.GetTime() + nMatchTime
				SNX.StealTheHat.Data:BroadcastData()
				---@param pPlayer Player
				for _, pPlayer in ipairs(Player.GetAll()) do
					pPlayer:STHSpawn()
				end
			end
			if (Server.GetTime() >= SNX.StealTheHat.Data.nMATCH_PHASE_END) then
				SNX.StealTheHat.Data.nGAME_PHASE = 2
				SNX.StealTheHat.Data.nMATCH_PHASE_END = -1
				SNX.StealTheHat.Data:BroadcastData()
			end
		elseif (SNX.StealTheHat.Data.nGAME_PHASE == 2) then -- End game interface
			if (SNX.StealTheHat.Data.nENDGAME_PHASE_END == -1) then
				SNX.StealTheHat.Data.nENDGAME_PHASE_END = Server.GetTime() + nEndGameTime

				local tLeaderboard = {}

				---@param pPlayer Player
				for _, pPlayer in ipairs(Player.GetAll()) do
					---@type STHCharacter|Character?
					local ePlayerCharacter = pPlayer:GetControlledCharacter()
					if (ePlayerCharacter and ePlayerCharacter:IsA(STHCharacter)) then
						table.insert(tLeaderboard, {
							["sName"] = pPlayer:GetName(),
							["nScore"] = ePlayerCharacter:GetScore(),
							["sSteamID"] = pPlayer:GetSteamID(),
							["sAvatar"] = pPlayer:GetAccountIconURL()
						})
					end
				end

				SNX.StealTheHat.Data.tLEADERBOARD = tLeaderboard

				SNX.StealTheHat.Data:BroadcastData()

				---@param pPlayer Player
				for _, pPlayer in ipairs(Player.GetAll()) do
					pPlayer:STHDestroy()
				end
			end
			if (Server.GetTime() >= SNX.StealTheHat.Data.nENDGAME_PHASE_END) then
				SNX.StealTheHat.Data.nGAME_PHASE = 0
				SNX.StealTheHat.Data.nENDGAME_PHASE_END = -1
				SNX.StealTheHat.Data:BroadcastData()
			end
		end
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
