<script setup>
	import * as RemixIcon from "@remixicon/vue";
	import { ref } from "vue";

	const tNotifications = [
		[
			{
				sText: "QuenK",
				sClass: "text-orange-400 font-bold"
			},
			{
				sText: "was knocked down by",
				sClass: "text-white/80"
			},
			{
				sText: "SamNx",
				sClass: "text-blue-400 font-bold"
			},
		],
		[
			{
				sText: "SamNx",
				sClass: "text-orange-400 font-bold"
			},
			{
				sText: "stole the hat!",
				sClass: "text-white/80"
			}
		],
		[
			{
				sText: "Miaou",
				sClass: "text-green-500 font-bold"
			},
			{
				sText: "joined the game!",
				sClass: "text-white/80"
			}
		],
	];

	const tLeaderboard = [
		{
			sName: "SamNx",
			nScore: 3187,
			bHasHat: true
		},
		{
			sName: "QuenK",
			nScore: 3045,
			bHasHat: false
		},
		{
			sName: "Miaou",
			nScore: 2965,
			bHasHat: false
		},
		{
			sName: "Doggy Doggo",
			nScore: 2875,
			bHasHat: false
		},
		{
			sName: "Horsy Horse",
			nScore: 2635,
			bHasHat: false
		},
		{
			sName: "Ducky Duck",
			nScore: 2301,
			bHasHat: false
		},
		{
			sName: "Mickey Mouse",
			nScore: 2289,
			bHasHat: false
		},
		{
			sName: "Wild Goose",
			nScore: 2064,
			bHasHat: false,
			bLocalPlayer: true
		},
		{
			sName: "No more inspiration",
			nScore: 1923,
			bHasHat: false
		},
		{
			sName: "Big noob",
			nScore: 812,
			bHasHat: false
		},
	]

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

	const bLeaderboardOpen = ref(false);
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
							<span class="font-bold">02:45</span>
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
							<div v-for="(tPlayer, nIndex) in tLeaderboard" :key="nIndex" class="grid grid-cols-[1fr_3fr_1fr_1fr] items-center px-4 py-4 border-b-2 border-orange-400/10">
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
		<div class="absolute top-6 left-6 bg-[#111] border-2 border-orange-400 rounded-xl flex flex-col overflow-hidden">
			<div class="w-full px-2 py-2 bg-orange-400/30 flex items-center gap-1">
				<RemixIcon.RiBarChart2Line class="w-4 h-4 -mt-px text-orange-400" />
				<span class="text-orange-400 font-bold text-2xs">TOP PLAYERS</span>
			</div>
			<div class="flex flex-col w-full px-2 py-1 gap-1">
				<div v-for="(tPlayer, nIndex) in tLeaderboard.slice(0, 5)" :key="nIndex" class="grid grid-cols-[auto_1fr_auto] gap-1 items-center px-2 py-px rounded-full">
					<span class="text-white/80 font-bold text-2xs">{{ nIndex + 1 }}{{ podiumSuffix(nIndex + 1) }}</span>
					<span class="font-bold text-xs">{{ tPlayer.sName }}</span>
					<span class="text-white/80 font-bold text-2xs ml-4">{{ tPlayer.nScore }}</span>
				</div>
				<div class="grid grid-cols-[auto_1fr_auto] gap-1 items-center px-2 py-px rounded-full bg-orange-400">
					<span class="text-white/80 font-bold text-2xs">8th</span>
					<span class="font-bold text-xs">LocalPlayer</span>
					<span class="text-white/80 font-bold text-2xs ml-4">2064</span>
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
				<span class="text-3xl font-bold">02:45</span>
			</div>
		</div>
		<div class=""></div>
		<div class="grid grid-cols-[1fr_auto_1fr] gap-4 items-end p-4">
			<div class="flex flex-col gap-4">
				<div class="flex flex-col w-fit gap-1">
					<div v-for="(tNotification, nIndex) in tNotifications" :key="nIndex" class="bg-black/50 rounded-lg px-2 flex items-center gap-[.1rem] px-2 py-1">
						<span class="text-2xs" v-for="(tPart, nIndex) in tNotification" :key="nIndex" :class="tPart.sClass">{{ tPart.sText }}</span>
					</div>
				</div>

				<div class="bg-[#111] rounded-xl p-3 border-2 border-orange-400 flex items-center w-fit gap-2">
					<div class="w-10 h-10 bg-orange-400 rounded-md flex items-center justify-center">
						<RemixIcon.RiHeart3Line class="w-6 h-6 text-white" />
					</div>
					<div class="flex flex-col">
						<div class="flex items-center justify-between text-xs font-semibold mb-2">
							<span class="text-orange-400">HEALTH</span>
							<span>80/100</span>
						</div>
						<div class="w-64 h-4 rounded-full bg-orange-900">
							<div class="h-full w-4/5 bg-orange-400 rounded-full transition-all duration-200"></div>
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
				<div class="w-30 h-30 bg-[#111] rounded-full border-4 border-orange-400 flex flex-col items-center justify-center shadow-[0px_8px_0px_0px_rgba(150,_85,_12,_1)] relative">
					<span class="absolute -top-1 left-1/2 -translate-x-1/2 -translate-y-1/2 bg-[#111] border-3 border-orange-400 text-boogaloo whitespace-nowrap px-2 rounded-xl animate-bounce">NEW PR !</span>
					<span class="text-orange-400 font-bold text-2xs">CURRENT SCORE</span>
					<span class="text-4xl text-luckiest">2,064</span>
				</div>
			</div>
		</div>
	</div>
</template>

<style scoped>
</style>