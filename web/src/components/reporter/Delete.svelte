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

	interface Story {
		id: number;
		type: string;
		image: string;
		header: string;
		body: string;
		date: string;
	}

	let stories: Array<Story> = [];
	let active = false;
	let deleteId: number | null = null;

	function open(id: number) {
		active = true;

		deleteId = id;
	}
	function close(remove: boolean): void {
		active = false;

		if (remove === false) {
			console.log('Not removing');
			return;
		}

		console.log('Remove story with id ' + deleteId);
		deleteId = null;
	}

	stories = [
		{
			id: 1,
			type: 'news',
			image: 'https://i.ytimg.com/vi/VDcldO8jGTI/maxresdefault.jpg',
			header: 'Story 1',
			body: '<p>boasdasddy</p>',
			date: moment(new Date()).format('LLL'),
		},
		{
			id: 2,
			type: 'news',
			image: 'https://ichef.bbci.co.uk/news/999/cpsprodpb/15951/production/_117310488_16.jpg',
			header: 'Story 2',
			body: '<p>boasdasddy</p>',
			date: moment(new Date()).format('LLL'),
		},
	];
</script>

<div class="container pt-4">
	<DataTable>
		<DataTableHead>
			<DataTableRow>
				<DataTableCell>Id</DataTableCell>
				<DataTableCell>Title</DataTableCell>
				<DataTableCell numeric>Date</DataTableCell>
				<DataTableCell>Delete</DataTableCell>
			</DataTableRow>
		</DataTableHead>
		<DataTableBody>
			{#each stories as story}
				<DataTableRow>
					<DataTableCell>{story.id}</DataTableCell>
					<DataTableCell>{story.header}</DataTableCell>
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
			Lorem ipsum, dolor sit amet consectetur adipisicing elit. Mollitia
			deleniti natus dolore, rerum hic beatae officiis at ea sequi labore.
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

	:global(.s-tbl > table) {
		width: 100%;
	}
</style>