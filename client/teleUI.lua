--TELEPORTER UI v1.0

basalt = require("basalt")
peripheral.find("modem", rednet.open)

settings.load("teleporter/settings")
local myTeleID = settings.get("myTeleID", 0)

--TODO: descriptions, co-ordinates, passwords, flavour text, teleporter cache and refresh

--"teleDimOver" is overworld 
--"teleDimNeth" is nether 
--"teleDimEnd"  is end
local function getTeleporters(dimension)
	local computers = {rednet.lookup(dimension)}
	local teleporters = {}
	local keys = {}
	for i, computer in pairs(computers) do
		rednet.send(computer, "who", dimension)
		local id, name = rednet.receive(dimension)
		teleporters[name] = id
		keys[i] = name
	end
	return teleporters, keys
end

local overworldIDs, overworld = getTeleporters("teleDimOver")
local netherIDs, nether = getTeleporters("teleDimNeth")
local theEndIDs, theEnd = getTeleporters("teleDimEnd")

local main = basalt.createFrame()
	:setBackground(colors.lightGray)
	:setForeground(colors.black)

local bottomInfo = main:addFrame():setSize(26, 1):setPosition(1, 20)

local showTeleID = bottomInfo:addLabel()
	:setText("ID:?")

local teleTitle = main:addLabel():setPosition(2, 13)
	:setText("Select a teleporter")

local teleList = main:addList():setSize(22, 8):setPosition(2, 2)
	:setOptions(overworld)
	:setSelectionColor(colors.blue, colors.white)
	local teleListItemCount = teleList:getItemCount()

local scrollbar = main:addScrollbar():setPosition(24, 2):setSize(2, 8)
	:setScrollAmount(teleListItemCount - 7)

local dimension = main:addDropdown():setPosition(2, 11)
	:addItem("Overworld", colors.green, colors.white, overworld, overworldIDs, "teleDimOver")
	:addItem("Nether", colors.red, colors.white, nether, netherIDs, "teleDimNeth")
	:addItem("The End", colors.yellow, colors.white, theEnd, theEndIDs, "teleDimEnd")
	:setSelectionColor(colors.blue, colors.white)
	SelectionIDsTable = dimension:getValue().args[2]
	SelectionProtocol = dimension:getValue().args[3]

local teleButton = main:addButton():setSize(16, 3):setPosition(6, 17)
	:setVisible(false)
	:setText("TELEPORT")
	:setBackground(colors.green)
	:setForeground(colors.white)

dimension:onSelect(function(self, item)
	teleList:setOptions(self:getValue().args[1])
	SelectionIDsTable = self:getValue().args[2]
	SelectionProtocol = self:getValue().args[3]
end)

teleList:onSelect(function(self, event, item)
	Selection = item.text
	SelectionID = SelectionIDsTable[Selection]
	showTeleID:setText("ID:"..SelectionID)
	teleTitle:setText(Selection)
	teleButton:setVisible(true)
end)

scrollbar:onChange(function(_, _, value)
  teleList:setOffset(value-1)
end)

teleList:onScroll(function()
	scrollbar:setIndex(teleList:getOffset() + 1)
end)

teleButton:onClick(function()
	teleTitle:setText("Teleporting to "..SelectionID)
	rednet.send(SelectionID, myTeleID, SelectionProtocol)
end)
	

basalt.autoUpdate()