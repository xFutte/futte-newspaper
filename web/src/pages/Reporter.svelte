<script lang="ts">
	import { ExpansionPanel, ExpansionPanels, Icon } from 'svelte-materialify';
	import Create from '../components/reporter/Create.svelte';

	import { mdiPencil, mdiFileEdit, mdiDeleteForever } from '@mdi/js';
	import Delete from '../components/reporter/Delete.svelte';
	import Update from '../components/reporter/Update.svelte';
	import { Config } from '../../config';

	import type { Story } from '../interfaces/story';
	import type { IReporterLevels } from '../interfaces/IReporterLevels';

	export let stories: Array<Story>;
	export let reporterLevel: number;
	export let isReporter: boolean;
	export let playerName: string;

	let updateContext = false;
	let updateId = undefined;
	let active = false;
	const reporterPermissions = Config.reporter.find(
		(permissions: IReporterLevels) => permissions.grade === reporterLevel
	) as IReporterLevels;
</script>

<div class="pa-4 reporter-page">
	<h4>{Config.text.reporterActions.title}</h4>
	{#if !isReporter || (!reporterPermissions.canPublish && !reporterPermissions.canEdit && !reporterPermissions.canDelete)}
		<p>{Config.text.reporterActions.noPermissions}</p>
	{:else}
		<div class="mt-2">
			<ExpansionPanels multiple>
				{#if reporterPermissions.canPublish}
					<ExpansionPanel class="publishStory">
						<span slot="header" class="pt-1"
							><Icon path={mdiPencil} class="mr-2" />{Config.text
								.reporterActions.publishNewStory}</span
						>
						<Create
							{updateContext}
							{stories}
							{updateId}
							{active}
							{playerName}
						/>
					</ExpansionPanel>
				{/if}
				{#if reporterPermissions.canEdit}
					<ExpansionPanel>
						<span slot="header" class="pt-1"
							><Icon path={mdiFileEdit} class="mr-2" />{Config
								.text.reporterActions.updateStories}</span
						>
						<Update {stories} />
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

<style lang="scss">
	.reporter-page {
		height: 900px;
	}
</style>
