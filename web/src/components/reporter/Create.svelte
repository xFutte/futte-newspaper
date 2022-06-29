<script lang="ts">
	import moment from 'moment';

	import { TextField, Textarea, Button } from 'svelte-materialify';
	import { quill } from 'svelte-quill';
	import { fetchNui } from '../../utils/fetchNui';
	import { useNuiEvent } from '../../utils/useNuiEvent';

	const options = {
		modules: {
			toolbar: [['bold', 'italic', 'underline', 'strike']],
		},
		placeholder: 'Type something...',
		theme: 'snow',
	};

	let story: Story;
	let content: StoryBody;

	async function publishArticle(): Promise<void> {
		const title: HTMLInputElement | null = document.querySelector('#title');
		const image: HTMLInputElement | null = document.querySelector('#image');

		// No security check initially - will be added
		story = {
			type: 'news',
			image: image?.value,
			title: title ? title.value : '',
			body: content.html,
			date: new Date().toUTCString(),
		};

		fetchNui('publishStory', story);
	}

	interface Story {
		id?: number;
		type: string;
		image?: string;
		title: string;
		body: string;
		date: string;
	}

	interface StoryBody {
		html: string;
		text: string;
	}
</script>

<div class="pt-4 container">
	<TextField id="title" outlined>Title</TextField>
	<TextField id="image" outlined>Image URL</TextField>
	<!-- <Textarea id="body" outlined>Body</Textarea> -->
	<div
		class="editor mb-2"
		use:quill={options}
		on:text-change={(e) => (content = e.detail)}
	/>
	<Button on:click={publishArticle}>Publish</Button>
</div>

<style>
	.container {
		width: 100%;
	}

	.editor {
		height: 200px;
	}
</style>
