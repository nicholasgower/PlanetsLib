local Public = {}

function Public.set_position_from_orbit(planet, orbit)
    if orbit.parent == "star" then
        planet.distance = orbit.distance
        planet.orientation = orbit.orientation
    else
        local parent = data.raw.planet[orbit.parent]
        local parent_distance = parent.distance
        local parent_orientation = parent.orientation

        local parent_angle = parent_orientation * 2 * math.pi
        local orbit_angle = orbit.orientation * 2 * math.pi

        local px = parent_distance * math.cos(parent_angle)
        local py = parent_distance * math.sin(parent_angle)
        local ox = orbit.distance * math.cos(orbit_angle)
        local oy = orbit.distance * math.sin(orbit_angle)

        local x = px + ox
        local y = py + oy

        planet.distance = math.sqrt(x * x + y * y)
        planet.orientation = math.atan2(y, x) / (2 * math.pi)
        if planet.orientation < 0 then planet.orientation = planet.orientation + 1 end
        if planet.orientation > 1 then planet.orientation = planet.orientation - 1 end
    end
end

return Public
