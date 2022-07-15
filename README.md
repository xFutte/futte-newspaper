# qb-news

This standalone resource will add a newspaper functionality to your beautiful server.

### Preview
| Opening newspaper | Reporter actions | Buying newspaper |
|--------------------| --------------- | -----------------|
| ![Opening newspaper](https://i.imgur.com/zEXI3oh.png) | ![Opening newspaper](https://i.imgur.com/68pjuKY.png) | ![Buying newspaper](https://i.imgur.com/ounIQJY.png) |

For now, this ressource is in MVP. Following features will be implemented in the near future:

- [ ] Prison sentences
- [ ] City news (release notes for city)
- [ ] Action feedback
- [ ] Live form validation
- [ ] Image URL validation
- [ ] Update stories
- [ ] Preview story before publishing
- [x] Input sanitization

Feel free to report bugs or improvements and they'll be looked at.

### Dependencies
- qb-target
- qb-inventory
- oxmysql

## Implementation

1. Add following to your shared.lua file:

```lua
['newspaper'] = {['name'] = 'newspaper', ['label'] = 'Newspaper', ['weight'] = 10, ['type'] = 'item', ['image'] = 'newspaper.png', ['unique'] = false , ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Los Santos Newspaper'},

```
### Configuration

1. There are quite a lot of configurations possible out-of-the-box with qb-news. This consists of two files: `config.js` and `config.lua`.

**Config.js** (so far)
```javscript
export const Config = {
	newspaperTitle: 'QB-News',
	articles: {
		showImage: true,
		showTitle: true,
		showDate: true,
		showPublisher: true,
	},
	display: {
		showPrisonSentences: true,
		showCityNews: true,
	},
	publishArticleControls: [['bold', 'italic', 'underline', 'strike']],
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
			textareaPlaceholder: 'Type something...',
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
Config = {
    type = {
        ['newspaper'] = {
            name = 'newspaper',
            price = 10000
        },
    },
    amountOfNews = 10
}
```

2. Add the newspaper.png image in the root of the resource into your qb-inventory folder, where all the other images are located.
