-- full gui
_guiCreateGridList = guiCreateGridList
_guiGridListAddColumn = guiGridListAddColumn
_guiGridListAddRow = guiGridListAddRow
_guiGridListSetItemText = guiGridListSetItemText
_guiGridListSetSelectedItem = guiGridListSetSelectedItem
_guiGridListSetItemData = guiGridListSetItemData
_guiGridListRemoveRow = guiGridListRemoveRow
_guiGridListClear = guiGridListClear
_guiGridListSetColumnTitle = guiGridListSetColumnTitle
_guiGridListSetColumnWidth = guiGridListSetColumnWidth
_guiGridListSetItemColor = guiGridListSetItemColor
_guiGridListSetItemBackColor = guiGridListSetItemBackColor
_guiGridListSetSortingEnabled = guiGridListSetSortingEnabled

_guiGridListGetSelectedItem = guiGridListGetSelectedItem
_guiGridListGetItemText = guiGridListGetItemText
_guiGridListGetItemData = guiGridListGetItemData
_guiGridListGetColumnCount = guiGridListGetColumnCount
_guiGridListGetColumnTitle = guiGridListGetColumnTitle
_guiGridListGetColumnWidth = guiGridListGetColumnWidth
_guiGridListGetRowCount = guiGridListGetRowCount


--Sets/create
function MLguiCreateGridList(x,y,g,u,relative,parent,backrenk,kenarrenk,backalpha,kenaralpha)
	local sira = #lists+1
	if not lists[sira] then lists[sira] = {} end
	local l = lists[sira]
	local backrenk,kenarrenk = backrenk or "000000",kenarrenk or "1883D7"
	local backalpha,kenaralpha = backalpha or 100, kenaralpha or 0.3
	if relative  then
		px,pu = guiGetSize(parent,false)
		x,y,g,u = x*px,y*pu,g*px,u*pu
		relative = false
	end
	l.parent = parent
	l.cols,l.rows,l.texts,l.satir,l.secili,l.wheel = {},{},{},0,{-1,-1},false
	l.back = guiCreateStaticImage(x,y,g,u,resimOlustur("test",100),relative,parent)
	renkVer(l.back,backrenk)
	l.x,l.y = guiGetPosition(l.back,false)
	l.g,l.u = guiGetSize(l.back,false)
	l.kenarlar = {
			ortaUst = guiCreateStaticImage(0,0,l.g,1,resimOlustur("test"), false, l.back),
			ortaAlt = guiCreateStaticImage(0,l.u-1,g,1,resimOlustur("test"), false, l.back),
			sol = guiCreateStaticImage(0,0,1,l.u,resimOlustur("test"), false,l.back),
			sag = guiCreateStaticImage(l.g-1,0,1,l.u,resimOlustur("test"), false, l.back)
		}
	for i,v in pairs(l.kenarlar) do
		renkVer(v,kenarrenk)
		guiSetProperty(v, "AlwaysOnTop", "True")
		guiSetAlpha(v, kenaralpha)
	end
	
	l.erkaninarkasi = guiCreateLabel(0,0,l.g,l.u+20,"",false,l.back)
	l.enarka = guiCreateScrollPane(0,20,l.g+20,l.u-20,false,l.erkaninarkasi)
	
	if not scriptler[sourceResource] then scriptler[sourceResource] = {} end
	if not scriptler[sourceResource]["guiList"] then scriptler[sourceResource]["guiList"] = {} end
	table.insert(scriptler[sourceResource]["guiList"], {lists,sira,l.back})
	
	return l.back
end
function MLguiGridListAddColumn(liste,baslik,uzunluk)
	local liste = getListe(liste)
	local sira = #liste.cols+1
	if not liste.cols[0] then liste.cols[0] = {} end
	if not liste.cols[sira] then liste.cols[sira] = {} end
	if sira == 1 then 
		liste.baslik = guiCreateStaticImage(0,0,liste.g,20,resimOlustur("test"),false,liste.back)
		renkVer(liste.baslik,"000000") 
		guiSetProperty(liste.baslik, "AlwaysOnTop", "True")
	end
	local Cuzunluk = uzunluk*liste.g
	liste.cols[0].yazi = guiCreateLabel(0,1,0,0,"",false,liste.baslik)	
	local ox,ou = guiGetPosition(liste.cols[sira-1].yazi,false) or 0 -- pos
	local og,op = guiGetSize(liste.cols[sira-1].yazi,false) or 0 -- size
	liste.cols[sira].yazi = guiCreateLabel((ox+og),1,Cuzunluk,20,baslik,false,liste.baslik)
	liste.cols[sira].cizgi = guiCreateStaticImage(ox+og,19,Cuzunluk,1,resimOlustur("test"), false, liste.baslik)
	if (ox+og)+Cuzunluk > liste.g then
		guiSetSize(liste.baslik, (ox+og)+Cuzunluk,20,false)
	end
	guiSetProperty(liste.cols[sira].cizgi, "AlwaysOnTop", "True")
	liste.cols[sira].uzun = uzunluk

	--liste.cols[sira] = {baslik,uzunluk}	
	return sira
