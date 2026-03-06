<script setup>
	import * as RemixIcon from "@remixicon/vue";

	const tKillFeed = [
		{
			tAttacker: { sName: "QuenK Le Goat", nTeam: 1 },
			tVictim: { sName: "SamNx", nTeam: 2 },
			nKillType: 1
		},
		{
			tAttacker: { sName: "QuenK Le Goat", nTeam: 2 },
			tVictim: { sName: "SamNx", nTeam: 1 },
			nKillType: 2
		},
		{
			tAttacker: { sName: "QuenK Le Goat", nTeam: 1 },
			tVictim: { sName: "SamNx", nTeam: 1 },
			nKillType: 1
		},
		{
			tAttacker: { sName: "SamNx", nTeam: 2 },
			tVictim: { sName: "NPC", nTeam: 0 },
			nKillType: 1
		},
		{
			// tAttacker: { sName: "SamNx", nTeam: 2 },
			tVictim: { sName: "SamNx", nTeam: 2 },
			nKillType: 0
		},
		{
			tAttacker: { sName: "Nom extremement long c'est absolument extra casse-couilles parce que ca va depasser de l'UI", nTeam: 1 },
			tVictim: { sName: "Nom extremement long c'est absolument extra casse-couilles parce que ca va depasser de l'UI", nTeam: 2 },
			nKillType: 1
		},
	];

	const getTeamBgColor = (nTeam) => {
		switch (nTeam) {
			case 1:
				return 'bg-blue-400';
			case 2:
				return 'bg-red-400';
			default:
				return 'bg-[#333]';
		}
	};

	const tPerks = [
		{
			sIcon: RemixIcon.RiFireFill,
			sColor: "text-yellow-500"
		},
		{
			sIcon: RemixIcon.RiMoonClearFill,
			sColor: "text-blue-200"
		},
		{
			sIcon: RemixIcon.RiGhostFill,
			sColor: "text-yellow-100"
		},
	];
</script>

<template>
	<div class="w-full h-full grid grid-rows-[auto_1fr_auto]">
		<!-- Kill feed -->
		<div class="absolute top-4 right-4 flex flex-col items-end gap-2">
			<div v-for="(tKill, nIndex) of tKillFeed" :key="nIndex" class="flex items-center">
				<span v-if="tKill?.tAttacker" class="font-semibold rounded-l-md px-2 text-xs h-6 flex items-center max-w-40" :class="getTeamBgColor(tKill?.tAttacker?.nTeam)"><span class="truncate">{{ tKill?.tAttacker?.sName }}</span></span>
				<div class="flex items-center justify-center bg-black w-6 h-6">
					<RemixIcon.RiCrosshair2Line v-if="tKill?.nKillType == 1" class="w-4 h-4" />
					<RemixIcon.RiKnifeLine v-else-if="tKill?.nKillType == 2" class="w-4 h-4" />
					<RemixIcon.RiSkullLine v-else class="w-4 h-4" />
				</div>
				<span v-if="tKill?.tVictim" class="font-semibold rounded-r-md px-2 text-xs h-6 flex items-center max-w-40" :class="getTeamBgColor(tKill?.tVictim?.nTeam)"><span class="truncate">{{ tKill?.tVictim?.sName }}</span></span>
			</div>
		</div>

		<div class="flex flex-col items-center pt-4">
			<div class="bg-[#111] px-10 py-2 rounded-md border-2 border-blue-400 flex flex-col items-center mb-2">
				<span class="text-blue-400 text-sm font-semibold">SPECTATOR</span>
				<span class="text-3xl font-bold">02:45</span>
			</div>
			<div class="flex items-center gap-4">
				<div class="flex flex-col gap-1">
					<div class="flex items-center justify-between w-full">
						<span class="text-blue-400 font-semibold text-xs">HUNTERS</span>
						<span class="text-blue-400 font-semibold text-xs">4/5</span>
					</div>
					<div class="bg-blue-900 rounded-full h-2 w-64">
						<div class="h-full w-4/5 bg-blue-400 rounded-full transition-all duration-200"></div>
					</div>
				</div>
				<span class="text-2xl font-bold">3 - 1</span>
				<div class="flex flex-col gap-1">
					<div class="flex items-center justify-between w-full">
						<span class="text-red-400 font-semibold text-xs">3/5</span>
						<span class="text-red-400 font-semibold text-xs">HIDERS</span>
					</div>
					<div class="bg-red-900 rounded-full h-2 w-64">
						<div class="h-full w-3/5 bg-red-400 rounded-full transition-all duration-200"></div>
					</div>
				</div>
			</div>
		</div>
		<div class=""></div>
		<div class="grid grid-cols-[1fr_auto_1fr] gap-4 items-end p-4">
			<div class="flex">
				<div class="bg-[#111] rounded-md p-3 border-2 border-[#333] flex flex-col w-fit">
					<span class="text-blue-400 text-xs font-semibold">CONDITION</span>
					<span class="text-3xl font-bold mb-2">85<span class="ml-px text-sm text-[#888] font-semibold">HP</span></span>
					<div class="w-64 h-2 rounded-full bg-blue-900">
						<div class="h-full w-4/5 bg-blue-400 rounded-full transition-all duration-200"></div>
					</div>
				</div>
			</div>
			<div class="flex justify-center">
				<div class="flex items-center mb-10 gap-2">
					<div v-for="(tPerk, nIndex) in tPerks" :key="nIndex" class="w-12 h-12 bg-[#111] border-2 border-[#333] relative flex items-center justify-center rounded-md">
						<component v-if="tPerk.sIcon" :is="tPerk.sIcon" class="w-6 h-6" :class="tPerk.sColor" />
						<div class="absolute bottom-0 left-1/2 -translate-x-1/2 translate-y-1/2 w-4 h-4 rounded-full bg-[#111] border-2 border-[#333] flex items-center justify-center text-center">
							<span class="text-xs">{{ nIndex + 1 }}</span>
						</div>
					</div>
				</div>
			</div>
			<div class="flex flex-col items-end">
				<div class="bg-[#111] rounded-md p-3 border-2 border-[#333] flex flex-col w-fit">
					<span class="text-md font-semibold">M4 Carbine</span>
					<div class="flex items-center justify-between gap-20">
						<span class="text-3xl font-bold mb-2">24<span class="ml-px text-sm text-[#888] font-semibold">/30</span></span>
						<div class="flex items-center gap-1">
							<div class="bg-blue-900 w-1 h-6 rounded-full">
								<div class="bg-blue-400 w-full h-full rounded-full"></div>
							</div>
							<div class="bg-blue-900 w-1 h-6 rounded-full">
								<div class="bg-blue-400 w-full h-full rounded-full"></div>
							</div>
							<div class="bg-blue-900 w-1 h-6 rounded-full">
								<div class="bg-blue-400 w-full h-full rounded-full"></div>
							</div>
							<div class="bg-blue-900 w-1 h-6 rounded-full">
								<div class="bg-blue-400 w-full h-full rounded-full"></div>
							</div>
						</div>
					</div>
					<div class="w-full h-px bg-[#333] mb-2"></div>
					<div class="flex items-center justify-between font-semibold text-[#888] text-xs gap-20">
						<span>AMMO TYPE: <span class="text-white">5.56</span></span>
						<div class="flex items-center gap-1">
							<span>MODE:</span>
							<RemixIcon.RiCrosshair2Line class="w-4 h-4 text-white" />
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</template>

<style scoped>
</style>