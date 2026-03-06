<script setup>
	import * as RemixIcon from "@remixicon/vue";
	import { ref, shallowRef } from "vue";
	import { formatCountdownTime } from "@/utils/time";

	// const tNotifications = [
	// 	[
	// 		{
	// 			sText: "QuenK",
	// 			sClass: "text-orange-400 font-bold"
	// 		},
	// 		{
	// 			sText: "was knocked down by",
	// 			sClass: "text-white/80"
	// 		},
	// 		{
	// 			sText: "SamNx",
	// 			sClass: "text-blue-400 font-bold"
	// 		},
	// 	],
	// 	[
	// 		{
	// 			sText: "SamNx",
	// 			sClass: "text-orange-400 font-bold"
	// 		},
	// 		{
	// 			sText: "stole the hat!",
	// 			sClass: "text-white/80"
	// 		}
	// 	],
	// 	[
	// 		{
	// 			sText: "Miaou",
	// 			sClass: "text-green-500 font-bold"
	// 		},
	// 		{
	// 			sText: "joined the game!",
	// 			sClass: "text-white/80"
	// 		}
	// 	],
	// ];
	const tNotifications = ref([]);

	const tPerks = [
		{
			sIcon: RemixIcon.RiFlashlightFill,
			sColor: "text-yellow-500"
		},
		{
			sIcon: RemixIcon.RiShieldFill,
			sColor: "text-blue-400"
		},
		{
			sIcon: RemixIcon.RiMoonClearFill,
			sColor: "text-blue-200"
		},
	];

	const podiumSuffix = (nIndex) => {
		switch (nIndex) {
			case 1:
				return "st";
			case 2:
				return "nd";
			case 3:
				return "rd";
			default:
				return "th";
		}
	};

	const getRankColor = (nIndex) => {
		switch (nIndex) {
			case 1:
				return "text-yellow-500";
			case 2:
				return "text-blue-100";
			case 3:
				return "text-yellow-700";
			default:
				return "text-white/80";
		}
	};

	const tLBLocalPlayer = ref(null);

	const bLeaderboardOpen = ref(false);

	const tCharacterData = ref({});

	const bScoreAdd = ref(false);
	const nScoreAddValue = ref("");

	const bShowNotifications = ref(false);
	const nShowNotifTimer = ref(0);

	const addScore = (nScore) => {
		bScoreAdd.value = true;
		nScoreAddValue.value = (nScore >= 0 ? '+' : '') + nScore;
		setTimeout(() => {bScoreAdd.value = false}, 990);
	}

	// Events

	Events.Subscribe("SNX::STH::MatchHUD::SyncData", function (tData) {
		const tSorted = tData.tLeaderboard.sort((a, b) => (b.nScore - a.nScore));
		for (let nIndex = 0; nIndex < tSorted.length; nIndex++) {
			if (tSorted[nIndex].bLocalPlayer) {
				let tPlayer = tSorted[nIndex];
				tPlayer.nIndex = nIndex;
				tLBLocalPlayer.value = tPlayer;
				break;
			}
		}

		tData.tLeaderboard = tSorted;
		tCharacterData.value = tData;
    });

	Events.Subscribe("SNX::STH::MatchHUD::AddScore", function (nScore) {
		addScore(nScore);
    });

	Events.Subscribe("SNX::STH::MatchHUD::ToggleLeaderboard", function (bState) {
		bLeaderboardOpen.value = bState;
    });

	Events.Subscribe("SNX::STH::MatchHUD::AddNotification", function (tData) {
		while (tNotifications.value.length >= 4) {
			tNotifications.value.shift();
		}
		tNotifications.value.push(tData);
		clearTimeout(nShowNotifTimer.value);
		bShowNotifications.value = true;
		nShowNotifTimer.value = setTimeout(() => {bShowNotifications.value = false}, 3000);
    });
</script>

