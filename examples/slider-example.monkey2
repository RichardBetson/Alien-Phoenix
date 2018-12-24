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
#Import "../phoenixslider"
#Import "../phoenixconsole"
Using phoenixslider
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
	Field slider_red:PSlider
	Field slider_green:PSlider
	Field slider_blue:PSlider
	Field slider_alpha:PSlider
	Field slider_scale:PSlider
	Field install:Bool 'Flag intitail setup
	
	'Simple light
	Field _logo:Image
	Field _background:Image
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
		Self._background=Image.Load( "asset::Slate Tiles II_D.png" )
 
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
		Self.about_window.DrawText("Alien Phoenix Slider Example",200,200)
		Self.about_window.DrawText("Powered by Alien Phoenix",220,220)
		Self.about_window.DrawText("Alien Phoenix Copyright (c) 2018 Richard Betson",135,240)
				
	End Method
 
 	Method Render2DExample:Void(window:PWindow)

		For Local x:=0 Until window.GetWindowWidth() Step Self._background.Width
			For Local y:=0 Until window.GetWindowHeight() Step _background.Height
				window.DrawImage( Self._background,x-window.GetWindowWidth()/1920,y-window.GetWindowHeight()/1080 )
			Next
		Next
		Local image:PWindowImage=window.DrawImage( _logo, window.GetWindowWidth()/2, window.GetWindowHeight()/2  )
		Local sred:Float=Float( 100-Self.slider_red.GetRange() ) *.01
		Local sgreen:Float=Float( 100-Self.slider_green.GetRange() ) *.01
		Local sblue:Float=Float( 100-Self.slider_blue.GetRange() ) *.01
		Local sa:Float=Float( 100-Self.slider_alpha.GetRange() ) *.01
		Local scl:Float=Float( 100-Self.slider_scale.GetRange() ) *.01
		If scl<0 Then scl=0
		If scl>1.0 Then scl=1.0
		window.SetImageColor(image, sred, sgreen, sblue)
		window.SetImageScale(image, scl, scl)
		window.SetImageAlpha(image, sa)
		window.SetImageBlend(image, BlendMode.Alpha)
		window.DrawText("Set Color",10,10)
		window.DrawText("Set Alpha",10,265)
		window.DrawText("Set Scale",10,330)

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
		g_window_system_console.PrintText("Alien Phoenix: Slider Example Running")
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
		window.SetBackgroundImage(Null)
		Self.slider_red= New PSlider(10,40,30,200,30,30,1,window) ' 1 = verticle slider 2 = horizontal
		Self.slider_green= New PSlider(50,40,30,200,30,30,1,window)
		Self.slider_blue= New PSlider(90,40,30,200,30,30,1,window)
		Self.slider_alpha= New PSlider(10,290,200,30,30,30,2,window)
		Self.slider_scale= New PSlider(10,350,200,30,30,30,2,window)

		'Set slider index range
		Self.slider_red.SetRange(100)
		Self.slider_green.SetRange(100)
		Self.slider_blue.SetRange(100)
		Self.slider_alpha.SetRange(100)
		Self.slider_scale.SetRange(100)		
		
		'Set the steprate of the thumb
		Self.slider_red.SetThumbStepRate(3)
		Self.slider_green.SetThumbStepRate(3)
		Self.slider_blue.SetThumbStepRate(3)
		Self.slider_alpha.SetThumbStepRate(3)
		Self.slider_scale.SetThumbStepRate(3)


		'Set slider custom color and alpha. Optional.
		Self.slider_red.SetUpColor(1.0,0.0,0.0)
		Self.slider_green.SetUpColor(0.0,1.0,0.0)
		Self.slider_blue.SetUpColor(0.0,0.0,1.0)		
'		Self.slider_green.SetUpColor(1.0,0.0,0.0)
'		Self.slider_green.SetUpAlpha(1.0)
'		Self.slider_green.SetDownColor(0.0,1.0,0.0)
'		Self.slider_green.SetDownAlpha(1.0)
'		Self.slider_green.SetHighlightColor(0.0,0.0,1.0)
'		Self.slider_green.SetHighlightAlpha(1.0)		
'		Self.slider_green.SetSelectedColor(1.0,1.0,0.0)
'		Self.slider_green.SetSelectedAlpha(1.0)

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
	
	New PPhoenixWeb("Alien Phoenix Slider Example - Powered by Alien Phoenix",1920,1080)'device_width,device_height )
	
	App.Run()
	
End
