# qb-newsstands

This standalone resource will add a newspaper functionality to the newsstands properties in FiveM. 

### Preview
| Opening newspaper | Reporter actions | Buying newspaper |
|--------------------| --------------- | -----------------|
| ![Opening newspaper](https://i.imgur.com/zEXI3oh.png) | ![Opening newspaper](https://i.imgur.com/68pjuKY.png) | ![Buying newspaper](https://i.imgur.com/ounIQJY.png) |

For now this resource is a MVP and we have future releases optimizing layout. Feel free to make pull requests or issues and I'll address those.

*Upcoming features*

- [ ] Prison sentences
- [ ] City news (release notes for city)
- [ ] Feedback messages for actions
- [ ] Image URL validation
- [ ] Update stories

## Dependencies
- qb-target
- oxmysql

## Implementation

1. Add following to your shared.lua file:

```lua
['newspaper'] = {['name'] = 'newspaper', ['label'] = 'Newspaper', ['weight'] = 10, ['type'] = 'item', ['image'] = 'newspaper.png', ['unique'] = false , ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Los Santos Newspaper'},

```

2. Add the image from the repository to your qb-inventory image folder.
