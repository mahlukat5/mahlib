function guiCreateGridList(x,y,g,u,relative,parent)
	Lsayi = #gui["g"] +1
	if not gui["g"][Lsayi] then gui["g"][Lsayi] = {} end
	local L = gui["g"][Lsayi]	
	if relative  then
		px,pu=getParentSize(parent)
		x,y,g,u=x*px,y*pu,g*px,u*pu
	end
	L.resim = guiCreateLabel(x,y,g,u, "", false, parent)
	L.liste = _guiCreateGridList(-8,-10,g+18, u+18,false, L.resim)
	L.kenarlar = {
		ortaUst = createSideLine(0,0,g,1,L.resim,settings.gridlist.side_lines),
		ortaAlt = createSideLine(0,u-1,g,1,L.resim,settings.gridlist.side_lines),
		sol = createSideLine(0,0,1,u,L.resim,settings.gridlist.side_lines),
		sag = createSideLine(g-1,0,1,u,L.resim,settings.gridlist.side_lines),
	}
	if not scriptler[sourceResource] then scriptler[sourceResource] = {} end
	if not scriptler[sourceResource]["g"] then scriptler[sourceResource]["g"] = {} end
	table.insert(scriptler[sourceResource]["g"], {Lsayi,L.resim})
	genelGuiTablo[L.liste]={i=Lsayi,t="g"}
	return L.liste
end