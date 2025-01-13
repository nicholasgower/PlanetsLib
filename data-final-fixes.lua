local lib=require("lib.lib")
local ps = require("lib.planet-str")
require("prototypes.override-final.starmap")

local planets=data.raw.planet

--Set planet string for every planet based on planet name.
for _, planet in pairs(planets) do
	if planet["surface_properties"]["planet-str"] == nil then --Other mods can override planet strings, this is a last-resort planet string generator.
		local truncated_name=string.sub(planet.name, 1, 8) --Planet strings can only be 8 characters or less.
		ps.set_planet_str(planet,truncated_name)
	end
    
end

for _, p in pairs(planets) do
	if p.sprite_only then
		planets[p.name] = nil
	end
end
for _, p in pairs(data.raw["space-location"]) do
	if p.sprite_only then
		data.raw["space-location"][p.name] = nil
	end
end

local gas_list = { "oxygen", "nitrogen", "carbon-dioxide", "argon" }
local enforce_percentage = settings.startup["PlanetsLib-enforce-gas-percentage"].value --Whether code should assert that combined gas contents add up to less than 100%.

for _, p in pairs(planets) do
	if p.surface_properties and enforce_percentage then
		local gas_content = 0
		for _, gas in pairs(gas_list) do
			if p.surface_properties[gas] then
				gas_content = gas_content + p.surface_properties[gas]
			end
		end
		assert(
			gas_content <= 100,
			"Combined gas contents of planet "
				.. p.name
				.. ' exceed 100%. To override this assertion, add \'data.raw["bool-setting"]["PlanetsLib-enforce-gas-percentage"].forced_value = false\' to settings-updates.lua.'
		)
	end
end
