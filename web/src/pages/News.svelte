<script lang="ts">
	import { onMount } from 'svelte';
	import moment from 'moment';
	import type { Story } from '../interfaces/story';

	// Placeholder image if none is provided/wrong image link
	const imagePlaceholder: string =
		'https://reviverestore.org/wp-content/uploads/2017/05/placeholder-image-cropped.jpg';

	export let stories: Array<Story>;

	let body: HTMLDivElement | null;
	let image: HTMLImageElement | null;
	let selectedStory: number = 0;

	function updateMainStory(id: number): void {
		selectedStory = id;

		// We need to do insert the text into the DOM this way due to how we get everything from the backend
		if (body) {
			body.innerHTML = stories[selectedStory].body;
		}
	}

	onMount(() => {
		body = document.querySelector('.body-content');

		updateMainStory(0);
		updateOtherStories();
	});

	function updateOtherStories(): void {
		stories.forEach((story: Story, index) => {
			const container = document.querySelector('.all-stories');

			const storyContainer = document.createElement('div');

			storyContainer.classList.add(
				'story',
				'pt-3',
				'pb-2',
				'pl-4',
				'pr-4'
			);

			const title = document.createElement('h6');
			const body = document.createElement('div');
			const date = document.createElement('small');

			title.innerHTML = story.title;
			body.innerHTML = story.body;
			date.innerHTML = story.date;

			storyContainer?.appendChild(title);
			storyContainer?.appendChild(date);
			storyContainer?.appendChild(body);
			storyContainer.setAttribute('data-id', index.toString());

			storyContainer.addEventListener('click', () => {
				updateMainStory(index);
			});

			container?.appendChild(storyContainer);
		});
	}
</script>

<div class="container">
	{#if stories.length > 0}
		<div class="latest pa-4">
			<div class="main_article_image">
				<!-- svelte-ignore a11y-img-redundant-alt -->
				<img
					src={stories[selectedStory ? selectedStory : 0].image
						? stories[selectedStory ? selectedStory : 0].image
						: imagePlaceholder}
					alt="Story image"
				/>
			</div>

			<h4 class="mt-2">
				{stories[selectedStory ? selectedStory : 0].title}
			</h4>
			<p>
				<small>{stories[selectedStory ? selectedStory : 0].date}</small>
			</p>
			<div class="body-content" />
		</div>
		<div class="previous">
			<h4 class="ma-4">All stories</h4>
			<div class="all-stories" />
			<div class="story" style="display: none" />
		</div>
	{/if}
</div>

<style lang="scss">
	$scrollbar-thumb-color: #90a4ae;
	$scrollbar-background-color: #cfd8dc;

	.container {
		display: flex;
		flex-direction: row;
		flex: 1;
	}

	.previous,
	.latest {
		height: 895px;
		overflow: auto;
	}

	.previous {
		flex: 1;
	}

	.latest {
		width: 65%;

		scrollbar-width: thin;
		scrollbar-color: $scrollbar-thumb-color $scrollbar-background-color;

		&::-webkit-scrollbar {
			width: 10px;
		}

		&::-webkit-scrollbar-track {
			background: $scrollbar-background-color;
		}

		&::-webkit-scrollbar-thumb {
			background-color: $scrollbar-thumb-color;
			border-radius: 6px;
			border: 3px solid $scrollbar-background-color;
		}
	}

	.main_article_image {
		width: 100%;
	}

	.main_article_image img {
		width: 100%;
	}

	div :global(.story:hover) {
		background: lightgrey;
		cursor: pointer;
	}
</style>
