<script lang="ts">
	import moment from 'moment';
	import { onMount } from 'svelte';

	let stories: Array<Story> = [];
	let selectedStory: number = 0;

	function updateMainStory(id: number): void {
		selectedStory = id - 1;

		const body = document.querySelector('.body-content');

		// We need to do insert the text into the DOM this way due to how we get everything from the backend
		if (body) {
			body.innerHTML = stories[id - 1].body;
		}
	}

	stories = [
		{
			id: 1,
			type: 'news',
			image: 'https://i.ytimg.com/vi/VDcldO8jGTI/maxresdefault.jpg',
			header: 'Story 1',
			body: '<p>boasdasddy</p><p>boasdasddy</p><p>boasdasddy</p><p>boasdasddy</p>',
			date: moment(new Date()).format('LLL'),
		},
		{
			id: 2,
			type: 'news',
			image: 'https://ichef.bbci.co.uk/news/999/cpsprodpb/15951/production/_117310488_16.jpg',
			header: 'Story 2',
			body: '<p>boasdasddy</p>',
			date: moment(new Date()).format('LLL'),
		},
	];

	let bodyElement: HTMLDivElement | null =
		document.querySelector('.body-content');

	if (bodyElement) {
		bodyElement.innerHTML = stories[0].body;
	}

	function ConvertStringToHTML(convert: string): HTMLElement {
		let parser = new DOMParser();
		let doc = parser.parseFromString(convert, 'text/html');

		return doc.body;
	}

	console.log(ConvertStringToHTML(stories[0].body).innerHTML);

	// Interfaces
	interface Story {
		id: number;
		type: string;
		image: string;
		header: string;
		body: string;
		date: string;
	}

	onMount(() => {
		updateMainStory(1);
		updateOtherStories();
	});

	function updateOtherStories(): void {
		stories.forEach((story: Story) => {
			const container = document.querySelector('.other-stories');

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

			title.innerHTML = story.header;
			body.innerHTML = story.body;
			date.innerHTML = story.date;

			storyContainer?.appendChild(title);
			storyContainer?.appendChild(date);
			storyContainer?.appendChild(body);

			storyContainer.addEventListener('click', () => {
				updateMainStory(story.id)
			})

			container?.appendChild(storyContainer);
		});

		
	}
</script>

<div class="container">
	<div class="latest pa-4">
		<!-- svelte-ignore a11y-missing-attribute -->
		<div class="main_article_image">
			<img src={stories[selectedStory].image} />
		</div>

		<h4 class="mt-2">{stories[selectedStory].header}</h4>
		<p><small>{stories[selectedStory].date}</small></p>
		<div class="body-content" />
	</div>
	<div class="previous">
		<h4 class="ma-4">Other stories</h4>
		<div class="other-stories" />
		<div class="story" style="display: none"></div>
		<!-- {#each stories as story}
			<div
				on:click={() => updateMainStory(story.id)}
				class="story pt-3 pb-2 pl-4 pr-4"
			>
				<h6>{story.header}</h6>
				<small>{story.date}</small>
				<p>
					{story.body}
				</p>
			</div>
		{/each} -->
	</div>
</div>

<style>
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
