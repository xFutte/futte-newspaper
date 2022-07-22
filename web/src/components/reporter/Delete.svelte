<script lang="ts">
	import moment from 'moment';
	import {
		DataTable,
		DataTableHead,
		DataTableRow,
		DataTableCell,
		DataTableBody,
		Icon,
		Button,
		Dialog,
		Card,
		CardTitle,
		CardText,
		CardActions,
	} from 'svelte-materialify';

	import { mdiDeleteForever } from '@mdi/js';
	import { fetchNui } from '../../utils/fetchNui';

	// Stories will be provided by the content component
	export let stories;

	let payload: object = {};
	let active = false;
	let deleteId: number | null = null;

	function open(id: number) {
		active = true;

		deleteId = id;
	}
	function close(remove: boolean): void {
		active = false;

		if (remove === false) {
			return;
		}

		// Made to an object to be more flexible for further implementation if desired
		payload = {
			id: deleteId,
		};

		fetchNui('deleteStory', payload);

		deleteId = null;
		payload = {};
	}
</script>

<div class="container pt-4">
	<DataTable class="datatable">
		<DataTableHead>
			<DataTableRow>
				<DataTableCell>Id</DataTableCell>
				<DataTableCell>Title</DataTableCell>
				<DataTableCell numeric>Date</DataTableCell>
				<DataTableCell numeric>Delete</DataTableCell>
			</DataTableRow>
		</DataTableHead>
		<DataTableBody>
			{#each stories as story}
				<DataTableRow id={story.id}>
					<DataTableCell>{story.id}</DataTableCell>
					<DataTableCell>{story.title}</DataTableCell>
					<DataTableCell numeric>{story.date}</DataTableCell>
					<DataTableCell numeric
						><Button on:click={() => open(story.id)}
							><Icon path={mdiDeleteForever} /></Button
						></DataTableCell
					>
				</DataTableRow>
			{/each}
		</DataTableBody>
	</DataTable>
</div>

<Dialog persistent bind:active>
	<Card>
		<CardTitle>Delete story?</CardTitle>
		<CardText>
			Are you sure you want to delete the story? This can't be undone.
		</CardText>
		<CardActions>
			<Button on:click={() => close(true)} text class="red-text"
				>Delete</Button
			>
			<Button on:click={() => close(false)} text>Cancel</Button>
		</CardActions>
	</Card>
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
