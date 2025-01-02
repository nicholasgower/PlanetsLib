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
