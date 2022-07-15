<script lang="ts">
	import DOMPurify from 'dompurify';

	import moment from 'moment';

	import { TextField, Button } from 'svelte-materialify';
	import { quill } from 'svelte-quill';
	import { fetchNui } from '../../utils/fetchNui';

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

		// Sanitize input and post
		if (DOMPurify.isSupported) {
			story = {
				type: 'news',
				image: DOMPurify.sanitize(image?.value as string),
				title: DOMPurify.sanitize(title?.value as string)
					? DOMPurify.sanitize(title?.value as string)
					: '',
				body: DOMPurify.sanitize(content.html),
				date: moment(new Date()).format('MMMM Do YYYY'),
			};

			fetchNui('publishStory', story);
		}
	}

	let active = false;

	function close() {
		active = false;
	}

	function preview() {
		active = true;

		const container = document.querySelector('.preview-content');
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
	<div
		class="editor mb-2"
		use:quill={options}
		on:text-change={(e) => (content = e.detail)}
	/>
	<Button on:click={publishArticle} class="green white-text">Publish</Button>
	<Button disabled on:click={preview}>Preview (Coming soon)</Button>
</div>

<!-- <Dialog persistent bind:active>
	<div class="preview-content">

	</div>

	<Button on:click={publishArticle} class="green white-text">Publish</Button>
	<Button on:click={close}>Back</Button>
</Dialog> -->
<style>
	.container {
		width: 100%;
	}

	.editor {
		height: 200px;
	}
</style>
