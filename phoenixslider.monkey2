'****************************************************************************
'* Alien Phoenix Gaming Framework							  
'* Copyright (c) 2018 Richard R Betson
'* Author - Richard R Betson
'* 
'* Language: Monkey2
'* Targets: Android, Windows, Linux, Emscripten, IOS
'* Title: Phoenix Slider
'* Licence: zlib/libpng License (Zlib) - https://opensource.org/licenses/Zlib
'* Version: 0.7
'****************************************************************************
Namespace phoenixslider


Class PSlider 'Final
	Field window:PWindow
	Field x:Int
	Field y:Int
	Field w:Int
	Field h:Int
	Field bw:Int
	Field bh:Int
	Field blend:Int
	Field alpha:Float
	Field r:Float,g:Float,b:Float
	Field image_scalew:Float
	Field image_scaleh:Float
	Field slider_image:Image
	Field slider_up_button:Int
	Field slider_down_button:Int
'	Field slider_highlight_button:Int
'	Field slider_selected_button:Int
	Field slider_button:Int
	Field slider_thumb_button_obj:PButton
	Field slider_top_button_obj:PButton
	Field slider_bottom_button_obj:PButton
	
	Field range:Int=99
	Field max_range:Int=100
	'Field slider_id:Int
	Field visible:Int=True
	Field alignment:Int=1
	Field slider_step_rate:Int=1
	Global slider_delta:Int
	Global old_mousez:Float
	

	Method New()
	End Method


	Method New(x:Int,y:Int,w:Int,h:Int,bw:Int,bh:Int,alignment:Int=1,window:PWindow=Null)
	'	Local slider:Slider=New Slider
		Local p_button:PButton=New PButton
		
		Self.window=window
		'slider.slider_id=id
		Self.x=x
		Self.y=y
		Self.w=w
		Self.h=h
		Self.alpha=1.0
		Self.r=1.0
		Self.g=1.0
		Self.b=1.0
		Self.bw=bw
		Self.bh=bh
		Self.alignment=alignment
		
Local alpha:Float=1.0
Local r:Float=1.0
Local g:Float=1.0
Local b:Float=1.0

		If alignment=2
			Self.image_scalew=(Float(w)/Float(sliderimage.Width))
			Self.image_scaleh=(Float(bh)/Float(sliderimage.Height))
		Else
			Self.image_scalew=(Float(bw)/Float(sliderimage.Width))
			Self.image_scaleh=(Float(h)/Float(sliderimage.Height))
		Endif

		Self.slider_image=g_slider_pannel
		g_slider_vert_thumb_up.Handle=New Vec2f(0,0)'SetHandle(0,0)
		g_slider_vert_top_up.Handle=New Vec2f(0,0)'SetHandle(0,0)
		g_slider_vert_bottom_up.Handle=New Vec2f(0,0)'SetHandle(0,0)
		g_slider_horz_thumb_up.Handle=New Vec2f(0,0)'SetHandle(0,0)
		g_slider_horz_top_up.Handle=New Vec2f(0,0)'SetHandle(0,0)
		g_slider_horz_bottom_up.Handle=New Vec2f(0,0)'SetHandle(0,0)		

