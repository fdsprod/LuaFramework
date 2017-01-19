Include.File("Framework\\utils")
Include.File("Framework\\Object")
Include.File("Framework\\Tracer")
Include.File("Framework\\Tracers\\FileTraceAdapter")
Include.File("Framework\\Serializer")
Include.File("Framework\\Net\\TcpConnection")

local log = "C:\\Users\\jboulang\\Documents\\test.log"

Tracer.registerListener(FileTraceAdapter:new(log))

local test =  {
	boolean = true,
	string = "string",
	number = 1,
	table = {
		foo = 1,
		bar = 2,
	}
}

test.sum = function(a,b)
	return a + b
end

local path = "C:\\Users\\jboulang\\Documents\\test.lua"

utils.serialize("test", test, path)
