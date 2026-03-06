export const formatCountdownTime = (nSeconds = 0) => {
	const nHours = Math.floor(nSeconds / 3600);
	nSeconds = nSeconds % 3600;
	const nMinutes = Math.floor(nSeconds / 60);
	nSeconds = nSeconds % 60;
	return ((nHours > 0 ? `${nHours < 10 ? '0' : ''}${nHours}:` : '') + `${nMinutes < 10 ? '0' : ''}${nMinutes}:${nSeconds < 10 ? '0' : ''}${nSeconds}`);
}