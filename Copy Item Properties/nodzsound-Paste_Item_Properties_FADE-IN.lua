-- @noindex
local scriptPath = ({reaper.get_action_context()})[2]:match('^.+[\\//]')
local memoryFile = scriptPath.."memory\\".."memory.txt"
local itemPropertyList = {
    "length",
    "pitch",
    "playrate",
    "fadeinlen",
    "fadeindir",
    "fadeinlenauto",
    "fadeinshape",
    "fadeoutlen",
    "fadeoutdir",
    "fadeoutlenauto",
    "fadeoutshape"
}

function run()
    local importData = ""

    local mem = io.open(memoryFile,"r")
    if mem then
        importData = mem:read("*a")
        mem:close()
    else
        reaper.ShowConsoleMsg("ERROR: Could not read from memory")
        return
    end

    local itemProperties = buildPropertyTable(importData)
    local selectedItems = getSelectedMediaItems()
    local subCounter = 0

    for i, item in pairs(selectedItems) do
        local activeTakeIdx = reaper.GetMediaItemInfo_Value(item, 'I_CURTAKE')
        local take = reaper.GetMediaItemTake(item, activeTakeIdx)
        local propSource = itemProperties[i -(#itemProperties * subCounter)]

        reaper.SetMediaItemInfo_Value(item, 'D_FADEINLEN', propSource.fadeinlen)
        reaper.SetMediaItemInfo_Value(item, 'D_FADEINDIR', propSource.fadeindir)
        reaper.SetMediaItemInfo_Value(item, 'D_FADEINLEN_AUTO', propSource.fadeinlenauto)
        reaper.SetMediaItemInfo_Value(item, 'D_FADEINSHAPE', propSource.fadeinshape)

        if i % #itemProperties == 0 then 
            subCounter = subCounter + 1
        end
    end
    reaper.UpdateArrange()
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

------------------------------------------------------------------
-- table propTable = buildPropertyTable(input)
-- @input: A string that contains the copied item properties.
-- Returns a table that contains all item properties of all copied items.
function buildPropertyTable(input)
    local retTable = {}
    local inputLength = string.len(input)
    local semiIdx = 1
    local lastSemiIdx = 1
    local propertyIdx = 0
    local itemIdx = 0

    while semiIdx < inputLength do
        semiIdx = string.find(input,";",semiIdx + 1) 

        if propertyIdx ~= 0 then
            local itemProps = retTable[itemIdx]
            itemProps[itemPropertyList[propertyIdx]] = tonumber(string.sub(input, lastSemiIdx+1,semiIdx-1))
        else
            itemIdx = itemIdx + 1
            retTable[itemIdx] = {}
        end
        propertyIdx = propertyIdx + 1 
        if propertyIdx > #itemPropertyList then
            propertyIdx = 0
        end
        lastSemiIdx = semiIdx
    end
    return retTable
end

-- Script Routine...................................................
run()

