local isim = getResourceName(getThisResource())

local functions = {
	["create"]={
		["guiCreateWindow"]={
			" function guiCreateWindow(...) return exports."..isim..":guiCreateWindow(...)end",
			" function guiWindowSetSizable(...)return exports."..isim..":guiWindowSetSizable(...)end",
			" function guiWindowSetMovable(...)return exports."..isim..":guiWindowSetMovable(...)end",
			" function guiWindowIsMovable(...)return exports."..isim..":guiWindowIsMovable(...)end",
			" function guiWindowSetHeaderColor(...)return exports."..isim..":guiWindowSetHeaderColor(...)end",
			" function guiWindowSetCloseVisible(...)return exports."..isim..":guiWindowSetCloseVisible(...)end",
		},
		["guiCreateGridList"]={" function guiCreateGridList(...)return exports."..isim..":guiCreateGridList(...)end"},
		["guiCreateButton"]={
			" function guiCreateButton(...)return exports."..isim..":guiCreateButton(...)end",
		},
		["guiCreateEdit"]={
			" function guiCreateEdit(...)return exports."..isim..":guiCreateEdit(...)end",
		},
		["guiCreateMemo"]={" function guiCreateMemo(...)return exports."..isim..":guiCreateMemo(...)end"},
		["guiCreateTabPanel"]={
			" function guiCreateTabPanel(...)return exports."..isim..":guiCreateTabPanel(...)end",
			" function guiCreateTab(...)return exports."..isim..":guiCreateTab(...)end",
			" function guiSetSelectedTab(...)return exports."..isim..":guiSetSelectedTab(...)end",
			" function guiGetSelectedTab(...)return exports."..isim..":guiGetSelectedTab(...)end",
			" function guiDeleteTab(...)return exports."..isim..":guiDeleteTab(...)end",
			" function guiTabSetHorizontalAlign(...)return exports."..isim..":guiTabSetHorizontalAlign(...)end",
		},
		["guilist"] = {
			--set functions
			" function guiCreateGridList(...)return exports."..isim..":MLguiCreateGridList(...)end",
			" function guiGridListAddColumn(...)return exports."..isim..":MLguiGridListAddColumn(...)end",
			" function guiGridListAddRow(...)return exports."..isim..":MLguiGridListAddRow(...)end",
			" function guiGridListSetItemText(...)return exports."..isim..":MLguiGridListSetItemText(...)end",
			" function guiGridListSetItemImage(...)return exports."..isim..":MLguiGridListSetItemImage(...)end",
			" function guiGridListSetItemWidth(...)return exports."..isim..":MLguiGridListSetItemWidth(...)end",
			" function guiGridListSetSelectedItem(...)return exports."..isim..":MLguiGridListSetSelectedItem(...)end",
			" function guiGridListSetItemData(...)return exports."..isim..":MLguiGridListSetItemData(...)end",
			" function guiGridListRemoveRow(...)return exports."..isim..":MLguiGridListRemoveRow(...)end",
			" function guiGridListClear(...)return exports."..isim..":MLguiGridListClear(...)end",
			" function guiGridListSetColumnTitle(...)return exports."..isim..":MLguiGridListSetColumnTitle(...)end",
			" function MLguiGridListSetColumnAlign(...)return exports."..isim..":MLguiGridListSetColumnAlign(...)end",
			" function guiGridListSetColumnWidth(...)return exports."..isim..":MLguiGridListSetColumnWidth(...)end",
			" function guiGridListSetItemColor(...)return exports."..isim..":MLguiGridListSetItemColor(...)end",
			" function guiGridListSetItemBackColor(...)return exports."..isim..":MLguiGridListSetItemBackColor(...)end",
			" function guiGridListSetSortingEnabled(...)return exports."..isim..":MLguiGridListSetSortingEnabled(...)end",
			" function guiGridListSetVerticalScrollPosition(...)return exports."..isim..":MLguiGridListSetVerticalScrollPosition(...)end",
			--get functions
			" function guiGridListGetSelectedItem(...)return exports."..isim..":MLguiGridListGetSelectedItem(...)end",
			" function guiGridListGetItemText(...)return exports."..isim..":MLguiGridListGetItemText(...)end",
			" function guiGridListGetItemData(...)return exports."..isim..":MLguiGridListGetItemData(...)end",
			" function guiGridListGetColumnCount(...)return exports."..isim..":MLguiGridListGetColumnCount(...)end",
			" function guiGridListGetColumnTitle(...)return exports."..isim..":MLguiGridListGetColumnTitle(...)end",
			" function guiGridListGetColumnWidth(...)return exports."..isim..":MLguiGridListGetColumnWidth(...)end",
			" function guiGridListGetRowCount(...)return exports."..isim..":MLguiGridListGetRowCount(...)end",		
		},
	},	
	["utils"]={
		" function guiGetPosition(...)return exports."..isim..":guiGetPosition(...) end",
		" function guiSetPosition(...)return exports."..isim..":guiSetPosition(...)end",
		" function guiGetSize(...)return exports."..isim..":guiGetSize(...)end",
		" function guiSetSize(...)return exports."..isim..":guiSetSize(...)end",
		" function guiSetText(...)return exports."..isim..":guiSetText(...)end",
		" function guiGetText(...)return exports."..isim..":guiGetText(...)end",
		" function guiSetEnabled(...)return exports."..isim..":guiSetEnabled(...)end",
		" function guiSetVisible(...)return exports."..isim..":guiSetVisible(...)end",
		" function destroyElement(...)return exports."..isim..":destroyElement(...)end",
		" function renkVer(...)return exports."..isim..":renkVer(...)end",
		" function guiSetLineColor(...)return exports."..isim..":guiSetLineColor(...)end",
	}
}

function getFunctions(...)
	local f = ""
	local isim = {...} -- gelen verileri table geçirdik
	if #isim > 0 then -- eğer gelen veri varsa
		if #isim == 1 then -- eğer 1 tane ise
			local isim = isim[1] -- 1.sini çektik
			if isim ~= "utils" and functions["create"][isim] then -- eğer "utils" den başka ise ve tabloda varsa
			
				for i,v in pairs(functions["create"][isim]) do
					f = f..v -- tablodaki karşılığınu çektik
				end	
				
				for i,v in pairs(functions["utils"]) do 
					f = f..v -- utils funclarını ekledik
				end
				
				return f	 -- gönderdik
			end	
			return f
		else -- eğer 1 taneden fazla ise örn: "guiCreateWindow","guiCreateButton",... gibi
			
			for i,v in pairs(isim) do -- gelen verileri döndürdük
				if functions["create"][v] then -- eğer tabloda varsa veri
					for i,v in pairs(functions["create"][v]) do
						f = f..v -- tablodaki karşılığınu çektik
					end	
				end	
			end
			
			for i,v in pairs(functions["utils"]) do
				f = f..v -- utils funclarını ekledik
			end
			
			return f -- gönderdik
		end	
	else -- eğer gelen bir veri yoksa
		for i,v in pairs(functions["create"]) do
			if i ~= "guilist" then
				for i,s in pairs(v) do
					f = f..s -- tüm funclrı değişkene koyduk
				end	
			end	
		end
		for i,v in pairs(functions["utils"]) do
			f = f..v -- utils funclarını ekledik
		end
		return f -- gönderdik
	end
end


