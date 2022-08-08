<script lang="ts">
	import {
		Tabs,
		Tab,
		Window,
		WindowItem,
		AppBar,
		Icon,
	} from 'svelte-materialify';
	import News from '../pages/News.svelte';
	import Reporter from '../pages/Reporter.svelte';

	import { mdiStar } from '@mdi/js';
	import type { Story } from '../interfaces/story';
	import { Config } from '../../config';
	import PrisonSentences from '../pages/PrisonSentences.svelte';
	import type { ISentence } from '../interfaces/ISentence';

	let value = 0;

	export let stories: Array<Story>;
	export let isReporter: boolean;
	export let reporterOnDuty: boolean;
	export let reporterLevel: number;
	export let sentences: Array<ISentence>;
	export let playerName: string;
</script>

<AppBar>
	<span slot="title"> {Config.newspaperTitle} </span>
	<div slot="extension">
		<Tabs class="green-text" bind:value fixedTabs>
			<div slot="tabs">
				<Tab>{Config.text.tabs.newspaper}</Tab>
				{#if Config.tabs.showPrisonSentences}<Tab
						>{Config.text.tabs.prisonSentences}</Tab
					>{/if}
				{#if isReporter && reporterOnDuty}<Tab
						><Icon path={mdiStar} /><span class="ml-2"
							>{Config.text.tabs.reporterActions}</span
						></Tab
					>{/if}
			</div>
		</Tabs>
	</div>
</AppBar>

<Window {value}>
	<WindowItem>
		<News {stories} />
	</WindowItem>
	{#if Config.tabs.showPrisonSentences}
		<WindowItem>
			<PrisonSentences {sentences} />
		</WindowItem>
	{/if}
	{#if Config.tabs.showCityNews}
		<WindowItem>
			<!-- Might be implemented of requested -->
		</WindowItem>
	{/if}
	{#if isReporter}
		<WindowItem>
			<Reporter {stories} {reporterLevel} {isReporter} {playerName} />
		</WindowItem>
	{/if}
</Window>
