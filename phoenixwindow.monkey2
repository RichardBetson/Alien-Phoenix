'******************************************************************************
'* Alien Phoenix Gaming Framework							  
'* Copyright (c) 2018 Richard R Betson
'* Author - Richard R Betson
'* 
'* Language: Monkey2
'* Targets: Android, Windows, Linux, Emscripten, IOS
'* Title: Phoenix Window 
'* Licence: zlib/libpng License (Zlib) - https://opensource.org/licenses/Zlib
'* Version: 0.7
'******************************************************************************

Namespace phoenixwindow

'#Import "phoenixconsole"
'Using phoenixconsole

Global dx11_flag:Int=False
'Screen coords for reseting viewport (see lock_view_port)
Global global_screen_x:Int
Global global_screen_y:Int
Global global_screen_width:Float
Global global_screen_height:Float
'------------------------------
Global PWindow_List:=New List<PWindow>
Global PWindow_List_Swap:=New List<PWindow>
Global g_cursor:Image
Global g_cursor_scale_horz:Image
Global g_cursor_scale_vert:Image
Global g_cursor_scale_ne:Image
Global g_cursor_scale_nw:Image
Global g_cursor_scale_se:Image
Global g_cursor_scale_sw:Image
Global g_cursor_offx:Int
Global g_cursor_offy:Int
Global g_cursor_scale:Image
Global g_cursor_scale_offx:Int
Global g_cursor_scale_offy:Int
Global g_mouse_move_time:Int,g_old_mouse_x2:Int,g_old_mouse_y2:Int 'mouse cursor show time, x, y
Global g_mouse_cursor_on:Int=False 'Flag for cursor on/off bypassing time to show
Global g_window_selected_report:Int
Global g_move_window_overide:Int
Global g_window_background_image:Image
Global g_window_border_left:Image
Global g_window_border_right:Image,g_window_border_top:Image,g_window_border_bottom:Image
Global g_window_maxamized:Int=False
Global g_window_screen_cast:Int

Global g_screen_cast_window_image_up:Image
Global g_maximize_window_image_up:Image
Global g_restore_window_image_up:Image
Global g_close_window_image_up:Image

Global g_screen_cast_window_image_down:Image
Global g_maximize_window_image_down:Image
Global g_restore_window_image_down:Image
Global g_close_window_image_down:Image

Global g_window_system_console:Console



Class PWindowText
	Field _text:String
	Field _text_x:Int
	Field _text_y:Int
	Field _text_blend:Int
	Field _text_alpha:Float
	Field _text_scalex:Float
	Field _text_scaley:Float
	Field _text_red:Int
	Field _text_green:Int
	Field _text_blue:Int	
	Field _text_font:Font
End Class

Class PWindowTextArray
	Field _text:String
	Field _text_x:Int
	Field _text_y:Int
	Field _text_blend:Int
	Field _text_alpha:Float
	Field _text_scalex:Float
	Field _text_scaley:Float
	Field _text_red:Int
	Field _text_green:Int
	Field _text_blue:Int	
	Field _text_font:Font
End Class



Class PTextArea
	Field _text_area_array:String[]
	Field _text_area_x:Int
	Field _text_area_y:Int
	Field _text_area_w:Int
	Field _text_area_h:Int
	Field _text_area_blend:Int
	Field _text_area_alpha:Float
	Field _text_area_scalex:Float
	Field _text_area_scaley:Float
	Field _text_area_red:Int
	Field _text_area_green:Int
	Field _text_area_blue:Int	
	Field _text_area_slider_vert:PSlider
	Field _text_area_font:Font
End Class


Class PWindowImage Final
	Field _light_bumpmap_image_flag:Int=False
	Field _window_image:Image
	Field _window_image_anim:Image[]
	Field _window_image_anim_flag:Int
	Field _window_image_x:Float
	Field _window_image_y:Float
	Field _window_image_alpha:Float
	Field _window_image_blend:Int
	Field _window_image_red:Float
	Field _window_image_green:Float
	Field _window_image_blue:Float
	Field _window_image_scalex:Float
	Field _window_image_scaley:Float
	Field _window_image_rotation:Float
	Field _window_image_frame:Int
	Field _window_image_frame_count:Int
	Field _window_image_delta:Int
	Field _window_image_delta_mark:Int
End Class

Class PWindowLine
	Field _window_line_x:Float
	Field _window_line_y:Float
	Field _window_line_x1:Float
	Field _window_line_y1:Float
	Field _window_line_red:Float=1.0
	Field _window_line_green:Float=1.0
	Field _window_line_blue:Float=1.0
End Class


Class PWindowRect
	Field _window_rect_x:Float
	Field _window_rect_y:Float
	Field _window_rect_w:Float
	Field _window_rect_h:Float
	Field _window_rect_red:Float=1.0
	Field _window_rect_green:Float=1.0
	Field _window_rect_blue:Float=1.0
End Class


Class PDrawList
	Field _image:PWindowImage
	Field _light:PWindowLight
	Field _text:PWindowText
	Field _text_area:PTextArea
	Field _text_array:PWindowTextArray
	Field _line:PWindowLine
	Field _rect:PWindowRect
	Field _window_lighting:PWindowLighting
	Field _camera:PWindow3DCamera
	Field _ambient_light:PWindowAmbient
End Class


Class PWindow3DCamera
	Field _camera:Camera
	Field _scene:Scene
'	Field _light:Light
'	Field _model:Model
	Field _x:Float
	Field _y:Float
	Field _z:Float
	Field _w:Float
	Field _h:Float
	Field _red:Float=1.0
	Field _green:Float=1.0
	Field _blue:Float=1.0
End Class


Class PWindowLight
	Field _image:Image
	Field _x:Float
	Field _y:Float
	Field _scalex:Float
	Field _scaley:Float
	Field _rotation:Float
	Field _red:Float=1.0
	Field _green:Float=1.0
	Field _blue:Float=1.0
End Class


Class PWindowLighting
	Field begin_lighting:Bool
	Field end_lighting:Bool
End Class


Class PWindowAmbient
	Field _red:Float
	Field _green:Float
	Field _blue:Float
End Class

'Class PTextArea
'	
'End Class

Class PNavBar
	Field _image:Image
	Field _x:Float
	Field _y:Float 
	Field _w:Float
	Field _h:Float
	Field _scalew:Float
	Field _scaleh:Float
	Field _alpha:Float=.7
	Field _blend:BlendMode=BlendMode.Alpha
	Field _red:Float=.3
	Field _green:Float=.3
	Field _blue:Float=.6
	Field _color:Color
	
	Field _window:PWindow
	
	
	
	Field Nav_Button_List:=New List<PButton>
	Field Nav_Listbox_List:=New List<PListBox>
	'Field Nav_Slider_List:=New List<Slider>
	
	Method New()
	End Method 
	
	Method New(image:Image,x:Float,y:Float,width:Float,height:Float,window:PWindow )
		Self._image=image
		Self._x=x
		Self._y=y
		Self._w=width
		Self._h=height
		Self._scalew=window._window_width/Self._image.Width
		Self._scaleh=height/Self._image.Height
		Self._window=window
	End Method 
	
	Method Update()
	'	Local dimage:PWindowImage= Self._window.AddWindowImage(Self._image,Self._x,Self._y,0,Self._scalew,Self._scaleh,Self._blend,Self._alpha)
	'	Self._window.SetWindowImageColor(dimage,Self._red,Self._green,Self._blue)
		
		Self._window._canvas.Translate((Self._x),(Self._y))'960,540)'new_window._window_x+new_window._window_viewport_x+
		Self._window._canvas.Scale(Self._scalew,Self._scaleh)
		Self._window._canvas.Rotate(0)'PWindow_image._window_image_rotation * degree_scalar)
		Self._window._canvas.DrawImage(Self._image,Self._x,Self._y)
	End Method
	
	Method AddNavControl(x:Float,y:Float,name:String,image:Image)
		
	'	Local tmp:= New Button()
		
	End Method
	
End Class 



