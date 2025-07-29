local rro = require("lib.remove-replace-object")

--New technologyPrototype field: PlanetsLib_recipe_productivity_effects
--Properties:
--  effects: array[ChangeResultProductivityModifier]
--  purge_other_effects: boolean. Default: false. Before adding effects added by PlanetsLib_recipe_productivity_effects, remove all effects not flagged with PlanetsLib_force_include.

--ChangeResultProductivityModifier
--Properties:
--  allow_multiple_results: boolean. Default: false. When false, only recipes with one result are added to the technology's effect list.
--  category (optional) (Either (name and type) or category required) 
--Inherited from ChangeRecipeProductivityModifier https://lua-api.factorio.com/latest/types/ChangeRecipeProductivityModifier.html
--  type (optional)
--  name (optional)
--  change 
--  icons (optional)
--  icon (optional)
--  icon_size (optional)
--  hidden (optional)
--  use_icon_overlay_constant (optional)



--New Modifier field: PlanetsLib_force_include
-- Makes this modifier immune to purge_other_effects.

--New recipe field: PlanetsLib_blacklist_technology_updates
-- Stops PlanetsLib from targeting this recipe in technology updates.

local function xor(a,b)
    return (a or b) and (not(a and b))
end

local function apply_recipe_productivity_effects(tech) 
    if tech.PlanetsLib_recipe_productivity_effects then
        
        local new_effects = {}
        if tech.PlanetsLib_recipe_productivity_effects.purge_other_effects then
            for _,effect in pairs(tech.effects) do
                if effect.PlanetsLib_force_include then
                    table.insert(new_effects,effect)
                end
            end
        else
            new_effects = table.deepcopy(tech.effects)
        end
        if not tech.effects then tech.effects = {} end
        

        for _,effect in pairs(tech.PlanetsLib_recipe_productivity_effects.effects) do
            local type = effect.type
            local name = effect.name
            local change = effect.change
            local category = effect.category 
            assert(xor(name,category),"You may only filter by result name or by category.")
            if category then
                assert(tech.PlanetsLib_recipe_productivity_effects.category_blacklist == nil,"category_blacklist and category are incompatible.")
            end

            local category_blacklist = tech.PlanetsLib_recipe_productivity_effects.category_blacklist or {"recycling"} --Excluded recipe categories

            for _,recipe in pairs(data.raw["recipe"]) do
                if not (recipe.Planetslib_blacklist_technology_updates or rro.contains(category_blacklist,recipe.category) )
                and recipe.results and (#recipe.results == 1 or effect.allow_multiple_results) then
                    for _,result in pairs(recipe.results) do
                        if result.type == type and ((not name and recipe.category == category) or result.name == name) then
                            local new_effect = {
                                type = "change-recipe-productivity",
                                recipe = recipe.name,
                                change = change,
                                hidden = effect.hidden,
                                use_icon_overlay_constant = effect.use_icon_overlay_constant,
                                icons = effect.icons,
                                icon = effect.icon,
                                icon_size = effect.icon_size,
                            }
                            --Check if effect already exists 
                            local contains = false
                            for _,effect in pairs(new_effects) do
                                if effect.recipe == new_effect.recipe then
                                    contains = true
                                end
                            end
                            if not contains then
                                table.insert(new_effects,new_effect)
                            end
                            break --To stop the same recipe from being added multiple times per result item.
                        end
                    end
                end
            end
            tech.effects = new_effects

        end
        tech.PlanetsLib_recipe_producitivity_effects = nil
    end



end


for _,tech in pairs(data.raw["technology"]) do
    apply_recipe_productivity_effects(tech)
end