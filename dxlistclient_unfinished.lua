-- full dx
-- Tamamlanmadı.(yapamadım) yapmak isteyen örnek kodlar üzerinden devam edebilir.
local sx,sy = guiGetScreenSize()
local pg,pu = 500,330
local x,y = (sx-pg)/2, (sy-pu)/2
local lists = {}

function guiCreateGridList(x,y,g,u,rel,parent)
	local sira = #lists+1
	if not lists[sira] then lists[sira] = {} end
	local l = lists[sira]	
	l.x,l.y,l.g,l.u = x,y,g,u	
	l.rel,l.parent = rel,parent
	l.cols,l.rows,l.texts,l.satir,l.scrolY = {},{},{},1,17
	return l
end
function guiGridListAddColumn(liste,baslik,uzunluk)
	local sira = #liste.cols+1
	if not liste.cols[sira] then liste.cols[sira] = {} end
	
	liste.cols[0] = {"",liste.x}	
	liste.cols[sira] = {baslik,uzunluk}	
	return liste.cols[sira]
end
function guiGridListAddRow(liste,...)
	local sira = #liste.rows+1
	if not liste.rows[sira] then liste.rows[sira] = {} end
	return sira
end
function guiGridListSetItemText(liste,row,col,yazi,secili)
	if not liste.rows[row] then print("guiGridListSetItemText row yok mq") return end
	if not liste.texts[row] then liste.texts[row] = {} end
	liste.texts[row] = {col,yazi,secili}
	return true
end

--local pencere = guiCreateWindow(x,y,pg,pu,"List Test",false)
local liste = guiCreateGridList(x,y,pg,pu,false)
guiGridListAddColumn(liste,"Test",0.25)
guiGridListAddColumn(liste,"asdasdd",0.25)
guiGridListAddColumn(liste,"hahaha",0.25)

for i=1,20 do
	local row = guiGridListAddRow(liste)
	guiGridListSetItemText(liste,row,1,"Test Row "..i,false)
end

addEventHandler("onClientRender", root, function()
	for i,v in pairs(lists)	do
		local x,y,g,u = v.x,v.y,v.g,v.u
		if v.parent then
			if not guiGetVisible(v.parent) then return end
			local px,py = guiGetPosition(v.parent,false)
			x,y = px+x,py+y
		end
	
		dxDrawRectangle(x,y,g,u,tocolor(0,0,0,180),true,true) -- ana tablo
		if #v.cols > 0 then
			dxDrawRectangle(x,y,g,18,tocolor(0,0,0,200),true,false) -- baslik
			for col=1,#v.cols do
				local baslikyazi,Cuzunluk = unpack(v.cols[col])
				local Yuzunluk = dxGetTextWidth(baslikyazi,1,"default-bold")
				local Cuzunluk = v.cols[col-1][2]*g
				dxDrawText(baslikyazi,x+Cuzunluk*(col-1)+5,y,g,u,tocolor(255,255,255,255),1,"default-bold","left",nil,nil,nil,true)
				local renk = tocolor(255,255,255,255)
				if col > 1 then
					renk = tocolor(255,0,0,255)
				end	
				if col == #v.cols then
					Cuzunluk = v.cols[col][2]*g
				end	
				--dxDrawLine(x+Cuzunluk,y+17,x+v.cols[col][2]*g,y+17,renk,1,true)
				--dxDrawLine(Cuzunluk+v.cols[col][2]*g,y,Cuzunluk+v.cols[col][2]*g,y+18,renk,1,true)
			end
			if #v.texts > 0 then
				for txt=v.satir,#v.texts do
					local col,yazi,secili = unpack(v.texts[txt])
					local Cuzunluk = v.cols[col-1][2]*g
					local recy= y+(17*(txt))
					if recy+16 < y+u then
						dxDrawRectangle(x,recy,g,16,tocolor(0,0,0,100),true,false)
						dxDrawText(yazi,x+Cuzunluk*(col-1)+5,y+(17*(txt)),g,u,tocolor(255,255,255,255),1,"default-bold","left",nil,nil,nil,true)
						if isMouseInPosition(x,y+(17*(txt)),g,16) then
							dxDrawRectangle(x,y+(17*(txt)),g,16,tocolor(66,134,244,50),true,false)
						end
					else
						--scrolY = y+v.scrolY
						if isMouseInPosition(x,y+v.scrolY,g,16) then
							if getKeyState("mouse1") then
								local cx, cy = getCursorPosition ()
								local cy = cy*sy
								--v.scrolY = v.scrolY-cy
								--v.satir = v.satir +1
							end
						end	
						dxDrawRectangle(x+g-15,y+17,15,u-17,tocolor(0,0,0,100),true,false)
						dxDrawRectangle(x+g-15,y+v.scrolY,15,20,tocolor(0,255,0,200),true,false)
					end	
				end
			end
		end
	end
end, true, "low-5")

function isMouseInPosition(x,y,width,height)
	if ( not isCursorShowing( ) ) then
		return false
	end
    local sx, sy = guiGetScreenSize ( )
    local cx, cy = getCursorPosition ( )
    local cx, cy = ( cx * sx ), ( cy * sy )
    if ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) then
        return true
    else
        return false
    end
end

showCursor(true)

bindKey("e", "down",function()
	guiSetVisible(pencere,not guiGetVisible(pencere))

end)