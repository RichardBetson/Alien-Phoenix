'****************************************************************************
'* Alien Phoenix Gaming Framework							  
'* Copyright (c) 2018 Richard R Betson
'* Author - Richard R Betson
'* 
'* Language: Monkey2
'* Targets: Android, Windows, Linux, Emscripten, IOS
'* Title: Phoenix Listbox
'* Licence: zlib/libpng License (Zlib) - https://opensource.org/licenses/Zlib
'* Version: 0.7
'****************************************************************************
Namespace phoenixlistbox

Class PListBoxElement
	Field listbox_object:PListBox
	Field button_handle:PButton
	Field button_name:String
End Class



Class PListBox' Final

Field window:PWindow
Field id:Int
Field index:Int
Field x:Int
Field y:Int
Field w:Int
Field h:Int
Field r:Float=1.0
Field g:Float=1.0
Field b:Float=1.0
Field justify:Int=1
Field listbox_image:Image
Field listbox_Image_scalew:Float
Field listbox_Image_scaleh:Float
Field listbox_button_sliderw:Int=30
Field listbox_button_sliderh:Int=30
Field alpha:Float
Field visible:Int=True
Field SLIDERCONST:Int
Field current_selected_element:PListBoxElement

Field slider_button_list:=New List<PListBoxElement>

Field listbox_button_index_Count:Int 	'total buttons in listbox
Field listbox_selected_button:PButton		'last selected button in listbox
Field sliderrange:Int				'Slider range for listbox slider
Field old_sliderrange:Int=-1
Field listbox_slider_max_range:Int=100
Field lb_element_height:Int=14
Field listbox_element_count:Int		'total elements in list box
Field generic_button:=New PButton

Field list_box_slider_obj:=New PSlider
Field generic_slider:=New PSlider

	Method New()
	End Method

	Method New(x:Int,y:Int,w:Int,h:Int,lb_element_height:Int,window:PWindow=Null)
'		Local listbox:ListBox=New ListBox
		Self.window=window
		'listbox.id=id
		Self.x=x
		Self.y=y
		Self.w=w
		Self.h=h
		Self.lb_element_height=lb_element_height
		Self.listbox_image=listbox_bg
		Self.listbox_image.Handle=New Vec2f(0,0)'SetHandle(0,0)
		If listbox_bg<>Null
			Self.listbox_Image_scalew=Float(w)/Float(Self.listbox_image.Width)
			Self.listbox_Image_scaleh=Float(h)/Float(Self.listbox_image.Height)
		Endif
		Self.alpha=g_listbox_alpha'1.0'alpha
		'ListboxSliderIndex=ListboxSliderIndex+1
		'listbox.SLIDERCONST=ListboxSliderIndex
		If Self.justify=2
			Self.list_box_slider_obj= New PSlider(x+w,y,listbox_slider_bw,h,listbox_slider_bw,listbox_slider_bh,1,window)
		Else
			Self.x=Self.x+listbox_slider_bw
			Self.list_box_slider_obj= New PSlider(x,y,listbox_slider_bw,h,listbox_slider_bw,listbox_slider_bh,1,window)			
		Endif		
		Button_ListBox_List.AddLast(Self)
		window.Window_ListBox_List.AddLast(Self)
		
