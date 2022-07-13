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

	let value = 0;
	let isReporter = true;

	export let stories: Array<Story>;

</script>

<AppBar>
	<span slot="title"> Los Santos News </span>
	<div slot="extension">
		<Tabs class="green-text" bind:value fixedTabs>
			<div slot="tabs">
				<Tab>Newspaper</Tab>
				<!-- <Tab>Prison sentences</Tab>
				<Tab>City updates</Tab> -->
				{#if isReporter == true}<Tab
						><Icon path={mdiStar} /><span class="ml-2"
							>Reporter actions</span
						></Tab
					>{/if}
			</div>
		</Tabs>
	</div>
</AppBar>

<Window {value}>
	<WindowItem>
		<News stories={stories} />
	</WindowItem>
	<!-- <WindowItem>
		<h4>Item 2</h4>
		<p>
			Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec
			accumsan, diam et elementum gravida, arcu mi fermentum nibh, vel
			dapibus ligula orci non est. Morbi commodo sagittis finibus.
			Maecenas in volutpat massa. Nullam vulputate metus velit, quis
			interdum elit imperdiet ut. Suspendisse et sagittis erat, euismod
			vulputate enim. Etiam feugiat sit amet justo vitae commodo.
		</p>
	</WindowItem>
	<WindowItem>
		<h4>Item 3</h4>
		<p>
			Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec
			accumsan, diam et elementum gravida, arcu mi fermentum nibh, vel
			dapibus ligula orci non est. Morbi commodo sagittis finibus.
			Maecenas in volutpat massa. Nullam vulputate metus velit, quis
			interdum elit imperdiet ut. Suspendisse et sagittis erat, euismod
			vulputate enim. Etiam feugiat sit amet justo vitae commodo.
		</p>
	</WindowItem> -->
	<WindowItem>
		<Reporter />
	</WindowItem>
</Window>
