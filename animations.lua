-------------------------------------------------
------------ EDITED BY Beyonder#0711 ------------
-------------------------------------------------
-------------- metascripts.org-------------------
-------------------------------------------------


-------------------------
-- İmportant Functions
-------------------------
local sx,sy = guiGetScreenSize()

function debug(msg,type,r,g,b)
    outputDebugString(getResourceName(getThisResource()).." : - "..msg,type,r,g,b)
end
function relativeto(x1,x2)
    return sx *x1, sy*x2
end
function torelative(x1,x2)
    return x1/sx,x2/sy
end
function hex2rgb(hex) --Hex to R,G,B
    hex = hex:gsub("#","")
    return tonumber("0x"..hex:sub(1,2)), tonumber("0x"..hex:sub(3,4)), tonumber("0x"..hex:sub(5,6))
end

-------------------------------------------
--GUI Animations
-------------------------------------------
local animations = {}
local anim_timers = {}
--Gui moving animation
function guiMoveTo(elm,movex,movey,relative,easing,duration,waiting)
    local x,y = guiGetPosition(elm,relative)
    local tick  = getTickCount()
    if waiting then
        table.insert(anim_timers,{
            elm = elm,
            timer = setTimer(function(elm,startx,starty,movex,movey,relative,easing,duration)
                table.insert(animations,{anim_type="moving",elm=elm,startx=x,starty=y,movex=movex,movey=movey,relative=relative,oldTick=tick,easing=easing,duration=duration})
            end,waiting,1,elm,x,y,movex,movey,relative,easing,duration)
        })
    else
        table.insert(animations,{anim_type="moving",elm=elm,startx=x,starty=y,movex=movex,movey=movey,relative=relative,oldTick=tick,easing=easing,duration=duration})
    end
end
--Gui Alpha animation
function guiAlphaTo(elm,movealpha,easing,duration,waiting)
    local startalpha = guiGetAlpha(elm)
    local tick  = getTickCount()

    if waiting then
        table.insert(anim_timers,{
            elm = elm,
            timer = setTimer(function(elm,startalpha,movealpha,easing,duration)
                table.insert(animations,{anim_type="alpha",elm=elm,startalpha=startalpha,movealpha=movealpha,oldTick=tick,easing=easing,duration=duration})
            end,waiting,1,elm,startalpha,movealpha,easing,duration)
        })
    else
        table.insert(animations,{anim_type="alpha",elm=elm,startalpha=startalpha,movealpha=movealpha,oldTick=tick,easing=easing,duration=duration})
    end
end
--Gui sizing animation
function guiSizeTo(elm,sizew,sizeh,relative,easing,duration,waiting)
    local w,h = guiGetSize(elm,relative)
    local tick  = getTickCount()

    if waiting then
        table.insert(anim_timers,{
            elm = elm,
            timer = setTimer(function(elm,w,h,sizew,sizeh,relative,easing,duration)
                table.insert(animations,{anim_type="sizing",elm=elm,startw=w,starth=h,sizew=sizew,sizeh=sizeh,relative=relative,oldTick=tick,easing=easing,duration=duration})
            end,waiting,1,elm,w,h,sizew,sizeh,relative,easing,duration)
        })
    else
        table.insert(animations,{anim_type="sizing",elm=elm,startw=w,starth=h,sizew=sizew,sizeh=sizeh,relative=relative,oldTick=tick,easing=easing,duration=duration})
    end
end


function guiStopAniming(elm)
    for k,v in ipairs(anim_timers) do 
        if v.elm == elm then 
            if isTimer(v.timer) then 
                killTimer(v.timer)
            end
            table.remove(anim_timers,k)
        end
    end
    for index,animt in ipairs(animations) do 
        if animt.elm == elm then
            table.remove(animations,index)
        end 
    end
end