'		Return listbox
	End Method



	Method CreateListBox:PListBox(x:Int,y:Int,w:Int,h:Int,lb_element_height:Int,window:PWindow=Null)
		Local listbox:PListBox=New PListBox
		listbox.window=window
		'listbox.id=id
		listbox.x=x
		listbox.y=y
		listbox.w=w
		listbox.h=h
		listbox.lb_element_height=lb_element_height
		listbox.listbox_image=listbox_bg
		listbox.listbox_image.Handle=New Vec2f(0,0)'SetHandle(0,0)
		If listbox_bg<>Null
			listbox.listbox_Image_scalew=Float(w)/Float(listbox.listbox_image.Width)
			listbox.listbox_Image_scaleh=Float(h)/Float(listbox.listbox_image.Height)
		Endif
		listbox.alpha=g_listbox_alpha'1.0'alpha
		'ListboxSliderIndex=ListboxSliderIndex+1
		'listbox.SLIDERCONST=ListboxSliderIndex
		If listbox.justify=2
			listbox.list_box_slider_obj= New PSlider(x+w,y,listbox_slider_bw,h,listbox_slider_bw,listbox_slider_bh,1,window)
		Else
			listbox.x=listbox.x+listbox_slider_bw
			listbox.list_box_slider_obj= New PSlider(x,y,listbox_slider_bw,h,listbox_slider_bw,listbox_slider_bh,1,window)			
		Endif		
		Button_ListBox_List.AddLast(listbox)
		window.Window_ListBox_List.AddLast(listbox)
		
		Return listbox
	End Method


	Method Update:Void(mx:Int,my:Int,window:PWindow=Null,winx:Int=0,winy:Int=0,window_selected:Int=False)
		Local cnt:Int=0,cnt2:Int=0
		Local index:Int=0
		Local current_lb_id:Int
		Local myMatrix:=New AffineMat3f
	'Self.list_box_slider_obj.SetThumb(50)
			Local p_listbox:PListBox=Self 'New ListBox
			Local count:Int=p_listbox.h/p_listbox.lb_element_height
			If p_listbox.window=window And p_listbox.visible=True And window_selected=False  'Or window=Null And window_selected=False And p_listbox.visible=True 
				p_listbox.window._canvas.BlendMode=BlendMode.Alpha'SetBlendMode(BlendMode.Alpha)
				p_listbox.window._canvas.Alpha=p_listbox.alpha'SetAlpha(p_listbox.alpha)
				p_listbox.window._canvas.Color= New Color(p_listbox.r,p_listbox.g,p_listbox.b)
				p_listbox.window._canvas.PopMatrix()
				p_listbox.window._canvas.PushMatrix()
				'p_listbox.window._canvas.Transform(p_listbox.listbox_Image_scalew,0,0,p_listbox.listbox_Image_scaleh,p_listbox.x+winx,p_listbox.y+winy)
				'Local myMatrix:=New AffineMat3f
				myMatrix.i.x=p_listbox.listbox_Image_scalew
				myMatrix.j.y=p_listbox.listbox_Image_scaleh
				myMatrix.t.x=p_listbox.x+winx
				myMatrix.t.y=p_listbox.y+winy
				p_listbox.window._canvas.Matrix*=myMatrix   'transform current matrix by myMatrix.

				
				
				p_listbox.window._canvas.DrawImage(p_listbox.listbox_image,0,0)
				p_listbox.window._canvas.PopMatrix()
				p_listbox.window._canvas.PushMatrix()
			Endif
			If p_listbox.window=window  And window_selected=True 'Or window=Null
				If p_listbox.visible=True And window_selected=True 

					p_listbox.window._canvas.BlendMode=BlendMode.Alpha
					p_listbox.window._canvas.Alpha=p_listbox.alpha
					p_listbox.window._canvas.Color= New Color(p_listbox.r,p_listbox.g,p_listbox.b)
					p_listbox.window._canvas.PopMatrix()
					p_listbox.window._canvas.PushMatrix()
				'	p_listbox.window._canvas.Transform(p_listbox.listbox_Image_scalew,0,0,p_listbox.listbox_Image_scaleh,p_listbox.x+winx,p_listbox.y+winy)

				'Local myMatrix:=New AffineMat3f
				myMatrix.i.x=p_listbox.listbox_Image_scalew
				myMatrix.j.y=p_listbox.listbox_Image_scaleh
				myMatrix.t.x=p_listbox.x+winx
				myMatrix.t.y=p_listbox.y+winy
				p_listbox.window._canvas.Matrix*=myMatrix   'transform current matrix by myMatrix.



					p_listbox.window._canvas.DrawImage(p_listbox.listbox_image,0,0)
					p_listbox.window._canvas.PopMatrix()
					p_listbox.window._canvas.PushMatrix()

			'		If p_listbox.list_box_slider_obj.visible=True
					
					If (mx>p_listbox.x And mx<(p_listbox.x+p_listbox.w) And my>p_listbox.y And my<(p_listbox.y+p_listbox.h) )
						silder_forced_focus=p_listbox.list_box_slider_obj'SLIDERCONST
					Else
						silder_forced_focus=Null
					Endif
					Local range:Int=p_listbox.list_box_slider_obj.GetRange(Null)-1
					If p_listbox.old_sliderrange>-1 Then p_listbox.old_sliderrange=p_listbox.sliderrange
			
					If range<>p_listbox.sliderrange
						If range<1 Then range=0
						p_listbox.sliderrange=range
					Endif
					index=(range*(Float(p_listbox.listbox_element_count)/p_listbox.listbox_slider_max_range) )
					If index>=p_listbox.listbox_button_index_Count-count Then index=p_listbox.listbox_button_index_Count-count
					'Local p_button:PButton=New PButton
					Local p_element:PListBoxElement
					For p_element=Eachin  p_listbox.slider_button_list
						If p_listbox.old_sliderrange<>p_listbox.sliderrange
							If (window_selected=True Or p_listbox.window=Null) And p_element.listbox_object=p_listbox
								If p_element.button_handle.visible=True Then p_element.button_handle.visible=False
								If cnt2>=index And cnt2<count+index And p_element.button_handle<>Null
									p_element.button_handle.SetPosition(p_element.button_handle.x,p_listbox.y+(p_element.button_handle.h*cnt))
									p_element.button_handle.SetVisible(True)
									cnt=cnt+1
								Endif
								cnt2=cnt2+1
							Endif
						Endif
						'p_element.button_handle.button_selected=False
						 'p_element.button_handle.SetSelected(False)
						If p_element.button_handle.button_down=True
							If p_listbox.listbox_selected_button<>Null Then p_listbox.listbox_selected_button.button_selected=False'SetSelected(False)
							p_listbox.listbox_selected_button= p_element.button_handle'p_element.button_id
							p_element.button_handle.button_selected=True
							p_listbox.current_selected_element=p_element
						Endif
					Next
					
				'	Endif
				Endif
				If p_listbox.old_sliderrange=0 Then p_listbox.old_sliderrange=p_listbox.sliderrange		
			Endif
			cnt2=0
			cnt=0
			
	End Method 

	
	Method ClearElements()
		For Local tmp_element:=Eachin Self.slider_button_list
				tmp_element.button_handle.DeleteButton()
				slider_button_list.Remove(tmp_element)
		Next
		
		Self.slider_button_list.Clear()
		Self.slider_button_list=New List<PListBoxElement>'.Clear()
			 
	End Method



	Method GetElement:PListBoxElement(name:String)
		Local p_element:PListBoxElement
		For p_element=Eachin  Self.slider_button_list
			If p_element.button_handle.name=name
				Return p_element'.button_handle
			Endif
		Next	
		Return Null	
	End Method


	Method GetElement:PListBoxElement(index:Int)
		Local count:Int
		Local p_element:PListBoxElement
		For p_element=Eachin  Self.slider_button_list
			If count=index 
				Return p_element
			Endif
			count+=1
		Next	
		Return Null	
	End Method


	Method GetElementButton:PButton(element:PListBoxElement)
		Local p_element:PListBoxElement
		For p_element=Eachin  Self.slider_button_list
			If p_element=element'.button_handle.button_selected=True
				Return p_element.button_handle
			Endif
		Next		
		Return Null		
	End Method


	Method GetSelectedElement:PListBoxElement()
	'	Local p_element:PListBoxElement
	'	For p_element=Eachin  Self.slider_button_list
	'		If p_element.button_handle.button_selected=True
	'			Return p_element
	'		Endif
	'	Next		
		If current_selected_element<>Null
			Return current_selected_element
		Else
			Return Null
		Endif
		Return Null	
	End Method


	Method GetSelectedElementButton:PButton()
	'	Local p_element:PListBoxElement
	'	For p_element=Eachin  Self.slider_button_list
	'		If p_element.button_handle.button_selected=True
	'			Return p_element.button_handle
	'		Endif
	'	Next		
	'	Return Null		
		If current_selected_element<>Null
			Return current_selected_element.button_handle
		Else
			Return Null
		Endif
		Return Null	
	End Method


	Method GetSelectedElementIndex:Int()
		Local p_element:PListBoxElement
		Local count:Int
		For p_element=Eachin  Self.slider_button_list
			If p_element.button_handle.button_selected=True
				Return count
			Endif
			count+=1
		Next		
		Return False
	End Method


	Method GetSelectedElementName:String()
