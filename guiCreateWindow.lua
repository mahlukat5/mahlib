function guiCreateWindow(x,y,g,u,yazi,relative,parent)
	wsayi = #gui["w"] +1
	if not gui["w"][wsayi] then gui["w"][wsayi] = {} end
	local w = gui["w"][wsayi]
	if relative  then
		px,pu=getParentSize(parent)
		x,y,g,u=x*px,y*pu,g*px,u*pu
	end
	w.move = true
	w.canResize = false	
	w.resim = guiCreateStaticImage(x,y,g,u,bosresim,false,parent)
	w.basarka = guiCreateStaticImage(0,0,g,20,bosresim, false, w.resim)
	w.label = guiCreateLabel(0,0,g,20, yazi, false, w.basarka)
	w.kenarlar = {
		ortaUst = createSideLine(0,20,g,2,w.resim,settings.window.side_lines,1),
		ortaAlt = createSideLine(0,u-2,g,2,w.resim,settings.window.side_lines,1),
		sol = createSideLine(0,20,2,u-20,w.resim,settings.window.side_lines,1),
		sag = createSideLine(g-2,20,2,u-20,w.resim,settings.window.side_lines,1),
	}
	w.kapatArka = guiCreateStaticImage(g-25,0,25,20,bosresim,false,w.basarka)
	w.kapat = guiCreateLabel(0,0,25,20, "X", false, w.kapatArka)
	w.resize = guiCreateStaticImage(g-10,u-10,10,10,bosresim, false,w.resim)
	guiSetProperty(w.resize,"MouseCursorImage","set:CGUI-Images image:NWSESizingCursorImage")
	guiSetFont(w.kapat, "default-bold-small") guiLabelSetColor(w.kapat,0,0,0)
	guiLabelSetHorizontalAlign(w.kapat, "center") guiLabelSetVerticalAlign(w.kapat, "center")
	
	if not scriptler[sourceResource] then scriptler[sourceResource] = {} end
	if not scriptler[sourceResource]["w"] then scriptler[sourceResource]["w"] = {} end
	table.insert(scriptler[sourceResource]["w"], {wsayi,w.resim})
	
	guiSetProperty(w.basarka,"ImageColours","tl:FF"..settings.window.header_topleft.." tr:FF"..settings.window.header_topright.." bl:FF"..settings.window.header_bottomleft.." br:FF"..settings.window.header_bottomright.."")
	guiSetProperty(w.resim,"ImageColours","tl:FF"..settings.window.back_topleft.." tr:FF"..settings.window.back_topright.." bl:FF"..settings.window.back_bottomleft.." br:FF"..settings.window.back_bottomright.."")
	renkVer(w.kapatArka,settings.window.close_back)
	guiSetFont(w.label,font1) guiSetEnabled(w.label,false) guiSetVisible(w.resize,w.canResize)
	guiLabelSetHorizontalAlign(w.label, "center") guiLabelSetVerticalAlign(w.label, "center")
	guiSetProperty(w.resize, "AlwaysOnTop", "True")
	
	genelGuiTablo[w.resim]={i=wsayi,t="w"}
	genelGuiTablo[w.kapat]={i=wsayi,isClose=true}
	genelGuiTablo[w.basarka]={i=wsayi,isHeader=true}
	genelGuiTablo[w.resize]={i=wsayi,isResizer=true}
	return w.resim,w.basarka
end

function guiWindowSetHeaderColor(element,hex)
	local sira = getGuiElement(element)
	if not sira then return end
	if not hex and sira.basarka then guiSetProperty(sira.basarka,"ImageColours","tl:FF"..settings.window.header_topleft.." tr:FF"..settings.window.header_topright.." bl:FF"..settings.window.header_bottomleft.." br:FF"..settings.window.header_bottomright.."") return end
	if sira.basarka then renkVer(sira.basarka) end
end
function guiWindowSetCloseVisible(element,bool)
	local sira = getGuiElement(element)
	if not sira then return end
	if sira.kapatArka then guiSetVisible(sira.kapatArka,bool) end
end