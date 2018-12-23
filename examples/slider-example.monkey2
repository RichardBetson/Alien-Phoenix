'-------------------------------------------------------------------------
'Title: Alien Phoenix 2D / 3D example
'Author: Richard R Betson
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
	Field my3d_window:=New PWindow
	Field my2d_window:=New PWindow
	Field about_window:=New PWindow
	Field generic_button:PButton
	
	Field install:Bool 'Flag intitail setup
 
	'3D window - 3D setup
	Field _scene:Scene
	Field _camera:Camera
	Field _light:Light
	Field _ground:Model
	Field _donut:Model
	Field _bloom:BloomEffect
	'Field _fog:FogEffect
	
	'Simple light
	Field _floor:Image
	Field _2d_light:Image
	Field _logo:Image
		
	Field ap_logo:Image
 
	Method New( title:String,width:Int,height:Int,flags:WindowFlags=WindowFlags.Resizable )
		Super.New( title, width, height, flags)
		
		Layout="Fill"
		ClearColor=Color.DarkGrey
		Style.BackgroundColor=Color.DarkGrey
		Self.ap_logo=Image.Load( "asset::logo_ap.png" )
		Self.ap_logo.Scale=New Vec2f( 1,1)
		Init3D()
		Init2D()
		
	End Method
	
	Method Init3D()
		SetConfig( "MOJO_TEXTURE_MAX_ANISOTROPY",16 )
		
		Self._scene=Scene.GetCurrent()
		Self._scene.EnvColor=Color.Black
		Self._scene.ClearColor=Color.Black
		Self._scene.AmbientLight=Color.Black
 
		Self._camera=New Camera
		Self._camera.Near=1
		Self._camera.Far=1000
		Self._camera.Move( 0,2,0 )
		
		Self._light=New Light
		Self._light.RotateX( 100 )
		Self._light.Range=20
		Self._light.Move(0,10,0)
		Self._light.CastsShadow=True
'		
		Local pixmap:=New Pixmap( 16,16 )
		pixmap.Clear( Color.Black )
		For Local i:=0 Until 16
			pixmap.SetPixelARGB( i,0,~0 )
			pixmap.SetPixelARGB( 0,i,~0 )
		Next
		
		Local texture:=New Texture( pixmap,TextureFlags.FilterMipmap|TextureFlags.WrapST )
		Local material:=New PbrMaterial( Color.Black )
		material.EmissiveTexture=texture
		material.EmissiveFactor=Color.Red
		material.ScaleTextureMatrix( 500,500 )
		
		Self._ground=Model.CreateBox( New Boxf( -500,-1,-500,500,0,500 ),10,10,10,material )
		Self._bloom=New BloomEffect
		Self._scene.AddPostEffect( _bloom )
		
		Self._scene.FogNear=--0.5
		Self._scene.FogFar=100
		Self._scene.FogColor=New Color(.4,.4,.8)
