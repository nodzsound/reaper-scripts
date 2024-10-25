-- @noindex

local scriptPath = ({reaper.get_action_context()})[2]:match('^.+[\\//]')

function run()
    local selectedItems = getSelectedMediaItems() --Get Source Items
    local sourceItemDataByTrack = {}
    local consolidatedData = {}
    local trackIdx, itemsInArray, itemXml, itemUid

    for _, item in pairs(selectedItems) do 
        trackIdx = tostring(getTrackIdxFromItem(item))
        if sourceItemDataByTrack[trackIdx] == nil then
            sourceItemDataByTrack[trackIdx] = {}
        end
        _, itemXml = reaper.GetItemStateChunk(item, "", false) 
        itemsInArray = #sourceItemDataByTrack[trackIdx]
        sourceItemDataByTrack[trackIdx][itemsInArray + 1] = itemXml  
    end 
    reaper.Main_OnCommand(40362)
    selectedItems = getSelectedMediaItems()
    for _, item in pairs(selectedItems) do 
        trackIdx = getTrackIdxFromItem(item)
        _, itemUid = reaper.GetSetMediaItemInfo_String(item, "GUID", "", false)
        --SetItemStateChunk
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

function getTrackIdxFromItem(srcItem) 
    local track = reaper.GetMediaItemTrack(srcItem)
    return reaper.GetMediaTrackInfo_Value(track, "IP_TRACKNUMBER")
end

function getItemData(srcItems)
    local retTableXml = {}
    local retTableUid = {}
    local uidCounter = 1
    local itemUid, itemXml

    for _, item in pairs(selItems) do
        b, itemUid = reaper.GetSetMediaItemInfo_String(item, "GUID", "", false)
        b, itemXml = reaper.GetItemStateChunk(item, "", false)
        retTable[itemUid] = itemXml
    end
    return retTableUid, retTableXml
end

-- Script Routine...................................................
run()