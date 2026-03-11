local bLeaderboardOpen = false

local uiMainUI = WebUI(
	"SNX Steal The Hat UI",
	"http://localhost:5173",
	WidgetVisibility.Visible,
	true,
	true
)

Timer.SetInterval(function()
	local pLocal = Client.GetLocalPlayer()
	---@type STHCharacter
	local eCharacter = pLocal:GetControlledCharacter()
	local tLeaderboard = {}

	---@param pPlayer Player
	for _, pPlayer in ipairs(Player.GetAll()) do
		---@type STHCharacter
		local ePlayerCharacter = pPlayer:GetControlledCharacter()
		table.insert(tLeaderboard, {
			["sName"] = pPlayer:GetName(),
			["nScore"] = ePlayerCharacter:GetScore(),
			["bHasHat"] = ePlayerCharacter:GetHasHat(),
			["bLocalPlayer"] = pLocal == pPlayer
		})
	end

	for i = 0, 10 do
		table.insert(tLeaderboard, {
			sName = "Test " .. i,
			nScore = i * 100,
			bHasHat = false
		})
	end

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

	uiMainUI:CallEvent("SNX::STH::MatchHUD::SyncData", {
		["nHealth"] = eCharacter:GetHealth(),
		["nMaxHealth"] = eCharacter:GetMaxHealth(),
		["nScore"] = eCharacter:GetScore(),
		["nPRScore"] = eCharacter:GetPRScore(),
		["nTimeLeft"] = 72,
		["tLeaderboard"] = tLeaderboard,
		["tDeck"] = tDeck,
		["bShiftDeck"] = ((tDeck[1] and not tDeck[2] and tDeck[3]) or (not tDeck[1] and (tDeck[2] or tDeck[3]))) and true or
			false,
		["tCurrentPerk"] = tPerk,
		["nPerkTimeLeft"] = math.floor((nPerkTimeLeft - Client.GetTime()) / 10) / 100
	})
end, 100)

---@param nScore number
Events.SubscribeRemote("SNX::STH::UI::AddScore", function(nScore)
	uiMainUI:CallEvent("SNX::STH::MatchHUD::AddScore", nScore)
end)

---@param tData { sText: string, sClass: string }[]
Events.Subscribe("SNX::STH::UI::AddNotification", function(tData)
	uiMainUI:CallEvent("SNX::STH::MatchHUD::AddNotification", tData)
end)

Input.Subscribe("KeyDown", function(sKey)
	if (sKey ~= "Tab") then return end
	if (not bLeaderboardOpen) then
		uiMainUI:CallEvent("SNX::STH::MatchHUD::ToggleLeaderboard", true)
		Input.SetMouseEnabled(true)
		bLeaderboardOpen = true
	end
end)

Input.Subscribe("KeyUp", function(sKey)
	if (sKey ~= "Tab") then return end
	if (bLeaderboardOpen) then
		uiMainUI:CallEvent("SNX::STH::MatchHUD::ToggleLeaderboard", false)
		Input.SetMouseEnabled(false)
		bLeaderboardOpen = false
	end
end)