<template>
	<div class="w-full h-full grid grid-rows-[auto_1fr_auto]">
		<div v-if="bLeaderboardOpen" class="absolute w-full h-full flex justify-center items-center z-20">
			<div class="grid grid-rows-[auto_1fr] rounded-xl border-4 border-orange-400 w-1/2 h-2/3 bg-[#111]">
				<div class="bg-orange-400/30 border-b-3 border-orange-400 px-6 py-2 flex items-center">
					<RemixIcon.RiVipCrownLine class="w-6 h-6 text-orange-400 mr-2" />
					<span class="text-2xl font-bold text-boogaloo">STEAL THE HAT</span>
				</div>
				<div class="grid grid-rows-[auto_1fr_auto] overflow-hidden px-6 py-4 gap-4">
					<div class="flex items-center justify-between">
						<span class="text-2xl text-boogaloo">LEADERBOARD</span>
						<div class="flex items-center rounded-xl border-2 border-orange-400 bg-[#222] px-2 py-1">
							<RemixIcon.RiTimerLine class="w-4 h-4 text-orange-400 mr-2" />
							<span class="font-bold">{{ formatCountdownTime(tCharacterData?.nTimeLeft || 0) }}</span>
						</div>
					</div>
					<div class="border-2 border-orange-400 grid grid-rows-[auto_1fr] rounded-xl overflow-hidden bg-orange-400/5">
						<div class="bg-orange-400/30 grid grid-cols-[1fr_3fr_1fr_1fr] px-4 py-2 border-b-2 border-orange-400 items-center">
							<span class="font-bold text-sm text-orange-400">RANK</span>
							<span class="font-bold text-sm text-orange-400">PLAYER</span>
							<span class="font-bold text-sm text-orange-400">STATUS</span>
							<span class="font-bold text-sm text-orange-400">SCORE</span>
						</div>
						<div class="overflow-y-scroll no-scrollbar">
							<div v-for="(tPlayer, nIndex) in tCharacterData?.tLeaderboard || []" :key="nIndex" class="grid grid-cols-[1fr_3fr_1fr_1fr] items-center px-4 py-4 border-b-2 border-orange-400/10">
								<span class="font-bold text-xs" :class="getRankColor(nIndex + 1)">{{ nIndex + 1 }}{{ podiumSuffix(nIndex + 1) }}</span>
								<span class="font-bold text-sm">{{ tPlayer.sName }} <span v-if="tPlayer.bLocalPlayer" class="text-yellow-500">(YOU)</span></span>
								<span class="font-bold w-fit rounded-full flex items-center" :class="tPlayer.bHasHat ? 'px-2 py-1 bg-orange-400/30 border-2 border-orange-400 text-2xs' : 'text-blue-200 text-xs'">
									<RemixIcon.RiVipCrownLine v-if="tPlayer.bHasHat" class="w-4 h-4 text-orange-400 mr-1" />
									<span>{{ tPlayer.bHasHat ? "WEARING HAT" : "Chasing" }}</span>
								</span>
								<span class="font-bold text-sm">{{ tPlayer.nScore }}</span>
							</div>
						</div>
					</div>
					<div class="grid grid-cols-3 gap-4 items-center">
						<div class="flex flex-col items-center justify-center border-2 border-orange-400 bg-orange-400/5 rounded-xl px-4 py-3">
							<span class="text-orange-400 text-xs font-bold">YOUR RANK</span>
							<div class="text-3xl font-bold">#8</div>
						</div>
						<div class="flex flex-col items-center justify-center border-2 border-orange-400 bg-orange-400/5 rounded-xl px-4 py-3">
							<span class="text-orange-400 text-xs font-bold">TOTAL HAT TIME</span>
							<div class="text-3xl font-bold">1:45</div>
						</div>
						<div class="flex flex-col items-center justify-center border-2 border-orange-400 bg-orange-400/5 rounded-xl px-4 py-3">
							<span class="text-orange-400 text-xs font-bold">HAT STOLEN</span>
							<div class="text-3xl font-bold">4 times</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="absolute top-6 left-6 bg-[#111] border-2 border-orange-400 rounded-xl flex flex-col overflow-hidden w-64">
			<div class="w-full px-2 py-2 bg-orange-400/30 flex items-center gap-1">
				<RemixIcon.RiBarChart2Line class="w-4 h-4 -mt-px text-orange-400" />
				<span class="text-orange-400 font-bold text-2xs">TOP PLAYERS</span>
			</div>
			<div class="flex flex-col w-full p-1 gap-1">
				<div v-for="(tPlayer, nIndex) in (tCharacterData?.tLeaderboard || []).slice(0, 5)" :key="nIndex" class="grid grid-cols-[1.5rem_1fr_auto] gap-1 items-center px-2 py-px rounded-full" :class="tPlayer.bLocalPlayer ? 'bg-orange-400' : ''">
					<span class="text-white/80 font-bold text-2xs">{{ nIndex + 1 }}{{ podiumSuffix(nIndex + 1) }}</span>
					<span class="font-bold text-xs truncate">{{ tPlayer.sName }}</span>
					<span class="text-white/80 font-bold text-2xs ml-4">{{ tPlayer.nScore }}</span>
				</div>
				<div v-if="tLBLocalPlayer?.nIndex >= 5" class="grid grid-cols-[1.5rem_1fr_auto] gap-1 items-center px-2 py-px rounded-full bg-orange-400">
					<span class="text-white/80 font-bold text-2xs">{{ tLBLocalPlayer?.nIndex + 1 }}{{ podiumSuffix(tLBLocalPlayer?.nIndex + 1) }}</span>
					<span class="font-bold text-xs truncate">{{ tLBLocalPlayer?.sName || "???" }}</span>
					<span class="text-white/80 font-bold text-2xs ml-4">{{ tLBLocalPlayer?.nScore || 0 }}</span>
				</div>
			</div>
		</div>
		<div class="flex flex-col items-center">
			<div class="w-100 h-8 bg-black/50 rounded-b-xl border-x-2 border-b-2 border-orange-400 mb-2 flex items-center justify-center gap-20 relative">
				<span class="text-white/80 font-bold text-xs absolute top-1/2 -translate-y-1/2 left-10">NW</span>
				<RemixIcon.RiVipCrownLine class="text-orange-400 w-4 h-4 absolute top-1/2 -translate-y-1/2 left-40" />
				<span class="text-white/80 font-bold text-xs absolute top-1/2 -translate-y-1/2 left-46">N</span>
				<span class="text-white/80 font-bold text-xs absolute top-1/2 -translate-y-1/2 left-70">NE</span>
				<span class="text-white/80 font-bold text-xs absolute top-1/2 -translate-y-1/2 left-95">E</span>
				<div class="absolute w-px h-full bg-orange-400 top-0 left-1/2"></div>
			</div>
			<div class="bg-[#111] px-10 py-2 rounded-xl border-2 border-orange-400 flex flex-col items-center mb-2">
				<span class="text-orange-400 text-sm font-semibold">YOU HAVE THE HAT !</span>
				<span class="text-3xl font-bold">{{ formatCountdownTime(tCharacterData?.nTimeLeft || 0) }}</span>
			</div>
		</div>
		<div class=""></div>
		<div class="grid grid-cols-[1fr_auto_1fr] gap-4 items-end p-4">
			<div class="flex flex-col gap-4">
				<div class="flex flex-col w-fit gap-1" :class="bShowNotifications ? '' : 'fade-down'">
					<div v-for="(tNotification, nIndex) in tNotifications" :key="nIndex" class="bg-black/50 rounded-lg px-2 flex items-center gap-[.1rem] px-2 py-1">
						<span class="text-2xs" v-for="(tPart, nIndex) in tNotification" :key="nIndex" :style="{ color: tPart.sColor }" :class="tPart.bBold ? 'font-bold' : ''">{{ tPart.sText }}</span>
					</div>
				</div>

				<div class="bg-[#111] rounded-xl p-3 border-2 border-orange-400 flex items-center w-fit gap-2">
					<div class="w-10 h-10 bg-orange-400 rounded-md flex items-center justify-center">
						<RemixIcon.RiHeart3Line class="w-6 h-6 text-white" />
					</div>
					<div class="flex flex-col">
						<div class="flex items-center justify-between text-xs font-semibold mb-2">
							<span class="text-orange-400">HEALTH</span>
							<span>{{ tCharacterData?.nHealth || 0 }}/{{ tCharacterData?.nMaxHealth || 0 }}</span>
						</div>
						<div class="w-64 h-4 rounded-full bg-orange-900">
							<div class="h-full bg-orange-400 rounded-full transition-all duration-200" :style="{ width: `${(Math.floor(tCharacterData?.nHealth || 0) / (tCharacterData?.nMaxHealth || 1) * 100)}%` }"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="flex justify-center">
				<div class="flex items-center mb-10 gap-2">
					<div v-for="(tPerk, nIndex) in tPerks" :key="nIndex" class="w-12 h-12 bg-[#111] border-2 border-orange-400 relative flex items-center justify-center rounded-xl">
						<component v-if="tPerk.sIcon" :is="tPerk.sIcon" class="w-6 h-6" :class="tPerk.sColor" />
						<div class="absolute top-0 right-0 translate-x-1/2 -translate-y-1/2 w-4 h-4 rounded-full bg-[#111] border-2 border-orange-400 flex items-center justify-center text-center">
							<span class="text-2xs">{{ nIndex + 1 }}</span>
						</div>
					</div>
				</div>
			</div>
			<div class="flex flex-col items-end">
				<div class="w-30 h-30 bg-[#111] rounded-full border-4 border-orange-400 flex flex-col items-center justify-center shadow-[0px_8px_0px_0px_rgba(150,85,12,1)] relative">
					<span v-if="bScoreAdd" class="absolute -top-2 -left-2 text-luckiest text-3xl text-orange-400 text-shadow-[3px_3px_0px_#111] z-10 animate-ping">{{ nScoreAddValue }}</span>
					<span v-if="tCharacterData?.nScore > tCharacterData?.nPRScore" class="absolute -top-1 left-1/2 -translate-x-1/2 -translate-y-1/2 bg-[#111] border-3 border-orange-400 text-boogaloo whitespace-nowrap px-2 rounded-xl animate-bounce">NEW PR !</span>
					<span class="text-orange-400 font-bold text-2xs">CURRENT SCORE</span>
					<span class="text-4xl text-luckiest">{{ tCharacterData?.nScore || 0 }}</span>
				</div>
			</div>
		</div>
	</div>
</template>

<style scoped>
	.fade-down {
		animation: fade-down 3s linear forwards;
	}

	@keyframes fade-down {
		0% {
			opacity: 1;
		}
		100% {
			opacity: 0;
		}
	}
</style>