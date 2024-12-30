require("scripts.cargo-pods")

-- local base_prototype_data = require("dump")

-- local COMMON_PROPERTIES = {
--     "name",
--     "type",
--     "subgroup",
--     "order"
-- }

-- local PROTOTYPE_PROPERTIES = {
--     item = {
--         "stack_size",
--         "fuel_value",
--         "fuel_category",
--         "place_result",
--     },
--     recipe = {
--         "category",
--         "ingredients",
--         "products",
--     }
-- }

-- local function dump_prototypes()
--     local function extract_properties(prototype, property_list)
--         local result = {}
--         for _, prop in ipairs(COMMON_PROPERTIES) do
--             result[prop] = prototype[prop]
--         end
--         for _, prop in ipairs(property_list) do
--             result[prop] = prototype[prop]
--         end
--         return result
--     end

--     local base_prototypes = {}

--     for prototype_type, properties in pairs(PROTOTYPE_PROPERTIES) do
--         local prototype_collection = prototypes[prototype_type]
--         if prototype_collection then
--             base_prototypes[prototype_type] = {}
--             for name, prototype in pairs(prototype_collection) do
--                 base_prototypes[prototype_type][name] =
--                     extract_properties(prototype, properties)
--             end
--         end
--     end

--     log(serpent.block(base_prototypes))
--     game.print("Prototype dump written to log")
-- end

-- commands.add_command("dump_prototypes", "Dump base prototypes", dump_prototypes)

-- local function extract_properties(prototype, property_list)
--     local result = {}
--     for _, prop in ipairs(COMMON_PROPERTIES) do
--         result[prop] = prototype[prop]
--     end
--     for _, prop in ipairs(property_list) do
--         result[prop] = prototype[prop]
--     end
--     return result
-- end

-- local function compare_values(base_value, current_value)
--     if type(base_value) ~= type(current_value) then
--         return false
--     end

--     if type(base_value) == "table" then
--         -- For arrays (like ingredients/products), compare contents
--         if #base_value ~= #current_value then
--             return false
--         end
--         for i, v in ipairs(base_value) do
--             if not compare_values(v, current_value[i]) then
--                 return false
--             end
--         end
--         return true
--     end

--     return base_value == current_value
-- end

-- local function check_modifications()
--     local modifications = {}

--     for prototype_type, properties in pairs(PROTOTYPE_PROPERTIES) do
--         local prototype_collection = prototypes[prototype_type]
--         if prototype_collection then
--             for name, prototype in pairs(prototype_collection) do
--                 local current_data = extract_properties(prototype, properties)
--                 local base_data = base_prototype_data[prototype_type][name]

--                 if base_data then
--                     local differences = {}
--                     -- Check common properties
--                     for _, prop in ipairs(COMMON_PROPERTIES) do
--                         if not compare_values(base_data[prop], current_data[prop]) then
--                             differences[prop] = {
--                                 old = base_data[prop],
--                                 new = current_data[prop]
--                             }
--                         end
--                     end
--                     -- Check type-specific properties
--                     for _, prop in ipairs(properties) do
--                         if not compare_values(base_data[prop], current_data[prop]) then
--                             differences[prop] = {
--                                 old = base_data[prop],
--                                 new = current_data[prop]
--                             }
--                         end
--                     end

--                     if next(differences) then
--                         modifications[prototype_type .. "." .. name] = differences
--                     end
--                 end
--             end
--         end
--     end

--     -- Log all modifications found
--     if next(modifications) then
--         log("=== Prototype Modifications Detected ===")
--         for prototype_path, changes in pairs(modifications) do
--             log("\nModified " .. prototype_path .. ":")
--             for property, change in pairs(changes) do
--                 log(string.format("  %s:", property))
--                 log("    Was: " .. serpent.line(change.old))
--                 log("    Now: " .. serpent.line(change.new))
--             end
--         end
--     else
--         log("No modifications detected in tracked prototypes")
--     end

--     game.print("Prototype comparison results written to log")
-- end

-- commands.add_command("check_modifications", "Check for prototype modifications", check_modifications)
