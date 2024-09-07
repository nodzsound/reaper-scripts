-- @noindex
local scriptPath = ({reaper.get_action_context()})[2]:match('^.+[\\//]')
local memoryFile = scriptPath.."memory\\".."memory.txt"

function run()
    local exportData = ""
    local itemIdx = 1 --used in for-loop to set table idx
    local selectedItems, numItems = getSelectedMediaItems()

    if numItems == 0 then
        return
    end

    for i, item in pairs(selectedItems) do 
        local itemProperties = {}
        local activeTakeIdx = reaper.GetMediaItemInfo_Value(item, 'I_CURTAKE')
        local take = reaper.GetMediaItemTake(item, activeTakeIdx)

        exportData = exportData..tostring(itemIdx)..";" --Add item idx
        exportData = exportData..tostring(reaper.GetMediaItemInfo_Value(item, 'D_LENGTH'))..";"          --Add item length
        exportData = exportData..tostring(reaper.GetMediaItemTakeInfo_Value(take, 'D_PITCH'))..";"      --Add take pitch
        exportData = exportData..tostring(reaper.GetMediaItemTakeInfo_Value(take, 'D_PLAYRATE'))..";"   --Add take playrate
        exportData = exportData..tostring(reaper.GetMediaItemInfo_Value(item, 'D_FADEINLEN'))..";"       --Add item fade in len
        exportData = exportData..tostring(reaper.GetMediaItemInfo_Value(item, 'D_FADEINDIR'))..";"       --Add item fade in dir
        exportData = exportData..tostring(reaper.GetMediaItemInfo_Value(item, 'D_FADEINLEN_AUTO'))..";"  --Add item fade in len auto
        exportData = exportData..tostring(reaper.GetMediaItemInfo_Value(item, 'C_FADEINSHAPE'))..";"     --Add item fade in shape
        exportData = exportData..tostring(reaper.GetMediaItemInfo_Value(item, 'D_FADEOUTLEN'))..";"      --Add item fade out len
        exportData = exportData..tostring(reaper.GetMediaItemInfo_Value(item, 'D_FADEOUTDIR'))..";"  	--Add item fade out dir
        exportData = exportData..tostring(reaper.GetMediaItemInfo_Value(item, 'D_FADEOUTLEN_AUTO'))..";" --Add item fade out len auto
        exportData = exportData..tostring(reaper.GetMediaItemInfo_Value(item, 'C_FADEOUTSHAPE'))..";"    --Add item fade out shape

        itemIdx = itemIdx + 1
    end

    local mem = io.open(memoryFile, "w")
    if mem then 
        mem:write(exportData)
        mem:close()
    else
        reaper.ShowConsoleMsg("ERROR: Could not write to memory")
    end
end


-- Helper Functions...................................................
------------------------------------------------------------------
-- table itemList, int numItems = sonuReaAccess.getSelectedItems()
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

-- Script Routine...................................................
run()

