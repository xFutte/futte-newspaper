<script lang="ts">
	import { visibility } from './store/stores';
	import VisibilityProvider from './providers/VisibilityProvider.svelte';
	import { MaterialApp } from 'svelte-materialify';
	import Content from './components/Content.svelte';
	import type { Story } from './interfaces/story';
	import moment from 'moment';

	let stories: Array<Story>;
	let isReporter: boolean;

	window.addEventListener('message', (event) => {
		isReporter = event.data.isReporter;

		if (!event.data.stories.length) {
			// Fallback story if there are no stories found
			stories = [
				{
					id: 0,
					title: 'No news',
					body: 'The newspaper is blank. Contact your local newsteam to make them publish something!',
					image: 'https://media3.giphy.com/media/l2JhORT5IFnj6ioko/giphy.gif?cid=ecf05e471lmb6vl1v3yftrccoy783zss3hmnkr7kccfzctxi&rid=giphy.gif&ct=g',
					date: moment().format('MMMM Do YYYY'),
					type: 'news',
				},
			];
		} else {
			stories = event.data.stories;
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
			<Content {stories} {isReporter} />
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
