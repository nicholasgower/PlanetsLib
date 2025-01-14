local function exact_value(property,value) -- Returns a surface condition locking the acceptable range of values to exactly one.
	return{
        property = property,
        min = value,
        max = value,
    }
end

local Public = {}

function Public.restrict_to_surface(planet) -- Returns a surface condition restricting prototype to the provided planet.
	return exact_value("planet-str",PlanetsLib.planet_str.get_planet_str_double(planet))
end

return Public