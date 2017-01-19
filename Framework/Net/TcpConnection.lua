TcpConnection = {
    traceSendReceive = false,
    isConnected = false
}

function TcpConnection:new(host, port, timeout)
    local self = Object:inherit(self, Object:new())    
    local socket = socket.tcp()

    socket:settimeout(timeout or 0)

    function self:getHostAddress() 
        return host
    end
    
    function self:getPort() 
        return port
    end    

    function self:getSocket()
        return socket
    end

    return self 
end

function TcpConnection:connect()
    local socket = self:getSocket()
    local host = self:getHostAddress()
    local port = self:getPort()  
    local ip = socket.dns.toip(host)

    Tracer.info("Connecting to "..host..":"..port..".")
    
    local success, err = socket:connect(ip, port)

    self.isConnected = success 

    if success then 
        Tracer.info("Successfully connected to "..host..":"..port..".")
    else
        Tracer.error("Connection to "..host..":"..port.." failed.  "..err)
    end

    return success, err
end

function TcpConnection:close()
    Tracer.info("Closing connection to "..host..":"..port..".")
    local socket = self:getSocket()
    socket:close()
    self.isConnected = false
end

function TcpConnection:send(data)
    if self.traceSendReceive then 
        Tracer.debug("Client -> Server("..host..":"..port..") : "..data)
    end

    local socket = self:getSocket()
    local count, err = socket:send(data)

    if err then
        Tracer.error(err)
    elseif self.traceSendReceive then 
        Tracer.debug(count.." bytes sent to "..host..":"..port..".")
    end

    return count, err
end

function TcpConnection:recv()
    local results = {}
    local index = 1
    local buffer, err

    repeat
        buffer, err = self.connection:receive("*l")
        if not err then
            if self.traceSendReceive then 
                Tracer.debug("Client <- Server("..host..":"..port..") : "..buffer)
            end
            results[index] = buffer
        elseif err ~= "timeout" then
            Tracer.error(err)
        end
    until err

    if err == "timeout" then
        err = nil
    end

    return results, err
end

