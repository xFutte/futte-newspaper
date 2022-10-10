<script lang="ts">
	import { Config } from '../../config';
	import type { ISentence } from '../interfaces/ISentence';

	export let sentences: Array<ISentence>;
</script>

<div class="sentences-container">
	<div class="sentences newspaper-left-page pa-5">
		<h4>{Config.text.prisonSentences.title}</h4>
		{#each sentences as sentence}<p class="mb-10">
				<strong>{sentence.jailed_player}</strong> has been sentenced to
				<strong
					>{sentence.jailed_time} month{Number(sentence.jailed_time) >
					1
						? 's'
						: ''}</strong
				>
				in Bolingbroke Penitentiary.<br />
				<small>{sentence.date}</small>
			</p>
		{/each}
	</div>
	<div class="image newspaper-right-page pa-5">
		<!-- svelte-ignore a11y-img-redundant-alt -->
		<img
			src={Config.prisonSentences.imageUrl}
			alt="Prison sentences image"
		/>
		<center
			><small><i>{Config.prisonSentences.imageCaption}</i></small></center
		>
	</div>
</div>

<style lang="scss">
	.sentences-container {
		display: flex;
		flex: 1;
		justify-content: space-between;
		height: 900px;

		.sentences {
			width: 65%;
			flex: 1;
		}
		
		.image {
			flex: 1;

			img {
				width: 100%;
			}
		}

		div {
			flex-grow: 1;
		}
	}
</style>