end
function MLguiGridListAddRow(liste,...)
	assert(liste, "expected gui-element at argument 1, got ".. type(liste))
	local liste = getListe(liste)
	if not liste then return false end
	local sira = #liste.rows+1
	if not liste.rows[sira] then liste.rows[sira] = {} end
	return sira
end
function MLguiGridListSetItemText(liste,row,col,yazi,secili,sort,img,imgG,imgU)
	local liste = getListe(liste)
	if row < 1 then row = 1 end
	if liste.texts[row] and liste.texts[row][col] then
		for i,v in pairs(liste.texts[row][col]) do
			if isElement(v) then destroyElement(v) end
		end
	end
	if not liste.rows[row] then print("guiGridListSetItemText row yok") return false end
	if not liste.cols[col] then print("guiGridListSetItemText col yok") return false end
	if not liste.texts[row] then liste.texts[row] = {} end
	if not liste.texts[row][col] then liste.texts[row][col] = {} end
	if not liste.texts[row][0] then liste.texts[row][0] = {} end
	local backcolor,backalpha = backcolor or "212121", backalpha or 150
	local arkaY = 20+(21*(row-1))
	local g,u = guiGetSize(liste.back,false)
	local ox,oy = guiGetPosition(liste.cols[col].yazi,false) or 0
	local og,op = guiGetSize(liste.cols[col].yazi,false) or 0
	local Cuzunluk = liste.cols[col].uzun*liste.g
	
	if arkaY+20 > liste.u-20 and not liste.scrollarka  then
		liste.scrollarka = guiCreateStaticImage(g-10,20,10,u,resimOlustur("test"),false,liste.back)
		liste.scrollkenar = guiCreateStaticImage(0,0,1,u+20,resimOlustur("test"),false,liste.scrollarka)
		guiSetAlpha(liste.scrollkenar,0.4)
		liste.scroll = guiCreateStaticImage(0,0,10,20,resimOlustur("test"),false,liste.scrollarka)
		renkVer(liste.scrollarka,"020202") 
	end
	if not liste.texts[row][0].arka then
		local g = guiGetSize(liste.baslik,false)
		liste.texts[row][0].arka = guiCreateStaticImage(0,arkaY,liste.g,20,resimOlustur("test",secili and 0 or backalpha),false,liste.enarka)
		guiSetProperty(liste.texts[row][0].arka,"AlwaysOnTop", "False")
		renkVer(liste.texts[row][0].arka,backcolor) 
		liste.texts[row][0].arkarenk = backcolor
	end	
	liste.texts[row][col].secili = secili
	if not img then
		liste.texts[row][col].yazi = guiCreateLabel(ox+2,0,og-2,20,yazi,false,liste.texts[row][0].arka )
	else
		liste.texts[row][col].yazi = guiCreateStaticImage(ox+2,0,imgG or 20,imgU or 20,yazi,false,liste.texts[row][0].arka )
	end	
	liste.texts[row][col].yaziarka = guiCreateLabel(0,0,liste.g,20,"",false,liste.texts[row][0].arka )
	guiBringToFront(liste.texts[row][col].yaziarka)
	return true
end
function MLguiGridListSetItemImage(liste,row,col,yazi,secili,sort,imgG,imgU)
	return MLguiGridListSetItemText(liste,row,col,yazi,secili,sort,true,imgG,imgU)
end
function MLguiGridListSetSelectedItem(liste,row,col)
	local liste = getListe(liste)
	if row == 0 then row = 1 end
	local rows,cols = MLguiGridListGetSelectedItem(liste)
	if row ~= -1 and col ~= -1 then
		if rows ~= row then
			if rows ~= -1 and cols ~= -1 then
				local renk = liste.texts[rows][0].arkarenk
				renkVer(liste.texts[rows][0].arka,renk)
			end	
		
			renkVer(liste.texts[row][0].arka,"4286f4")
			guiSetAlpha(liste.texts[row][0].arka,1)	
		end	
	else
		if liste.texts[rows]  then
			local renk = liste.texts[rows][0].arkarenk
			renkVer(liste.texts[rows][0].arka,renk)
		end	
	end
	liste.secili = {row,col}
	return true
