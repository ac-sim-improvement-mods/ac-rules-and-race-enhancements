local popup = {}

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

local function drawRaceControl(text)
    local scale = F1RegsConfig.data.NOTIFICATIONS.SCALE

    ui.pushDWriteFont("Formula1 Display;Weight=Bold")
    --ui.pushDWriteFont("Formula1 Display Bold Bold:fonts/f1.ttf")

    local xOffset = -1090
    local yOffset = -220
    local xAlign = 600
    local yAlign = 50
    local fontSize = 250
    local bannerHeight = 760
    local leftBannerWidth = 2880
    local rightBannerWidth = (ui.measureDWriteText(text,30).x * 1.5) + 5

    local darkBlueColor = rgbm(0.07, 0.12, 0.23, 1)
    local whiteColor = rgbm(1,1,1,1)

    ui.beginScale()
    -- Race Control dark blue rect
    ui.drawRectFilled(
        vec2(xOffset,yOffset),
        vec2(leftBannerWidth,bannerHeight),
        darkBlueColor
    )

    -- -- Information white rect
    -- ui.drawRectFilled(
    --     vec2(299+ xOffset+leftBannerWidth,yOffset),
    --     vec2(leftBannerWidth+rightBannerWidth,bannerHeight),
    --     whiteColor
    -- )

    ui.beginScale()
    drawText{
        string = "RACE",
        fontSize = fontSize,
        xPos = xAlign,
        yPos = yAlign,
        xAlign = ui.Alignment.Start,
        yAlign = ui.Alignment.Center,
        color = whiteColor,
        margin = vec2(20000, 250)
    }

    drawText{
        string = "CONTROL",
        fontSize = fontSize,
        xPos = xAlign,
        yPos = yAlign + 250,
        xAlign = ui.Alignment.Start,
        yAlign = ui.Alignment.Center,
        color = whiteColor,
        margin = vec2(20000, 250)
    }
    ui.endScale(1.5)

    drawText{
        string = text,
        fontSize = 275,
        xPos = 2000 + rightBannerWidth/2,
        yPos = yAlign + 19,
        xAlign = ui.Alignment.Center,
        yAlign = ui.Alignment.Center,
        color = whiteColor,
        margin = vec2(20000, 250)
    }

    ui.beginScale()
    local pos_x = xOffset + 125
    local pos_y = yOffset + 100
    local size_x = pos_x + 1168
    local size_y = pos_y + 800

    ui.drawImage("assets/icons/fia_logo.png", vec2(pos_x,pos_y), vec2(size_x,size_y), rgbm(1,1,1,1), true)
    ui.endScale(0.9)
    ui.endScale(scale)

    ui.popDWriteFont()
end

local function drawNotification()
    drawRaceControl(NOTIFICATION_TEXT)
  end
  
local fadingTimer = ui.FadingElement(drawNotification,false)
  
function popup.notification(text,timer)
      if not timer then
          timer = F1RegsConfig.data.NOTIFICATIONS.DURATION
      end
  
      NOTIFICATION_TIMER = timer
      NOTIFICATION_TEXT = text
end

function notificationHandler(dt)
    local timer = NOTIFICATION_TIMER
    timer = timer - dt
    NOTIFICATION_TIMER = timer
    -- fadingTimer(timer > 0 and timer < 60)
    fadingTimer(true)

    NOTIFICATION_TEXT = "RACE CONTROL BANNER"

    drawRaceControl(NOTIFICATION_TEXT)
end

return popup