Class PWindow
'	Field _dlist:PDrawList2=New PDrawList2
	Field _gui_font:Font
	Field _canvas:Canvas
	Field _canvas_rotation:Float=0.0
	Field _canvas_translation_x:Float=0.0
	Field _canvas_translation_y:Float=0.0
	Field _canvas_scale_w:Float=1.0
	Field _canvas_scale_h:Float=1.0
	Field _window_image:Image
	Field _window_background_image_flag:Bool
	Field _window_x:Float
	Field _window_y:Float
	Field _window_old_x:Float
	Field _window_old_y:Float
	Field _window_old_width:Float
	Field _window_old_height:Float
	
	Field _window_width:Float=100
	Field _window_height:Float=100
	Field _window_alpha:Float=1.0
	Field _window_blend:Int=BlendMode.Alpha
	Field _window_red:Float=1.0
	Field _window_green:Float=1.0
	Field _window_blue:Float=1.0
	Field _window_viewport_x:Int
	Field _window_viewport_y:Int
	Field _window_viewport_width:Int=50
	Field _window_viewport_height:Int=50
	Field _window_top_most:Int=False
	Field _window_visible:Int=True
	'----------------------------------
	'Flag to allow one extra list 
	'iteration to reset GUI componnents
	'ie: reset button down
	'----------------------------------
	Field _window_close_hide_process_flag:Int=False
	'----------------------------------
	
	'-----------------------
	'Screen cast and min/max
	'-----------------------
	Field _window_cast_screen_flag:Int=False
	Field _window_maximize_flag:Int
	
	Field _window_minimize_flag:Int
	Field _window_old_maximize_width:Int
	Field _window_old_maximize_height:Int
	Field _window_old_maximize_x:Int
	Field _window_old_maximize_y:Int
	Field _window_old_resize_flag:Int
	Field _window_old_move_flag:Int
	
	'Window control button objects
	Field _window_cast_control:PButton
	Field _window_maximize_control:PButton
	Field _window_close_control:PButton
	Field Window_Control_Button_List:=New List<PButton>
	'-----------------------
	
	Field _window_movable:Int=True
	Field _window_selected:Int=True
	Field _window_selectable:Int=True
	Field _window_text_array:String[]
	Field _PWindow_border_left:Image
	Field _PWindow_border_right:Image
	Field _PWindow_border_top:Image
	Field _PWindow_border_bottom:Image
	Field _PWindow_border_left_width:Int=1
	Field _PWindow_border_left_height:Int=1
	Field _PWindow_border_right_width:Int=1
	Field _PWindow_border_right_height:Int=1
	Field _PWindow_border_top_width:Int=1
	Field _PWindow_border_top_height:Int=1
	Field _PWindow_border_bottom_width:Int=1
	Field _PWindow_border_bottom_height:Int=1
	Field _window_border_height:Int=1
	Field _window_border_width:Int=1
	Field _window_border_left_scale:Float
	Field _window_border_right_scale:Float
	Field _window_border_top_scale:Float
	Field _window_border_bottom_scale:Float
	Field _window_border_blend:Int
	Field _window_border_alpha:Float
	Field _window_border_red:Float
	Field _window_border_green:Float
	Field _window_border_blue:Float
	Field _window_border:Int=False
	Field _window_border_enable_flag:Int
	Field _window_border_forced:Int=True
	Field _window_text_alpha:Float
	Field _window_text_blend:Int
	Field _window_text_red:Float
	Field _window_text_green:Float
	Field _window_text_blue:Float
	Field _window_image_array_index:Int=0
	Field _window_resize_width:Int=35
	Field _window_resize_height:Int=35
	Field _window_image_scale_width:Float
	Field _window_image_scale_height:Float
	Field _window_z:Int
	Field _window_view_port_x:Int
	Field _window_view_port_y:Int
	Field _window_view_port_width:Int
	Field _window_view_port_height:Int

	Field _window_cls_flag:Bool
	Field _window_cls_red:Float
	Field _window_cls_green:Float
	Field _window_cls_blue:Float 
	Field _window_cls_color:=New Color(0,0,0)

	'Field PWindow_Line_List:=New List<PWindowLine>
	'Field PWindow_Image_List:=New List<PWindowImage>
	Field PWindow_Text_List:=New List<PWindowText>
	'Field PWindow_Text_List_Immediate:=New List<PWindow_Text_Immediate>
	Field _window_resize_on:Int
	Field user_viewport_x:Int
	Field user_viewport_y:Int
	Field user_viewport_w:Int
	Field user_viewport_h:Int
	Field _window_rotation_flag:Int
	'Field _window_rotation_dx11:Int
	Field _window_rotation_offset_x:Int
	Field _window_rotation_offset_y:Int
	Field _window_rotation_angle:Int
	Field _min_window_width:Int=50
	Field _min_window_height:Int=50

	Field _max_window_width:Int=50
	Field _max_window_height:Int=50

	Field _silder_user_forced_focus:Int
	Field _mouse_click_time:Int
	'-----------------------
	'Draw window text method
	'-----------------------
	'Global _window_text_array:String[]
	Global _window_text_x:Int
	Global _window_text_y:Int
	Field _window_text_w:Int
	Field _window_text_h:Int
	Global _window_text_order:Int
	'Field PWindow_Text_List:TList=CreateList()
	Field _mouse_down:Int=False
	Field old_m_x:Int
	Field old_m_y:Int
	Field _window_move:Int=True
	Field _window_resize_flag:Int
	Field _window_resize_mouseover_flag:Int=False
	Field _window_text:String
	Field _window_text_color_red:Float=1.0
	Field _window_text_color_green:Float=1.0
	Field _window_text_color_blue:Float=1.0
	Field _textoffset:Int
	
	'--------------------
	'light mojo2
	'--------------------
	Field _bumpmap:Image

	Global light_index:Int=-1
	
	Field _mojo_rect:Recti



	'---------------
	'Menu
	'---------------
	Field _window_menu_bar:PNavBar

	Field draw_image_cnt:Int	'Counter for images in draw list per frame

	Field Window_Button_List:=New List<PButton>
	Field Window_ListBox_List:=New List<PListBox>
	Field Window_Slider_List:=New List<PSlider>
	Field Window_Draw_List:=New Stack<PDrawList>
	
	Field _draw_stack:=New PDrawList[1000]
	Field _draw_list_index:Int
	
	Field _radian_scalar:Float=(180/Pi)
	Field _degree_scalar:Float=(Pi/180)




	Method SetScreenSize:Void(w:Float,h:Float)
		global_screen_width=w
		global_screen_height=h
		For Local window:=Eachin PWindow_List
			window._mojo_rect=New Recti(0,0,w,h)
			window._max_window_width=w
			window._max_window_height=h
		Next
	End Method



	Method LoadImages:Void(i1:Image,i2:Image,i3:Image,i4:Image,cursor_horz:Image,cursor_vert:Image)
		g_cursor=i2
		g_cursor_scale_ne=i3
		g_cursor_scale_sw=i1
		g_cursor_scale_nw=i4
		g_cursor_scale_se=i4
		g_cursor_scale_horz=cursor_horz
		g_cursor_scale_vert=cursor_vert
		g_cursor_offx=0
		g_cursor_offy=0
		g_cursor_scale_offx=0
		g_cursor_scale_offy=0
	End Method


	Method New()
	End Method

	Method New(canvas:Canvas)
			Self._canvas=canvas
	End Method

	Method New(canvas:Canvas,rect:Recti,window_x:Int,window_y:Int,window_width:Int,window_height:Int,window_blend_m:Int=BlendMode.Alpha,window_alpha:Float=0,window_red:Float=0,window_green:Float=0,window_blue:Float=0)
		Self._canvas=canvas
		Self._mojo_rect=rect
						
		'clear any selected window flags
		Local new_window2:PWindow=New PWindow
		For new_window2=Eachin PWindow_List
			new_window2._window_selected=False
		Next
		
		If g_window_background_image<>Null
			Self._window_image=g_window_background_image
			Self._window_image_scale_width=Float(Float(window_width)/Float(g_window_background_image.Width))
			Self._window_image_scale_height=Float(Float(window_height)/Float(g_window_background_image.Height))
			Self._window_background_image_flag=True
		Endif
		Self._window_viewport_width=window_width
		Self._window_viewport_height=window_height
		Self._window_x=window_x
		Self._window_y=window_y
		Self._window_width=window_width
		Self._window_height=window_height
		Self._window_old_x=_window_x
		Self._window_old_y=_window_y
		Self._max_window_width=global_screen_width
		Self._max_window_height=global_screen_height
		
		If g_window_border_right<>Null And g_window_border_left<>Null And g_window_border_top<>Null And g_window_border_bottom<>Null
			Self.SetWindowBorder(g_window_border_right,g_window_border_left,g_window_border_top,g_window_border_bottom)
		Endif

		PWindow_List.AddLast(Self)
		Self.SetWindowOnTop()
	End Method

	Method CloseWindow:Void()
	
	End Method
	
	
	Method MoveWindow:Void(window_obj:PWindow,msx:Int,msy:Int)
		If window_obj._window_movable=True And g_move_window_overide=False 
			Local my:Int=msy
			Local mx:Int=msx
			window_obj._window_x=((window_obj._window_old_x)-(old_m_x-mx))
			window_obj._window_y=((window_obj._window_old_y)-(old_m_y-my))
			If window_obj._window_x < window_obj._window_view_port_x Then window_obj._window_x=window_obj._window_view_port_x
			If window_obj._window_y < window_obj._window_view_port_y Then window_obj._window_y=window_obj._window_view_port_y
			If window_obj._window_x+window_obj._window_width > window_obj._window_view_port_width  Then  window_obj._window_x=window_obj._window_view_port_width-(window_obj._window_width)
			If window_obj._window_y+window_obj._window_height > window_obj._window_view_port_height  Then  window_obj._window_y=window_obj._window_view_port_height-(window_obj._window_height)
		Endif
	End Method
	
	
	Method SetMinWindowSize:Void(minw:Int=0,minh:Int=0,maxw:Int=0,maxh:Int=0,bypass_flag:Bool=False)
		If bypass_flag=True And Self._window_cast_screen_flag=True
			Self.SetScreenCast(False)
		Endif
		If minw>0 Then Self._min_window_width=minw
		If minh>0 Then Self._min_window_height=minh
		If maxw>0 Then Self._max_window_width=maxw
		If maxh>0 Then Self._max_window_height=maxh
	End Method
	
	
	Method SetWindowSize:Void(w:Int,h:Int,bypass_flag:Bool=False)
		If bypass_flag=True And Self._window_cast_screen_flag=True
			Self.SetScreenCast(False)
		Endif
		Self._window_width=w 
		Self._window_height=h 
		If Self._window_width<Self._min_window_width Then  Self._window_width=Self._min_window_width
		If Self._window_width>Self._max_window_width Then  Self._window_width=Self._max_window_width
		
		If Self._window_height<Self._min_window_height Then  Self._window_height=Self._min_window_height
		If Self._window_height>Self._max_window_height Then  Self._window_height=Self._max_window_height
		
		Self._window_viewport_width=Self._window_width
		Self._window_viewport_height=Self._window_height
		If Self._window_image<>Null
			Self._window_image_scale_width=Float(Float(Self._window_viewport_width)/Float(Self._window_image.Width))
			Self._window_image_scale_height=Float(Float(Self._window_viewport_height)/Float(Self._window_image.Height))
		Endif
		If Self._PWindow_border_right<>Null And Self._PWindow_border_left<>Null And Self._PWindow_border_bottom<>Null And Self._PWindow_border_top<>Null
 			Self._window_border_left_scale=Float(Float(Self._window_height )/Float(Self._PWindow_border_left.Height))
			Self._window_border_right_scale=Float(Float(Self._window_height )/Float(Self._PWindow_border_right.Height))
			Self._window_border_top_scale=Float(Float(Self._window_viewport_width+(Self._PWindow_border_left_width*2) )/Float(Self._PWindow_border_top.Width))
			Self._window_border_bottom_scale=Float(Float(Self._window_viewport_width +(Self._PWindow_border_left_width*2)  )/Float(Self._PWindow_border_bottom.Width))
		Endif		
	End Method
	
	
	Method ResizeWindow:Void(window_obj:PWindow,position:Int,msx:Int,msy:Int)
'		If (window_obj._window_width>=window_obj._min_window_width And window_obj._window_height>=window_obj._min_window_height)
'			If (window_obj._window_width<=window_obj._max_window_width And window_obj._window_height<=window_obj._max_window_height)
			Select position
			'----------------
			'Corners
			'----------------
			Case 1
				Local tmp_height:Float= (msy-window_obj._window_y)
				If tmp_height>window_obj._min_window_height And tmp_height<=window_obj._max_window_height' Then 
					If window_obj._window_height>window_obj._min_window_height 
					window_obj._window_height=tmp_height
					Endif
				Endif

				If window_obj._window_width>= window_obj._min_window_width Or window_obj._window_width<= window_obj._max_window_width Then window_obj._window_width= msx-window_obj._window_x 
			Case 2
				Local tmp_height:Float= window_obj._window_height+(window_obj._window_y-msy)
				If tmp_height>window_obj._min_window_height And tmp_height<=window_obj._max_window_height
					If window_obj._window_height>window_obj._min_window_height 
					window_obj._window_y=msy
					window_obj._window_height=tmp_height
					Endif
				Endif

				Local tmp_width:Float= (msx-window_obj._window_x)
				If tmp_width>window_obj._min_window_width And tmp_width<=window_obj._max_window_width 
					If window_obj._window_width>window_obj._min_window_width 
					window_obj._window_width=tmp_width
					Endif
				Endif
			Case 3
				Local tmp_height:Float= (msy-window_obj._window_y)
				If tmp_height>window_obj._min_window_height And tmp_height<=window_obj._max_window_height
					If window_obj._window_height>window_obj._min_window_height 
					window_obj._window_height=tmp_height
					Endif
				Endif

				Local tmp_width:Float= window_obj._window_width + (window_obj._window_x-msx)
				If tmp_width>window_obj._min_window_width And tmp_width<=window_obj._max_window_width 
					If window_obj._window_width>window_obj._min_window_width 
					window_obj._window_width=tmp_width
					window_obj._window_x=msx
					Endif
				Endif

			Case 4
				Local tmp_height:Float= window_obj._window_height+(window_obj._window_y-msy)
				If tmp_height>window_obj._min_window_height And tmp_height<=window_obj._max_window_height
					If window_obj._window_height>window_obj._min_window_height 
					window_obj._window_y=msy
					window_obj._window_height=tmp_height
					Endif
				Endif

				Local tmp_width:Float= window_obj._window_width+ (window_obj._window_x-msx)
				If tmp_width>window_obj._min_window_width And tmp_width<=window_obj._max_window_width 
					If window_obj._window_width>window_obj._min_window_width 
					window_obj._window_width=tmp_width
					window_obj._window_x=msx
					Endif
				Endif
			'-----------------------
			'Sides
			'-----------------------
			Case 5
				Local tmp_width:Float= window_obj._window_width+ (window_obj._window_x-msx)
				If tmp_width>window_obj._min_window_width And tmp_width<=window_obj._max_window_width 
					If window_obj._window_width>=window_obj._min_window_width 
					window_obj._window_width=tmp_width
					window_obj._window_x=msx
					Endif
				Endif
			Case 6
				Local tmp_width:Float= (msx-window_obj._window_x)
				If tmp_width>window_obj._min_window_width And tmp_width<=window_obj._max_window_width 
					If window_obj._window_width>=window_obj._min_window_width 
					window_obj._window_width=tmp_width
					Endif
				Endif
			Case 7
				Local tmp_height:Float= window_obj._window_height+(window_obj._window_y-msy)
				If tmp_height>window_obj._min_window_height And tmp_height<=window_obj._max_window_height
					If window_obj._window_height>=window_obj._min_window_height 
					window_obj._window_y=msy
					window_obj._window_height=tmp_height
					Endif
				Endif
			Case 8
'				Local tmp_height:Float= window_obj._window_height+(window_obj._window_y-msy)
'				If tmp_height>window_obj._min_window_height And tmp_height<=window_obj._max_window_height
'					If window_obj._window_height>window_obj._min_window_height 
'					window_obj._window_y=msy
'					window_obj._window_height=tmp_height
'					Endif
'				Endif
				Local tmp_height:Float= (msy-window_obj._window_y)
				If tmp_height>window_obj._min_window_height And tmp_height<=window_obj._max_window_height' Then 
					If window_obj._window_height>=window_obj._min_window_height 
					window_obj._window_height=tmp_height
					Endif
				Endif


			End Select

			If window_obj._window_width<window_obj._min_window_width Then  window_obj._window_width=window_obj._min_window_width
			If window_obj._window_width>window_obj._max_window_width Then  window_obj._window_width=window_obj._max_window_width
			If window_obj._window_height<window_obj._min_window_height Then  window_obj._window_height=window_obj._min_window_height
			If window_obj._window_height>window_obj._max_window_height Then  window_obj._window_height=window_obj._max_window_height
			
			
			window_obj._window_viewport_width=window_obj._window_width
			window_obj._window_viewport_height=window_obj._window_height
			If window_obj._window_image<>Null
				window_obj._window_image_scale_width=Float(Float(window_obj._window_viewport_width )/Float(window_obj._window_image.Width))
				window_obj._window_image_scale_height=Float(Float(window_obj._window_viewport_height )/Float(window_obj._window_image.Height))
			Endif
			If window_obj._window_border_enable_flag=True
			window_obj._window_border_left_scale=Float(Float(window_obj._window_height )/Float(window_obj._PWindow_border_left_height))
			window_obj._window_border_right_scale=Float(Float(window_obj._window_height )/Float(window_obj._PWindow_border_right_height))
			window_obj._window_border_top_scale=Float(Float(window_obj._window_viewport_width+(window_obj._PWindow_border_right.Width*2) )/Float(window_obj._PWindow_border_top_width))
			window_obj._window_border_bottom_scale=Float(Float(window_obj._window_viewport_width +(window_obj._PWindow_border_right.Width*2)  )/Float(window_obj._PWindow_border_bottom_width))
