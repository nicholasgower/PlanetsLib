local orbits = require("lib.orbits")

local Public = {}
local starmap_layers = {}

function Public.update_starmap_layers(planet)
	local orbit = planet.orbit

	local x = orbit.distance * 32 * math.sin(orbit.orientation * 2 * math.pi)
	local y = -orbit.distance * 32 * math.cos(orbit.orientation * 2 * math.pi)

	local parent = planet.orbit.parent

	assert(
		parent.type == "planet" or parent.type == "space-location",
		"Parent types other than planet or space-location are not yet supported"
	)

	local parent_data = data.raw[parent.type][parent.name]
	local parent_orbit = parent_data.orbit

	assert(parent_orbit, "Parent " .. parent.name .. " has no orbit")

	local parent_distance, parent_orientation = orbits.get_absolute_polar_position_from_orbit(parent_orbit)

	local parent_x = parent_distance * 32 * math.sin(parent_orientation * 2 * math.pi)
	local parent_y = -parent_distance * 32 * math.cos(parent_orientation * 2 * math.pi)

	if orbit.sprite then
		if orbit.sprite.layers then
			for _, layer in pairs(orbit.sprite.layers) do
				layer = util.table.deepcopy(layer)
				layer.shift = {
					(layer.shift and layer.shift[1] or 0) + parent_x,
					(layer.shift and layer.shift[2] or 0) + parent_y,
				}
				table.insert(starmap_layers, layer)
			end
		else
			local sprite = util.table.deepcopy(orbit.sprite)
			sprite.shift = {
				(sprite.shift and sprite.shift[1] or 0) + parent_x,
				(sprite.shift and sprite.shift[2] or 0) + parent_y,
			}
			table.insert(starmap_layers, sprite)
		end
	end

	planet.draw_orbit = false

	if planet.sprite_only then
		table.insert(starmap_layers, {
			filename = planet.starmap_icon,
			size = planet.starmap_icon_size,
			scale = (planet.magnitude * 32) / planet.starmap_icon_size,
			shift = { parent_x + x, parent_y + y },
		})
	end
end

for _, planet in pairs(data.raw["planet"]) do
	Public.update_starmap_layers(planet)
end
for _, space_location in pairs(data.raw["space-location"]) do
	Public.update_starmap_layers(space_location)
end

data.raw["utility-sprites"]["default"].starmap_star = { layers = starmap_layers }

return Public
