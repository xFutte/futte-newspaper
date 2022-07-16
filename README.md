# qb-newspaper

This standalone resource will add a newspaper functionality to your beautiful QBCore FiveM server.

### Preview
| Opening newspaper | Reporter actions | Buying newspaper |
|--------------------| --------------- | -----------------|
| ![Opening newspaper](https://i.imgur.com/zEXI3oh.png) | ![Opening newspaper](https://i.imgur.com/68pjuKY.png) | ![Buying newspaper](https://i.imgur.com/ounIQJY.png) |

For now, this ressource is in MVP. Following features will be implemented in the near future:

- [ ] Prison sentences
- [ ] City news (release notes for city)
- [ ] Action feedback
- [x] Live form validation
- [x] Image URL validation
- [ ] Update stories
- [ ] Preview story before publishing
- [x] Input sanitization

Feel free to report bugs or improvements and they'll be looked at.

### Dependencies
- qb-target
- qb-inventory
- oxmysql

## Implementation

1. Navigate to ./web and run `npm install` to install all dependencies. If you don't already have node, you can download it on https://nodejs.org/en/download/.'
2. Run `npm run dev` if you want to develop on the resource or `run npm build` if you simply want to bundle the resource and use it. It is always a good idea to run `npm run build` when you're done custommizing it to compress the bundle.
2. Add following to your shared.lua file:

```lua
['newspaper'] = {['name'] = 'newspaper', ['label'] = 'Newspaper', ['weight'] = 10, ['type'] = 'item', ['image'] = 'newspaper.png', ['unique'] = false , ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Los Santos Newspaper'},
```
3. Add the newspaper.png image in the root of the resource into your qb-inventory folder, where all the other images are located.
## Configuration

1. There are quite a lot of configurations possible out-of-the-box with qb-news. This consists of two files: `config.js` and `config.lua`.

**Config.js** (so far)
```javscript
export const Config = {
	newspaperTitle: 'QB-News',
	tabs: {
		showPrisonSentences: true,
		showCityNews: true,
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
				imagePlaceholder: 'Image URL (Optional)',
				titlePlaceholder: 'Title (Required)',
				publish: 'Publish',
				preview: 'Preview (Coming soon)',
				wrongImageFormat:
					'Wrong image format. Either .jpg, .jpeg, .png. .webp, .avif, .gif, or .svg expected',
				required: 'Required',
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
```

