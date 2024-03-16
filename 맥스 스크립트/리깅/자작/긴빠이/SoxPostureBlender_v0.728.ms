--만든이 : 이상원
-- 체크사항 . 삭제된 오브젝트가 뒤섞여 있을 때 오류 체크

try (destroydialog SOXPostureBlender) catch()

SOXPostureBlender

rollout SOXPostureBlenderSubSlider1 "SOX Posture Blender Slider"
(
	slider uiSliderBlend range:[0.0, 1.0, 0.0]
	
	on uiSliderBlend	buttondown do
	(
		SOXPostureBlender.uiListPosture.selection = 1
		SOXPostureBlender.fnSliderButtonDown ()
	)
	
	on uiSliderBlend buttonUp do
	(
		disableSceneRedraw()
		undo Off
		(
			animate off (SOXPostureBlender.fnSliderChange 0.0)
		)
		
		undo On
		(
			SOXPostureBlender.fnSliderChange uiSliderBlend.value -- 슬라이더 체인지에서는 Undo를 막았으므로 Undo가 가능한 이곳에서 한번 더 변경해줌
		)
		
		enableSceneRedraw()
		redrawViews()
		
		uiSliderBlend.value = 0.0
		SOXPostureBlender.uiSliderBlend.value = 0.0
		SOXPostureBlender.fnRefreshUi () -- 오브젝트 삭제 등의 씬 변화를 수시로 확인하기 위해 슬라이더 액션의 끝에 리프레시 함수를 삽입함.
	)

	on uiSliderBlend changed var do
	(
		SOXPostureBlender.uiSliderBlend.value = var

		undo Off
		(
			animate off (SOXPostureBlender.fnSliderChange var)
		)
	)
	
	on SOXPostureBlenderSubSlider1 close do
	(
		SOXPostureBlender.arrFloater[1] = undefined
	)
)

rollout SOXPostureBlenderSubSlider2 "SOX Posture Blender Slider"
(
	slider uiSliderBlend range:[0.0, 1.0, 0.0]
	
	on uiSliderBlend	buttondown do
	(
		SOXPostureBlender.uiListPosture.selection = 2
		SOXPostureBlender.fnSliderButtonDown ()
	)
	
	on uiSliderBlend buttonUp do
	(
		disableSceneRedraw()
		undo Off
		(
			animate off (SOXPostureBlender.fnSliderChange 0.0)
		)
		
		undo On
		(
			SOXPostureBlender.fnSliderChange uiSliderBlend.value -- 슬라이더 체인지에서는 Undo를 막았으므로 Undo가 가능한 이곳에서 한번 더 변경해줌
		)
		
		enableSceneRedraw()
		redrawViews()
		
		uiSliderBlend.value = 0.0
		SOXPostureBlender.uiSliderBlend.value = 0.0
		SOXPostureBlender.fnRefreshUi () -- 오브젝트 삭제 등의 씬 변화를 수시로 확인하기 위해 슬라이더 액션의 끝에 리프레시 함수를 삽입함.
	)

	on uiSliderBlend changed var do
	(
		SOXPostureBlender.uiSliderBlend.value = var
		undo Off
		(
			animate off (SOXPostureBlender.fnSliderChange var)
		)
	)
	
	on SOXPostureBlenderSubSlider2 close do
	(
		SOXPostureBlender.arrFloater[2] = undefined
	)
)

rollout SOXPostureBlenderSubSlider3 "SOX Posture Blender Slider"
(
	slider uiSliderBlend range:[0.0, 1.0, 0.0]
	
	on uiSliderBlend	buttondown do
	(
		SOXPostureBlender.uiListPosture.selection = 3
		SOXPostureBlender.fnSliderButtonDown ()
	)
	
	on uiSliderBlend buttonUp do
	(
		disableSceneRedraw()
		undo Off
		(
			animate off (SOXPostureBlender.fnSliderChange 0.0)
		)
		
		undo On
		(
			SOXPostureBlender.fnSliderChange uiSliderBlend.value -- 슬라이더 체인지에서는 Undo를 막았으므로 Undo가 가능한 이곳에서 한번 더 변경해줌
		)
		
		enableSceneRedraw()
		redrawViews()
		
		uiSliderBlend.value = 0.0
		SOXPostureBlender.uiSliderBlend.value = 0.0
		SOXPostureBlender.fnRefreshUi () -- 오브젝트 삭제 등의 씬 변화를 수시로 확인하기 위해 슬라이더 액션의 끝에 리프레시 함수를 삽입함.
	)

	on uiSliderBlend changed var do
	(
		SOXPostureBlender.uiSliderBlend.value = var
		undo Off
		(
			animate off (SOXPostureBlender.fnSliderChange var)
		)
	)
	
	on SOXPostureBlenderSubSlider3 close do
	(
		SOXPostureBlender.arrFloater[3] = undefined
	)
)

rollout SOXPostureBlenderSubSlider4 "SOX Posture Blender Slider"
(
	slider uiSliderBlend range:[0.0, 1.0, 0.0]
	
	on uiSliderBlend	buttondown do
	(
		SOXPostureBlender.uiListPosture.selection = 4
		SOXPostureBlender.fnSliderButtonDown ()
	)
	
	on uiSliderBlend buttonUp do
	(
		disableSceneRedraw()
		undo Off
		(
			animate off (SOXPostureBlender.fnSliderChange 0.0)
		)
		
		undo On
		(
			SOXPostureBlender.fnSliderChange uiSliderBlend.value -- 슬라이더 체인지에서는 Undo를 막았으므로 Undo가 가능한 이곳에서 한번 더 변경해줌
		)
		
		enableSceneRedraw()
		redrawViews()
		
		uiSliderBlend.value = 0.0
		SOXPostureBlender.uiSliderBlend.value = 0.0
		SOXPostureBlender.fnRefreshUi () -- 오브젝트 삭제 등의 씬 변화를 수시로 확인하기 위해 슬라이더 액션의 끝에 리프레시 함수를 삽입함.
	)

	on uiSliderBlend changed var do
	(
		SOXPostureBlender.uiSliderBlend.value = var
		undo Off
		(
			animate off (SOXPostureBlender.fnSliderChange var)
		)
	)
	
	on SOXPostureBlenderSubSlider4 close do
	(
		SOXPostureBlender.arrFloater[4] = undefined
	)
)

rollout SOXPostureBlenderSubSlider5 "SOX Posture Blender Slider"
(
	slider uiSliderBlend range:[0.0, 1.0, 0.0]
	
	on uiSliderBlend	buttondown do
	(
		SOXPostureBlender.uiListPosture.selection = 5
		SOXPostureBlender.fnSliderButtonDown ()
	)
	
	on uiSliderBlend buttonUp do
	(
		disableSceneRedraw()
		undo Off
		(
			animate off (SOXPostureBlender.fnSliderChange 0.0)
		)
		
		undo On
		(
			SOXPostureBlender.fnSliderChange uiSliderBlend.value -- 슬라이더 체인지에서는 Undo를 막았으므로 Undo가 가능한 이곳에서 한번 더 변경해줌
		)
		
		enableSceneRedraw()
		redrawViews()
		
		uiSliderBlend.value = 0.0
		SOXPostureBlender.uiSliderBlend.value = 0.0
		SOXPostureBlender.fnRefreshUi () -- 오브젝트 삭제 등의 씬 변화를 수시로 확인하기 위해 슬라이더 액션의 끝에 리프레시 함수를 삽입함.
	)

	on uiSliderBlend changed var do
	(
		SOXPostureBlender.uiSliderBlend.value = var
		undo Off
		(
			animate off (SOXPostureBlender.fnSliderChange var)
		)
	)
	
	on SOXPostureBlenderSubSlider5 close do
	(
		SOXPostureBlender.arrFloater[5] = undefined
	)
)

