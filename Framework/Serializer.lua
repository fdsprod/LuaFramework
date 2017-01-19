Serializer = {
    fout = nil,
    level = "",
}

function Serializer:new(fout)
    local self = Object:inherit(self, Object:new())    
    self.fout = fout    
    return self
end

function Serializer:writeValue(o)
    if type(o) == "number" then
        return o
    elseif type(o) == "boolean" then
        return tostring(o)
    elseif type(o) == "string" then
        return string.format("%q", o)
    else
        return "nil"
    end
end

function Serializer:writeObject(name, value, level)
    if level == nil then level = self.level end
    if type(value) == "number" or type(value) == "string" or type(value) == "boolean" then
        self.fout:write(level, name, " = ")
        self.fout:write(self:writeValue(value), ",\n")
    elseif type(value) == "table" then
        self.fout:write(level, name, " = ")
        self.fout:write("\n"..level.."{\n")
        for k,v in pairs(value) do 
            local key
            if type(k) == "number" then
                key = string.format("[%s]", k)
            else
                key = k
            end
            self:writeObject(key, v, level.."  ")
        end        
        self.fout:write(level.."},\n")
    end
end
