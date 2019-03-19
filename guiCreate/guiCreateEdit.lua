function guiCreateEdit(x,y,g,u,yazi,relative,parent,kenarrenk)
	esayi = #etablo +1
	if not etablo[esayi] then etablo[esayi] = {} end
	local e = etablo[esayi]
	
	if not kenarrenk or string.len(kenarrenk) > 6 then
		kenarrenk =  "1883D7"
	end
	
	if relative  then
		if parent then px,pu = guiGetSize(parent,false) end
		if not parent then px,pu = guiGetScreenSize() end
		x,y,g,u = x*px,y*pu,g*px,u*pu
	end
	
	e.resim = guiCreateLabel(x,y,g,u, "", false, parent)
	e.edit = _guiCreateEdit(-7,-5,g+15, u+8,yazi,false, e.resim)
	
	e.kenarlar = {
		ortaUst = guiCreateStaticImage(0,0,g,1,resimOlustur("test"), false, e.resim),
		ortaAlt = guiCreateStaticImage(0,u-1,g,1,resimOlustur("test"), false, e.resim),
		sol = guiCreateStaticImage(0,0,1,u,resimOlustur("test"), false, e.resim),
		sag = guiCreateStaticImage(g-1,0,1,u,resimOlustur("test"), false, e.resim),
	}

	for i,v in pairs(e.kenarlar) do
		renkVer(v,kenarrenk)
		guiSetProperty(v, "AlwaysOnTop", "True")
		guiSetAlpha(v, 0.4)
	end	
	
	if not scriptler[sourceResource] then scriptler[sourceResource] = {} end
	if not scriptler[sourceResource]["e"] then scriptler[sourceResource]["e"] = {} end
	table.insert(scriptler[sourceResource]["e"], {etablo,esayi,e.resim})

	renkVer(e.resim,kenarrenk)
	genelGuiTablo[e.edit] = e.kenarlar
	return e.edit
end