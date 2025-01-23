local Public = {}

-- Restricts the surface conditions of an existing recipe or entity. For each condition passed, if it is more restrictive in any way than the existing conditions, those restrictions will be applied.
function Public.restrict_surface_conditions(recipe_or_entity, conditions)
	conditions = util.table.deepcopy(conditions)
	if conditions.property then
		conditions = { conditions }
	end

	local surface_conditions = recipe_or_entity.surface_conditions
			and util.table.deepcopy(recipe_or_entity.surface_conditions)
		or {}

	for _, condition in pairs(conditions) do
		for i = 1, #surface_conditions do
			local existing = surface_conditions[i]
			if existing.property == condition.property then
				if condition.min ~= nil then
					if existing.min ~= nil then
						existing.min = math.max(existing.min, condition.min)
					else
						existing.min = condition.min
					end
				end

				if condition.max ~= nil then
					if existing.max ~= nil then
						existing.max = math.min(existing.max, condition.max)
					else
						existing.max = condition.max
					end
				end
				goto continue
			end
		end
		-- No existing condition found, add new one
		table.insert(surface_conditions, {
			property = condition.property,
			min = condition.min,
			max = condition.max,
		})
		::continue::
	end

	recipe_or_entity.surface_conditions = surface_conditions
end

-- Relaxes the surface conditions of an existing recipe or entity. For each 'min' value on conditions passed, any existing min conditions of the same property will be relaxed to that min value. Similarly for 'max'. Note that failing to pass a max does not mean that any existing maxima for that property will be removed.
function Public.relax_surface_conditions(recipe_or_entity, conditions)
	conditions = util.table.deepcopy(conditions)

	if conditions.property then
		conditions = { conditions }
	end

	local surface_conditions = recipe_or_entity.surface_conditions
			and util.table.deepcopy(recipe_or_entity.surface_conditions)
		or {}

	for _, condition in pairs(conditions) do
		for i = 1, #surface_conditions do
			local existing_condition = surface_conditions[i]
			if existing_condition.property == condition.property then
				if condition.min ~= nil and existing_condition.min ~= nil then
					existing_condition.min = math.min(existing_condition.min, condition.min)
				end

				if condition.max ~= nil and existing_condition.max ~= nil then
					existing_condition.max = math.max(existing_condition.max, condition.max)
				end
			end
		end
	end

	recipe_or_entity.surface_conditions = surface_conditions
end

function Public.restrict_to_planet(recipe_or_entity, planet)
	local surface_conditions = recipe_or_entity.surface_conditions
			and util.table.deepcopy(recipe_or_entity.surface_conditions)
		or {}

	local condition_value = PlanetsLib.planet_str.get_planet_str_double(planet)

	table.insert(surface_conditions, {
		property = "planet-str",
		min = condition_value,
		max = condition_value,
	})

	recipe_or_entity.surface_conditions = surface_conditions
end

--== Older APIs: ==--

local function exact_value(property, value) -- Returns a surface condition locking the acceptable range of values to exactly one.
	return {
		property = property,
		min = value,
		max = value,
	}
end

function Public.restrict_to_surface(planet) -- Returns a surface condition restricting prototype to the provided planet.
	return exact_value("planet-str", PlanetsLib.planet_str.get_planet_str_double(planet))
end

return Public
