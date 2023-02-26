try(DestroyDialog HidePolygonForAnim) catch()

FileName = getdir #userscripts + "\Hide Polygon for Anim.ini"

rollout HidePolygonForAnim "Hide Polygon for Anim" width:220 height:160
	(
		label Label_Naming "Naming" pos:[10,10]
		editText Naming pos:[5,30] width:105 height:16
		Dropdownlist MeshList "MeshList" pos:[115,10] width:100
		MultiListBox PolygonList "Polygon List"pos:[10,55] width:100 height:5
		button Btn_ClearList "Clear" pos:[70,50]
		button Btn_PolyIndexHide "Hide" pos:[115,75] width:100 height:30
		button Btn_PolyIndexUnHide "UnHide" pos:[115,110] width:45 height:30
		button Btn_PolyIndexUnHideAll "UnHide All" pos:[160,110] width:55 height:30
		Label Copyright "Created by Shin Jin Ho"

		on HidePolygonForAnim open do
			(
				MeshObjList = #()
				
				for o in objects do
					(
						if ((classof o) == Editable_Mesh) or  ((classof o) == PolyMeshObject) or ((classof o) == Editable_Poly) do (AppendIfUnique MeshObjList o)
					)
				
				if MeshObjList.count > 0  do
					(
						MeshList.items = for i in MeshObjList collect i.name

						PolygonList.items = GetINISetting FileName MeshList.selected
					)
			)
		
		on Naming entered txt do
			(								
				if (GetFiles FileName).count == 0 do
					(
						File = CreateFile FileName
						Close File
					)

				SetINISetting FileName ($.name as string) Naming.text ((GetFaceSelection $) as string)
				
				PolygonList.items = GetINISetting FileName MeshList.selected
				
				Naming.text = ""
			)
			
		on MeshList selected val do
			(
				PolygonList.items = GetINISetting FileName MeshList.selected
			)
			
		on Btn_ClearList pressed do
			(
				INIList = GetINISetting FileName
				
				for i in INIList do
					(
						DelINISetting FileName i
					)
				
					PolygonList.items = GetINISetting FileName MeshList.selected
			)
			
		on Btn_PolyIndexHide pressed do
			(
				SelectList = #()
				
				for i = 1 to PolygonList.items.count do
					(
						if (PolygonList.selection[i]) == true do
							(
								append SelectList PolygonList.items[i]
							)
					)
				
				if SelectList.count != 0 do
					(
						for j = 1 to SelectList.count do
							(
								PolyIndexArray = execute (GetINISetting FileName MeshList.selected (SelectList[j] as string))

								(execute ("$" + MeshList.selected)).EditablePoly.SetSelection #Face PolyIndexArray
								(execute ("$"  + MeshList.selected)).EditablePoly.Hide #Face

								deselect (execute ("$" + MeshList.selected))								
							)
					)
				RedrawViews()
			)
			
		on Btn_PolyIndexUnHide pressed do
			(
				SelectList_UnHide = #()
				SelectList_Hide = #()
				
				for i = 1 to PolygonList.items.count do
					(
						if (PolygonList.selection[i]) == true then
							(
								append SelectList_UnHide PolygonList.items[i]
							)
						else ( append SelectList_Hide PolygonList.items[i] )
					)
					
				if SelectList_UnHide.count == 0 then false
				else
					(
						(execute ("$" + MeshList.selected)).EditablePoly.UnhideAll #Face
						
						for i = 1 to SelectList_Hide.count do
							(	
								PolyIndexArray = execute (GetINISetting FileName MeshList.selected (SelectList_Hide[i] as string))
								
								(execute ("$" + MeshList.selected)).EditablePoly.SetSelection #Face PolyIndexArray
								(execute ("$"  + MeshList.selected)).EditablePoly.Hide #Face
							)
					)
				deselect (execute ("$" + MeshList.selected))
				RedrawViews()
			)
			
		on Btn_PolyIndexUnHideAll pressed do
			(
				(execute ("$" + MeshList.selected)).EditablePoly.UnhideAll #Face
				
				deselect (execute ("$" + MeshList.selected))

				RedrawViews()
			)
			
		on PolygonList RightClick do
			(
				DeleteList = #()
				
				if (getfiles FileName).count != 0 do
					(
						for i = 1 to PolygonList.items.count do
							(
								if (PolygonList.selection[i]) == true do
									(
										append DeleteList PolygonList.items[i]
									)
							)
						
						DelINISetting FileName MeshList.selected (DeleteList[1] as string)
						
						PolygonList.items = GetINISetting FileName MeshList.selected
					)
			)
		
	)
	
CreateDialog HidePolygonForAnim