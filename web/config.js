export const Config = {
	newspaperTitle: 'QB-News',
	articles: {
		showImage: true,
		showTitle: true,
		showDate: true,
		showPublisher: true,
		titleMaxLength: 60,
	},
	display: {
		showPrisonSentences: true,
		showCityNews: true,
	},
	publishArticleControls: [
		['bold', 'italic', 'underline', 'strike'],
		['blockquote', 'image'],
		[{ list: 'ordered' }, { list: 'bullet' }],
	],
	reporter: [
		{
			grade: 0,
			canPublish: true,
			canEdit: true,
			canDelete: false,
		},
		{
			grade: 1,
			canPublish: true,
			canEdit: true,
			canDelete: true,
		},
		{
			grade: 2,
			canPublish: true,
			canEdit: true,
			canDelete: true,
		},
		{
			grade: 3,
			canPublish: true,
			canEdit: true,
			canDelete: true,
		},
	],
	text: {
		tabs: {
			newspaper: 'Newspaper',
			prisonSentences: 'Prison sentences (coming soon)',
			cityUpdates: 'City updates (coming soon)',
			reporterActions: 'Reporter actions',
		},
		prisonSentences: {},
		cityUpdates: {},
		reporterActions: {
			title: 'Reporter actions',
			noPermissions: 'You have no reporter permissions.',
			publishNewStory: 'Publish a new story',
			updateStories: 'Update stories (coming soon)',
			deleteStories: 'Delete stories',
			publishStory: {
				textareaPlaceholder: 'Type something...',
				imagePlaceholder: 'Image URL',
				titlePlaceholder: 'Title',
				publish: 'Publish',
				preview: 'Preview (Coming soon)',
			},
		},
		articles: {
			writtenBy: 'Written by',
			on: 'on',
			latestStories: 'Latest stories',
		},
	},
};
