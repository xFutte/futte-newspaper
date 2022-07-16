<script lang="ts">
	import { Config } from './../../../config';
	import DOMPurify from 'dompurify';
	import moment from 'moment';
	import { TextField, Button, ExpansionPanel } from 'svelte-materialify';
	import { quill } from 'svelte-quill';
	import type { Story } from '../../interfaces/story';
	import { fetchNui } from '../../utils/fetchNui';
	import { onMount } from 'svelte';

	export let closePublishAccordion = () => {};

	const options = {
		modules: {
			toolbar: Config.publishArticleControls,
		},
		placeholder:
			Config.text.reporterActions.publishStory.textareaPlaceholder,
		theme: 'snow',
	};

	let titleInput: HTMLInputElement | null;
	let imageInput: HTMLInputElement | null;
	let titleValue: string;
	let imageValue: string;
	let bodyValue: string | undefined;
	let story: Story;

	let validUrl: boolean = true;
	let validBody: boolean = false;
	let validTitle: boolean = false;

	onMount(() => {
		titleInput = document.querySelector('#title');
		imageInput = document.querySelector('#image');
	});

	function publishArticle(): void {
		if (DOMPurify.isSupported) {
			if (titleValue && bodyValue) {
				story = {
					type: 'news',
					image: imageValue,
					title: titleValue,
					body: bodyValue as string,
					date: moment(new Date()).format('MMMM Do YYYY'),
				};

				fetchNui('publishStory', story);
			}
		} else {
			console.log('DOMPurify is not supported.');
		}
	}

	// Make this work somehow..
	// closePublishAccordion();

	function isImage(url: string): boolean {
		return /\.(jpg|jpeg|png|webp|avif|gif|svg)$/.test(url);
	}

	function imageUrlCheck(e): void {
		imageValue = DOMPurify.sanitize(e.target.value);

		validUrl = isImage(imageValue) || imageValue === '' ? true : false;
	}

	function titleCheck(e): void {
		titleValue = DOMPurify.sanitize(e.target.value);
		validTitle = titleValue.length ? true : false;
	}

	function updateBodyValue(e): void {
		bodyValue = DOMPurify.sanitize(e.detail.html);

		// If everything gets deleted from the textarea, <p><br></p> will still be left. Reset the value to ''
		if (bodyValue === '<p><br></p>') {
			bodyValue = undefined;
		}

		validBody = bodyValue?.length ? true : false;
	}
</script>

<div class="pt-4 container">
	<form id="form">
		<TextField
			on:change={(e) => titleCheck(e)}
			on:input={(e) => titleCheck(e)}
			on:keydown={(e) => titleCheck(e)}
			id="title"
			outlined
			>{Config.text.reporterActions.publishStory
				.titlePlaceholder}</TextField
		>

		<TextField
			on:change={(e) => imageUrlCheck(e)}
			on:input={(e) => imageUrlCheck(e)}
			on:keydown={(e) => imageUrlCheck(e)}
			id="image"
			outlined
			>{Config.text.reporterActions.publishStory
				.imagePlaceholder}</TextField
		>

		<p class="error-text">
			<small
				>{#if !validUrl}
					{Config.text.reporterActions.publishStory.wrongImageFormat}
				{/if}</small
			>
		</p>

		<div
			class="editor mb-2"
			use:quill={options}
			on:text-change={(e) => updateBodyValue(e)}
		/>
		<Button
			disabled={!validBody || !validTitle || !validUrl}
			on:click={publishArticle}
			class="green white-text"
			>{Config.text.reporterActions.publishStory.publish}</Button
		>
		<Button disabled
			>{Config.text.reporterActions.publishStory.preview}</Button
		>
	</form>
</div>

<style>
	.container {
		width: 100%;
	}

	.editor {
		height: 200px;
	}
</style>
