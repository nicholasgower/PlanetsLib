PlanetsLib = {}
require("prototypes.surface-property")
require("prototypes.categories")
local technology = require("lib.technology")
local planet = require("lib.planet")

--== API ==--

function PlanetsLib:planet_extend(configs)
	local planets = planet.planet_extend(configs)

	data:extend(planets)
	return planets
end

PlanetsLib.technology_icons_planet_cargo_drops = technology.technology_icons_planet_cargo_drops
PlanetsLib.technology_effect_cargo_drops = technology.technology_effect_cargo_drops
PlanetsLib.technology_icons_moon = technology.technology_icons_moon

PlanetsLib.borrow_music = planet.borrow_music
