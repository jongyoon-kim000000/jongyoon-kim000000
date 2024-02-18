(
	/* 만든이 : 김종윤
	문의 : https://blog.naver.com/trueb000/

	*/




	-- 함수 정의: 정보 버튼을 눌렀을 때 실행되는 함수
	fn openInfoWebsite =
	(
	    shellLaunch "https://blog.naver.com/trueb000/" ""
	)
	function SetZeroPoint =
	(
	    $.position = [0, 0, 0]
	    resetXForm $
	    macros.run "Modifier Stack" "Convert_to_Poly"
	)

	/*-- 함수 정의
	function Merge =
	(
	    actionMan.executeAction 0 "40195"  -- File: Merge File

	)*/


	fn movePivotToOrigin obj =
	(
	    -- 오브젝트의 피봇을 월드 좌표 0,0,0으로 설정합니다.
	    obj.pivot = [0,0,0]
	    )

		
		
		
		
		
		
		
	global rot = eulerToQuat(eulerAngles 90 0 0)
	-- UI 정의
	try (destroyDialog ::L) catch ()
	rollout L "LIL Rigging TooL" width:350	height:600
		-------------------------------------------------------------------------------------------------
	(
			groupBox grp1 "SET" pos:[7,3] width:148 height:250
			button btn1 "Merge" pos:[18,23] width:127 height:34
			on btn1 pressed do
			(			actionMan.executeAction 0 "40195"  -- File: Merge File
			)	
			
			button btn2 "Move to Zero" pos:[18,63] width:127 height:34
			on btn2 pressed do
			(
			  selectedObjects = getCurrentSelection()
			if selectedObjects.count > 0 then
			(
			for obj in selectedObjects do SetZeroPoint()
			messagebox "      Set Zero      " title: "LIL_Modell_Edit"
			)
	        else Messagebox "No object selected" title: "LIL_Modell_Edit"
			)
		
			
			button btn22 "Move Pivot to Zero" pos:[18,103] width:127 height:34
			on btn22 pressed do
			(
			  selectedObjects = getCurrentSelection()
			if selectedObjects.count > 0 then
			(
			  for obj in selectedObjects do
	        -- 오브젝트의 피봇을 월드 좌표 0,0,0으로 설정합니다.
	        obj.pivot = [0,0,0]
			)
	        else Messagebox "No object selected" title: "LIL_Modell_Edit"
			)
		
			
			
			button btn3 "Reset XForm" pos:[18,143] width:127 height:34
			on btn3 pressed do
			(
			-- 선택된 객체가 있는지 확인
			selectedObjects = getCurrentSelection()
			if selectedObjects.count > 0 then
			(
	        -- 선택된 객체에 대해 Reset XForm 실행
	        for obj in selectedObjects do resetXForm obj

	        -- Reset XForm이 완료된 후 메시지 표시
	        messagebox "Reset XForm Completed" title: "LIL_Modell_Edit"
			)
			else messagebox "No object selected" title: "LIL_Modell_Edit"
			)

		
			button btn4 "Skin" pos:[18,183] width:63 height:30
			on btn4 pressed do
			(
			-- 현재 선택된 모든 객체를 얻습니다.
			selectedObjects = selection

			-- 각 객체에 대해 루프를 돌면서 Skin Modifier를 추가합니다.
			for obj in selectedObjects do
			(
			modPanel.addModToSelection (skin ()) ui:on
			)

			)
	     
			button btn5 "Skin Wrap" pos:[82,183] width:63 height:30
			on btn5 pressed do
			(
			-- 현재 선택된 모든 객체를 얻습니다.
			selectedObjects = selection

			-- 각 객체에 대해 루프를 돌면서 Skin Modifier를 추가합니다.
			for obj in selectedObjects do
			(
			modPanel.addModToSelection (Skin_Wrap()) ui:on
			)

			)
			
			button btn55 "Edit Mesh"pos:[18,217] width:127 height:30
			on btn55 pressed do
			(
			modPanel.addModToSelection (Edit_Mesh ()) ui:on


			)
			
			--------------------------------------------------------------------------------------------------------
			groupBox grp2 "Skin" pos:[7,265] width:148 height:180
			
			
			button btn6 "Edit Envelopes" pos:[18,280] width:127 height:34
			on btn6 pressed do
			(
			selectedObject = selection[1]

				-- 오브젝트가 선택되어 있는지 확인
				if selectedObject != undefined do
				(
				subObjectLevel = 1

				-- 서브 오브젝트 레벨을 1로 설정
			
				)

			)
			button btn7 "Weight Table" pos:[48,320] width:97 height:34
			on btn7 pressed do
			(
			skinOps.buttonWeightTable $.modifiers[#Skin]

			)
			button btn8 "..." pos:[18,320] width:30 height:34
			on btn8 pressed do
			(
skinOps.weightTool $.modifiers[#Skin]


			)
			button btn9 "Paint Weight" pos:[18,360] width:97 height:34
			on btn9 pressed do
			(
			skinOps.paintWeightsButton $.modifiers[#Skin]


			)
			button btn10 "..." pos:[115,360] width:30 height:34
			on btn10 pressed do
			(
			skinOps.paintOptionsButton $.modifiers[#Skin]


			)
			button btn11 "Remove Zero Weight" pos:[18,400] width:127 height:34
			on btn11 pressed do
			(
			skinOps.RemoveZeroWeights $.modifiers[#Skin]
			)
			--------------------------------------------------------------------------
			groupBox grp3 "Skin hide" pos:[165,3] width:175 height:120

			button infoButton "Info" pos:[120,560]  width:127 height:25  align:#center
			  on infoButton pressed do
	  		(
	       		 openInfoWebsite()
			)
			--하이드 매니저		
					button uiBtnHideSelVerts "Vertex" pos:[178,23] width:48 height:30
					button uiBtnHideSelFace "Face" pos:[228,23] width:48 height:30
					button uiBtnHideSelElem "Element" pos:[278,23] width:48 height:30
					button uiBtnUnhideAll "Unhide All" pos:[198,58] width:98 height:25
					checkbox uiChkHideUnselected "Hide Unselected" across:2 pos:[200,88] width:125 height:30
								-- obj에 스킨 모디파이어가 적용되었는지 검사하여 해당 모디파이어 위치 id 번호를 리턴한다. 모디파이어가 없으면 0 리턴
								function CheckSkinModifier obj =
								(
									if ( obj.modifiers.count == 0 ) do return 0
									for o = 1 to obj.modifiers.count do
									(
										if ( (classof obj.modifiers[o])  == Skin ) do return o
									)
									return 0
								)
								
								-- Skin 모디파이어가 적용된 타입을 알아낸다. (현재는 폴리 타입만 지원)
								-- Teapot 오브제트를 예를 들면,
								-- 0. 예외 경우
								-- 1. Teapot > Skin
								-- 2. Teapot > ?? .... > Edit Poly > Skin  (Skin과 Edit Poly 사이에 다른 것이 끼어있을 수 있다)
								-- 3. Edittable Poly > Skin (Edit Poly 모디파이어가 존재하지 않음)
								-- 이 함수는 Skin이 적용되어있다는 전제 하에 작동
								local idEditPolyModifier
								local idSkinModifier
								function CheckType obj =
								(
									idSkinModifier = CheckSkinModifier obj
									if idSkinModifier == 0 do return 0
									
									-- 1번 혹은 3번 경우
									if ( obj.modifiers.count == 1 ) do (
										if ( (classof $.baseobject) == Editable_Poly ) then
										(
											return 3
										)
										else
										(
											return 1
										)
									)
									
									-- 이하 2번 혹은 3번
									-- 일단 Skin 모디파이어가 있는 위치를 찾는다.
									idSkin = CheckSkinModifier obj
									
									for o = idSkin to obj.modifiers.count do
									(
										if ( ( classof obj.modifiers[o] ) == Edit_Poly ) do
										(
											idEditPolyModifier = o		-- 발견된 Edit Poly 모디파이어 인덱스를 로컬 변수에 기억
											return 2
										)
									)
									
									if ( ( classof obj.baseobject ) == Editable_Poly ) do return 3
									
									-- 어떤 경우에도 해당되지 않으면 0 리턴
									return 0
								)
								
								-- 스킨 모디파이어로부터 현재 선택된 버택스 일련번호를 bitArray 로 리턴한다.
								function GetSkinVertSelection skinMod =
								(
									bitArr = #{}
									loopIndex = 1
									errFlag = false
									testValue = true
									while errFlag == false do
									(
										try
										(
											testValue = skinOps.IsVertexSelected skinMod loopIndex
										)
										catch
										(
											return bitArr
										)
										
										append bitArr loopIndex
										if testValue == 0 do
										(
											bitArr[loopIndex] = false
										)
										loopIndex += 1
									)
									return bitArr
								)
		
								on uiBtnHideSelVerts pressed do
								(
									if (selection.count != 1) do return()
										
									-- 여기서 idSkinModifier와 idEditPolyModifier 로컬 변수가 같이 세팅된다.	
									skinType = CheckType selection[1]
													
									if ( skinType == 0 ) do return()
									
									disableSceneRedraw()
									undo on (
									case skinType of
									(
										2:
										(
											-- Edit Poly > Skin
											selectedVerts = GetSkinVertSelection selection[1].modifiers[idSkinModifier]
											if (uiChkHideUnselected.state) do
											(
												selectedVerts = -selectedVerts
											)
											modPanel.setCurrentObject selection[1].modifiers[idEditPolyModifier]
											subobjectLevel = 1
											selection[1].modifiers[idEditPolyModifier].SetSelection #Vertex #{}
											selection[1].modifiers[idEditPolyModifier].Select #Vertex selectedVerts
											selection[1].modifiers[idEditPolyModifier].ButtonOp #HideVertex
											subobjectLevel = 0
											modPanel.setCurrentObject selection[1].modifiers[idSkinModifier]
											subobjectLevel = 1
											skinOps.SelectVertices selection[1].modifiers[idSkinModifier] #{}
										)-- 2 end
										
										3:
										(
											-- Edittable Poly > Skin
											selectedVerts = GetSkinVertSelection selection[1].modifiers[idSkinModifier]
											if (uiChkHideUnselected.state) do
											(
												selectedVerts = -selectedVerts
											)
											selection[1].EditablePoly.SetSelection #Vertex selectedVerts
											selection[1].EditablePoly.Hide #Vertex
											subobjectLevel = 1
											skinOps.SelectVertices selection[1].modifiers[idSkinModifier] #{}
										)-- 3 end
										
										default: return ()
									)
									)-- undo end
									enableSceneRedraw()
								)
								
								on uiBtnHideSelFace pressed do
								(
									if (selection.count != 1) do return()
										
									-- 여기서 idSkinModifier와 idEditPolyModifier 로컬 변수가 같이 세팅된다.	
									skinType = CheckType selection[1]
													
									if ( skinType == 0 ) do return()
									
									disableSceneRedraw()
									undo on (
									case skinType of
									(
										2:
										(
											-- Edit Poly > Skin
											selectedVerts = GetSkinVertSelection selection[1].modifiers[idSkinModifier]
											modPanel.setCurrentObject selection[1].modifiers[idEditPolyModifier]
											subobjectLevel = 1
											selection[1].modifiers[idEditPolyModifier].SetSelection #Vertex #{}
											selection[1].modifiers[idEditPolyModifier].Select #Vertex selectedVerts
											selection[1].modifiers[idEditPolyModifier].ConvertSelection #Vertex #Face
											if (uiChkHideUnselected.state) do
											(
												subobjectLevel = 4
												actionMan.executeAction 0 "40044"  -- Selection: Select Invert
											)
											selection[1].modifiers[idEditPolyModifier].ButtonOp #HideFace
											subobjectLevel = 0
											modPanel.setCurrentObject selection[1].modifiers[idSkinModifier]
											subobjectLevel = 1
											skinOps.SelectVertices selection[1].modifiers[idSkinModifier] #{}
										)-- 2 end
										
										3:
										(
											-- Edittable Poly > Skin
											selectedVerts = GetSkinVertSelection selection[1].modifiers[idSkinModifier]
											selection[1].EditablePoly.SetSelection #Vertex selectedVerts
											selection[1].EditablePoly.ConvertSelection #Vertex #Face
											if (uiChkHideUnselected.state) do
											(
												modPanel.setCurrentObject selection[1].baseObject
												subobjectLevel = 4
												actionMan.executeAction 0 "40044"  -- Selection: Select Invert
												subobjectLevel = 0
											)
											selection[1].EditablePoly.Hide #Face
											modPanel.setCurrentObject selection[1].modifiers[idSkinModifier]
											subobjectLevel = 1
											skinOps.SelectVertices selection[1].modifiers[idSkinModifier] #{}
										)-- 3 end
										
										default: return ()
									)
									)-- undo end
									enableSceneRedraw()
								)
								
								on uiBtnHideSelElem pressed do
								(
									if (selection.count != 1) do return()
										
									-- 여기서 idSkinModifier와 idEditPolyModifier 로컬 변수가 같이 세팅된다.	
									skinType = CheckType selection[1]
													
									if ( skinType == 0 ) do return()
									
									disableSceneRedraw()
									undo on (
									case skinType of
									(
										2:
										(
											-- Edit Poly > Skin
											selectedVerts = GetSkinVertSelection selection[1].modifiers[idSkinModifier]
											modPanel.setCurrentObject selection[1].modifiers[idEditPolyModifier]
											subobjectLevel = 1
											selection[1].modifiers[idEditPolyModifier].SetSelection #Vertex #{}
											selection[1].modifiers[idEditPolyModifier].Select #Vertex selectedVerts
											selection[1].modifiers[idEditPolyModifier].ConvertSelection #Vertex #Element
											if (uiChkHideUnselected.state) do
											(
												subobjectLevel = 5
												actionMan.executeAction 0 "40044"  -- Selection: Select Invert
											)
											selection[1].modifiers[idEditPolyModifier].ButtonOp #HideFace
											subobjectLevel = 0
											modPanel.setCurrentObject selection[1].modifiers[idSkinModifier]
											subobjectLevel = 1
											skinOps.SelectVertices selection[1].modifiers[idSkinModifier] #{}
										)-- 2 end
										
										3:
										(
											-- Edittable Poly > Skin
											selectedVerts = GetSkinVertSelection selection[1].modifiers[idSkinModifier]
											selection[1].EditablePoly.SetSelection #Vertex selectedVerts
											selection[1].EditablePoly.ConvertSelection #Vertex #Element
											if (uiChkHideUnselected.state) do
											(
												modPanel.setCurrentObject selection[1].baseObject
												subobjectLevel = 5
												actionMan.executeAction 0 "40044"  -- Selection: Select Invert
												subobjectLevel = 0
											)
											selection[1].EditablePoly.Hide #Face
											modPanel.setCurrentObject selection[1].modifiers[idSkinModifier]
											subobjectLevel = 1
											skinOps.SelectVertices selection[1].modifiers[idSkinModifier] #{}
										)-- 3 end
										
										default: return ()
									)
									)-- undo end
									enableSceneRedraw()
								)
								
								on uiBtnUnhideAll pressed do
								(
									if (selection.count != 1) do return()
										
									-- 여기서 idSkinModifier와 idEditPolyModifier 로컬 변수가 같이 세팅된다.	
									skinType = CheckType selection[1]
													
									if ( skinType == 0 ) do return()
									
									undo on (
									case skinType of
									(
										2:
										(
											selection[1].modifiers[idEditPolyModifier].ButtonOp #UnhideAllFace
											selection[1].modifiers[idEditPolyModifier].ButtonOp #UnhideAllVertex
										)-- 2 end
										
										3:
										(
											selection[1].EditablePoly.unhideAll #Face
											selection[1].EditablePoly.unhideAll #Vertex
										)-- 3 end
										
										default: return ()
									)
									)-- undo end
								)		
	---------------------------------------------------------------------------------
		


		local userPropKeywordNAP = "lil_Sk"
			groupBox grp4 "Normal Aligned Point" pos:[165,130] width:175 height:80

			button uiNAP_Create "Create" pos:[175,150] width:60 height:20
			button uiNAP_Select "Select"  pos:[260,150] width:60 height:20
			spinner uiNAP_Size "Size" offset:[90, 5] range:[0.0, 999999.0, 10.0]width:80 across:2
			colorPicker uiNAP_Color pos:[265,175] color:yellow


		-- Normal Aligned Point 기능용 모디파이어 타입을 검사하여 리턴
		function GetObjTypeNAP obj =
		(
			-- 단순히 모디파이어 없는 Editable Poly일 경우
			if ( classof (modPanel.getCurrentObject()) == Editable_Poly ) do return "EditablePoly"
			
			-- Edit Poly 모디파이어일 경우
			if ( classof (modPanel.getCurrentObject()) == Edit_Poly ) do return "EditPoly"
				
			-- 그 외의 경우 모두 "Undefined"
			return "Undefined"
		)
		
		-- 위치 배열에서 meNum 으로부터 가장 가까운 버택스 번호를 리턴함. 예외상황은 일괄적으로 1을 리턴
		function FindNearPosNAP arrPos meNum =
		(
			if arrPos.count <= 1 do return 1
			local retNum
			local tDist
			if meNum == 1 then
			(
				tDist = distance arrPos[1] arrPos[2]
				retNum = 2
			)
			else
			(
				tDist = distance arrPos[1] arrPos[meNum]
				retNum = 1
			)
			for o = 2 to arrPos.count do
			(
				if o != meNum do
				(
					nowDist = distance arrPos[o] arrPos[meNum]
					if nowDist <= tDist do
					(
						retNum = o
						tDist = nowDist
					)
				)
			) -- for end
			
			return retNum
		)
		
		function FnLookAt pEye pAt pUp = -- 바라보는 위치, 타겟 위치, 업노드 위치
		(
			pUp = pUp - pEye
			xaxis = normalize(pAt - pEye); yaxis = normalize(cross pUp xaxis); zaxis = cross xaxis yaxis 
			(matrix3 [xaxis.x, xaxis.y, xaxis.z] [yaxis.x, yaxis.y, yaxis.z] [zaxis.x, zaxis.y, zaxis.z] [pEye.x, pEye.y, pEye.z])
		)
		
		-- 노말 정렬된 포인트들을 생성하는 함수
		function CreateNAP arrNormal arrPos =
		(
			if arrNormal.count == 0 do return()
			if arrNormal.count == 1 then
			(
				tMatrix = FnLookAt arrPos[1] (arrPos[1] + arrNormal[1]) [0, 0, 0]
				tPoint = Point size:uiNAP_Size.value wirecolor:uiNAP_Color.color
				tPoint.transform = tMatrix
				setUserProp tPoint userPropKeywordNAP true
			)
			else
			(
				for o = 1 to arrNormal.count do
				(
					nearNum = FindNearPosNAP arrPos o
					
					if o != arrNormal.count then
					(
						-- 마지막 포인트가 아닐 때 (Upnode 결정을 위해)
						tMatrix = FnLookAt arrPos[o] (arrPos[o] + arrNormal[o]) (arrPos[nearNum] + arrNormal[nearNum])
					)
					else
					(
						-- 마지막 포인트일 때 (Upnode 결정을 위해)
						tMatrix = FnLookAt arrPos[o] (arrPos[o] + arrNormal[o]) (arrPos[nearNum] + arrNormal[nearNum])
					)
					tPoint = Point size:uiNAP_Size.value wirecolor:uiNAP_Color.color
					tPoint.transform = tMatrix
					setUserProp tPoint userPropKeywordNAP true
				)
			)
		)
		
		function GetObjsNAP =
		(
			if objects.count == 0 do return #()
			arrSel = #()
			for o in objects do
			(
				if (getUserProp o userPropKeywordNAP) == true do (append arrSel o)
			)
			return arrSel
		)
		
		on uiNAP_Create pressed do
		(
			if selection.count != 1 do return()
			
			objType = GetObjTypeNAP selection[1]
			if objType == "Undefined" do return()
			
			arrPosNAP = #()
			arrNormalNAP = #()
			case objType of
			(
				"EditablePoly":
				(
					if subobjectLevel != 1 do return()
					local sel = selection[1].baseobject
					local vertArray = (polyop.getVertSelection sel) as array
					if vertArray.count == 0 do return()
					for o  = 1 to vertArray.count do
					(
						local vertFaces = polyOp.getFacesUsingVert sel vertArray[o]
						local tNormal = [0,0,0]
						for i in vertFaces do
						(
							tNormal += polyOp.getFaceNormal sel i
						)
						append arrNormalNAP ( (tNormal / vertFaces.numberSet) * selection[1].transform.rotation )
						append arrPosNAP ( (transMatrix (polyop.getVert sel vertArray[o])) * selection[1].transform).position		-- getVert 로 얻어오는 버택스 포지션은 오브젝트 내 로컬 포지션이라서 오브젝트 포지션을 더해줘야 월드 포지션이다.
					)
					subobjectLevel = 0		-- 버택스 생성시 강제로 현재 선택 오브젝트가 풀리기때문에 서브오브젝트를 일단 닫아줘야 모드파이어 스택에서 사고가 안생긴다.
					CreateNAP arrNormalNAP arrPosNAP
				)
				"EditPoly":
				(
					if subobjectLevel != 1 do return()
					local sel = modPanel.getCurrentObject()
					local vertArray = ((modPanel.getCurrentObject()).GetSelection #Vertex) as array
					if vertArray.count == 0 do return()
					for o  = 1 to vertArray.count do
					(
						/*
						sel.ConvertSelection #Vertex #Face
						local vertFaces = sel.GetSelection #Face
						local tNormal = [0,0,0]
						for i in vertFaces do
						(
							-- tNormal += polyOp.getFaceNormal sel i		-- 여기서 에러
						)
						*/
						
						append arrNormalNAP ( (getNormal selection[1].mesh vertArray[o]) * selection[1].transform.rotation )
						append arrPosNAP ( (transMatrix (getVert selection[1].mesh vertArray[o])) * selection[1].transform).position		-- getVert 로 얻어오는 버택스 포지션은 오브젝트 내 로컬 포지션이라서 오브젝트 포지션을 더해줘야 월드 포지션이다.
					)
					subobjectLevel = 0		-- 버택스 생성시 강제로 현재 선택 오브젝트가 풀리기때문에 서브오브젝트를 일단 닫아줘야 모드파이어 스택에서 사고가 안생긴다.
					CreateNAP arrNormalNAP arrPosNAP
				)
				default:return()
			)
		)
		
		on uiNAP_Select pressed do
		(
			subobjectLevel = 0		-- 현재 선택 오브젝트가 풀리기때문에 서브오브젝트를 일단 닫아줘야 모드파이어 스택에서 사고가 안생긴다.
			select (GetObjsNAP())
		)
		
		on uiNAP_Size changed var do
		(
			tPoints = GetObjsNAP()
			if tPoints.count == 0 do return()
			for o in tPoints do
			(
				o.size = var
			)
		)
		
		on uiNAP_Color changed var do
		(
			tPoints = GetObjsNAP()
			if tPoints.count == 0 do return()
			for o in tPoints do
			(
				o.wirecolor = var
			)
		)

						
								
								
	--------------------------------------------------------------------------------
		
	--비저빌리티 
			groupBox grp5 "Visiblity" pos:[165,220] width:175 height:60
	button Bonetoggle "Bone" pos:[178,240] width:48 height:30
	on Bonetoggle pressed do
		(

			case of
				(
					(hideByCategory.bones == true): (hideByCategory.bones = false)
					(hideByCategory.bones == false): (hideByCategory.bones = true)
				)	
				
		)
	button Helpertoggle "Helper" pos:[230,240] width:48 height:30
	on Helpertoggle pressed do
		(
	actionMan.executeAction 0 "40187"

		)
	button GeTo "Geometry" pos:[285,240] width:48 height:30
	on GeTo pressed do
		(
	actionMan.executeAction 0 "40190"  -- Views: Hide Geometry Toggle


		)
	-------------------------------------------------------------------	
		
	
--바이패드 선택 
		groupBox grp6 "ETC" pos:[165,340] width:175 height:50
------------------------------------------------------------
button SelCom "Select COM" pos:[178,355] width:48 height:30
		on SelCom pressed do
		(
			macros.run "JJTools 2013" "JJTools2013_Bip_Select_Bip"
		)
		button Fig "Figure Mode" pos:[230,355] width:48 height:30
		on Fig pressed do
		(
			actionMan.executeAction 972555510 "40144"

		)
			button RENAME "Rename" pos:[285,355] width:48 height:30
		on RENAME pressed do
		(
		macros.run "Scene Explorer" "SERename"

		)
	groupBox grp7 "Skin Pose" pos:[165,285] width:175 height:50
			button setpose "Set Skin Pose" pos:[170,300] width:75 height:30
		on setpose pressed do
		(
macros.run "Characters" "SetSkinPose"

		)
				button asspose "Assume Skin Pose" pos:[255,300] width:75 height:30
		on asspose pressed do
		(
macros.run "Characters" "AssumeSkinPose"


		)
		
		------------------------------------------------------------
		--헬퍼생성
		
	groupBox grpdis "Create Helper" pos:[165,395] width:175 height:135
    checkbox NewPointbox "Box" pos:[170,420] enabled:true checked:true across:3
    checkbox NewPointcross "Cross" pos:[225,420]
    checkbox N_link "Link" pos:[292,420]
    spinner spn_PointSize "Size:" pos:[230,445] range:[0,300,20] type:#integer width:40 height:16
		    editText edt_name "Name:" pos:[190,470] fieldWidth:70

    button btn_CreatPoint "Create" pos:[280,500]
    button bt_origin "Oringin" pos:[180,500] 



    on edt_name entered txt do(
        if txt !="" then (get_txt_name = true )
        else (get_txt_name = false)

    )
    -----------------------------------------
    on btn_CreatPoint pressed do
    (
        undo on
        (

                if selection.count != 0  then (
                    AllPoint = #()
                    for o in selection do
                    (
                        NewPoint = point()
                        if NewPointbox.checked == true then (NewPoint.box=on)
                        else (NewPoint.box=off)

                        if NewPointcross.checked == true then(NewPoint.cross=on)
                        else(NewPoint.cross=off)

                        NewPoint.transform = o.transform
                        NewPoint.size = spn_PointSize.value
                        --Newpoint.name = "Point_"+ o.name
                        if get_txt_name == true then (NewPoint.name = edt_name.text + "_" + o.name )
                        else(NewPoint.name = "Point_" + o.name)

                        if N_link.checked == true do(Newpoint.parent = o )
                        append AllPoint  Newpoint
                    )

                    select AllPoint
                    selectionSets ["Point_ji"] = AllPoint
                )
                else(

                        NewPoint = point()
                        if NewPointbox.checked == true then ( NewPoint.box=on)
                        else ( NewPoint.box=off )

                        if NewPointcross.checked == true then (NewPoint.cross=on)
                        else ( NewPoint.cross=off )

                        if get_txt_name == true do (NewPoint.name = edt_name.text)
                        --else(NewPoint.name = "Point_" + o.name)
                        /*if NewPoint_root.checked == true do(
                            Newpoint.name = "Root"
                            --Newpoint.transform = (matrix3 [0,0,1] [-1.50996e-007,-1,0] [1,-1.50996e-007,0] [0,0,0])

                            --$boy_Hub.parent = Newpoint
                            Newpoint.boneEnable=true
                        )*/

                )
        )


    )
    on bt_origin pressed do
    (
        undo on(
            if selection.count == 0 do (
                NewPoint = point()
                if NewPointbox.checked == true then (NewPoint.box=on)
                else (NewPoint.box=off)

                if NewPointcross.checked == true then (NewPoint.cross=on)
                else(NewPoint.cross=off)

                if get_txt_name == true do (NewPoint.name = edt_name.text)
                --else(NewPoint.name = "Root_" )

                --if New_cat.checked == true do ( Newpoint.transform = (matrix3 [0,0,1] [-1.50996e-007,-1,0] [1,-1.50996e-007,0] [0,0,0]) )
                Newpoint.boneEnable=true
            )

            if selection.count == 1 do (
                NewPoint = point()
                if NewPointbox.checked == true then (NewPoint.box=on)
                else (NewPoint.box=off)

                if NewPointcross.checked == true then (NewPoint.cross=on)
                else(NewPoint.cross=off)

                if get_txt_name == true then (NewPoint.name = edt_name.text)
                else(NewPoint.name = "Root_" + $.name)
                $.parent = Newpoint
                Newpoint.boneEnable=true
            )

            if selection.count > 1 do ( messageBox ("只能??一?物?") )
        )
    )

----------------------------------------------------------------------------------------------------------
			
	)

	createDialog L
)