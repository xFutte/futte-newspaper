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

	let value = 3;

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
				{#if Config.tabs.showCityNews}<Tab disabled
						>{Config.text.tabs.cityUpdates}</Tab
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
	<WindowItem>
		<PrisonSentences {sentences} />
	</WindowItem>
	<WindowItem>
		<h4>City updates</h4>
		<p>
			Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec
			accumsan, diam et elementum gravida, arcu mi fermentum nibh, vel
			dapibus ligula orci non est. Morbi commodo sagittis finibus.
			Maecenas in volutpat massa. Nullam vulputate metus velit, quis
			interdum elit imperdiet ut. Suspendisse et sagittis erat, euismod
			vulputate enim. Etiam feugiat sit amet justo vitae commodo.
		</p>
	</WindowItem>
	{#if isReporter}
		<WindowItem>
			<Reporter {stories} {reporterLevel} {isReporter} {playerName} />
		</WindowItem>
	{/if}
</Window>
