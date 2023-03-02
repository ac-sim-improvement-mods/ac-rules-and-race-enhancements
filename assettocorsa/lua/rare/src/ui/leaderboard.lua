local leaderboard = {}

--- Override function to add clarity and default values for drawing text
local function drawText(textdraw)
    if not textdraw.margin then
        textdraw.margin = vec2(350, 350)
    end
    if not textdraw.color then
        textdraw.color = rgbm(0.95, 0.95, 0.95, 1)
    end
    if not textdraw.fontSize then
        textdraw.fontSize = 70
    end

    ui.setCursorX(textdraw.xPos)
    ui.setCursorY(textdraw.yPos)
    ui.dwriteTextAligned(textdraw.string, textdraw.fontSize, textdraw.xAlign, textdraw.yAlign, textdraw.margin, false, textdraw.color)
end

function drawF1Leaderboard()
    ui.childWindow('test',vec2(400,400),false,ui.WindowFlags.NoBackground,function ()
        -- ui.drawImage('/assets/leaderboard/6.png',vec2(0,0),vec2(200,200),true,vec2(0,0),vec2(1,1))
    end)

end

return leaderboard