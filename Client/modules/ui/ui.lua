SNX = SNX or {}
SNX.StealTheHat = SNX.StealTheHat or {}
SNX.StealTheHat.UI = SNX.StealTheHat.UI or {}

local bLeaderboardOpen = false

SNX.StealTheHat.UI.uiMainUI = WebUI(
	"SNX Steal The Hat UI",
	"http://localhost:5173",
	-- "file://UI/dist/index.html",
	WidgetVisibility.Visible,
	true,
	true
)

Timer.SetInterval(function()
	local pLocal = Client.GetLocalPlayer()
	---@type STHCharacter
	local eCharacter = pLocal:GetControlledCharacter()
	if (not eCharacter) then return end
	local tLeaderboard = {}

	---@param pPlayer Player
	for _, pPlayer in ipairs(Player.GetAll()) do
		---@type STHCharacter
		local ePlayerCharacter = pPlayer:GetControlledCharacter()
		if (ePlayerCharacter and ePlayerCharacter:IsA(STHCharacter)) then
			table.insert(tLeaderboard, {
				["sName"] = pPlayer:GetName(),
				["nScore"] = ePlayerCharacter:GetScore(),
				["bHasHat"] = ePlayerCharacter:GetHasHat(),
				["bLocalPlayer"] = pLocal == pPlayer
			})
		end
	end

	-- for i = 0, 10 do
	-- 	table.insert(tLeaderboard, {
	-- 		sName = "Test " .. i,
	-- 		nScore = i * 100,
	-- 		bHasHat = false
	-- 	})
	-- end

	local tDeck = eCharacter:GetDeck()
	local tPerk = eCharacter:GetCurrentPerk()
	if (tPerk and type(tPerk) == "table") then
		for sKey, xValue in pairs(tPerk) do
			if (type(xValue) == "function") then
				tPerk[sKey] = nil
			end
		end
	end

	local nPerkTimeLeft = eCharacter:GetValue("SNX::STH::Perks::nCurrentPerkTimeLeft", 0)
	local nTimeLeft = math.floor((SNX.StealTheHat.Data.nMATCH_PHASE_END - Client.GetTime()) / 1000)

	SNX.StealTheHat.UI.uiMainUI:CallEvent("SNX::STH::MatchHUD::SyncData", {
		["nHealth"] = eCharacter:GetHealth(),
		["nMaxHealth"] = eCharacter:GetMaxHealth(),
		["nScore"] = eCharacter:GetScore(),
		["nPRScore"] = eCharacter:GetPRScore(),
		["nTimeLeft"] = (nTimeLeft < 0) and 0 or nTimeLeft,
		["tLeaderboard"] = tLeaderboard,
		["tDeck"] = tDeck,
		["bShiftDeck"] = ((tDeck[1] and not tDeck[2] and tDeck[3]) or (not tDeck[1] and (tDeck[2] or tDeck[3]))) and true or
			false,
		["tCurrentPerk"] = tPerk,
		["nPerkTimeLeft"] = math.floor((nPerkTimeLeft - Client.GetTime()) / 10) / 100,
		["bHasHat"] = eCharacter:GetHasHat()
	})
end, 100)

---@param nScore number
Events.SubscribeRemote("SNX::STH::UI::AddScore", function(nScore)
	SNX.StealTheHat.UI.uiMainUI:CallEvent("SNX::STH::MatchHUD::AddScore", nScore)
end)

---@param tData { sText: string, sClass: string }[]
Events.Subscribe("SNX::STH::UI::AddNotification", function(tData)
	SNX.StealTheHat.UI.uiMainUI:CallEvent("SNX::STH::MatchHUD::AddNotification", tData)
end)

Input.Subscribe("KeyDown", function(sKey)
	if (sKey ~= "Tab") then return end
	if (SNX.StealTheHat.Data.nGAME_PHASE ~= 1) then return end
	if (not bLeaderboardOpen) then
		SNX.StealTheHat.UI.uiMainUI:CallEvent("SNX::STH::MatchHUD::ToggleLeaderboard", true)
		Input.SetMouseEnabled(true)
		bLeaderboardOpen = true
	end
end)

Input.Subscribe("KeyUp", function(sKey)
	if (sKey ~= "Tab") then return end
	if (SNX.StealTheHat.Data.nGAME_PHASE ~= 1) then return end
	if (bLeaderboardOpen) then
		SNX.StealTheHat.UI.uiMainUI:CallEvent("SNX::STH::MatchHUD::ToggleLeaderboard", false)
		Input.SetMouseEnabled(false)
		bLeaderboardOpen = false
	end
end)
