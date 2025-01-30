require("prototypes.override.planet")


--promethium is automatically set as an endgame technology, so it will always have all science packs.
-- in data updates, so other mods can turn it off.
data.raw["technology"]["promethium-science-pack"]["as_endgame_technology"] = true