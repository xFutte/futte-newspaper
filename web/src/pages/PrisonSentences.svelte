<script lang="ts">
	import { Config } from '../../config';
	import type { ISentence } from '../interfaces/ISentence';

	export let sentences: Array<ISentence>;
</script>

<div class="pa-4">
	<h4>{Config.text.prisonSentences.title}</h4>

	<div class="sentences-container mt-10">
		<div class="sentences">
			{#each sentences as sentence}<p class="mb-10">
					<strong>{sentence.jailed_player}</strong> has been sentenced
					to
					<strong
						>{sentence.jailed_time} month{Number(
							sentence.jailed_time
						) > 1
							? 's'
							: ''}</strong
					>
					in Bolingbroke Penitentiary.<br />
					<small>{sentence.date}</small>
				</p>
			{/each}
		</div>
		<div class="image">
			<!-- svelte-ignore a11y-img-redundant-alt -->
			<img
				src={Config.prisonSentences.imageUrl}
				alt="Prison sentences image"
			/>
			<center><small><i>{Config.prisonSentences.imageCaption}</i></small></center>
		</div>
	</div>
</div>

<style lang="scss">
	.sentences-container {
		display: flex;
		flex: 1;
		justify-content: space-between;

		.sentences {
			width: 65%;
		}

		div {
			flex-grow: 1;
		}
	}
</style>
