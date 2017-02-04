FileLogAdapter = {}

function FileLogAdapter:new(file)
    local self = Object:inherit(self, Object:new())
    self.fout = io.open(file, "w")
    return self
end

function FileLogAdapter.debug(str)
    self:write("DEBUG: "..(str or ""))
end

function FileLogAdapter:info(str)
    self:write("INFO : "..(str or ""))
end

function FileLogAdapter:warn(str)
    self:write("WARN : "..(str or ""))
end

function FileLogAdapter:error(str)
    self:write("ERROR: "..(str or ""))
end

function FileLogAdapter:write(str)
    if not str or not self.fout then 
        return
    end
    
    self.fout:write("["..os.date("%H:%M:%S").."] "..str.."\r\n")
    self.fout:flush()
end
