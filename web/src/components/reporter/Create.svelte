<script lang="ts">
	import { TextField, Textarea, Button } from 'svelte-materialify';

	let story: Story;

    interface Story {
		id?: number;
		type: string;
		image?: string | undefined;
        title: string;
		body: string;
		date: string;
	}

	async function publishArticle(): Promise<void> {
        const title: HTMLInputElement | null = document.querySelector('#title');
		const image: HTMLInputElement | null = document.querySelector('#image');
		const body: HTMLTextAreaElement | null =
			document.querySelector('#body');

        if (!title?.value || !body?.value) {
            console.log('no value');
        } else {
            const santized = await sanityCheck(title.value, body.value, image?.value);
        }

		if (title && body) {
			story = {
				type: 'news',
				image: image?.value ? image.value : undefined,
				title: title.value,
				body: body.value,
				date: new Date().toUTCString(),
			};
		} else {
            
        }
    }

    async function sanityCheck(title: string, body: string, image?: string | undefined): Promise<void> {
        try {
            
        } catch {

        }
        return Promise.resolve();
    }
	

    function validationParses(title: string, image?: string | undefined, body?: string): boolean {
        if (title && body) {
            return true;
        } else {
            return false;
        }
    }


</script>

<div class="pt-4 container">
	<TextField id="title" outlined>Title</TextField>
	<TextField id="image" outlined>Image URL</TextField>
	<Textarea id="body" outlined>Body</Textarea>
	<Button on:click={publishArticle}>Publish</Button>
</div>

<style>
	.container {
		width: 100%;
	}
</style>
