genelGuiTablo = {}
scriptler = {} 
sx,sy = guiGetScreenSize()

--guiCreateWindow
wtablo = {}
--guiCreateButton
btablo = {}
--guiCreateGridList
Ltablo = {}
--guiCreateMemo
mtablo = {}
--guiCreateEdit
etablo = {}
-- guiCreateTab
tabs = {}
-- full gui list
lists = {}


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

addEventHandler("onClientResourceStop", root, function(sc)
	if scriptler[sc] then
		for i,v in pairs(scriptler[sc]) do
			for a,s in pairs(v) do 
				local tablo,sira,element = unpack(s)
				if isElement(element) then _destroyElement(element) end
				if tablo[sira] then tablo[sira]= nil end
			end	
		end
		scriptler[sc] = nil
	end
end)

--edit,gridlst,buton,memo mouse
function kenarAlpha()
	local sira = genelGuiTablo[source]
	if sira then
		if sira.kenarlar then
			for i,v in pairs(sira.kenarlar) do
				guiSetAlpha(v,  eventName == "onClientMouseEnter" and 1 or 0.4)
			end	
		end	
		if sira.isClose then guiSetAlpha(wtablo[sira.w].kapatArka, eventName == "onClientMouseEnter" and 1 or 0.5) end
	end
end
addEventHandler("onClientMouseEnter", resourceRoot, kenarAlpha)
addEventHandler("onClientMouseLeave", resourceRoot, kenarAlpha)


addEventHandler("onClientGUIClick", resourceRoot, function()
	local sira = genelGuiTablo[source]
	if sira and sira.isClose then 
		guiSetVisible(wtablo[sira.w].resim, false)
		showCursor(false)
		triggerEvent("MahLib:PencereKapatıldı",wtablo[sira.w].resim)
	end
end)

function libElementmi(element,sorgu)
	if sorgu == "w" then -- window
		for i,v in pairs(wtablo) do
			if v.resim == element then
				return v,i
			end	
		end
	elseif sorgu == "b" then -- button
		for i,v in pairs(btablo) do
			if v.label == element then
				return v,i
			end	
		end
	elseif sorgu == "e" then -- edit	
		for i,v in pairs(etablo) do
			if v.edit == element then
				return v,i
			end	
		end	
	elseif sorgu == "m" then -- memo
		for i,v in pairs(mtablo) do
			if v.memo == element then
				return v,i
			end	
		end
	elseif sorgu == "g" then -- gridlist
		for i,v in pairs(Ltablo) do
			if v.liste == element then
				return v,i
			end	
		end
	elseif sorgu == "ba" then -- pencere başlık
		for i,v in pairs(wtablo) do
			if v.basarka == element or v.label == element then
				return v,i
			end	
		end
	elseif sorgu == "tab" then -- tab
		for i,v in pairs(tabs) do
			for s,a in pairs(v.tabciklar) do
				--print(tostring(element).." = "..tostring(a.alan))
				if a.alan == element then
					return a,s,v
				end
			end
		end 
	elseif sorgu == "tabpanel" then
		for i,v in pairs(tabs) do
			if v.resim == element then
				return v,i
			end	
		end
	end	
	return false
end

--basinca olan ufalma ve panel taşıma
local clickedButton,clickedWindow = nil,nil
function MouseDown(btn, x, y)
	local sira = genelGuiTablo[source]
	if sira then
		if sira.isButton then
			if clickedButton then return end
			local g,u = guiGetSize(source, false)
			local x,y = guiGetPosition(source, false)
			clickedButton = {source,g,u,x,y}
			guiSetPosition(source, x+2,y+2, false)
			guiSetSize(source, g-4,u-4, false)
		end
		if btn == "left" and sira.isHeader and wtablo[sira.w].move then
			clickedWindow = wtablo[sira.w].resim
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
	local sira = genelGuiTablo[element]
	if sira then
		return _guiGetPosition(sira.resim, relative)
	else
		return _guiGetPosition(element, relative)
	end	
end
function guiSetPosition(element,x,y,relative)
	local sira = genelGuiTablo[element]
	if sira then
		return _guiSetPosition(sira.resim, x,y,relative)
	else
		return _guiSetPosition(element, x,y,relative)
	end	
end
function guiGetSize(element,relative)
	local sira = genelGuiTablo[element]
	if sira then
		return _guiGetSize(sira.resim, relative)
	else
		return _guiGetSize(element, relative)
	end	