end
function MLguiGridListSetItemData(liste,row,col,veri)
	local liste = getListe(liste)
	if row < 1 then row = 1 end
	if not liste.texts[row] then return end
	liste.texts[row][col].veri = veri
	return true
end
function MLguiGridListRemoveRow(liste,row)
	local liste = getListe(liste)
	if row < 1 then row = 1 end
	if not liste.rows[row] then return false end
	if liste.texts[row][0].arka then
		destroyElement(liste.texts[row][0].arka)
		liste.texts[row][0].arka = nil
	end	
	for cols,v in pairs(liste.texts[row]) do table.each(v, destroy) end
	table.remove(liste.rows,row)
	table.remove(liste.texts,row)
	for i,v in pairs(liste.rows) do
		local arkaY = 20+(21*(i))
		if liste.texts[i][0].arka then
			guiSetText(liste.texts[i][0].arka,0,arkaY,false)
		end
	end
	if 0+(21*(#liste.rows)) < liste.u+20 and liste.scrollarka  then
		destroyElement(liste.scrollarka)
		liste.scrollarka = nil
	end
end	
function MLguiGridListClear(liste)
	local liste = getListe(liste)
	if #liste.texts > 0  then
		for i,v in pairs(liste.texts) do
			if liste.texts[i] and liste.texts[i][0].arka then
				destroyElement(liste.texts[i][0].arka)
				liste.texts[i][0].arka = nil
			end	
			for cols,k in pairs(v) do
				table.each(k, destroy)
			end	
		end
		if liste.scrollarka  then
			destroyElement(liste.scrollarka)
			liste.scrollarka = nil
		end	
	end
	liste.rows = {}		
end
function MLguiGridListSetColumnTitle(liste,col,yazi)	
	local liste = getListe(liste)
	if not liste.cols[col] then return false end
	return guiSetText(liste.cols[col].yazi,yazi)
end
function MLguiGridListSetColumnWidth(liste,col,uzunluk,rel)
	local liste = getListe(liste)
	if not liste then return false end
	if not liste.cols[col] then return false end
	if not uzunluk then return false end
	if type(uzunluk) ~= "number" then return false end
	if uzunluk > 1 then uzunluk = 1 end
	local Cuzunluk = uzunluk*liste.g
	liste.cols[col].uzun = uzunluk
	guiSetPosition(liste.cols[col].yazi,0+Cuzunluk*(col-1)+5)
end
function MLguiGridListSetItemColor(liste,row,col,r,g,b,a)
	local liste = getListe(liste)
	if row < 1 then row = 1 end
	if not liste then return false end
	if not liste.rows[row] then return false end
	if not liste.cols[col] then return false end
	
	guiLabelSetColor(liste.texts[row][col].yazi,r,g,b)
	if a then
		guiSetAlpha(liste.texts[row][col].yazi,a)
	end	
end
function MLguiGridListSetItemBackColor(liste,row,hex)
	local liste = getListe(liste)
	if row < 1 then row = 1 end
	if not liste then return false end
	if not liste.rows[row] then return false end
	renkVer(liste.texts[row][0].arka,hex)
	liste.texts[row][0].arkarenk = hex
end
function MLguiGridListSetSortingEnabled (liste,bool)
	--hiçbişey
end

--Gets
function MLguiGridListGetSelectedItem(liste)
	local liste = getListe(liste)
	local row,col = unpack(liste.secili)
	return row,col
end	
function MLguiGridListGetItemText(liste,row,col)
	local liste = getListe(liste)
	if row < 1 then row = 1 end
	if not liste.texts[row] then return false end
	if not liste.texts[row][col] then return false end
	local elm = liste.texts[row][col].yazi
	return getElementType(elm)
end
function MLguiGridListGetItemData(liste,row,col)
	local liste = getListe(liste)
	if row < 1 then row = 1 end
	if not liste.texts[row] then return false end
	if not liste.texts[row][col] then return false end
	return liste.texts[row][col].veri
end
function MLguiGridListGetColumnCount(liste)
	local liste = getListe(liste)
	return #liste.cols
end
function MLguiGridListGetColumnTitle(liste,col)
	local liste = getListe(liste)
	if not liste.cols[col] then return false end
	return guiGetText(liste.cols[col].yazi) or false
end
function MLguiGridListGetColumnWidth(liste,col,rel)
	local liste = getListe(liste)
	if not liste.cols[col] then return false end
	return liste.cols[col].uzun or false
end
function MLguiGridListGetItemColor(liste,row,col)
	local liste = getListe(liste)
	if row < 1 then row = 1 end
	if not liste.rows[row] then return false end
	if not liste.cols[col] then return false end
	local r,g,b = guiLabelGetColor(liste.texts[row][col].yazi)
	return r,g,b or false
end
function MLguiGridListGetRowCount(liste)
	local liste = getListe(liste)
	return #liste.rows
end

--useful and events
function destroy(element)
	if isElement(element) then destroyElement(element) end
end
function table.each(t, index, callback, ...)
	local args = { ... }
	if type(index) == 'function' then
		table.insert(args, 1, callback)
		callback = index
		index = false
	end
	for k,v in pairs(t) do
		callback(index and v[index] or v, unpack(args))
	end
	return t
end	
function scrollmu(element)
	for i,v in pairs(lists) do
		if v.scroll == element then
			return v.scrollarka,v.enarka
		end	
	end
	return false
end
function getListe(element)
	if type(element) ~= "table" then
		for i,v in pairs(lists) do
			if v.back == element then
				return lists[i]
			end
		end
	else
		return element
	end	
end
addEventHandler( "onClientGUIMouseDown", resourceRoot,function ( btn, x, y )
	local arka,enarka = scrollmu(source)
	if btn == "left" and arka then
		clickedScroll = source
		local elementPos = { guiGetPosition( source, false ) }
		local g,u = guiGetSize(arka,false)
		offset = {elementPos[ 1 ], y - elementPos[ 2 ],u,enarka }
	end
end)
addEventHandler( "onClientGUIMouseUp", resourceRoot,function ( btn, x, y )
	if btn == "left"  then
		clickedScroll = nil
	end
end)
addEventHandler( "onClientCursorMove", getRootElement( ),function ( _, _, rx, ry )
	if clickedScroll then
		local x,y,u,enarka = unpack(offset)
		local last = nil
		local _,gu = guiGetSize(clickedScroll,false)
		local px,py = guiGetPosition(enarka,false)
		local pg,pu = guiGetSize(enarka,false)
		if (ry-y+18)+gu < u and (ry-y) > -2 then 
			guiSetPosition(clickedScroll, x, ry-y, false )
			guiScrollPaneSetVerticalScrollPosition(enarka,((ry-y)/(u-40)*(100)))
		end	
	end
end)
addEventHandler("onClientMouseEnter", resourceRoot, function()
	for i,v in pairs(lists) do
		for row,a in pairs(v.texts) do
			for col,k in pairs(a) do
				if source == k.yaziarka and not k.secili then
					guiSetAlpha(a[0].arka, 0.5)
					--renkVer(a.arka,"4286f4")
					v.wheel = true
					break
				end
			end	
		end	
	end
end)
addEventHandler("onClientMouseLeave", resourceRoot, function()
	for i,v in pairs(lists) do
		for row,a in pairs(v.texts) do
			for col,k in pairs(a) do
				if source == k.yaziarka then
					guiSetAlpha(a[0].arka, 1)
					v.wheel = false
					break
				end
			end	
		end	
	end
end)
addEventHandler("onClientGUIClick", resourceRoot, function()
	for i,v in pairs(lists) do
		for row,a in pairs(v.texts) do
			for col,k in pairs(a) do
				if source == k.yaziarka and not k.secili then
					MLguiGridListSetSelectedItem(v,row,col)
					triggerEvent("onClientGUIClick",v.back)
					break
				elseif source == v.enarka then
					MLguiGridListSetSelectedItem(v,-1,-1)
					break
				end
			end	
		end	
	end
end)
addEventHandler("onClientGUIDoubleClick", resourceRoot, function()
	for i,v in pairs(lists) do
		for row,a in pairs(v.texts) do
			for col,k in pairs(a) do
				if source == k.yaziarka and not k.secili then
					triggerEvent("onClientGUIDoubleClick",v.back)
					break
				end
			end	
		end	
	end
end)
addEventHandler("onClientMouseWheel",resourceRoot,function(yon)
	local sx,sy = guiGetScreenSize()
	local cx,cy = getCursorPosition()
	local cx,cy = cx*sx,cy*sy
	for i,v in pairs(lists) do
		if v.wheel and v.scrollarka  then
			local px,py = guiGetPosition(v.scroll,false)
			local pg,pu = guiGetSize(v.scrollarka,false)
			if yon == 1 then
				if (py-5) > -6 then
					guiSetPosition(v.scroll, px, py-5, false )
					guiScrollPaneSetVerticalScrollPosition(v.enarka,((py-5)/(pu-40)*(100)))
				end	
			else
				if (py+5) < pu-36 then
					guiSetPosition(v.scroll, px, py+5, false )
					guiScrollPaneSetVerticalScrollPosition(v.enarka,((py+5)/(pu-40)*(100)))
				end	
			end	
		end
	end
end)

