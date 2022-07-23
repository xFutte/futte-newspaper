# Newspaper script for QBCore

This standalone resource will add a newspaper functionality to your beautiful QBCore FiveM server and is still in active development.

This resource supports:

- Buying a newspaper at a newspaper stand
- Viewing news
- Writing, updating & deleting news as a news reporter
- Previewing a story before publishing it
- Display of prison sentences when someone gets sent to jail

The resource supports a lot of customization. See everything in the [configuration section](https://github.com/xFutte/qb-newspaper/blob/master/README.md#configuration).

## Preview
![Opening newspaper](https://i.imgur.com/vkSWDU3.png)
[More screenshots](https://imgur.com/a/Sr1gQ4u)

## Dependencies
- qb-target
- qb-inventory
- oxmysql

## Implementation
1. Run the attached import.sql file in the database
2. Add `exports['newsstands']:CreateJailStory(name, time)` wherever you jail a player, parsing the name of the prisoner and the time sentenced as parameters.
3. Add the newspaper.png image into your qb-inventory folder, where all the other images are located (located in the root of the repo).
4. Add following to your shared.lua file:
```lua
['newspaper'] = {['name'] = 'newspaper', ['label'] = 'Newspaper', ['weight'] = 10, ['type'] = 'item', ['image'] = 'newspaper.png', ['unique'] = false , ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Los Santos Newspaper'},
```

## Development

1. Navigate to ./web and run `npm install` to install all dependencies. If you don't already have node.js you can [download it here](https://nodejs.org/en/download/).'
2. Run `npm run dev` in ./web to compile the GUI.

:bulb: When you are done working with the resource run `npm run build` to minify and uglify the resource to decrease the resource size.

## Configuration

There are quite a lot of configurations possible out-of-the-box. These consists of two files: `config.js` and `config.lua`.

**Config.js**
```js
export const Config = {
	newspaperTitle: 'Los Santos Newspaper',
	tabs: {
		showPrisonSentences: true,
		showCityNews: false,
	},
	articles: {
		showImage: true,
		showTitle: true,
		showDate: true,
		showPublisher: true,
		titleMaxLength: 60,
	},

	publishArticleControls: [
		['bold', 'italic', 'underline', 'strike'],
		['blockquote', 'image'],
		[{ list: 'ordered' }, { list: 'bullet' }],
	],
	// Remember to align this with QBShared.Jobs
	reporter: [
		{
			grade: 0,
			canPublish: true,
			canEdit: true,
			canDelete: true,
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
			canDelete: false,
		},
		{
			grade: 3,
			canPublish: true,
			canEdit: true,
			canDelete: true,
		},
	],
	prisonSentences: {
		imageUrl:
			'https://cdn.realsport101.com/images/ncavvykf/gfinityesports/94d9c2c9e240b6b4e792a705ead0a0d188c1af47-808x455.png?w=686&h=386&auto=format',
		imageCaption: 'Bolingbroke Penitentiary',
	},
	text: {
		tabs: {
			newspaper: 'Newspaper',
			prisonSentences: 'Prison sentences',
			reporterActions: 'Reporter actions',
		},
		prisonSentences: {
			title: 'Prison sentences',
			noSentencesAvailable: 'No sentences available',
		},
		reporterActions: {
			title: 'Reporter actions',
			noPermissions: 'You have no reporter permissions.',
			publishNewStory: 'Publish a new story',
			updateStories: 'Update stories',
			deleteStories: 'Delete stories',
			publishStory: {
				textareaPlaceholder: 'Article content..',
				imagePlaceholder: 'Image URL (Optional)',
				titlePlaceholder: 'Title (Required)',
				publish: 'Publish',
				update: 'Update',
				discardChanges: 'Discard changes',
				preview: 'Preview',
				wrongImageFormat:
					'Wrong image format. Either .jpg, .jpeg, .png. .webp, .avif, .gif, or .svg expected',
				required: 'Required',
				cancel: 'Cancel',
			},
		},
		articles: {
			writtenBy: 'Written by',
			on: 'on',
			latestStories: 'Latest stories',
		},
	},
};
```

**Config.lua**
```lua
Config.BuyNewspaperText = 'Buy newspaper' -- Text shown with qb-target
Config.BuyNewspaperIcon = 'fas fa-newspaper' -- Icon shown with qb-target
Config.Price = 100 -- Price of buying the newspaper
Config.AmountOfNews = 10 -- Amount of news to be fetched from the database
Config.AmountOfSentences = 10 -- Amount of prison sentences to be fetched from the database
```

