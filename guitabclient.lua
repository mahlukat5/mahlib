-- full gui
_guiCreateTabPanel = guiCreateTabPanel
_guiCreateTab = guiCreateTab
_guiSetSelectedTab = guiSetSelectedTab
_guiGetSelectedTab = guiGetSelectedTab
_guiDeleteTab = guiDeleteTab



function guiCreateTabPanel(x,y,g,u,relative,parent)
	local sira = #gui["t"]+1
	if not gui["t"][sira] then gui["t"][sira] = {} end
	local t = gui["t"][sira]
	if relative  then
		px,pu=getParentSize(parent)
		x,y,g,u=x*px,y*pu,g*px,u*pu
	end
	t.resim = guiCreateLabel(x,y,g,u,"",false,parent)
	t.x,t.y = x,y
	t.g,t.u = g,u
	t.secili,t.tabciklar = nil,{}
	
	t.tabciklar[0] = {}
	t.tabciklar[0].arka = guiCreateLabel(0,0,0,0,"",false,t.resim)
	t.kenarlar = {
		ortaAlt = createSideLine(0,t.u-1,t.g,1,t.resim,settings.tabpanel.side_lines),
		sol = createSideLine(0,20,1,t.u-20,t.resim,settings.tabpanel.side_lines),
		sag = createSideLine(t.g-1,20,1,t.u-20,t.resim,settings.tabpanel.side_lines)
	}
	if not scriptler[sourceResource] then scriptler[sourceResource] = {} end
	if not scriptler[sourceResource]["t"] then scriptler[sourceResource]["t"] = {} end
	table.insert(scriptler[sourceResource]["t"], {sira,t.resim})
	genelGuiTablo[t.resim]={i=sira,t="t"}
	return t.resim
end
function guiCreateTab(yazi,parent,alanrenk)
	local ind = genelGuiTablo[parent]
	local t = gui["t"][ind.i]
	local sira = #t.tabciklar+1
	if not t.tabciklar[sira] then t.tabciklar[sira] = {} end
	local tab = t.tabciklar[sira]
	if not alanrenk or string.len(alanrenk) > 6 then
		alanrenk =  "000000" 
	end
	tab.alanrenk = alanrenk
	
	local ox,oy = guiGetPosition(t.tabciklar[sira-1].arka,false) 
	local og,op = guiGetSize(t.tabciklar[sira-1].arka,false)
	local yuzunluk = utf8.len(yazi)*8
	tab.arka = guiCreateStaticImage((ox+og),0,yuzunluk,20,bosresim,false,parent)
	tab.kose = guiCreateStaticImage(0,19,yuzunluk,1,bosresim,false,tab.arka)
	renkVer(tab.arka,"000000")
	renkVer(tab.kose,"1883D7")
	
	tab.yazi = guiCreateLabel(0,0,yuzunluk,20,yazi,false,tab.arka)
	guiLabelSetHorizontalAlign(tab.yazi, "center") guiLabelSetVerticalAlign(tab.yazi, "center")
	
	tab.alan = guiCreateStaticImage(0,20,t.g,t.u,bosresim,false,parent)
	renkVer(tab.alan,alanrenk) _guiSetVisible(tab.alan,false) guiSetAlpha(tab.arka,0.7)
	tabciklar[tab.yazi] = {i=sira,t="t",pi=ind.i,label=true}
	tabciklar[tab.alan] = {i=sira,t="t",pi=ind.i}
	if sira == 1 then guiSetSelectedTab(parent,tab.alan) end	
	return tab.alan
end
function guiSetSelectedTab(tabpanel,tab)
	local t = getTabPanel(tabpanel)
	local ttab = getTab(t,tab)
	if t.secili then -- eskisini deaktif
		local ttab = getTab(t,t.secili)
		_guiSetVisible(t.secili,false)
		guiSetAlpha(ttab.arka,0.7)
		guiSetAlpha(ttab.kose,0.7)
		renkVer(ttab.arka,"000000")
		ttab.secili = nil
	end	
	-- yenisini aktif
	_guiSetVisible(tab,true)	
	guiSetAlpha(ttab.arka,1)
	guiSetAlpha(ttab.kose,0)
	renkVer(ttab.arka,ttab.alanrenk)
	ttab.secili = true
	t.secili = tab
end
function guiGetSelectedTab(tabpanel)
	local t = getTabPanel(tabpanel)
	return t.secili
end
function guiDeleteTab(tab,tabpanel)
	local t = getTabPanel(tabpanel)
	local ttab,sira = getTab(t,tab)
	if not ttab then return false end
	if isElement(ttab.arka) then _destroyElement(ttab.arka) end
	table.remove(t.tabciklar,sira)
	for i=1,#t.tabciklar do
		local ox,oy = guiGetPosition(t.tabciklar[i-1].arka,false) 
		local og,op = guiGetSize(t.tabciklar[i-1].arka,false)
		guiSetPosition(t.tabciklar[i].arka,ox+og,0,false)
	end
end


addEventHandler("onClientGUIClick", resourceRoot, function()
	local t = tabciklar[source]
	if t and t.label then
		guiSetSelectedTab(gui[t.t][t.pi].resim,gui[t.t][t.pi].tabciklar[t.i].alan)
		triggerEvent("onClientGUITabSwitched", gui[t.t][t.pi].tabciklar[t.i].alan, gui[t.t][t.pi].tabciklar[t.i].alan)
	end
end)


function getTabPanel(element)
	if type(element) ~= "table" then
		return getGuiElement(element)
	else
		return element
	end	
end
function getTab(tabpanel,element)
	local sira = tabciklar[element] 
	return gui["t"][sira.pi].tabciklar[sira.i],sira.i
end




-- local sx,sy = guiGetScreenSize()
-- local pg,pu = 500,337
-- local x,y = (sx-pg)/2, (sy-pu)/2

-- local pencere = guiCreateWindow(x,y,pg,pu,"img tab çalışmaları",false)
-- tab = guiCreateTabPanel(10,25,pg-20,pu-30,false,pencere)
-- tab2 = guiCreateTab("Test", tab,"9e9e9e")
-- tab3 = guiCreateTab("Testttt2", tab,"9e9e9e")
-- tab4 = guiCreateTab("uzunyazitestamcik", tab,"9e9e9e")
-- tab5 = guiCreateTab("Testttt4", tab,"9e9e9e")
-- tab6 = guiCreateTab("Testsssss5", tab,"9e9e9e")

-- local label = guiCreateLabel(10,10,100,100,"Testlabel",false,tab2)
-- local buton = guiCreateButton(10,30,100,20,"testButon",false,tab2)
-- local liste = guiCreateGridList(10,100,100,100,false,tab2)
-- guiGridListAddColumn(liste,"TestCol",1)

-- local edit = guiCreateEdit(10,0,100,25,"Test Edit",false,tab3)
-- local memo = guiCreateMemo(20,50,100,50,"Test Memo",false,tab4)

-- bindKey("3","down",function()
	-- guiSetText(tab4,"tab"..math.random(math.random(99999999)))
-- end)

-- showCursor(true)
