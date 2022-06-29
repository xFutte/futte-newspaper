<script lang="ts" defer>
	import moment from 'moment';

	let stories: Array<Story> = [];
	let selectedStory: number = 0;


	function updateMainStory(story: Story): void {
		selectedStory = story.id - 1;
	}

	stories = [
		{
			id: 1,
			type: 'news',
			image: 'https://i.ytimg.com/vi/VDcldO8jGTI/maxresdefault.jpg',
			header: 'Story 1',
			body: '<p>boasdasddy</p>',
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

	// Interfaces
	interface Story {
		id: number;
		type: string;
		image: string;
		header: string;
		body: string;
		date: string;
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
		{stories[selectedStory].body}
	</div>
	<div class="previous">
		<h4 class="ma-4">Other stories</h4>
		{#each stories as story}
			<div
				on:click={() => updateMainStory(story)}
				class="story pt-3 pb-2 pl-4 pr-4"
			>
				<h6>{story.header}</h6>
				<small>{story.date}</small>
				<p>{story.body}</p>
			</div>
		{/each}
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

	.story:hover {
		background: lightgrey;
		cursor: pointer;
	}
</style>
