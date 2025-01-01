local Public = {}

function Public.technology_icons_planet_cargo_drops(planet_icon, icon_size)
	icon_size = icon_size or 256
	return {
		{
			icon = "__PlanetsLib__/graphics/icons/cargo-drop-tech-pod.png",
			icon_size = icon_size,
			scale = 0.4923,
			shift = { 0, 0 },
			draw_background = true,
		},
		{
			icon = planet_icon,
			icon_size = 256,
			scale = 0.65,
			shift = { -17, 55 },
			draw_background = true,
		},
		{
			icon = "__PlanetsLib__/graphics/icons/cargo-drop-tech-shadow.png",
			icon_size = 520,
			scale = 0.4923,
			shift = { 0, 0 },
			tint = { r = 0, g = 0, b = 0, a = 0.5 },
			draw_background = true,
		},
		{
			icon = "__PlanetsLib__/graphics/icons/cargo-drop-tech-pod.png",
			icon_size = 520,
			scale = 0.4923,
			shift = { 0, 0 },
			draw_background = true,
		},
	}
end

function Public.technology_icons_moon(moon_icon, icon_size)
	icon_size = icon_size or 256

	local icons = {
		{
			icon = moon_icon,
			icon_size = icon_size,
		},
		{
			icon = "__PlanetsLib__/graphics/icons/moon-technology-symbol.png",
			icon_size = 128,
			scale = 0.5,
			shift = { 50, 50 },
		},
	}
	return icons
end

function Public.technology_effect_cargo_drops(planet_name)
	return {
		{
			type = "nothing",
			effect_description = { "planetslib.cargo-drops-tech-description", "[space-location=" .. planet_name .. "]" },
		},
	}
end

-- TODO: Apply use_icon_overlay_constant to the unlock if the planet is a moon

return Public
