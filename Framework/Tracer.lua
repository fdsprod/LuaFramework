Tracer = {
    listeners = {}
}

function Tracer.registerListener(listener)
    table.insert(Tracer.listener, listener)
end

function Tracer.debug(str)
	for i, tracer in ipairs(Tracer.listeners) do
		if tracer and tracer.debug then tracer:debug(str) end
	end
end

function Tracer.info(str)
	for i, tracer in ipairs(Tracer.listeners) do
		if tracer and tracer.info then tracer:info(str) end
	end
end

function Tracer.warn(str)
	for i, tracer in ipairs(Tracer.listeners) do
		if tracer and tracer.warn then tracer:warn(str) end
	end
end

function Tracer.error(str)
	for i, tracer in ipairs(Tracer.listeners) do
		if tracer and tracer.error then tracer:error(str) end
	end
end
