local technology = require("lib.technology")
local planet = require("lib.planet")
local planet_str = require("lib.planet-str")
local surface_conditions = require("lib.surface_conditions")

function PlanetsLib:extend(configOrConfigs)
	local configs = util.table.deepcopy(configOrConfigs)

	if not configs[1] then
		configs = { configs }
	end

	for _, config in ipairs(configs) do
		planet.extend(config)
	end
end

function PlanetsLib:update(configOrConfigs)
	local configs = util.table.deepcopy(configOrConfigs)

	if not configs[1] then
		configs = { configs }
	end

	for _, config in ipairs(configs) do
		planet.update(config)
	end
end

PlanetsLib.technology_icons_planet_cargo_drops = technology.technology_icons_planet_cargo_drops
PlanetsLib.technology_effect_cargo_drops = technology.technology_effect_cargo_drops
PlanetsLib.technology_icons_moon = technology.technology_icons_moon

PlanetsLib.borrow_music = planet.borrow_music

PlanetsLib.planet_str=planet_str

PlanetsLib.surface_conditions=surface_conditions



--- This function sets `default_import_location` based on an item name and planet.
--- `default_import_location` is used by the space platform GUI to
--- define the default planet where an item will be imported from.
PlanetsLib.set_default_import_location = planet.set_default_import_location
