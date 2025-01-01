for _, planet in pairs(data.raw["planet"]) do
	if not planet.orbit then
		planet.orbit = {
			distance = planet.distance,
			orientation = planet.orientation,
			parent = {
				type = "space-location",
				name = "star",
			},
		}
	end
end
for _, location in pairs(data.raw["space-location"]) do
	if not location.orbit then
		location.orbit = {
			distance = location.distance,
			orientation = location.orientation,
			parent = {
				type = "space-location",
				name = "star",
			},
		}
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