rollout SOXPostureBlenderSubSlider6 "SOX Posture Blender Slider"
(
	slider uiSliderBlend range:[0.0, 1.0, 0.0]
	
	on uiSliderBlend	buttondown do
	(
		SOXPostureBlender.uiListPosture.selection = 6
		SOXPostureBlender.fnSliderButtonDown ()
	)
	
	on uiSliderBlend buttonUp do
	(
		disableSceneRedraw()
		undo Off
		(
			animate off (SOXPostureBlender.fnSliderChange 0.0)
		)
		
		undo On
		(
			SOXPostureBlender.fnSliderChange uiSliderBlend.value -- 슬라이더 체인지에서는 Undo를 막았으므로 Undo가 가능한 이곳에서 한번 더 변경해줌
		)
		
		enableSceneRedraw()
		redrawViews()
		
		uiSliderBlend.value = 0.0
		SOXPostureBlender.uiSliderBlend.value = 0.0
		SOXPostureBlender.fnRefreshUi () -- 오브젝트 삭제 등의 씬 변화를 수시로 확인하기 위해 슬라이더 액션의 끝에 리프레시 함수를 삽입함.
	)

	on uiSliderBlend changed var do
	(
		SOXPostureBlender.uiSliderBlend.value = var
		undo Off
		(
			animate off (SOXPostureBlender.fnSliderChange var)
		)
	)
	
	on SOXPostureBlenderSubSlider6 close do
	(
		SOXPostureBlender.arrFloater[6] = undefined
	)
)

rollout SOXPostureBlenderSubSlider7 "SOX Posture Blender Slider"
(
	slider uiSliderBlend range:[0.0, 1.0, 0.0]
	
	on uiSliderBlend	buttondown do
	(
		SOXPostureBlender.uiListPosture.selection = 7
		SOXPostureBlender.fnSliderButtonDown ()
	)
	
	on uiSliderBlend buttonUp do
	(
		disableSceneRedraw()
		undo Off
		(
			animate off (SOXPostureBlender.fnSliderChange 0.0)
		)
		
		undo On
		(
			SOXPostureBlender.fnSliderChange uiSliderBlend.value -- 슬라이더 체인지에서는 Undo를 막았으므로 Undo가 가능한 이곳에서 한번 더 변경해줌
		)
		
		enableSceneRedraw()
		redrawViews()
		
		uiSliderBlend.value = 0.0
		SOXPostureBlender.uiSliderBlend.value = 0.0
		SOXPostureBlender.fnRefreshUi () -- 오브젝트 삭제 등의 씬 변화를 수시로 확인하기 위해 슬라이더 액션의 끝에 리프레시 함수를 삽입함.
	)

	on uiSliderBlend changed var do
	(
		SOXPostureBlender.uiSliderBlend.value = var
		undo Off
		(
			animate off (SOXPostureBlender.fnSliderChange var)
		)
	)
	
	on SOXPostureBlenderSubSlider7 close do
	(
		SOXPostureBlender.arrFloater[7] = undefined
	)
)

rollout SOXPostureBlenderSubSlider8 "SOX Posture Blender Slider"
(
	slider uiSliderBlend range:[0.0, 1.0, 0.0]
	
	on uiSliderBlend	buttondown do
	(
		SOXPostureBlender.uiListPosture.selection = 8
		SOXPostureBlender.fnSliderButtonDown ()
	)
	
	on uiSliderBlend buttonUp do
	(
		disableSceneRedraw()
		undo Off
		(
			animate off (SOXPostureBlender.fnSliderChange 0.0)
		)
		
		undo On
		(
			SOXPostureBlender.fnSliderChange uiSliderBlend.value -- 슬라이더 체인지에서는 Undo를 막았으므로 Undo가 가능한 이곳에서 한번 더 변경해줌
		)
		
		enableSceneRedraw()
		redrawViews()
		
		uiSliderBlend.value = 0.0
		SOXPostureBlender.uiSliderBlend.value = 0.0
		SOXPostureBlender.fnRefreshUi () -- 오브젝트 삭제 등의 씬 변화를 수시로 확인하기 위해 슬라이더 액션의 끝에 리프레시 함수를 삽입함.
	)

	on uiSliderBlend changed var do
	(
		SOXPostureBlender.uiSliderBlend.value = var
		undo Off
		(
			animate off (SOXPostureBlender.fnSliderChange var)
		)
	)
	
	on SOXPostureBlenderSubSlider8 close do
	(
		SOXPostureBlender.arrFloater[8] = undefined
	)
)

rollout SOXPostureBlenderSubSlider9 "SOX Posture Blender Slider"
(
	slider uiSliderBlend range:[0.0, 1.0, 0.0]
	
	on uiSliderBlend	buttondown do
	(
		SOXPostureBlender.uiListPosture.selection = 9
		SOXPostureBlender.fnSliderButtonDown ()
	)
	
	on uiSliderBlend buttonUp do
	(
		disableSceneRedraw()
		undo Off
		(
			animate off (SOXPostureBlender.fnSliderChange 0.0)
		)
		
		undo On
		(
			SOXPostureBlender.fnSliderChange uiSliderBlend.value -- 슬라이더 체인지에서는 Undo를 막았으므로 Undo가 가능한 이곳에서 한번 더 변경해줌
		)
		
		enableSceneRedraw()
		redrawViews()
		
		uiSliderBlend.value = 0.0
		SOXPostureBlender.uiSliderBlend.value = 0.0
		SOXPostureBlender.fnRefreshUi () -- 오브젝트 삭제 등의 씬 변화를 수시로 확인하기 위해 슬라이더 액션의 끝에 리프레시 함수를 삽입함.
	)

	on uiSliderBlend changed var do
	(
		SOXPostureBlender.uiSliderBlend.value = var
		undo Off
		(
			animate off (SOXPostureBlender.fnSliderChange var)
		)
	)
	
	on SOXPostureBlenderSubSlider9 close do
	(
		SOXPostureBlender.arrFloater[9] = undefined
	)
)

