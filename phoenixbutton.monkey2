'****************************************************************************
'* Alien Phoenix Gaming Framework							  
'* Copyright (c) 2018 Richard R Betson
'* Author - Richard R Betson
'* 
'* Language: Monkey2
'* Targets: Android, Windows, Linux, Emscripten, IOS
'* Title: Phoenix Button
'* Licence: zlib/libpng License (Zlib) - https://opensource.org/licenses/Zlib
'* Version: 0.7
'****************************************************************************

Namespace phoenixbutton
#Import "phoenixslider"
#Import "phoenixlistbox"
Using phoenixslider
Using phoenixlistbox

Global button_up_default:Image
Global button_down_default:Image
Global button_highlight_default:Image
Global button_selected_default:Image

Global g_slider_horz_thumb_up:Image
Global g_slider_horz_thumb_down:Image
Global g_slider_horz_thumb_highlight:Image
Global g_slider_horz_thumb_selected:Image
Global g_slider_horz_top_up:Image
Global g_slider_horz_top_down:Image
Global g_slider_horz_top_highlight:Image
Global g_slider_horz_top_selected:Image
Global g_slider_horz_bottom_up:Image
Global g_slider_horz_bottom_down:Image
Global g_slider_horz_bottom_highlight:Image
Global g_slider_horz_bottom_selected:Image

Global g_slider_vert_thumb_up:Image
Global g_slider_vert_thumb_down:Image
Global g_slider_vert_thumb_highlight:Image
Global g_slider_vert_thumb_selected:Image
Global g_slider_vert_top_up:Image
Global g_slider_vert_top_down:Image
Global g_slider_vert_top_highlight:Image
Global g_slider_vert_top_selected:Image
Global g_slider_vert_bottom_up:Image
Global g_slider_vert_bottom_down:Image
Global g_slider_vert_bottom_highlight:Image
Global g_slider_vert_bottom_selected:Image

Global g_slider_pannel:Image

Global g_listbox_button_up:Image
Global g_listbox_button_down:Image
Global g_listbox_button_highlight:Image
Global g_listbox_button_selected:Image


Global g_listbox_slider_up:Image
Global g_listbox_slider_down:Image
Global g_listbox_slider_highlight:Image
Global g_listbox_slider_selected:Image

Global g_button_text_center:Int=True	'Global text center state True/False
Global g_listbox_text_center:Int=False	'Global text center state True/False
Global g_listbox_alpha:Float=1.0

Global g_buttont_font:Font


Global listbox_slider:Image

Global button_r:Float=1.0
Global button_g:Float=1.0
Global button_b:Float=1.0

Global slider_button_r:Float=1.0
Global slider_button_g:Float=1.0
Global slider_button_b:Float=1.0

Global listbox_bg:Image
Global ship_view_bg:Image
Global panel_1:Image
Global panel_2:Image

'Global slider_override_button_id:Int=0 	'disables all button input other then slider button
Global slider_override_obj:PButton


Global maxbuttoncount:Int=10000000
'Global ButtonSliderIndex:Int=10010000	'Slider button index
'Global LISTBOX_BUTTON_INDEX_START:Int=10020000
'Global listbox_button_index:Int=LISTBOX_BUTTON_INDEX_START
'Global ListboxSliderIndex:Int=10030000

Global listbox_slider_bw:Int=20
Global listbox_slider_bh:Int=20

Global sliderimage:Image
Global silder_forced_focus:PSlider
Global silder_user_forced_focus:PSlider

Global Button_List:=New List<PButton>
Global Slider_List:=New List<PSlider>
Global Button_ListBox_List:=New List<PListBox>
Global slider_Button_List:=New List<PButton>

Global mouse_button_status:Int=False
Global ship_index:Int=1
Global button_time:Int=0

Global global_highlight_button_red:Float=1.0
Global global_highlight_button_green:Float=1.0
Global global_highlight_button_blue:Float=1.0
Global global_highlight_button_blend:Int=BlendMode.Alpha
Global global_highlight_button_alpha:Float=0.9

Global global_selected_button_red:Float=1.0
Global global_selected_button_green:Float=1.0
Global global_selected_button_blue:Float=1.0
Global global_selected_button_blend:Int=BlendMode.Alpha
Global global_selected_button_alpha:Float=0.9

Global global_down_button_red:Float=1.0
Global global_down_button_green:Float=1.0
Global global_down_button_blue:Float=1.0
Global global_down_button_blend:Int=BlendMode.Alpha
Global global_down_button_alpha:Float=0.9


Global background_canvas:Canvas


Class PTextBox 'Final
	Field x:Int
	Field y:Int
	Field w:Int
	Field h:Int
	Field image:Image
	Field text:String
	Field r:Int,g:Int,b:Int
	Field tr:Int=255,tg:Int=255,tb:Int=255
	
	Method CreateTextBox:Void(x:Int,y:Int,w:Int,h:Int,text:String,image:Image,r:Float=1.0,g:Float=1.0,b:Float=1.0)
		Local p_textbox:=New PTextBox
		p_textbox.x=x
		p_textbox.y=y
		p_textbox.w=w
		p_textbox.h=h
		p_textbox.r=r
		p_textbox.g=g
		p_textbox.b=b
		p_textbox.image=image
		p_textbox.text=text
	End Method
	
End Class




Class PMenuElement Final
	Field name:String
	Field x:Int,y:Int,w:Int,h:Int
End Class



Class PMenu
	Field name:String
	Field x:Int,y:Int,w:Int,h:Int
	Field menu_elements_list:=New List<PMenuElement>
End Class


