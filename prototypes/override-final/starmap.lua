local orbits = require("lib.orbits")

local Public = {}
local starmap_layers = {}

-- Orbits help us construct the system. In data-final-fixes, it's now better to rely on the game variables (distance and orientation) for compatibility with other mods.

function Public.update_starmap_layers(planet)
	if planet.sprite_only then
		local x = planet.distance * 32 * math.sin(planet.orientation * 2 * math.pi)
		local y = -planet.distance * 32 * math.cos(planet.orientation * 2 * math.pi)

		table.insert(starmap_layers, {
			filename = planet.starmap_icon,
			size = planet.starmap_icon_size,
			scale = (planet.magnitude * 32) / planet.starmap_icon_size,
			shift = { x, y },
		})
	end

	if planet.orbit and planet.orbit.sprite then
		local orbit = planet.orbit
		local parent = orbit.parent

		assert(
			parent.type == "planet" or parent.type == "space-location",
			"Parent types other than planet or space-location are not yet supported"
		)

		local distance_from_orbit = orbits.get_absolute_polar_position_from_orbit(orbit)

		if distance_from_orbit ~= planet.distance then
			-- Another mod has intercepted, so let's not risk drawing any orbit sprite.

			return { should_disable_default_orbit_sprite = true }
		end

		local parent_data = data.raw[parent.type][parent.name]

		local parent_x = parent_data.distance * 32 * math.sin(parent_data.orientation * 2 * math.pi)
		local parent_y = -parent_data.distance * 32 * math.cos(parent_data.orientation * 2 * math.pi)

		if orbit.sprite.layers then
			for _, layer in pairs(orbit.sprite.layers) do
				Public.update_starmap_from_sprite(layer, parent_x, parent_y)
			end
		else
			Public.update_starmap_from_sprite(orbit.sprite, parent_x, parent_y)
		end

		return { should_disable_default_orbit_sprite = true }
	end

	return { should_disable_default_orbit_sprite = false }
end

function Public.update_starmap_from_sprite(sprite, dx, dy)
	local sprite_copy = util.table.deepcopy(sprite)
	sprite_copy.shift = {
		(sprite_copy.shift and sprite_copy.shift[1] or 0) + dx,
		(sprite_copy.shift and sprite_copy.shift[2] or 0) + dy,
	}
	table.insert(starmap_layers, sprite_copy)
end

for _, planet in pairs(data.raw["planet"]) do
	local result = Public.update_starmap_layers(planet)
	if result.should_disable_default_orbit_sprite then
		planet.draw_orbit = false
	end
end
for _, space_location in pairs(data.raw["space-location"]) do
	local result = Public.update_starmap_layers(space_location)
	if result.should_disable_default_orbit_sprite then
		space_location.draw_orbit = false
	end
end

data.raw["utility-sprites"]["default"].starmap_star = { layers = starmap_layers }

return Public
