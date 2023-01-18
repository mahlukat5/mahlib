local sx,sy = guiGetScreenSize()
local pg,pu = 600,400
local x,y = (sx-pg)/2,(sy-pu)/2 -- panelgenislik,paneluzunluk
local flags = {"tr","ac","ad","ae","af","ag","ai","al","am","an"}

-- local buton = guiCreateButton(x,y,pg,200,"Buton",false)

local panel = guiCreateWindow(x,y,pg,pu,"Lib Test Panel",false)
-- guiWindowSetCloseVisible(panel,false)
guiWindowSetSizable(panel,true)
-- guiSetVisible(panel,false)
showCursor(true)
bindKey("3","down",function()
	guiSetVisible(panel,not guiGetVisible(panel))
	showCursor(guiGetVisible(panel))
end)

local tabpanel = guiCreateTabPanel(10,30,pg-20,pu-60,false,panel)
local tab1 = guiCreateTab("TabPanel Tab 1",tabpanel)
local tab2 = guiCreateTab("TabPanel Tab 22222",tabpanel,"CC0000")
local tab3 = guiCreateTab("TabPanel Tab 3",tabpanel,"GGGGGG")
-- local tab4 = guiCreateTab("TabPanel Tab 4",tabpanel,"a5a5a5")
-- local tab5 = guiCreateTab("TabPanel Tab 5",tabpanel,"c4b2b2")
guiTabSetHorizontalAlign(tabpanel,"center")

-- guiCreateStaticImage(0.5,0.07,0.01,1,bosresim,true,tabpanel)

local tab1liste = guiCreateGridList(10,20,150,150,false,tab1)
guiGridListAddColumn(tab1liste,"G1",0.2)
guiGridListAddColumn(tab1liste,"G2",0.2)
guiGridListAddColumn(tab1liste,"G3",0.2)
for i=1,10 do
	local row = guiGridListAddRow(tab1liste)
	guiGridListSetItemText(tab1liste,row,1,"test "..i,false,false)
	guiGridListSetItemText(tab1liste,row,3,"test3 "..i,false,false)
	guiGridListSetItemColor(tab1liste,row,1,math.random(255),math.random(255),math.random(255),255)
end

local tab1liste_ozel = MLguiCreateGridList(180,20,200,280,false,tab1)
MLguiGridListAddColumn(tab1liste_ozel,"Colum_Center",0.5)
MLguiGridListAddColumn(tab1liste_ozel,"Column_Right",0.5,"right")
MLguiGridListSetColumnAlign(tab1liste_ozel,1,"center")	
for i=1,5 do
	local row = MLguiGridListAddRow(tab1liste_ozel)
	local buyukluk = math.random(20,100)
	MLguiGridListSetItemText(tab1liste_ozel,row,1,"sira: "..i.." height: "..buyukluk,false,false)
	MLguiGridListSetItemImage(tab1liste_ozel,row,2,":admin/client/images/flags/"..flags[i]..".png",20,math.random(0,buyukluk-16),16,16)
	MLguiGridListSetItemWidth(tab1liste_ozel,row,buyukluk)
end

addEventHandler("onClientGUIClick",tab1liste_ozel,function()
	local row,col = MLguiGridListGetSelectedItem(tab1liste_ozel)
	if row ~= -1 then
		local buyukluk = math.random(20,100)
		MLguiGridListSetItemImage(tab1liste_ozel,row,2,":admin/client/images/flags/"..flags[row]..".png",20,math.random(0,buyukluk-16),16,16)
		MLguiGridListSetItemWidth(tab1liste_ozel,row,buyukluk)
	end
end,false)

local tab1liste_ozel2 = MLguiCreateGridList(400,20,150,280,false,tab1)
MLguiGridListAddColumn(tab1liste_ozel2,"GridList Image",1)
for i=1,10 do
	local row = MLguiGridListAddRow(tab1liste_ozel2)
	MLguiGridListSetItemImage(tab1liste_ozel2,row,1,":admin/client/images/flags/"..flags[i]..".png",math.random(130),2,16,16)
	MLguiGridListSetItemBackColor(tab1liste_ozel2,row,tostring(math.random(999999)))
end

local tab2memo = guiCreateMemo(10,20,150,150,"Memo",false,tab2)

for i=1,10 do
	buton = guiCreateButton(10,20+(25)*(i-1),100,20,"Buton "..i,false,tab3,math.random(999999))
end
for i=1,10 do
	edit = guiCreateEdit(10+105,20+(25)*(i-1),100,20,"Edit "..i,false,tab3)
end
