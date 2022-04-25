function guiCreateEdit(x,y,g,u,yazi,relative,parent)
	esayi = #gui["e"] +1
	if not gui["e"][esayi] then gui["e"][esayi] = {} end
	local e = gui["e"][esayi]
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
	table.insert(scriptler[sourceResource]["e"], {esayi,e.resim})

	genelGuiTablo[e.edit]={i=esayi,t="e"}
	return e.edit
end

--set:389e image:389f