'			Endif
'			Endif
		Endif
	End Method
	
	
	Method RotateCanvas:Void(rot:Float)
		Self._canvas_rotation=rot
	End Method
	
	
	Method ScaleCanvas:Void(w:Float,h:Float)
		Self._canvas_scale_w=w
		Self._canvas_scale_h=h
	End Method
	
	
	Method TranslateCanvas:Void(x:Float, y:Float)
		Self._canvas_translation_x=x
		Self._canvas_translation_y=y
	End Method
	
	
	Global mdown:Int
	
	Method DrawWindow:Void(msx:Int,msy:Int)
		For Local new_window:PWindow=Eachin PWindow_List.Backwards()
			If new_window._window_visible=True Or ( new_window._window_visible=False And new_window._window_close_hide_process_flag=True)
				If new_window._window_close_hide_process_flag=True Then new_window._window_visible=True 'See below.
				'----------------------------------
				'Draw windows and GUI components.
				'Draw images, test and mojo2 render
				'----------------------------------
				'
				'Test For Window Occulsion
				'-------------------------
				'-------------------
				'If window maximized
				'only draw it'
				'-------------------
				If g_window_maxamized=False 'And g_window_screen_cast=False'Or (g_window_maxamized=False And new_window._window_cast_screen=True)
					If g_window_screen_cast=False Then DrawWindowUpdate(new_window,msx,msy)
				Else
					If (new_window._window_maximize_flag=True And  new_window._window_cast_screen_flag=False)  Or  (new_window._window_cast_screen_flag=False And new_window._window_top_most=True)
						DrawWindowUpdate(new_window,msx,msy)
					Endif
				Endif
				'----------------------------
				'If window maximized and cast
				'draw all visible windows.
				'----------------------------		
				If g_window_screen_cast=True 'And g_window_maxamized=False
					'If new_window._window_selected=False Or new_window._window_cast_screen_flag=True
						DrawWindowUpdate(new_window,msx,msy)
					'Endif
				
				Endif
				'------------------------------------
				'Check if window was closed or hidden
				'to allow a final iteration to reset
				'button down and other GUI states.
				'------------------------------------
				If new_window._window_close_hide_process_flag=True
					new_window._window_close_hide_process_flag=False
					new_window._window_visible=False 
				Endif
			Endif
		'	new_window.Window_Draw_List.Clear()
			'new_window.PWindow_Image_List.Clear()
			'new_window.PWindow_Line_List.Clear()
		Next
	End Method
	
	
	Method DrawWindowUpdate:Void(new_window:PWindow,msx:Int,msy:Int)
		Local time:Int=Millisecs()	
		Local myMatrix:=New AffineMat3f
		Local degree_scalar:Float=( Pi/180.0 ) 'for degree conversion


'		If new_window._canvas=Null
'			Print "NULL CANVAS - DrawUpdateWindow()"
'			Print new_window._window_x
'			Print new_window._window_width
'		Endif
		new_window._canvas.PushMatrix()
		If new_window._window_visible=True And (new_window._canvas.Viewport.BottomRight.X>new_window._window_x+new_window._window_viewport_x And new_window._canvas.Viewport.BottomRight.Y>new_window._window_y+new_window._window_viewport_y)

			'---------------------------
			'Clear screen for window.
			'Only clears viewport aerea.
			'---------------------------
			If new_window._window_cls_flag=True
				LockViewport(new_window)
			
				new_window._canvas.Clear(new_window._window_cls_color)
			
				new_window._canvas.PopMatrix()
				new_window._canvas.PushMatrix()
				UnlockViewportWindow(new_window)
			Endif

			
			'-----------------------------
			'Draw Window Background Image
			'-----------------------------
			If new_window._window_image<>Null And new_window._window_background_image_flag=True
				new_window._canvas.Alpha=new_window._window_alpha'SetAlpha(new_window._window_alpha)
				SetBlendMode(new_window._canvas,new_window._window_blend)
			'change color to window when selected/un-selected
			'	If new_window._window_selected=True
					new_window._canvas.Color= New Color(new_window._window_red,new_window._window_green,new_window._window_blue)
			'	Else
			'		new_window._canvas.Color=New Color(new_window._window_red*.5,new_window._window_green*.5,new_window._window_blue*.5)
			'	Endif

				myMatrix.i.x=new_window._window_image_scale_width
				myMatrix.j.y=new_window._window_image_scale_height
				myMatrix.t.x=new_window._window_x+new_window._window_viewport_x
				myMatrix.t.y=new_window._window_y+new_window._window_viewport_y
				new_window._canvas.Matrix*=myMatrix   'transform current matrix by myMatrix.


				new_window._canvas.DrawImage (new_window._window_image,0,0)
			Endif
			new_window._canvas.PopMatrix()
			new_window._canvas.PushMatrix()
			
			'--------------------
			'Draw Window Borders
			'--------------------
			If (new_window._window_border=True Or new_window._window_border_forced=True) And new_window._window_border_enable_flag=True 
				new_window._canvas.Alpha=(new_window._window_border_alpha)
				SetBlendMode(new_window._canvas,new_window._window_border_blend)
				If new_window._window_selected=True			
				new_window._canvas.Color=New Color(new_window._window_border_red,new_window._window_border_green,new_window._window_border_blue)
				Else
				new_window._canvas.Color=New Color(new_window._window_border_red*.5,new_window._window_border_green*.5,new_window._window_border_blue*.5)
				Endif

				myMatrix.i.x=1
				myMatrix.j.y=new_window._window_border_left_scale
				myMatrix.t.x=new_window._window_x-new_window._window_border_width
				myMatrix.t.y=new_window._window_y
				new_window._canvas.Matrix*=myMatrix   'transform current matrix by myMatrix.

				If new_window._PWindow_border_left<>Null Then new_window._canvas.DrawImage (new_window._PWindow_border_left,0,0)' new_window._window_x, new_window._window_y)
				new_window._canvas.PopMatrix()
				new_window._canvas.PushMatrix()
				myMatrix.i.x=1
				myMatrix.j.y=new_window._window_border_right_scale
				myMatrix.t.x=new_window._window_x+new_window._window_width
				myMatrix.t.y=new_window._window_y
				new_window._canvas.Matrix*=myMatrix   'transform current matrix by myMatrix.

				If new_window._PWindow_border_right<>Null Then new_window._canvas.DrawImage (new_window._PWindow_border_right, 0,0)'new_window._window_x+new_window._window_viewport_width, new_window._window_y)
				new_window._canvas.PopMatrix()
				new_window._canvas.PushMatrix()
				myMatrix.i.x=new_window._window_border_top_scale
				myMatrix.j.y=1
				myMatrix.t.x=new_window._window_x-(new_window._PWindow_border_left_width)
				myMatrix.t.y=new_window._window_y-new_window._window_border_height
				new_window._canvas.Matrix*=myMatrix   'transform current matrix by myMatrix.

				If new_window._PWindow_border_top<>Null Then new_window._canvas.DrawImage (new_window._PWindow_border_top, 0,0)'new_window._window_x+new_window._window_viewport_x, new_window._window_y)
				new_window._canvas.PopMatrix()
				new_window._canvas.PushMatrix()
				myMatrix.i.x=new_window._window_border_bottom_scale
				myMatrix.j.y=1
				myMatrix.t.x=new_window._window_x+new_window._window_viewport_x-new_window._PWindow_border_left_width
				myMatrix.t.y=new_window._window_y+new_window._window_viewport_height
				new_window._canvas.Matrix*=myMatrix   'transform current matrix by myMatrix.

				If new_window._PWindow_border_bottom<>Null Then new_window._canvas.DrawImage (new_window._PWindow_border_bottom, 0,0)' new_window._window_x+new_window._window_viewport_x, new_window._window_y+new_window._window_viewport_height)
				
				new_window._canvas.PopMatrix()
				new_window._canvas.PushMatrix()

			Endif
			


			
			'-------------------------------
			'Itirate Through Window Drawlist
			'-------------------------------
			LockViewport2(new_window)
			new_window._canvas.PopMatrix()
			
			'new_window._canvas.AmbientLight=New Color(.63,.63,.63)


draw_image_cnt=0
			For Local dlist:PDrawList=Eachin new_window.Window_Draw_List
'draw_image_cnt=draw_image_cnt+1
				If dlist._ambient_light<>Null
					new_window._canvas.AmbientLight=New Color(dlist._ambient_light._red,dlist._ambient_light._green,dlist._ambient_light._blue)
				Endif


				If dlist._window_lighting<>Null
					If dlist._window_lighting.begin_lighting=True
						new_window._canvas.BeginLighting()
					Endif
					If dlist._window_lighting.end_lighting=True
						new_window._canvas.EndLighting()
					Endif
				Endif




				'------------------
				'Rotate Canvas
				'------------------				
'				If dlist._canvas_rotation=True
					'new_window._canvas.Rotate( new_window._canvas_rotation )
'				Endif

				'------------------
				'Translate Canvas
				'------------------
'				If dlist._canvas_translate=True
				'	new_window._canvas.Translate( new_window._canvas_translation_x, new_window._canvas_translation_y )
'				Endif

				'------------------
				'Render Camera
				'------------------
				If dlist._camera<>Null
					
					dlist._camera._camera.Viewport= new_window._canvas.Viewport
					'dlist._camera._scene.ShadowAlpha=1.0
					dlist._camera._camera.Render(new_window._canvas)', dlist._camera._camera )
				Endif
				

				'------------------
				'Draw Window Images
				'------------------
				If dlist._image<>Null
				
				new_window._canvas.PushMatrix()
				new_window._canvas.Translate(new_window._canvas_translation_x, new_window._canvas_translation_y)
				new_window._canvas.Scale(new_window._canvas_scale_w, new_window._canvas_scale_h)
				new_window._canvas.Rotate(new_window._canvas_rotation)
				
				
					Local PWindow_image:PWindowImage=dlist._image
					'If PWindow_image._light_bumpmap_image_flag=False
					new_window._canvas.PushMatrix()
					new_window._canvas.Alpha=(PWindow_image._window_image_alpha)
									
					SetBlendMode(new_window._canvas,PWindow_image._window_image_blend)
					new_window._canvas.Translate(0,0)
					
					new_window._canvas.Translate((PWindow_image._window_image_x),(PWindow_image._window_image_y))'960,540)'new_window._window_x+new_window._window_viewport_x+
					new_window._canvas.Scale(PWindow_image._window_image_scalex,PWindow_image._window_image_scaley)
					new_window._canvas.Rotate((PWindow_image._window_image_rotation) * degree_scalar)
					new_window._canvas.Translate(-(PWindow_image._window_image_x),-(PWindow_image._window_image_y))'960,540)
					new_window._canvas.Color=New Color(PWindow_image._window_image_red, PWindow_image._window_image_green, PWindow_image._window_image_blue)


					If PWindow_image._window_image_anim_flag=False
						If PWindow_image._window_image<>Null Then new_window._canvas.DrawImage(PWindow_image._window_image,(PWindow_image._window_image_x),(PWindow_image._window_image_y))'0,0)						
					Else
						If PWindow_image._window_image_anim[PWindow_image._window_image_frame]<>Null Then new_window._canvas.DrawImage(PWindow_image._window_image_anim[PWindow_image._window_image_frame],(PWindow_image._window_image_x),(PWindow_image._window_image_y))'0,0)
					Endif
				
					new_window._canvas.PopMatrix()
					new_window._canvas.PopMatrix()
					
				Endif

				'----------------
				'Draw 2D Light
				'---------------
				If dlist._light<>Null
					If dlist._light._image<>Null
					new_window._canvas.PushMatrix()
'					new_window._canvas.Alpha=(PWindow_image._window_image_alpha)
									
					'SetBlendMode(new_window._canvas,PWindow_image._window_image_blend)
'					new_window._canvas.Translate(0,0)
					
'					new_window._canvas.Translate((PWindow_image._window_image_x),(PWindow_image._window_image_y))'960,540)'new_window._window_x+new_window._window_viewport_x+
'					new_window._canvas.Scale(dlist._light._scalex,dlist._light._scaley)
'					new_window._canvas.Rotate((PWindow_image._window_image_rotation) * degree_scalar)
'					new_window._canvas.Translate(-(PWindow_image._window_image_x),-(PWindow_image._window_image_y))'960,540)
					new_window._canvas.Color=New Color(dlist._light._red, dlist._light._green, dlist._light._blue)


						dlist._light._image.Scale=New Vec2f( dlist._light._scalex, dlist._light._scaley)
						dlist._light._image.Color=New Color(dlist._light._red, dlist._light._green, dlist._light._blue )
						new_window._canvas.AddLight( dlist._light._image,  dlist._light._x, dlist._light._y, dlist._light._rotation * new_window._degree_scalar)
						new_window._canvas.PopMatrix()
					'	new_window._canvas.PushMatrix()
					
					draw_image_cnt=draw_image_cnt+1
					Endif
				Endif
				
				'----------------
				'Draw Window Text
				'----------------
				If dlist._text<>Null
					new_window._canvas.Font=new_window._gui_font
					Local text_Obj:PWindowText=dlist._text
					new_window._canvas.PushMatrix()
					SetBlendMode(new_window._canvas,text_Obj._text_blend)

					new_window._canvas.Translate(0,0)
'					new_window._canvas.Alpha=(1)

					new_window._canvas.Alpha=(text_Obj._text_alpha)
					new_window._canvas.Scale(text_Obj._text_scalex,text_Obj._text_scaley)
					new_window._canvas.Color=New Color(text_Obj._text_red, text_Obj._text_green, text_Obj._text_blue)
					new_window._canvas.DrawText(text_Obj._text,text_Obj._text_x,text_Obj._text_y)
					new_window._canvas.PopMatrix()
				Endif

				If dlist._text_area<>Null
					
				Endif

				If dlist._text_array<>Null
					new_window._canvas.Font=new_window._gui_font
					'new_window._canvas.Color=New Color(.3,1,.3)
					new_window._canvas.PushMatrix()
					new_window._canvas.Translate(0,0)
					new_window._canvas.Scale(1,1)
				'	new_window._canvas.PushMatrix()
					new_window.DrawTextArray()
					
					new_window._canvas.PopMatrix()
				'	new_window._canvas.PopMatrix()
				Endif


				'----------------
				'Draw Line
				'----------------
				If dlist._line<>Null
					Local pline:PWindowLine=dlist._line
					new_window._canvas.Translate(0,0)
					new_window._canvas.Alpha=(1)
					new_window._canvas.Scale(1,1)
					new_window._canvas.Color=New Color(pline._window_line_red ,pline._window_line_green,pline._window_line_blue)		
					SetBlendMode(new_window._canvas,new_window._canvas.BlendMode=BlendMode.Alpha)

					new_window._canvas.DrawLine(pline._window_line_x,pline._window_line_y,pline._window_line_x1,pline._window_line_y1)
				Endif

				'----------------
				'Draw Rectangle
				'----------------
				If dlist._rect<>Null
					Local prect:PWindowRect=dlist._rect
					new_window._canvas.Translate(0,0)
					new_window._canvas.Alpha=(1)
					new_window._canvas.Color=New Color(dlist._rect._window_rect_red,dlist._rect._window_rect_green,dlist._rect._window_rect_blue)
					
					SetBlendMode(new_window._canvas,new_window._canvas.BlendMode=BlendMode.Alpha)

					new_window._canvas.DrawRect(prect._window_rect_x,prect._window_rect_y,prect._window_rect_w,prect._window_rect_h)
				Endif
				
