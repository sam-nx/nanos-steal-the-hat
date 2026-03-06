local pLocal = Client.GetLocalPlayer()
local bLeaderboardOpen = false

local uiMainUI = WebUI(
	"SNX Steal The Hat UI",
	"http://localhost:5173",
	WidgetVisibility.Visible,
	true,
	true
)

Timer.SetInterval(function()
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

	local nTest = 0

	for i = 0, 10 do
		table.insert(tLeaderboard, {
			sName = "Test " .. i,
			nScore = i * 100,
			bHasHat = false
		})
	end

	uiMainUI:CallEvent("SNX::STH::MatchHUD::SyncData", {
		["nHealth"] = eCharacter:GetHealth(),
		["nMaxHealth"] = eCharacter:GetMaxHealth(),
		["nScore"] = eCharacter:GetScore(),
		["nPRScore"] = eCharacter:GetPRScore(),
		["nTimeLeft"] = 72,
		["tLeaderboard"] = tLeaderboard,
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
