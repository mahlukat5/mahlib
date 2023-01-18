# MahLib

## Usage
```lua
loadstring(exports["MahLib"]:getFunctions())()
```
> There is a some optional arguments in getFunctions function
```lua
  "guiCreateWindow","guiCreateButton","guiCreateGridList","guiCreateEdit","guiCreateTabPanel","guilist"
```  
You can use only "guiCreateWindow" like this:  
```lua
loadstring(exports["MahLib"]:getFunctions("guiCreateWindow"))()
```
or you can use only "guiCreateWindow" and "guiCreateButton" like this: 
```lua
loadstring(exports["MahLib"]:getFunctions("guiCreateWindow","guiCreateButton"))()
```
"guilist" only using with arguments. not loading without arguments
```lua
-- for using guilist
loadstring(exports["MahLib"]:getFunctions("guilist","guiCreateButton"))()
```

## Extra Functions
```lua
-- if not hex then auto setting defaulthex.
guiWindowSetHeaderColor( window, hex)

-- set visible X button in window
guiWindowSetCloseVisible(window,bool)

-- you can change line colors with this function
guiSetLineColor(element,hex)

-- you can change the horizontal alignment of tabs
guiTabSetHorizontalAlign(tabpanel,align)
```
## Extra Events
```lua
-- triggered when a window closed with X button. source is window
"MahLib:PencereKapatıldı" 
```

## Preview
https://streamable.com/sfiear
