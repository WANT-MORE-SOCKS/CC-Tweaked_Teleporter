--TELEPORTER CONTROLLER v2.0

local function resetOutput()
--Bottom
	redstone.setAnalogOutput("right", 0)
--Top
	redstone.setAnalogOutput("front", 0)
end

--Top 		9-16
--Bottom	1-8
while true do
	resetOutput()
	local _, number = os.pullEvent("tele")
	if number < 9 then
		redstone.setAnalogOutput("right", number)
		print("right activated")
	else
		redstone.setAnalogOutput("front", number - 8)
		print("front activated")
	end
	sleep(1)
end