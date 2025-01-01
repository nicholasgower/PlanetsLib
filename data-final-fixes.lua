local orbits = require("lib.orbits")

-- Force-set the position of planets and moons, in case other mods moved them:
for _, p in pairs(data.raw.planet) do
	local distance, orientation = orbits.get_absolute_polar_position_from_orbit(p.orbit)
	p.distance = distance
	p.orientation = orientation
end
for _, p in pairs(data.raw["space-location"]) do
	local distance, orientation = orbits.get_absolute_polar_position_from_orbit(p.orbit)
	p.distance = distance
	p.orientation = orientation
end

require("prototypes.override-final.starmap")

for _, p in pairs(data.raw.planet) do
	if p.sprite_only then
		data.raw.planet[p.name] = nil
	end
end
for _, p in pairs(data.raw["space-location"]) do
	if p.sprite_only then
		data.raw["space-location"][p.name] = nil
	end
end
