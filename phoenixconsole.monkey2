'****************************************************************************
'* Alien Phoenix Gaming Framework							  
'* Copyright (c) 2018 Richard R Betson
'* Author - Richard R Betson
'* 
'* Language: Monkey2
'* Targets: Android, Windows, Linux, Emscripten, IOS
'* Title: Phoenix Console
'* Licence: zlib/libpng License (Zlib) - https://opensource.org/licenses/Zlib
'* Version: 0.7
'****************************************************************************
Namespace phoenixconsole

Global Console_List:= New List<Console>


Class Console

Field x:Int,y:Int,w:Int,h:Int
Field red:Float=1.0,green:Float=1.0,blue:Float=1
Field colored:=New Float[500],colorgreen:= New Float[500],colorblue:=New Float[500]
Field console_window_image:Image
Field array_length:Int=500
Field text:=New String[500]
Field text_index:Int=1
Field console_window:PWindow'=New PWindow
Field console_exit_button:PButton'=New Button
Field generic_button:PButton=New PButton
Field button_list_local:=New List<PButton>
'Const BUTTONOK:PButton
Field console:Console
Field console_old_width:Int,console_old_height:Int
Field console_slider:PSlider
Field generic_slider:PSlider=New PSlider

	Method Update:Void()
	
	For Local c:Console=Eachin Console_List
	
		If c.console_window.WindowVisible()=True
		Local width:Int=c.console_window.GetWindowWidth()
		Local height:Int=c.console_window.GetWindowHeight()
			If c.console_old_width<>width Or c.console_old_height<>height
				c.console_slider.SetPosition(width-25,5,0,height-10,c.console_slider)
				c.console_exit_button.SetPosition(width-130,height-50,c.console_exit_button)
				c.console_old_width=width
				c.console_old_height=height
			Endif
		'Endif
		c.text_index=(c.array_length)-(c.console_slider.GetRange(Null))
		c.console_window.SetTextArrayIndex(c.text_index)
		Self.console_window.SetTextArray(Self.text, 20, 1, True)
		
		c.console_window.DrawTextA()
		For Local b:PButton=Eachin c.button_list_local
			If b.ButtonDown()=True'button_down=True
				If b=c.console_exit_button Then c.HideConsole()
			Endif
		Next
		Endif
	Next
	End Method


	Method New(canvas:Canvas,rect:Recti,x:Int,y:Int,w:Int,h:Int)
		Self.console=Self
		console.console_window=New PWindow
		console.x=x
		console.y=y
		console.w=w
		console.h=h
		console.console_window= New PWindow(canvas,rect,x,y,w,h)'console.x,console.y,console.w,console.h)',BlendMode.Alpha,1,1.0,1.0,1.0)
		console.console_window.SetWindowBorder()'window_border_left,window_border_right,window_border_top,window_border_bottom)
		console.console_window.SetBorderStyle(BlendMode.Alpha,.9,.15,.35,.55)
		console.console_window.ForceBorder(True)
		console.console_window.SetMinWindowSize(300,150)
		'console.console_window.SetWindowOnTop()
		console.console_window.SetResizable(True)
'		console.console_exit_button=console.generic_button.CreateButton("Exit",console.BUTTONOK,10,10,80,30,Null,Null,1,1,True,255,255,255,console.console_window,console.button_list_local) 
		console.console_exit_button=New PButton("Exit",10,10,80,30,1,1,console.console_window,console.button_list_local) 
		
		'console.console_exit_button.SetLpha(False,1.0)

'		console.console_slider=Self.generic_button.CreateSlider(41101,console.w-30,10,20,console.h-20,20,20,1,Null,.95,255,255,255,console.console_window)
		console.console_slider=New PSlider(console.w-30,10,20,console.h-20,20,20,1,console.console_window)
		'console.array_length=((console.text[..].Length() )-1) 
		
'		Self.console_window.SetTextAPos(Self.text, 20, 20)
		
		console.console_slider.SetRange(console.array_length)
		console.console_slider.SetThumb(console.array_length)
		Console_List.AddLast(console)
		console.console_window.SetTextArrayStyle(BlendMode.Alpha,.99,.6,1.0,.7)
		console.console_slider.SetThumb(console.array_length)
	End Method


	Method PrintText:Void(text:String,r:Float=-1,g:Float=-1,b:Float=-1)
		Self.text_index=Self.text_index+1
'		Self.text[Self.text_index]=text
		
'	For Local test:Int=1 To 998
'		Self.text[test]=Self.text[998-test]
'	Next
	For Local test2:Int=1 To 99'8
		Local test3:Int=(99-test2)
		Self.text[test3+1]=Self.text[test3]
		If r=-1 And g=-1 And b=-1
			Self.colored[test3+1]=Self.red
			Self.colorgreen[test3+1]=Self.green
			Self.colorblue[test3+1]=Self.blue
		Else
			If r=-1 Then r=0
			If g=-1 Then g=0
			If b=-1 Then b=0
			Self.colored[test3+1]=r
			Self.colorgreen[test3+1]=g
			Self.colorblue[test3+1]=b
		Endif
	Next
	Self.text[1]=text
	
	Self.console_window.SetTextArray(Self.text, 20, 20, False)


	End Method

	Method SetTextColor:Void(r:Float,g:Float,b:Float)
		Self.red=r
		Self.green=g
		Self.blue=b	
		Self.console_window.SetTextArrayStyle(BlendMode.Alpha,.99,r,g,b)
 	
	End Method

	Method ShowConsole:Void()
		Self.console_window.ShowWindow()
	End Method
	

	Method HideConsole:Void()
		Self.console_window.HideWindow()
	End Method

End Class
