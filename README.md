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
"gui move element 
```lua
guiMoveTo(elm,200,100,true,"Linear",1500,500)
guiMoveTo(elm,x,y,relative,easing,duration,delay)
```
"gui size element 
```lua
guiSizeTo(elm,200,100,true,"Linear",1500,500)
guiSizeTo(elm,w,h,relative,easing,duration,delay)
```
"gui set alpha element 
```lua
guiAlphaTo(elm,200,100,true,"Linear",1500)
guiAlphaTo(elm,alpha,relative,easing,duration,delay)
```
"gui alert anim
```lua
guiAlertAnim(elm,false)
guiAlertAnim(elm,relative)
```
"gui stop anim
```lua
guiStopAnim(elm)
guiStopAnim(elm)
```
"gui add tooltip
```lua
guiAddTooltio(elm,"hi\nhello","#ff00ff")
guiAddTooltip(elm,text,hexcolor)
```
## Extra Events
```lua
-- triggered when a window closed with X button. source is window
"MahLib:PencereKapatıldı" 
```

## Preview
https://streamable.com/sfiear
