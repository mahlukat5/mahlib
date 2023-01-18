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

local onTop,scrolls = {},{} --for events
--Sets/create
function MLguiCreateGridList(x,y,g,u,relative,parent,backrenk,kenarrenk,backalpha,kenaralpha)
	local sira = #gui["guilist"]+1
	if not gui["guilist"][sira] then gui["guilist"][sira] = {} end
	local l = gui["guilist"][sira]
	if relative  then
		px,pu=getParentSize(parent)
		x,y,g,u=x*px,y*pu,g*px,u*pu
	end
	l.parent = parent
	l.cols,l.rows,l.texts,l.satir,l.secili,l.wheel = {},{},{},0,{-1,-1},false
	l.resim = guiCreateStaticImage(x,y,g,u,a150,false,parent)
	l.x,l.y,l.g,l.u = x,y,g,u
	l.kenarlar = {
		ortaUst = createSideLine(0,0,g,1,l.resim,settings.guilist.side_lines),
		ortaAlt = createSideLine(0,u-1,g,1,l.resim,settings.guilist.side_lines),
		sol = createSideLine(0,0,1,u,l.resim,settings.guilist.side_lines),
		sag = createSideLine(g-1,0,1,u,l.resim,settings.guilist.side_lines)
	}
	l.erkaninarkasi = guiCreateLabel(0,0,g,u+20,"",false,l.resim)
	l.enarka = guiCreateScrollPane(0,20,g+20,u-20,false,l.erkaninarkasi)
	
	if not scriptler[sourceResource] then scriptler[sourceResource] = {} end
	if not scriptler[sourceResource]["guilist"] then scriptler[sourceResource]["guilist"] = {} end
	table.insert(scriptler[sourceResource]["guilist"], {sira,l.resim})
	
	guiSetProperty(l.resim,"ImageColours","tl:FF"..settings.guilist.back_topleft.." tr:FF"..settings.guilist.back_topright.." bl:FF"..settings.guilist.back_bottomleft.." br:FF"..settings.guilist.back_bottomright.."")
	genelGuiTablo[l.resim]={i=sira,t="guilist"}
	return l.resim