'		Local p_element:PListBoxElement
'		For p_element=Eachin  Self.slider_button_list
'			If p_element.button_handle.button_selected=True
'				Return p_element.button_handle.name
'			Endif
'		Next		
		If current_selected_element<>Null
			Return current_selected_element.button_handle.name.Trim()
		Else
			Return ""
		Endif
		Return ""	
'		Return ""
	End Method
	
	
	Method GetSlider:PSlider()
		Local slider: PSlider=Self.list_box_slider_obj
		Return slider
	End Method


	Method JustifySlider(justify:Int)
		If justify=1
			If Self.justify=2
				Self.list_box_slider_obj.SetPosition(Self.x,Self.y,0,0)
				Self.justify=justify
				Self.SetPosition(Self.x+Self.list_box_slider_obj.w,Self.y,Self.w,Self.h)
			Endif
		Else
			If Self.justify=1
				Self.list_box_slider_obj.SetPosition(Self.w,Self.y,0,0)
				Self.justify=justify
				Self.SetPosition(Self.x-Self.list_box_slider_obj.w,Self.y,Self.w,Self.h)
			Endif
		Endif				
	End Method
	

	Method SetPosition:Void(x:Int,y:Int,w:Int,h:Int)
		Self.x=x
		Self.y=y
		Self.w=w
		Self.h=h
		Self.listbox_Image_scalew=Float(w)/Float(Self.listbox_image.Width)
		Self.listbox_Image_scaleh=Float(h)/Float(Self.listbox_image.Height)
		Local p_element:PListBoxElement
		For p_element=Eachin  Self.slider_button_list
			If p_element.listbox_object=Self
				p_element.button_handle.x=x
				p_element.button_handle.y=y
			Endif 
		Next
		If Self.justify=1
			Self.list_box_slider_obj.SetPosition(Self.x-Self.list_box_slider_obj.w,Self.y,0,Self.h)
		Else
			Self.list_box_slider_obj.SetPosition(Self.x+Self.w,Self.y,0,Self.h)
		Endif
	End Method


	Method SetHighlightAlpha:Void(alpha:Float)
		Local p_element:PListBoxElement
		For p_element=Eachin  Self.slider_button_list
			If p_element.button_handle.listbox_id=Self.id
				p_element.button_handle.highlight_alpha=alpha
			Endif
		Next
	End Method


	Method SetHighlightBlend:Void(blend:Int)
		Local p_element:PListBoxElement
		For p_element=Eachin  Self.slider_button_list
			If p_element.button_handle.listbox_id=Self.id
				p_element.button_handle.highlight_blend=blend
			Endif
		Next
	End Method


	Method SetHighlightColor:Void(red:Float,green:Float,blue:Float)
		Local p_element:PListBoxElement
		For p_element=Eachin  Self.slider_button_list
			If p_element.button_handle.listbox_id=Self.id
				p_element.button_handle.highlight_red=red
				p_element.button_handle.highlight_green=green
				p_element.button_handle.highlight_blue=blue
			Endif
		Next		
	End Method


	Method SetElementSelected()
		
	End Method


	Method SetSelectedAlpha:Void(alpha:Float)
		Local p_element:PListBoxElement
		For p_element=Eachin  Self.slider_button_list
			If p_element.button_handle.listbox_id=Self.id
				p_element.button_handle.selected_alpha=alpha
			Endif
		Next		
	End Method


	Method SetSelectedBlend:Void(blend:Int)
		Local p_element:PListBoxElement
		For p_element=Eachin  Self.slider_button_list
			If p_element.button_handle.listbox_id=Self.id
				p_element.button_handle.selected_blend=blend
			Endif
		Next		
	End Method


	Method SetSelectedColor:Void(red:Float,green:Float,blue:Float)
		Local p_element:PListBoxElement
		For p_element=Eachin  Self.slider_button_list
			If p_element.button_handle.listbox_id=Self.id
				p_element.button_handle.selected_red=red
				p_element.button_handle.selected_green=green
				p_element.button_handle.selected_blue=blue
			Endif
		Next		
	End Method


	Method SetDownAlpha:Void(alpha:Float)
		Local p_element:PListBoxElement
		For p_element=Eachin  Self.slider_button_list
			If p_element.button_handle.listbox_id=Self.id
				p_element.button_handle.down_alpha=alpha
			Endif
		Next		
	End Method


	Method SetDownBlend:Void(blend:Int)
		Local p_element:PListBoxElement
		For p_element=Eachin  Self.slider_button_list
			If p_element.button_handle.listbox_id=Self.id
				p_element.button_handle.down_blend=blend
			Endif
		Next		
	End Method


	Method SetDownColor:Void(red:Float,green:Float,blue:Float)
		Local p_element:PListBoxElement
		For p_element=Eachin  Self.slider_button_list
			If p_element.button_handle.listbox_id=Self.id
				p_element.button_handle.down_red=red
				p_element.button_handle.down_green=green
				p_element.button_handle.down_blue=blue
			Endif
		Next		
	End Method



	Method SetUpAlpha:Void(alpha:Float)
		Local p_element:PListBoxElement
		For p_element=Eachin  Self.slider_button_list
			If p_element.button_handle.listbox_id=Self.id
				p_element.button_handle.alpha=alpha
			Endif
		Next		
	End Method

	Method SetUpBlend:Void(blend:Int)
		Local p_element:PListBoxElement
		For p_element=Eachin  Self.slider_button_list
			If p_element.button_handle.listbox_id=Self.id
				p_element.button_handle.blend=blend
			Endif
		Next		
	End Method

	Method SetUpColor:Void(red:Float,green:Float,blue:Float)
		Local p_element:PListBoxElement
		For p_element=Eachin  Self.slider_button_list
			If p_element.button_handle.listbox_id=Self.id
				p_element.button_handle.up_red=red
				p_element.button_handle.up_green=green
				p_element.button_handle.up_blue=blue
				p_element.button_handle.up_color= New Color(red,green,blue)
			Endif
		Next		
	End Method




	Method SetElementHighlightAlpha:Void(element:PListBoxElement,alpha:Float)
		element.button_handle.highlight_alpha=alpha
	End Method


	Method SetElementHighlightBlend:Void(element:PListBoxElement,blend:Int)
		element.button_handle.highlight_blend=blend
	End Method


	Method SetElementHighlightColor:Void(element:PListBoxElement,r:Float,g:Float,b:Float)
		element.button_handle.highlight_red=r
		element.button_handle.highlight_green=g
		element.button_handle.highlight_blue=b
	End Method


	Method SetElementSelectedAlpha:Void(element_id:Int,alpha:Float)
		Local p_element:PListBoxElement
		For p_element=Eachin  Self.slider_button_list
			If p_element.button_handle.id=element_id
				p_element.button_handle.selected_alpha=alpha
				Exit
			Endif
		Next
	End Method


	Method SetElementSelectedBlend:Void(element_id:Int,blend:Int)
		Local p_element:PListBoxElement
		For p_element=Eachin  Self.slider_button_list
			If p_element.button_handle.id=element_id
				p_element.button_handle.selected_blend=blend
				Exit
			Endif
		Next
	End Method


	Method SetElementSelectedColor:Void(element_id:Int,r:Float,g:Float,b:Float)
		Local p_element:PListBoxElement
		For p_element=Eachin  Self.slider_button_list
			If p_element.button_handle.id=element_id
				p_element.button_handle.selected_red=r
				p_element.button_handle.selected_green=g
				p_element.button_handle.selected_blue=b
				Exit
			Endif
		Next
	End Method


	Method SetElementDownAlpha:Void(element_id:Int,alpha:Float)
		Local p_element:PListBoxElement
		For p_element=Eachin  Self.slider_button_list
			If p_element.button_handle.id=element_id
				p_element.button_handle.down_alpha=alpha
				Exit
			Endif
		Next
	End Method


	Method SetElementDownBlend:Void(element_id:Int,blend:Int)
		Local p_element:PListBoxElement
		For p_element=Eachin  Self.slider_button_list
			If p_element.button_handle.id=element_id
				p_element.button_handle.down_blend=blend
				Exit
			Endif
		Next
	End Method


	Method SetElementDownColor:Void(element_id:Int,r:Float,g:Float,b:Float)
		Local p_element:PListBoxElement
		For p_element=Eachin  Self.slider_button_list
			If p_element.button_handle.id=element_id
				p_element.button_handle.down_red=r
				p_element.button_handle.down_green=g
				p_element.button_handle.down_blue=b
				Exit
			Endif
		Next
	End Method


	Method SetElementUpAlpha:Void(element_id:Int,alpha:Float)
		Local p_element:PListBoxElement
		For p_element=Eachin  Self.slider_button_list
			If p_element.button_handle.id=element_id
				p_element.button_handle.alpha=alpha
				Exit
			Endif
		Next
	End Method


	Method SetElementUpBlend:Void(element:PListBoxElement,blend:Int)
		element.button_handle.blend=blend
	End Method


	Method SetElementUpColor:Void(element:PListBoxElement,r:Float,g:Float,b:Float)
		element.button_handle.up_red=r
		element.button_handle.up_green=g
		element.button_handle.up_blue=b
		element.button_handle.up_color= New Color(r,g,b)
	End Method


	Method SetElelementName:Void(id:Int,name:String,change_name:String)
		If id<0
			Local p_element:PListBoxElement
			For p_element=Eachin  Self.slider_button_list
				If p_element.button_handle.listbox_id=Self.id
					If p_element.button_handle.name=name 
						p_element.button_handle.name=change_name
						Exit
					Endif
				Endif
			Next		
		Else
			For Local p_listbox:PListBox=Eachin Button_ListBox_List
			If p_listbox.id=id
				Local p_element:PListBoxElement
				For p_element=Eachin  p_listbox.slider_button_list
					If p_element.button_handle.listbox_id=id
						If p_element.button_handle.name=name 
							p_element.button_handle.name=change_name
							Exit
						Endif
					Endif
				Next
			Endif	
			Next
		Endif
	End Method
	

	Method SetElelementSelectedByName:Void(id:Int,name:String,flag:Int=True)
		If id<0
			Local p_element:PListBoxElement
			For p_element=Eachin  Self.slider_button_list
				If p_element.button_handle.listbox_id=Self.id
					If p_element.button_handle.name=name 
						p_element.button_handle.button_selected=flag 
						Self.listbox_selected_button=p_element.button_handle'p_element.button_id
						Exit
					Endif
				Endif
			Next		
		Else
			Local p_button:PButton
			Local p_element:PListBoxElement
			For Local p_listbox:PListBox=Eachin Button_ListBox_List
			If p_listbox.id=id
				For p_element=Eachin  p_listbox.slider_button_list
					If p_element.button_handle.listbox_id=id
						If p_element.button_handle.name=name 
							p_element.button_handle.button_selected=flag 
							p_listbox.listbox_selected_button=p_element.button_handle'p_element.button_id
							Exit
						Endif
					Endif
				Next
			Endif	
			Next
		Endif
	End Method
	
	
	Method SetSliderVisible(flag:Bool)
		If flag=False
			Self.list_box_slider_obj.HideSlider()
			Self.SetPosition(Self.x,Self.y,Self.w,Self.h)
		Else
			Self.list_box_slider_obj.ShowSlider()
			If Self.justify=1
				Self.list_box_slider_obj.SetPosition(Self.x,Self.y,0,0)
				Self.justify=justify
				Self.SetPosition(Self.x+Self.list_box_slider_obj.w,Self.y,Self.w,Self.h)
			Else
				Self.list_box_slider_obj.SetPosition(Self.w,Self.y,0,0)
				Self.justify=justify
				Self.SetPosition(Self.x-Self.list_box_slider_obj.w,Self.y,Self.w,Self.h)
			Endif				
		Endif
	End Method

	
	Method AddElement:PListBoxElement(name:String,image:Image=Null,image_up:Image=Null,image_down:Image=Null,image_highlight:Image=Null)
		'listbox_button_index=listbox_button_index+1
		Self.listbox_button_index_Count=Self.listbox_button_index_Count+1
		Self.listbox_element_count=Self.listbox_element_count+1
		Local tmp:PButton
		g_listbox_button_up.Handle=New Vec2f(0,0)
		g_listbox_button_down.Handle=New Vec2f(0,0)
		tmp=New PButton(name,Self.x,Self.y,Self.w,Self.lb_element_height,1,False,Self.window,Null)

		
		If image_up<>Null And image_down<>Null And image<>Null And image_highlight<>Null

			tmp.SetImage(image_up,image_down,image_highlight,image)

		Else
			tmp.SetImage(g_listbox_button_up,g_listbox_button_down,g_listbox_button_highlight,g_listbox_button_selected)
		Endif



		tmp.SetUpAlpha(Self.alpha)
		tmp.SetUpColor(Self.r,Self.g,Self.b)
		tmp.listbox_id=Self.id
		tmp.SetVisible(False)'listbox_button_index,False)
		tmp.text_center=False

		Local p_element:PListBoxElement
		p_element=New PListBoxElement
		'p_element.button_id=listbox_button_index
		'p_element.listbox_id=Self.id
		p_element.button_handle=tmp
		p_element.button_name=name
		p_element.listbox_object=Self
		Self.slider_button_list.AddLast(p_element)
		Return p_element'.button_id
	End Method

	
	Method DeleteAllElements:Void(id:Int=-1)
		If id<0
			Local tmp:PButton= New PButton
			Self.listbox_button_index_Count=0
			Self.listbox_element_count=0
			Local p_element:PListBoxElement
			For p_element=Eachin  Self.slider_button_list
				p_element.button_handle.DeleteButton()'p_element.button_id)
				Self.slider_button_list.Remove(p_element)
				Exit
			Next		
		Else
		Local tmp:PButton= New PButton
		For Local p_listbox:PListBox=Eachin Button_ListBox_List
			If p_listbox.id=id
				p_listbox.listbox_button_index_Count=0
				p_listbox.listbox_element_count=0
				Local p_element:PListBoxElement
				For p_element=Eachin  p_listbox.slider_button_list
					p_element.button_handle.DeleteButton()'p_element.button_id)
					p_listbox.slider_button_list.Remove(p_element)
					Exit
				Next
			Endif
		Next
		Endif
	End Method 
	
	
	Method DeleteElement:Void(element:PListBoxElement)'id:Int,buttonid:Int)
		 element.button_handle.DeleteButton()
		 element.listbox_object.slider_button_list.Remove(element)
	End Method 


	Method DeleteElementByName:Void(name:String)
		Local p_element:PListBoxElement
		For p_element=Eachin  Self.slider_button_list
			If  p_element.button_name=name
				p_element.button_handle.DeleteButton()'p_element.button_id)
				Self.slider_button_list.Remove(p_element)
				Exit
			Endif
		Next
	End Method 


	Method DeleteElementByIndex:Void(index:Int)
		Local p_element:PListBoxElement
		Local count:Int
		For p_element=Eachin  Self.slider_button_list
			If  count=index'p_element.button_name=name
				p_element.button_handle.DeleteButton()'p_element.button_id)
				Self.slider_button_list.Remove(p_element)
				Exit
			Endif
			count+=1
		Next
	End Method 


	Method DestroyListBox:Void()
		Button_ListBox_List.Remove(Self)
		Self.window.Window_ListBox_List.Remove(Self)
		Self.list_box_slider_obj.DestroySlider()
	End Method

	
	Method HideListBox:Void()
		Self.visible=False
		Self.list_box_slider_obj.HideSlider()
		For Local p_button:PListBoxElement=Eachin Self.slider_button_list
			p_button.button_handle.SetVisible(False)
		Next 
	End Method


	Method ShowListBox:Void(id:Int=-1)
		If id>-1
			For Local p_listbox:PListBox=Eachin Button_ListBox_List
				If p_listbox.id=id
					p_listbox.list_box_slider_obj.ShowSlider()
					p_listbox.visible=True
					For Local p_button:PListBoxElement=Eachin p_listbox.slider_button_list
						p_button.button_handle.SetVisible(True)
					Next 
					Exit
				Endif
			Next
		Else
			For Local p_listbox:PListBox=Eachin Button_ListBox_List
				If p_listbox=Self
					p_listbox.list_box_slider_obj.ShowSlider()
					p_listbox.visible=True
					For Local p_button:PListBoxElement=Eachin p_listbox.slider_button_list
						p_button.button_handle.SetVisible(True)
					Next 
					Exit
				Endif
			Next
		Endif
	End Method
	
	
	Function SetBlendMode(canvas:Canvas,blend:Int)
		If blend=1 Then canvas.BlendMode=BlendMode.Opaque
		If blend=2 Then canvas.BlendMode=BlendMode.Alpha
		If blend=3 Then canvas.BlendMode=BlendMode.Additive
		If blend=4 Then canvas.BlendMode=BlendMode.Multiply
	End Function	
	
End Class
