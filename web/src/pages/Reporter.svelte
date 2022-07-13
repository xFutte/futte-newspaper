<script lang="ts">
	import { ExpansionPanel, ExpansionPanels, Icon } from 'svelte-materialify';
	import Create from '../components/reporter/Create.svelte';

	import { mdiPencil, mdiFileEdit, mdiDeleteForever } from '@mdi/js';
	import Delete from '../components/reporter/Delete.svelte';
	import type { Story } from '../interfaces/story';
</script>

<div class="pa-4">
	<h4>Reporter actions</h4>

	<div class="mt-2">
		<ExpansionPanels multiple>
			<ExpansionPanel>
				<span slot="header" class="pt-1"
					><Icon path={mdiPencil} class="mr-2" />Publish a new story</span
				>
				<Create />
			</ExpansionPanel>
			<ExpansionPanel disabled>
				<span slot="header" class="pt-1"><Icon path="{mdiFileEdit}" class="mr-2"/>Update stories (coming soon)</span>
				Lorem ipsum dolor sit amet consectetur, adipisicing elit. Repellat
				amet natus obcaecati molestiae quas mollitia error modi atque aliquam
				esse.
			</ExpansionPanel>
			<ExpansionPanel>
				<span slot="header" class="pt-1"
					><Icon path={mdiDeleteForever} class="mr-2" />Delete story</span
				>
				<Delete {stories} />
			</ExpansionPanel>
		</ExpansionPanels>
	</div>
</div>
