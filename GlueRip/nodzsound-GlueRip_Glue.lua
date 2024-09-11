-- @noindex

local scriptPath = ({reaper.get_action_context()})[2]:match('^.+[\\//]')

function run()
    local selectedItems = getSelectedMediaItems()
    local trackItemRelationTbl = buildItemTrackRelationTable(selectedItems)

    for _, trackItems in  pairs(trackItemRelationTbl) do
        if #trackItems < 2 then continue end
        
    end
end

-- Helper Functions...................................................
------------------------------------------------------------------
-- table itemList, int numItems = getSelectedItems()
-- Returns all selected items that are in the current project 
-- and the amount of said items. 
function getSelectedMediaItems()
    local numItems = reaper.CountSelectedMediaItems(0)
	local retTable = {}
	for i = 0, numItems - 1 do
    	retTable[i + 1] = reaper.GetSelectedMediaItem(0, i)
  	end
  	return retTable, numItems
end 

function buildItemTrackRelationTable(itemList)
    local retTable = {}
    for i, item in pairs(itemList) do 
        local track = reaper.GetMediaItemInfo_Value(item, 'P_TRACK')
        local trackNumberStr = tostring(reaper.GetMediaTrackInfo_Value(track, 'IP_TRACKNUMBER'))

        if retTable[trackNumberStr] == nil then
            retTable[trackNumberStr] = {}
        end
        table.insert(retTable[trackNumberStr], item)
    end
    return retTable
end
-- Script Routine...................................................
run()