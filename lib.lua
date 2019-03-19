genelGuiTablo = {}
scriptler = {} 

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

function resimOlustur(isim,a)
	if fileExists(isim.."png") then return isim.."png" end
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

function renkVer(resim,hex)
	guiSetProperty(resim,"ImageColours","tl:FF"..hex.." tr:FF"..hex.." bl:FF"..hex.." br:FF"..hex)
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
	local event = eventName
	--for i,v in pairs(genelGuiTablo) do
		if genelGuiTablo[source] then
			for i,v in pairs(genelGuiTablo[source]) do
				if event == "onClientMouseEnter" then
					guiSetAlpha(v, 1)
				elseif event == "onClientMouseLeave" then
					guiSetAlpha(v, 0.4)
				end	
			end	
		end
--	end
	for i,v in pairs(wtablo) do
		if source == v.kapat then
			if event == "onClientMouseEnter" then
				guiSetAlpha(v.kapatArka, 1)
			elseif event == "onClientMouseLeave" then
				guiSetAlpha(v.kapatArka, 0.5)
			end	
			break
		end
	end
end
addEventHandler("onClientMouseEnter", resourceRoot, kenarAlpha)
addEventHandler("onClientMouseLeave", resourceRoot, kenarAlpha)


addEventHandler("onClientGUIClick", resourceRoot, function()
	for i,v in pairs(wtablo) do
		if source == v.kapat then
			guiSetVisible(v.resim, false)
			showCursor(false)
			triggerEvent("MahLib:PencereKapatıldı",v.resim)
		end
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

--basinca olan ufalma
basili = {}
addEventHandler("onClientGUIMouseDown", resourceRoot, function()
	local bsira = libElementmi(source,"b")
	if bsira then
		if basili[source] then return end
		basili[source] = true
		local g,u = guiGetSize(source, false)
		local x,y = guiGetPosition(source, false)
		guiSetPosition(source, x+2,y+2, false)
		guiSetSize(source, g-4,u-4, false)
	end
end)

addEventHandler("onClientGUIMouseUp", resourceRoot, function()
	local bsira = libElementmi(source,"b")
	if bsira then
		if not basili[source] then  
			for i,v in pairs(basili) do
				if v == true then
					source = i
					break
				end
			end	
		end
		if not basili[source] then return end
		basili[source] = nil
		local g,u = guiGetSize(source, false)
		local x,y = guiGetPosition(source, false)
		guiSetPosition(source, x-2,y-2, false)
		guiSetSize(source, g+4,u+4, false)
	else
		for i,v in pairs(basili) do
			if v == true then
				source = i
				break
			end
		end	
		if bsira then
			basili[source] = nil
			local g,u = guiGetSize(source, false)
			local x,y = guiGetPosition(source, false)
			guiSetPosition(source, x-2,y-2, false)
			guiSetSize(source, g+4,u+4, false)
		end	
	end
end)

function basiliBirak()
	for i,v in pairs(basili) do
			if v == true then
				source = i
				break
			end
		end	
	if libElementmi(source,"b") then
		basili[source] = nil
		local g,u = guiGetSize(source, false)
		local x,y = guiGetPosition(source, false)
		guiSetPosition(source, x-2,y-2, false)
		guiSetSize(source, g+4,u+4, false)
	end	
end

addEventHandler("onClientClick", root, function(button, durum, _, _, _, _, _, tiklanan)
	if durum == "up" then
		if tiklanan then 
			local element = getElementType(tiklanan)
			if element then
				if not string.find(element, "gui-") then
					basiliBirak()
				end	
			end	
		else
			basiliBirak()
		end
	end	
end)

--panel taşıma
addEventHandler( "onClientGUIMouseDown", resourceRoot,function ( btn, x, y )
	if btn == "left" then
		local wsira = libElementmi(source,"ba")
		if wsira then
			local source = wsira.resim
			clickedElement = source
			local elementPos = { guiGetPosition( source, false ) }
			offsetPos = { x - elementPos[ 1 ], y - elementPos[ 2 ] };
		end	
	end
end)

addEventHandler( "onClientGUIMouseUp", resourceRoot,function ( btn, x, y )
	if btn == "left" and libElementmi(source,"ba") then
		clickedElement = nil
	end
end)

addEventHandler( "onClientCursorMove", getRootElement( ),function ( _, _, x, y )
	if clickedElement then
		guiSetPosition( clickedElement, x - offsetPos[ 1 ], y - offsetPos[ 2 ], false )
	end
end)


--diğer funclar
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

function guiGetPosition(element,relative)
	local relative = relative or false
	local bsira = libElementmi(element,"b")
	local esira = libElementmi(element,"e")
	local msira = libElementmi(element,"m")
	local gsira = libElementmi(element,"g")
	if bsira then
		local x,y = _guiGetPosition(bsira.resim, relative)
		return x,y 
	elseif esira then
		local x,y = _guiGetPosition(esira.resim, relative)
		return x,y 
	elseif msira then
		local x,y = _guiGetPosition(msira.resim, relative)
		return x,y 
	elseif gsira then
		local x,y = _guiGetPosition(gsira.resim, relative)
		return x,y 	
	else
		local x,y = _guiGetPosition(element, relative)
		return x,y
	end
end

function guiSetPosition(element,x,y,relative)
	local relative = relative or false
	local bsira = libElementmi(element,"b")
	local esira = libElementmi(element,"e")
	local msira = libElementmi(element,"m")
	local gsira = libElementmi(element,"g")
	if bsira then
		_guiSetPosition(bsira.resim, x,y, relative)
	elseif esira then
		_guiSetPosition(esira.resim, x,y, relative)	
	elseif msira then
		_guiSetPosition(msira.resim, x,y, relative)	
	elseif gsira then
		_guiSetPosition(gsira.resim, x,y, relative)		
	else
		_guiSetPosition(element,x,y,relative)
	end
end

function guiGetSize(element,relative)
	local relative = relative or false
	local bsira = libElementmi(element,"b")
	local esira = libElementmi(element,"e")
	local msira = libElementmi(element,"m")
	local gsira = libElementmi(element,"g")
	if bsira then
		local g,u = _guiGetSize(bsira.resim, relative)
		return g,u
	elseif esira then
		local g,u = _guiGetSize(esira.resim, relative)
		return g,u 
	elseif msira then
		local g,u = _guiGetSize(msira.resim, relative)
		return g,u 
	elseif gsira then
		local g,u = _guiGetSize(gsira.resim, relative)
		return g,u 	
	else
		local g,u = _guiGetSize(element, relative)
		return g,u
	end
end

function guiSetSize(element,g,u,relative)
	local relative = relative or false
	local wsira = libElementmi(element,"w")
	local bsira = libElementmi(element,"b")
	local esira = libElementmi(element,"e")
	local msira = libElementmi(element,"m")
	local gsira = libElementmi(element,"g")
	local tsira = libElementmi(element,"tabpanel")
	if bsira then
		_guiSetSize(bsira.resim, g,u, relative)
		_guiSetSize(bsira.label, g,u, relative)
		koseleriAyarla(bsira,g,u)
	elseif wsira then
		_guiSetSize(wsira.resim, g,u, relative)
		koseleriAyarla(wsira,g,u)
		--baslik
		_guiSetSize(wsira.basarka, g,20, relative)
		--kapat
		_guiSetPosition(wsira.kapatArka, g-25,1, relative)
		--label
		local yazi = guiGetText(wsira.label)
		_guiSetPosition(wsira.label, (g/2)-((string.len(yazi)*8)/2),0, relative)
		_guiSetSize(wsira.label,(string.len(yazi)*8),20, relative)
		guiLabelSetHorizontalAlign(wsira.label, "center")
		guiLabelSetVerticalAlign(wsira.label, "center")
	elseif esira then
		_guiSetSize(esira.resim, g,u, relative)
		_guiSetSize(element, g,u, relative)
		koseleriAyarla(esira,g,u)
	elseif msira then
		_guiSetSize(msira.resim, g,u, relative)
		_guiSetSize(element, g,u, relative)
		koseleriAyarla(msira,g,u)
	elseif gsira then
		_guiSetSize(gsira.resim, g,u, relative)
		_guiSetSize(element, g,u, relative)
		koseleriAyarla(gsira,g,u)
	elseif tsira then
		koseleriAyarla(tsira,g,u)
	else
		_guiSetSize(element,g,u,relative)
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
	local wsira = libElementmi(element,"w")
	local tsira,sira,tabs = libElementmi(element,"tab")
	if wsira then
		local g,u = _guiGetSize(wsira.resim,false)
		_guiSetPosition(wsira.label,(g/2)-((string.len(yazi)*8)/2),0, false)
		_guiSetSize(wsira.label, (string.len(yazi)*8),20, false)
		guiLabelSetHorizontalAlign(wsira.label, "center")
		guiLabelSetVerticalAlign(wsira.label, "center")
		_guiSetText(wsira.label, yazi)
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
		_guiSetText(element, yazi)
	end
end

function guiGetText(element)
	local wsira = libElementmi(element,"w")
	local tsira,sira,tabs = libElementmi(element,"tab")
	if wsira then
		local yazi = _guiGetText(wsira.label)
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
	local bsira = libElementmi(element,"b")
	local tsira,sira,tabs = libElementmi(element,"tab")
	if bsira then
		if bool == false then
			guiSetAlpha(bsira.resim,0.5)
			_guiSetEnabled(element, bool)
		else
			guiSetAlpha(bsira.resim,1)
			_guiSetEnabled(element, bool)
		end
	elseif tsira then
		if bool == false then
			guiSetAlpha(tsira.arka,0.4)
		else
			guiSetAlpha(tsira.arka,1)
		end
		_guiSetEnabled(element, bool)
		_guiSetEnabled(tsira.arka, bool)
	else
		_guiSetEnabled(element, bool)
	end	
end

function guiSetVisible(element, bool)
	local bsira = libElementmi(element,"b")
	local esira = libElementmi(element,"e")
	local msira = libElementmi(element,"m")
	local gsira = libElementmi(element,"g")
	local tsira,sira,tabs = libElementmi(element,"tab")
	if bsira then
		_guiSetVisible(bsira.resim, bool)
	elseif esira then
		_guiSetVisible(esira.resim, bool)
	elseif msira then
		_guiSetVisible(msira.resim, bool)
	elseif gsira then
		_guiSetVisible(gsira.resim, bool)
	elseif tsira then
		_guiSetVisible(tsira.arka, bool)
		_guiSetVisible(element, bool)
	else
		_guiSetVisible(element, bool)
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
			_destroyElement(bsira.resim)	
			btablo[i] = nil
		elseif esira then
			_destroyElement(esira.resim)
			etablo[i] = nil
		elseif msira then
			_destroyElement(msira.resim)	
			mtablo[i] = nil	
		elseif gsira then
			_destroyElement(gsira.resim)
			Ltablo[i] = nil	
		else
			_destroyElement(element)
		end	
	else
		_destroyElement(element)
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
	local wsira = libElementmi(element,"w")
	if wsira then
		wsira.move = bool
	else
		_guiWindowSetMovable(element, bool)
	end	
end

function guiWindowIsMovable(element, bool)
	local wsira = libElementmi(element,"w")
	if wsira then
		return wsira.move
	else
		_guiWindowIsMovable(element, bool)
	end	
end
	

function guiEditSetColor(edit,kenarrenk)
	local esira = libElementmi(edit,"e")
	if esira then
		for i,v in pairs(esira.kenarlar) do
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





