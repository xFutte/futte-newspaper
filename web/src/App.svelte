<script lang="ts">
	import { visibility } from './store/stores';
	import VisibilityProvider from './providers/VisibilityProvider.svelte';
	import { MaterialApp } from 'svelte-materialify';
	import Content from './components/Content.svelte';
	import type { Story } from './interfaces/story';
	import moment from 'moment';

	const imagePlaceholder: string =
		'https://reviverestore.org/wp-content/uploads/2017/05/placeholder-image-cropped.jpg';

	let stories: Array<Story>;

	window.addEventListener('message', (event) => {
		

		if (!event.data.stories.length) {
			stories = [
				{
					id: 0,
					title: 'No news',
					body: 'The newspaper is blank. Contact your local newsteam to make them publish something!',
					image: 'https://media4.giphy.com/media/XEZZliwJmGg6otzKK1/giphy.gif?cid=ecf05e4774hvzt8xh1biwz0a03w9lser5n4rng5mh6uodji0&rid=giphy.gif&ct=g',
					date: moment().format(),
					type: 'news',
				},
			];
		} else {
			stories = event.data.stories;
		}

		visibility.set(true);
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
