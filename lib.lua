genelGuiTablo,scriptler,tabciklar = {},{},{}
gui = {
	["w"]={},
	["b"]={},
	["g"]={},
	["m"]={},
	["e"]={},
	["t"]={},
	["guilist"]={},
}
sx,sy = guiGetScreenSize()


font1 = guiCreateFont("dosyalar/Font1.ttf",12)
font2 = guiCreateFont("dosyalar/Font1.ttf",13)

_guiCreateButton = guiCreateButton
_guiCreateWindow = guiCreateWindow
_guiCreateEdit = guiCreateEdit
_guiCreateMemo = guiCreateMemo
_guiCreateGridList = guiCreateGridList
_guiGetPosition = guiGetPosition
_guiSetPosition = guiSetPosition
_guiGetSize = guiGetSize
_guiSetSize = guiSetSize
_guiSetText = guiSetText
_guiGetText = guiGetText
_guiSetEnabled = guiSetEnabled
_guiSetVisible = guiSetVisible
_destroyElement = destroyElement
_guiWindowSetSizable = guiWindowSetSizable
_guiWindowSetMovable = guiWindowSetMovable
_guiWindowIsMovable = guiWindowIsMovable

sourceResource = getThisResource()

function resimOlustur(isim,a)
	if fileExists(isim..".png") then return isim..".png" end
	local texture = dxCreateTexture(1,1) 
	local pixels = dxGetTexturePixels(texture) 
	local r,g,b,a = 255,255,255,a or 255 
	dxSetPixelColor(pixels,0,0,r,g,b,a) 
	dxSetTexturePixels(texture, pixels) 
	local pxl = dxConvertPixels(dxGetTexturePixels(texture),"png") 
	local nImg = fileCreate(isim..".png") 
	fileWrite(nImg,pxl) 
	fileClose(nImg)
	return isim..".png" 
end
bosresim = resimOlustur("test") -- silme
a150 = resimOlustur("a150",150)
a0 = resimOlustur("a0",0)
function renkVer(resim,hex)
	guiSetProperty(resim,"ImageColours","tl:FF"..hex.." tr:FF"..hex.." bl:FF"..hex.." br:FF"..hex)
end
function getParentSize(parent)
	local px,pu=sx,sy
	if parent then px,pu=guiGetSize(parent,false) end
	return px,pu
end
function createSideLine(x,y,g,u,parent,hex)
	local side = guiCreateStaticImage(x,y,g,u,bosresim,false,parent)
	renkVer(side,hex)
	guiSetProperty(side, "AlwaysOnTop", "True") guiSetAlpha(side, 0.4)
	return side
end
function getGuiElement(elm)
	local indeks = genelGuiTablo[elm]
	if tabciklar[elm] then return tabciklar[elm] end
	return (indeks and indeks.t and gui[indeks.t][indeks.i]) or indeks
end

addEventHandler("onClientResourceStop", root, function(sc)
	if scriptler[sc] and sc ~= getThisResource() then
		for tablo,v in pairs(scriptler[sc]) do
			for a,s in pairs(v) do 
				local sira,element = unpack(s)
				if isElement(element) then _destroyElement(element) end
				if gui[tablo][sira] then gui[tablo][sira]= nil end
			end	
		end
		scriptler[sc] = nil
	end
end)

--edit,gridlst,buton,memo mouse
function kenarAlpha()
	local sira = getGuiElement(source)
	if sira then
		if sira.kenarlar then
			for i,v in pairs(sira.kenarlar) do
				guiSetAlpha(v,eventName=="onClientMouseEnter"and 1 or 0.4)
			end	
		end	
		if sira.isClose then guiSetAlpha(gui["w"][sira.i].kapatArka, eventName == "onClientMouseEnter" and 1 or 0.5) end
	end
	local t = tabciklar[source]
	if t and t.label then
		if not gui[t.t][t.pi].tabciklar[t.i].secili then
			guiSetAlpha(gui[t.t][t.pi].tabciklar[t.i].arka,eventName=="onClientMouseEnter" and 0.6 or 0.7)
			renkVer(gui[t.t][t.pi].tabciklar[t.i].arka,eventName=="onClientMouseEnter" and gui[t.t][t.pi].tabciklar[t.i].alanrenk or "000000")
		end
	end
