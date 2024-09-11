-- @noindex

local scriptPath = ({reaper.get_action_context()})[2]:match('^.+[\\//]')
local memoryFile = scriptPath.."memory\\".."memory.txt"

function run()
    file = io.open(scriptPath.."testfile.txt", "w")
    file:write("Hello World")
    file:close()

    local track = reaper.GetSelectedTrack(0,0)
    reaper.SetProjExtState(0, "nodzsound-GlueRip", "TestVar: ", "DUBjajajaj,1234-;IDU")
    local reval, value = reaper.GetProjExtState(0, "nodzsound-GlueRip", "TestVar: ")
    reaper.ShowConsoleMsg(value)
end

run()