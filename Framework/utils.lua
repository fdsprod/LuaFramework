
utils = {
	diagnostics = {
		log = {
			adapters = {}
		}
	},
	table = {},
	io = {}
}

utils.diagnostics.safeCall = function(callback)
	if type(object) ~= "function" then
		adapter.error("utils.diagnostics.safeCall: callback was not a valid function.")
	end

	local result, err = pcall(callback)

	if err then 
		adapter.error(err)
	end

	return result
end

utils.diagnostics.log.registerAdapter = function(adapater)
    table.insert(utils.diagnostics.log.adapters, adapater)
end

utils.diagnostics.log.debug = function(str)
	for i, adapter in ipairs(utils.diagnostics.log.adapters) do
		if adapter and adapter.debug then adapter:debug(str) end
	end
end

utils.diagnostics.log.info = function(str)
	for i, adapter in ipairs(utils.diagnostics.log.adapters) do
		if adapter and adapter.info then adapter:info(str) end
	end
end

utils.diagnostics.log.warn = function(str)
	for i, adapter in ipairs(utils.diagnostics.log.adapters) do
		if adapter and adapter.warn then adapter:warn(str) end
	end
end

utils.diagnostics.log.error = function(str)
	for i, adapter in ipairs(utils.diagnostics.log.adapters) do
		if adapter and adapter.error then adapter:error(str) end
	end
end

--from http://lua-users.org/wiki/CopyTable
utils.table.deepCopy = function(object)
	local lookup_table = {}
	local function _copy(object)
		if type(object) ~= "table" then
			return object
		elseif lookup_table[object] then
			return lookup_table[object]
		end
		local new_table = {}
		lookup_table[object] = new_table
		for index, value in pairs(object) do
			new_table[_copy(index)] = _copy(value)
		end
		return setmetatable(new_table, getmetatable(object))
	end
	local objectreturn = _copy(object)
	return objectreturn
end

utils.io.serialize = function(name, table, path)	 
    local fout = assert(io.open(path, 'w'))
    if fout then
        local serializer = Serializer:new(fout)
        serializer:writeObject(name, table)
        fout:close()
    end
end

utils.io.loadFile = function(filename)
	local result
	local f, err = loadfile(filename)

	if f then
		local env = {}

		setfenv(f, env)
		f()

		result = env.dialog
	else
		adapter.warn("Cannot load " .. filename .. ": " .. err)
	end

	return result
end
    
utils.io.doFile = function(filename)        
	local f, err = utils.loadfile(filename)
	if not f then
		return { }
	end
	local env = {_ = function(p) return p end} 
	setfenv(f, env)
	f()
	env._ = nil;
	return env
end

-- Register for shorthand access
log = utils.diagnostics.log

local PrintLogAdapter = {}

function PrintLogAdapter:new()
    local self = utils.table.deepCopy( self ) -- Create a new self instance
    local mt = {}

	setmetatable( self, mt )
	self.__index = self	

	return self
end

function PrintLogAdapter.debug(str)
    self:write("DEBUG: "..(str or ""))
end

function PrintLogAdapter:info(str)
    self:write("INFO : "..(str or ""))
end

function PrintLogAdapter:warn(str)
    self:write("WARN : "..(str or ""))
end

function PrintLogAdapter:error(str)
    self:write("ERROR: "..(str or ""))
end

function PrintLogAdapter:write(str)
	print("["..os.date("%H:%M:%S").."] "..str)
end

log.registerAdapter(PrintLogAdapter:new())