rollout SOXPostureBlender "SOX Posture Blender v0.728" width:360
(
	local uiFSx = 200
	local uiFSy = 76
	
	local arrPostureList = #() -- 포스쳐 이름 리스트 배열
	local arrObjectHandle = #() -- 오브젝트 ID 배열
	local arrObjectName = #() -- 오브젝트 이름 배열
	local arrObjectTransformLocal = #() -- 오브젝트 로컬 트랜스폼 배열
	local arrObjectTransformWorld = #() -- 오브젝트 월드 트랜스폼 배열
	local arrVP = #() -- 가상 부모용 배열
	local arrVPTransformLocal = #() -- 가상 부모로부터의 로컬 트랜스폼을 따로 기억해야 한다.
	local informationText = "" -- 인포창용 로컬 변수
	
	local arrObjectStatus = #() -- 현재 오브젝트가 삭제되었는지 이름이 변경되었는지 상태를 기억하는 배열 변수. 파일로 저장되지는 않는다.
	
	local arrTempLocal = #() -- 슬라이더가 눌러지는 순간의 오브젝트리스트의 트랜스폼 정보를 잠시 기억하는 배열
	local arrTempWorld = #() -- 슬라이더가 눌러지는 순간의 오브젝트리스트의 트랜스폼 정보를 잠시 기억하는 배열
	
	local arrFloater = #()
	
	local arrRolloutName = #("SOXPostureBlenderSubSlider1","SOXPostureBlenderSubSlider2","SOXPostureBlenderSubSlider3","SOXPostureBlenderSubSlider4","SOXPostureBlenderSubSlider5","SOXPostureBlenderSubSlider6","SOXPostureBlenderSubSlider7","SOXPostureBlenderSubSlider8","SOXPostureBlenderSubSlider9")
	
	local arrFloatingTempPos = #()
	
	button uiBtnAdd "Add" offset:[-6, 0] across:7
	button uiBtnRemove "Remove" offset:[-2, 0]
	button uiBtnRefresh "Refresh" offset:[12, 0]
	button uiBtnLoad "Load" offset:[18, 0]
	button uiBtnSave "Save" offset:[18, 0]
	button uiBtnHelp "Help" offset:[16, 0]
	button uiBtnSite "Site" offset:[12, 0]
	
	editText uiTextPostureName tooltip:"Enter posture name here" width:168 align:#left
	
	button uiBtnUpdate "Update Posture" align:#right offset:[56, 0] align:#right across:3
	pickbutton uiPickVirtualParent "Assign VP" tooltip:"Assign Virtual Parent" align:#right width:66 offset:[40, 0]
	button uiBtnVirtualParentRemove "Remove VP" tooltip:"Remove Virtual Parent" align:#right width:66 offset:[0, 0]
	
	button uiBtnPostureUp "^" align:#left width:14 offset:[0, 10]
	button uiBtnPostureDown "v" align:#left width:14
	
	listBox uiListPosture "Posture List" height:5 readOnly:false offset:[0, -80] width:152 align:#right across:2
	listBox uiListObject height:5 readOnly:false offset:[0, -64]
	
	slider uiSliderBlend range:[0.0, 1.0, 0.0] offset:[0, -6]
	radiobuttons uiRadioLocalWorld "Blend Type" labels:#("Local", "World") default:1 offset:[100, 0] across:5
	
	checkbox uiCheckPosition "Position" checked:false offset:[24 + 90, 0]
	checkbox uiCheckRotation "Rotation" checked:true offset:[-42 + 90, 16]
	checkbox uiCheckScale "Scale" checked:false offset:[-108 + 90, 32]
	radiobuttons uiRadioLoadType "Load Type" labels:#("Object ID", "Name") default:1
	
	button uiBtnCreateSlider "Create Floater" width:90 offset:[-124, -52]
	button uiBtnCloseAllSlider "Close All Floater" width:90 offset:[-124, 0]
	
	editText uiTextInfo "Information" height:50 readOnly:true labelOnTop:true
	
	/* -- 만들다 만 함수. 프랍의 Position Space와 Rotation Space를 자동으로 인식하게 하려면 이 함수가 완성되어야 하지만 수동으로 VP를 지정하도록 설계함.
	function fnFindPropVP prop = -- 프랍 오브젝트의 가상의 부모를 찾아낸다. 찾아낸 경우만 해당 노드를 리턴하고 그 외 모든 경우에는 undefined 리턴함.
	(
		if (classof prop.baseobject) != Biped_Object do return undefined
		
		-- 먼저 입력된 오브젝트가 프랍인지 검사한다.
		findTrig = false
		if prop == (biped.getNode prop #Prop1) then findTrig = true
		if prop == (biped.getNode prop #Prop2) then findTrig = true
		if prop == (biped.getNode prop #Prop3) then findTrig = true
		
		if findTrig == false do return undefined
			
		biped.getKey prop.controller 1
		
	-- 	k = biped.getKey prop.controller 1
	-- 	showProperties k
	-- 	<propkey>.posSpace Integer Default: 1
	-- 	<propkey>.rotSpace Integer Default: varies
	-- 	0 - World
	-- 	Positioning/rotation is in world coordinate space. 
	-- 	1 - Body
	-- 	Positioning/rotation is in body coordinate space. 
	-- 	2 ? Right Hand
	-- 	Positioning/rotation is in right hand coordinate space. 
	-- 	3 ? Left Hand
	-- 	Positioning/rotation is in left hand coordinate space.

	)
	*/
	
	function fnAppendIfUnique arr var = -- appendIfUnique를 대체하는 함수. appendIfUnique는 맥스 2008부터 추가된 함수임
	(
		if (findItem arr var) != 0 do return false
		append arr var
		return true
	)
	
	function MakeClosest quat1 quat2 = -- modifies quat2 and also returns quat2, 이 함수는 slerp 함수를 사용하기 위한 사전 함수임
	(
		local dot = quat1.x*quat2.x + quat1.y*quat2.y + quat1.z*quat2.z+
		quat1.w*quat2.w
		if (dot < 0.0) do (quat2.x = -quat2.x; quat2.y = -quat2.y;
		quat2.z = -quat2.z; quat2.w = -quat2.w)
		quat2
	)

	function fnBlendTransform aat bbt bias = -- aat와 bbt 두 개의 matrix3 값을 받아서 bias 대로 블랜드 된 matrix3 을 리턴한다. bias는 0 ~ 1 사이의 값이어야 한다.
	(
		rm = matrix3 1

		rotA = aat.rotation
		rotB = bbt.rotation
		
		MakeClosest rotA rotB
		rm = rm * (scaleMatrix  ((aat.scale * (1.0 - bias)) + (bbt.scale * bias)))
		rm = rm * ((slerp rotA rotB bias) as matrix3)
		rm = rm * (transMatrix ((aat.pos * (1.0 - bias)) + (bbt.pos * bias)))
	)
	
	function fnSwapArray arr id1 id2 = -- arr 배열에서 id1과 id2 의 내용을 서로 뒤바꾼다. 리턴된 배열은 원래 배열을 변경시키지 않는다.
	(
		if arr.count < id1 or arr.count < id2 do return arr -- 잘못된 아이디가 입력되면 그냥 원래 배열을 리턴
		if id1 == id2 do return arr -- 같은 번호의 아이디가 입력되어도 그냥 원래 배열을 리턴한다.
		
		if id1 > id2 do -- 배열 인덱스는 반드시 id1이 더 작다는 사실을 기준으로 작동해야 한다.
		(
			tempID = id1
			id1 = id2
			id2 = tempID
		)
		
		tempArr = deepcopy arr -- 배열 복제는 deepcopy로 해야함. 안그러면 원래 원본과 instance 관계가 될 가능성이 있는데 안전하게 하려면 deepcopy로 복제하는게 좋음.
		
		tempVar = tempArr[id1]
		tempArr[id1] = tempArr[id2]
		tempArr[id2] = tempVar
		
		return tempArr
	)
	
	function fnSwapLocalArrVar id1 id2 = -- 롤아웃에서 사용되는 로컬 변수의 자리바꿈 함수
	(
		arrPostureList = fnSwapArray arrPostureList id1 id2
		arrObjectHandle = fnSwapArray arrObjectHandle id1 id2
		arrObjectName = fnSwapArray arrObjectName id1 id2
		arrObjectTransformLocal = fnSwapArray arrObjectTransformLocal id1 id2
		arrObjectTransformWorld = fnSwapArray arrObjectTransformWorld id1 id2
		arrVP = fnSwapArray arrVP id1 id2
		arrVPTransformLocal = fnSwapArray arrVPTransformLocal id1 id2
		arrFloater = fnSwapArray arrFloater id1 id2
		arrObjectStatus = fnSwapArray arrObjectStatus id1 id2
		
		arrFloatingTempPos = fnSwapArray arrFloatingTempPos id1 id2 -- 이거 스왑하면 매우 헛갈려짐
	)
	
	-- 포스쳐 리스트 순서를 바꾸기 전에 현재 플로팅 슬라이더의 위치 정보를 기억하고 플로팅 슬라이더를 모두 닫는다.
	function fnBeforFloatingSwap =
	(
		fCount = arrFloater.count
		if fCount == 0 do return false
			
		arrFloatingTempPos = #() -- 플로팅 슬라이더 위치를 기억할 롤아웃 로컬 변수 초기화
		for o = 1 to fCount do
		(
			if arrFloater[o] == undefined then append arrFloatingTempPos undefined
				else -- 위치를 기억시키고 플로터를 닫아버린다.
				(
					append arrFloatingTempPos arrFloater[o].pos
					
					-- fnBeforFloatingSwap 함수와 fnAfterFloatingSwap 에서 삭제되고 되살아나는 플로터는 undefined로 셋팅되면 안된다.
					tempFloater = arrFloater[o] -- 플로터가 유저에 의해 닫힐 때 arrFloater[o]를 undefined 로 삭제하는 이벤트가 발생하기 때문에 삭제 전 잠시 기억해서
					closeRolloutFloater arrFloater[o] -- 플로터를 삭제하고
					arrFloater[o] = tempFloater -- 이벤트로 삭제된 arrFloater[o]의 undefined를 다시 tempFloater로 되살린다.
				)
		)
		
		return true
	)
	 
	-- 포스쳐 리스트 순서를 바꾼 뒤에 기억된 플로팅 슬라이더의 위치정보대로 다시 플로팅 슬라이더를 재생성한다.
	function fnAfterFloatingSwap =
	(
		fCount = arrFloater.count
		if fCount == 0 do return false
			
		for o = 1 to fCount do
		(
			if arrFloater[o] != undefined  and o <= 9 do
			(
				if arrFloatingTempPos[o] == undefined
					then arrFloater[o] = newRolloutFloater uiListPosture.items[o] uiFSx uiFSy
					else arrFloater[o] = newRolloutFloater uiListPosture.items[o] uiFSx uiFSy arrFloatingTempPos[o].x arrFloatingTempPos[o].y
				addRollout (execute arrRolloutName[o]) arrFloater[o]
			)
		)
		
		return true
	)
	
	-- trParent 로부터 trChild 의 로컬 위치와 로테이션과 스케일 값을 를 리턴한다.
	function fnGetLocalTransform trParent trChild = -- 입력 값은 matrix3, 리턴 값은 matrix3,
	(
		trChild*(inverse trParent)
	)
	
	-- trParent 를 기준으로 trLocal 값 만큼을 이동한 월드 트랜스폼 값을 리턴한다. 안쓸지도 모름. 이것 대신에 아마 fnApplyLocalTransform이걸 사용할듯
	function fnSetLocalTransform trParent trLocal = -- 입력 값은 Matrix3, 리턴 값은 matrix3
	(
		tempVar = trLocal*trParent
	)

	function fnApplyLocalTransform obj localTr = -- obj의 위치를 변경한다. localTr을 로컬 트랜스폼으로 간주하고 적용한다. 부모가 있으면 부모 트랜스폼을 곱해야한다.
	(
		if obj.parent == undefined then parentTransform = (matrix3 1) else parentTransform = obj.parent.transform
		
		xid = uiListPosture.selection
		oid = uiListObject.selection
		
		if xid != 0 and oid != 0 do
		(
			if arrVP[xid][oid] != undefined do tempVPnode = maxOps.getNodeByHandle arrVP[xid][oid]
			if tempVPnode != undefined do parentTransform = tempVPnode.transform
		)
		
		finalTransform = localTr * parentTransform
		if (classof obj.baseobject) == Biped_Object
		then -- 바이패드면
			(
				if uiCheckScale.state do biped.setTransform obj #scale finalTransform.scale animButtonState
				if uiCheckPosition.state do biped.setTransform obj #pos finalTransform.pos animButtonState
				if uiCheckRotation.state do biped.setTransform obj #rotation finalTransform.rotation animButtonState
			)
		else -- 바이패드가 아니면
			(
				filterTransform = matrix3 1
				if uiCheckScale.state then filterTransform = filterTransform * (scaleMatrix finalTransform.scale) else filterTransform = filterTransform * (scaleMatrix obj.transform.scale)
				if uiCheckRotation.state then filterTransform = filterTransform * (finalTransform.rotation as matrix3) else filterTransform = filterTransform * (obj.transform.rotation as matrix3)
				if uiCheckPosition.state then filterTransform =  filterTransform * (transMatrix finalTransform.position) else filterTransform = filterTransform * (transMatrix obj.transform.position)
				obj.transform = filterTransform
			)
					
	)
	
	function fnApplyWorldTransform obj worldTr = -- obj의 위치를 변경한다.
	(
		if (classof obj.baseobject) == Biped_Object
		then -- 바이패드면
			(
				if uiCheckScale.state do biped.setTransform obj #scale worldTr.scale animButtonState
				if uiCheckPosition.state do biped.setTransform obj #pos worldTr.pos animButtonState
				if uiCheckRotation.state do biped.setTransform obj #rotation worldTr.rotation animButtonState
			)
		else -- 바이패드가 아니면
			(
				filterTransform = matrix3 1
				if uiCheckScale.state then filterTransform = filterTransform * (scaleMatrix worldTr.scale) else filterTransform = filterTransform * (scaleMatrix obj.transform.scale)
				if uiCheckRotation.state then filterTransform = filterTransform * (worldTr.rotation as matrix3) else filterTransform = filterTransform * (obj.transform.rotation as matrix3)
				if uiCheckPosition.state then filterTransform = filterTransform * (transMatrix worldTr.position) else filterTransform = filterTransform * (transMatrix obj.transform.position)
				obj.transform = filterTransform
			)
	)
	
	function fnSetObjInfo = -- 현재 uiListObject의 선택된 오브젝트 내용을 informationText에 입력한다.
	(
		pid = uiListPosture.selection
		oid = uiListObject.selection
		
		if pid == 0 or oid == 0 do (informationText = ""; return ())
			
		stringVP = ""
		if arrVP[pid][oid] != undefined do
		(
			tempNode = maxOps.getNodeByHandle arrVP[pid][oid]
			if tempNode != undefined do stringVP = ", Virtual Parent = " + tempNode.name
		)
		
		tempStream = stringStream ""
		format "Object ID = %%\n" arrObjectHandle[pid][oid] stringVP to:tempStream
		if arrVPTransformLocal[pid][oid] == undefined
		then -- 가상 부모가 없으면 그냥 로컬 변수 값으로 셋팅
		(
			format "Local, pos:% rot:% sca:%\n" arrObjectTransformLocal[pid][oid].position ((arrObjectTransformLocal[pid][oid].rotation) as eulerAngles) arrObjectTransformLocal[pid][oid].scale to:tempStream
		)
		else -- 가상 부모가 있으면 가상 부모의 로컬 변수 값으로 셋팅
		(
			format "Local, pos:% rot:% sca:%\n" arrVPTransformLocal[pid][oid].position ((arrVPTransformLocal[pid][oid].rotation) as eulerAngles) arrVPTransformLocal[pid][oid].scale to:tempStream
		)
		format "World, pos:% rot:% sca:%\n" arrObjectTransformWorld[pid][oid].position ((arrObjectTransformWorld[pid][oid].rotation) as eulerAngles) arrObjectTransformWorld[pid][oid].scale to:tempStream
		
		informationText = tempStream as string
	)
	
	function fnAddRenamedTag str = -- 특정 스트링을 입력받고 -(renamed) 라는 문자열이 없으면 끝에 추가한다
	(
		if (findString str "-(renamed)") == undefined then return (str + "-(renamed)") else return str
	)
	
	function fnUpdateVar = --배열 내에 있는 오브젝트들이 제대로 있는지 검사한다. 검사 결과 문제가 있으면 변수를 조정한다.
	(
		pCount = arrPostureList.count
		if pCount == 0 do return ()
		
		for i = 1 to pCount do
		(
			oCount = arrObjectHandle[i].count
			if oCount != 0 do
			(
				for j = 1 to oCount do
				(
					tempNode = maxOps.getNodeByHandle arrObjectHandle[i][j]
					if tempNode == undefined then
					(
						case of
						(
							(uiRadioLoadType.state == 1):arrObjectStatus[i][j] = "-(deleted)" -- 씬 내에서 ID에 해당되는 오브젝트가 없는 경우 -(deleted)로 표시
							(uiRadioLoadType.state == 2):
								(
									tempNamedObj = getNodeByName arrObjectName[i][j]
									if tempNamedObj == undefined then arrObjectStatus[i][j] = "-(deleted)"
										else (arrObjectHandle[i][j] = tempNamedObj.inode.handle;arrObjectName[i][j] = tempNamedObj.name;arrObjectStatus[i][j] = "")
								)
						)
					)
					else -- 오브젝트가 있더라도 이름이 정확히 맞는지 체크
					(
						case of
						(
							(uiRadioLoadType.state == 1):if tempNode.name != arrObjectName[i][j] do arrObjectStatus[i][j] = "-(renamed)"
							(uiRadioLoadType.state == 2):
								(
									tempNamedObj = getNodeByName arrObjectName[i][j]
									if tempNamedObj == undefined then (if tempNode.name != arrObjectName[i][j] do arrObjectStatus[i][j] = "-(renamed)")
										else (arrObjectHandle[i][j] = tempNamedObj.inode.handle;arrObjectName[i][j] = tempNamedObj.name;arrObjectStatus[i][j] = "")
								)
						)
					)
					
					if arrVP[i][j] != undefined do -- VP에 내용이 있는지 검사.
					(
						if (maxOps.getNodeByHandle arrVP[i][j]) == undefined do (arrVP[i][j] == undefined;arrVPTransformLocal[i][j] = undefined) -- 해당 오브젝트가 삭제되거나 해서 찾을 수 없으면 VP 배열 내용을 undefined로 대체한다.
					)
				)
			)
		)
	)
	
	function fnRefreshUi =
	(
		uiListPosture.items = arrPostureList
		
		fnUpdateVar ()
		
		xid = uiListPosture.selection
		if xid == 0 then uiListObject.items = #()
		else
		(
			tempArray = #()
			for o = 1 to arrObjectName[xid].count do append tempArray (arrObjectName[xid][o] + arrObjectStatus[xid][o])
			uiListObject.items = tempArray
		)
		oid = uiListObject.selection
		
		if uiListPosture.selection == 0 then uiBtnRemove.enabled = false else uiBtnRemove.enabled = true
		
		fnSetObjInfo ()
		uiTextInfo.text = informationText
		
		if uiListPosture.selection >= 1 do uiBtnCreateSlider.enabled = true
		if uiListPosture.selection == 0 do uiBtnCreateSlider.enabled = false
		
		if arrFloater.count != 0 do
		(
			tempTrigger = false
			for o = 1 to arrFloater.count do (if (try (arrFloater[o].open) catch (false)) == true do tempTrigger = true) -- 하나라도 창이 열린 상태면 트리거를 true로 셋팅
			if tempTrigger == true then uiBtnCloseAllSlider.enabled = true else uiBtnCloseAllSlider.enabled = false
		)
		
		if oid == 0 then
		(
			uiPickVirtualParent.enabled = false
			uiBtnVirtualParentRemove.enabled = false
		)
		else
		(
			uiPickVirtualParent.enabled = true -- 뭔가 오브젝트 리스트에 선택된 오브젝트가 있으면 'AssignVP' 버튼을 활성화 시킨다.
			if arrVP[xid][oid] == undefined then uiBtnVirtualParentRemove.enabled = false else uiBtnVirtualParentRemove.enabled = true -- 가상 부모
		)
	)
	
	function fnIfTopInArray arr obj = -- obj가 arr 안에서 최상위 부모인지 검사. top이면 true 리턴, 뭔가 부모가 있으면 false 리턴. 뭔가 문제가 있으면 undefined 리턴
	(
		if arr.count == 0 do return undefined -- 입력된 배열 내용이 하나도 없으면 뭔가 잘못된 것임. undefined 리턴
		if (findItem arr obj) == 0 do return undefined -- obj가 arr 안에 없으면 뭔가 잘못된 것임. undefined 리턴
		
		if obj.parent == undefined do return true -- 현재 오브젝트의 부모가 없으면 일단 최상위이므로 true 리턴
		if (findItem arr obj.parent) == 0 then return true else return false -- 현재 오브젝트의 부모가 배열 안에 없으면 배열 내에서 top 이므로 true 리턴
	)
	
	function fnIfEndInArray arr obj = -- obj가 arr 안에서 최하위 노드인지 검사. end이면 true 리턴, 뭔가 아니면 false 리턴. 뭔가 문제가 있으면 undefined 리턴
	(
		if arr.count == 0 do return undefined -- 입력된 배열 내용이 하나도 없으면 뭔가 잘못된 것임. undefined 리턴
		if (findItem arr obj) == 0 do return undefined -- obj가 arr 안에 없으면 뭔가 잘못된 것임. undefined 리턴
		
		if obj.children.count == 0 do return true -- 자식이 하나도 없으면 end이므로 true 리턴
		
		xTrig = false
		for o in obj.children do (if (findItem arr o) != 0 do xTrig = true)
		if xTrig == false then return true else return false -- 자식 노드가 arr 안에서 발견되지 않으면 end 이고 발견되면 end가 아님
	)
	
-- 	fnAppendIfUnique arr var
	
	function fnSortArrByHierarchy arr = -- 입력된 arr 선택들을 계층구조 순서대로 정렬해서 리턴한다. 
	(
		if arr.count == 0 do (messagebox "fnSortArrByHierarchy 함수에 잘못된 변수가 전달되었습니다";return false)
		
		xReturnArray = #() -- 리턴될 배열 초기화
		xArray = #() -- 작업할 배열 생성
		xEndArray = #() -- arr 내에서 최하위 노드들을 기억할 배열
		
		for o in arr do if (fnIfEndInArray arr o) == true do append xEndArray o -- arr 내에서 최하위 자식들을 xEndArray에 기억시킨다.
		
		for o in xEndArray do
		(
			xObj = o -- while 안으로 들어가기 위해 일단 undefined 가 아닌 것을 넣는다.
			
			while xObj != undefined do
			(
				fnAppendIfUnique xArray xObj
				xObj = xObj.parent
				if (findItem arr xObj) == 0 do xObj = undefined -- arr 배열 내에 없는 parent 라면 그냥 undefined 임.
			)
		)
		
		for o = xArray.count to 1 by -1 do append xReturnArray xArray[o] -- xArray가 자식부터 저장된 배열이므로 다시 최종 리턴 배열에 거꾸로 넣어준다.
		
		return xReturnArray
	)
	
	function fnAddObjectList = -- 현재 선택된 오브젝트를 오브젝트 리스트에 추가한다. 그리고 롤아웃 로컬 변수도 셋팅한다.
	(

		if selection.count == 0 do return false
		
		local tempHandle = #()
		local tempName = #()
		local tempLocal = #()
		local tempWorld = #()
		local tempVP = #()
		local tempVPTransformLocal = #()
		local tempObjectStatus = #()
	
		tempSelection = fnSortArrByHierarchy (selection as array) -- 계층구조 순서로 정렬된 tempSelection을 만든다.
		
		for o = 1 to tempSelection.count do
		(		
			append tempHandle tempSelection[o].inode.handle
			append tempName tempSelection[o].name
			
			if tempSelection[o].parent == undefined
				then -- 부모 오브젝트가 없는 경우
				(
					append tempLocal (fnGetLocalTransform (matrix3 1) tempSelection[o].transform)
				)
				else -- 부모 오브젝트가 있는 경우
				(
					append tempLocal (fnGetLocalTransform tempSelection[o].parent.transform tempSelection[o].transform)
				)
			
			append tempWorld tempSelection[o].transform
			append tempVP undefined
			append tempVPTransformLocal undefined
			append tempObjectStatus ""
		)
		
		append arrObjectHandle tempHandle
		append arrObjectName tempName
		append arrObjectTransformLocal tempLocal
		append arrObjectTransformWorld tempWorld
		append arrVP tempVP
		append arrVPTransformLocal tempVPTransformLocal
		append arrObjectStatus tempObjectStatus
		
		append arrFloater undefined -- 플로팅 슬라이더 롤아웃용 변수를 초기화해준다.
		
		fnRefreshUi ()
	)
	
	function fnUpdateObjectList xid = -- 포스쳐 ID를 입력받고 해당되는 오브젝트들을 현재의 트랜스폼 정보로 업데이트 한다. fnAddObjectList 함수와 비슷함
	(
		if uiListPosture.items[xid] == undefined do return false -- 입력받은 xid가 존재하지 않는경우면 false 리턴

		local tempLocal = #()
		local tempWorld = #()
		local tempVPLocal = #()
		
		tempSelection = #()
		for o = 1 to arrObjectHandle[xid].count do append tempSelection (maxOps.getNodeByHandle arrObjectHandle[xid][o])
		
		for o = 1 to tempSelection.count do
		(		
			if arrVP[xid][o] != undefined do -- 가상부모가 지정된 경우
			(
				tempVP = (maxOps.getNodeByHandle arrVP[xid][o])
				if tempVP == undefined
					then -- 가상 부모가 여러 이유로 씬 내에서 찾을 수 없는 경우.
					(
						append tempVPLocal (fnGetLocalTransform (matrix3 1) tempSelection[o].transform)
					)
					else -- 가상 부모가 실제로 씬 내에 존재하는 경우
					(
						append tempVPLocal (fnGetLocalTransform tempVP.transform tempSelection[o].transform)
					)
			)
			
			if tempSelection[o].parent == undefined -- 가상 부모가 아닌 일반 경우.
			then -- 부모 오브젝트가 없는 경우
			(
				append tempLocal (fnGetLocalTransform (matrix3 1) tempSelection[o].transform)
			)
			else -- 부모 오브젝트가 있는 경우
			(
				append tempLocal (fnGetLocalTransform tempSelection[o].parent.transform tempSelection[o].transform)
			)
				
			append tempWorld tempSelection[o].transform
		)
		
		arrObjectTransformLocal[xid] = tempLocal
		arrObjectTransformWorld[xid] = tempWorld
		arrVPTransformLocal[xid] = tempVPLocal
		
		fnRefreshUi ()
	)
	
	function fnTrimSpaceString str = -- 입력된 스트링에서 앞 뒤 공백을 제거한 스트링을 리턴한다.
	(
		if str == undefined do return false
		if str.count == 0 do return ""
		
		tempStr = copy str
		tempStr = trimLeft tempStr
		tempStr = trimRight tempStr
		return tempStr
	)
	
	function fnCheckStringSPB str = -- 스트링의 확장자를 검사해서 spb파일인지 검사한다. 확장자명은 spb
	(
		keyword = "spb"
		if str.count <= (keyword.count + 1) do return false
		
		tempStr = ""
		tempIndex = str.count - keyword.count + 1
		for o = tempIndex to str.count do tempStr += str[o]
		
		if (stricmp keyword tempStr) == 0 do return true
		-- if (toUpper keyword) == (toUpper tempStr) do return true -- for max 2008 or higher
		return false
	)
	
	function fnSetSPBVar = -- 롤아웃 로컬 변수들을 모두 취합해서 정해진 포맷으로 정렬한 뒤 StringStream 변수 하나로 리턴
	(
		pCount = arrPostureList.count
		if pCount == 0 do return undefined
			
		tempStr = stringStream ""
		
		for i = 1 to pCount do
		(
			format "Posture = %\n" arrPostureList[i] to:tempStr
			for k = 1 to arrObjectHandle[i].count do
			(
				format "Handle = %\n" arrObjectHandle[i][k] to:tempStr
				format "Name = %\n" arrObjectName[i][k] to:tempStr
				format "LocalTransform = %\n" arrObjectTransformLocal[i][k] to:tempStr
				format "WorldTransform = %\n" arrObjectTransformWorld[i][k] to:tempStr
				format "VirtualParent = %\n" arrVP[i][k] to:tempStr
				format "VirtualParentLocalTransform = %\n" arrVPTransformLocal[i][k] to:tempStr
			)
		)
		return tempStr
	)
	
	function fnSliderChange var = -- 슬라이더가 변경될 때 하는 액션
	(
		xid = uiListPosture.selection
		if xid == 0 do return ()
		
		arrTargetObj = #() -- 대상 오브젝트 배열을 하나 만든다.
		
		oCount = arrObjectHandle[xid].count
		for o = 1 to oCount do append arrTargetObj (maxOps.getNodeByHandle arrObjectHandle[xid][o])
		
		for o = 1 to oCount do
		(
			local blendTransform
			
			case of
			(
				(uiRadioLocalWorld.state == 1): -- 로컬
					(
						if arrTargetObj[o] != undefined do -- 오브젝트가 존재할 경우에만 실행하도록 함
						(
							if arrVPTransformLocal[xid][o] == undefined
							then blendTransform = fnBlendTransform arrTempLocal[o] arrObjectTransformLocal[xid][o] var -- 로컬 기준으로 
							else
							(
								blendTransform = fnBlendTransform arrTempLocal[o] arrVPTransformLocal[xid][o] var -- VP 로컬 기준으로 
							)
							
							fnApplyLocalTransform arrTargetObj[o] blendTransform
						)
					)
				(uiRadioLocalWorld.state == 2): -- 월드
					(
						if arrTargetObj[o] != undefined do -- 오브젝트가 존재할 경우에만 실행하도록 함
						(
							blendTransform = fnBlendTransform arrTempWorld[o] arrObjectTransformWorld[xid][o] var -- 월드 기준으로
							fnApplyWorldTransform arrTargetObj[o] blendTransform
						)
					)
			)
		)
	)
	
	function fnSliderButtonDown = -- 슬라이더 버튼이 클릭될 때 최초로 실행될 작업들. 오브젝트 리스트의 트랜스폼 정보를 롤아웃 로컬 변수에 기억시켜야함.
	(
		arrTempLocal = #()
		arrTempWorld = #()
		
		xid = uiListPosture.selection
		oCount = arrObjectHandle[xid].count

		if xid == 0 do return ()
		
		for o = 1 to oCount do
		(
			tempObj = maxOps.getNodeByHandle arrObjectHandle[xid][o]
			if tempObj != undefined then -- 대상 오브젝트가 씬에 존재한다면
			(
				if tempObj.parent == undefined then tempTr = (matrix3 1) else tempTr = tempObj.parent.transform -- 임시용 tempTr 변수 셋팅
				if arrVP[xid][o] != undefined do tempVPnode = maxOps.getNodeByHandle arrVP[xid][o] -- arrVP 배열로부터 tempVPnode 오브젝트를 얻어온다.
				if tempVPnode != undefined do tempTr = tempVPnode.transform -- VP가 존재하면 VP의 트랜스폼 정보를 최종적으로 사용한다.
-- 				format "디버그 tempVP = %\n" tempVPnode.name
				append arrTempLocal (fnGetLocalTransform tempTr tempObj.transform)
				append arrTempWorld tempObj.transform
			)
			else -- 대상 오브젝트가 삭제된 상태라면 배열에는 undefined 를 넣는다.
			(
				append arrTempLocal undefined
				append arrTempWorld undefined
			)
		)
	)
	
	on uiRadioLoadType changed var do
	(
		fnRefreshUi ()
	)
	
	on uiBtnVirtualParentRemove pressed do
	(
		xid = uiListPosture.selection
		oid = uiListObject.selection
		
		if xid == 0 or oid == 0 do return ()
		
		arrVP[xid][oid] = undefined
		arrVPTransformLocal[xid][oid] = undefined
		
		fnRefreshUi ()
	)
	
	on uiPickVirtualParent picked obj do
	(
		xid = uiListPosture.selection
		oid = uiListObject.selection
		
		if xid == 0 or oid == 0 do return ()
		
		tempNode = maxOps.getNodeByHandle arrObjectHandle[xid][oid]
		if tempNode != undefined do
		(
			arrVP[xid][oid] = obj.inode.handle
			arrVPTransformLocal[xid][oid] = fnGetLocalTransform obj.transform tempNode.transform
		)
		
		fnRefreshUi ()
	)
	
	on uiBtnUpdate pressed do
	(
		xid = uiListPosture.selection -- 현재 포스쳐 리스트에서 선택된 항목 번호를 알아낸다.
		if xid == 0 do return () -- 선택이 없거나 가장 위가 선택되어 있으면 그냥 리턴한다.
		fnUpdateObjectList xid
	)

	on uiSliderBlend buttondown do -- 메인 윈도우 슬라이더에 마우스 클릭 최초 한번 실행되는 이벤트.
	(
		fnSliderButtonDown ()
	)
	
	on uiSliderBlend buttonUp do
	(
		disableSceneRedraw()
		undo Off
		(
			animate off (fnSliderChange 0.0)
		)

		undo On
		(
			fnSliderChange uiSliderBlend.value -- 슬라이더 체인지에서는 Undo를 막았으므로 Undo가 가능한 이곳에서 한번 더 변경해줌
		)
		
		enableSceneRedraw()
		redrawViews()

		uiSliderBlend.value = 0.0
		try (arrFloater[uiListPosture.selection].rollouts[1].uiSliderBlend.value = 0.0) catch ()
		fnRefreshUi () -- 오브젝트 삭제 등의 씬 변화를 수시로 확인하기 위해 슬라이더 액션의 끝에 리프레시 함수를 삽입함.
	)
	
	on uiSliderBlend changed var do
	(
		undo Off
		(
		animate off (fnSliderChange var)
		)

 		try (arrFloater[uiListPosture.selection].rollouts[1].uiSliderBlend.value = var) catch ()
	)
	
	on uiBtnLoad pressed do
	(
		spbFile = (getOpenFileName caption:"Select spb file" types:"SOX Posture Blender (*.spb)|*.spb|All (*.*)|*.*|") as string
		if spbFile == "undefined" do return ()
		if (fnCheckStringSPB spbFile) == false do (messagebox "*.spb 확장자만 지원합니다"; return())
		
		openStream = openFile spbFile mode:#rt
			
		arrPostureList = #() -- 포스쳐 이름 리스트 배열 초기화
		arrObjectHandle = #() -- 오브젝트 ID 배열 초기화
		arrObjectName = #() -- 오브젝트 이름 배열 초기화
		arrObjectTransformLocal = #() -- 오브젝트 로컬 트랜스폼 배열 초기화
		arrObjectTransformWorld = #() -- 오브젝트 월드 트랜스폼 배열 초기화
		arrVP = #() -- 가상 부모용 배열 초기화
		arrVPTransformLocal = #() -- 가상 부모용 로컬 트랜스폼 배열 초기화
		arrObjectStatus = #() -- 오브젝트 상태 체크용 배열 초기화 (이건 파일에 없는 정보임)
		
		xPos = 0 -- 포스쳐 인덱스 초기화
		while (eof openStream) != true do
		(
			tempKeyword = readDelimitedString openStream "="
			tempKeyword = trimLeft tempKeyword -- 안전을 위해 앞뒤 공백을 없앤다
			tempKeyword = trimRight tempKeyword -- 안전을 위해 앞뒤 공백을 없앤다
			
			case of
			(
				(tempKeyword == "Posture"):
					(
						xPos += 1
						tempValue = readDelimitedString openStream "\n"
						tempValue = trimRight (trimLeft tempValue)
						append arrPostureList tempValue
						arrObjectHandle[xPos] = #() -- 포스쳐에 해당되는 오브젝트 리스트를 배열로 초기화
						arrObjectName[xPos] = #() -- 포스쳐에 해당되는 오브젝트 리스트를 배열로 초기화
						arrObjectTransformLocal[xPos] = #() -- 포스쳐에 해당되는 오브젝트 리스트를 배열로 초기화
						arrObjectTransformWorld[xPos] = #() -- 포스쳐에 해당되는 오브젝트 리스트를 배열로 초기화
						arrVP[xPos] = #() -- 포스쳐에 해당되는 오브젝트 리스트를 배열로 초기화
						arrVPTransformLocal[xPos] = #() -- 포스쳐에 해당되는 오브젝트 리스트를 배열로 초기화
						arrObjectStatus[xPos] = #() -- 오브젝트 상태 체크용 배열 변수 초기화 (이건 파일에 없는 내용)
					)
				(tempKeyword == "Handle"):(tempValue = readDelimitedString openStream "\n";append arrObjectHandle[xPos] (execute tempValue))
				(tempKeyword == "Name"):(tempValue = readDelimitedString openStream "\n";append arrObjectName[xPos] (trimRight (trimLeft tempValue)))
				(tempKeyword == "LocalTransform"):(tempValue = readDelimitedString openStream "\n";append arrObjectTransformLocal[xPos] (execute tempValue))
				(tempKeyword == "WorldTransform"):(tempValue = readDelimitedString openStream "\n";append arrObjectTransformWorld[xPos] (execute tempValue))
				(tempKeyword == "VirtualParent"):(tempValue = readDelimitedString openStream "\n";append arrVP[xPos] (execute tempValue))
				(tempKeyword == "VirtualParentLocalTransform"):(tempValue = readDelimitedString openStream "\n";append arrVPTransformLocal[xPos] (execute tempValue))
			)
			append arrObjectStatus[xPos] ""
		)
		fnRefreshUi ()
	)
	
	-- via http://forums.cgsociety.org/archive/index.php/t-1087734.html
	-- Thanx denis and diccy
	on uiBtnSave pressed do if uiListPosture.items.count == 0 then false else
	( 
		file = (getSaveFileName caption:"Save spb file" types:"SOX Posture Blender (*.spb)|*.spb|All (*.*)|*.*|")

		if (file != undefined) and (ss = createFile file) != undefined do
		(
		format "%\n" (fnSetSPBVar() as string) to:ss

		flush ss
		close ss
		true
		)
	)
	
	on uiBtnPostureUp pressed do
	(
-- 		fnSwapLocalArrVar id1 id2
		xid = uiListPosture.selection -- 현재 포스쳐 리스트에서 선택되 항목 번호를 알아낸다.
		if xid == 0 or xid == 1 do return () -- 선택이 없거나 가장 위가 선택되어 있으면 그냥 리턴한다.
		
		fnBeforFloatingSwap () -- 포스쳐 리스트를 스왑하기 전에 플로팅 창을 기억하고 삭제
		fnSwapLocalArrVar xid (xid - 1) -- 스왑~
		if xid == 10 do arrFloater[9] = undefined -- 예외처리, 플로터는 9번까지만 지원하기때문에 10번을 9번과 자리바꿈하게 되면 아무것도 없는 undefined로 9번을 강제로 채워야 한다.
		fnRefreshUi ()
		fnAfterFloatingSwap () --스왑한 뒤 스왑된 기준으로 다시 플로팅 창을 되살린다.
		
		uiListPosture.selection = xid - 1
		fnRefreshUi ()
	)
	
	on uiBtnPostureDown pressed do
	(
-- 		fnSwapLocalArrVar id1 id2
		xid = uiListPosture.selection -- 현재 포스쳐 리스트에서 선택되 항목 번호를 알아낸다.
		if xid == 0 or  uiListPosture.items.count <= 1 or xid == uiListPosture.items.count do return () -- 선택이 없거나 가장 아래가 선택되어 있거나 리스트에 아이템이 하나뿐이면 그냥 리턴한다.
		
		fnBeforFloatingSwap () -- 포스쳐 리스트를 스왑하기 전에 플로팅 창을 기억하고 삭제
		fnSwapLocalArrVar xid (xid + 1) -- 스왑~
		if xid == 9 do arrFloater[9] = undefined -- 예외처리, 플로터는 9번까지만 지원하기때문에 9번과 10번을 자리바꿈하게 되면 아무것도 없는 undefined로 9번을 강제로 채워야 한다.
		fnRefreshUi ()
		fnAfterFloatingSwap () --스왑한 뒤 스왑된 기준으로 다시 플로팅 창을 되살린다.
		
		uiListPosture.selection = xid + 1
		fnRefreshUi ()
	)
	
	on uiBtnCreateSlider pressed do
	(
		xid = uiListPosture.selection -- 현재 포스쳐 리스트에서 선택되 항목 번호를 알아낸다.
		if xid == 0 do return ()
		
		if xid >= 10 do (messagebox "플로팅 슬라이더는 Posture List 상위 9개 항목만 지원됩니다";return ())
		
		try (closeRolloutFloater arrFloater[xid]) catch ()
		arrFloater[xid] = newRolloutFloater uiListPosture.selected uiFSx uiFSy
		
		addRollout (execute arrRolloutName[xid]) arrFloater[xid]
		
		fnRefreshUi ()
	)
	
	on uiBtnCloseAllSlider pressed do
	(
		if arrFloater.count == 0 do return ()
		
		for o = 1 to arrFloater.count do (try (closeRolloutFloater arrFloater[o]) catch ())
	)
	
	on uiBtnRefresh pressed do
	(
		fnRefreshUi ()
	)
	
	on uiTextPostureName changed var do
	(
		uiBtnAdd.enabled = true
		if var == "" do uiBtnAdd.enabled = false
	)
	
	on uiListPosture doubleClicked var do
	(
		tempObj = #()
		for o = 1 to arrObjectHandle[var].count do append tempObj (maxOps.getNodeByHandle arrObjectHandle[var][o])
		select tempObj
	)
	
	on uiListObject doubleClicked var do
	(
		tempNode = maxOps.getNodeByHandle arrObjectHandle[uiListPosture.selection][var]
		if tempNode == undefined then fnRefreshUi () else select tempNode -- 사용자에 의해 지워진 노드일 수 있음.
	)
	
	on uiListPosture selected var do
	(
		fnRefreshUi ()
	)
	
	on uiListObject selected var do
	(
		fnRefreshUi ()
	)
	
	on uiBtnRemove pressed do
	(
-- 		arrFloater -- 플로터용 배열 변수
		
		xid = uiListPosture.selection
		if xid == 0 do return ()
		
		deleteItem arrPostureList xid
		deleteItem arrObjectHandle xid
		deleteItem arrObjectName xid
		deleteItem arrObjectTransformLocal xid
		deleteItem arrObjectTransformWorld xid
		deleteItem arrVP xid
		deleteItem arrVPTransformLocal xid
		deleteItem arrObjectStatus xid
		
		try (closeRolloutFloater arrFloater[xid]) catch ()
		try (deleteItem arrFloater xid) catch () -- 플로터용 배열 변수에서 삭제
		
		 -- 포스쳐 리스트에서 아이템을 삭제할 때 리스트에 아무것도 선택되지 않은 상황이 되기 쉬운데 이런 상황은 버그 발생 확률을 높인다. 그래서 리스트에 무언가라도 있으면 선택하도록 보완
		if uiListPosture.selection == 0 and uiListPosture.items.count >= 1 do uiListPosture.selection = uiListPosture.items.count
		
		fnRefreshUi ()
	)
	
	on uiBtnAdd pressed do
	(
		if selection.count == 0 do return () -- 선택이 아무것도 없으면 그냥 리턴
		
		tempString = fnTrimSpaceString uiTextPostureName.text -- 입력된 포스쳐 이름을 앞뒤 공백 잘라서 tempString 변수에 넣는다.
		if tempString.count == 0 do return ()
		
		if (fnAppendIfUnique arrPostureList tempString) == true 
		then (fnAddObjectList ();uiTextPostureName.text = "";uiBtnAdd.enabled = false) -- 포스쳐 이름이 새로 추가될 경우
		else (uiTextInfo.text = "중복된 이름입니다";return ()) -- 포스쳐 이름이 중복될 경우
		
		uiListPosture.selection = uiListPosture.items.count
		uiListObject.items = arrObjectName[uiListPosture.items.count]
		fnSetObjInfo ()
		fnRefreshUi ()
	)
	
	on SOXPostureBlender open do
	(
		uiBtnAdd.enabled = false
		uiBtnRemove.enabled = false
		
-- 		uiRadioLoadType.enabled = false
		
		uiBtnCreateSlider.enabled = false
		uiBtnCloseAllSlider.enabled = false
		
		uiPickVirtualParent.enabled = false
		uiBtnVirtualParentRemove.enabled = false
	)
	
	on SOXPostureBlender close do
	(
		uiBtnCloseAllSlider.pressed ()
	)
	
on uiBtnHelp pressed do
(
tempString = "저작권 : 이 툴은 어떤 목적으로든 사용할 수 있습니다. 하지만 내용을 수정하거나 상업적인 목적으로 재 판매하는 것은 금지됩니다.
만든이 : 이상원

툴의 목적 : 페이셜 작업용 컨트롤 오브젝트나 손가락의 다양한 Preset 형태들을 기억시키고, 기억된 형태로 쉽게 블랜드 할 수 있는 툴입니다.

Add : 현재 선택된 오브젝트들을 등록합니다. Posture 이름을 지정하지 않으면 등록되지 않습니다.
Remove : 등록된 Posture를 삭제합니다. Posture List에서 선택된 Posture가 삭제됩니다.
Refresh : 툴이 인식하지 못하는 씬의 변화가 발생했을 경우 변화를 반영합니다. 오브젝트가 삭제되거나 씬이 새로 불러졌을 때 주로 사용됩니다.
주의, 씬 내에서 삭제된 오브젝트들이 리스트에 섞여있는 경우의 버그 테스트가 아직 완벽하지 않습니다. 혹시 삭제된 오브젝트와 관련해서 툴의 오류가 발생되면 'Site' 버튼을 눌러서 해당 상황을 알려주세요
Load, Save : 현재 포스쳐 리스트와 오브젝트 리스트를 파일로 저장하거나 불러들입니다.
Site : 이 툴의 공식 웹 페이지를 방문합니다.
Update Posture : Object List에 저장된 오브젝트의 트랜스폼 정보를 현재 상태 기준으로 새로 적용합니다.
Assign VP : VP는 Virtual Parent의 약자입니다. 바이패드 프랍 오브젝트의 경우처럼 계층구조상의 부모와 실제 움직이는 부모가 달라야 하는 경우 가상의 부모를 선택할 수 있는 버튼입니다. 가상의 부모가 지정되는 순간의 오브젝트 자세가 기준이 되는 점을 주의해야 합니다.
Remove VP : 가상의 부모 오브젝트 지정을 해제합니다.
Create Floater : Posture List에서 일일이 Posture를 선택하고 슬라이더를 조절하는게 불편해서 Posture마다 독립된 슬라이더를 플로터 형태로 생성하는 기능입니다. 최대 9개까지 생성이 가능하며 Posture List에서 위에서부터 9개까지만 생성 가능합니다.
Close All Floater : 화면에 표시된 모든 플로터를 제거합니다.
Blend Type : Object List에 저장된 트랜스폼 정보를 월드 기준으로 적용할지 로컬 기준으로 적용할지를 결정합니다.
Position, Rotation, Scale 체크박스 ; Object List에 저장된 트랜스폼 정보에서 원하는 컨트롤러만 선택적으로 적용할 수 있습니다.
Load Type : Name 옵션을 선택할 경우 오브젝트 내부 ID에서 찾지 못하더라도 이름이 같은 오브젝트가 발견되면 해당 오브젝트를 대신 사용합니다.
"
	messagebox tempString title:"SOX Posture Blender Help"
)
	
	on uiBtnSite pressed do
	(
		shellLaunch "http://cafe.naver.com/pinksox/2894" ""
	)
)
createDialog SOXPostureBlender style:#(#style_titlebar, #style_toolwindow, #style_sysmenu)