end
function MLguiGridListAddColumn(liste,baslik,uzunluk,align)
	local liste = getListe(liste)
	local sira = #liste.cols+1
	if not liste.cols[0] then liste.cols[0] = {} end
	if not liste.cols[sira] then liste.cols[sira] = {} end
	if sira == 1 then 
		liste.baslik = guiCreateStaticImage(0,0,liste.g,20,bosresim,false,liste.resim)
		renkVer(liste.baslik,"000000")
	end
	local Cuzunluk = uzunluk*liste.g
	liste.cols[0].yazi = guiCreateLabel(0,1,0,0,"",false,liste.baslik)	
	local ox,ou = guiGetPosition(liste.cols[sira-1].yazi,false) or 0 -- pos
	local og,op = guiGetSize(liste.cols[sira-1].yazi,false) or 0 -- size
	liste.cols[sira].yazi = guiCreateLabel((ox+og),1,Cuzunluk,20,baslik,false,liste.baslik)
	 guiLabelSetHorizontalAlign(liste.cols[sira].yazi,align or "left")
	liste.cols[sira].cizgi = guiCreateStaticImage(ox+og,19,Cuzunluk,1,bosresim, false, liste.baslik)
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
function MLguiGridListSetItemText(liste,row,col,yazi,secili,sort,img,imgX,imgY,imgG,imgU)
	local liste = getListe(liste)
	assert(liste, "expected gui-element at argument 1, got ".. type(liste))
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
	local buyukluk = 20
	-- local arkaY = (21*(row))
	local arkaY = row == 1 and 21 or (liste.texts[row-1][0].y+liste.texts[row-1][0].g)+1
	local g,u = _guiGetSize(liste.resim,false)
	local ox,oy = _guiGetPosition(liste.cols[col].yazi,false) or 0
	local og,op = _guiGetSize(liste.cols[col].yazi,false) or 0
	local Cuzunluk = liste.cols[col].uzun*liste.g

	if arkaY > u-20 and not liste.scrollarka  then
		liste.scrollarka = guiCreateStaticImage(g-10,20,10,u,bosresim,false,liste.resim)
		liste.scrollkenar = guiCreateStaticImage(0,0,1,u,bosresim,false,liste.scrollarka)
		guiSetAlpha(liste.scrollkenar,0.4) renkVer(liste.scrollarka,"020202") 
		liste.scroll = guiCreateStaticImage(0,0,10,20,bosresim,false,liste.scrollarka)
		scrolls[liste.scroll]={liste.scrollarka,liste.enarka}
	end
	if not liste.texts[row][0].arka then
		liste.texts[row][0].arka = guiCreateStaticImage(0,arkaY,liste.g,buyukluk,secili and a0 or a150,false,liste.enarka)
		renkVer(liste.texts[row][0].arka,"212121") 
		liste.texts[row][0].arkarenk = "212121"
		liste.texts[row][0].g = buyukluk
		liste.texts[row][0].y = arkaY
	end	
	liste.texts[row][col].secili = secili
	if not img then
		liste.texts[row][col].yazi = guiCreateLabel(secili and ox+0 or ox+5,0,og-2,buyukluk,yazi,false,liste.texts[row][0].arka )
		if secili then 
			guiSetFont(liste.texts[row][col].yazi,"default-bold-small") 
		else
			guiLabelSetVerticalAlign(liste.texts[row][col].yazi,"center")
		end
	else
		liste.texts[row][col].img = guiCreateStaticImage(ox+imgX,0+imgY,imgG or 20,imgU or buyukluk,yazi,false,liste.texts[row][0].arka )
		guiSetEnabled(liste.texts[row][col].img,false)
		liste.texts[row][col].yazi = guiCreateLabel(secili and ox+0 or ox+5,0,og-2,buyukluk,"",false,liste.texts[row][0].arka )
	end	
	return true
end
function MLguiGridListSetItemImage(liste,row,col,yazi,imgX,imgY,imgG,imgU)
	return MLguiGridListSetItemText(liste,row,col,yazi,false,false,true,imgX or 0,imgY or 0,imgG or 20,imgU)
