function guiCreateButton(x,y,g,u,yazi,relative,parent)
	bsayi = #btablo +1
	if not btablo[bsayi] then btablo[bsayi] = {} end
	local b = btablo[bsayi]
	if relative  then
		px,pu=getParentSize(parent)
		x,y,g,u=x*px,y*pu,g*px,u*pu
	end
	b.resim = guiCreateStaticImage(x,y,g,u,bosresim,false,parent)
	b.label = guiCreateLabel(0,0,g,u,yazi,false,b.resim)
	b.kenarlar = {
		ortaUst = createSideLine(0,0,g,1,b.resim,settings.button.side_lines),
		ortaAlt = createSideLine(0,u-1,g,1, b.resim,settings.button.side_lines),
		sol = createSideLine(0,0,1,u,b.resim,settings.button.side_lines),
		sag = createSideLine(g-1,0,1,u,b.resim,settings.button.side_lines),
	}
	if not scriptler[sourceResource] then scriptler[sourceResource] = {} end
	if not scriptler[sourceResource]["b"] then scriptler[sourceResource]["b"] = {} end
	table.insert(scriptler[sourceResource]["b"], {btablo,bsayi,b.resim})
	
	guiSetProperty(b.resim,"ImageColours","tl:FF"..settings.button.back_topleft.." tr:FF"..settings.button.back_topright.." bl:FF"..settings.button.back_bottomleft.." br:FF"..settings.button.back_bottomright.."")
	guiLabelSetHorizontalAlign(b.label, "center") guiLabelSetVerticalAlign(b.label, "center")
	guiSetFont(b.label, font1)
	b.isButton=true
	genelGuiTablo[b.label]=b
	return b.label 
end
