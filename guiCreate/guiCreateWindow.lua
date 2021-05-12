function guiCreateWindow(x,y,g,u,yazi,relative,parent)
	wsayi = #wtablo +1
	if not wtablo[wsayi] then wtablo[wsayi] = {} end
	local w = wtablo[wsayi]
	if relative  then
		px,pu=getParentSize(parent)
		x,y,g,u=x*px,y*pu,g*px,u*pu
	end
	w.move = true	
	w.resim = guiCreateStaticImage(x,y,g,u,bosresim,false,parent)
	w.basarka = guiCreateStaticImage(0,0,g,20,bosresim, false, w.resim)
	w.label = guiCreateLabel(0,0,g,20, yazi, false, w.basarka)
	w.kenarlar = {
		ortaUst = createSideLine(0,0,g,1,w.resim,settings.window.side_lines),
		ortaAlt = createSideLine(0,u-1,g,1,w.resim,settings.window.side_lines),
		sol = createSideLine(0,0,1,u,w.resim,settings.window.side_lines),
		sag = createSideLine(g-1,0,1,u,w.resim,settings.window.side_lines),
	}
	w.kapatArka = guiCreateStaticImage(g-25,1,25,20,bosresim,false,w.basarka)
	w.kapat = guiCreateLabel(0,-2,25,20, "X", false, w.kapatArka)
	guiSetFont(w.kapat, "default-bold-small") guiSetAlpha(w.kapatArka, 0.5)
	guiLabelSetHorizontalAlign(w.kapat, "center") guiLabelSetVerticalAlign(w.kapat, "center")
	
	if not scriptler[sourceResource] then scriptler[sourceResource] = {} end
	if not scriptler[sourceResource]["w"] then scriptler[sourceResource]["w"] = {} end
	table.insert(scriptler[sourceResource]["w"], {wtablo,wsayi,w.resim})
	
	guiSetProperty(w.basarka,"ImageColours","tl:FF"..settings.window.header_topleft.." tr:FF"..settings.window.header_topright.." bl:FF"..settings.window.header_bottomleft.." br:FF"..settings.window.header_bottomright.."")
	guiSetProperty(w.resim,"ImageColours","tl:FF"..settings.window.back_topleft.." tr:FF"..settings.window.back_topright.." bl:FF"..settings.window.back_bottomleft.." br:FF"..settings.window.back_bottomright.."")
	renkVer(w.kapatArka,settings.window.close_back)
	guiSetFont(w.label,font1) 
	guiSetEnabled(w.label,false) 
	guiLabelSetHorizontalAlign(w.label, "center") guiLabelSetVerticalAlign(w.label, "center")
	
	genelGuiTablo[w.resim]=w
	genelGuiTablo[w.kapat]={w=wsayi,isClose=true}
	genelGuiTablo[w.basarka]={w=wsayi,isHeader=true}
	return w.resim,w.basarka
end

function guiWindowSetHeaderColor(element,hex)
	local sira = genelGuiTablo[element]
	if not sira then return end
	if not hex and sira.basarka then guiSetProperty(sira.basarka,"ImageColours","tl:FF"..settings.window.header_topleft.." tr:FF"..settings.window.header_topright.." bl:FF"..settings.window.header_bottomleft.." br:FF"..settings.window.header_bottomright.."") return end
	if sira.basarka then renkVer(sira.basarka) end
end
function guiWindowSetCloseVisible(element,bool)
	local sira = genelGuiTablo[element]
	if not sira then return end
	if sira.kapatArka then guiSetVisible(sira.kapatArka,bool) end
end
