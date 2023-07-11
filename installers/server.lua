--TELEPORTER SERVER INSTALLER v1.0

term.setTextColor(colors.yellow)

local installThese = {
    "wget https://raw.githubusercontent.com/WANT-MORE-SOCKS/CC-Tweaked_Teleporter/master/server/startup.lua /startup.lua",
    "wget https://raw.githubusercontent.com/WANT-MORE-SOCKS/CC-Tweaked_Teleporter/master/server/listener.lua /teleporter/listener.lua",
    "wget https://raw.githubusercontent.com/WANT-MORE-SOCKS/CC-Tweaked_Teleporter/master/server/teleporter.lua /teleporter/teleporter.lua"
}

local function installThem()
    for _, i in pairs(installThese) do
        shell.run(i)
    end
end

if fs.exists("/teleporter") then
    print("Do you wish to re-install the software? [y/n]")
    if string.lower(read()) == "y" then
        settings.load("/teleporter/settings")
        shell.run("rm /teleporter")
        installThem()
    end
else installThem() end

if fs.exists("/teleporter/settings") then
    print("Do you wish to overwrite pre-existing settings? [y/n]")
    if string.lower(read()) ~= "y" then
        print("Installation complete")
        error()
    end
end
print("A young teleporter stands in it's installer")
print("What will the name of this young teleporter be?")
print(">Enter hostname. (Any characters, keep it brief-esque.)")
local hostName = read()
settings.set("hostName", hostName)
print("Your name is "..hostName..". Now tell me, what dimension does this "..hostName.." live in?")
print("(Type in \"overworld\", \"nether\" or \"end\")")
while true do
    local dimension = string.lower(read())
    if dimension == "overworld" then
        settings.set("dimension", "teleDimOver")
        break
    elseif dimension == "nether" then
        settings.set("dimension", "teleDimNeth")
        break
    elseif dimension == "end" then
        settings.set("dimension", "teleDimEnd")
        break
    else
        print("Try again, smartass.")
        print("failed answer: "..dimension)
    end
end
settings.save("teleporter/settings")
print("Installation complete")