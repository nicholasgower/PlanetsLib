for _, planet in pairs(data.raw["planet"]) do
	if not planet.orbit then
		planet.orbit = {
			parent = {
				type = "space-location",
				name = "star",
			},
		}
	end
	if not planet.orbit.distance then
		planet.orbit.distance = planet.distance
	end
	if not planet.orbit.orientation then
		planet.orbit.orientation = planet.orientation
	end
end
for _, location in pairs(data.raw["space-location"]) do
	if not location.orbit then
		location.orbit = {
			parent = {
				type = "space-location",
				name = "star",
			},
		}
	end
	if not location.orbit.distance then
		location.orbit.distance = location.distance
	end
	if not location.orbit.orientation then
		location.orbit.orientation = location.orientation
	end
end

data.raw["planet"]["vulcanus"].orbit.sprite = {
	type = "sprite",
	filename = "__PlanetsLib__/graphics/orbits/orbit_vulcanus.png",
	size = 640,
}
data.raw["planet"]["nauvis"].orbit.sprite = {
	type = "sprite",
	filename = "__PlanetsLib__/graphics/orbits/orbit_nauvis.png",
	size = 960,
}
data.raw["planet"]["gleba"].orbit.sprite = {
	type = "sprite",
	filename = "__PlanetsLib__/graphics/orbits/orbit_gleba.png",
	size = 1280,
}
data.raw["planet"]["fulgora"].orbit.sprite = {
	type = "sprite",
	filename = "__PlanetsLib__/graphics/orbits/orbit_fulgora.png",
	size = 1600,
}
data.raw["planet"]["aquilo"].orbit.sprite = {
	type = "sprite",
	filename = "__PlanetsLib__/graphics/orbits/orbit_aquilo.png",
	size = 2240,
}
data.raw["space-location"]["solar-system-edge"].orbit.sprite = {
	type = "sprite",
	filename = "__PlanetsLib__/graphics/orbits/orbit_solar-system-edge.png",
	size = 3200,
}
