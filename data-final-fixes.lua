local planet = require("lib.planet")

for _, p in pairs(data.raw.planet) do
    if p.planet_type and p.planet_type == "moon" and p.orbit.parent ~= "star" then
        -- TODO: Should the orientation be rotated if the planet's orbit has rotated?
        planet.set_position_from_orbit(p, p.orbit)
    end
end
