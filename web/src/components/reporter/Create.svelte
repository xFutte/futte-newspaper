<script lang="ts">
	import { Config } from './../../../config';
	import DOMPurify from 'dompurify';
	import moment from 'moment';
	import { TextField, Button, ExpansionPanel } from 'svelte-materialify';
	import { quill } from 'svelte-quill';
	import type { Story } from '../../interfaces/story';
	import { fetchNui } from '../../utils/fetchNui';

	export let closePublishAccordion = () => {};

	const options = {
		modules: {
			toolbar: Config.publishArticleControls,
		},
		placeholder:
			Config.text.reporterActions.publishStory.textareaPlaceholder,
		theme: 'snow',
	};

	const titleRules = [
		(value: string) => !!value || 'Required',
		(value: string) => value.length <= 25 || 'Max 25 characters',
	];

	let titleValue: string;
	let story: Story;
	let content: StoryBody;

	let imageError = '';

	function publishArticle(): void {
		const publishStory = document.querySelector('.publishStory');
		const titleInput: HTMLInputElement | null =
			document.querySelector('#title');
		const imageInput: HTMLInputElement | null =
			document.querySelector('#image');

		titleValue = DOMPurify.sanitize(titleInput?.value as string)
			? DOMPurify.sanitize(titleInput?.value as string)
			: '';

		const imageValue = isImage(
			DOMPurify.sanitize(imageInput?.value as string)
		)
			? (imageInput?.value as string)
			: '';

		const bodyValue = DOMPurify.sanitize(content.html);
		const dateValue = moment(new Date()).format('MMMM Do YYYY');

		if (titleValue.length)
			if (DOMPurify.isSupported) {
				// Sanitize input and post
				story = {
					type: 'news',
					image: imageValue,
					title: titleValue,
					body: bodyValue,
					date: dateValue,
				};

				fetchNui('publishStory', story);
			}

		// Make this work somehow..
		// closePublishAccordion();
	}

	function isImage(url: string): boolean {
		return /\.(jpg|jpeg|png|webp|avif|gif|svg)$/.test(url);
	}

	function imageUrlCheck(e): void {
		if (isImage(e.target.value)) {
			return;
		} else {
			imageError = 'Wrong image format';
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

	interface StoryBody {
		html: string;
		text: string;
	}
</script>

<div class="pt-4 container">
	<form id="form">
		<TextField
			counter={Config.articles.titleMaxLength}
			maxlength={Config.articles.titleMaxLength}
			on:input={(e) => (titleValue = e.target?.value)}
			rules={titleRules}
			id="title"
			outlined
			>{Config.text.reporterActions.publishStory
				.titlePlaceholder}</TextField
		>

		<TextField on:change={(e) => imageUrlCheck(e)} id="image" outlined
			>{Config.text.reporterActions.publishStory
				.imagePlaceholder}</TextField
		>
		<div
			class="editor mb-2"
			use:quill={options}
			on:text-change={(e) => (content = e.detail)}
		/>
		<Button
			disabled={!content && !titleValue}
			on:click={publishArticle}
			class="green white-text"
			>{Config.text.reporterActions.publishStory.publish}</Button
		>
		<Button disabled on:click={preview}
			>{Config.text.reporterActions.publishStory.preview}</Button
		>
	</form>
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