end
addEventHandler("onClientMouseEnter", resourceRoot, kenarAlpha)
addEventHandler("onClientMouseLeave", resourceRoot, kenarAlpha)


addEventHandler("onClientGUIClick", resourceRoot, function()
	local sira = getGuiElement(source)
	if sira and sira.isClose then 
		guiSetVisible(gui["w"][sira.i].resim, false)
		showCursor(false)
		triggerEvent("MahLib:PencereKapatıldı",gui["w"][sira.i].resim)
	end
end)

--basinca olan ufalma ve panel taşıma
local clickedButton,clickedWindow = nil,nil
function MouseDown(btn, x, y)
	local sira = getGuiElement(source)
	if sira then
		if sira.isButton then
			if clickedButton then return end
			local g,u = guiGetSize(source, false)
			local x,y = guiGetPosition(source, false)
			clickedButton = {source,g,u,x,y}
			guiSetPosition(source, x+2,y+2, false)
			guiSetSize(source, g-4,u-4, false)
		end
		if btn == "left" and sira.isHeader and gui["w"][sira.i].move then
			clickedWindow = gui["w"][sira.i].resim
			local ex,ey = _guiGetPosition( clickedWindow, false )
			offsetPos = { x - ex, y - ey };
			addEventHandler( "onClientCursorMove",root,cursorMove)
		end	
	end
end
function MouseUp(btn, x, y)
	if clickedButton then
		local g,u = guiGetSize(clickedButton[1],false)
		local x,y = guiGetPosition(clickedButton[1],false)
		guiSetPosition(clickedButton[1],clickedButton[4],clickedButton[5],false)
		guiSetSize(clickedButton[1],clickedButton[2],clickedButton[3],false)
		clickedButton = nil
	end	
	if btn == "left" and clickedWindow then
		clickedWindow = nil
		removeEventHandler( "onClientCursorMove",root,cursorMove)
	end
end
addEventHandler("onClientGUIMouseUp", resourceRoot,MouseUp)
addEventHandler("onClientGUIMouseDown", resourceRoot,MouseDown) 
addEventHandler("onClientClick", root, function(button, state, _, _, _, _, _, tiklanan)
	if state == "up" and clickedButton then
		MouseUp()
	end	
end)
function cursorMove(_, _, x, y)
	if clickedWindow then
		_guiSetPosition(clickedWindow,x-offsetPos[ 1 ],y-offsetPos[ 2 ], false )
	end
end



--diğer funclar
function guiGetPosition(element,relative)
	local t = getGuiElement(element)
	return _guiGetPosition((t and t.resim) or (element), relative)
end
function guiSetPosition(element,x,y,relative)
	local t = getGuiElement(element)
	return _guiSetPosition((t and t.resim) or (element), x,y,relative)
end
function guiGetSize(element,relative)
	local t = getGuiElement(element)
	return _guiGetSize((t and t.resim) or (element), relative)
end
function guiSetSize(element,g,u,relative)
	local sira = getGuiElement(element)
	if sira then
		_guiSetSize(sira.resim, g,u, relative)
		if sira.label then
			_guiSetSize(sira.label, g,u, relative)
			guiLabelSetHorizontalAlign(sira.label, "center") guiLabelSetVerticalAlign(sira.label, "center")
		end	
		if sira.basarka then _guiSetSize(sira.basarka, g,20, false) end
		if sira.kapatArka then _guiSetSize(sira.kapatArka, g-25,1, false) end
		koseleriAyarla(sira,g,u)
	else
		return _guiSetSize(element,g,u,relative)
	end	
end	

function koseleriAyarla(t,g,u)
	-- üst çizgi
	local g,u = _guiGetSize(t.resim,false)
	if t.kenarlar.ortaUst then
		_guiSetSize(t.kenarlar.ortaUst, g,1, false)
		_guiSetPosition(t.kenarlar.ortaUst,0,0,false)	
	end
	-- alt çizgi
	_guiSetSize(t.kenarlar.ortaAlt, g,1, false)
	_guiSetPosition(t.kenarlar.ortaAlt,0,u-1,false)	
	-- sol çizgi 
	_guiSetSize(t.kenarlar.sol, 1,u, false)
	-- sag çizgi
	_guiSetPosition(t.kenarlar.sag,g-1,0,false)
	_guiSetSize(t.kenarlar.sag, 1,u, false)