function setAnimRender()
    local nowTick = getTickCount()
    for index,animt in ipairs(animations) do 
        if animt.anim_type == "moving" then 
            if animt.relative then
                local startx,starty = relativeto(animt.startx,animt.starty)
                local movex,movey =  relativeto(animt.movex,animt.movey)
                movex,movey = interpolateBetween(startx,starty,0,movex,movey,0,(nowTick-animt.oldTick)/animt.duration,animt.easing)
                movex,movey = torelative(movex,movey)
                guiSetPosition(animt.elm,movex,movey,animt.relative) 
                if nowTick-animt.oldTick  > animt.duration then  table.remove(animations,index) end
            else
                local movex,movey = interpolateBetween(animt.startx,animt.starty,0,animt.movex,animt.movey,0,(nowTick-animt.oldTick)/animt.duration,animt.easing)
                guiSetPosition(animt.elm,movex,movey,animt.relative)
                if nowTick-animt.oldTick  > animt.duration then  table.remove(animations,index)  end
            end
        end
        if animt.anim_type == "alpha" then 
            local movealpha= interpolateBetween(animt.startalpha,0,0,animt.movealpha,0,0,(nowTick-animt.oldTick)/animt.duration,animt.easing)
            guiSetAlpha(animt.elm,movealpha)
            if nowTick-animt.oldTick  > animt.duration then  table.remove(animations,index)  end
        end
        
        if animt.anim_type == "sizing" then 
            if animt.relative then
                local startw,starth = relativeto(animt.startw,animt.starth)
                local sizew,sizeh =  relativeto(animt.sizew,animt.sizeh)
                sizew,sizeh = interpolateBetween(startw,starth,0,sizew,sizeh,0,(nowTick-animt.oldTick)/animt.duration,animt.easing)
                sizew,sizeh = torelative(sizew,sizeh)
                guiSetSize(animt.elm,sizew,sizeh,animt.relative) 
                if nowTick-animt.oldTick  > animt.duration then  table.remove(animations,index) end
            else
                local movew,moveh = interpolateBetween(animt.startw,animt.starth,0,animt.sizew,animt.sizeh,0,(nowTick-animt.oldTick)/animt.duration,animt.easing)
                guiSetSize(animt.elm,sizew,sizeh,animt.relative)
                if nowTick-animt.oldTick  > animt.duration then  table.remove(animations,index)  end
            end
        end
    end
end
addEventHandler("onClientRender",root,setAnimRender)

---Custom Anims
--------------------------------------------------
--gui Alert Animation ( - gui uyarı animasyonu - )
---------------------------------------------------
function guiAlertAnim(element,relative)
    if not element then return end
    local elm_x,elm_y = guiGetPosition(element,relative)
    local elm_w,elm_h = guiGetSize(element,relative)
    local move_result = 0
    if relative then 
        move_result =  0.01
    else
        move_result = 10
    end
    guiMoveTo(element,elm_x-move_result,elm_y,relative,"SineCurve",500)
    guiMoveTo(element,elm_x+move_result,elm_y,relative,"SineCurve",500,50)
    guiMoveTo(element,elm_x-move_result,elm_y,relative,"SineCurve",500,100)
    guiMoveTo(element,elm_x+move_result,elm_y,relative,"SineCurve",500,150)
    guiMoveTo(element,elm_x-move_result,elm_y,relative,"SineCurve",500,200)
    guiMoveTo(element,elm_x+move_result,elm_y,relative,"SineCurve",500,250)
    guiMoveTo(element,elm_x-move_result,elm_y,relative,"SineCurve",500,300)
    guiMoveTo(element,elm_x+move_result,elm_y,relative,"SineCurve",500,350)
    guiMoveTo(element,elm_x-move_result,elm_y,relative,"SineCurve",500,400)
    guiMoveTo(element,elm_x,elm_y,relative,"SineCurve",500,450)
    setTimer(function(element,elm_x,elm_y,relative,elm_w,elm_h)
        guiStopAniming(element)
        guiSetPosition(element,elm_x,elm_y,relative)
        guiSetSize(element,elm_w,elm_h,relative)
    end,650,2,element,elm_x,elm_y,relative,elm_w,elm_h)
end


----------------------------------
--Elements Tooltip
-----------------------------------
local tooltip_elements = {}
background = guiCreateGridList(0,0,190,100,false)
local label = guiCreateLabel(0,20,190,100,"asdasd",false,background)
--guiSetEnabled(label,false)
guiSetProperty(label,"DisabledTextColour","FFFFFFFF")
-- guiSetProperty(background,"AlwaysOnTop","True")
guiSetProperty(label,"AlwaysOnTop","True")
guiLabelSetHorizontalAlign(label,"left")
guiLabelSetVerticalAlign(label,"top")
status_tooltip = false
guiSetVisible(background,false)

addEventHandler( "onClientMouseEnter",root, function(aX, aY)
    if tooltip_elements[source] then 
        if not status_tooltip then 
            local aX,aY = getCursorPosition()
            aX,aY = relativeto(aX,aY)
            guiBringToFront(background)
            guiSetText(label,tooltip_elements[source][1])
            guiSetVisible(background,true)
            local _,piece = string.gsub(tooltip_elements[source][1], "\n", "")
            if tooltip_elements[source][2] then 
                guiLabelSetColor(label,hex2rgb(tooltip_elements[source][2]))
            end
            guiSetSize(label,190,(15+(piece*15)),false)
            guiSetSize(background,140,(55+(piece*7.2)),false)
            guiSetPosition(background,aX+45,aY-50,false)
            guiSetPosition(label,10,10,false)
            status_tooltip = true    
        end
    end
end)

addEventHandler( "onClientMouseLeave", root, function()
    if status_tooltip then 
        guiSetText(label,"")
        guiLabelSetColor(label,255,255,255)
        status_tooltip = false
        guiSetVisible(background,false)
    end
end)

function guiAddTooltip(elm,text,color)
    tooltip_elements[elm] = {text,color or false}
end
