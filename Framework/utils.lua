
utils = {
	diagnostics = {},
	table = {},
	io = {}
}

utils.diagnostics.safeCall = function(callback)
	if type(object) ~= "function" then
		Tracer.error("utils.diagnostics.safeCall: callback was not a valid function.")
	end

	local result, err = pcall(callback)

	if err then 
		Tracer.error(err)
	end

	return result
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
		Tracer.warn("Cannot load " .. filename .. ": " .. err)
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