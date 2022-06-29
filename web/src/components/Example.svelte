<script lang="ts">
	import { visibility } from '../store/stores';
	import { fetchNui } from '../utils/fetchNui';
	import Tabs from './Content.svelte';

	interface ReturnData {
		x: number;
		y: number;
		z: number;
	}

	let clientData: ReturnData;

	const handleClientData = () => {
		fetchNui('getClientData')
			.then((returnData) => {
				clientData = returnData;
			})
			.catch((e) => {
				clientData = { x: 100, y: 100, z: 100 };
			});
	};

	const closeDialog = () => {
		visibility.set(false);
		fetchNui('hideUI');
	};
</script>

<div class="container">
	<Tabs />
</div>