Class PButton 'Final
	Field button_down_flag:Int 'Flag for down click responce delay
	Field window:PWindow
	Field buttonstyle:Int
	Field x:Int
	Field y:Int
	Field w:Int
	Field h:Int
	Field alpha:Float
	Field blend:Int=BlendMode.Alpha
	Field up_image:Image
	Field down_image:Image
	Field selected_image:Image
	Field highlight_image:Image
	Field z_order:Int
	Field z_order_limit:Int=100
	Field button_down:Int
	Field name:String
	Field name_image:Image
	Field id:Int
	Field visible:Int
	Field button_selected:Int=False
	Field scalew:Float
	Field scaleh:Float

	Field text_red:Float=1.0
	Field text_green:Float=1.0
	Field text_blue:Float=1.0
	Field text_alpha:Float=0.9
	Field text_blend:Int=BlendMode.Alpha

	Field text_selected_red:Float=1.0
	Field text_selected_green:Float=1.0
	Field text_selected_blue:Float=1.0
	Field text_selected_alpha:Float=1.0
	Field text_selected_blend:Int=BlendMode.Alpha

	Field text_down_red:Float=1.0
	Field text_down_green:Float=1.0
	Field text_down_blue:Float=1.0
	Field text_down_alpha:Float=1.0
	Field text_down_blend:Int=BlendMode.Alpha

	Field text_highlight_red:Float=1.0
	Field text_highlight_green:Float=1.0
	Field text_highlight_blue:Float=1.0
	Field text_highlight_alpha:Float=1.0
	Field text_highlight_blend:Int=BlendMode.Alpha
	
	Field text_center:Int
	Field listbox_id:Int=False
	Field hover_status:Int=False
	Field lb_button_id:Int =False 	'index of buttons used for list box
	Field button_state_override:Int 'Used for instant action on button down.
	
	Field highlight_blend:Int=global_highlight_button_blend
	Field highlight_alpha:Float=global_highlight_button_alpha
	Field highlight_red:Float=global_highlight_button_red
	Field highlight_green:Float=global_highlight_button_green
	Field highlight_blue:Float=global_highlight_button_blue

	Field selected_blend:Int=global_selected_button_blend
	Field selected_alpha:Float=global_selected_button_alpha
	Field selected_red:Float=global_selected_button_red
	Field selected_green:Float=global_selected_button_green
	Field selected_blue:Float=global_selected_button_blue

	Field down_blend:Int=global_down_button_blend
	Field down_alpha:Float=global_down_button_alpha
	Field down_red:Float=global_down_button_red
	Field down_green:Float=global_down_button_green
	Field down_blue:Float=global_down_button_blue

	Field up_red:Float=1.0
	Field up_green:Float=1.0
	Field up_blue:Float=1.0
	Field up_color:= New Color(1.0,1.0,1.0)
	
	
'	Field buttom_alpha:Float '<<<<<<<<<<<<<< change to this in convertion
'	Field buttom_blend:Int '<<<<<<<<<<<<<< change to this in convertion
	
	'Field button_font:Font'=LoadImageFont("system_resorces/Vera-Bold.ttf",10)'
	Field touch_x:Int,touch_y:Int
	
	Method New()
	End Method


	Method New(text:String,x:Int,y:Int,w:Int,h:Int,buttonstyle:Int=1,z_order:Int=0,window:PWindow,game_button_list:List<PButton> = Null)'=Null)
		'Local p_button:Button=New Button
		Self.up_image=button_up_default
		Self.down_image=button_down_default
		Self.highlight_image=button_highlight_default
		Self.selected_image=button_selected_default
		Self.window=window
		Self.x=x
		Self.y=y
		Self.w=w
		Self.h=h
		Self.alpha=1.0
		Self.buttonstyle=buttonstyle
		Self.name=text
		Self.scalew=(Float(w)/Float(Self.up_image.Width))
		Self.scaleh=(Float(h)/Float(Self.up_image.Height))
		'Self.id=button_id
		Self.visible=True
		Self.text_red=button_r
		Self.text_green=button_g
		Self.text_blue=button_b
		Self.text_center=g_button_text_center
		Self.z_order=z_order
		
		'Button_List.AddLast(Self)
		window.Window_Button_List.AddLast(Self)
		
		Self.SortZOrder(window.Window_Button_List)
		
		If game_button_list<>Null
			game_button_list.AddLast(Self)
			Self.SortZOrder(game_button_list)
		Endif
	'	Return p_button
	End Method


	Method Update:Int(x:Int,y:Int,mousebutton:Int,window:PWindow=Null,winx:Int=0,winy:Int=0,window_selected:Int=False)
		'------------------------
		'Get touch screen touches
		'------------------------
		'Removed for MX2
'		Local touches:Int=TouchDown(1)
		Local touch_count:Int
