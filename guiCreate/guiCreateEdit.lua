function guiCreateEdit(x,y,g,u,yazi,relative,parent)
	esayi = #etablo +1
	if not etablo[esayi] then etablo[esayi] = {} end
	local e = etablo[esayi]
	if relative  then
		px,pu=getParentSize(parent)
		x,y,g,u=x*px,y*pu,g*px,u*pu
	end	
	e.resim = guiCreateLabel(x,y,g,u, "", false, parent)
	e.edit = _guiCreateEdit(-7,-5,g+15, u+8,yazi,false, e.resim)
	e.kenarlar = {
		ortaUst = createSideLine(0,0,g,1,e.resim,settings.edit.side_lines),
		ortaAlt = createSideLine(0,u-1,g,1,e.resim,settings.edit.side_lines),
		sol = createSideLine(0,0,1,u,e.resim,settings.edit.side_lines),
		sag = createSideLine(g-1,0,1,u, e.resim,settings.edit.side_lines),
	}
	if not scriptler[sourceResource] then scriptler[sourceResource] = {} end
	if not scriptler[sourceResource]["e"] then scriptler[sourceResource]["e"] = {} end
	table.insert(scriptler[sourceResource]["e"], {etablo,esayi,e.resim})

	genelGuiTablo[e.edit]=e
	return e.edit
end
