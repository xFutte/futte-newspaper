<script lang="ts">
	import {
		DataTable,
		DataTableHead,
		DataTableRow,
		DataTableCell,
		DataTableBody,
		Icon,
		Button,
		Dialog,
	} from 'svelte-materialify';

	import { mdiFileEdit } from '@mdi/js';
	import Create from './Create.svelte';

	// Stories will be provided by the content component
	export let stories;
	let updateContext = true;
	let active = false;
	let updateId: number | null = null;
	let playerName: string;

	function showForm(articleId: number) {
		active = true;
		updateId = articleId;
	}

	let close = () => {
		active = false;

		updateContext = updateContext ? false : true;
	};
</script>

<div class="container pt-4">
	<DataTable class="datatable">
		<DataTableHead>
			<DataTableRow>
				<DataTableCell>Id</DataTableCell>
				<DataTableCell>Title</DataTableCell>
				<DataTableCell numeric>Date</DataTableCell>
				<DataTableCell numeric>Update</DataTableCell>
			</DataTableRow>
		</DataTableHead>
		<DataTableBody>
			{#each stories as story}
				<DataTableRow>
					<DataTableCell>{story.id}</DataTableCell>
					<DataTableCell>{story.title}</DataTableCell>
					<DataTableCell numeric>{story.date}</DataTableCell>
					<DataTableCell numeric
						><Button on:click={() => showForm(story.id)}
							><Icon path={mdiFileEdit} /></Button
						></DataTableCell
					>
				</DataTableRow>
			{/each}
		</DataTableBody>
	</DataTable>
</div>

<Dialog persistent bind:active>
	<Create
		{updateContext}
		{stories}
		{updateId}
		{active}
		{close}
		{playerName}
	/>
</Dialog>

<style>
	.container {
		width: 100%;
	}

	:global(.s-tbl table),
	:global(.s-tbl) {
		width: 100%;
	}
</style>
