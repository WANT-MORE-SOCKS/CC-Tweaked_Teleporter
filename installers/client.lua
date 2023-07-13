--TELEPORTER CLIENT INSTALLER v1.0
--REQUIRES BASALT FRAMEWORK

if not fs.exists("/basalt.lua") then
    term.setTextColour(colors.red)
    print("This program requires the Basalt UI Framework.")
    term.setTextColour(colors.yellow)
    print("Do you wish to install the latest version? [y/n]")
    local answer = read()
    term.setTextColour(colors.white)
    if answer == "yes" or answer == "y" then
        shell.run("wget run https://basalt.madefor.cc/install.lua packed")
    else
        error("Goodbye")
    end
end

if fs.exists("/teleporter") then fs.delete("/teleporter") end
fs.makeDir("teleporter")
local basalt = require("/basalt")

local main = basalt.createFrame()
    :setBackground(colors.black)
    :setForeground(colors.white)

local sub = {
    main:addFrame():setSize("{parent.w}", "{parent.h}")
        :setBackground(colors.black)
        :setForeground(colors.white),
    main:addFrame():setSize("{parent.w}", "{parent.h}"):hide(),
    main:addFrame():setSize("{parent.w}", "{parent.h}"):hide(),
    main:addFrame():setSize("{parent.w}", "{parent.h}"):hide()
}

local function openSubFrame(id)
    if(sub[id]~=nil)then
        for k,v in pairs(sub)do
            v:hide()
        end
        sub[id]:show()
    end
end

local figletTitle = sub[1]:addLabel()
    :setText("  ||           '||`       \n  ||            ||        \n''||''  .|''|,  ||  .|''|,\n  ||    ||..||  ||  ||..||\n  `|..' `|...  .||. `|...'\n                       || \n'||''|, .|''|, '||''|''||'\n ||  || ||  ||  ||     || \n ||..|' `|..|' .||.    `|.\n ||                       \n.||                       ")
    :setForeground(colors.blue)

local beginButton = sub[1]:addButton():setPosition(4, 15):setSize(20, 5)
    :setText("Proceed")
    :setBackground(colors.green)
    :setForeground(colors.white)

beginButton:onClick(function()
    openSubFrame(2)
end)

local phase1Title = sub[2]:addLabel():setPosition(6, 2)
    :setText("Set up Settings")
    :setForeground(colors.white)

local phase1IDTitle = sub[2]:addLabel():setPosition(2, 6)
    :setText("ID:")
    :setForeground(colors.white)

local phase1IDInfo = sub[2]:addLabel():setPosition(2, 7)
    :setText("If you are unsure,\ncontact the teleporter\nservice provider.")
    :setForeground(colors.white)

local phase1IDInput = sub[2]:addInput():setPosition(5, 6):setSize(3, 1)
    :setInputType("number")
    :setInputLimit(2)

local phase1ProceedButton = sub[2]:addButton():setPosition(4, 15):setSize(20, 5)
    :setText("Proceed")
    :setBackground(colors.green)
    :setForeground(colors.white)
    :hide()

phase1IDInput:onChar(function()
    phase1ProceedButton:show()
end)

phase1ProceedButton:onClick(function()
    openSubFrame(3)
    settings.set("myTeleID", tonumber(phase1IDInput:getValue()))
    settings.save("/teleporter/settings")
end)

local phase2Title = sub[3]:addLabel():setPosition(6, 2)
    :setText("You are all set!")
    :setForeground(colors.white)

local phase2ProceedButton = sub[3]:addButton():setPosition(4, 15):setSize(20, 5)
    :setText("Install")
    :setBackground(colors.green)
    :setForeground(colors.white)

phase2ProceedButton:onClick(function()
    shell.run("wget https://raw.githubusercontent.com/WANT-MORE-SOCKS/CC-Tweaked_Teleporter/master/client/teleUI.lua /teleporter/teleUI.lua")
    shell.run("wget https://raw.githubusercontent.com/WANT-MORE-SOCKS/CC-Tweaked_Teleporter/master/icons/icon.nfp /teleporter/teleUI.lua.nfp")
    openSubFrame(4)
end)

local exitButton = sub[4]:addButton():setPosition(4, 10):setSize(20, 5)
    :setText("Exit")
    :setBackground(colors.green)
    :setForeground(colors.white)

    exitButton:onClick(function()
        basalt.stopUpdate()
end)

basalt.autoUpdate()