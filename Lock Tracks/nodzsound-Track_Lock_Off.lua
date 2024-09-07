-- @noindex
local scriptPath = ({reaper.get_action_context()})[2]:match('^.+[\\//]')

function run()
    local trackList = getSelectedTracks()

    for i, track in pairs(trackList) do
        local retval, rppxml = reaper.GetTrackStateChunk(track, "", false)
        if string.find(rppxml, "LOCK 1") then
            rppxml = string.gsub(rppxml, "LOCK 1", "")
        end
        reaper.SetTrackStateChunk(track, rppxml, false)
    end
end

-- Helper Functions...................................................
-- table trackList, int numTracks = getSelectedTracks()
-- Returns all selected tracks that are in the current project 
-- and the amount of said tracks. 
function getSelectedTracks()
    local numTracks = reaper.CountSelectedTracks(0)
	local retTable = {}
	for i = 0, numTracks - 1 do
    	retTable[i + 1] = reaper.GetSelectedTrack(0, i)
  	end
  	return retTable, numTracks
end 

-- Script Routine...................................................
run()