'		If touches=True
'			touch_count=2
'		Else
'			touch_count=1
'		Endif
		touch_count=1



		For Local tcount:Int=1 To touch_count
			'----------------------------
			'Transform screen coordinates
			'----------------------------
			'Local vout:Float[3]
			'window._canvas.TransformCoords([TouchX(tcount-1),TouchY(tcount-1)],vout,0)
			x=Mouse.X'vout[0]
			y=Mouse.Y'vout[1]
			Self.touch_x=x
			Self.touch_y=y
			mouse_button_status=mousebutton
			'--------------------------------------
			'On override (no window move or resize)
			'which is a condition where the button 
			'is in the down position and curor is
			'bieng moved.
			'--------------------------------------
			If slider_override_obj>Null' slider_override_button_id>0 
				'-----------------------------------------
				'If slider_override_button_id=true then
				'update button with no window move/resize.
				'-----------------------------------------
				If Self=slider_override_obj'Self.id=slider_override_button_id
					Self.UpdateButton(False,True,window,0,0,window_selected)'winx,winy
					Return True
				Else
					Self.UpdateButton(False,False,window,0,0,window_selected)
					Return True
				Endif
			Else
				'-----------------------------------------
				'If cursor within button area then update.
				'-----------------------------------------
				If  ( (x>=Self.x+winx And x<(Self.x+winx+Self.w)) And (y>=Self.y+winy And y<(Self.y+winy+Self.h)) )  And (Self.window=window Or window=Null) And (window_selected=True Or window=Null)
					If Mouse.ButtonDown(MouseButton.Left)=True
						Self.UpdateButton(False,True,window,0,0,window_selected)
						Return True
					Else
						Self.UpdateButton(True,False,window,0,0,window_selected)
						If Self.button_down_flag=True 
							Self.button_down=True
							Self.button_down_flag=False
						Endif
					Endif
				Else
					Self.UpdateButton(False,False,window,0,0,window_selected)
					If Self.button_down_flag=True  And Mouse.ButtonDown(MouseButton.Left)=True 
						Self.button_down_flag=False
					Endif
				Endif
			Endif
		Next

		Return False
	End Method


	Method UpdateButton:Void(highlight_flag:Int=False,button_flag:Int=False,window:PWindow=Null,winx:Int=0,winy:Int=0,window_selected:Int=False,windowless:Int=False)
		If Self.id< maxbuttoncount 
			Self.button_down=False	
		Endif

		Local myMatrix:=New AffineMat3f

		Local t1_x:Float=Self.up_image.Handle.x
		Local t1_y:Float=Self.up_image.Handle.y
		Local t2_x:Float=Self.down_image.Handle.x
		Local t2_y:Float=Self.down_image.Handle.y
		Local t3_x:Float=Self.selected_image.Handle.x
		Local t3_y:Float=Self.selected_image.Handle.y
		Local t4_x:Float=Self.highlight_image.Handle.x
		Local t4_y:Float=Self.highlight_image.Handle.y

		Self.up_image.Handle=New Vec2f(.0,.0)
		Self.down_image.Handle=New Vec2f(.0,.0)
		Self.selected_image.Handle=New Vec2f(.0,.0)
		Self.highlight_image.Handle=New Vec2f(.0,.0)
		
		'----------------------
		'Draw buttons on window
		'----------------------
		If Self.window=window And highlight_flag=False And Self.button_down=False And button_flag=False
			Self.window._canvas.PopMatrix()
			Self.window._canvas.PushMatrix()
'			Self.window._canvas.Transform(Self.scalew,0,0,Self.scaleh,Self.x+winx,Self.y+winy)
			Self.window._canvas.Font=g_buttont_font
			'g_mojo_window_style.Font=g_buttont_font

				'Local myMatrix:=New AffineMat3f
				myMatrix.i.x=Self.scalew
				myMatrix.j.y=Self.scaleh
				myMatrix.t.x=Self.x+winx
				myMatrix.t.y=Self.y+winy
				Self.window._canvas.Matrix*=myMatrix   'transform current matrix by myMatrix.


			If Self.button_selected=True
				Self.window._canvas.Color=New Color(Self.selected_red,Self.selected_green,Self.selected_blue)'SetColor(Self.selected_red,Self.selected_green,Self.selected_blue)
				Self.window._canvas.Alpha=(Self.selected_alpha)'SetAlpha(Self.selected_alpha)
				SetBlendMode(Self.window._canvas,Self.selected_blend)
				Self.window._canvas.DrawImage(Self.selected_image,0,0)
				
				Self.window._canvas.Color=New Color(Self.text_selected_red,Self.text_selected_green,Self.text_selected_blue)'SetColor(Self.text_selected_red,Self.text_selected_green,Self.text_selected_blue)
				Self.window._canvas.Alpha=Self.text_selected_alpha'SetAlpha(Self.text_selected_alpha)
				'Self.window._canvas.SetBlendMode(Self.window._canvas.Self.text_selected_blend)
				SetBlendMode(Self.window._canvas,Self.text_selected_blend)

			Else
				Self.window._canvas.Color=Self.up_color'New Color(Self.button_red,Self.button_green,Self.button_blue)' SetColor(Self.button_red,Self.button_green,Self.button_blue)
				SetBlendMode(Self.window._canvas,Self.blend)
				Self.window._canvas.Alpha=Self.alpha'SetAlpha(Self.alpha)
				Self.window._canvas.DrawImage(Self.up_image,0,0)
				'Self.window._canvas.Color=New Color(Self.text_selected_red,Self.text_selected_green,Self.text_selected_blue)' SetColor(Self.text_selected_red,Self.text_selected_green,Self.text_selected_blue)

				Self.window._canvas.Color=New Color(Self.text_red,Self.text_green,Self.text_blue)' SetColor(Self.text_red,Self.text_green,Self.text_blue)
				Self.window._canvas.Alpha=Self.text_alpha'SetAlpha(Self.text_selected_alpha)
				SetBlendMode(Self.window._canvas,Self.text_blend)

			Endif
			Self.window._canvas.PopMatrix()
			Self.window._canvas.PushMatrix()
			Self.window._canvas.Scale(1,1)
			Self.window._canvas.PopMatrix()
			Self.window._canvas.PushMatrix()
			
			Local len_char:Int=Self.window._canvas.Font.TextWidth("a")
			Local name_len:Int=Self.window._canvas.Font.TextWidth(Self.name)
			Local tmp_name:String
			If name_len > Self.w
				tmp_name= Mid(Self.name,1,(Self.w/len_char))
			Else
				tmp_name=Self.name 
			Endif 
		
			If Self.text_center=True
				Self.window._canvas.DrawText(tmp_name,( (Self.w/2)-(Self.window._canvas.Font.TextWidth(Self.name)/2) )+Self.x+winx,( (Self.h/2)-(Self.window._canvas.Font.TextWidth("A")) ) +Self.y+winy)		
			Else
				Self.window._canvas.DrawText(tmp_name,Self.x+winx,( (Self.h/2)-(Self.window._canvas.Font.TextWidth("A")) ) +Self.y+winy)
			Endif
			Self.window._canvas.PopMatrix()
			Self.window._canvas.PushMatrix()
		Endif
		If Self.window=window And window_selected=True
			Self.window._canvas.Font=g_buttont_font
			If Self.visible=True
				Self.hover_status=False 'Reset cusrsor hover flag
				Self.window._canvas.Color=New Color(1,1,1)' SetColor(1,1,1)
				Self.window._canvas.Scale(Self.scalew,Self.scaleh)
				Self.window._canvas.Alpha=Self.alpha' SetAlpha(Self.alpha)
				'---------------------
				'Draw highlight button
				'---------------------
				If highlight_flag= True And window_selected=True
					If Self.buttonstyle=1
						Self.hover_status=True 
						Self.window._canvas.Color= Self.up_color'New Color(Self.button_red,Self.button_green,Self.button_blue)'SetColor(Self.button_red,Self.button_green,Self.button_blue)
						Self.window._canvas.PopMatrix()
						Self.window._canvas.PushMatrix()