end
function guiSetSize(element,g,u,relative)
	local relative = relative or false
	local sira = genelGuiTablo[element]
	local tsira = libElementmi(element,"tabpanel")
	if sira then
		_guiSetSize(sira.resim, g,u, relative)
		if sira.label then
			_guiSetSize(sira.label, g,u, relative)
			guiLabelSetHorizontalAlign(sira.label, "center") guiLabelSetVerticalAlign(sira.label, "center")
		end	
		if sira.basarka then _guiSetSize(sira.basarka, g,20, relative) end
		if sira.kapatArka then _guiSetSize(sira.kapatArka, g-25,1, relative) end
		koseleriAyarla(sira,g,u)
	elseif tsira then
		koseleriAyarla(tsira,g,u)
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
	local sira = genelGuiTablo[element]
	local tsira,sira,tabs = libElementmi(element,"tab")
	if sira and sira.basarka then -- window ise
		if sira.label then
			_guiSetText(sira.label, yazi)
			guiLabelSetHorizontalAlign(sira.label, "center") guiLabelSetVerticalAlign(sira.label, "center")
		end	
	elseif tsira then
		local yuzunluk = string.len(yazi)*8
		_guiSetSize(tsira.arka,yuzunluk,20,false)
		_guiSetSize(tsira.kose,yuzunluk,1,false)
		_guiSetSize(tsira.yazi,yuzunluk,20,false)
		_guiSetText(tsira.yazi,yazi)
		guiLabelSetHorizontalAlign(tsira.yazi, "center")
		guiLabelSetVerticalAlign(tsira.yazi, "center")
		for i=sira+1,#tabs.tabciklar do
			local ox,oy = _guiGetPosition(tabs.tabciklar[i-1].arka,false) 
			local og,op = _guiGetSize(tabs.tabciklar[i-1].arka,false)
			_guiSetPosition(tabs.tabciklar[i].arka,(ox+og),0,false)
		end
	else
		return _guiSetText(element, yazi)
	end
end

function guiGetText(element)
	local sira = genelGuiTablo[element]
	local tsira,sira,tabs = libElementmi(element,"tab")
	if sira and sira.basarka then -- window ise
		local yazi = _guiGetText(sira.label)
		return yazi
	elseif tsira then
		local yazi = _guiGetText(tsira.yazi)
		return yazi
	else
		local yazi = _guiGetText(element)
		return yazi
	end
end
function guiSetEnabled(element, bool)
	local bsira = genelGuiTablo[element]
	local tsira,sira,tabs = libElementmi(element,"tab")
	if bsira then
		guiSetAlpha(bsira.resim,bool and 1 or 0.5)
		return _guiSetEnabled(element, bool)
	elseif tsira then
		guiSetAlpha(tsira.arka,bool and 1 or 0.4)
		_guiSetEnabled(element, bool)
		return _guiSetEnabled(tsira.arka, bool)
	else
		return _guiSetEnabled(element, bool)
	end	
end
function guiSetVisible(element, bool)
	local sira = genelGuiTablo[element]
	local tsira,sira,tabs = libElementmi(element,"tab")
	if sira then
		return _guiSetVisible(sira.resim, bool)
	elseif tsira then
		_guiSetVisible(tsira.arka, bool)
		return _guiSetVisible(element, bool)
	else
		return _guiSetVisible(element, bool)
	end	
end


function destroyElement(element)
	local tip = getElementType(element)
	if tip:find("gui-") then
		local bsira,i = libElementmi(element,"b")
		local esira,i = libElementmi(element,"e")
		local msira,i = libElementmi(element,"m")
		local gsira,i = libElementmi(element,"g")
		if bsira then
			btablo[i] = nil
			_destroyElement(bsira.resim)	
		elseif esira then
			etablo[i] = nil
			_destroyElement(esira.resim)
		elseif msira then
			mtablo[i] = nil	
			_destroyElement(msira.resim)	
		elseif gsira then
			Ltablo[i] = nil	
			_destroyElement(gsira.resim)
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
	-- local wsira = libElementmi(element,"w")
	local sira = genelGuiTablo[element]
	if sira then
		sira.move = bool
	else
		return _guiWindowSetMovable(element, bool)
	end	
end
function guiWindowIsMovable(element, bool)
	-- local wsira = libElementmi(element,"w")
	local sira = genelGuiTablo[element]
	if sira then
		return sira.move
	else
		_guiWindowIsMovable(element, bool)
	end	
end
function guiEditSetColor(edit,kenarrenk)
	-- local esira = libElementmi(edit,"e")
	local sira = genelGuiTablo[element]
	if sira and sira.edit then
		for i,v in pairs(sira.kenarlar) do
			renkVer(v,kenarrenk)
			guiSetAlpha(v, 0.5)
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





