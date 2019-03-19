function guiCreateMemo(x,y,g,u,yazi,relative,parent,kenarrenk)
	msayi = #mtablo +1
	if not mtablo[msayi] then mtablo[msayi] = {} end
	local m = mtablo[msayi]
	
	if not kenarrenk or string.len(kenarrenk) > 6 then
		kenarrenk =  "1883D7"
	end
		
	if relative  then
		if parent then px,pu = guiGetSize(parent,false) end
		if not parent then px,pu = guiGetScreenSize() end
		x,y,g,u = x*px,y*pu,g*px,u*pu
	end

	m.resim = guiCreateLabel(x,y,g,u, "", false, parent)
	m.memo = _guiCreateMemo(-5,-10,g+15, u+10, yazi,false, m.resim)
	
	m.kenarlar = {
		ortaUst = guiCreateStaticImage(0,0,g,1,resimOlustur("test"), false, m.resim),
		ortaAlt = guiCreateStaticImage(0,u-1,g,1,resimOlustur("test"), false, m.resim),
		sol = guiCreateStaticImage(0,0,1,u,resimOlustur("test"), false, m.resim),
		sag = guiCreateStaticImage(g-1,0,1,u,resimOlustur("test"), false, m.resim),
	}
	
	for i,v in pairs(m.kenarlar) do
		renkVer(v,kenarrenk)
		guiSetProperty(v, "AlwaysOnTop", "True")
		guiSetAlpha(v, 0.4)
	end	
	
	if not scriptler[sourceResource] then scriptler[sourceResource] = {} end
	if not scriptler[sourceResource]["m"] then scriptler[sourceResource]["m"] = {} end
	table.insert(scriptler[sourceResource]["m"], {mtablo,msayi,m.resim})
	

	renkVer(m.resim,kenarrenk)
	genelGuiTablo[m.memo] = m.kenarlar
	return m.memo
end