'						Self.window._canvas.Transform(Self.scalew,0,0,Self.scaleh,Self.x+winx,Self.y+winy)

				'Local myMatrix:=New AffineMat3f
				myMatrix.i.x=Self.scalew
				myMatrix.j.y=Self.scaleh
				myMatrix.t.x=Self.x+winx
				myMatrix.t.y=Self.y+winy
				Self.window._canvas.Matrix*=myMatrix   'transform current matrix by myMatrix.


						If Mouse.ButtonDown(MouseButton.Left)=False
							Self.window._canvas.Alpha=Self.highlight_alpha'SetAlpha(Self.highlight_alpha)
							'Self.window._canvas.SetBlendMode(Self.highlight_blend)
							SetBlendMode(Self.window._canvas,Self.highlight_blend)
							
							Self.window._canvas.Color=New Color(Self.highlight_red,Self.highlight_green,Self.highlight_blue)'SetColor(Self.highlight_red,Self.highlight_green,Self.highlight_blue)
							Self.window._canvas.DrawImage(Self.highlight_image,0,0)
						Else
							Self.window._canvas.DrawImage(Self.down_image,0,0)
						Endif
						Self.window._canvas.PopMatrix()
						Self.window._canvas.PushMatrix()				
						Self.window._canvas.Scale(1,1)
						Self.window._canvas.Alpha=Self.text_highlight_alpha'1'SetAlpha(1)
						'Self.window._canvas.SetBlendMode(BlendMode.Alpha)
						SetBlendMode(Self.window._canvas,Self.text_highlight_blend)
						
						'Self.window._canvas.Color=New Color(Self.text_red,Self.text_green,Self.text_blue)'SetColor(Self.text_red,Self.text_green,Self.text_blue)
						Self.window._canvas.Color=New Color(Self.text_highlight_red,Self.text_highlight_green,Self.text_highlight_blue)

						Local len_char:Int=Self.window._canvas.Font.TextWidth("a")
						Local name_len:Int=Self.window._canvas.Font.TextWidth(Self.name)
						Local tmp_name:String
						If name_len > Self.w
							tmp_name= Mid(Self.name,1,((Self.w)/len_char))
						Else
							tmp_name=Self.name 
						Endif 
									
						
						If Self.text_center=True
							Self.window._canvas.DrawText(tmp_name,( (Self.w/2)-(Self.window._canvas.Font.TextWidth(Self.name)/2) )+Self.x+winx,( (Self.h/2)-(Self.window._canvas.Font.TextWidth("A")) ) +Self.y+winy)		
						Else
							Self.window._canvas.DrawText(tmp_name,Self.x+winx,( (Self.h/2)-(Self.window._canvas.Font.TextWidth("A")) ) +Self.y+winy)
						Endif
					Endif
				Else
					'---------------------
					'Draw down button
					'---------------------
					If button_flag=False
						Self.button_down=False
					Else
						If Self.buttonstyle=1 
							Self.window._canvas.PopMatrix()
							Self.window._canvas.PushMatrix()
