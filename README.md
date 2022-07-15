# qb-news

This standalone resource will add a newspaper functionality to the newsstands properties in FiveM. 

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

## Dependencies
- qb-target
- qb-inventory
- oxmysql

### Implementation

1. Add following to your shared.lua file:

```lua
['newspaper'] = {['name'] = 'newspaper', ['label'] = 'Newspaper', ['weight'] = 10, ['type'] = 'item', ['image'] = 'newspaper.png', ['unique'] = false , ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Los Santos Newspaper'},

```

2. Add the image from the repository to your qb-inventory image folder.

#### Costumization

**Recommended**: You should update the default story in `App.svelte` to what you want. 

There are a couple of things that you can costumize out of the box. In the `config.lua`, you can change the price of the newspaper. 
