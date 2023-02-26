-- 만든이 : 이상원
-- 사용 및 수정은 자유입니다. 하지만 재 배포는 금지합니다.

global SoxRiggingAssist		-- 롤아웃명을 글로벌 변수로 인식하기 위해 초기에 한 번 사용

try (destroydialog SoxRiggingAssist) catch()		-- 혹시 열려있는 창이 있으면 강제 종료

rollout SoxRiggingAssist "Sox RiggingAssist v0.12" width:180
(
	local userPropKeywordNAP = "SoxRiggingAssist_NAP"
	group "Normal Aligned Point"
	(
		button uiNAP_Create "Create" across:2
		button uiNAP_Select "Select"
		spinner uiNAP_Size "Size" offset:[-8, 0] range:[0.0, 999999.0, 10.0]width:80 across:2
		colorPicker uiNAP_Color align:#center color:yellow
	)
	
	group "Biped Figure Fit using 2-Pos"
	(
		radioButtons uiBFF_UpAxis "Up-Axis ( Second Object )" labels:#("+X", "-X", "+Y", "-Y", "+Z", "-Z") default:5 align:#left offset:[0, -4]
		label uiBFF_Label1 "Select 1 = Biped" align:#center offset:[9, -60]
		label uiBFF_Label2 "Select 2-3 = Start-End" align:#center offset:[24, 0]		
		button uiBFF_Fit "Fit" width:80 offset:[10, 0]
	)
	
	button uiAbout "About"
	
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
	
	on uiBFF_Fit pressed do
	(
		if selection.count != 3 do return()
		if (classof selection[1].baseobject) != Biped_Object do return()
		if selection[1].controller.rootnode.controller.figureMode == false do return()
		
		local upAxisPos = case uiBFF_UpAxis.state of
		(
			1:[1, 0, 0]
			2:[-1, 0, 0]
			3:[0, 1, 0]
			4:[0, -1, 0]
			5:[0, 0, 1]
			6:[0, 0, -1]
			default:[0, 0, 1]
		)
		undo on
		(
			tOriginalScale = biped.getTransform selection[1] #scale
			biped.setTransform selection[1] #scale [(distance selection[2].transform.position selection[3].transform.position), tOriginalScale.y, tOriginalScale.z ] false
			--FnLookAt
			upPos = ( (transMatrix upAxisPos) * selection[2].transform ).position
			tMatrix = FnLookAt selection[2].transform.position selection[3].transform.position upPos
			biped.setTransform selection[1] #rotation tMatrix.rotation false
		)
	)

	on uiAbout pressed do
	(
		shellLaunch "http://cafe.naver.com/pinksox/6215" ""
	)
	
	on SoxRiggingAssist open do
	(

	)
	
	on SoxRiggingAssist close do
	(

	)
)

createDialog SoxRiggingAssist style:#(#style_titlebar, #style_toolwindow, #style_sysmenu) lockWidth:true