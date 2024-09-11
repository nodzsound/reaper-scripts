-- @noindex

local scriptPath = ({reaper.get_action_context()})[2]:match('^.+[\\//]')

function run()
    local selectedItems = getSelectedMediaItems()
    
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

-- Script Routine...................................................
run()