'							Self.window._canvas.Transform(Self.scalew,0,0,Self.scaleh,winx+Self.x,winy+Self.y)

				'Local myMatrix:=New AffineMat3f
				myMatrix.i.x=Self.scalew
				myMatrix.j.y=Self.scaleh
				myMatrix.t.x=Self.x+winx
				myMatrix.t.y=Self.y+winy
				Self.window._canvas.Matrix*=myMatrix   'transform current matrix by myMatrix.


							Self.window._canvas.Color=New Color(Self.down_red,Self.down_green,Self.down_blue)'SetColor(Self.down_red,Self.down_green,Self.down_blue)
							'Self.window._canvas.SetBlendMode(Self.down_blend)
							SetBlendMode(Self.window._canvas,Self.down_blend)
							
							Self.window._canvas.Alpha=Self.down_alpha'SetAlpha(Self.down_alpha)
							Self.window._canvas.DrawImage(Self.down_image,0,0)
							Self.window._canvas.Scale(1,1)
							Self.window._canvas.PopMatrix()
							Self.window._canvas.PushMatrix()
							Self.window._canvas.Alpha=Self.text_highlight_alpha'SetAlpha(Self.text_highlight_alpha)
							'Self.window._canvas.SetBlendMode(Self.text_highlight_blend)
							SetBlendMode(Self.window._canvas,Self.text_highlight_blend)
							
							Self.window._canvas.Color=New Color(Self.text_down_red,Self.text_down_green,Self.text_down_blue)'SetColor(Self.text_down_red,Self.text_down_green,Self.text_down_blue)

							Local len_char:Int=Self.window._canvas.Font.TextWidth("a")
							Local name_len:Int=Self.window._canvas.Font.TextWidth(Self.name)
							Local tmp_name:String
							If name_len > Self.w
								tmp_name= Mid(Self.name,1,(Self.w/len_char))
							Else
								tmp_name=Self.name 
							Endif 
					

							If Self.text_center=True
								Self.window._canvas.DrawText(tmp_name,( (Self.w/2)-(Self.window._canvas.Font.TextWidth(Self.name)/2) )+Self.x+winx,( (Self.h/2)-(Self.window._canvas.Font.TextWidth("A")) ) +Self.y+winy)		
							Else
								Self.window._canvas.DrawText(tmp_name,Self.x+winx,( (Self.h/2)-(Self.window._canvas.Font.TextWidth("A")) ) +Self.y+winy)
							Endif
						Else
						Endif
						If window_selected=True And window._window_resize_flag=False'Or Self.window=Null And window_selected=True 
							If Self.button_state_override=True Then Self.button_down=True 'override for button action delay in sliders
							Self.button_down_flag=True 'Button action delay flag see Update()
						Endif
					Endif
				Endif
			Endif
			Self.window._canvas.Scale(1,1)
		Endif

		Self.up_image.Handle=New Vec2f(t1_x,t1_y)
		Self.down_image.Handle=New Vec2f(t2_x,t2_y)
		Self.selected_image.Handle=New Vec2f(t3_x,t3_y)
		Self.highlight_image.Handle=New Vec2f(t4_x,t4_y)

	End Method

	
	'Returns button state. True button down.
	Method ButtonDown:Int()
		If Self.button_down=True And Self.button_down_flag=False
			Return True
		Else
			Return False
		Endif
		Return False
	End Method 
	
	
	Method Destroy:Void(window:PWindow)
		window.Window_Button_List.Remove(Self)
	End Method
	

	Method DeleteButton:Void()
		'Button_List.Remove(Self)
		Self.window.Window_Button_List.Remove(Self)
		'ListRemove(window,Window_Button_List,p_button)
	End Method


	
	Method GetButtonObject:PButton()
		Return Self
		Return Null
	End Method 


	Method GetVisible:Int()
		Return Self.visible
		Return False
	End Method


	Method GetSelected:Int()
		Return Self.button_selected
		Return False
	End Method
	

	Method SortZOrder:Void(list:List<PButton>)'=Null)
		Local temp_list:=New List<PButton>
		For Local i:Int=0 To Self.z_order_limit
			For Local button:PButton=Eachin list
				If button.z_order=i Then  temp_list.AddLast(button)
			Next
		Next
		list.Clear()
		For Local button2:PButton=Eachin temp_list
			list.AddLast(button2)
		Next
		temp_list.Clear()
	End Method


	Method GetCursorHoverStatus:Int()
		Return Self.hover_status
		Return False
	End Method

	
	Method HideWindowResources:Void(window:PWindow)
		For Local p_button:PButton=Eachin window.Window_Button_List
			If p_button.window=window
				p_button.visible=False
				Exit
			Endif
		Next
	End Method


	Method ShowWindowResources:Void(window:PWindow)
		For Local p_button:PButton=Eachin window.Window_Button_List
			If p_button.window=window
				p_button.visible=True
				Exit
			Endif
		Next
	End Method


	Method SetBackgroundCanvas:Void(canvas:Canvas)
		background_canvas=canvas		
	End Method
	
	
	Method SetHighlightGlobalColor:Void(r:Float=1.0,g:Float=1.0,b:Float=1.0)
		global_highlight_button_red=r
		global_highlight_button_green=g
		global_highlight_button_blue=b
		
	End Method


	Method SetHighlightGlobalBlend:Void(blend:Int)
		global_highlight_button_blend=blend

	End Method


	Method SetHighlightGlobalAlpha:Void(alpha:Float)
		global_highlight_button_alpha=alpha
	End Method


	Method SetSelectedGlobalColor:Void(r:Float=1.0,g:Float=1.0,b:Float=1.0)
		global_selected_button_red=r
		global_selected_button_green=g
		global_selected_button_blue=b
	End Method


	Method SetSelectedGlobalBlend:Void(blend:Int)
		global_selected_button_blend=blend

	End Method


	Method SetSelectedGlobalAlpha:Void(alpha:Float)
		global_selected_button_alpha=alpha
	End Method


	Method SetHighlightBlend:Void(blend:Int)
		Self.highlight_blend=blend
	End Method


	Method SetHighlightAlpha:Void(alpha:Float)
		Self.highlight_alpha=alpha
	End Method


	Method SetHighlightColor:Void(r:Float=1.0,g:Float=1.0,b:Float=1.0)
		Self.highlight_red=r
		Self.highlight_green=g
		Self.highlight_blue=b		
	End Method


	Method SetSelectedBlend:Void(blend:Int)
		Self.selected_blend=blend
	End Method


	Method SetSelectedAlpha:Void(alpha:Float)
		Self.selected_alpha=alpha
	End Method


	Method SetSelectedColor:Void(r:Float=1.0,g:Float=1.0,b:Float=1.0)
		Self.selected_red=r
		Self.selected_green=g
		Self.selected_blue=b		
	End Method


	Method SetDownBlend:Void(blend:Int)
		Self.down_blend=blend
	End Method


	Method SetDownAlpha:Void(alpha:Float)
		Self.down_alpha=alpha
	End Method


	Method SetDownColor:Void(r:Float=1.0,g:Float=1.0,b:Float=1.0)
		Self.down_red=r
		Self.down_green=g
		Self.down_blue=b		
	End Method


	Method SetFont:Void(font:Font)
		g_buttont_font=font
	End Method


	Method SetTextColorSelected:Void(r:Float=1.0,g:Float=1.0,b:Float=1.0)
		Self.text_selected_red=r
		Self.text_selected_green=g
		Self.text_selected_blue=b		
	End Method


	Method SetTextAlphaSelected:Void(alpha:Float=1.0)
		Self.text_selected_alpha=alpha
	End Method
	
	
	Method SetTextBlendSelected:Void(blend:Int)
		Self.text_selected_blend=blend
	End Method


	Method SetTextColorHighlight:Void(r:Float=1.0,g:Float=1.0,b:Float=1.0)
		Self.text_highlight_red=r
		Self.text_highlight_green=g
		Self.text_highlight_blue=b		
	End Method


	Method SetTextAlphaHighlight:Void(alpha:Float=1.0)
		Self.text_highlight_alpha=alpha
	End Method
	
	
	Method SetTextBlendHighlight:Void(blend:Int)
		Self.text_highlight_blend=blend
	End Method


	Method SetTextColorDown:Void(r:Float=1.0,g:Float=1.0,b:Float=1.0)
		Self.text_down_red=r
		Self.text_down_green=g
		Self.text_down_blue=b		
	End Method


	Method SetTextAlphaDown:Void(alpha:Float=1.0)
		Self.text_down_alpha=alpha
	End Method
	
	
	Method SetTextBlendDown:Void(blend:Int)
		Self.text_down_blend=blend
	End Method


	Method SetTextColor:Void(r:Float=1.0,g:Float=1.0,b:Float=1.0)
		Self.text_red=r
		Self.text_green=g
		Self.text_blue=b		
	End Method


	Method SetTextAlpha:Void(alpha:Float=1.0)
		Self.text_alpha=alpha
	End Method


	Method SetTextBlend:Void(blend:Int)
		Self.text_blend=blend
	End Method


	Method SetUpColor:Void(r:Float=1.0,g:Float=1.0,b:Float=1.0)
		Self.up_red=r
		Self.up_green=g
		Self.up_blue=b
		Self.up_color= New Color(r,g,b)
	End Method


	Method SetUpAlpha:Void(alpha:Float=1.0)
		Self.alpha=alpha
	End Method


	Method SetUpBlend:Void(blend:Int)
		Self.blend=blend
	End Method


	Method SetPosition:Void(x:Int,y:Int,button_obj:PButton=Null)
		If button_obj=Null Then button_obj=Self
		button_obj.x=x
		button_obj.y=y
	End Method


	Method SetSelected:Void(flag:Int)
		Self.button_selected=flag
	End Method


	Method SetName:Void(name:String)
		Self.name=name
	End Method
	
	
	Method SetImage:Void(button_up:Image=Null,button_down:Image=Null,button_highlight:Image=Null,button_selected:Image=Null)
		If button_up=Null
			Self.up_image=button_up_default
			Self.scalew=(Float(Self.w)/Float(Self.up_image.Width))
			Self.scaleh=(Float(Self.h)/Float(Self.up_image.Height))
		Else
			Self.up_image=button_up
			Self.scalew=(Float(Self.w)/Float(Self.up_image.Width))
			Self.scaleh=(Float(Self.h)/Float(Self.up_image.Height))
		Endif
		If button_down=Null
			Self.down_image=button_down_default
		Else
			Self.down_image=button_down
		Endif
		If button_highlight=Null
			Self.highlight_image=button_highlight_default
		Else
			Self.highlight_image=button_highlight
		Endif
		If button_selected=Null
			Self.selected_image=button_selected_default
		Else
			Self.selected_image=button_selected
		Endif
	End Method


	Method SetVisible:Void(flag:Int)
		Self.visible=flag
	End Method


	