'		slider_vert_thumb.SetHandle(0,0)
'		slider_vert_top.SetHandle(0,0)
'		slider_vert_bottom.SetHandle(0,0)
'		slider_horz_thumb.SetHandle(0,0)
'		slider_horz_top.SetHandle(0,0)
'		slider_horz_bottom.SetHandle(0,0)		
		Self.slider_image.Handle=New Vec2f(0,0)'SetHandle(0,0)
		
		If alignment=1
			Local tmpb:PButton=New PButton
			tmpb=New PButton("",x,y,bw,bh,1,True,window,Null)
			tmpb.SetImage(g_slider_vert_top_up,g_slider_vert_top_down,g_slider_vert_top_highlight,g_slider_vert_top_selected)
			tmpb.SetUpColor(r,g,b)
			tmpb.SetUpAlpha(alpha)
			slider_Button_List.AddLast(tmpb)
			tmpb.button_state_override=True
			Self.slider_top_button_obj=tmpb
			
			tmpb=New PButton("",x,y+(h-bh),bw,bh,1,True,window,Null)
			tmpb.SetImage(g_slider_vert_bottom_up,g_slider_vert_bottom_down,g_slider_vert_bottom_highlight,g_slider_vert_bottom_selected)
			tmpb.SetUpColor(r,g,b)
			tmpb.SetUpAlpha(alpha)
			slider_Button_List.AddLast(tmpb)
			'tmpb.slider_id=id
			tmpb.button_state_override=True
			Self.slider_bottom_button_obj=tmpb
			
			tmpb=New PButton("",x,y+bh,bw,bh,1,True,window,Null)
			tmpb.SetImage(g_slider_vert_thumb_up,g_slider_vert_thumb_down,g_slider_vert_thumb_highlight,g_slider_vert_thumb_selected)
			tmpb.SetUpColor(r,g,b)
			tmpb.SetUpAlpha(alpha)
			slider_Button_List.AddLast(tmpb)
			'tmpb.slider_id=id
			tmpb.button_state_override=True
			Self.slider_thumb_button_obj=tmpb
		Else
			Local tmpb:PButton=New PButton
			tmpb=New PButton("",x,y,bw,bh,1,True,window,Null)
			tmpb.SetImage(g_slider_horz_top_up,g_slider_horz_top_down,g_slider_horz_top_highlight,g_slider_horz_top_selected)
			tmpb.SetUpColor(r,g,b)
			tmpb.SetUpAlpha(alpha)
			slider_Button_List.AddLast(tmpb)
			'tmpb.slider_id=id
			tmpb.button_state_override=True
			Self.slider_top_button_obj=tmpb
			
			tmpb=New PButton("",x+w-bw,y,bw,bh,1,True,window,Null)
			tmpb.SetImage(g_slider_horz_bottom_up,g_slider_horz_bottom_down,g_slider_horz_bottom_highlight,g_slider_horz_bottom_selected)
			tmpb.SetUpColor(r,g,b)
			tmpb.SetUpAlpha(alpha)
			slider_Button_List.AddLast(tmpb)
			'tmpb.slider_id=id
			tmpb.button_state_override=True
			Self.slider_bottom_button_obj=tmpb
			
			tmpb=New PButton("",x+1+bw,y,bw,bh,1,True,window,Null)
			tmpb.SetImage(g_slider_horz_thumb_up,g_slider_horz_thumb_down,g_slider_horz_thumb_highlight,g_slider_horz_thumb_selected)
			tmpb.SetUpColor(r,g,b)
			tmpb.SetUpAlpha(alpha)
			slider_Button_List.AddLast(tmpb)
			'tmpb.slider_id=id
			tmpb.button_state_override=True
			Self.slider_thumb_button_obj=tmpb
		Endif		
		
		'global index
'		Self.slider_up_button=ButtonSliderIndex
'		ButtonSliderIndex=ButtonSliderIndex+1
'		Self.slider_down_button=ButtonSliderIndex
'		ButtonSliderIndex=ButtonSliderIndex+1
'		Self.slider_button=ButtonSliderIndex
'		ButtonSliderIndex=ButtonSliderIndex+1
		Self.range=0
		Slider_List.AddLast(Self)
		window.Window_Slider_List.AddLast(Self)
		
	'	Return slider

	End Method








	Method CreateSlider:PSlider(x:Int,y:Int,w:Int,h:Int,bw:Int,bh:Int,alignment:Int=1,window:PWindow=Null)
		Local slider:PSlider=New PSlider
		Local p_button:PButton=New PButton
		
		slider.window=window
		'slider.slider_id=id
		slider.x=x
		slider.y=y
		slider.w=w
		slider.h=h
		slider.alpha=1.0
		slider.r=1.0
		slider.g=1.0
		slider.b=1.0
		slider.bw=bw
		slider.bh=bh
		slider.alignment=alignment
		
