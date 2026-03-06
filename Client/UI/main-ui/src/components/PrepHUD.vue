<script setup>
	import * as RemixIcon from "@remixicon/vue";
	import { ref } from "vue";

	const nCountdown = ref(30);

	const formatCountdownTime = (nSeconds = 0) => {
		const nHours = Math.floor(nSeconds / 3600);
		nSeconds = nSeconds % 3600;
		const nMinutes = Math.floor(nSeconds / 60);
		nSeconds = nSeconds % 60;
		return ((nHours > 0 ? `${nHours < 10 ? '0' : ''}${nHours}:` : '') + `${nMinutes < 10 ? '0' : ''}${nMinutes}:${nSeconds < 10 ? '0' : ''}${nSeconds}`);
	}

	const startCountDown = () => {
		nCountdown.value = 30;
		const nInterval = setInterval(() => {
			nCountdown.value -= 1;
			if (nCountdown.value <= 0) clearInterval(nInterval);
		}, 1000);
	}

	startCountDown();
</script>

<template>
	<div class="w-full h-full bg-black relative">
		<img class="absolute w-full h-screen object-cover z-10" src="https://syntystore.com/cdn/shop/files/Alpine_Screenshot_01.png?v=1702609495&width=2275" alt="Map Background">
		<div class="absolute w-full h-full backdrop-blur-sm z-10 bg-black/40"></div>

		<div class="grid grid-rows-[1fr_auto_1fr] absolute z-10 w-full h-full">
			<div></div>
			<div class="flex flex-col items-center justify-center">
				<span class="bg-orange-400 px-8 py-2 rounded-xl text-black text-3xl shadow-[6px_6px_0px_0px_rgba(0,_0,_0,_0.5)] -rotate-5 text-luckiest">GET READY!</span>
				<div class="px-4 py-2 rounded-full bg-black/50 border-2 border-orange-500 flex flex-col items-center justify-center mt-12 mb-10">
					<span class="text-6xl font-bold text-zendots">{{ formatCountdownTime(nCountdown) }}</span>
				</div>
				<span class="text-orange-400 font-semibold tracking-widest text-sm mb-1">NEXT MAP</span>
				<span class="text-5xl font-bold text-boogaloo mb-6">Steal The Hat Testing Map</span>
				<div class="flex items-center gap-2">
					<div class="flex items-center">
						<div v-for="nIndex in 3" :key="nIndex" class="w-8 h-8 rounded-full border-2 border-orange-400 bg-black -ml-2"></div>
						<div class="w-8 h-8 rounded-full bg-orange-400 -ml-2 text-black text-xs font-bold flex items-center justify-center text-arial">+5</div>
					</div>
					<span class="text-white/80">8 players ready</span>
				</div>
			</div>
			<div class="p-8 flex items-end">
				<div class="flex items-center">
					<div class="bg-black/50 rounded-xl px-4 py-2 flex items-center">
						<div class="flex items-center gap-2">
							<RemixIcon.RiBarChart2Line class="w-6 h-6 text-orange-400" />
							<div class="flex flex-col">
								<span class="text-white/80 text-xs">YOUR GLOBAL RANK</span>
								<span class="text-lg font-bold">#32</span>
							</div>
						</div>
						<div class="w-px h-8 bg-white/30 mx-4"></div>
						<div class="flex items-center gap-2">
							<RemixIcon.RiSparkling2Fill class="w-6 h-6 text-orange-400" />
							<div class="flex flex-col">
								<span class="text-white/80 text-xs">MAX SCORE</span>
								<span class="text-lg font-bold">2,184</span>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</template>

<style scoped>
</style>