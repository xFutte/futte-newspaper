<script lang="ts">
	import { Config } from './../../../config';
	import DOMPurify from 'dompurify';
	import moment from 'moment';
	import { TextField, Button, ExpansionPanel } from 'svelte-materialify';
	import { quill } from 'svelte-quill';
	import type { Story } from '../../interfaces/story';
	import { fetchNui } from '../../utils/fetchNui';
	import { onMount } from 'svelte';

	export let updateContext;
	export let stories: Array<Story>;
	export let updateId;
	export let active;

	export let close = () => {};

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
	let bodyInput: HTMLDivElement | null;
	let titleValue: string = '';
	let imageValue: string = '';
	let bodyValue: string | undefined = '';
	let story: Story;

	let validUrl: boolean = true;
	let validBody: boolean = false;
	let validTitle: boolean = false;

	onMount(() => {
		titleInput = document.querySelector('#title');
		imageInput = document.querySelector('#image');
		bodyInput = document.querySelector('.ql-editor');

		if (updateContext === true) {
			addStoryToForm(updateId);
		}
	});

	function addStoryToForm(id: number) {
		const story = stories.find((story: Story) => story.id === id);

		if (story && titleInput && imageInput && bodyInput) {
			titleInput.value = story.title;
			imageInput.value = story.image;
			bodyInput.innerHTML = story.body;

			titleValue = story.title;
			imageValue = story.image;
			bodyValue = story.body;

			validTitle = true;
			validBody = true;
			validUrl = true;

			titleInput.focus();
		} else {
			console.log('Could not find story to update');
		}
	}

	function publishArticle(): void {
		if (DOMPurify.isSupported) {
			if (titleValue && bodyValue) {
				story = {
					id: updateId,
					type: 'news',
					image: imageValue,
					title: titleValue,
					body: bodyValue as string,
					date: moment(new Date()).format('MMMM Do YYYY'),
				};

				if (updateContext === true) {
					fetchNui('updateStory', story);
					close();
				} else {
					fetchNui('publishStory', story);
				}
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

	function correctBodyValue(e): void {
		bodyValue = DOMPurify.sanitize(e.detail.html);

		// If everything gets deleted from the textarea, <p><br></p> will still be left. Reset the value to ''
		if (bodyValue === '<p><br></p>') {
			bodyValue = undefined;
		}

		validBody = bodyValue?.length ? true : false;
	}
</script>

<div class="pt-4 container">
	<h4>
		{#if updateContext == true}Update article{:else}Publish articles{/if}
	</h4>
	<br />
	<form id="form">
		<TextField
			on:change={(e) => titleCheck(e)}
			on:input={(e) => titleCheck(e)}
			on:keydown={(e) => titleCheck(e)}
			placeholder="Title"
			id="title"
			outlined
			>{Config.text.reporterActions.publishStory
				.titlePlaceholder}</TextField
		>

		<TextField
			on:change={(e) => imageUrlCheck(e)}
			on:input={(e) => imageUrlCheck(e)}
			on:keydown={(e) => imageUrlCheck(e)}
			placeholder="Image URL"
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
			on:text-change={(e) => correctBodyValue(e)}
		/>
		<Button
			disabled={!validBody || !validTitle || !validUrl}
			on:click={publishArticle}
			class="green white-text"
			>{#if updateContext}{Config.text.reporterActions.publishStory
					.update}{:else}{Config.text.reporterActions.publishStory
					.publish}{/if}</Button
		>

		{#if !updateContext}<Button disabled
				>{Config.text.reporterActions.publishStory.preview}</Button
			>
		{/if}
		{#if updateContext}<Button on:click={close}
				>{Config.text.reporterActions.publishStory
					.discardChanges}</Button
			>{/if}
	</form>
</div>

<style>
	.container {
		width: 100%;
		padding: 20px;
	}

	.editor {
		height: 200px;
	}
</style>