end
function MLguiGridListSetItemWidth(liste,row,width)
	local liste = getListe(liste)
	assert(liste, "expected gui-element at argument 1, got ".. type(liste))
	if not liste.rows[row] then print("MLguiGridListSetItemWidth row yok") return false end
	_guiSetSize(liste.texts[row][0].arka,liste.g,width,false)
	local col = 1
	repeat
		local og,op = _guiGetSize(liste.cols[col].yazi,false) or 0
		_guiSetSize(liste.texts[row][col].yazi,og-2,width,false)
		col = col+1
	until not liste.texts[row][col]	
	liste.texts[row][0].g = width
	if liste.texts[row][0].y+width > liste.u and not liste.scrollarka then
		liste.scrollarka = guiCreateStaticImage(liste.g-10,20,10,liste.u,bosresim,false,liste.resim)
		liste.scrollkenar = guiCreateStaticImage(0,0,1,liste.u,bosresim,false,liste.scrollarka)
		guiSetAlpha(liste.scrollkenar,0.4) renkVer(liste.scrollarka,"020202") 
		liste.scroll = guiCreateStaticImage(0,0,10,20,bosresim,false,liste.scrollarka)
		scrolls[liste.scroll]={liste.scrollarka,liste.enarka}
	end
	if liste.texts[row+1] then rePositionRows(liste,row) end
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
	if liste.scrollarka and sourceResource then
		local px,py = guiGetPosition(liste.scroll,false)
		local pg,pu = guiGetSize(liste.scrollarka,false)
		local rowsayi = #liste.rows
		if liste.texts[row] then
			local rowe = liste.texts[row][0].arka
			local roweX,roweY = guiGetPosition(rowe,false)
			local newY =roweY
			if row == 1 then newY = 0 end
			if (newY+5) > pu-36 then newY=pu-40  end
			guiSetPosition(liste.scroll, px, newY, false )
			guiScrollPaneSetVerticalScrollPosition(liste.enarka,((newY)/(pu-40)*(100)))
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
	for i,v in ipairs(liste.rows) do
		local arkaY = i == 1 and 21 or (liste.texts[i-1][0].y+liste.texts[i-1][0].g)+1
		if liste.texts[i][0].arka then
			_guiSetPosition(liste.texts[i][0].arka,0,arkaY,false)
			liste.texts[i][0].y = arkaY
		end
	end
	local totalWidth = liste.texts[#liste.rows][0].y + liste.texts[#liste.rows][0].g
	if totalWidth < liste.u and liste.scrollarka  then
		destroyScroll(liste)
	end
	if onTop and onTop.row == row then onTop = nil end
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
			destroyScroll(liste)
		end	
		liste.secili = {-1,-1}
	end
	liste.rows = {}		
end
function MLguiGridListSetColumnTitle(liste,col,yazi)	
	local liste = getListe(liste)
	if not liste.cols[col] then return false end
	return guiSetText(liste.cols[col].yazi,yazi)
end
function MLguiGridListSetColumnAlign(liste,col,align)	
	local liste = getListe(liste)
	if not liste.cols[col] then return false end
	return guiLabelSetHorizontalAlign(liste.cols[col].yazi,align or "center")
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
	
	if getElementType(liste.texts[row][col].yazi) == "gui-label" then  guiLabelSetColor(liste.texts[row][col].yazi,r,g,b) end
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
	--TODO
end
function MLguiGridListSetVerticalScrollPosition(liste,fPosition)
	--TODO
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
	return guiGetText(elm) or ""
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
function getListe(elm)
	return type(elm) == "table" and elm or getGuiElement(elm)
end
function rePositionRows(liste,fromRow)
	-- local totalWidth = 0
	for i=fromRow+1,#liste.rows do
		local arkaY = i == 1 and 21 or (liste.texts[i-1][0].y+liste.texts[i-1][0].g)+1
		if liste.texts[i][0].arka then
			_guiSetPosition(liste.texts[i][0].arka,0,arkaY,false)
			liste.texts[i][0].y = arkaY
		end
		-- totalWidth = totalWidth+liste.texts[i][0].y
	end
	local totalWidth = liste.texts[#liste.rows][0].y + liste.texts[#liste.rows][0].g
	if totalWidth < liste.u and liste.scrollarka  then
		destroyScroll(liste)
	end
	if totalWidth > liste.u and not liste.scrollarka then
		liste.scrollarka = guiCreateStaticImage(liste.g-10,20,10,liste.u,bosresim,false,liste.resim)
		liste.scrollkenar = guiCreateStaticImage(0,0,1,liste.u,bosresim,false,liste.scrollarka)
		guiSetAlpha(liste.scrollkenar,0.4) renkVer(liste.scrollarka,"020202") 
		liste.scroll = guiCreateStaticImage(0,0,10,20,bosresim,false,liste.scrollarka)
		scrolls[liste.scroll]={liste.scrollarka,liste.enarka}
	end
end
function destroyScroll(liste)
	scrolls[liste.scroll] = nil
	destroyElement(liste.scrollarka)
	liste.scrollarka = nil
end


addEventHandler( "onClientGUIMouseDown", resourceRoot,function ( btn, x, y )
	local scroll = scrolls[source]
	if btn == "left" and scroll then
		clickedScroll = source
		local elementPos = { _guiGetPosition( source, false ) }
		local g,u = _guiGetSize(scroll[1],false)
		offset = {elementPos[ 1 ], y - elementPos[ 2 ],u,scroll[2] }
		addEventHandler( "onClientCursorMove", root,moveScroll)
	end
end)
addEventHandler( "onClientGUIMouseUp", resourceRoot,function ( btn, x, y )
	if btn == "left"  then
		clickedScroll = nil
		removeEventHandler( "onClientCursorMove", root,moveScroll)
	end
end)
function moveScroll(_, _, rx, ry)
	if clickedScroll then
		local x,y,u,enarka = unpack(offset)
		local last = nil
		local _,gu = _guiGetSize(clickedScroll,false)
		local px,py = _guiGetPosition(enarka,false)
		local pg,pu = _guiGetSize(enarka,false)
		if (ry-y+18)+gu < u and (ry-y) > -2 then 
			_guiSetPosition(clickedScroll, x, ry-y, false )
			guiScrollPaneSetVerticalScrollPosition(enarka,((ry-y)/(u-40)*(100)))
		end	
	end
end
addEventHandler("onClientMouseEnter", resourceRoot, function()
	for liste,v in pairs(gui["guilist"]) do
		for row,a in pairs(v.texts) do
			for col,k in pairs(a) do
				if source == k.yazi and not k.secili then
					guiSetAlpha(a[0].arka, 0.5)
					onTop = {list=liste,row=row,col=col}
					break
				end
			end	
		end	
	end
end)
addEventHandler("onClientMouseLeave", resourceRoot, function()
	if onTop and onTop.row then
		guiSetAlpha(gui["guilist"][onTop.list].texts[onTop.row][0].arka, 1)
		onTop={}
	end
end)
addEventHandler("onClientGUIClick", resourceRoot, function(b,s,x,y)
	if onTop and onTop.row then
		local g = gui["guilist"][onTop.list].texts[onTop.row][onTop.col]
		if source == g.yazi and not g.secili then
			-- MLguiGridListSetSelectedItem(gui["guilist"][onTop.list],onTop.row,onTop.col)
			MLguiGridListSetSelectedItem(gui["guilist"][onTop.list],onTop.row,(gui["guilist"][onTop.list].texts[onTop.row][1]) and 1 or onTop.col)
			triggerEvent("onClientGUIClick",gui["guilist"][onTop.list].resim,b,s,x,y)
		elseif source == gui["guilist"][onTop.list].enarka then
			MLguiGridListSetSelectedItem(gui["guilist"][onTop.list],-1,-1)
			triggerEvent("onClientGUIClick",gui["guilist"][onTop.list].resim,b,s,x,y)
			onTop = nil
		end
	end
end)
addEventHandler("onClientGUIDoubleClick", resourceRoot, function(b,s,x,y)
	if onTop and onTop.row then
		local g = gui["guilist"][onTop.list].texts[onTop.row][onTop.col]
		if source == g.yazi and not g.secili then
			triggerEvent("onClientGUIDoubleClick",gui["guilist"][onTop.list].resim,b,s,x,y)
		end	
	end	
end)
addEventHandler("onClientMouseWheel",resourceRoot,function(yon)
	if onTop and onTop.row and  gui["guilist"][onTop.list].scrollarka then
		local v = gui["guilist"][onTop.list]
		local px,py = guiGetPosition(v.scroll,false)
		local pg,pu = guiGetSize(v.scrollarka,false)
		if yon == 1 then
			if (py-10) > -6 then
				_guiSetPosition(v.scroll, px, py-10, false )
				guiScrollPaneSetVerticalScrollPosition(v.enarka,((py-10)/(pu-40)*(100)))
			end	
		else
			if (py+10) < pu-36 then
				_guiSetPosition(v.scroll, px, py+10, false )
				guiScrollPaneSetVerticalScrollPosition(v.enarka,((py+10)/(pu-40)*(100)))
			end	
		end	
	end
end)

