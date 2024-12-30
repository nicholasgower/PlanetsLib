---@param starmap_planet_icon string
---@param planet_icon_size number
function PlanetsLib.technology_icons_planet_cargo_drops(planet_icon)
    return {
        {
            icon = "__PlanetsLib__/graphics/icons/cargo-drop-tech-pod.png",
            icon_size = 520, -- TODO: 512
            scale = 0.4923,
            shift = { 0, 0 },
            draw_background = true,
        },
        {
            icon = planet_icon, -- TODO: Rotate 90 with shadow beneath
            icon_size = 256,
            scale = 0.65,
            shift = { -17, 55 },
            draw_background = true,
        },
        {
            icon = "__PlanetsLib__/graphics/icons/cargo-drop-tech-shadow.png",
            icon_size = 520,
            scale = 0.4923,
            shift = { 0, 0 },
            tint = { r = 0, g = 0, b = 0, a = 0.5 },
            draw_background = true,
        },
        {
            icon = "__PlanetsLib__/graphics/icons/cargo-drop-tech-pod.png",
            icon_size = 520,
            scale = 0.4923,
            shift = { 0, 0 },
            draw_background = true,
        }
    }
end

function PlanetsLib.technology_icons_moon(moon_icon)
    local icons =
    {
        {
            icon = moon_icon,
            icon_size = 256,
        },
        {
            icon = "__PlanetsLib__/graphics/icons/moon-technology-symbol.png",
            icon_size = 128,
            scale = 0.5,
            shift = { 50, 50 }
        }
    }
    return icons
end

function PlanetsLib.cargo_drops_tech_effect(planet_name)
    return {
        {
            type = "nothing",
            effect_description = { "planetslib.cargo-drops-tech-description", "[space-location=" .. planet_name .. "]" },
        },
    }
end

-- TODO: Apply use_icon_overlay_constant to the unlock if the planet is a moon
