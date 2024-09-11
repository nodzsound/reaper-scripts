-- @noindex

local scriptPath = ({reaper.get_action_context()})[2]:match('^.+[\\//]')
local memoryFile = scriptPath.."memory\\".."memory.txt"

function run()
    file = io.open(scriptPath.."testfile.txt", "w")
    file:write("Hello World")
    file:close()

    local track = reaper.GetSelectedTrack(0,0)
    local retval, rppxml = reaper.GetTrackStateChunk(track, "", false)
    rppxml = string.gsub(rppxml, "VOLPAN", "GLUERIP 157351\nVOLPAN")
    reaper.ShowConsoleMsg(rppxml)
    reaper.SetTrackStateChunk(track, rppxml, false)
    retval, rppxml = reaper.GetTrackStateChunk(track, "", false)
    reaper.ShowConsoleMsg(rppxml)
end

run()