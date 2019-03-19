function guiCreateWindow(x,y,g,u,yazi,relative,parent,renk1,renk2,renk3,renk4,font,kapat)
	wsayi = #wtablo +1
	if not wtablo[wsayi] then wtablo[wsayi] = {} end
	local w = wtablo[wsayi]
	if not renk1 or string.len(renk1) > 6 then
		renk1 =  "000000" -- window renk üst taraf
	end
	if not renk2 or string.len(renk2) > 6 then
		renk2 = "000000" -- window renk alt taraf
	end
	if not renk3 or string.len(renk3) > 6 then
		renk3 = "202225" -- baslik renk
	end
	if not renk4 or string.len(renk4) > 6 then
		renk4 = "1883D7"  -- window kenar çizgi
	end
	
	if relative  then
		if parent then px,pu = guiGetSize(parent,false) end
		if not parent then px,pu = guiGetScreenSize() end
		x,y,g,u = x*px,y*pu,g*px,u*pu
	end
	

	--arkaResim
	w.resim = guiCreateStaticImage(x,y,g,u,resimOlustur("test"),false,parent)
	guiSetProperty(w.resim,"ImageColours","tl:FF"..renk1.." tr:FF"..renk1.." bl:FF"..renk2.." br:FF"..renk2.."")
	--baslıkArka
	w.basarka = guiCreateStaticImage(0,0,g,20, resimOlustur("test"), false, w.resim)
	--kenarlar
	w.kenarlar = {
		ortaUst = guiCreateStaticImage(0,0,g,1,resimOlustur("test"), false, w.resim),
		ortaAlt = guiCreateStaticImage(0,u-1,g,1,resimOlustur("test"), false, w.resim),
		sol = guiCreateStaticImage(0,0,1,u,resimOlustur("test"), false, w.resim),
		sag = guiCreateStaticImage(g-1,0,1,u,resimOlustur("test"), false, w.resim),
	}
	
	for i,v in pairs(w.kenarlar) do
		renkVer(v,renk4)
		guiSetProperty(v, "AlwaysOnTop", "True")
		guiSetAlpha(v, 0.4)
	end	
	--baslıkLabel
	w.label = guiCreateLabel((g/2)-((string.len(yazi)*8)/2),0,(string.len(yazi)*8),20, yazi, false, w.basarka)
	guiSetFont(w.label, font or font1)
	guiLabelSetHorizontalAlign(w.label, "center")
	guiLabelSetVerticalAlign(w.label, "center")
	--kapatArka
	if not kapat then
		w.kapatArka = guiCreateStaticImage(g-25,1,25,20,resimOlustur("test"),false,w.basarka)
		guiSetAlpha(w.kapatArka, 0.5)
		--kapatLabel
		w.kapat = guiCreateLabel(0,-2,25,20, "X", false, w.kapatArka)
		guiSetFont(w.kapat, "default-bold-small")
		guiLabelSetHorizontalAlign(w.kapat, "center")
		guiLabelSetVerticalAlign(w.kapat, "center")
	end	
	w.move = true
	
	if not scriptler[sourceResource] then scriptler[sourceResource] = {} end
	if not scriptler[sourceResource]["w"] then scriptler[sourceResource]["w"] = {} end
	table.insert(scriptler[sourceResource]["w"], {wtablo,wsayi,w.resim})
	
	renkVer(w.resim,renk1)
	renkVer(w.basarka,renk3)
	renkVer(w.kapatArka,"E81123")
	return w.resim,w.basarka
end