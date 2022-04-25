function guiCreateButton(x,y,g,u,yazi,relative,parent)
	bsayi = #gui["b"] +1
	if not gui["b"][bsayi] then gui["b"][bsayi] = {} end
	local b = gui["b"][bsayi]
	if relative  then
		px,pu=getParentSize(parent)
		x,y,g,u=x*px,y*pu,g*px,u*pu
	end
	b.resim = guiCreateStaticImage(x,y,g,u,bosresim,false,parent) -- kenar
	b.resim2 = guiCreateStaticImage(1,1,g-2,u-2,bosresim,false,b.resim) -- iç kısım
	b.label = guiCreateLabel(0,0,1,1,yazi,true,b.resim2)
	if not scriptler[sourceResource] then scriptler[sourceResource] = {} end
	if not scriptler[sourceResource]["b"] then scriptler[sourceResource]["b"] = {} end
	table.insert(scriptler[sourceResource]["b"], {bsayi,b.resim})
	
	guiSetProperty(b.resim2,"ImageColours","tl:FF"..settings.button.back_topleft.." tr:FF"..settings.button.back_topright.." bl:FF"..settings.button.back_bottomleft.." br:FF"..settings.button.back_bottomright.."")
	guiSetProperty(b.resim,"ImageColours","tl:FF"..settings.button.side_topleft.." tr:FF"..settings.button.side_topright.." bl:FF"..settings.button.side_bottomleft.." br:FF"..settings.button.side_bottomright.."")
	guiLabelSetHorizontalAlign(b.label, "center") guiLabelSetVerticalAlign(b.label, "center")
	guiSetProperty(b.label, "AlwaysOnTop", "True")
	guiSetFont(b.label, font1)
	b.isButton=true
	genelGuiTablo[b.label]={i=bsayi,t="b"}
	return b.label 
end