'				dlist._image. 

			Next
			
			
			'--------------- End Draw List --------------------
			
			
			

			new_window._canvas.PushMatrix()

			new_window.Window_Draw_List.Clear()
		'	new_window.Window_Draw_List=New Stack<PDrawList>
		'	new_window.Window_Light_List.Clear()
		'	new_window.Window_Light_List=New List<PWindowLight>

			UnlockViewportWindow(new_window)
			
		'	new_window.DrawTextArray()
		Endif

		LockViewport(new_window)


		'---------------------------------------------------
		'Update Listbox, Slider - Window Slider/Listbox List
		'---------------------------------------------------
		Local p_button5:PButton=New PButton
		Local move_flag:Int=False,move_listbox_flag:Int=False,move_slider_flag:Int=False,old_tmp_flag:Int=False
		For Local lslider:PSlider=Eachin new_window.Window_Slider_List
			move_slider_flag=lslider.Update(msx,msy,new_window, (new_window._window_x+new_window._window_viewport_x),(new_window._window_y+new_window._window_viewport_y) , new_window._window_selected )
		Next
		For Local lbox:PListBox=Eachin new_window.Window_ListBox_List
			lbox.Update(msx,msy,new_window,0,0,new_window._window_selected )
		Next
		'-----------------------------------
		'Update buttons - Window Button List
		'-----------------------------------
		Local mouse_d:Int
		For Local p_button:PButton=Eachin new_window.Window_Button_List
			If p_button.visible=True 
				If new_window._mouse_click_time<time
					mouse_d=Mouse.ButtonDown(MouseButton.Left)
				Else
					mouse_d=0
				Endif
				move_flag=p_button.Update(msx,msy,mouse_d, new_window,(new_window._window_x+new_window._window_viewport_x) , (new_window._window_y+new_window._window_viewport_y),new_window._window_selected )
				If old_tmp_flag=False And move_flag=True And new_window._window_selected=True Then old_tmp_flag=True
			Endif
			If move_flag=True Or move_slider_flag=True
				g_move_window_overide=True
			Else
				If Mouse.ButtonDown(MouseButton.Left)=False Then g_move_window_overide=False
			Endif
		Next


		'------------
		'Menu Bar
		'------------
		If new_window._window_menu_bar<>Null
			new_window._window_menu_bar.Update()
		Endif


		'new_window.PWindow_Text_List_Immediate.Clear()
		UnlockViewportWindow(new_window)
		new_window._canvas.PopMatrix()
		new_window._canvas.PushMatrix()
		new_window._canvas.Alpha=(1)
		SetBlendMode(new_window._canvas,BlendMode.Alpha)
		new_window._canvas.Color=New Color(1,1,1)
		new_window._canvas.Scale(1,1)
		'GCCollect()
		new_window._canvas.PopMatrix()
	End Method


	Global cur_pos:Int=0
	
	Method UpdateWindow:Void()
		Local window_resize_mouseover_flag:Int=False,window_resize_flag:Int=False
		Local click_delay:Int=300
		
		If Self._canvas=Null Then Print "Alien Phoenix: ERROR * NULL GLOBAL CANVAS - UpdateWindow() *"
		
		Local msx:Float=Mouse.X
		Local msy:Float=Mouse.Y
		Local mouse_x2:Int=msx
		Local mouse_y2:Int=msy

		For Local new_window:PWindow=Eachin PWindow_List
			If new_window._window_visible=True 
				Local mouse_x:Int=mouse_x2
				Local mouse_y:Int=mouse_y2
				Local reize_window_x:Int=(new_window._window_x+new_window._window_width)
				Local reize_window_y:Int=(new_window._window_y+new_window._window_height)
				'-------------------------
				'Resize Window check coord
				'Corners
				'-------------------------
				Local resize_slected_flag:Int
				If (mouse_x > reize_window_x And mouse_x < reize_window_x+new_window._window_resize_width*.5 ) And (mouse_y<new_window._window_y+(new_window._window_resize_height*.5) And mouse_y>new_window._window_y-(new_window._window_resize_height*.5)) Or (mouse_x > reize_window_x-new_window._window_resize_width And mouse_x < reize_window_x+(new_window._window_resize_width) ) And (mouse_y<new_window._window_y And mouse_y>new_window._window_y-(new_window._window_resize_height*.5))
					If 	new_window._window_resize_on=True And resize_slected_flag=False And new_window._window_resize_flag=False  And new_window._window_move=False And new_window._window_selected=True'z=1
						Self._window_resize_mouseover_flag=True
						window_resize_mouseover_flag=True
					 	cur_pos=2
						resize_slected_flag=True
					Endif	
				Endif
				If (mouse_x > new_window._window_x-(new_window._window_resize_width*.5)  And mouse_x < new_window._window_x) And (mouse_y>reize_window_y-(new_window._window_resize_height) And mouse_y<reize_window_y+(new_window._window_resize_height*.5))  Or  (mouse_x > new_window._window_x-(new_window._window_resize_width*.5)  And mouse_x < new_window._window_x+new_window._window_resize_width) And (mouse_y>reize_window_y And mouse_y<reize_window_y+(new_window._window_resize_height*.5))
					If 	new_window._window_resize_on=True And resize_slected_flag=False And new_window._window_resize_flag=False  And new_window._window_move=False And new_window._window_selected=True'z=1
						Self._window_resize_mouseover_flag=True
						window_resize_mouseover_flag=True
					 	cur_pos=3
						resize_slected_flag=True
					Endif	
				Endif
				If (mouse_x > new_window._window_x-(new_window._window_resize_width*.5)  And mouse_x < new_window._window_x) And (mouse_y>new_window._window_y And mouse_y<new_window._window_y+(new_window._window_resize_height*.5))  Or  (mouse_x > new_window._window_x-(new_window._window_resize_width*.5)  And mouse_x < new_window._window_x+new_window._window_resize_width) And (mouse_y>new_window._window_y-(new_window._window_resize_height*.5) And mouse_y<new_window._window_y)
					If 	new_window._window_resize_on=True And resize_slected_flag=False And new_window._window_resize_flag=False  And new_window._window_move=False And new_window._window_selected=True'z=1
						Self._window_resize_mouseover_flag=True
						window_resize_mouseover_flag=True
					 	cur_pos=4
						resize_slected_flag=True
					Endif	
				Endif
				If (mouse_x > reize_window_x  And mouse_x < reize_window_x+(new_window._window_resize_width*.5)) And (mouse_y>reize_window_y-(new_window._window_resize_height) And mouse_y<reize_window_y+(new_window._window_resize_height))  Or  (mouse_x > reize_window_x-new_window._window_resize_width  And mouse_x < reize_window_x+new_window._window_resize_width And (mouse_y>reize_window_y And mouse_y<reize_window_y+(new_window._window_resize_height*.5)))
					If 	new_window._window_resize_on=True And resize_slected_flag=False And new_window._window_resize_flag=False  And new_window._window_move=False And new_window._window_selected=True'z=1
						Self._window_resize_mouseover_flag=True
						window_resize_mouseover_flag=True
					 	cur_pos=1
						resize_slected_flag=True
					Endif	
				Endif
				'--------------------
				'Resize window sides.
				'--------------------
				If ( mouse_x > new_window._window_x-(new_window._window_resize_width*.5) And mouse_x < new_window._window_x) And (mouse_y>new_window._window_y+(new_window._window_resize_height*.5) And mouse_y< (new_window._window_y+new_window._window_height) - (new_window._window_resize_height))  'Or  (mouse_x > reize_window_x-new_window._window_resize_width  And mouse_x < reize_window_x+new_window._window_resize_width And (mouse_y>reize_window_y And mouse_y<reize_window_y+(new_window._window_resize_height*.5)))
					If 	new_window._window_resize_on=True And resize_slected_flag=False And new_window._window_resize_flag=False  And new_window._window_move=False And new_window._window_selected=True'z=1
						Self._window_resize_mouseover_flag=True
						window_resize_mouseover_flag=True
					 	cur_pos=5
						resize_slected_flag=True
					Endif	
				Endif
				If ( mouse_x < reize_window_x+(new_window._window_resize_width*.5) And mouse_x > reize_window_x) And (mouse_y>new_window._window_y+(new_window._window_resize_height*.5) And mouse_y< (new_window._window_y+new_window._window_height) - (new_window._window_resize_height))  'Or  (mouse_x > reize_window_x-new_window._window_resize_width  And mouse_x < reize_window_x+new_window._window_resize_width And (mouse_y>reize_window_y And mouse_y<reize_window_y+(new_window._window_resize_height*.5)))
					If 	new_window._window_resize_on=True And resize_slected_flag=False And new_window._window_resize_flag=False  And new_window._window_move=False And new_window._window_selected=True'z=1
						Self._window_resize_mouseover_flag=True
						window_resize_mouseover_flag=True
					 	cur_pos=6
						resize_slected_flag=True
					Endif	
				Endif
				If ( mouse_x > new_window._window_x+(new_window._window_resize_width) And mouse_x < reize_window_x-(new_window._window_resize_width)) And (mouse_y>new_window._window_y-(new_window._window_resize_height*.5) And mouse_y< new_window._window_y )  'Or  (mouse_x > reize_window_x-new_window._window_resize_width  And mouse_x < reize_window_x+new_window._window_resize_width And (mouse_y>reize_window_y And mouse_y<reize_window_y+(new_window._window_resize_height*.5)))
					If 	new_window._window_resize_on=True And resize_slected_flag=False And new_window._window_resize_flag=False  And new_window._window_move=False And new_window._window_selected=True'z=1
						Self._window_resize_mouseover_flag=True
						window_resize_mouseover_flag=True
					 	cur_pos=7
						resize_slected_flag=True
					Endif	
				Endif
				If ( mouse_x > new_window._window_x+(new_window._window_resize_width) And mouse_x < reize_window_x-(new_window._window_resize_width)) And (mouse_y>reize_window_y And mouse_y< reize_window_y + (new_window._window_resize_height))  'Or  (mouse_x > reize_window_x-new_window._window_resize_width  And mouse_x < reize_window_x+new_window._window_resize_width And (mouse_y>reize_window_y And mouse_y<reize_window_y+(new_window._window_resize_height*.5)))
					If 	new_window._window_resize_on=True And resize_slected_flag=False And new_window._window_resize_flag=False  And new_window._window_move=False And new_window._window_selected=True'z=1
						Self._window_resize_mouseover_flag=True
						window_resize_mouseover_flag=True
					 	cur_pos=8
						resize_slected_flag=True
					Endif	
				Endif

				'-------------------------
				'Reset cursor interaction.
				'-------------------------
				If resize_slected_flag=False
					If Mouse.ButtonDown(MouseButton.Left)=False Self._window_resize_mouseover_flag=False
				Endif
				
				'--------------------------------
				'Window z-order, resize and move.
				'--------------------------------
				If new_window._window_visible=True 
					'------------------------------
					'If mouse cursor within window.
					'------------------------------
					If ( (mouse_x>new_window._window_x And mouse_x<(new_window._window_x+new_window._window_width)) And ( mouse_y>new_window._window_y And mouse_y<(new_window._window_y+new_window._window_height)) )  Or (new_window._window_move=True And new_window._window_selected=True) Or (resize_slected_flag=True And new_window._window_selected=True)
						If Mouse.ButtonDown(MouseButton.Left)=True 
							'-------------------
							'Sort Window Z-Order
							'-------------------
							If _mouse_down=False 
								'-------------------
								'Normal Z-Order Sort
								'-------------------
								new_window._window_move=True
								old_m_x= mouse_x
								old_m_y= mouse_y
								Local win_count:Int
								If new_window._window_cast_screen_flag=False
									Local current_window_z:Int=0'1
									Local new_window2:PWindow=New PWindow 

									If new_window._window_top_most=True 
										PWindow_List_Swap.AddLast(new_window)
										new_window._window_z=current_window_z+1
										current_window_z=current_window_z+1
									Endif

									For new_window2=Eachin PWindow_List
										If new_window2<>new_window  And new_window2._window_top_most=True
											current_window_z=current_window_z+1
											new_window2._window_z=current_window_z
											new_window2.ShowBorder(False)
											PWindow_List_Swap.AddLast(new_window2)
										Endif
										new_window2._window_selected=False
									Next

									If new_window._window_top_most=False 
										PWindow_List_Swap.AddLast(new_window)
										new_window._window_z=current_window_z+1
										current_window_z=current_window_z+1
									Endif
			
									For new_window2=Eachin PWindow_List
										If new_window2<>new_window  And new_window2._window_top_most=False
											current_window_z=current_window_z+1
											new_window2._window_z=current_window_z
											new_window2.ShowBorder(False)
											PWindow_List_Swap.AddLast(new_window2)
										Endif
										new_window2._window_selected=False
									Next

									PWindow_List=New List<PWindow>
									For Local temp1_obj:PWindow=Eachin PWindow_List_Swap
										PWindow_List.AddLast(temp1_obj)
									Next 
									PWindow_List_Swap=New List<PWindow>
								Else
									'---------------------------
									'Screen cast and bottom-most
									' Z-Order sort.
									'---------------------------
									For Local new_window3:PWindow=Eachin PWindow_List
										win_count=win_count+1
									Next
									new_window._window_z=win_count 
									Local current_window_z:Int=win_count
									Local new_window2:PWindow=New PWindow
									
									For new_window2=Eachin PWindow_List
										If new_window2<>new_window 
											current_window_z=current_window_z-1
											new_window2._window_z=current_window_z
											new_window2.ShowBorder(False)
											PWindow_List_Swap.AddLast(new_window2)
										Endif
										new_window2._window_selected=False
									Next
									PWindow_List_Swap.AddLast(new_window)
									'PWindow_List.Clear()
									PWindow_List=New List<PWindow>
									For Local temp1_obj:PWindow=Eachin PWindow_List_Swap
										PWindow_List.AddLast(temp1_obj)
									Next 
									'PWindow_List_Swap.Clear()
									PWindow_List_Swap=New List<PWindow>
								Endif
								
								
								new_window.ShowBorder(True)	
								new_window._window_selected=True
								g_window_selected_report=True
							Endif
				
							_mouse_down=True 
							If (new_window._window_selected=True) 
								If Self._window_resize_mouseover_flag=True 
									If Mouse.ButtonDown(MouseButton.Left)=True 
										new_window._window_resize_flag=True
									Endif
								Endif
								'--------------------
								'Resize / Move Window
								'--------------------
								If new_window._window_resize_flag=True
									If new_window._window_resize_on=True 
										ResizeWindow(new_window,cur_pos,msx,msy)
									Else
										window_resize_mouseover_flag=False
									Endif
								Else
									MoveWindow(new_window,msx,msy)	
								Endif
							Endif
						Endif
				
						If Mouse.ButtonDown(MouseButton.Left)=False And _mouse_down=True 
							Self._mouse_down=False
							new_window._window_move=False
							new_window._window_resize_flag=False
							new_window._window_resize_mouseover_flag=False
							new_window._window_old_x=new_window._window_x
							new_window._window_old_y=new_window._window_y
							cur_pos=0
						Endif
					Else
						If Mouse.ButtonDown(MouseButton.Left)=True 
							new_window._mouse_click_time=Millisecs()+click_delay
							new_window.ShowBorder(False)
							new_window._window_selected=False 
							g_window_selected_report=False
						Endif
					Endif
				Endif
			Endif







		'Update window controls (screen cast, maximize, close)
