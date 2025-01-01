[![Discord](https://img.shields.io/badge/Discord-7289DA?style=for-the-badge)](https://discord.gg/VuVhYUBbWE)

# PlanetsLib

Code and graphics to help modders creating planets and moons, plus thoughtful standardizations (to avoid proliferations of mods like [Surfaces Have Temperature](https://mods.factorio.com/mod/Surfaces-Have-Temperature)).

This library is fully open-source and will grow over time — feel free to contribute via pull requests on [Github](https://github.com/danielmartin0/PlanetsLib).

Contributors:

-   [Tserup](https://mods.factorio.com/user/Tserup) - Art
-   [thesixthroc](https://mods.factorio.com/user/thesixthroc)
-   [notnotmelon](https://mods.factorio.com/user/notnotmelon)

## API Reference

### Planet helpers

- `PlanetsLib:planet_extend(config)` - Defines a new planet, and calls data:extend with it. Does not support `distance`, `orientation` and `label_orientation`. Instead, contains `orbit` and `planet_type` as listed below.
    - `config.planet_type` - String: "planet", "moon", or "star"
    - `config.orbit` - Object containing orbital parameters:
        - `parent` - String: either "star" for planets in the default solar system, or the name of a parent planet/moon
        - `distance` - Number: orbital distance from parent
        - `orientation` - Number: orbital position (0-1)
        - `label_orientation` - Number: rotation of planet label
    - Any other valid planet prototype fields
    - Note:
        - Can accept a single config object or an array of configs
        - Moons are automatically assigned to "satellites" subgroup in Factoriopedia
        - Returns array of created planet prototypes
- `PlanetsLib:borrow_music(source_planet, target_planet)` - Clones music tracks from an existing planet to a new one.
- `PlanetsLib:set_default_import_location(item_name, planet)` - Sets the default import location for an item on a planet.

### Cargo Drop System

The library provides automatic cargo drop restriction functionality. To implement:

1. Define a technology with name pattern: `[planet-name]-cargo-drops`
2. Use the provided helper functions:
    - `PlanetsLib.technology_icons_planet_cargo_drops`
    - `PlanetsLib.technology_effect_cargo_drops`

Players will be unable to drop cargo (excluding players and construction robots) to that planet before researching the technology.

### Moon Support

Special functionality for implementing moons:

-   `PlanetsLib.technology_icons_moon` - Creates standardized icons for moon discovery
-   A new Factoriopedia row below planets with subgroup `satellites`.

### Surface Temperature

The library implements a temperature surface condition for planetary surfaces. Default temperatures (in Kelvin):

| Surface         | Temperature |
| --------------- | ----------- |
| Nauvis          | 288K        |
| Vulcanus        | 332K        |
| Fulgora         | 314K        |
| Gleba           | 298K        |
| Aquilo          | 258K        |
| Space Platforms | 268K        |
| Default         | 288K        |

These values are spaced to allow modded planets to fit between them.
