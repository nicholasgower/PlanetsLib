for _, type in pairs({ "space-location", "planet" }) do
	for _, location in pairs(data.raw[type]) do
		if
			not (
				location.orbit
				and location.orbit.parent
				and location.orbit.distance
				and (location.orbit.orientation or location.orbit.distance == 0)
			)
		then
			location.orbit = {
				parent = {
					type = "space-location",
					name = "star",
				},
				distance = location.distance,
				orientation = location.orientation,
			}
		end
	end
end

require("prototypes.override-final.starmap")

for _, type in pairs({ "space-location", "planet" }) do
	for _, location in pairs(data.raw[type]) do
		if location.sprite_only then
			data.raw[type][location.name] = nil
		end
	end
end

local gas_list = { "oxygen", "nitrogen", "carbon-dioxide", "argon" }
local enforce_percentage = settings.startup["PlanetsLib-enforce-gas-percentage"].value --Whether code should assert that combined gas contents add up to less than 100%.

for _, planet in pairs(data.raw.planet) do
	if planet.surface_properties and enforce_percentage then
		local gas_content = 0
		for _, gas in pairs(gas_list) do
			if planet.surface_properties[gas] then
				gas_content = gas_content + planet.surface_properties[gas]
			end
		end
		assert(
			gas_content <= 100,
			"Combined gas contents of planet "
				.. planet.name
				.. ' exceed 100%. To override this assertion, add \'data.raw["bool-setting"]["PlanetsLib-enforce-gas-percentage"].forced_value = false\' to data-updates.lua.'
		)
	end
end
