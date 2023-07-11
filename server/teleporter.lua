--TELEPORTER CONTROLLER v2.0

function resetOutput()
--Bottom
	redstone.setAnalogOutput("right", 0)
--Top
	redstone.setAnalogOutput("bottom", 0)
end

--Top 		9-16
--Bottom	1-8
while true do
	resetOutput()
	local _, number = os.pullEvent("tele")
	if number < 9 then redstone.setAnalogOutput("right", number)
	else redstone.setAnalogOutput("bottom", number - 8) end
	sleep(1)
end