Local alpha:Float=1.0
Local r:Float=1.0
Local g:Float=1.0
Local b:Float=1.0

		If alignment=2
			slider.image_scalew=(Float(w)/Float(sliderimage.Width))
			slider.image_scaleh=(Float(bh)/Float(sliderimage.Height))
		Else
			slider.image_scalew=(Float(bw)/Float(sliderimage.Width))
			slider.image_scaleh=(Float(h)/Float(sliderimage.Height))
		Endif

		slider.slider_image=g_slider_pannel
		g_slider_vert_thumb_up.Handle=New Vec2f(0,0)'SetHandle(0,0)
		g_slider_vert_top_up.Handle=New Vec2f(0,0)'SetHandle(0,0)
		g_slider_vert_bottom_up.Handle=New Vec2f(0,0)'SetHandle(0,0)
		g_slider_horz_thumb_up.Handle=New Vec2f(0,0)'SetHandle(0,0)
		g_slider_horz_top_up.Handle=New Vec2f(0,0)'SetHandle(0,0)
		g_slider_horz_bottom_up.Handle=New Vec2f(0,0)'SetHandle(0,0)		

'		slider_vert_thumb.SetHandle(0,0)
'		slider_vert_top.SetHandle(0,0)
'		slider_vert_bottom.SetHandle(0,0)
'		slider_horz_thumb.SetHandle(0,0)
'		slider_horz_top.SetHandle(0,0)
'		slider_horz_bottom.SetHandle(0,0)		
		slider.slider_image.Handle=New Vec2f(0,0)'SetHandle(0,0)
		
		If alignment=1
			Local tmpb:PButton=New PButton
			tmpb=New PButton("",x,y,bw,bh,1,True,window,Null)
			tmpb.SetImage(g_slider_vert_top_up,g_slider_vert_top_down,g_slider_vert_top_highlight,g_slider_vert_top_selected)
			tmpb.SetUpColor(r,g,b)
			tmpb.SetUpAlpha(alpha)
			tmpb.button_state_override=True
			slider.slider_top_button_obj=tmpb
			slider_Button_List.AddLast(tmpb)
			
			tmpb=New PButton("",x,y+(h-bh),bw,bh,1,True,window,Null)
			tmpb.SetImage(g_slider_vert_bottom_up,g_slider_vert_bottom_down,g_slider_vert_bottom_highlight,g_slider_vert_bottom_selected)
			tmpb.SetUpColor(r,g,b)
			tmpb.SetUpAlpha(alpha)
			'tmpb.slider_id=id
			tmpb.button_state_override=True
			slider.slider_bottom_button_obj=tmpb
			slider_Button_List.AddLast(tmpb)
			
			tmpb=New PButton("",x,y+bh,bw,bh,1,True,window,Null)
			tmpb.SetImage(g_slider_vert_thumb_up,g_slider_vert_thumb_down,g_slider_vert_thumb_highlight,g_slider_vert_thumb_selected)
			tmpb.SetUpColor(r,g,b)
			tmpb.SetUpAlpha(alpha)
			'tmpb.slider_id=id
			tmpb.button_state_override=True
			slider.slider_thumb_button_obj=tmpb
			slider_Button_List.AddLast(tmpb)
			
		Else
			Local tmpb:PButton=New PButton
			tmpb=New PButton("",x,y,bw,bh,1,True,window,Null)
			tmpb.SetImage(g_slider_vert_top_up,g_slider_vert_top_down,g_slider_vert_top_highlight,g_slider_vert_top_selected)
			tmpb.SetUpColor(r,g,b)
			tmpb.SetUpAlpha(alpha)
			slider_Button_List.AddLast(tmpb)
			'tmpb.slider_id=id
			tmpb.button_state_override=True
			slider.slider_top_button_obj=tmpb
			
			tmpb=New PButton("",x+w-bw,y,bw,bh,1,True,window,Null)
			tmpb.SetImage(g_slider_vert_bottom_up,g_slider_vert_bottom_down,g_slider_vert_bottom_highlight,g_slider_vert_bottom_selected)
			tmpb.SetUpColor(r,g,b)
			tmpb.SetUpAlpha(alpha)
			slider_Button_List.AddLast(tmpb)
			'tmpb.slider_id=id
			tmpb.button_state_override=True
			slider.slider_bottom_button_obj=tmpb
			
			tmpb=New PButton("",x+1+bw,y,bw,bh,1,True,window,Null)
			tmpb.SetImage(g_slider_vert_thumb_up,g_slider_vert_thumb_down,g_slider_vert_thumb_highlight,g_slider_vert_thumb_selected)
			tmpb.SetUpColor(r,g,b)
			tmpb.SetUpAlpha(alpha)
			slider_Button_List.AddLast(tmpb)
			'tmpb.slider_id=id
			tmpb.button_state_override=True
			slider.slider_thumb_button_obj=tmpb
		Endif		
		
		'global index
