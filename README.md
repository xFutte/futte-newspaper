**THIS IS STILL IN DEVELOPMENT AND NOT STABLE YET**

# qb-newsstands

This standalone resource will add a newspaper functionality to the newsstands properties in FiveM. 

For now this resource is a MVP and we have future releases optimizing layout. Feel free to make pull requests or issues and I'll address those.

## Dependencies
qb-target

## Implementation

1. Add following to your shared.lua file:

```lua
['newspaper'] = {['name'] = 'newspaper', ['label'] = 'Newspaper', ['weight'] = 10, ['type'] = 'item', ['image'] = 'newspaper.png', ['unique'] = false , ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Los Santos Newspaper'},

```

2. Add the image from the repository to your qb-inventory image folder.