Global mytext:= New String[500]
	
'Function Caret:String()
'	Return Chr( (95 * ( (Millisecs() / 500) Mod 2) ) ) '"_"
'End Function


'Function Caret2:Void(x:Int , y:Int)
'	If Millisecs()/500 Mod 2=0
'		'DrawLine(x + 1 , y , x + 1 , y + 12)
'	Endif
'End Function

	
Function LoadImages:Void(file:String)
	Local mx2_hack:String="asset::"'AppDir()+"assets/"
	Local newss:String
	Local mt:String=LoadString((mx2_hack+file))
	
	newss=mt
	Local cnt:Int=1
	newss.Trim()
	Local strend:Int=newss.Length-1		
	Local start:Int=0
	Local strcnt:Int
	
	'tfs:FileStream
	
'	Local ms:Stream
'	ms=FileStream.Open("./test.txt","r")
'	ms.WriteCString("TEST")
	
	
	'Write
	
'	Print "--------------------------------------- Parts -----------------------------"
	'ChangeDir("")
	'Local mx2_hack:String=AppDir()+"assets/" '"/home/moonbasealpha/Programming/monkey2/phoenix/assets/"
'	Print "---------------------------------->"+mx2_hack
	
	
	For Local ts:Int=1 To strend+1
		Local mys:String=newss.Slice(ts,(ts+1))
		If mys=String.FromChar(10)   Or ts=strend+1
			Local line:String=newss.Slice(start,ts)
			start=ts+1
