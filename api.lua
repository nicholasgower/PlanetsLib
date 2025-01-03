local technology = require("lib.technology")
local planet = require("lib.planet")

function PlanetsLib:extend(configs)
	local planets = planet.planet_extend(configs)

	data:extend(planets)
	return planets
end
-- PlanetsLib.planet_extend = planet.planet_extend

PlanetsLib.technology_icons_planet_cargo_drops = technology.technology_icons_planet_cargo_drops
PlanetsLib.technology_effect_cargo_drops = technology.technology_effect_cargo_drops
PlanetsLib.technology_icons_moon = technology.technology_icons_moon

PlanetsLib.borrow_music = planet.borrow_music

--- This function sets `default_import_location` based on an item name and planet.
--- `default_import_location` is used by the space platform GUI to
--- define the default planet where an item will be imported from.
PlanetsLib.set_default_import_location = planet.set_default_import_location
