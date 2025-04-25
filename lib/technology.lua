local Public = {}

function Public.cargo_drops_technology_base(planet, planet_technology_icon, planet_technology_icon_size)
	if not planet then
		error("PlanetsLib:cargo_drops_technology() - planet is required")
	end
	if not planet_technology_icon then
		error("PlanetsLib:cargo_drops_technology() - planet_technology_icon is required")
	end
	if not planet_technology_icon_size then
		error("PlanetsLib:cargo_drops_technology() - planet_technology_icon_size is required")
	end

	return {
		type = "technology",
		name = "planetslib-" .. planet .. "-cargo-drops",
		localised_name = { "", { "technology-name.cargo-drops", { "space-location-name." .. planet } } },
		localised_description = { "technology-description.cargo-drops", { "space-location-name." .. planet } },
		-- TODO: Switch to the iconized planet and show a constant symbol in front?
		effects = Public.technology_effect_cargo_drops(planet, {
			{
				icon = planet_technology_icon,
				icon_size = planet_technology_icon_size,
				scale = 0.65 * (256 / planet_technology_icon_size),
				draw_background = true,
			},
		}),
		icons = Public.technology_icons_planet_cargo_drops(planet_technology_icon, planet_technology_icon_size),
	}
end

function Public.technology_icons_planet_cargo_drops(planet_icon, icon_size, mini)
	icon_size = icon_size or 256
	return {
		{
			icon = "__PlanetsLib__/graphics/icons/cargo-drop-tech-pod.png",
			icon_size = 256,
			scale = 1,
			shift = { 0, 0 },
			draw_background = true,
		},
		{
			icon = planet_icon,
			icon_size = icon_size,
			scale = 0.65 * (256 / icon_size),
			shift = mini and { 0, 0 } or { -17, 55 },
			draw_background = true,
		},
		{
			icon = "__PlanetsLib__/graphics/icons/cargo-drop-tech-shadow.png",
			icon_size = 256,
			scale = 1,
			shift = { 0, 0 },
			tint = { r = 0, g = 0, b = 0, a = 0.5 },
			draw_background = true,
		},
		{
			icon = "__PlanetsLib__/graphics/icons/cargo-drop-tech-pod.png",
			icon_size = 256,
			scale = 1,
			shift = { 0, 0 },
			draw_background = true,
		},
	}
end

function Public.technology_effect_cargo_drops(planet_name, icons)
	return {
		{
			type = "nothing",
			icons = icons,
			effect_description = { "planetslib.cargo-drops-tech-description", "[space-location=" .. planet_name .. "]" },
		},
	}
end

function Public.excise_tech_from_tech_tree(tech_name)
	log("PlanetsLib: Excising technology " .. tech_name .. " from tech tree")

	local tech = data.raw.technology[tech_name]
	if not tech then
		return
	end

	for _, other_tech in pairs(data.raw.technology) do
		if other_tech.prerequisites then
			local affected = false
			for i = #other_tech.prerequisites, 1, -1 do
				if other_tech.prerequisites[i] == tech_name then
					affected = true
					table.remove(other_tech.prerequisites, i)
				end
			end

			if affected then
				for _, prereq in pairs(tech.prerequisites or {}) do
					table.insert(other_tech.prerequisites, prereq)
				end
			end
		end
	end

	data.raw.technology[tech_name].hidden = true
end

function Public.excise_recipe_from_tech_tree(name)
	log("PlanetsLib: Excising recipe " .. name .. " from tech tree")

	for _, tech in pairs(data.raw.technology) do
		if tech.effects and #tech.effects > 0 then
			local new_effects = {}
			for _, effect in ipairs(tech.effects) do
				if not (effect.type == "unlock-recipe" and effect.recipe == name) then
					table.insert(new_effects, effect)
				end
			end
			tech.effects = new_effects

			if #tech.effects == 0 then
				Public.excise_tech_from_tech_tree(tech.name)
			end
		end
	end
