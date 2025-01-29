local lib = require("lib.lib")

-- fix ordering of science packs in the vanilla lab to match the pack's order string.
local lab = data.raw["lab"]["lab"]
local base_inputs = lib.sorted_by_order_and_name(lab.inputs)
lab.inputs = base_inputs

-- the biolab should have all of these by default
data.raw["lab"]["biolab"].include_all_lab_science = true

for _, new_lab in pairs(data.raw["lab"]) do
	if new_lab["include_all_lab_science"] == true then
		for _, input in pairs(base_inputs) do
			if not lib.contains(new_lab.inputs, input) then
				table.insert(new_lab.inputs, input)
			end
		end
		new_lab.inputs = lib.sorted_by_order_and_name(new_lab.inputs)
	elseif new_lab["sort_sciences"] == true then
		local local_inputs = new_lab.inputs
		new_lab.inputs = lib.sorted_by_order_and_name(local_inputs)
	end
end
