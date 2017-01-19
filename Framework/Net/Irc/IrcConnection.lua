IrcConnection = {
    traceSendReceive = false
}

function IrcConnection:new(host, port)
    local self = Object:inherit(self, TcpConnection:new(host, port)) 
end

function IrcConnection:connect(username, password)
    local success, err = TcpConnection.connect(self)
    return success, err
end

function IrcConnection:recv()
    local packets, err = TcpConnection.recv()

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

