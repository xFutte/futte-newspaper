<script lang="ts">
	import { visibility } from './store/stores';
	import VisibilityProvider from './providers/VisibilityProvider.svelte';
	import { MaterialApp } from 'svelte-materialify';
	import Content from './components/Content.svelte';
	import type { Story } from './interfaces/story';
	import moment from 'moment';

	let stories: Array<Story>;
	let reporterLevel: number;
	let isReporter: boolean;

	window.addEventListener('message', (event) => {
		const data = event.data;

		isReporter = data.isReporter;
		reporterLevel = data.reporterLevel;

		if (!data.stories.length) {
			// Placeholder story if none is available in the database - should be updated before use of resource
			stories = [
				{
					id: 0,
					title: 'Welcome to qb-newsstands',
					body: "<p>qb-newsstands is a standalone ressource for FiveM. It has the following dependencies:</p><p><ul><li>qb-target</li><li>oxmysql</li></ul></p><p>I hope you'll enjoy the resource. Feel free to open issues if you find a bug/wish new functionality.</p><p>- xFutte</p>",
					image: 'https://w0.peakpx.com/wallpaper/131/302/HD-wallpaper-grand-theft-auto-5-gta-v-grand-theft-auto-v-open-world-gaming-video-game-game-gta-5.jpg',
					date: moment().format('MMMM Do YYYY'),
					type: 'news',
					publisher: 'xFutte @ Github',
				},
			];
		} else {
			stories = data.stories;
		}

		// Show the newspaper GUI
		visibility.set(true);
	});
</script>

<svelte:head>
	<link href="//cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet" />
</svelte:head>

<main class="container">
	<VisibilityProvider>
		<MaterialApp>
			<Content {stories} {isReporter} {reporterLevel} />
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
