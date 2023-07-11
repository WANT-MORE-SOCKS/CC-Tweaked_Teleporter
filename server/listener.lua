--TELEPORTER LISTENER v1.0

--TODO: settings integration, passwords

--IMPORTANT!!
settings.load("/teleporter/settings")
local hostName = settings.get("hostName")
local dimension = settings.get("dimension")
--IMPORTANT!!
peripheral.find("modem", rednet.open)

rednet.host(dimension, hostName)

while true do
	local id, message, _ = rednet.receive(dimension)
	print(message)
	if message == "who" then rednet.send(id, hostName, dimension)
	elseif (type(message) == "number" and 16 >= message and message >= 1) then os.queueEvent("tele", message) end
end