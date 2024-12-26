-- @noindex

local scriptPath = ({reaper.get_action_context()})[2]:match('^.+[\\//]')
package.path = string.format('%s?.lua;', scriptPath)
local appName = "GlueRip"
local json = require('json')

function run()
    local selectedItems = getSelectedMediaItems() --Get Source Items
    local srcItemUid, srcTrack, srcPosData

    for i, item in pairs(selectedItems) do 
        _, srcItemUid = reaper.GetSetMediaItemInfo_String(item, "GUID", "", false)
        srcTrack = reaper.GetMediaItemTrack(item)
        srcPosData = getItemPosition(item)

        local xmlTable = nil
        local newItems = {}
        local posOffset, newPos
        _, xmlTable = reaper.GetProjExtState(0, appName, srcItemUid)
        if xmlTable ~= "" then 
            reaper.Undo_BeginBlock()
            xmlTable = json.decode(xmlTable)
            for x, srcXml in pairs(xmlTable) do 
                newItems[#newItems + 1] = reaper.AddMediaItemToTrack(srcTrack)
                local newItemGuid
                _, newItemGuid = reaper.GetSetMediaItemInfo_String(newItems[#newItems], "GUID", "", false)
                reaper.SetItemStateChunk(newItems[#newItems], srcXml, false)
                reaper.GetSetMediaItemInfo_String(newItems[#newItems], "GUID", newItemGuid, true)

                if x == 1 then posOffset = srcPosData[1] - getItemPosition(newItems[#newItems])[1] end

                newPos = reaper.GetMediaItemInfo_Value(newItems[#newItems], "D_POSITION") + posOffset
                reaper.SetMediaItemInfo_Value(newItems[#newItems], "D_POSITION", newPos)

            end
            reaper.DeleteTrackMediaItem(srcTrack, item)
            reaper.Undo_EndBlock("GlueRip: Rip Item "..srcItemUid, 0)
        end
    end
end

-- Helper Functions...................................................
------------------------------------------------------------------
-- table itemList, int numItems = getSelectedMediaItems()
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

getItemPosition = function(item)
    retTable = {}
    retTable[1] = reaper.GetMediaItemInfo_Value(item, 'D_POSITION')
    retTable[2] = reaper.GetMediaItemInfo_Value(item, 'D_LENGTH')
    retTable[3] = retTable[1] + retTable[2]
    return retTable
end

-- Script Routine...................................................
run()