end	

function guiSetText(element, yazi)
	local sira = getGuiElement(element)
	if sira then 
		if sira.basarka and sira.label then
			_guiSetText(sira.label, yazi)
			guiLabelSetHorizontalAlign(sira.label, "center") guiLabelSetVerticalAlign(sira.label, "center")
			return
		end	
		if sira.pi then -- tab
			local yuzunluk = string.len(yazi)*8
			local tsira = gui["t"][sira.pi].tabciklar[sira.i]
			_guiSetSize(tsira.arka,yuzunluk,20,false)
			_guiSetSize(tsira.kose,yuzunluk,1,false)
			_guiSetSize(tsira.yazi,yuzunluk,20,false)
			_guiSetText(tsira.yazi,yazi)
			guiLabelSetHorizontalAlign(tsira.yazi, "center")
			guiLabelSetVerticalAlign(tsira.yazi, "center")
			for i=sira.i+1,#gui["t"][sira.pi].tabciklar do
				local ox,oy = _guiGetPosition(gui["t"][sira.pi].tabciklar[i-1].arka,false) 
				local og,op = _guiGetSize(gui["t"][sira.pi].tabciklar[i-1].arka,false)
				_guiSetPosition(gui["t"][sira.pi].tabciklar[i].arka,(ox+og),0,false)
			end
			return
		end	
		_guiSetText(element, yazi)
	else
		return _guiSetText(element, yazi)
	end
end
function guiGetText(element)
	local sira = getGuiElement(element)
	return _guiGetText(sira and (sira.pi and gui["t"][sira.pi].tabciklar[sira.i].yazi or (sira.label or element)) or (element))
end
function guiSetEnabled(element, bool)
	local sira = getGuiElement(element)
	if sira then
		local elm = (sira.pi and gui["t"][sira.pi].tabciklar[sira.i].arka or sira.resim or sira.label)
		guiSetAlpha(elm,bool and 1 or 0.5)
		return _guiSetEnabled(elm, bool)
	else
		return _guiSetEnabled(element, bool)
	end	
end
function guiSetVisible(element, bool)
	local sira = getGuiElement(element)
	return _guiSetVisible(sira and (sira.pi and gui["t"][sira.pi].tabciklar[sira.i].arka or sira.resim) or (element),bool)
end

function destroyElement(element)
	local tip = getElementType(element)
	if tip:find("gui-") then
		local sira = genelGuiTablo[element]
		if sira and sira.t then
			_destroyElement(gui[sira.t][sira.i].resim)
			gui[sira.t][sira.i]=nil
		else
			return _destroyElement(element)
		end	
	else
		return _destroyElement(element)
	end	
end	
function guiWindowSetSizable(element, bool)
	if getElementType(element) ~= "gui-window" then
		return false
	else
		_guiWindowSetSizable(element, bool)
	end	
end
function guiWindowSetMovable(element, bool)
	local sira = getGuiElement(element)
	if sira then
		sira.move = bool
	else
		return _guiWindowSetMovable(element, bool)
	end	
end
function guiWindowIsMovable(element, bool)
	local sira = getGuiElement(element)
	if sira then
		return sira.move
	else
		_guiWindowIsMovable(element, bool)
	end	
end
function guiSetLineColor(element,hex)
	local indeks = getGuiElement(element)
	if indeks then
		for i,v in pairs(indeks.kenarlar) do
			renkVer(v,hex)
		end	
	end
end


function RGBToHex(red, green, blue, alpha)
	
	-- Make sure RGB values passed to this function are correct
	if( ( red < 0 or red > 255 or green < 0 or green > 255 or blue < 0 or blue > 255 ) or ( alpha and ( alpha < 0 or alpha > 255 ) ) ) then
		return nil
	end

	-- Alpha check
	if alpha then
		return string.format("#%.2X%.2X%.2X%.2X", red, green, blue, alpha)
	else
		return string.format("#%.2X%.2X%.2X", red, green, blue)
	end

end
