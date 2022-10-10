<script lang="ts">
	import { visibility } from './store/stores';
	import VisibilityProvider from './providers/VisibilityProvider.svelte';
	import { MaterialApp } from 'svelte-materialify';
	import Content from './components/Content.svelte';
	import moment from 'moment';
	import type { INewspaperData } from './interfaces/INewspaperData';
	import type { ISentence } from './interfaces/ISentence';
	import type { Story } from './interfaces/story';

	let stories: Array<Story>;
	let reporterLevel: number;
	let reporterOnDuty: boolean;
	let isReporter: boolean;
	let sentences: Array<ISentence>;
	let playerName: string;

	window.addEventListener('message', (event) => {
		const data: INewspaperData = event.data;

		isReporter = data.isReporter;
		reporterLevel = data.reporterLevel;
		reporterOnDuty = data.reporterOnDuty;
		playerName = data.playerName;

		const placeholderStory = {
			id: 0,
			title: 'Welcome to futte-newspaper',
			body: "<p>futte-newspaper is a standalone ressource for FiveM. It has the following dependencies:</p><p><ul><li>qb-target</li><li>oxmysql</li></ul></p><p>I hope you'll enjoy the resource. Feel free to open issues if you find a bug/wish new functionality.</p><p>- xFutte</p>",
			image: 'https://w0.peakpx.com/wallpaper/131/302/HD-wallpaper-grand-theft-auto-5-gta-v-grand-theft-auto-v-open-world-gaming-video-game-game-gta-5.jpg',
			date: moment().format('MMMM Do YYYY'),
			type: 'news',
			publisher: 'xFutte @ Github',
		};

		stories = data.stories.length ? data.stories : [placeholderStory];
		sentences = data.sentences.length ? data.sentences : [];

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
			<div class="background">
				<Content
					{stories}
					{isReporter}
					{reporterLevel}
					{reporterOnDuty}
					{sentences}
					{playerName}
				/>
			</div>
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

	.background {
		background-image: url(assets/background2.jpg);
		height: 1005px;
	}

	:global(.newspaper-left-page) {
		box-shadow: inset rgb(187 187 187) -9px 0px 20px 0px;
	}

	:global(.newspaper-right-page) {
		box-shadow: inset rgb(187 187 187) 9px 0px 20px 0px;
		    border-left: 1px solid rgba(119, 118, 118, 0.7);
	}
</style>
