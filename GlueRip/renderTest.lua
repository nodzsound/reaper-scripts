-- @noindex

local scriptPath = ({reaper.get_action_context()})[2]:match('^.+[\\//]')

function run()
    local sourceFileName =""
    local targetFileName = "CuteRenderedFile"
    local startPercent = 0
    local endPercent = 100
    local playRate = reaper.Master_GetPlayRate()

    reaper.RenderFileSelection(sourceFileName, targetFileName, startPercent, endPercent, playRate)
end
run()