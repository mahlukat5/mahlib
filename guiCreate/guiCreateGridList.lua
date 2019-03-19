function guiCreateGridList(x,y,g,u,relative,parent,kenarrenk)
	Lsayi = #Ltablo +1
	if not Ltablo[Lsayi] then Ltablo[Lsayi] = {} end
	local L = Ltablo[Lsayi]
	
	if not kenarrenk or string.len(kenarrenk) > 6 then
		kenarrenk =  "1883D7"
	end
		
	if relative  then
		if parent then px,pu = guiGetSize(parent,false) end
		if not parent then px,pu = guiGetScreenSize() end
		x,y,g,u = x*px,y*pu,g*px,u*pu
	end
	
	L.resim = guiCreateLabel(x,y,g,u, "", false, parent)
	L.liste = _guiCreateGridList(-8,-10,g+20, u+18,false, L.resim)
	
	L.kenarlar = {
		ortaUst = guiCreateStaticImage(0,0,g,1,resimOlustur("test"), false, L.resim),
		ortaAlt = guiCreateStaticImage(0,u-1,g,1,resimOlustur("test"), false, L.resim),
		sol = guiCreateStaticImage(0,0,1,u,resimOlustur("test"), false, L.resim),
		sag = guiCreateStaticImage(g-1,0,1,u,resimOlustur("test"), false, L.resim),
	}

	for i,v in pairs(L.kenarlar) do
		renkVer(v,kenarrenk)
		guiSetProperty(v, "AlwaysOnTop", "True")
		guiSetAlpha(v, 0.4)
	end	
	
	if not scriptler[sourceResource] then scriptler[sourceResource] = {} end
	if not scriptler[sourceResource]["L"] then scriptler[sourceResource]["L"] = {} end
	table.insert(scriptler[sourceResource]["L"], {Ltablo,Lsayi,L.resim})

	genelGuiTablo[L.liste] = L.kenarlar
	return L.liste
end



