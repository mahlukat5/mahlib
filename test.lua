local sx,sy = guiGetScreenSize()
local pg,pu = 600,400
local x,y = (sx-pg)/2,(sy-pu)/2 -- panelgenislik,paneluzunluk

local panel = guiCreateWindow(x,y,pg,pu,"Lib Test Panel",false)
-- guiWindowSetCloseVisible(panel,false)
-- guiWindowSetMovable(panel,false)
guiSetVisible(panel,false)

local tabpanel = guiCreateTabPanel(10,30,pg-20,pu-60,false,panel)
local tab1 = guiCreateTab("TabPanel Tab 1",tabpanel)
local tab2 = guiCreateTab("TabPanel Tab 2",tabpanel,"CC0000")
local tab3 = guiCreateTab("TabPanel Tab 3",tabpanel,"GGGGGG")
local tab4 = guiCreateTab("TabPanel Tab 4",tabpanel,"a5a5a5")
local tab5 = guiCreateTab("TabPanel Tab 5",tabpanel,"c4b2b2")

local tab1liste = guiCreateGridList(10,20,150,150,false,tab1)
guiGridListAddColumn(tab1liste,"GridList",0.9)
for i=1,10 do
	local row = guiGridListAddRow(tab1liste)
	guiGridListSetItemText(tab1liste,row,1,"test "..i,false,false)
	guiGridListSetItemColor(tab1liste,row,1,math.random(255),math.random(255),math.random(255),255)
end

local tab1liste_ozel = MLguiCreateGridList(180,20,150,150,false,tab1)
MLguiGridListAddColumn(tab1liste_ozel,"GridList",0.9)
for i=1,4 do
	local row = MLguiGridListAddRow(tab1liste_ozel)
	MLguiGridListSetItemText(tab1liste_ozel,row,1,"test "..i,false,false)
	MLguiGridListSetItemBackColor(tab1liste_ozel,row,tostring(math.random(999999)))
	MLguiGridListSetItemColor(tab1liste_ozel,row,1,math.random(255),math.random(255),math.random(255),255)
end

local tab1liste_ozel2 = MLguiCreateGridList(350,20,150,150,false,tab1)
MLguiGridListAddColumn(tab1liste_ozel2,"GridList",0.9)
local flags = {"tr","ac","ad","ae","af","ag","ai","al","am","an"}
for i=1,10 do
	local row = MLguiGridListAddRow(tab1liste_ozel2)
	MLguiGridListSetItemImage(tab1liste_ozel2,row,1,":admin/client/images/flags/"..flags[i]..".png",16,16)
	MLguiGridListSetItemBackColor(tab1liste_ozel2,row,tostring(math.random(999999)))
end

local tab2memo = guiCreateMemo(10,20,150,150,"Memo",false,tab2)

for i=1,10 do
	buton = guiCreateButton(10,20+(25)*(i-1),100,20,"Buton "..i,false,tab3,math.random(999999))
end
for i=1,10 do
	edit = guiCreateEdit(10+105,20+(25)*(i-1),100,20,"Edit "..i,false,tab3)
end



-- local s = _guiCreateWindow(0,y,pg,pu,"test",false)
-- local s = _guiCreateWindow(pg,y,pg,pu,"test2",false)
-- guiSetProperty(s,"FrameEnabled", "false")
-- guiSetProperty(s,"BackgroundEnabled", "false")
-- guiSetProperty(s,"DestroyedByParent", "false")
-- local s2 = guiCreateStaticImage(0,0,pg,pu-50,bosresim,false,s)
-- local w  = _guiCreateWindow(0,0,pg,pu,"asdasd",false,s)