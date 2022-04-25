function guiCreateMemo(x,y,g,u,yazi,relative,parent,kenarrenk)
	msayi = #gui["m"] +1
	if not gui["m"][msayi] then gui["m"][msayi] = {} end
	local m = gui["m"][msayi]		
	if relative  then
		px,pu = parent and _guiGetSize(parent,false) or sx,sy 
		x,y,g,u = x*px,y*pu,g*px,u*pu
	end
	m.resim = guiCreateLabel(x,y,g,u, "", false, parent)
	m.memo = _guiCreateMemo(-5,-10,g+15, u+10, yazi,false, m.resim)
	m.kenarlar = {
		ortaUst = createSideLine(0,0,g,1,m.resim,settings.memo.side_lines),
		ortaAlt = createSideLine(0,u-1,g,1,m.resim,settings.memo.side_lines),
		sol = createSideLine(0,0,1,u,m.resim,settings.memo.side_lines),
		sag = createSideLine(g-1,0,1,u,m.resim,settings.memo.side_lines),
	}	
	if not scriptler[sourceResource] then scriptler[sourceResource] = {} end
	if not scriptler[sourceResource]["m"] then scriptler[sourceResource]["m"] = {} end
	table.insert(scriptler[sourceResource]["m"], {msayi,m.resim})
	genelGuiTablo[m.memo]={i=msayi,t="m"}
	return m.memo
end