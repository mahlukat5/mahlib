-- full gui
_guiCreateTabPanel = guiCreateTabPanel
_guiCreateTab = guiCreateTab
_guiSetSelectedTab = guiSetSelectedTab
_guiGetSelectedTab = guiGetSelectedTab
_guiDeleteTab = guiDeleteTab



function guiCreateTabPanel(x,y,g,u,relative,parent,kenarrenk)
	local sira = #tabs+1
	if not tabs[sira] then tabs[sira] = {} end
	local t = tabs[sira]
	if not kenarrenk or string.len(kenarrenk) > 6 then
		kenarrenk =  "1883D7"
	end
	if relative  then
		px,pu = guiGetSize(parent,false)
		x,y,g,u = x*px,y*pu,g*px,u*pu
		relative = false
	end
	
	t.resim = guiCreateLabel(x,y,g,u,"",relative,parent)
	t.x,t.y = guiGetPosition(t.resim,false)
	t.g,t.u = guiGetSize(t.resim,false)
	t.secili,t.tabciklar = nil,{}
	
	t.tabciklar[0] = {}
	t.tabciklar[0].arka = guiCreateLabel(0,0,0,0,"",false,t.resim)
	t.kenarlar = {
		--ortaUst = guiCreateStaticImage(0,20,t.g,1,resimOlustur("test"), false, t.resim),
		ortaAlt = guiCreateStaticImage(0,t.u-1,t.g,1,resimOlustur("test"), false, t.resim),
		sol = guiCreateStaticImage(0,20,1,t.u-20,resimOlustur("test"), false, t.resim),
		sag = guiCreateStaticImage(t.g-1,20,1,t.u-20,resimOlustur("test"), false, t.resim)
	}
	
	for i,v in pairs(t.kenarlar) do
		renkVer(v,kenarrenk)
		guiSetProperty(v, "AlwaysOnTop", "True")
		guiSetAlpha(v, 0.4)
	end	
	if not scriptler[sourceResource] then scriptler[sourceResource] = {} end
	if not scriptler[sourceResource]["t"] then scriptler[sourceResource]["t"] = {} end
	table.insert(scriptler[sourceResource]["t"], {tabs,sira,t.resim})

	return t.resim
end
function guiCreateTab(yazi,parent,alanrenk)
	local t = getTabPanel(parent)
	local sira = #t.tabciklar+1
	if not t.tabciklar[sira] then t.tabciklar[sira] = {} end
	local tab = t.tabciklar[sira]
	if not alanrenk or string.len(alanrenk) > 6 then
		alanrenk =  "000000" 
	end
	tab.alanrenk = alanrenk
	
	local ox,oy = guiGetPosition(t.tabciklar[sira-1].arka,false) 
	local og,op = guiGetSize(t.tabciklar[sira-1].arka,false)
	local yuzunluk = string.len(yazi)*8
	tab.arka = guiCreateStaticImage((ox+og),0,yuzunluk,20,resimOlustur("test",255),false,parent)
	tab.kose = guiCreateStaticImage(0,19,yuzunluk,1,resimOlustur("test",255),false,tab.arka)
	renkVer(tab.arka,"000000")
	renkVer(tab.kose,"1883D7")
	
	tab.yazi = guiCreateLabel(0,0,yuzunluk,20,yazi,false,tab.arka)
	guiLabelSetHorizontalAlign(tab.yazi, "center")
	guiLabelSetVerticalAlign(tab.yazi, "center")
	
	tab.alan = guiCreateStaticImage(0,20.2,t.g,t.u,resimOlustur("test",255),false,parent)
	renkVer(tab.alan,alanrenk) _guiSetVisible(tab.alan,false) guiSetAlpha(tab.arka,0.7)
	if sira == 1 then
		tab.secili = true
		_guiSetVisible(tab.alan,true)
		guiSetSelectedTab(parent,tab.alan)
		guiSetAlpha(tab.arka,1)
		renkVer(tab.arka,alanrenk)
	end	
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
	for i,v in pairs(ttab) do
		if isElement(v) then destroyElement(v) end
	end	
	table.remove(t.tabciklar,sira)
	for i=1,#t.tabciklar do
		local ox,oy = guiGetPosition(t.tabciklar[i-1].arka,false) 
		local og,op = guiGetSize(t.tabciklar[i-1].arka,false)
		guiSetPosition(t.tabciklar[i].arka,ox+og,0,false)
	end
end

addEventHandler("onClientMouseEnter", resourceRoot, function()
	for i,v in pairs(tabs) do
		for i,t in pairs(v.tabciklar) do
			if source == t.yazi and not t.secili then
				guiSetAlpha(t.arka,0.6)
				renkVer(t.arka,t.alanrenk)
			end
		end	
	end
end)
addEventHandler("onClientMouseLeave", resourceRoot, function()
	for i,v in pairs(tabs) do
		for i,t in pairs(v.tabciklar) do
			if source == t.yazi and not t.secili then
				guiSetAlpha(t.arka,0.7)
				renkVer(t.arka,"000000")
			end
		end	
	end
end)
addEventHandler("onClientGUIClick", resourceRoot, function()
	for i,v in pairs(tabs) do
		for i,t in pairs(v.tabciklar) do
			if source == t.yazi then
				guiSetSelectedTab(v.resim,t.alan)
				triggerEvent("onClientGUITabSwitched", t.alan, t.alan)
			end
		end	
	end
end)


function getTabPanel(element)
	if type(element) ~= "table" then
		for i,v in pairs(tabs) do
			if v.resim == element then
				return tabs[i]
			end
		end
	else
		return element
	end	
end
function getTab(tabpanel,element)
	for i,v in pairs(tabpanel.tabciklar) do
		if v.alan == element then
			return v,i
		end
	end
	return false
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
	-- guiDeleteTab(tab4,tab)
-- end)

-- showCursor(true)