'		------------------------------------------------------
	'	If new_window.WindowActive()=True
		Local bx:Int,by:Int
		bx=new_window.GetWindowWidth()

		For Local win_cntrl_button_object:PButton=Eachin new_window.Window_Control_Button_List
			bx=bx-36
			If win_cntrl_button_object.ButtonDown()=True
				If win_cntrl_button_object=new_window._window_cast_control
					If new_window._window_cast_screen_flag=False
						new_window.SetScreenCast(True)
						win_cntrl_button_object.SetImage(g_screen_cast_window_image_down,g_screen_cast_window_image_up,g_screen_cast_window_image_down,g_screen_cast_window_image_down)
						win_cntrl_button_object.SetSelected(True)
						new_window._window_maximize_control.SetSelected(False)
						new_window._window_maximize_control.SetImage(g_maximize_window_image_up,g_maximize_window_image_down,g_maximize_window_image_up,g_maximize_window_image_down)
					Else
						new_window.SetScreenCast(False)
						win_cntrl_button_object.SetSelected(False)
						win_cntrl_button_object.SetImage(g_screen_cast_window_image_up,g_screen_cast_window_image_down,g_screen_cast_window_image_up,g_screen_cast_window_image_down)
						'Self._window_maximize_control.SetSelected(False)
						'Self._window_maximize_control.SetImage(g_maximize_window_image_up,g_maximize_window_image_down,g_maximize_window_image_up,g_maximize_window_image_down)
					Endif
				Endif		

				If win_cntrl_button_object=new_window._window_maximize_control
					If new_window._window_maximize_flag=False
						new_window.MaximizeWindow(True)
						win_cntrl_button_object.SetImage(g_maximize_window_image_down,g_maximize_window_image_up,g_maximize_window_image_down,g_maximize_window_image_down)
						win_cntrl_button_object.SetSelected(True)
						new_window._window_cast_control.SetSelected(False)
						new_window._window_cast_control.SetImage(g_screen_cast_window_image_up,g_screen_cast_window_image_down,g_screen_cast_window_image_up,g_screen_cast_window_image_down)
					Else
						new_window.MaximizeWindow(False)
						new_window._window_maximize_control.SetSelected(False)
						win_cntrl_button_object.SetImage(g_maximize_window_image_up,g_maximize_window_image_down,g_maximize_window_image_up,g_maximize_window_image_down)
						'Self._window_cast_control.SetSelected(False)
						'Self._window_cast_control.SetImage(g_screen_cast_window_image_up,g_screen_cast_window_image_down,g_screen_cast_window_image_up,g_screen_cast_window_image_down)
					Endif
				Endif		
			
				If win_cntrl_button_object=new_window._window_close_control
					If new_window.GetWindowMaximize()=True
						new_window.MaximizeWindow(False)
						'win_cntrl_button_object.SetSelected(False)
						new_window._window_maximize_control.SetSelected(False)
						new_window._window_maximize_control.SetImage(g_maximize_window_image_up,g_maximize_window_image_down,g_maximize_window_image_up,g_maximize_window_image_down)
						new_window.HideWindow()
					Else
						If new_window.GetScreenCast()=True
							new_window.SetScreenCast(False)
							new_window._window_cast_control.SetSelected(False)
							new_window._window_cast_control.SetImage(g_screen_cast_window_image_up,g_screen_cast_window_image_down,g_screen_cast_window_image_up,g_screen_cast_window_image_down)
							new_window.HideWindow()
						Else
							new_window.HideWindow()
						Endif
					Endif
				Endif
			
			Endif
			
			win_cntrl_button_object.SetPosition(bx,5)
		Next
		'Endif
'		-----------------------------------------------------












		Next
		
		
		
		
		
		'-----------------------------------------
		'Draw window, button and other components.
		'Draw window Draw List.
		'-----------------------------------------
		Self.DrawWindow(msx,msy)
		'-----------------------------------------
		Self._canvas.BlendMode=BlendMode.Alpha'SetBlendMode(BlendMode.Alpha)
		Self._canvas.Scale(1,1)
		Self._canvas.Color=New Color(1,1,1)'SetColor(1,1,1)
		'------------------
		'Draw Window Cursor
		'------------------
		If (mouse_x2<>g_old_mouse_x2 Or mouse_y2<>g_old_mouse_y2)
			g_mouse_move_time=Millisecs()+4000
			g_old_mouse_x2=mouse_x2
			g_old_mouse_y2=mouse_y2
		Endif

		If ( window_resize_mouseover_flag=False) And g_mouse_move_time>Millisecs()
			Self._canvas.DrawImage(g_cursor,msx+g_cursor_offx,msy+g_cursor_offy)
		Else
			Select cur_pos
				Case 1
					Self._canvas.DrawImage(g_cursor_scale_se,msx,msy)'+g_cursor_scale_offx,msy+g_cursor_scale_offy)
				Case 2
					Self._canvas.DrawImage(g_cursor_scale_ne,msx,msy)'+g_cursor_scale_offx,msy)
				Case 3
					Self._canvas.DrawImage(g_cursor_scale_sw,msx,msy)
				Case 4
					Self._canvas.DrawImage(g_cursor_scale_nw,msx,msy)
				Case 5
					Self._canvas.DrawImage(g_cursor_scale_horz,msx,msy)
				Case 6
					Self._canvas.DrawImage(g_cursor_scale_horz,msx,msy)
				Case 7
					Self._canvas.DrawImage(g_cursor_scale_vert,msx,msy)
				Case 8
					Self._canvas.DrawImage(g_cursor_scale_vert,msx,msy)
			End Select
		Endif
	'	If Self._window_resize_flag=False And Mouse.ButtonDown(MouseButton.Left)=False Then cur_pos=0
	End Method


	Method ResetMaximizeWindow:Void()
		For Local tmpwin:PWindow=Eachin PWindow_List
			If tmpwin._window_maximize_flag=True And tmpwin<>Self
				If tmpwin.GetScreenCast()=False Then tmpwin.MaximizeWindow(False)
			Endif
		Next
	End Method
	
	
	Method MaximizeWindow:Void(flag:Int)
		Self.ResetMaximizeWindow()
		If flag=True
			If Self._window_cast_screen_flag=True
				Self.SetScreenCast(False)
				Self.ResetScreenCastWindow()
			For Local new_window3:PWindow=Eachin PWindow_List
				If new_window3<>Self
					If new_window3._window_cast_control<>Null
						new_window3._window_cast_control.SetSelected(False)
						new_window3._window_cast_control.SetImage(g_screen_cast_window_image_up,g_screen_cast_window_image_down,g_screen_cast_window_image_up,g_screen_cast_window_image_down)
					Endif						
				Endif
			Next

			Endif
			'Else
			'	ResetScreenCastWindow()
			'Endif
			
			Self.SetWindowOnTop()
			Self._window_old_resize_flag=Self._window_resize_on
			Self._window_old_move_flag=Self._window_movable
			Self.SetResizable(False)
			Self.SetMovable(False)
			Self._window_old_maximize_x=Self.GetWindowX()
			Self._window_old_maximize_y=Self.GetWindowY()
			Self.SetWindowPos(0,0)
			Self._window_maximize_flag=True
			'Self._window_cast_screen_flag=False
			Self._window_old_maximize_width=Self.GetWindowWidth()
			Self._window_old_maximize_height=Self.GetWindowHeight()
			Self.SetWindowSize(global_screen_width,global_screen_height)
			g_window_maxamized=True
			g_window_screen_cast=False
		'	Endif
		Else
			Self.SetWindowOnTop()
			Self.SetResizable(Self._window_old_resize_flag)
			Self.SetMovable(Self._window_old_move_flag)
			Self.SetWindowPos(Self._window_old_maximize_x,Self._window_old_maximize_y)
			Self._window_maximize_flag=False
			'Self._window_cast_screen_flag=False
			Self.SetWindowSize(Self._window_old_maximize_width,Self._window_old_maximize_height)
			Self._window_selected=True
			g_window_selected_report=True
			g_window_maxamized=False
		Endif

'			For Local new_window3:PWindow=Eachin PWindow_List
'				If new_window3<>Self
'					If new_window3._window_cast_control<>Null
'						new_window3._window_cast_control.SetSelected(False)
'						new_window3._window_cast_control.SetImage(g_screen_cast_window_image_up,g_screen_cast_window_image_down,g_screen_cast_window_image_up,g_screen_cast_window_image_down)
'					Endif						
'				Endif
'			Next

	End Method


	Method ResetScreenCastWindow:Void()
		For Local tmpwin:PWindow=Eachin PWindow_List
			If tmpwin._window_cast_screen_flag=True And tmpwin<>Self
				tmpwin.SetScreenCast(False)
			Endif
		Next
	End Method
	
	
	Method SetScreenCast:Void(flag:Int)
		Self.ResetScreenCastWindow()

		If flag=True
			If Self._window_maximize_flag=True
				Self.MaximizeWindow(False)
			Endif 
			Self._window_cast_screen_flag=flag
			Local win_count:Int
			For Local new_window3:PWindow=Eachin PWindow_List
				win_count=win_count+1
				If new_window3<>Self
					If new_window3._window_cast_control<>Null
						new_window3._window_cast_control.SetSelected(False)
						new_window3._window_cast_control.SetImage(g_screen_cast_window_image_up,g_screen_cast_window_image_down,g_screen_cast_window_image_up,g_screen_cast_window_image_down)
					Endif
				Endif
			Next
				Self._window_z=win_count 
				Local current_window_z:Int=win_count
				'PWindow_List_Swap.AddLast(Self)
				Local new_window2:PWindow=New PWindow
			For new_window2=Eachin PWindow_List
				If new_window2<>Self 
					current_window_z=current_window_z-1
					new_window2._window_z=current_window_z
					new_window2.ShowBorder(False)
					PWindow_List_Swap.AddLast(new_window2)
				Endif
				new_window2._window_selected=False
			Next
			PWindow_List_Swap.AddLast(Self)
			PWindow_List.Clear()
			For Local temp1_obj:PWindow=Eachin PWindow_List_Swap
				PWindow_List.AddLast(temp1_obj)
			Next 
			PWindow_List_Swap.Clear()
			Self.ShowBorder(True)	
			Self._window_selected=True
			g_window_selected_report=True
			g_window_screen_cast=True
			'g_window_maxamized=True
			'Print Millisecs()

			Self._window_old_resize_flag=Self._window_resize_on
			Self._window_old_move_flag=Self._window_movable
			Self.SetResizable(False)
			Self.SetMovable(False)

			Self._window_old_maximize_x=Self.GetWindowX()
			Self._window_old_maximize_y=Self.GetWindowY()
			Self.SetWindowPos(0,0)
			'Self._window_maxamize_flag=False
			Self._window_old_maximize_width=Self.GetWindowWidth()
			Self._window_old_maximize_height=Self.GetWindowHeight()
			Self.SetWindowSize(global_screen_width,global_screen_height)
		Else
			Self._window_cast_screen_flag=flag

			For Local new_window3:PWindow=Eachin PWindow_List
			'	If new_window3<>Self
					If new_window3._window_cast_control<>Null
						new_window3._window_cast_control.SetSelected(False)
						new_window3._window_cast_control.SetImage(g_screen_cast_window_image_up,g_screen_cast_window_image_down,g_screen_cast_window_image_up,g_screen_cast_window_image_down)
					Endif						
			'	Endif
			Next

