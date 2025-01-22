local Public = {}

local warn_color = { r = 255, g = 90, b = 54 }

function Public.tick_10_check_cargo_pods()
	if not storage.planets_lib then
		storage.planets_lib = {}
	end

	if not storage.planets_lib.cargo_pods_seen_on_platforms then
		storage.planets_lib.cargo_pods_seen_on_platforms = {}
	end
	if not storage.planets_lib.cargo_pod_canceled_whisper_ticks then
		storage.planets_lib.cargo_pod_canceled_whisper_ticks = {}
	end

	for _, force in pairs(game.forces) do
		for _, platform in pairs(force.platforms) do
			if platform and platform.valid and platform.surface and platform.surface.valid then
				local planet_name = nil
				if platform.space_location and platform.space_location.valid and platform.space_location.name then
					planet_name = platform.space_location.name
				end

				if planet_name then
					local cargo_drops_tech = force.technologies["planetslib-" .. planet_name .. "-cargo-drops"]

					if cargo_drops_tech and not cargo_drops_tech.researched then
						local cargo_pods = platform.surface.find_entities_filtered({ type = "cargo-pod" })

						Public.examine_cargo_pods(platform, cargo_pods, planet_name)
					end
				end
			end
		end
	end
end

script.on_nth_tick(10, Public.tick_10_check_cargo_pods)

function Public.examine_cargo_pods(platform, cargo_pods, planet_name)
	for _, pod in pairs(cargo_pods) do
		if pod and pod.valid and not storage.planets_lib.cargo_pods_seen_on_platforms[pod.unit_number] then
			local pod_contents = pod.get_inventory(defines.inventory.cargo_unit).get_contents()

			local only_construction_robots_or_players = true

			for _, item in pairs(pod_contents) do
				local entity = prototypes.entity[item.name]

				if (not entity) or (entity and entity.type ~= "construction-robot") then
					only_construction_robots_or_players = false
				end
			end

			local nearby_hubs = platform.surface.find_entities_filtered({
				name = { "space-platform-hub", "cargo-bay" },
				position = pod.position,
				radius = 4,
			})

			local launched_from_platform = #nearby_hubs > 0

			storage.planets_lib.cargo_pods_seen_on_platforms[pod.unit_number] = {
				launched_from_platform = launched_from_platform,
				entity = pod,
				platform_index = platform.index,
			}

			if launched_from_platform and not only_construction_robots_or_players then
				Public.destroy_pod_on_platform(pod, platform, planet_name)
			end
		end
	end
end

function Public.destroy_pod_on_platform(pod, platform, planet_name)
	local hub = platform.hub
	if hub and hub.valid then
		local pod_inventory = pod.get_inventory(defines.inventory.cargo_unit)
		local hub_inventory = hub.get_inventory(defines.inventory.hub_main)

		if pod_inventory and hub_inventory then
			for _, item in pairs(pod_inventory.get_contents()) do
				hub_inventory.insert(item)
			end
		end
	end

	for _, player in pairs(game.connected_players) do
		if
			player.valid
			and player.surface
			and player.surface.valid
			and player.surface.index == platform.surface.index
		then
			local whisper_hash = platform.index .. "-" .. player.name

			local last_whisper_tick = storage.planets_lib.cargo_pod_canceled_whisper_ticks[whisper_hash]

			if (not last_whisper_tick) or (game.tick - last_whisper_tick >= 60 * 10) then
				player.print({
					"planetslib.cargo-pod-canceled",
					"[space-platform=" .. platform.index .. "]",
					"[technology=" .. "planetslib-" .. planet_name .. "-cargo-drops" .. "]",
				}, { color = warn_color })

				storage.planets_lib.cargo_pod_canceled_whisper_ticks[whisper_hash] = game.tick
			end
		end
	end

	local pod_unit_number = pod.unit_number

	pod.destroy()

	storage.planets_lib.cargo_pods_seen_on_platforms[pod_unit_number] = nil
end

return Public
