IrcConnection = {
    isConnected = false
}

function IrcConnection:new(host, port, caps, timeout)
    local self = Object:inherit(self, TcpConnection:new(host, port)) 
end

function IrcConnection:connect(username, password)
    local success, err = __super:connect()

    local host = __super:getHostAddress()
    local port = __super:getPort()  

    if not success then
        log.warn("Unable to connect to "..host..":"..self.port)
    else
        tracer:info("Conncted to "..host..":"..self.port)
       
        self:settimeout(timeout)  
        
        self:send("CAP REQ : "..table.concat(caps, " "))
        self:send("PASS "..password)
        self:send("NICK "..username)

        self.isConnected = true
    end

    return success, err
end

function IrcConnection:join(roomname)
    self:send("JOIN #"..string.lower(roomname))
end

function IrcConnection:recv()
    local packets, err = __super:recv()

    if err then
        return false
    end
    
     for i, packet in ipairs(packets) do        
        local prefix, cmd, param = string.match(buffer, "^:([^ ]+) ([^ ]+)(.*)$")
        
        param = string.sub(param,2)

        local param1, param2 = string.match(param,"^([^:]+) :(.*)$")
        local user, userhost = string.match(prefix,"^([^!]+)!(.*)$")
     end
end