#rem
			Local win_count:Int
				Self._window_z=1 
				Local current_window_z:Int=1
				PWindow_List_Swap.AddLast(Self)
				Local new_window2:PWindow=New PWindow
			For new_window2=Eachin PWindow_List
				If new_window2<>Self 
					current_window_z=current_window_z-1
					new_window2._window_z=current_window_z
					new_window2.ShowBorder(False)
					PWindow_List_Swap.AddLast(new_window2)
				Endif
				new_window2._window_selected=False
			Next
			PWindow_List.Clear()
			For Local temp1_obj:PWindow=Eachin PWindow_List_Swap
				PWindow_List.AddLast(temp1_obj)
			Next 
			PWindow_List_Swap.Clear()
#end
			
			Self.SetWindowOnTop()
			Self.ShowBorder(True)	
			Self._window_selected=True
			g_window_selected_report=True
			g_window_screen_cast=False
			'g_window_maxamized=False		
			Self.SetResizable(Self._window_old_resize_flag)
			Self.SetMovable(Self._window_old_move_flag)
			Self.SetWindowPos(Self._window_old_maximize_x,Self._window_old_maximize_y)
			'Self._window_maxamize_flag=False
			Self.SetWindowSize(Self._window_old_maximize_width,Self._window_old_maximize_height)
		Endif

	End Method
	
#Rem	
	Method ClearWindowText:Void()
		Self.PWindow_Text_List.Clear()
	End Method


	Method ClearWindowImage:Void()
	'	Self.PWindow_Image_List.Clear()
'		Self._dlist._master_index=0
'		Self._dlist._image_index=0
	End Method


	Method ClearWindowLine:Void()
		'Self.PWindow_Line_List.Clear()
	End Method
#End Rem

	Method GetScreenSize:Float[]()
		Return New Float[](global_screen_width,global_screen_height)
	End Method


	Method GetDrawImageCnt:Int()
		Return Self.draw_image_cnt
	End Method


	Method GetWindowMaximize:Int()
		Return Self._window_maximize_flag
	End Method
	

	Method GetScreenCast:Int()
		Return Self._window_cast_screen_flag
	End Method


	Method GetWindowHeight:Float()
		Return Self._window_height
	End Method


	Method GetWindowWidth:Float()
		Return Self._window_width
	End Method


	Method GetWindowX:Float()
		Return Self._window_x
	End Method
	

	Method GetWindowY:Float()
		Return Self._window_y
	End Method


	Method GetCastStatus:Int()
		Return Self._window_cast_screen_flag
	End Method


	Method GetGlobalCastStatus:Int()
		Return g_window_screen_cast
	End Method


	Method GetMaximizeStatus:Int()
		Return Self._window_maximize_flag
	End Method


	Method GetGlobalMaximizeStatus:Int()
		Return g_window_maxamized
	End Method
	
	
	Method AnyWindowSelected:Int()
		Return g_window_selected_report
	End Method


	Method SetWindowTop:Void(flag:Int=True)
		Self._window_top_most=flag
	End Method 


	Method HideWindow:Void()
		Self._window_visible=False
		Self._window_close_hide_process_flag=True
	If Self.GetWindowMaximize()=True
		Self.ResetScreenCastWindow()
		Self.ResetMaximizeWindow()
	Endif
	End Method
	
	
	Method ShowWindow:Void()
		Self._window_visible=True
		Self._mouse_click_time=Millisecs()+1000
	End Method


	Method DrawText:PWindowText(PWindow_text:String,x:Int,y:Int,blend:Int=BlendMode.Alpha,alpha:Float=1,scalex:Float=1,scaley:Float=1,r:Float=1.0,g:Float=1.0,b:Float=1.0)
		Local text_obj:PWindowText
		text_obj=New PWindowText
		text_obj._text=PWindow_text
		text_obj._text_x=x
		text_obj._text_y=y
		text_obj._text_blend=blend
		text_obj._text_alpha=alpha
		text_obj._text_scalex=scalex
		text_obj._text_scaley=scaley
		text_obj._text_red=r
		text_obj._text_green=g
		text_obj._text_blue=b
		Local dlist:PDrawList=New PDrawList
		dlist._text=text_obj	'Add text object to draw list
		'Self.Window_Draw_List.AddLast(dlist)
		Self.Window_Draw_List.Push( dlist )
		Return text_obj
	End Method

	
	Method DrawTextA:Void()
		Local text_obj:PWindowTextArray
		text_obj=New PWindowTextArray
		Local dlist:PDrawList=New PDrawList
		dlist._text_array=text_obj	'Add text object to draw list
		Self.Window_Draw_List.Push( dlist )
	End Method


#Rem
	Method DrawText:Void(PWindow_text:String,x:Int,y:Int,blend:Int=BlendMode.Alpha,alpha:Float=1,scalex:Float=1,scaley:Float=1,r:Float=1.0,g:Float=1.0,b:Float=1.0)
		Local text_obj:Window_Text_Immediate
		text_obj=New Window_Text_Immediate
		text_obj._text=PWindow_text
		text_obj._text_x=x
		text_obj._text_y=y
		text_obj._text_blend=blend
		text_obj._text_alpha=alpha
		text_obj._text_scalex=scalex
		text_obj._text_scaley=scaley
		text_obj._text_red=r
		text_obj._text_green=g
		text_obj._text_blue=b
		Self.PWindow_Text_List_Immediate.AddLast(text_obj)
	End Method
#End Rem	

	
	Method AddLight:PWindowLight(image:Image,x:Float,y:Float,scalex:Float=1.0,scaley:Float=1.0,red:Float=1.0,green:Float=1.0,blue:Float=1.0,rot:Float=0)
	
		Local plight:PWindowLight=New PWindowLight
		plight._x=x
		plight._y=y
		plight._image=image
		plight._scalex=scalex
		plight._scaley=scaley
		plight._red=red
		plight._green=green
		plight._blue=blue
		plight._rotation=rot

'		Self.PWindow_Line_List.AddLast(pline)
		Local dlist:PDrawList=New PDrawList
		dlist._light=plight
		'Self.Window_Draw_List.AddLast(dlist)
		Self.Window_Draw_List.Push( dlist )
		'Self.Window_Light_List.AddLast(plight)'dlist)
		
		Return plight		
	End Method


	Method BeginLighting:Void()
		Local pwindow_lighting:=New PWindowLighting
		pwindow_lighting.begin_lighting=True
		Local dlist:PDrawList=New PDrawList
		dlist._window_lighting=pwindow_lighting	
		'Self.Window_Draw_List.AddLast(dlist)
		Self.Window_Draw_List.Push( dlist )			
	End Method

	Method EndLighting:Void()
		Local pwindow_lighting:=New PWindowLighting
		pwindow_lighting.end_lighting=True
		Local dlist:PDrawList=New PDrawList
		dlist._window_lighting=pwindow_lighting	
		'Self.Window_Draw_List.AddLast(dlist)
		Self.Window_Draw_List.Push( dlist )			
	End Method


	Method DrawImage:PWindowImage(image:Image,x:Float,y:Float,frame:Int=0,scalex:Float=1.0,scaley:Float=1.0,blend:Int=BlendMode.Alpha,alpha:Float=1.0,rot:Float=0,r:Float=1.0,g:Float=1.0,b:Float=1.0)
		Local PWindow_image:PWindowImage=New PWindowImage
		PWindow_image._window_image=image
		PWindow_image._window_image_x=x
		PWindow_image._window_image_y=y
		PWindow_image._window_image_alpha=alpha
		PWindow_image._window_image_blend=blend
		PWindow_image._window_image_red=r
		PWindow_image._window_image_green=g
		PWindow_image._window_image_blue=b
		PWindow_image._window_image_scalex=scalex
		PWindow_image._window_image_scaley=scaley
		PWindow_image._window_image_rotation=rot
		PWindow_image._window_image_frame=frame
		PWindow_image._window_image_anim_flag=False
		'Self.PWindow_Image_List.AddLast(PWindow_image)
		
		Local dlist:PDrawList=New PDrawList
		dlist._image=PWindow_image	'Add image object to draw list
		Self.Window_Draw_List.Push( dlist )

		'Local lng:Int=Self._draw_stack.Length
		'Print lng
		
'		Self._draw_list_index=+1
'		Self._draw_stack[Self._draw_list_index]=New PDrawList
'		Self._draw_stack[Self._draw_list_index]._image=PWindow_image	'Add image object to draw list
		

		'Self.Window_Draw_List.AddLast(dlist)	
'		Self._dlist._image_index=Self._dlist._image_index+1
'	'	Local tmp_index_order:Int[Self._dlist._image_index]=Self._dlist._index_order
'		Self._dlist._image[Self._dlist._image_index]=PWindow_image
'	'	
'		Self._dlist._master_index=Self._dlist._master_index+1
'		Self._dlist._index_order[Self._dlist._master_index]=1
'		
		Return PWindow_image
	End Method



	Method DrawLine:PWindowLine(x:Float,y:Float,x1:Float,y1:Float)
		Local pline:PWindowLine=New PWindowLine
		pline._window_line_x=x
		pline._window_line_y=y
		pline._window_line_x1=x1
		pline._window_line_y1=y1
		'Self.PWindow_Line_List.AddLast(pline)
		Local dlist:PDrawList=New PDrawList
		dlist._line=pline
		'Self.Window_Draw_List.AddLast(dlist)
		Self.Window_Draw_List.Push( dlist )
		
		Return pline		
	End Method


	Method DrawRect:PWindowRect(x:Float,y:Float,w:Float,h:Float,red:Float=1.0,green:Float=1.0,blue:Float=1.0)
		Local prect:PWindowRect=New PWindowRect
		prect._window_rect_x=x
		prect._window_rect_y=y
		prect._window_rect_w=w
		prect._window_rect_h=h
		prect._window_rect_red=red
		prect._window_rect_green=green
		prect._window_rect_blue=blue
		'Self.PWindow_Line_List.AddLast(pline)
		Local dlist:PDrawList=New PDrawList
		dlist._rect=prect
		'Self.Window_Draw_List.AddLast(dlist)
		Self.Window_Draw_List.Push( dlist )
		Return prect		
	End Method


	Method RenderWindowCamera:Void(scene:Scene,camera:Camera)
		Local dlist:PDrawList=New PDrawList
		Local cam_obj:= New PWindow3DCamera
		cam_obj._camera=camera
		cam_obj._scene=scene
		dlist._camera=cam_obj
		'Self.Window_Draw_List.AddLast(dlist)
		Self.Window_Draw_List.Push( dlist )
	End Method


	Method SetAmbientLight:Void(red:Float,green:Float,blue:Float)
		Local dlist:PDrawList=New PDrawList
		Local ambient_obj:=New PWindowAmbient
		ambient_obj._red=red
		ambient_obj._green=green
		ambient_obj._blue=blue
		dlist._ambient_light=ambient_obj
		Self.Window_Draw_List.Push( dlist )
	End Method 


	Method SetImageBlend:Void(image_obj:PWindowImage,blend:Int)
		image_obj._window_image_blend=blend
	End Method


	Method SetImageColor:Void(image_obj:PWindowImage,r:Float,g:Float,b:Float)
		image_obj._window_image_red=r
		image_obj._window_image_green=g
		image_obj._window_image_blue=b
	End Method


	Method SetImageScale:Void(image_obj:PWindowImage,scalex:Float,scaley:Float)
		image_obj._window_image_scalex=scalex
		image_obj._window_image_scaley=scaley
	End Method

	
	Method SetImageAlpha:Void(image_obj:PWindowImage,alpha:Float)
		image_obj._window_image_alpha=alpha
	End Method
	
	Method SetImageRotation:Void(image_obj:PWindowImage,rotation:Float)
		image_obj._window_image_rotation=rotation
	End Method


	Method SetLineColor:Void(line_obj:PWindowLine,r:Float,g:Float,b:Float)
		line_obj._window_line_red=r
		line_obj._window_line_green=g
		line_obj._window_line_blue=b
	End Method



	
	Method DrawAnimImage:PWindowImage(image:Image[],x:Float,y:Float,frame:Int=0,scalex:Float=1.0,scaley:Float=1.0,blend:Int=BlendMode.Alpha,alpha:Float=1.0,rot:Float=0,r:Float=1.0,g:Float=1.0,b:Float=1.0)
		Local PWindow_image:PWindowImage=New PWindowImage
		PWindow_image._window_image_anim=image
		PWindow_image._window_image_x=x
		PWindow_image._window_image_y=y
		PWindow_image._window_image_alpha=alpha
		PWindow_image._window_image_blend=blend
		PWindow_image._window_image_red=r
		PWindow_image._window_image_green=g
		PWindow_image._window_image_blue=b
		PWindow_image._window_image_scalex=scalex
		PWindow_image._window_image_scaley=scaley
		PWindow_image._window_image_rotation=rot
		PWindow_image._window_image_frame=frame
		PWindow_image._window_image_anim_flag=True
		PWindow_image._window_image_delta=32
		
	'	Self.PWindow_Image_List.AddLast(PWindow_image)
		Local dlist:PDrawList=New PDrawList
		dlist._image=PWindow_image	'Add image object to draw list
		'Self.Window_Draw_List.AddLast(dlist)
		Self.Window_Draw_List.Push( dlist )
		
		Return(PWindow_image)
	End Method

	
	Method SetTextArray:Void(arraya:String[],x:Int=0,y:Int=0,assending_print_order:Int=False)
		Self._window_text_array=arraya'[..]
		Self._window_text_x=x
		Self._window_text_y=y
		Self._window_text_order=assending_print_order
	End Method
	
	Method SetTextAPos(x:Float,y:Float)
		Self._window_text_x=x
		Self._window_text_y=y			
	End Method

	Method SetTextASize(w:Float,h:Float)
		Self._window_text_w=w
		Self._window_text_h=h			
	End Method
	
	
	Method DrawTextArray:Void(text_height:Int=20)
		'Local array_text:String[]=Self._window_text_array
		Local x:Int=Self._window_text_x
		Local y:Int=Self._window_text_y
	'	Self._canvas.Translate(0,0)
		'Local assending_print_order:Int=Self._window_text_order
		Local linespace:Int=4
		text_height=(Self._canvas.Font.Height+linespace)
	'	Self._canvas.Alpha=(Self._window_text_alpha) 
	'	SetBlendMode(Self._canvas,Self._window_text_blend)
	'	Self._canvas.Color=New Color(Self._window_text_red,Self._window_text_green,Self._window_text_blue)
	'	Self._canvas.Scale(1,1)
		Local ystep_1:Int= text_height ,ystep_2:Int
		If ystep_1=0 Then ystep_1=20
		Local tstep_1:Int=((Self._window_text_array.Length )-1) 
	'	Self._canvas.PopMatrix()
	'	Self._canvas.PushMatrix()
	'	Self._canvas.Alpha=(1)
	'	Self._canvas.Scale(1,1)
		Self._canvas.Color=New Color(Self._window_text_red,Self._window_text_green,Self._window_text_blue)
