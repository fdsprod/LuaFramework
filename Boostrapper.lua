package.path  = package.path..";.\\LuaSocket\\?.lua;"
package.cpath = package.cpath..";.\\LuaSocket\\?.dll;"


Include.ProgramPath = ".\\Framework"

Include.File("Framework\\utils")
Include.File("Framework\\Object")
Include.File("Framework\\Logging\\FileLogAdapter")
Include.File("Framework\\Serializer")
--Include.File("Framework\\Net\\TcpConnection")
--Include.File("Framework\\Net\\Irc\\IrcConnection")

local logFile = "C:\\Users\\jboulang\\Documents\\test.log"
log.registerAdapter(FileLogAdapter:new(logFile))

TestObject = {
	boolean = true,
	string = "string",
	number = 1,
	table = {
		foo = 1,
		bar = 2,
	}
}

function TestObject:new()
    local self = Object:inherit(self, Object:new())
    return self
end

function TestObject:sum(a,b)
	return a + b
end

local path = "C:\\Users\\jboulang\\Documents\\test.lua"

utils.io.serialize("TestObject", TestObject, path)

--local irc = IrcConnection:new("irc.chat.twitch.tv", 6667)

--local response = irc.recv()

-- for i, cmd in ipairs(response) do
-- 	log.debug(cmd)
-- end

log.info("done.")
