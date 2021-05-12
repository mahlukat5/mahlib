function guiCreateGridList(x,y,g,u,relative,parent)
	Lsayi = #Ltablo +1
	if not Ltablo[Lsayi] then Ltablo[Lsayi] = {} end
	local L = Ltablo[Lsayi]	
	if relative  then
		px,pu=getParentSize(parent)
		x,y,g,u=x*px,y*pu,g*px,u*pu
	end
	L.resim = guiCreateLabel(x,y,g,u, "", false, parent)
	L.liste = _guiCreateGridList(-8,-10,g+20, u+18,false, L.resim)
	L.kenarlar = {
		ortaUst = createSideLine(0,0,g,1,L.resim,settings.gridlist.side_lines),
		ortaAlt = createSideLine(0,u-1,g,1,L.resim,settings.gridlist.side_lines),
		sol = createSideLine(0,0,1,u,L.resim,settings.gridlist.side_lines),
		sag = createSideLine(g-1,0,1,u,L.resim,settings.gridlist.side_lines),
	}
	if not scriptler[sourceResource] then scriptler[sourceResource] = {} end
	if not scriptler[sourceResource]["L"] then scriptler[sourceResource]["L"] = {} end
	table.insert(scriptler[sourceResource]["L"], {Ltablo,Lsayi,L.resim})
	genelGuiTablo[L.liste]=L
	return L.liste
end
