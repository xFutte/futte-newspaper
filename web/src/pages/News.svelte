<script lang="ts">
	import { onMount } from 'svelte';
	import moment from 'moment';
	import type { Story } from '../interfaces/story';
	import { Config } from '../../config';

	// Placeholder image if none is provided/wrong image link
	const imagePlaceholder: string =
		'https://reviverestore.org/wp-content/uploads/2017/05/placeholder-image-cropped.jpg';

	export let stories: Array<Story>;

	let body: HTMLDivElement | null;
	let selectedStory: number = 0;

	let storyTitle: string | undefined;
	let storyImage: string | undefined;
	let storyPublisher: string | undefined;
	let storyDate: string | undefined;

	function updateMainStory(id: number): void {
		selectedStory = id;

		storyImage = stories[selectedStory].image;
		storyTitle = stories[selectedStory].title;
		storyPublisher = stories[selectedStory].publisher;
		storyDate = stories[selectedStory].date;

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
				'ellipsis',
				'pt-3',
				'pb-2',
				'pl-3',
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
		<div class="latest pa-5 newspaper-left-page">
			{#if Config.articles.showImage}
				{#if storyImage}<div class="main_article_image">
						<!-- svelte-ignore a11y-img-redundant-alt -->
						<img src={storyImage} alt="Story image" />
					</div>
				{/if}
			{/if}

			{#if Config.articles.showTitle}
				<h4 class="mt-2">
					{storyTitle}
				</h4>
			{/if}

			{#if Config.articles.showPublisher || Config.articles.showDate}
				<p>
					<small
						>{#if Config.articles.showPublisher}{Config.text
								.articles.writtenBy}
							{storyPublisher}
							{#if Config.articles.showPublisher && Config.articles.showDate}{Config
									.text.articles.on}{/if}
						{/if}{#if Config.articles.showDate}{storyDate}{/if}
					</small>
				</p>
			{/if}

			<hr class="seperator" />

			<div class="body-content" />
		</div>
		<div class="previous pa-5 newspaper-right-page">
			<h4 class="ml-3 mr-3 mb-3 mt-0">{Config.text.articles.latestStories}</h4>
			<div class="all-stories" />
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

	.seperator {
		margin-bottom: 1em;
	}

	.previous,
	.latest {
		flex: 1;
		height: 900px;
		overflow: auto;

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

	:global(.story:hover) {
		background: rgb(154 154 154 / 10%);
		cursor: pointer;
	}

	:global(.ellipsis) {
		display: -webkit-box;
		-webkit-line-clamp: 4;
		-webkit-box-orient: vertical;
		overflow: hidden;
	}


</style>
