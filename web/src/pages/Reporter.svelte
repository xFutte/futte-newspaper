<script lang="ts">
	import { ExpansionPanel, ExpansionPanels, Icon } from 'svelte-materialify';
	import Create from '../components/reporter/Create.svelte';

	import { mdiPencil, mdiFileEdit, mdiDeleteForever } from '@mdi/js';
	import Delete from '../components/reporter/Delete.svelte';
	import { Config } from '../../config';

	import type { Story } from '../interfaces/story';
	import type { IReporterLevels } from '../interfaces/IReporterLevels';

	export let stories: Array<Story>;
	export let reporterLevel: number;

	const reporterPermissions = Config.reporter.find(
		(permissions: IReporterLevels) => permissions.grade === reporterLevel
	) as IReporterLevels;
</script>

<div class="pa-4">
	<h4>{Config.text.reporterActions.title}</h4>
	{#if !reporterPermissions.canPublish && !reporterPermissions.canEdit && !reporterPermissions.canDelete}
		<p>{Config.text.reporterActions.noPermissions}</p>
	{:else}
		<div class="mt-2">
			<ExpansionPanels multiple>
				{#if reporterPermissions.canPublish}
					<ExpansionPanel>
						<span slot="header" class="pt-1"
							><Icon path={mdiPencil} class="mr-2" />{Config.text
								.reporterActions.publishNewStory}</span
						>
						<Create />
					</ExpansionPanel>
				{/if}
				{#if reporterPermissions.canEdit}
					<ExpansionPanel disabled>
						<span slot="header" class="pt-1"
							><Icon path={mdiFileEdit} class="mr-2" />{Config
								.text.reporterActions.updateStories}</span
						>
						Lorem ipsum dolor sit amet consectetur, adipisicing elit.
						Repellat amet natus obcaecati molestiae quas mollitia error
						modi atque aliquam esse.
					</ExpansionPanel>
				{/if}
				{#if reporterPermissions.canDelete}
					<ExpansionPanel>
						<span slot="header" class="pt-1"
							><Icon
								path={mdiDeleteForever}
								class="mr-2"
							/>{Config.text.reporterActions.deleteStories}</span
						>
						<Delete {stories} />
					</ExpansionPanel>
				{/if}
			</ExpansionPanels>
		</div>
	{/if}
</div>
