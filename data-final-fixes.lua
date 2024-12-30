for _, planet in pairs(data.raw.planet) do
    if planet.planet_type and planet.planet_type == "moon" and planet.orbit.parent ~= "star" then
        -- TODO: Should the orientation be rotated if the planet's orbit has rotated?
        PlanetsLib.set_position_from_orbit(planet, planet.orbit)
    end
end
