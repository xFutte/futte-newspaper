<script lang="ts">
	import { visibility } from './store/stores';
	import VisibilityProvider from './providers/VisibilityProvider.svelte';
	import { MaterialApp } from 'svelte-materialify';
	import Content from './components/Content.svelte';
	import type { Story } from './interfaces/story';

	let stories: Array<Story>;

	window.addEventListener('message', (event) => {
		// stories = event.data.stories;
		stories = []
		visibility.set(true);

		console.log(stories);
	});
</script>

<svelte:head>
	<link href="//cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet" />
</svelte:head>

<main class="container">
	<VisibilityProvider>
		<MaterialApp>
			<Content {stories} />
		</MaterialApp>
	</VisibilityProvider>
</main>

<style lang="scss">
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
		font-size: 1.5vh;
		color: white;
		user-select: none;
		height: 1005px;
		min-height: 1005px;
	}
</style>
