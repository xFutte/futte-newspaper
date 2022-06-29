<script lang="ts">
	import VisibilityProvider from './providers/VisibilityProvider.svelte';
	import { debugData } from './utils/debugData';
	import { MaterialApp } from 'svelte-materialify';
	import Content from './components/Content.svelte';

	debugData([
		{
			action: 'setVisible',
			data: true,
		},
	]);
</script>

<main class="container">
	<VisibilityProvider>
		<MaterialApp>
			<Content />
		</MaterialApp>
	</VisibilityProvider>
</main>

<style>
	.container {
		position: absolute;
		top: 50%;
		left: 50%;
		transform: translate(-50%, -50%);
		font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
		display: flex;
		flex-direction: column;
		border-radius: 5px;
		width: 1600px;
		height: 1000px;
		font-size: 1.5vh;
		color: white;
		user-select: none;
	}
</style>
