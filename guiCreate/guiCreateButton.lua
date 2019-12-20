function guiCreateButton(x,y,g,u,yazi,relative,parent,renk1,renk2,kenaralpha)
	bsayi = #btablo +1
	if not btablo[bsayi] then btablo[bsayi] = {} end
	local b = btablo[bsayi]
	
	if not renk1 or string.len(renk1) > 6 then
		--renk = math.random(999999)
		renk1 = "131314" -- genel buton rengi
	end
	if not renk2 or string.len(renk2) > 6 then
		renk2 = "FFFFFF" -- buton kenar rengi
	end
	kenaralpha = kenaralpha or 0.4
	--arkaResim
	if relative  then
		if parent then px,pu = guiGetSize(parent,false) end
		if not parent then px,pu = guiGetScreenSize() end
		x,y,g,u = x*px,y*pu,g*px,u*pu
	end
	relative = false
	b.resim = guiCreateStaticImage(x,y,g,u,resimOlustur("test"),false,parent)
	--kenarlar
	b.kenarlar = {
		ortaUst = guiCreateStaticImage(0,0,g,1,resimOlustur("test"), relative, b.resim),
		ortaAlt = guiCreateStaticImage(0,u-1,g,1,resimOlustur("test"), relative, b.resim),
		sol = guiCreateStaticImage(0,0,1,u,resimOlustur("test"), relative, b.resim),
		sag = guiCreateStaticImage(g-1,0,1,u,resimOlustur("test"), relative, b.resim),
	}
	
	for i,v in pairs(b.kenarlar) do
		renkVer(v,renk2)
		guiSetAlpha(v, kenaralpha)
	end	
	--label
	b.label = guiCreateLabel(0,0,g,u,yazi,relative,b.resim)
	guiLabelSetHorizontalAlign(b.label, "center")
	guiLabelSetVerticalAlign(b.label, "center")
	guiSetFont(b.label, font1)
	
	if not scriptler[sourceResource] then scriptler[sourceResource] = {} end
	if not scriptler[sourceResource]["b"] then scriptler[sourceResource]["b"] = {} end
	table.insert(scriptler[sourceResource]["b"], {btablo,bsayi,b.resim})
	
	renkVer(b.resim,renk1)
	genelGuiTablo[b.label] = b.kenarlar
	return b.label 
end
