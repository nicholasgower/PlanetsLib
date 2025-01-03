for _, planet in pairs(data.raw["planet"]) do
	if not (planet.orbit and planet.orbit.parent and planet.orbit.distance and planet.orbit.orientation) then
		planet.orbit = {
			parent = {
				type = "space-location",
				name = "star",
			},
			distance = planet.distance,
			orientation = planet.orientation,
		}
	end
end
for _, location in pairs(data.raw["space-location"]) do
	if not (location.orbit and location.orbit.parent and location.orbit.distance and location.orbit.orientation) then
		location.orbit = {
			parent = {
				type = "space-location",
				name = "star",
			},
			distance = location.distance,
			orientation = location.orientation,
		}
	end
end

-- Disabled as the vanilla orbits are sufficient:
-- data.raw["planet"]["vulcanus"].orbit.sprite = {
-- 	type = "sprite",
-- 	filename = "__PlanetsLib__/graphics/orbits/orbit_vulcanus.png",
-- 	size = 640,
-- }
-- data.raw["planet"]["nauvis"].orbit.sprite = {
-- 	type = "sprite",
-- 	filename = "__PlanetsLib__/graphics/orbits/orbit_nauvis.png",
-- 	size = 960,
-- }
-- data.raw["planet"]["gleba"].orbit.sprite = {
-- 	type = "sprite",
-- 	filename = "__PlanetsLib__/graphics/orbits/orbit_gleba.png",
-- 	size = 1280,
-- }
-- data.raw["planet"]["fulgora"].orbit.sprite = {
-- 	type = "sprite",
-- 	filename = "__PlanetsLib__/graphics/orbits/orbit_fulgora.png",
-- 	size = 1600,
-- }
-- data.raw["planet"]["aquilo"].orbit.sprite = {
-- 	type = "sprite",
-- 	filename = "__PlanetsLib__/graphics/orbits/orbit_aquilo.png",
-- 	size = 2240,
-- }
-- data.raw["space-location"]["solar-system-edge"].orbit.sprite = {
-- 	type = "sprite",
-- 	filename = "__PlanetsLib__/graphics/orbits/orbit_solar-system-edge.png",
-- 	size = 3200,
-- }