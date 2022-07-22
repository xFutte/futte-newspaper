export interface Story {
	// For stories
	id?: number;
	type: string;
	image: string;
	title: string;
	body: string;
	date: string;
	publisher?: string;
	// For prison sentences
	time?: string;
	name?: string;
}
