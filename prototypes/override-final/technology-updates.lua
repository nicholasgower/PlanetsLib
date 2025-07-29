for _,tech in pairs(data.raw["technology"]) do
    PlanetsLib.process_technology_recipe_productivity_effects(tech)
end