'		slider.slider_up_button=ButtonSliderIndex
'		ButtonSliderIndex=ButtonSliderIndex+1
'		slider.slider_down_button=ButtonSliderIndex
'		ButtonSliderIndex=ButtonSliderIndex+1
'		slider.slider_button=ButtonSliderIndex
'		ButtonSliderIndex=ButtonSliderIndex+1
		slider.range=0
		Slider_List.AddLast(slider)
		window.Window_Slider_List.AddLast(slider)
		
		Return slider

	End Method


	Method Update:Int(mx:Int,my:Int,window:PWindow=Null,winx:Int=0,winy:Int=0,window_selected:Int=False)
		Local window_move_flag:Int=False
		'For Local p_slider:Slider=Eachin Slider_List
		Local p_slider:PSlider=Self
			If p_slider.window=window And p_slider.visible=True And window_selected=False 'Or p_slider.window=Null And window_selected=False And p_slider.visible=True
				p_slider.window._canvas.PopMatrix()
				p_slider.window._canvas.PushMatrix()
				'p_slider.window._canvas.Transform(p_slider.image_scalew,0,0,p_slider.image_scaleh,p_slider.x+winx,p_slider.y+winy)

				Local myMatrix:=New AffineMat3f
				myMatrix.i.x=p_slider.image_scalew
				myMatrix.j.y=p_slider.image_scaleh
				myMatrix.t.x=p_slider.x'+winx
				myMatrix.t.y=p_slider.y'+winy
				p_slider.window._canvas.Matrix*=myMatrix   'transform current matrix by myMatrix.


				p_slider.window._canvas.Alpha=p_slider.alpha'SetAlpha(p_slider.alpha)
				p_slider.window._canvas.DrawImage(p_slider.slider_image,0,0)
				p_slider.window._canvas.Alpha=1'SetAlpha(1)
				p_slider.window._canvas.PopMatrix()
				p_slider.window._canvas.PushMatrix()
				p_slider.window._canvas.Scale(1,1)
			Endif
	
			If p_slider.window=window  And window_selected=True 
				p_slider.window._canvas.Color=New Color(1,1,1)'SetColor(1,1,1)' 255,255,255 '--------FIX THIS should be field int's
				p_slider.slider_image.Handle=New Vec2f(0,0)'SetHandle(0,0)
				If  p_slider.visible=True 
					p_slider.window._canvas.PopMatrix()
					p_slider.window._canvas.PushMatrix()
					'p_slider.window._canvas.Transform(p_slider.image_scalew,0,0,p_slider.image_scaleh,p_slider.x+winx,p_slider.y+winy)'0,0)

				Local myMatrix:=New AffineMat3f
				myMatrix.i.x=p_slider.image_scalew
				myMatrix.j.y=p_slider.image_scaleh
				myMatrix.t.x=p_slider.x'+winx
				myMatrix.t.y=p_slider.y'+winy
				p_slider.window._canvas.Matrix*=myMatrix   'transform current matrix by myMatrix.


					p_slider.window._canvas.Alpha=p_slider.alpha'SetAlpha(p_slider.alpha)
					p_slider.window._canvas.DrawImage(p_slider.slider_image,0,0)
					p_slider.window._canvas.Alpha=1'SetAlpha(1)
					p_slider.window._canvas.PopMatrix()
					p_slider.window._canvas.PushMatrix()
					p_slider.window._canvas.Scale(1,1)
					'0 should be replaced with mousez
					Local mz:Int=0,mz2:Float
					
					If window_selected=True Or window=Null
						If ( silder_forced_focus=Null Or (silder_forced_focus<>Null And silder_forced_focus=p_slider))'p_slider.slider_id) )
							If silder_user_forced_focus<>Null And silder_user_forced_focus=p_slider'p_slider.slider_id 
								mz2=old_mousez-mz
								p_slider.range=p_slider.range+(mz2*(5) )
								old_mousez=mz
							Else
								If silder_user_forced_focus=Null
								mz2=old_mousez-mz
								p_slider.range=p_slider.range+(mz2*(5) )
								old_mousez=mz
							Endif
						Endif
					Endif 
				'Endif
				
				'----------------------------------------
				'Checks for mouse in slider area
				'and moves thumb if ture
				'----------------------------------------
				If window._window_resize_flag=False
				If Mouse.ButtonDown(MouseButton.Left)'MouseDown(MOUSE_LEFT)
					If p_slider.alignment=1					
						If my < p_slider.slider_thumb_button_obj.y+window._window_y And my > p_slider.y + p_slider.slider_top_button_obj.h + window._window_y And mx < p_slider.x+p_slider.w+window._window_x And mx > p_slider.x+window._window_x
							If slider_delta<Millisecs()
								If p_slider.range>3 Then p_slider.range=p_slider.range-(p_slider.slider_step_rate*2)
								If p_slider.range<=3 Then  p_slider.range=0
								p_slider.slider_thumb_button_obj.SetPosition(p_slider.x,p_slider.y+p_slider.bh+((p_slider.h- (p_slider.bh*3))*(Float(p_slider.range) / Float(p_slider.max_range) )) )
								slider_delta=Millisecs()+200
							'	window_move_flag=True
							g_move_window_overide=True
							Endif
						Endif
						If my > p_slider.slider_thumb_button_obj.y+p_slider.slider_thumb_button_obj.h+window._window_y And my < p_slider.slider_bottom_button_obj.y+window._window_y And mx < p_slider.x+p_slider.w+window._window_x And mx > p_slider.x+window._window_x
							If slider_delta<Millisecs()
								If p_slider.range<=p_slider.max_range Then p_slider.range=p_slider.range+(p_slider.slider_step_rate*2)
								If p_slider.range>p_slider.max_range Then  p_slider.range=p_slider.max_range
								p_slider.slider_thumb_button_obj.SetPosition(p_slider.x,p_slider.y+p_slider.bh+((p_slider.h- (p_slider.bh*3))*(Float(p_slider.range) / Float(p_slider.max_range) )) )
								slider_delta=Millisecs()+200
							'	window_move_flag=True
							g_move_window_overide=True
							Endif
						Endif
					Else
						If mx < p_slider.slider_thumb_button_obj.x+window._window_x And mx > p_slider.x + p_slider.slider_top_button_obj.w + window._window_x And my > p_slider.y+window._window_y And my < p_slider.y+p_slider.h+window._window_y
							If slider_delta<Millisecs()
								If p_slider.range>3 Then p_slider.range=p_slider.range-(p_slider.slider_step_rate*2)
								If p_slider.range<=3 Then  p_slider.range=0
								p_slider.slider_thumb_button_obj.SetPosition(p_slider.x+p_slider.bw+((p_slider.w- (p_slider.bw*3))*(Float(p_slider.range) / Float(p_slider.max_range) )),p_slider.y )
								slider_delta=Millisecs()+200
							'	window_move_flag=True
							g_move_window_overide=True
							Endif
						Endif
						If mx > p_slider.slider_thumb_button_obj.x+p_slider.slider_thumb_button_obj.w+window._window_x And mx < p_slider.x + p_slider.slider_bottom_button_obj.x + window._window_x And my > p_slider.y+window._window_y And my < p_slider.y+p_slider.h+window._window_y
							If slider_delta<Millisecs()
								If p_slider.range<=p_slider.max_range Then p_slider.range=p_slider.range+(p_slider.slider_step_rate*2)
								If p_slider.range>p_slider.max_range Then  p_slider.range=p_slider.max_range
								p_slider.slider_thumb_button_obj.SetPosition(p_slider.x+p_slider.bw+((p_slider.w- (p_slider.bw*3))*(Float(p_slider.range) / Float(p_slider.max_range) )),p_slider.y )
								slider_delta=Millisecs()+200
							'	window_move_flag=True
							g_move_window_overide=True
							Endif
						Endif				
					Endif
				Endif
				'*----------------------




				
				For Local p_button:PButton=Eachin slider_Button_List 
				
					If (p_button.window=window And window_selected=True )
						If silder_forced_focus=Null Or (silder_forced_focus<>Null And silder_forced_focus=p_slider)'=p_slider.slider_id)
							If p_slider.alignment=1			
								If mz<>0.0  Then p_button.SetPosition(p_slider.x,p_slider.y+p_slider.bh+((p_slider.h- (p_slider.bh*3))*(Float(p_slider.range) / Float(p_slider.max_range) )) )
							Else
								If mz<>0.0  Then p_button.SetPosition(p_slider.x+p_slider.bw+((p_slider.w- (p_slider.bw*3))*(Float(p_slider.range) / Float(p_slider.max_range) )),p_slider.y )
							Endif
							If Mouse.ButtonDown(MouseButton.Left)=False  Then  slider_override_obj=Null'slider_override_button_id=0 
							If p_slider.range<1 Then  p_slider.range=0
							If p_slider.range>p_slider.max_range Then  p_slider.range=p_slider.max_range
								If  p_button.button_down=True 
									If p_slider.alignment=1
										Select p_button'.id 
											Case p_slider.slider_top_button_obj
											If slider_delta<Millisecs()
												If p_slider.range>0 Then p_slider.range=p_slider.range-p_slider.slider_step_rate'1
												If p_slider.range<1 Then  p_slider.range=0
												p_slider.slider_thumb_button_obj.SetPosition(p_slider.x,p_slider.y+p_slider.bh+((p_slider.h- (p_slider.bh*3))*(Float(p_slider.range) / Float(p_slider.max_range) )) )
												slider_delta=Millisecs()+100
											Endif
												 p_button.button_down=False
											Case p_slider.slider_bottom_button_obj
												If slider_delta<Millisecs()
													If p_slider.range<=p_slider.max_range Then p_slider.range=p_slider.range+p_slider.slider_step_rate'1
													If p_slider.range>p_slider.max_range Then  p_slider.range=p_slider.max_range
													p_slider.slider_thumb_button_obj.SetPosition(p_slider.x,p_slider.y+p_slider.bh+((p_slider.h- (p_slider.bh*3))*(Float(p_slider.range) / Float(p_slider.max_range) )) )
													slider_delta=Millisecs()+100
												Endif
												p_button.button_down=False
											Case p_slider.slider_thumb_button_obj
												Local posy:Int=(my-(p_slider.bh/2))
												If Mouse.ButtonDown(MouseButton.Left)=True
													If posy<( (p_slider.y+winy + p_slider.h) - (p_slider.bh*2)) And posy>(p_slider.y+winy+p_slider.bh)-5
														p_slider.range=(p_slider.max_range)*(( Float(posy)-Float(p_slider.y+winy+p_slider.bh)) / Float(p_slider.h-(p_slider.bh*3.1)) ) '+p_slider.bh'-(p_slider.bh*2)
														'slider_override_button_id=p_button.id 
														slider_override_obj=p_button
														p_button.SetPosition(p_slider.x,p_slider.y+p_slider.bh+((p_slider.h-(p_slider.bh*3))*(Float(p_slider.range) / Float(p_slider.max_range) )) )
													Endif
												Endif
												p_button.button_down=False
												p_button.button_selected=False
											End Select
										Endif
											
										If p_slider.alignment=2
											
											Select p_button'.id 
											
											Case p_slider.slider_top_button_obj
												If slider_delta<Millisecs()
													If p_slider.range>0 Then p_slider.range=p_slider.range-p_slider.slider_step_rate'5
													If p_slider.range<1 Then  p_slider.range=0
													p_slider.slider_thumb_button_obj.SetPosition(p_slider.x+p_slider.bw+((p_slider.w- (p_slider.bw*3))*(Float(p_slider.range) / Float(p_slider.max_range) )),p_slider.y )
														slider_delta=Millisecs()+100
												Endif
												 p_button.button_down=False
											Case p_slider.slider_bottom_button_obj
												If slider_delta<Millisecs()
													If p_slider.range<=p_slider.max_range Then p_slider.range=p_slider.range+p_slider.slider_step_rate'5
													If p_slider.range>p_slider.max_range Then  p_slider.range=p_slider.max_range
													p_slider.slider_thumb_button_obj.SetPosition(p_slider.x+p_slider.bw+((p_slider.w- (p_slider.bw*3))*(Float(p_slider.range) / Float(p_slider.max_range) )),p_slider.y )
													slider_delta=Millisecs()+100
												Endif
												p_button.button_down=False
											Case p_slider.slider_thumb_button_obj
											Local posx:Int=(mx-(p_slider.bw/2))
											If Mouse.ButtonDown(MouseButton.Left)=True
												'Print "Slider 2"
												If posx<( (p_slider.x+winx + p_slider.w) - (p_slider.bw*2)) And posx>(p_slider.x+winx+p_slider.bw)-5
													p_slider.range=(p_slider.max_range)*(( Float(posx)-Float(p_slider.x+winx+p_slider.bw)) / Float(p_slider.w-(p_slider.bw*3.1)) ) '+p_slider.bh'-(p_slider.bh*2)
													'slider_override_button_id=p_button.id 
													slider_override_obj=p_button
													p_button.SetPosition(p_slider.x+p_slider.bw+((p_slider.w-(p_slider.bw*3))*(Float(p_slider.range) / Float(p_slider.max_range) )),p_slider.y )
												Endif
											Endif
											p_button.button_down=False
											p_button.button_selected=False
										End Select
									Endif
								Endif
							Endif
						Endif			
					Next
					Endif
					Endif
				Endif		
			Endif
		'Next
		window._canvas.PopMatrix()
		window._canvas.PushMatrix()		
		silder_forced_focus=Null 'resets forced focus of slider	
		If window_move_flag=True
			Return True
		Else
			Return False
		Endif
		Return False
	End Method


	Method GetRange:Int(slider_obj:PSlider=Null)
		If slider_obj=Null Then slider_obj=Self
		Return slider_obj.range
		Return False
	End Method
	

	Method GetRangeMax:Int(slider_obj:PSlider=Null)
		If slider_obj=Null Then slider_obj=Self
		Return slider_obj.max_range
		Return False
	End Method


	Method GetThumbStepRate:Int()
		Return Self.slider_step_rate
	End Method


	Method SetUpAlpha(alpha:Float)
		slider_thumb_button_obj.alpha=alpha
		slider_top_button_obj.alpha=alpha
		slider_bottom_button_obj.alpha=alpha
	End Method
	
	
	Method SetUpBlend:Void(blend:Int)
		slider_thumb_button_obj.blend=blend
		slider_top_button_obj.blend=blend
		slider_bottom_button_obj.blend=blend	
	End Method
	
	
	Method SetUpColor:Void(red:Float,green:Float,blue:Float)
		slider_thumb_button_obj.SetUpColor(red,green,blue)
		slider_top_button_obj.SetUpColor(red,green,blue)
		slider_bottom_button_obj.SetUpColor(red,green,blue)		
	End Method

	Method SetDownAlpha:Void(alpha:Float)
		slider_thumb_button_obj.down_alpha=alpha
		slider_top_button_obj.down_alpha=alpha
		slider_bottom_button_obj.down_alpha=alpha
	End Method
	
	
	Method SetDownBlend:Void(blend:Int)
		slider_thumb_button_obj.down_blend=blend
		slider_top_button_obj.down_blend=blend
		slider_bottom_button_obj.down_blend=blend	
	End Method
	
	
	Method SetDownColor:Void(red:Float,green:Float,blue:Float)
		slider_thumb_button_obj.SetDownColor(red,green,blue)
		slider_top_button_obj.SetDownColor(red,green,blue)
		slider_bottom_button_obj.SetDownColor(red,green,blue)		
	End Method
	
	
	Method SetHighlightAlpha:Void(alpha:Float)
		slider_thumb_button_obj.highlight_alpha=alpha
		slider_top_button_obj.highlight_alpha=alpha
		slider_bottom_button_obj.highlight_alpha=alpha	
	End Method


	Method SetHighlightBlend:Void(blend:Int)
		slider_thumb_button_obj.highlight_blend=blend
		slider_top_button_obj.highlight_blend=blend
		slider_bottom_button_obj.highlight_blend=blend		
	End Method


	Method SetHighlightColor:Void(red:Float,green:Float,blue:Float)
		slider_thumb_button_obj.SetHighlightColor(red,green,blue)
		slider_top_button_obj.SetHighlightColor(red,green,blue)
		slider_bottom_button_obj.SetHighlightColor(red,green,blue)			
	End Method


	Method SetSelectedAlpha:Void(alpha:Float)
		slider_thumb_button_obj.selected_alpha=alpha
		slider_top_button_obj.selected_alpha=alpha
		slider_bottom_button_obj.selected_alpha=alpha		
	End Method
	
	
	Method SetSelectedBlend(blend:Int)
		slider_thumb_button_obj.selected_blend=blend
		slider_top_button_obj.selected_blend=blend
		slider_bottom_button_obj.selected_blend=blend			
	End Method
	
	
	Method SetSelectedColor:Void(red:Float,green:Float,blue:Float)
		slider_thumb_button_obj.SetSelectedColor(red,green,blue)
		slider_top_button_obj.SetSelectedColor(red,green,blue)
		slider_bottom_button_obj.SetSelectedColor(red,green,blue)			
	End Method

	
	Method SetThumbStepRate:Void(rate:Int)
		Self.slider_step_rate=rate
	End Method
	

	Method SetPosition:Void(x:Int,y:Int,w:Int=0,h:Int=0,slider_obj:PSlider=Null)
		'------------------------------------------------------------------
		'W and H are optional and use null or zero to keep current settings
		'------------------------------------------------------------------
		Local p_slider:PSlider=Self
		Local offy:Int=y-p_slider.y,old_sliderh:Int
		p_slider.x=x
		p_slider.y=y
		If h>0
			old_sliderh=p_slider.h
			p_slider.h=h
			p_slider.image_scaleh=(Float(h)/Float(p_slider.slider_image.Height))
		Endif
		For Local p_button:PButton=Eachin slider_Button_List 
			If p_button=p_slider.slider_top_button_obj'.id =p_slider.slider_up_button
				p_button.x=x
				p_button.y=p_button.y+offy
			Endif
			If p_button=p_slider.slider_thumb_button_obj'.id =p_slider.slider_down_button
				p_button.x=x
				p_button.y=p_button.y+offy
				If h>0
					p_button.y=p_button.y+(h-old_sliderh)
					p_button.SetPosition(p_slider.x,p_slider.y+p_slider.bh+((p_slider.h- (p_slider.bh*3))*(Float(p_slider.range) / Float(p_slider.max_range) )) )
				Endif
			Endif
			If p_button=p_slider.slider_bottom_button_obj 'And h=0'.id =p_slider.slider_button And h=0
				p_button.x=x
				p_button.y=(y+h)-p_button.h'p_button.y+offy
			Endif
		Next
	End Method

		
	Method SetRange:Void(range:Int)
		Self.max_range=range
	End Method


	'Need to add thumb object handle instead of pbutton2
	Method SetThumb:Void(range:Int)
		Self.range=range
		'Local p_button2:PButton=New PButton
		If Self.alignment=1
			Self.slider_thumb_button_obj.SetPosition(Self.x,Self.y+Self.bh+((Self.h- (Self.bh*3))*(Float(Self.range) / Float(Self.max_range) )) )
			'Print range
		Else
			Self.slider_thumb_button_obj.SetPosition(Self.x+Self.bw+((Self.w- (Self.bw*3))*(Float(Self.range) / Float(Self.max_range) )),Self.y )				
		Endif
	End Method

	
	Method SetFocus:Void()
		silder_user_forced_focus=Self'id
	End Method


	Method DestroySlider:Void()
		Slider_List.Remove(Self)
		Self.window.Window_Slider_List.Remove(Self)
	End Method


	Method HideSlider:Void()
		Self.slider_top_button_obj.SetVisible(False)
		Self.slider_bottom_button_obj.SetVisible(False)
		Self.slider_thumb_button_obj.SetVisible(False)
		Self.visible=False
		slider_override_obj=Null
	End Method


	Method ShowSlider:Void()
		Self.slider_top_button_obj.SetVisible(True)
		Self.slider_bottom_button_obj.SetVisible(True)
		Self.slider_thumb_button_obj.SetVisible(True)
		Self.visible=True
	End Method	
	
End Class
