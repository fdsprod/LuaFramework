TraceAdpater = {}

function TraceAdpater:new(file)
    local self = Object:inherit(self, Object:new())
    self.fout = io.open(file, "w")
    return self
end

function TraceAdpater.debug(str)
    self:write("DEBUG: "..(str or ""))
end

function TraceAdpater:info(str)
    self:write("INFO : "..(str or ""))
end

function TraceAdpater:warn(str)
    self:write("WARN : "..(str or ""))
end

function TraceAdpater:error(str)
    self:write("ERROR: "..(str or ""))
end

function TraceAdpater:write(str)
    if not str or not self.fout then 
        return
    end
    
    self.fout:write("["..os.date("%H:%M:%S").."] "..str.."\r\n")
    self.fout:flush()
end
