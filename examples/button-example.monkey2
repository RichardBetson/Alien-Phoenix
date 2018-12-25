'-------------------------------------------------------------------------
'Title: Alien Phoenix Button Example
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
 
Class Bunny
	Field x:Float
	Field y:Float
	Field dx:Float
	Field dy:Float
	Field red:Float=1.0
	Field green:Float=1.0
	Field blue:Float=1.0
	Field frame:Int
	Field alive:Bool=True
End Class
 
Class PPhoenixWeb Extends Window
	
	Field virtualRes:=New Vec2i( 1920, 1080 )
 
	Field current_window:=New PWindow
	Field generic_window:=New PWindow
	Field my2d_window:=New PWindow
	Field about_window:=New PWindow
	Field menu_window:=New PWindow
	Field generic_button:PButton
	Field button_bunny_200:PButton
	Field button_bunny_400:PButton
	Field button_bunny_600:PButton
	Field button_bunny_800:PButton
	Field button_bunny_1000:PButton
	Field button_bunny_nuke:PButton
	Field button_bunny_small:PButton
	Field button_bunny_medium:PButton
	Field button_bunny_large:PButton
	Field scale_w:Float=1.0
	Field scale_h:Float=1.0
	Field Bunny_List:=New List<Bunny>
	Field install:Bool 'Flag intitail setup
 	Field Local_Button_List:= New List<PButton>
	Field nuke:Bool
	Field _logo:Image
	Field ap_logo:Image
	Field bunny:Image
	Field explode:Image
	Field explode_anim:=New Image[20]
 
 
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
		Self.bunny=Image.Load( "asset::bunny-1.png" )
		Self.bunny.Handle=New Vec2f( 0.5, 0.5 )		
		Self.explode=Image.Load( "asset::exp.png" )
 
 		'parse image
 		'-----------
		Local seq:Int
		Local iw:Int,ih:Int
		
		iw=(Self.explode.Width/32)
		ih=(Self.explode.Height/32)
		seq=(iw*ih)

		Local x:Int,y:Int,lcnt:Int
	
		Self.explode_anim= New Image[seq]
		
		For y=0 To (Self.explode.Height-1) Step 32
			For x=0 To (Self.explode.Width-1) Step 32
			Local rect:=New Recti(x,y,x+32,y+32)
				Self.explode_anim[lcnt]=New Image(Self.explode,rect)
				Self.explode_anim[lcnt].Handle=New Vec2f( .5,.5 )
				lcnt=lcnt+1
			Next
		Next
		'-- end --
		
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
			Self.menu_window=InitMenuWindow(canvas,Rect,30,30,245,560)
			
			'Setup a generic window with canvas only
			Self.generic_window=New PWindow(canvas)
			
			canvas.AmbientLight=New Color(.25,.25,.25)
			Self.install=True
		Endif
 
		'Draw about window assets
		Self.RenderAboutWindow()
 
		'Draw 2D asstets
		Self.Render2DExample(my2d_window)		

		'Update and manage buttons
		Self.UpdateMenuWindow()

		
		'Update all windows
		Self.generic_window.UpdateWindow()
		
		App.RequestRender()
	End Method
 
 
	Method RenderAboutWindow()
 
		Self.about_window.DrawImage(Self.ap_logo,120,35)
		Self.about_window.DrawText("Alien Phoenix Button Example - Bunny Corral",150,200)
		Self.about_window.DrawText("Powered by Alien Phoenix",220,220)
		Self.about_window.DrawText("Alien Phoenix Copyright (c) 2018 Richard Betson",135,240)
				
	End Method
 
 	Global iframe:Int
 	Global delta:Int	
	Method Render2DExample:Void(window:PWindow)
		If button_bunny_nuke.button_down
			nuke=True
		Endif
		
		If  nuke=True
			iframe=iframe+1
			If iframe>14 
				iframe=1
			Endif
			Local cnt:Int
			For Local bunnyo:Bunny=Eachin Bunny_List.Backwards()
				cnt=cnt+1
				If cnt<100
					bunnyo.alive=False
				Endif
			Next
			If cnt=0 Then nuke=False
		Endif	
		
		For Local bunnyo:Bunny=Eachin Bunny_List
			
			
			bunnyo.x=bunnyo.x+bunnyo.dx
			bunnyo.y=bunnyo.y+bunnyo.dy
			bunnyo.frame=iframe
			If bunnyo.alive=False
				
				Local pimage:PWindowImage=window.DrawAnimImage(explode_anim, bunnyo.x, bunnyo.y, bunnyo.frame)
				window.SetImageScale(pimage, 3, 3)
			Else
				Local pimage:PWindowImage=window.DrawImage(bunny, bunnyo.x, bunnyo.y)
				window.SetImageColor(pimage,bunnyo.red,bunnyo.green,bunnyo.blue)
				window.SetImageScale(pimage, scale_w, scale_h)
			Endif
			If bunnyo.x >= window.GetWindowWidth()
				bunnyo.x=window.GetWindowWidth()
				bunnyo.dx=-bunnyo.dx
			Endif
			If bunnyo.y >= window.GetWindowHeight()
				bunnyo.y=window.GetWindowHeight()
				bunnyo.dy=-bunnyo.dy
			Endif

			If bunnyo.x <=0 Then bunnyo.dx=-bunnyo.dx
			If bunnyo.y <=0 Then bunnyo.dy=-bunnyo.dy 

			If bunnyo.alive=False And iframe=14
				Bunny_List.Remove(bunnyo)
			Endif
		Next 

		window.DrawText("Resize window and corral bunnies!",( window.GetWindowWidth()*.5 )-100, window.GetWindowHeight() -100 )
		Self.menu_window.DrawText("Add some Bunnies!",20,35)
		Self.menu_window.DrawText("Nuke some Bunnies!",20,280)
		Self.menu_window.DrawText("Size some Bunnies!",20,365)
		
		
	End Method
	
	Method UpdateMenuWindow()
		For Local lbutton:PButton=Eachin Local_Button_List
			If lbutton.ButtonDown()=True
				Local count:Int
				Local red:Float,green:Float,blue:Float
				Select lbutton
					Case Self.button_bunny_200
						count=200
						red=1.0
						green=0.0
						blue=1.0
					Case Self.button_bunny_400
						count=400
						red=0.0
						green=1.0
						blue=0.0
					Case Self.button_bunny_600
						count=600
						red=1.0
						green=1.0
						blue=1.0
					Case Self.button_bunny_800
						count=800
						red=1.0
						green=0.5
						blue=0.2
					Case Self.button_bunny_1000
						count=1000
						red=1.0
						green=0.0
						blue=0.0
					Case Self.button_bunny_small
						Self.button_bunny_small.SetSelected(True)
						Self.button_bunny_medium.SetSelected(False)
						Self.button_bunny_large.SetSelected(False)
						scale_w=0.5
						scale_h=0.5
					Case button_bunny_medium
						Self.button_bunny_small.SetSelected(False)
						Self.button_bunny_medium.SetSelected(True)
						Self.button_bunny_large.SetSelected(False)
						scale_w=1.0
						scale_h=1.0
					Case button_bunny_large
						Self.button_bunny_small.SetSelected(False)
						Self.button_bunny_medium.SetSelected(False)
						Self.button_bunny_large.SetSelected(True)
						scale_w=1.5
						scale_h=1.5
				End Select
				For Local i:Int=1 To count
					Local bunnyo:=New Bunny
					Self.Bunny_List.AddLast(bunnyo)
					bunnyo.x=Rnd(100)
					bunnyo.y=Rnd(100)
					bunnyo.dx=Rnd(6.0)
					bunnyo.dy=Rnd(6.0)
					bunnyo.red=red
					bunnyo.green=green
					bunnyo.blue=blue
				Next
			Endif
		Next
	
	End Method
 
 
	Method InitMainGUI:Void(canvas:Canvas)
		Self.generic_window.LoadResources("system_resources/client_skin/window_skin.txt")		
		Self.generic_window.SetScreenSize(1920,1080)
		Self.generic_button.LoadImages("system_resources/client_skin/client_skin.txt")

	End Method
				
 
	Method Init2DWindow:PWindow(canvas:Canvas,rect:Recti,x:Float,y:Float,w:Float,h:Float)
		Local window:PWindow=New PWindow(canvas,rect,x,y,w,h)
		window.SetBorderStyle(BlendMode.Additive,.8,.4,.6,.8)
		window.SetResizable(True)
		window.SetMinWindowSize(150,150)',5760+210,1080)
		window.SetCLS(False)
		window.SetWindowControls(New String[]("maximize","cast"),True)
		'window.SetBackgroundImage(Null)
		For Local i:Int=1 To 999
			Local bunnyo:=New Bunny
			Self.Bunny_List.AddLast(bunnyo)
			bunnyo.x=Rnd(100)
			bunnyo.y=Rnd(100)
			bunnyo.dx=Rnd(6.0)
			bunnyo.dy=Rnd(6.0)
		Next
		Return window
	End Method

 
	Method InitMenuWindow:PWindow(canvas:Canvas,rect:Recti,x:Float,y:Float,w:Float,h:Float)
		Local window:PWindow=New PWindow(canvas,rect,x,y,w,h)
		window.SetBorderStyle(BlendMode.Additive,.8,.4,.6,.8)
		window.SetResizable(False)
		window.SetWindowTop(True)
		window.SetMinWindowSize(150,150)',5760+210,1080)
		window.SetCLS(True)
		'window.SetWindowControls(New String[]("maximize","cast"),True)
		'window.SetBackgroundImage(Null)
		
		Self.button_bunny_200=New PButton("200 Bunnies",20,60,200,30,1,1,window,Local_Button_List)
		Self.button_bunny_400=New PButton("400 Bunnies",20,100,200,30,1,1,window,Local_Button_List)
		Self.button_bunny_600=New PButton("600 Bunnies",20,140,200,30,1,1,window,Local_Button_List)
		Self.button_bunny_800=New PButton("800 Bunnies",20,180,200,30,1,1,window,Local_Button_List)
		Self.button_bunny_1000=New PButton("1000 Bunnies",20,220,200,30,1,1,window,Local_Button_List)
		Self.button_bunny_nuke=New PButton("Nuke Bunnies!",20,305,200,30,1,1,window,Local_Button_List)
		
		Self.button_bunny_small=New PButton("Small Bunnies",20,390,200,30,1,1,window,Local_Button_List)
		Self.button_bunny_medium=New PButton("Medium Bunnies!",20,430,200,30,1,1,window,Local_Button_List)
		Self.button_bunny_large=New PButton("Large Bunnies!",20,470,200,30,1,1,window,Local_Button_List)

		Self.button_bunny_small.SetSelected(False)
		Self.button_bunny_medium.SetSelected(True)
		Self.button_bunny_large.SetSelected(False)
								
		Self.button_bunny_200.SetTextColor(1.0,0.0,1.0)
		Self.button_bunny_400.SetTextColor(0.0,1.0,0.0)
		Self.button_bunny_600.SetTextColor(1.0,1.0,1.0)
		Self.button_bunny_800.SetTextColor(1.0,0.5,0.2)
		Self.button_bunny_1000.SetTextColor(1.0,0.0,0.0)
		Self.button_bunny_nuke.SetTextColor(0.0,0.0,0.0)
		Return window
	End Method
 
 
	Method InitAboutWindow:PWindow(canvas:Canvas,rect:Recti,x:Float,y:Float,w:Float,h:Float)
		Local window:PWindow=New PWindow(canvas,rect,x,y,w,h)
		window.SetBorderStyle(BlendMode.Additive,.4,.4,.6,.8)
		window.SetResizable(False)
		window.SetMinWindowSize(150,150)
		window.SetCLS(True)
		window.SetWindowControls(New String[]("close"),True)
		window.SetBackgroundImage(Null)
		window.SetWindowOnTop()
		Return window
	End Method
 
End Class
 
Function Main()
 
	New AppInstance
	
	New PPhoenixWeb("Alien Phoenix Button Example - Powered by Alien Phoenix",1920,1080)'device_width,device_height )
	
	App.Run()
	
End