'		LockViewport(Self)
		Local window_height:Int=Self.GetWindowHeight()
		Local t_step_1:Int
		Local beginoffset:Int,endoffset:Int
		
		If Self._window_text_order=True
			For t_step_1=1+Self._textoffset To tstep_1
				ystep_2=ystep_2+ystep_1
				Self._canvas.DrawText(Self._window_text_array[t_step_1],x,y +Self._window_viewport_y+(window_height-ystep_2) )
				If ystep_2>((window_height)-(ystep_1)) Then Exit
			Next
		Else
			For t_step_1=1+Self._textoffset To tstep_1
				ystep_2=ystep_2+ystep_1
				Self._canvas.DrawText(Self._window_text_array[t_step_1],x,y+Self._window_y+Self._window_viewport_y+(5+ystep_2) )
				If ystep_2>((Self._window_text_h-(text_height*2)-5 )) Then Exit
			Next
		Endif
	'	Self._canvas.PopMatrix()
	'	Self._canvas.PushMatrix()
'		UnlockViewportWindow(Self)
'		Self._canvas.Alpha=(1.0)
'		SetBlendMode(Self._canvas,BlendMode.Alpha)
'		Self._canvas.Color=New Color(1,1,1)
'		Self._canvas.Scale(1,1)		
	End Method 
	
	
	Method SetWindowBorder:Int(border1_image:Image=Null,border2_image:Image=Null,border3_image:Image=Null,border4_image:Image=Null)
		If border1_image=Null And border2_image=Null And border3_image=Null And border4_image=Null 
			border1_image=g_window_border_left
			border2_image=g_window_border_right
			border3_image=g_window_border_top
			border4_image=g_window_border_bottom
		Endif
		Self._PWindow_border_left=border1_image
		Self._PWindow_border_right=border2_image
		Self._window_border_width=Self._PWindow_border_left.Width
		Self._window_border_right_scale=Float(Float(Self._window_viewport_height+(Self._PWindow_border_right.Height*2))/Float(Self._PWindow_border_right.Height))
		Self._window_border_left_scale=Float(Float(Self._window_viewport_height+(Self._PWindow_border_right.Height*2))/Float(Self._PWindow_border_left.Height))
		Self._PWindow_border_top=border3_image
		Self._window_border_top_scale=Float( Float(Self._window_viewport_width+(Self._PWindow_border_right.Width*2)) / Float(Self._PWindow_border_top.Width) )
		Self._window_border_height=Self._PWindow_border_top.Height
		Self._PWindow_border_bottom=border4_image	
		Self._window_border_bottom_scale=Float(Float(Self._window_viewport_width+(Self._PWindow_border_right.Width*2))/Float(Self._PWindow_border_bottom.Width))
		If Self._window_image<>Null
			Self._window_image_scale_width=Float(Float(Self._window_viewport_width)/Float(Self._window_image.Width))
			Self._window_image_scale_height=Float(Float(Self._window_viewport_height-Self._window_viewport_y)/Float(Self._window_image.Height))
		Endif
	
		Self.EnableBorder()
		Self.ShowBorder(False)
		Return True
	End Method
	
	
	Method SetTextArrayStyle:Void(blend:Int=BlendMode.Alpha,alpha:Float=1.0,r:Float=1.0,g:Float=1.0,b:Float=1.0)
		Self._window_text_alpha=alpha
		Self._window_text_blend=blend
		Self._window_text_red=r
		Self._window_text_green=g
		Self._window_text_blue=b
	End Method

	
	Method SetTextArrayIndex:Void(offset:Int)
		Self._textoffset=offset
	End Method


	Method SetTextFont:Void(font:Font)
		Self._gui_font=font
	End Method
	
'	Method SetWindowBGImage:Void(image:Image)
'		Self._window_image=image
'		If image<>Null
'			Self._window_image_width=Self.window_image.Width
'			Self._window_image_height=Self.window_image.Height
'		Else
'			Self._window_image_width=0
'			Self._window_image_height=0		
'		Endif
'	End Method

#Rem	
	Method SetWindowRotation:Void(rot_flag:Int,dx11:Int,off_x:Int,off_y:Int,rot_angle:Int)
		Self._window_rotation_flag=rot_flag
		Self._window_rotation_offset_x=off_x
		Self._window_rotation_offset_y=off_y
		Self._window_rotation_angle=rot_angle
		dx11_flag=dx11
	End Method

	
	Method SetWindowDXFlag:Void(dx:Int)
		dx11_flag=dx
	End Method
#End Rem

	Method SetBackgroundImage:Void(image:Image) 
		If image=Null
			Self._window_image=Null
			Self._window_background_image_flag=False
		Else
			Self._window_image=image
			Self._window_image_scale_width=Float(Float(Self._window_width)/Float(image.Width))
			Self._window_image_scale_height=Float(Float(Self._window_height)/Float(image.Height))
			Self._window_background_image_flag=True
		Endif
	End Method 

	Method SetBackgroundImageVisible:Void(flag:Bool)
		Self._window_background_image_flag=False
	End Method
	
	
	Method SetBackgroundAlpha:Void(alpha:Float)
		Self._window_alpha=alpha		
	End Method	


	Method SetBackgroundBlend:Void(blend:Int)
		Self._window_blend=blend
	End Method	


	Method SetBackgroundColor:Void(red:Float=1.0,green:Float=1.0,blue:Float=1.0)
			Self._window_red=red
			Self._window_green=green
			Self._window_blue=blue		
	End Method	


	Method SetBorderStyle:Void(blend:Int=BlendMode.Alpha,alpha:Float=1.0,r:Float=1.0,g:Float=1.0,b:Float=1.0)
		Self._window_border_blend=blend
		Self._window_border_alpha=alpha
		Self._window_border_red=r
		Self._window_border_green=g
		Self._window_border_blue=b
	End Method

	
	Method SetWindowControls:Void(id:String[],flag:Bool)
		Local len:Int=id.Length-1
		For Local i:Int=0 To len
			If id[i].ToLower()="close"
				'Self.close_window_image=g_close_window_image
				Self._window_close_control=New PButton("",1,1,30,30,1,1,Self,Window_Control_Button_List)
				If g_close_window_image_up<>Null 
					Self._window_close_control.SetImage(g_close_window_image_up,g_close_window_image_down,g_close_window_image_up,g_close_window_image_down)
					Self._window_close_control.SetHighlightBlend(3)
					'Self._window_close_control.SetHighlightAlpha(.8)
					Self._window_close_control.SetHighlightColor(.6,.6,.6)
				Endif
			Endif
			If id[i].ToLower()="maximize"
				'Self.close_window_image=g_maximize_window_image
				Self._window_maximize_control=New PButton("",35,1,30,30,1,1,Self,Window_Control_Button_List)
				If g_maximize_window_image_up<>Null 
					Self._window_maximize_control.SetImage(g_maximize_window_image_up,g_maximize_window_image_down,g_maximize_window_image_up,g_maximize_window_image_down)'close_window_image,close_window_image,close_window_image,close_window_image)
					Self._window_maximize_control.SetHighlightBlend(3)
					'Self._window_maximize_control.SetHighlightAlpha(.8)
					Self._window_maximize_control.SetHighlightColor(.6,.6,.6)
				Endif
			Endif
			If id[i].ToLower()="cast"
				'Self.close_window_image=g_maximize_window_image
				Self._window_cast_control=New PButton("",70,1,30,30,1,1,Self,Window_Control_Button_List)
				If g_screen_cast_window_image_up<>Null 
					Self._window_cast_control.SetImage(g_screen_cast_window_image_up,g_screen_cast_window_image_down,g_screen_cast_window_image_up,g_screen_cast_window_image_down)'close_window_image,close_window_image,close_window_image,close_window_image)
					Self._window_cast_control.SetHighlightBlend(3)
					'Self._window_cast_control.SetHighlightAlpha(.8)
					Self._window_cast_control.SetHighlightColor(.6,.6,.6)
				Endif
			Endif

		Next
	End Method
	
	Method SetCLS(flag:Bool)
		Self._window_cls_flag=flag
	End Method 
	
	
	Method SetCLSColor(red:Float=1.0,green:Float=1.0,blue:Float=1.0)
		Self._window_cls_red=red
		Self._window_cls_green=green
		Self._window_cls_blue=blue
	End Method
	
	
	Method SetViewPort:Void(x:Int,y:Int,width:Int,height:Int)
		Self._window_view_port_x=x
		Self._window_view_port_y=y
		Self._window_view_port_width=width
		Self._window_view_port_height=height
	End Method
		
	
	Method SetViewPort2:Void(x:Int,y:Int,width:Int,height:Int)
		Self.user_viewport_x=x
		Self.user_viewport_y=y
		Self.user_viewport_w=width
		Self.user_viewport_h=height
	End Method
	
	
	Method SetWindowPos:Void(x:Int,y:Int)
		Self._window_x=x
		Self._window_y=y
		Self._window_old_x=x
		Self._window_old_y=y
	End Method

	
	Method LockSliderFocus:Void(slider_id:Int)
		Self._silder_user_forced_focus=slider_id
	End Method

	
	Method UnLockSliderFocus:Void()
		Self._silder_user_forced_focus=0
	End Method
	
	
	Method WindowVisible:Int()
		Return Self._window_visible
	End Method


	Method SetSelectable:Void(flag:Int)
			Self._window_selectable=flag
	End Method


	
	Method SetResizable:Void(flag:Int)
			Self._window_resize_on=flag
	End Method


	Method SetMovable:Void(flag:Int)
			Self._window_movable=flag
	End Method

	
	Method SetWindowOnTop:Void()

		'-------------------
		'Normal Z-Order Sort
		'-------------------
		'	new_window._window_move=True
		'	old_m_x= mouse_x
		'	old_m_y= mouse_y
			Local win_count:Int
			If Self._window_cast_screen_flag=False
				Local current_window_z:Int=0'1
				Local new_window2:PWindow=New PWindow 

				If Self._window_top_most=True 
					PWindow_List_Swap.AddLast(Self)
					Self._window_z=current_window_z+1
					current_window_z=current_window_z+1
				Endif

				For new_window2=Eachin PWindow_List
					If new_window2<>Self  And new_window2._window_top_most=True
						current_window_z=current_window_z+1
						new_window2._window_z=current_window_z
						new_window2.ShowBorder(False)
						PWindow_List_Swap.AddLast(new_window2)
					Endif
					new_window2._window_selected=False
				Next

				If Self._window_top_most=False 
					PWindow_List_Swap.AddLast(Self)
					Self._window_z=current_window_z+1
					current_window_z=current_window_z+1
				Endif

				For new_window2=Eachin PWindow_List
					If new_window2<>Self  And new_window2._window_top_most=False
						current_window_z=current_window_z+1
						new_window2._window_z=current_window_z
						new_window2.ShowBorder(False)
						PWindow_List_Swap.AddLast(new_window2)
					Endif
					new_window2._window_selected=False
				Next

				PWindow_List=New List<PWindow>
				For Local temp1_obj:PWindow=Eachin PWindow_List_Swap
					PWindow_List.AddLast(temp1_obj)
					temp1_obj.ShowBorder(True)
					
					'might need this removed for testing
					'-----------------------------------
					'temp1_obj._window_selected=True
				Next 
				PWindow_List_Swap=New List<PWindow>
			Endif