end

function Public.excise_effect_from_tech_tree(effect)
	log("PlanetsLib: Excising effect " .. serpent.block(effect) .. " from tech tree")

	for _, tech in pairs(data.raw.technology) do
		if tech.effects and #tech.effects > 0 then
			local new_effects = {}
			for _, current_effect in ipairs(tech.effects) do
				local should_keep = true

				local effect_count, current_count = 0, 0
				for _ in pairs(effect) do
					effect_count = effect_count + 1
				end
				for _ in pairs(current_effect) do
					current_count = current_count + 1
				end

				if effect_count == current_count then
					should_keep = false
					for k, v in pairs(effect) do
						if not (current_effect[k] and current_effect[k] == v) then
							should_keep = true
							break
						end
					end
				else
					should_keep = true
				end

				if should_keep then
					table.insert(new_effects, current_effect)
				end
			end
			tech.effects = new_effects

			if #tech.effects == 0 then
				Public.excise_tech_from_tech_tree(tech.name)
			end
		end
	end
end

function Public.technology_icon_moon(moon_icon, icon_size)
	icon_size = icon_size or 256
	local icons = util.technology_icon_constant_planet(moon_icon)
	icons[1].icon_size = icon_size
	icons[2].icon = "__PlanetsLib__/graphics/icons/moon-technology-symbol.png"
	-- End result is an icons object ressembling the following, as of 2.0.37. Future API changes might change this code,
	-- which is why this function is written to reference the base function instead of copying it by hand.
	-- local icons = {
	-- 	{
	-- 		icon = moon_icon,
	-- 		icon_size = icon_size,
	-- 	},
	-- 	{
	-- 		icon = "__PlanetsLib__/graphics/icons/moon-technology-symbol.png",
	-- 		icon_size = 128,
	-- 		scale = 0.5,
	-- 		shift = { 50, 50 },
	-- 		floating = true
	-- 	},
	-- }
	return icons
end

-- The same as util.technology_icon_constant_planet from the vanilla library, but allows any icon size.
function Public.technology_icon_planet(planet_icon, icon_size)
	icon_size = icon_size or 256
	local icons = util.technology_icon_constant_planet(planet_icon)
	icons[1].icon_size = icon_size
	-- End result is an icons object ressembling the following, as of 2.0.37. Future API changes might change this code,
	-- which is why this function is written to reference the base function instead of copying it by hand.
	-- local icons = {
	-- 	{
	-- 		icon = planet_icon,
	-- 		icon_size = icon_size,
	-- 	},
	-- 	{
	-- 		icon = "__core__/graphics/icons/technology/constants/constant-planet.png",
	-- 		icon_size = 128,
	-- 		scale = 0.5,
	-- 		shift = { 50, 50 },
	-- 		floating = true
	-- 	},
	-- }
	return icons
end

-- TODO: Apply use_icon_overlay_constant to the unlock if the planet is a moon

-- This function makes the technology use all sciences in the base lab.
-- Compatibility for technologies after prometheum science.
function Public.set_science_packs_from_lab(technology, lab)
	if not (technology and technology.unit and lab and lab.inputs) then
		return
	end

	technology.unit.ingredients = technology.unit.ingredients or {}

	local inputs = lab.inputs
	local existing_packs = {}

	for _, pack in pairs(technology.unit.ingredients) do
		existing_packs[pack[1]] = true
	end

	for _, value in pairs(inputs) do
		if not existing_packs[value] then
			local to_insert = true
			for _, effect in pairs(technology.effects) do --Check if this technology unlocks a science pack. If yes, don't make this technology require that pack.
				if effect.type == "unlock-recipe" and effect.recipe == value then
					to_insert = false
					break
				end
			end

			if to_insert then
				table.insert(technology.unit.ingredients, { value, 1 })
				existing_packs[value] = true
			end
		end
	end
end

return Public
