Object = {}

function Object:new()
    local self = utils.deepCopy( self ) -- Create a new self instance
    local mt = {}

	setmetatable( self, mt )
	self.__index = self	

	return self
end

function Object:inherit( child, parent )
	local child = utils.deepCopy( child )
	if child ~= nil then
		setmetatable( child, parent )
		child.__index = child
	end
	return child
end