'			Print line

			'If Lower(Mid(newss,1,12))="<background>" Then background=LoadImage(Mid(newss,13,Len(newss)))
			If (Mid(line,1,13)).ToLower()="<panel_right>" Then panel_1=Image.Load(mx2_hack+Mid(line,14,line.Length))',0,0)
			If (Mid(line,1,12)).ToLower()="<panel_left>" Then panel_2=Image.Load(mx2_hack+Mid(line,13,line.Length))',0,0)
			If (Mid(line,1,10)).ToLower()="<ship_box>" Then ship_view_bg=Image.Load(mx2_hack+Mid(line,11,line.Length))',0,0)
			If (Mid(line,1,11)).ToLower()="<button_up>" Then button_up_default=Image.Load(mx2_hack+Mid(line,12,line.Length))',0,0 )
			If (Mid(line,1,13)).ToLower()="<button_down>" Then button_down_default=Image.Load(mx2_hack+Mid(line,14,line.Length))',0,0 )

			If (Mid(line,1,18)).ToLower()="<button_highlight>" Then button_highlight_default=Image.Load(mx2_hack+Mid(line,19,line.Length))',0,0 )
			If (Mid(line,1,17)).ToLower()="<button_selected>" Then button_selected_default=Image.Load(mx2_hack+Mid(line,18,line.Length))',0,0 )

			If (Mid(line,1,19)).ToLower()="<slider_vert_thumb>" Then g_slider_vert_thumb_up=Image.Load(mx2_hack+Mid(line,20,line.Length))',0,0 )
			If (Mid(line,1,17)).ToLower()="<slider_vert_top>" Then g_slider_vert_top_up=Image.Load(mx2_hack+Mid(line,18,line.Length))',0,0 )
			If (Mid(line,1,20)).ToLower()="<slider_vert_bottom>" Then g_slider_vert_bottom_up=Image.Load(mx2_hack+Mid(line,21,line.Length))',0,0 )

			If (Mid(line,1,24)).ToLower()="<slider_vert_thumb_down>" Then g_slider_vert_thumb_down=Image.Load(mx2_hack+Mid(line,25,line.Length))',0,0 )
			If (Mid(line,1,22)).ToLower()="<slider_vert_top_down>" Then g_slider_vert_top_down=Image.Load(mx2_hack+Mid(line,23,line.Length))',0,0 )
			If (Mid(line,1,25)).ToLower()="<slider_vert_bottom_down>" Then g_slider_vert_bottom_down=Image.Load(mx2_hack+Mid(line,26,line.Length))',0,0 )
			If (Mid(line,1,29)).ToLower()="<slider_vert_thumb_highlight>" Then g_slider_vert_thumb_highlight=Image.Load(mx2_hack+Mid(line,30,line.Length))',0,0 )
			If (Mid(line,1,27)).ToLower()="<slider_vert_top_highlight>" Then g_slider_vert_top_highlight=Image.Load(mx2_hack+Mid(line,28,line.Length))',0,0 )
			If (Mid(line,1,30)).ToLower()="<slider_vert_bottom_highlight>" Then g_slider_vert_bottom_highlight=Image.Load(mx2_hack+Mid(line,31,line.Length))',0,0 )

			If (Mid(line,1,28)).ToLower()="<slider_vert_thumb_selected>" Then g_slider_vert_thumb_selected=Image.Load(mx2_hack+Mid(line,29,line.Length))',0,0 )
			If (Mid(line,1,26)).ToLower()="<slider_vert_top_selected>" Then g_slider_vert_top_selected=Image.Load(mx2_hack+Mid(line,27,line.Length))',0,0 )
			If (Mid(line,1,29)).ToLower()="<slider_vert_bottom_selected>" Then g_slider_vert_bottom_selected=Image.Load(mx2_hack+Mid(line,30,line.Length))',0,0 )

			If (Mid(line,1,22)).ToLower()="<slider_horz_thumb_up>" Then g_slider_horz_thumb_up=Image.Load(mx2_hack+Mid(line,23,line.Length))',0,0 )
			If (Mid(line,1,20)).ToLower()="<slider_horz_top_up>" Then g_slider_horz_top_up=Image.Load(mx2_hack+Mid(line,21,line.Length))',0,0 )
			If (Mid(line,1,23)).ToLower()="<slider_horz_bottom_up>" Then g_slider_horz_bottom_up=Image.Load(mx2_hack+Mid(line,24,line.Length))',0,0 )
			If (Mid(line,1,24)).ToLower()="<slider_horz_thumb_down>" Then g_slider_horz_thumb_down=Image.Load(mx2_hack+Mid(line,25,line.Length))',0,0 )
			If (Mid(line,1,22)).ToLower()="<slider_horz_top_down>" Then g_slider_horz_top_down=Image.Load(mx2_hack+Mid(line,23,line.Length))',0,0 )
			If (Mid(line,1,25)).ToLower()="<slider_horz_bottom_down>" Then g_slider_horz_bottom_down=Image.Load(mx2_hack+Mid(line,26,line.Length))',0,0 )
			If (Mid(line,1,29)).ToLower()="<slider_horz_thumb_highlight>" Then g_slider_horz_thumb_highlight=Image.Load(mx2_hack+Mid(line,30,line.Length))',0,0 )
			If (Mid(line,1,27)).ToLower()="<slider_horz_top_highlight>" Then g_slider_horz_top_highlight=Image.Load(mx2_hack+Mid(line,28,line.Length))',0,0 )
			If (Mid(line,1,30)).ToLower()="<slider_horz_bottom_highlight>" Then g_slider_horz_bottom_highlight=Image.Load(mx2_hack+Mid(line,31,line.Length))',0,0 )
			If (Mid(line,1,28)).ToLower()="<slider_horz_thumb_selected>" Then g_slider_horz_thumb_selected=Image.Load(mx2_hack+Mid(line,29,line.Length))',0,0 )
			If (Mid(line,1,26)).ToLower()="<slider_horz_top_selected>" Then g_slider_horz_top_selected=Image.Load(mx2_hack+Mid(line,27,line.Length))',0,0 )
			If (Mid(line,1,29)).ToLower()="<slider_horz_bottom_selected>" Then g_slider_horz_bottom_selected=Image.Load(mx2_hack+Mid(line,30,line.Length))',0,0 )


			If (Mid(line,1,15)).ToLower()="<slider_pannel>" Then g_slider_pannel=Image.Load(mx2_hack+Mid(line,16,line.Length))',0,0 )
			
			If (Mid(line,1,19)).ToLower()="<listbox_button_up>" Then g_listbox_button_up=Image.Load(mx2_hack+Mid(line,20,line.Length))',0,0 )
			If (Mid(line,1,21)).ToLower()="<listbox_button_down>" Then g_listbox_button_down=Image.Load(mx2_hack+Mid(line,22,line.Length))',0,0 )

			If (Mid(line,1,26)).ToLower()="<listbox_button_highlight>" Then g_listbox_button_highlight=Image.Load(mx2_hack+Mid(line,27,line.Length))',0,0 )
			If (Mid(line,1,25)).ToLower()="<listbox_button_selected>" Then g_listbox_button_selected=Image.Load(mx2_hack+Mid(line,26,line.Length))',0,0 )

			If (Mid(line,1,15)).ToLower()="<listbox_panel>" Then listbox_bg=Image.Load(mx2_hack+Mid(line,16,line.Length))',0,0)
			'If Lower(Mid(newss,1,19))="<listbox_slider_up>" Then slider_button_up=LoadImage(Mid(newss,20,Len(newss)))
			'If Lower(Mid(newss,1,21))="<listbox_slider_down>" Then slider_button_up=LoadImage(Mid(newss,22,Len(newss)))
			If (Mid(line,1,17)).ToLower()="<listbox_slider_>" Then sliderimage=Image.Load(mx2_hack+Mid(line,18,line.Length))
			If (Mid(line,1,18)).ToLower()="<button_color_red>" Then button_r=Float( (mx2_hack+Mid(line,19,line.Length)))'.ToInt()
			If (Mid(line,1,19)).ToLower()="<button_color_blue>" Then button_b=Float( (mx2_hack+Mid(line,20,line.Length)) )'.ToInt()
			If (Mid(line,1,20)).ToLower()="<button_color_green>" Then button_g=Float( (mx2_hack+Mid(line,21,line.Length)))'.ToInt()
			'If Lower(Mid(newss,1,18))="<slider_color_red>" Then slider_r=LoadImage(Mid(newss,19,Len(newss)))
			'If Lower(Mid(newss,1,19))="<slider_color_blue>" Then slider_g=LoadImage(Mid(newss,20,Len(newss)))
			'If Lower(Mid(newss,1,30))="<slider_color_green>" Then slider_b=LoadImage(Mid(newss,21,Len(newss)))
			'If Lower(Mid(newss,1,25))="<slider_button_color_red>" Then slider_button_r=LoadImage(Mid(newss,26,Len(newss)))
			'If Lower(Mid(newss,1,26))="<slider_button_color_blue>" Then slider_button_g=LoadImage(Mid(newss,27,Len(newss)))
			'If Lower(Mid(newss,1,27))="<slider_button_color_green>" Then slider_button_b=LoadImage(Mid(newss,28,Len(newss)))
			'If (Mid(line,1,21)).ToLower()="<listbox_button_down>" And button_down_2<>Null Then Print ">>>>>"+ Mid(line,22,line.Length())
		Endif
	Next
			
	'CHANGE ** Here for testing
'	If g_slider_vert_top_up<>Null Then g_slider_vert_top_down=g_slider_vert_top_up
'	If g_slider_vert_thumb_up<>Null Then g_slider_vert_thumb_down=g_slider_vert_thumb_up
'	If g_slider_vert_bottom_up<>Null Then g_slider_vert_bottom_down=g_slider_vert_bottom_up
			
	'If button_highlight_default=Null Then EndApp
End Function




Function Mid:String( str:String,pos:Int,size:Int=-1 )
	If pos>str.Length Return ""
	pos-=1
	If( size<0 ) Return str.Slice(pos,str.Length)'[pos..]
	If pos<0 
		size=size+pos 
		pos=0
	Endif
	If pos+size>str.Length 
		size=str.Length-pos
	Endif
	Return (str.Slice(pos,(pos+size)))'[pos..pos+size]
End Function




Function SetBlendMode(canvas:Canvas,blend:Int)
'Print blend
	If blend=1 Then canvas.BlendMode=BlendMode.Opaque
	If blend=2 Then canvas.BlendMode=BlendMode.Alpha
	If blend=3 Then canvas.BlendMode=BlendMode.Additive
	If blend=4 Then canvas.BlendMode=BlendMode.Multiply
	'Return Null
End Function

End Class



