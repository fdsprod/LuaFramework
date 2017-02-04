Config = {}

local tracer = utils.diagnostics.trace

function Config:new(file, defaults)
    local self = Object:inherit(defaults or self, Object:new())    
    local table = utils.doFile(file)
    
    function self:getFile() 
        return file
    end

    if (table and table.config) then
        for k,v in pairs(table.config) do
            self[k] = v 
        end
    else
        log.info("Configuration not found, using defaults...")
    end    

    return self 
end

function Config:save()
    log.info("Saving configuration")
    utils.serialize(self, 'config', self:getFile())	
end