'		Self._scene.AddPostEffect( _fog )
		
		Local materiala:=New PbrMaterial( Color.Silver ,0)
		materiala.EmissiveFactor=New Color( 1,0,.5 )
		materiala.MetalnessFactor=0
		
		Self._donut=Model.CreateTorus( 2,.5,48,24,materiala )
		Self._donut.Move( 0,3,6 )
		
	End Method
	
	
	Method Init2D()
		Self._floor=Image.LoadBump( "asset::Slate Tiles II_D.png","asset::Slate Tiles II_N.png","asset::Slate Tiles II_S.png",.75,True )
 
		Self._2d_light=Image.LoadLight( "asset::cone_orange.png" )
		Self._2d_light.Handle=New Vec2f( .5,0 )
		Self._2d_light.Scale=New Vec2f( 1,1)
		Self._2d_light.LightDepth=200
		
		Self._logo=Image.Load( "asset::Monkey2-logo-48.png" )
		Self._logo.Handle=New Vec2f( .5 )		
		Self._logo.ShadowCaster=New ShadowCaster( _logo.Width/2,20 )
 
	End Method
		
	
	Method OnMeasure:Vec2i() Override
		Return virtualRes
	End Method
	
	
	Method OnRender( canvas:Canvas ) Override
		
		If Self.install=False
			'Load GUI resources
			InitMainGUI()
			
			'Setup windows
			Self.my2d_window=Init2DWindow(canvas,Rect,300,200,1280,720)
			Self.my3d_window=Init3DWindow(canvas,Rect,100,100,1280,720)
			Self.about_window=InitAboutWindow(canvas,Rect,600,300,600,350)
			
			'Setup a generic window with canvas only
			Self.generic_window=New PWindow(canvas)
			
			canvas.AmbientLight=New Color(.25,.25,.25)
			Self.install=True
		Endif
 
		'Update 3D objects
		Self._donut.Rotate( .2,.2,.3 )
		Self._ground.RotateY( Sin(Millisecs()*.0001),True )
		
		'update 3D scene to window
		my3d_window.RenderWindowCamera(_scene,_camera)
 
		'Draw about window assets
		RenderAboutWindow()
 
		'Draw 2D asstets
		Render2DExample(my2d_window)		
		
		'Update all windows
		generic_window.UpdateWindow()
		
		App.RequestRender()
	End Method
 
 
	Method RenderAboutWindow()
 
		Self.about_window.DrawImage(Self.ap_logo,120,35)
		Self.about_window.DrawText("Alien Phoenix 2D / 3D Example",200,200)
		Self.about_window.DrawText("Powered by Alien Phoenix",220,220)
		Self.about_window.DrawText("Alien Phoenix copyright (c) 2018 Richard Betson",135,240)
				
	End Method
 
 Global lightRot:=0.0
 Global viewRot:=0.0	
	Method Render2DExample:Void(window:PWindow)
 
		Local offsetx:Float=window.GetWindowWidth()/2
		Local offsety:Float=window.GetWindowHeight()/2		
		
		
		viewRot+=.001
 
		window.TranslateCanvas( offsetx, offsety )
		window.ScaleCanvas( Sin( viewRot*3 )*.25+1.25,Cos( viewRot*5 )*.25+1.25 )
		window.RotateCanvas( viewRot )
		
		
		lightRot+=.4
		
		window.BeginLighting()
		
		Local mx:Float, my:Float
		If window.WindowSelected()
			mx=(Mouse.X )-window.GetWindowX()
			my=(Mouse.Y )-window.GetWindowY()
		Else
			mx=window.GetWindowWidth()/2
			my=window.GetWindowHeight()/2
		Endif
		
		window.AddLight( Self._2d_light, mx, my,4,4,8,8,8,lightRot )
		window.AddLight( Self._2d_light, mx, my,4,4,8,8,8,lightRot+90+Pi )
		window.AddLight( Self._2d_light, mx, my,4,4,8,8,8,lightRot+180+Pi/2 )
		window.AddLight( Self._2d_light, mx, my,4,4,8,8,8,lightRot+270+Pi+Pi/2 )
		 
		For Local x:=0 Until window.GetWindowWidth() Step Self._floor.Width
			For Local y:=0 Until window.GetWindowHeight() Step _floor.Height
				window.DrawImage( Self._floor,x-window.GetWindowWidth()/2,y-window.GetWindowHeight()/2 )
			Next
		Next
		
		
		For Local an:=0.0 Until TwoPi Step TwoPi/8.0
			window.DrawImage( _logo,(window.GetWindowWidth()/2+Cos( an ) * window.GetWindowWidth()/4) -offsetx, (window.GetWindowHeight()/2 + Sin( an ) * window.GetWindowHeight()/4)-offsety )
		Next
		
		window.EndLighting()
		
	End Method
 
 
 
	Method InitMainGUI:Void()
		Self.generic_window.LoadResources("system_resources/client_skin/window_skin.txt")		
		Self.generic_window.SetScreenSize(1920,1080)
		Self.generic_button.LoadImages("system_resources/client_skin/client_skin.txt")
	End Method
		
		
	Method InitMenuWindow:PWindow(canvas:Canvas,rect:Recti,x:Float,y:Float,w:Float,h:Float)
		Local window:PWindow=New PWindow(canvas,rect,x,y,w,h)
		window.SetBorderStyle(BlendMode.Additive,.4,.4,.6,.8)
		window.SetResizable(True)
		window.SetMinWindowSize(150,150)
		window.SetCLS(False)
		window.SetWindowControls(New String[]("close","maximize","cast"),True)
		window.SetBackgroundImage(Null)
		Return window
	End Method
	
 
	Method Init3DWindow:PWindow(canvas:Canvas,rect:Recti,x:Float,y:Float,w:Float,h:Float)
		Local window:PWindow=New PWindow(canvas,rect,x,y,w,h)
		window.SetBorderStyle(BlendMode.Additive,.4,.4,.6,.8)
		window.SetResizable(True)
		window.SetMinWindowSize(150,150)',5760+210,1080)
		window.SetCLS(False)
		window.SetWindowControls(New String[]("maximize","cast"),True)
		window.SetBackgroundImage(Null)
		Return window
	End Method
	
 
	Method Init2DWindow:PWindow(canvas:Canvas,rect:Recti,x:Float,y:Float,w:Float,h:Float)
		Local window:PWindow=New PWindow(canvas,rect,x,y,w,h)
		window.SetBorderStyle(BlendMode.Additive,.4,.4,.6,.8)
		window.SetResizable(True)
		window.SetMinWindowSize(150,150)',5760+210,1080)
		window.SetCLS(True)
		window.SetWindowControls(New String[]("maximize","cast"),True)
		window.SetBackgroundImage(Null)
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
	
	New PPhoenixWeb("Alien Phoenix 2D / 3D Example - Powered by Alien Phoenix",1920,1080)'device_width,device_height )
	
	App.Run()
	
End