'		Self._window_z=1 
'		Local current_window_z:Int=1
'		PWindow_List_Swap.AddLast(Self)
'		Local new_window3:PWindow=New PWindow
'		For new_window3=Eachin PWindow_List
'			If new_window3<>Self
'				current_window_z=current_window_z+1
'				new_window3._window_z=current_window_z
'				new_window3.ShowWindowBorder(False)
'				PWindow_List_Swap.AddLast(new_window3)
'			Endif
'			new_window3._window_selected=False
'		Next
'		PWindow_List.Clear()
'		For Local temp1_obj:PWindow=Eachin PWindow_List_Swap
'			PWindow_List.AddLast(temp1_obj)
'		Next 
'		PWindow_List_Swap.Clear()
		Self.ShowBorder(True)
		Self._window_selected=True
		g_window_selected_report=True
	End Method
	
	
	Method ShowBorder:Void(flag:Int)
			Self._window_border=flag
	End Method	


	Method ForceBorder:Void(flag:Int)
			Self._window_border_forced=flag
	End Method	


	Method DisableBorder:Void()
		Self._window_border_enable_flag=False
		Self._window_viewport_x=0
		Self._window_viewport_y=0
		Self._window_viewport_width=0
		Self._window_viewport_height=0
		Self._PWindow_border_left_width=0
		Self._PWindow_border_left_height=0
		Self._PWindow_border_right_width=0
		Self._PWindow_border_right_height=0
		Self._PWindow_border_top_width=0
		Self._PWindow_border_top_height=0
		Self._PWindow_border_bottom_width=0
		Self._PWindow_border_bottom_height=0
	End Method


	Method EnableBorder:Void()
		If Self._PWindow_border_left<>Null And Self._PWindow_border_right<>Null And Self._PWindow_border_top<>Null And Self._PWindow_border_bottom<>Null
			Self._window_border_enable_flag=True
			Self._window_border_right_scale=Float(Float(Self._window_height)/Float(Self._PWindow_border_right.Height))
			Self._window_border_left_scale=Float(Float(Self._window_height)/Float(Self._PWindow_border_left.Height))
			Self._window_border_top_scale=Float( Float(Self._window_viewport_width+(Self._PWindow_border_right.Width*2)) / Float(Self._PWindow_border_top.Width) )
			Self._window_border_bottom_scale=Float(Float(Self._window_viewport_width+(Self._PWindow_border_right.Width*2))/Float(Self._PWindow_border_bottom.Width))
			Self._PWindow_border_left_width=Self._PWindow_border_left.Width
			Self._PWindow_border_left_height=Self._PWindow_border_left.Height
			Self._PWindow_border_right_width=Self._PWindow_border_right.Width
			Self._PWindow_border_right_height=Self._PWindow_border_right.Height
			Self._PWindow_border_top_width=Self._PWindow_border_top.Width
			Self._PWindow_border_top_height=Self._PWindow_border_top.Height
			Self._PWindow_border_bottom_width=Self._PWindow_border_bottom.Width
			Self._PWindow_border_bottom_height=Self._PWindow_border_bottom.Height
		Endif
	End Method

	
	Method LockViewport2:Void(window_obj:PWindow)
		Local x:Int,y:Int,width:Int,height:Int
		'Local gsci:Int[]=window_obj._canvas.Scissor()
		window_obj._window_view_port_x=window_obj._canvas.Scissor.X'gsci[0]
		window_obj._window_view_port_y=window_obj._canvas.Scissor.Y'gsci[1]
		window_obj._window_view_port_width=window_obj._canvas.Scissor.Width'gsci[2]
		window_obj._window_view_port_height=window_obj._canvas.Scissor.Height'gsci[3] 
		'Print window_obj._canvas.Scissor.Height
		
		'Print window_obj._mojo_rect.Width
		
		Local vout:= New Int[4]
		vout[0]=(window_obj._window_viewport_x+window_obj._window_x +window_obj.user_viewport_x)*Float(window_obj._mojo_rect.Width / global_screen_width)
		vout[1]=(window_obj._window_viewport_y+window_obj._window_y +window_obj.user_viewport_y)*Float(window_obj._mojo_rect.Height / global_screen_height)
		vout[2]=window_obj._window_x+(window_obj._window_viewport_width-window_obj._window_viewport_x -window_obj.user_viewport_w)*Float(window_obj._mojo_rect.Width / global_screen_width)
		vout[3]=window_obj._window_y+(window_obj._window_viewport_height-window_obj._window_viewport_y -window_obj.user_viewport_h)*Float(window_obj._mojo_rect.Height / global_screen_height)
		'window_obj._canvas.SetScissor(vout[0], vout[1], vout[2], vout[3] )
		'window_obj._canvas.Scissor=New Recti(vout[0], vout[1], vout[2], vout[3])
		window_obj._canvas.Viewport=New Recti(vout[0], vout[1], vout[2], vout[3])
		
		'window_obj._canvas.Translate(0,window_obj._window_y)
		
		'Print vout[2]
		
		
		'If window_obj._renderer<>Null Then window_obj._renderer.SetViewport(vout[0], vout[1], vout[2], vout[3] )
	End Method


	Method UnlockViewportWindow:Void(window_obj:PWindow)
	'	window_obj._canvas.Scissor=New Recti(window_obj._window_view_port_x,window_obj._window_view_port_y,window_obj._window_view_port_width,window_obj._window_view_port_height) 
		window_obj._canvas.Viewport=New Recti(window_obj._window_view_port_x,window_obj._window_view_port_y,window_obj._window_view_port_width,window_obj._window_view_port_height)
	End Method


	Method LockViewport:Void(window_obj:PWindow)
		Local x:Int,y:Int,width:Int,height:Int
		'Local gsci:Int[]=window_obj._canvas.Scissor()
		window_obj._window_view_port_x=window_obj._canvas.Scissor.X'gsci[0]
		window_obj._window_view_port_y=window_obj._canvas.Scissor.Y'gsci[1]
		window_obj._window_view_port_width=window_obj._canvas.Scissor.Width'gsci[2]
		window_obj._window_view_port_height=window_obj._canvas.Scissor.Height'gsci[3] 
		Local vout:= New Float[4]
		vout[0]=(window_obj._window_viewport_x+window_obj._window_x +window_obj.user_viewport_x)*Float(window_obj._mojo_rect.Width/global_screen_width)
		vout[1]=(window_obj._window_viewport_y+window_obj._window_y +window_obj.user_viewport_y)*Float(window_obj._mojo_rect.Height /global_screen_height)
		vout[2]=window_obj._window_x+(window_obj._window_viewport_width-window_obj._window_viewport_x -window_obj.user_viewport_w+1)*Float(window_obj._mojo_rect.Width /global_screen_width)
		vout[3]=window_obj._window_y+(window_obj._window_viewport_height-window_obj._window_viewport_y -window_obj.user_viewport_h+1)*Float(window_obj._mojo_rect.Height /global_screen_height)
		'window_obj._canvas.SetScissor(vout[0], vout[1], vout[2], vout[3] )
	'	window_obj._canvas.Scissor=New Recti(vout[0], vout[1], vout[2], vout[3])
		window_obj._canvas.Viewport=New Recti(vout[0], vout[1], vout[2], vout[3])
	End Method


	Method ShowCursor:Void(flag:Int)
		g_mouse_cursor_on=flag
	End Method

	
	Method WindowSelected:Bool()
		If Self._window_selected=True
			Return True
		Else
			Return False
		Endif
		Return False
	End Method

	
	Method PositionVisibleWindows:Void(gw:Int,gh:Int)
		Local new_window2:PWindow
		For new_window2=Eachin PWindow_List	
			If new_window2._window_visible=True
				If new_window2._window_x+new_window2._window_width > gw Then  new_window2._window_x= gw-new_window2._window_width
				If new_window2._window_y+new_window2._window_height > gh  Then  new_window2._window_y= gh-new_window2._window_height
			Endif
		Next
	End Method

	
'	Method SetFont:Void(font:ImageFont)
'		Self._gui_font=font
'	End Method


'	Method Get_Window_Font:ImageFont()
'		Return Self._gui_font
'	End Method

	
	Function LoadResources:Void(file:String)
	Print "Alien Phoenix: Loading Window Resources. . ."
		Local newss:String
		Local path:String="asset::"'AppDir()+"assets/"
		Local mt:String=LoadString(path+file)
		
		
		'Print file
'		Print "--------------------------------->"+path+file
		
		
		newss=mt
		Local cnt:Int=1
		newss.Trim()
		Local strend:Int=newss.Length-1		
		Local start:Int=0
		Local strcnt:Int
		For Local ts:Int=1 To strend+1
			Local mys:String=newss.Slice(ts,(ts+1))'[ts..(ts+1)]
			If mys=String.FromChar(10) Or ts=strend+1
				Local line:String=newss.Slice(start,ts)'[start..(ts)]
				start=ts+1
	
				If (Mid(line,1,20)).ToLower()="<left_window_border>" Then g_window_border_left=Image.Load(path+Mid(line,21,line.Length))',0,0)
				If (Mid(line,1,21)).ToLower()="<right_window_border>" Then g_window_border_right=Image.Load(path+Mid(line,22,line.Length))',0,0)
				If (Mid(line,1,19)).ToLower()="<top_window_border>" Then g_window_border_top=Image.Load(path+Mid(line,20,line.Length))',0,0)
				If (Mid(line,1,22)).ToLower()="<bottom_window_border>" Then g_window_border_bottom=Image.Load(path+Mid(line,23,line.Length))',0,0)					

				If (Mid(line,1,19)).ToLower()="<maximize_up_image>" Then g_maximize_window_image_up=Image.Load(path+Mid(line,20,line.Length))',0,0)
				If (Mid(line,1,21)).ToLower()="<maximize_down_image>" Then g_maximize_window_image_down=Image.Load(path+Mid(line,22,line.Length))',0,0)
				If (Mid(line,1,21)).ToLower()="<restore_window_image>" Then g_restore_window_image_up=Image.Load(path+Mid(line,22,line.Length))',0,0)
				If (Mid(line,1,22)).ToLower()="<screen_cast_up_image>" Then g_screen_cast_window_image_up=Image.Load(path+Mid(line,23,line.Length))',0,0)
				If (Mid(line,1,24)).ToLower()="<screen_cast_down_image>" Then g_screen_cast_window_image_down=Image.Load(path+Mid(line,25,line.Length))',0,0)															
				If (Mid(line,1,16)).ToLower()="<close_up_image>" Then g_close_window_image_up=Image.Load(path+Mid(line,17,line.Length))',0,0)
				If (Mid(line,1,18)).ToLower()="<close_down_image>" Then g_close_window_image_down=Image.Load(path+Mid(line,19,line.Length))',0,0)
			
				If (Mid(line,1,8)).ToLower()="<cursor>" Then g_cursor=Image.Load(path+Mid(line,9,line.Length))',0,0)
				If (Mid(line,1,19)).ToLower()="<cursor_scale_horz>" Then g_cursor_scale_horz=Image.Load(path+Mid(line,20,line.Length))',0,0)
				If (Mid(line,1,19)).ToLower()="<cursor_scale_vert>" Then g_cursor_scale_vert=Image.Load(path+Mid(line,20,line.Length))',0,0)
				If (Mid(line,1,17)).ToLower()="<cursor_scale_ne>" Then g_cursor_scale_ne=Image.Load(path+Mid(line,18,line.Length))',0,0)
				If (Mid(line,1,17)).ToLower()="<cursor_scale_nw>" Then g_cursor_scale_nw=Image.Load(path+Mid(line,18,line.Length))',0,0)
				If (Mid(line,1,17)).ToLower()="<cursor_scale_se>" Then g_cursor_scale_se=Image.Load(path+Mid(line,18,line.Length))',0,0)
				If (Mid(line,1,17)).ToLower()="<cursor_scale_sw>" Then g_cursor_scale_sw=Image.Load(path+Mid(line,18,line.Length))',0,0)
				If (Mid(line,1,25)).ToLower()="<window_background_image>" Then g_window_background_image=Image.Load(path+Mid(line,26,line.Length))',0,0)
				
				
'g_window_background_image
'Global g_cursor_offx:Int
'Global g_cursor_offy:Int
'Global g_cursor_scale:Image
'Global g_cursor_scale_offx:Int
'Global g_cursor_scale_offy:Int
			
			Endif
		Next
	'	If 	window_border_left=Null Then Print "LRWINDOW NULLLLLLL"

'		If g_cursor<>Null
			
'		Endif


	End Function

	Function Mid:String( str:String,pos:Int,size:Int=-1 )
		If pos>str.Length Return ""
		pos-=1
		If( size<0 ) 
			Return (str.Slice(pos,str.Length))'[pos..]
		Endif
		If pos<0 
			size=size+pos 
			pos=0
		Endif
		If pos+size>str.Length 
			size=str.Length-pos
		Endif
		Return str.Slice(pos,(pos+size))'[pos..pos+size]
	End Function
			
End Class


Function SetBlendMode:Void(canvas:Canvas,blend:Int)
	If blend=1 Then canvas.BlendMode=BlendMode.Opaque
	If blend=2 Then canvas.BlendMode=BlendMode.Alpha
	If blend=3 Then canvas.BlendMode=BlendMode.Additive
	If blend=4 Then canvas.BlendMode=BlendMode.Multiply
	'Return Null
End Function




