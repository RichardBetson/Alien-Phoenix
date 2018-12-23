'-------------------------------------------------------------------------
'Title: Alien Phoenix Draw-Image Example
'Author: Richard R Betson
'
'-------------------------------------------------------------------------
 
 
Namespace phoenixusc
 
#Import "demo_assets/"
 
#Import "<sdl2>"
#Import "<std>"
#Import "<mojo>"
#Import "<mojo3d>"
#Import "../phoenixbutton"
#Import "../phoenixwindow"
#Import "../phoenixconsole"
Using phoenixconsole
Using std.. 
Using mojo..
Using mojo3d..
Using sdl2..
 
Using phoenixbutton
Using phoenixwindow
 
 
 
Class PPhoenixWeb Extends Window
	
	Field virtualRes:=New Vec2i( 1920, 1080 )
 
	Field current_window:=New PWindow
	Field generic_window:=New PWindow
	Field my2d_window:=New PWindow
	Field about_window:=New PWindow
	Field generic_button:PButton
	'Field console_window:PWindow
	
	Field install:Bool 'Flag intitail setup
 
	
	'Simple light
	Field _logo:Image
	Field ap_logo:Image
 
	Method New( title:String,width:Int,height:Int,flags:WindowFlags=WindowFlags.Resizable )
		Super.New( title, width, height, flags)
		
		Layout="Fill"
		ClearColor=Color.DarkGrey
		Style.BackgroundColor=Color.DarkGrey
		Self.ap_logo=Image.Load( "asset::logo_ap.png" )
		Self.ap_logo.Scale=New Vec2f( 1,1)
		Init2D()
		
	End Method
	
	Method Init2D()		
		Self._logo=Image.Load( "asset::monkey2logo.png" )
		Self._logo.Handle=New Vec2f( 0.5, 0.5 )		
 
	End Method
		
	
	Method OnMeasure:Vec2i() Override
		Return virtualRes
	End Method
	
	
	Method OnRender( canvas:Canvas ) Override
		
		If Self.install=False
			'Load GUI resources
			InitMainGUI(canvas)
			
			'Setup windows
			Self.my2d_window=Init2DWindow(canvas,Rect,300,200,1280,720)
			Self.about_window=InitAboutWindow(canvas,Rect,600,300,600,350)
			
			'Setup a generic window with canvas only
			Self.generic_window=New PWindow(canvas)
			
			canvas.AmbientLight=New Color(.25,.25,.25)
			Self.install=True
		Endif
 
		'Draw about window assets
		RenderAboutWindow()
 
		'Draw 2D asstets
		Render2DExample(my2d_window)		

		'Update window console
		g_window_system_console.Update()
		
		'Update all windows
		generic_window.UpdateWindow()
		
		App.RequestRender()
	End Method
 
 
	Method RenderAboutWindow()
 
		Self.about_window.DrawImage(Self.ap_logo,120,35)
		Self.about_window.DrawText("Alien Phoenix Draw Image Example",200,200)
		Self.about_window.DrawText("Powered by Alien Phoenix",220,220)
		Self.about_window.DrawText("Alien Phoenix Copyright (c) 2018 Richard Betson",135,240)
				
	End Method
 
 	Global scl:Float=0.0
 	Global clr:Float=0.0	
	Method Render2DExample:Void(window:PWindow)
		clr=clr+.01
		If clr > 1.0 Then clr = 0.0
		scl=scl+.01
		If scl > 1.0 Then scl = 0.0
		Local image:PWindowImage=window.DrawImage( _logo, window.GetWindowWidth()/2, window.GetWindowHeight()/2  )
		window.SetImageColor(image, clr, clr, clr)
		window.SetImageScale(image, scl, scl)
		window.SetImageBlend(image, BlendMode.Alpha)
	End Method
 
 
	Method InitMainGUI:Void(canvas:Canvas)
		Self.generic_window.LoadResources("system_resources/client_skin/window_skin.txt")		
		Self.generic_window.SetScreenSize(1920,1080)
		Self.generic_button.LoadImages("system_resources/client_skin/client_skin.txt")

		'Init Console
		g_window_system_console=New Console(canvas,Rect,20,560,1000,350)
		g_window_system_console.PrintText(".")
		g_window_system_console.PrintText(".")
		g_window_system_console.PrintText(".")
		g_window_system_console.PrintText("Welcome to Alien Phoeinix")
		g_window_system_console.PrintText("<-------->")
		g_window_system_console.PrintText("Alien Phoenix: Loaded window resources.")
		g_window_system_console.PrintText("<-------->")
		g_window_system_console.PrintText("Alien Phoenix: Draw-Image Example Running")
		g_window_system_console.PrintText("<-------->")
		g_window_system_console.PrintText(".")
		g_window_system_console.PrintText(".")
		g_window_system_console.PrintText(".")
	End Method
				
 
	Method Init2DWindow:PWindow(canvas:Canvas,rect:Recti,x:Float,y:Float,w:Float,h:Float)
		Local window:PWindow=New PWindow(canvas,rect,x,y,w,h)
		window.SetBorderStyle(BlendMode.Additive,.4,.4,.6,.8)
		window.SetResizable(True)
		window.SetMinWindowSize(150,150)',5760+210,1080)
		window.SetCLS(True)
		window.SetWindowControls(New String[]("maximize","cast"),True)
		'window.SetBackgroundImage(Null)
		Return window
	End Method
 
 
	Method InitAboutWindow:PWindow(canvas:Canvas,rect:Recti,x:Float,y:Float,w:Float,h:Float)
		Local window:PWindow=New PWindow(canvas,rect,x,y,w,h)
		window.SetBorderStyle(BlendMode.Additive,.4,.4,.6,.8)
		window.SetResizable(False)
		window.SetMinWindowSize(150,150)
		window.SetCLS(True)
		window.SetBackgroundImage(Null)
		window.SetWindowOnTop()
		Return window
	End Method
 
End Class
 
Function Main()
 
	New AppInstance
	
	New PPhoenixWeb("Alien Phoenix Draw Image Example - Powered by Alien Phoenix",1920,1080)'device_width,device_height )
	
	App.Run()
	
End
