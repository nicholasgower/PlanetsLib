local orbits = require("lib.orbits")

local Public = {}
local starmap_layers = {}

-- Orbits help us construct the system. In data-final-fixes, it's now better to rely on the game variables (distance and orientation) for compatibility with other mods.

function Public.update_starmap_layers(planet)
	if planet.sprite_only and (planet.starmap_icon or planet.starmap_icons) then
		local magnitude = planet.magnitude or 1

		local x = planet.distance * 32 * math.sin(planet.orientation * 2 * math.pi)
		local y = -planet.distance * 32 * math.cos(planet.orientation * 2 * math.pi)

		if planet.starmap_icons then
			for _, sprite in pairs(planet.starmap_icons) do
				local scaled_sprite = util.table.deepcopy(sprite)
				scaled_sprite.scale = scaled_sprite.scale * (magnitude * 32)

				Public.update_starmap_from_sprite(sprite, { x = x, y = y })
			end
		elseif planet.starmap_icon then
			local icon_size = planet.starmap_icon_size or 64

			Public.update_starmap_from_sprite({
				filename = planet.starmap_icon,
				size = icon_size,
				scale = (magnitude * 32) / icon_size,
			}, { x = x, y = y })
		end
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
				Public.update_starmap_from_sprite(layer, { x = parent_x, y = parent_y })
			end
		else
			Public.update_starmap_from_sprite(orbit.sprite, { x = parent_x, y = parent_y })
		end

		return { should_disable_default_orbit_sprite = true }
	end

	return { should_disable_default_orbit_sprite = false }
end

function Public.update_starmap_from_sprite(sprite, extra_displacement)
	local sprite_copy = util.table.deepcopy(sprite)

	local shift_x = 0
	local shift_y = 0

	if sprite_copy.shift then
		if sprite_copy.shift.x then
			shift_x = shift_x + sprite_copy.shift.x
			shift_y = shift_y + sprite_copy.shift.y
		else
			shift_x = shift_x + sprite_copy.shift[1]
			shift_y = shift_y + sprite_copy.shift[2]
		end
	end

	if extra_displacement then
		if extra_displacement.x and extra_displacement.y then
			shift_x = shift_x + extra_displacement.x
			shift_y = shift_y + extra_displacement.y
		else
			shift_x = shift_x + extra_displacement[1]
			shift_y = shift_y + extra_displacement[2]
		end
	end

	sprite_copy.shift = {
		shift_x,
		shift_y,
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
