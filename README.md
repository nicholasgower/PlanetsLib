[![Discord](https://img.shields.io/badge/Discord-%235865F2.svg?style=for-the-badge\&logo=discord\&logoColor=white)](https://discord.gg/VuVhYUBbWE)

# PlanetsLib

Code and graphics to help modders creating planets, moons and other systems. Standardizations are included to avoid proliferations of mods like [Surfaces Have Temperature](https://mods.factorio.com/mod/Surfaces-Have-Temperature). This library is a community project and will grow over time — feel free to contribute via pull requests on [Github](https://github.com/danielmartin0/PlanetsLib).

When breaking changes are made to features used by live mods, the major version of Planetslib will be bumped.

## API Reference

### Planet helpers

* `PlanetsLib:planet_extend(config)` - Defines a new planet. This includes a call to data:extend. Does not support `distance` or `orientation` - instead, contains `orbit` as listed below.
  * `config.orbit` - Object containing orbital parameters:
    * `parent` - Object containing `name` and `type` fields, corresponding to a parent at `data.raw\[type]\[name]`.
    * `distance` - Number: orbital distance from parent
    * `orientation` - Number: orbital angle from parent (0-1). Note that orientation is absolute, not relative to the parent's orientation.
    * `sprite` - Object: Sprite for the orbit, centered on its parent.
  * `config.sprite_only` - Boolean (optional): If true, the prototype will be removed in `data-final-fixes` and replaced by a sprite on the starmap. This is used for the central star (`data.raw\["space-location"].star`) internally.
  * Any other valid planet prototype fields
  * Notes:
    * Can accept a single config object or an array of configs
    * Returns array of created planet prototypes
* `PlanetsLib:borrow_music(source_planet, target_planet)` - Clones music tracks from an existing planet to a new one.
* `PlanetsLib:set_default_import_location(item_name, planet)` - Sets the default import location for an item on a planet.

### Planet Cargo Drops Technology

The library provides automatic cargo drop restriction functionality. To implement:

* Define a technology with name pattern: `[planet-name]-cargo-drops`
  * Use the provided helper functions:
  * `PlanetsLib.technology_icons_planet_cargo_drops`
  * `PlanetsLib.technology_effect_cargo_drops`

Players will be unable to drop cargo (excluding players and construction robots) to that planet before researching the technology.

### Support for moons

* `PlanetsLib.technology_icons_moon` - Standardized icon for moon discovery technology
* `subgroup=satellites`, a Factoriopedia row below planets.

### Surface conditions

Documentation pending.

## Credits

Contributors:

* [Tserup](https://mods.factorio.com/user/Tserup) - Art
* [thesixthroc](https://mods.factorio.com/user/thesixthroc)
* [MidnightTigger](https://mods.factorio.com/user/Midnighttigger)
* [notnotmelon](https://mods.factorio.com/user/notnotmelon)
