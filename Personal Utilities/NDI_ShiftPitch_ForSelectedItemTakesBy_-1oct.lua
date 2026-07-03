--[[
  * ReaScript Name: Shift the pitch of all selected items up by 1ct
  * Description: Shift the pitch of all selected items up by 1ct
  * Instructions: Select all items to be shifted and run.
  * Author: Nico Dilz
  * Author URI: http://www.nico-dilz.com
  * Licence: GPL v3
  * Reaper 6.0
  * Extensions: None 
  * Version 1.0
--]]

-- User Variables ------------------------------------

shiftValue = -12.0     --Set to Float. 0.0 = no change, +/- 0.1 = 10 cents change, +/- 0.01 = 1 cent change --
-- FUNCTIONS -----------------------------------------

-- MAIN PROCESS -----------------------------------------

numSelectedItems = reaper.CountSelectedMediaItems(0)


if numSelectedItems > 0 then
  for i = 0, numSelectedItems - 1 do
      reaper.Undo_BeginBlock()
      currentItem = reaper.GetSelectedMediaItem(0, i)
      currentTake = reaper.GetActiveTake(currentItem)
      currentPitch = reaper.GetMediaItemTakeInfo_Value(currentTake, "D_PITCH")
      newPitch = currentPitch + shiftValue
      reaper.SetMediaItemTakeInfo_Value(currentTake, "D_PITCH", newPitch)
      reaper.Undo_BeginBlock("Shift Take Pitch", -1)
  end 
end
