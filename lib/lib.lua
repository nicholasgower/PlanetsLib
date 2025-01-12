
local lib={}

--Encodes string to double
function lib.encode_string(str) 
    assert(#str <= 8, "String length exceeds 8 characters; cannot encode.")
    
    local result = 0
    local length = #str
    local max_bytes = 8 -- We can encode up to 8 bytes in a double precision floating point
    
    for i = 1, length do
        local byte = string.byte(str, i)
        result = result + byte * (256 ^ (i - 1))
    end
    
    return result
end

-- Decodes a double back into a string
function lib.decode_string(num)
    local result = {}
    local max_bytes = 8 -- Decode up to 8 bytes
    
    for i = 0, max_bytes - 1 do
        local byte = math.floor(num / (256 ^ i)) % 256
        if byte == 0 then break end -- Null terminator or end of meaningful bytes
        table.insert(result, string.char(byte))
    end
    
    return table.concat(result)
end



return lib