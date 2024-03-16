-- 만든이 : 이상원
-- 사용 및 수정은 자유입니다. 하지만 재 배포는 금지합니다.

global SoxBipedAssist		-- 롤아웃명을 글로벌 변수로 인식하기 위해 초기에 한 번 사용

try (destroydialog SoxBipedAssist) catch()		-- 혹시 열려있는 창이 있으면 강제 종료

rollout SoxBipedAssist "Sox BipedAssist v0.422"
(
	local mc_setKeyColor = color 140 0 0
	local mc_spineColor = color 8 110 134
	
	checkButton uiChkBtnScanBiped "Scan Biped" width:70 checked:true highlightColor:(color 180 0 80) tooltip:"Cache biped selection for faster operation. If the configuration of the Biped changes, scan again. If you have multiple bipeds, scan the selected ones. (Kor) 바이패드 선택을 캐싱 해서 빠르게 작동할 수 있게 합니다. 바이패드의 구성이 변경되면 다시 스캔하세요. 바이패드가 여러개라면 선택된 것을 스캔합니다." across:2
	button uiAbout "About"
	
	checkBox uiChkSelHiddenObj "Select hidden biped" checked:true
	
	checkButton uiHead "Head" width: 50 height:33 checked:true highlightColor:(color 55 137 221) offset:[0, -4]
	checkButton uiNecks "Necks" width: 35 checked:true highlightColor:mc_spineColor align:#center offset:[0, -4]
	
	checkButton uiRArms "Arms" checked:true highlightColor:(color 6 95 6) width:34 align:#left offset:[-8, -30] across:2
	checkButton uiLArms "Arms" checked:true highlightColor:(color 28 28 128) width:34 align:#right offset:[8, -30]
	
	checkButton uiRClavicle "R Clavicle" width:54 height:16 checked:true highlightColor:(color 6 134 6) across:2
	checkButton uiLClavicle "L Clavicle" width:54 height:16 checked:true highlightColor:(color 28 28 177)
	
	checkButton uiAllSpine height:58 width:26 checked:true highlightColor:mc_spineColor offset:[-12, -4] align:#center tooltip:"All Spine"
	checkButton uiSpine2 "2" width:26 height:18 checked:true highlightColor:mc_spineColor align:#center offset:[16, -62]
	checkButton uiSpine1 "1" width:26 height:18 checked:true highlightColor:mc_spineColor align:#center offset:[16, -4]
	checkButton uiSpine0 "0" width:26 height:18 checked:true highlightColor:mc_spineColor align:#center offset:[16, -4]
	
	checkButton uiCOM "COM" checked:true width:42 height:22 highlightColor:(color 55 137 221) offset:[0, -4]
	checkButton uiPelvis "Pelvis" checked:true highlightColor:(color 161 134 25) width:50 height:18 offset:[0, -4]
	
	checkButton uiRUpArm "R" width:25  height:30 offset:[-18, -104] checked:true highlightColor:(color 6 134 6) across:2
	checkButton uiLUpArm "L" width:25  height:30 offset:[18, -104] checked:true highlightColor:(color 28 28 177)
	checkButton uiRForArm "R" width:25  height:30 offset:[-18, -4] checked:true highlightColor:(color 6 134 6) across:2
	checkButton uiLForArm "L" width:25  height:30 offset:[18, -4] checked:true highlightColor:(color 28 28 177)
	checkButton uiRHand "Hand" offset:[-22, -4] checked:true highlightColor:(color 6 134 6) across:2
	checkButton uiLHand "Hand" offset:[22, -4] checked:true highlightColor:(color 28 28 177)
	
	checkButton uiRThigh "R" width:25  height:30 align:#right checked:true highlightColor:(color 6 134 6) offset:[-4, 12] across:2
	checkButton uiLThigh "L" width:25 height:30 align:#left checked:true highlightColor:(color 28 28 177) offset:[4, 12]
	checkButton uiRCalf "R" width:25  height:30 checked:true highlightColor:(color 6 134 6) align:#right  offset:[-4, -4] across:2
	checkButton uiLCalf "L" width:25  height:30 checked:true highlightColor:(color 28 28 177) align:#left offset:[4, -4]
	checkButton uiRFoot "R Foot" checked:true highlightColor:(color 6 134 6) align:#right offset:[0, -4] width:43 height:25 across:2
	checkButton uiLFoot "L Foot" checked:true highlightColor:(color 28 28 177) align:#left offset:[0, -4] width:43 height:25
	
	checkButton uiRLegs "Legs" checked:true highlightColor:(color 6 95 6) width:30 align:#left offset:[-4, -70] across:2
	checkButton uiLLegs "Legs" checked:true highlightColor:(color 28 28 128) width:30 align:#right offset:[4, -70]
	
	checkButton uiRToe "toe" checked:true highlightColor:(color 6 134 6) width:25 height:18 align:#left offset:[-3, 22] across:2
	checkButton uiLToe "toe" checked:true highlightColor:(color 28 28 177) width:25 height:18 align:#right offset:[3, 22]
	
	checkButton uiAllFoot "All Foot" width:60 checked:true highlightColor:mc_spineColor align:#center  offset:[0, 0]
	checkButton uiAllBip "All Biped" width:100 checked:true highlightColor:(color 55 137 221) offset:[0, -4] align:#center
		
	group "Keyframe Assist" (
		checkButton uiBtnSetAllKey "Set All Key" checked:true highlightColor:mc_setKeyColor offset:[6, 0] across:3
		checkButton uiBtnLimbIK "IK" tooltip:"Shift + Click - apply to all keys, Ctrl + Click - Apply to selected keys. (Shift 클릭 - 모든 키에 적용, Ctrl 클릭 - 선택된 키에 적용)" checked:true highlightColor:(color 168 170 13) offset:[22, 0]
		checkButton uiBtnLimbFK "FK" tooltip:"Shift + Click - apply to all keys, Ctrl + Click - Apply to selected keys. (Shift 클릭 - 모든 키에 적용, Ctrl 클릭 - 선택된 키에 적용)" checked:true highlightColor:(color 86 87 7) offset:[8, 0]
        
		label uiLabelLoopRagne "Loop" tooltip:"Loop Range" align:#left offset:[-2, 2] across:4
		spinner uiSpnLoopStart tooltip:"Loop Range" type:#integer range:[-9999,9999,0] width:40 align:#left offset:[-12, 2]
		spinner uiSpnLoopEnd tooltip:"Loop Range" type:#integer range:[-9999,9999,30] width:40 align:#left offset:[-6, 2]
		button uiBtnGotoMirror "Mirror" tooltip:"Go to Mirror frame" align:#right offset:[8, -2] width:38
		checkButton uiBtnLoopTrim "Trim" width:40 offset:[-3, -2] checked:true highlightColor:mc_setKeyColor tooltip:"Delete keys outside the Loop" across:4
		-- 앞 뒤로 복제 기능은 만들다 중단. (일일이 자세를 복사해주는 방법을 시도했는데 너무 느림)
		-- Shift 복제처럼 KeyArray를 한 방에 복제해주는 방법을 써야할듯. 일반 오브젝트는 복제가 되는데 바이패드는 안됨.
		-- checkButton uiBtnLoopDupe "Dupl." width:40 offset:[6, 0] checked:true highlightColor:(color 60 0 0) tooltip:"Duplicate the keys before and after the Loop."
		checkButton uiBtnLoopSel "Sel." width:40 offset:[6, -2] checked:true highlightColor:(color 123 74 0) align:#center tooltip:"Select keys in the looping range."
		button uiBtnLoopGet "Get" offset:[12, -2] width:30 tooltip:"Get current time"
		button uiBtnLoopSet "Set" offset:[10, -2] width:30
    )
	
	group "Animation Range" (
		spinner uiSpnAnimRangeAStart type:#integer range:[-9999,9999,0] width:40 offset:[-10, 0] across:4
		spinner uiSpnAnimRangeAEnd type:#integer range:[-9999,9999,30] width:40
		button uiBtnAnimRangeAGet "Get" offset:[12, -2] width:30 tooltip:"Get current time"
		button uiBtnAnimRangeASet "Set" offset:[10, -2] width:30
		
		spinner uiSpnAnimRangeBStart type:#integer range:[-9999,9999,-20] width:40 offset:[-10, 0] across:4
		spinner uiSpnAnimRangeBEnd type:#integer range:[-9999,9999,30] width:40
		button uiBtnAnimRangeBGet "Get" offset:[12, -2] width:30 tooltip:"Get current time"
		button uiBtnAnimRangeBSet "Set" offset:[10, -2] width:30
		
		/*
		spinner uiSpnAnimRangeCStart type:#integer range:[-9999,9999,0]width:40 offset:[-10, 0] across:4
		spinner uiSpnAnimRangeCEnd type:#integer range:[-9999,9999,50] width:40
		button uiBtnAnimRangeCGet "Get" offset:[10, -2] tooltip:"Get current time"
        button uiBtnAnimRangeCSet "Set" offset:[10, -2]
        */
	)
	
	local mc_gotoSize = 20
	button uiBtnGoto1 align:#center offset:[-6, -6] width:mc_gotoSize across:8
	button uiBtnGoto2 align:#center offset:[-5, -6] width:mc_gotoSize
	button uiBtnGoto3 align:#center offset:[-4, -6] width:mc_gotoSize
	button uiBtnGoto4 align:#center offset:[-3, -6] width:mc_gotoSize
	button uiBtnGoto5 align:#center offset:[3, -6] width:mc_gotoSize
	button uiBtnGoto6 align:#center offset:[4, -6] width:mc_gotoSize
	button uiBtnGoto7 align:#center offset:[5, -6] width:mc_gotoSize
	button uiBtnGoto8 align:#center offset:[6, -6] width:mc_gotoSize
	
	dropdownlist uiDropPlaySpeed items:#("1/4x Speed", "1/2x Speed", " 1x Speed", "2x Speed", "4x Speed") selection:3 tooltip:"Playback Speed" width:90 offset:[-8, 0] across:2
	checkbutton uiPlayBlock "Play.B" offset:[14, 0] width:54 tooltip:"Play blocking animation of selected biped objects"
	timer clock "PlayClock" interval:1 active:false -- 가장 빠른 인터벌로
	
	--button uiBtnTest "Test"

	/*
	group "Hide / Unhide"
	(
		button uiBtnHideSel "Hide sel." across:2
		button uiBtnUnhideSel "Unhide sel."
	)
	*/

    local m_workingBipRoot -- 현재 작업중인 바이패드의 루트 노드
    
	-- 시인성을 위해 예외적으로 m_ 뒤에 대문자 사용
	-- 모든 부위 변수들은 배열
	local m_Head
	local m_RArms
	local m_Necks
	local m_LArms
	local m_RClavicle
	local m_LClavicle
	local m_RUpArm
	local m_AllSpine
	local m_Spine2
	local m_Spine1
	local m_Spine0
	local m_LUpArm
	local m_RForArm
	local m_LForArm
	local m_RHand
	local m_COM
	local m_LHand
	local m_Pelvis
	local m_RThigh
	local m_LThigh
	local m_RCalf
	local m_LCalf
	local m_RFoot
	local m_LFoot
	local m_RToe
	local m_LToe
	local m_RLegs
	local m_AllFoot
	local m_LLegs
	local m_AllBip

	local m_goto1
	local m_goto2
	local m_goto3
	local m_goto4
	local m_goto5
	local m_goto6
	local m_goto7
    local m_goto8
    
    local m_PBKeyTimeArray      -- 블럭킹 애니메이션용 키 타임 배열 로컬 변수 (Frame)
    local m_PBKeyMiliSecArray  -- 블럭킹 애니메이션용 키 타임 배열 로컬 변수 (밀리세컨드)
    local m_PBStartTime     -- 블럭킹 애니메이션 반복 시작시간 비교용 기록
    local m_PBPointer       -- 어디까지 재생중인지 기록하는 포인터
    local m_PBPlaySpeed     -- 재생 속도 가속 감속용, uiDropPlaySpeed 와 연동됨
	
	struct BipType
	(
		limbName,
		linkIndex
    )
    
    function SetPBPlaySpeed = (
        case timeConfiguration.playbackSpeed of (
        1: (m_PBPlaySpeed = 4.0) -- 1/4 속도라서 4배 더 큰 시간 값을 적용해야함
        2: (m_PBPlaySpeed = 2.0)
        3: (m_PBPlaySpeed = 1.0)
        4: (m_PBPlaySpeed = 0.5)
        5: (m_PBPlaySpeed = 0.25) -- 4배 속도라서 0.25배 작은 시간값을 적용해야함
        )
    )

	-- 바이패드 COM인지 검사
	fn IfBipRoot obj = (
		if ((classof obj.baseobject) == Biped_Object) do (
			if (obj.controller.rootNode == obj) do (return true)
		)
		return false
	)

	fn SaveRangeLoop = (
		if (m_workingBipRoot == undefined or (isDeleted m_workingBipRoot)) do return ()
		setUserProp m_workingBipRoot "SoxBA_RangeLoopStart" uiSpnLoopStart.value
		setUserProp m_workingBipRoot "SoxBA_RangeLoopEnd" uiSpnLoopEnd.value
	)

	fn LoadRangeLoop = (
		if (m_workingBipRoot == undefined or (isDeleted m_workingBipRoot)) do return ()
		try (
			uiSpnLoopStart.value = getUserProp m_workingBipRoot "SoxBA_RangeLoopStart"
			uiSpnLoopEnd.value = getUserProp m_workingBipRoot "SoxBA_RangeLoopEnd"
		) catch ()
	)

	fn SaveRangeA = (
		if (m_workingBipRoot == undefined or (isDeleted m_workingBipRoot)) do return ()
		setUserProp m_workingBipRoot "SoxBA_RangeAStart" uiSpnAnimRangeAStart.value
		setUserProp m_workingBipRoot "SoxBA_RangeAEnd" uiSpnAnimRangeAEnd.value
	)

	fn LoadRangeA = (
		if (m_workingBipRoot == undefined or (isDeleted m_workingBipRoot)) do return ()
		try (
			uiSpnAnimRangeAStart.value = getUserProp m_workingBipRoot "SoxBA_RangeAStart"
			uiSpnAnimRangeAEnd.value = getUserProp m_workingBipRoot "SoxBA_RangeAEnd"
		) catch ()
	)

	fn SaveRangeB = (
		if (m_workingBipRoot == undefined or (isDeleted m_workingBipRoot)) do return ()
		setUserProp m_workingBipRoot "SoxBA_RangeBStart" uiSpnAnimRangeBStart.value
		setUserProp m_workingBipRoot "SoxBA_RangeBEnd" uiSpnAnimRangeBEnd.value
	)

	fn LoadRangeB = (
		if (m_workingBipRoot == undefined or (isDeleted m_workingBipRoot)) do return ()
		try (
			uiSpnAnimRangeBStart.value = getUserProp m_workingBipRoot "SoxBA_RangeBStart"
			uiSpnAnimRangeBEnd.value = getUserProp m_workingBipRoot "SoxBA_RangeBEnd"
		) catch ()
	)

	fn LoadGoto = (
		if (m_workingBipRoot == undefined or (isDeleted m_workingBipRoot)) do return ()
		try (
			m_goto1 = getUserProp m_workingBipRoot "SoxBA_Goto1"
			if (m_goto1 == "undefined") do (m_goto1 = undefined)
			m_goto2 = getUserProp m_workingBipRoot "SoxBA_Goto2"
			if (m_goto2 == "undefined") do (m_goto2 = undefined)
			m_goto3 = getUserProp m_workingBipRoot "SoxBA_Goto3"
			if (m_goto3 == "undefined") do (m_goto3 = undefined)
			m_goto4 = getUserProp m_workingBipRoot "SoxBA_Goto4"
			if (m_goto4 == "undefined") do (m_goto4 = undefined)
			m_goto5 = getUserProp m_workingBipRoot "SoxBA_Goto5"
			if (m_goto5 == "undefined") do (m_goto5 = undefined)
			m_goto6 = getUserProp m_workingBipRoot "SoxBA_Goto6"
			if (m_goto6 == "undefined") do (m_goto6 = undefined)
			m_goto7 = getUserProp m_workingBipRoot "SoxBA_Goto7"
			if (m_goto7 == "undefined") do (m_goto7 = undefined)
			m_goto8 = getUserProp m_workingBipRoot "SoxBA_Goto8"
			if (m_goto8 == "undefined") do (m_goto8 = undefined)
		) catch ()
	)

	fn SaveGoto ui val index = (
		if (m_workingBipRoot == undefined or (isDeleted m_workingBipRoot)) do return ()
		local pString = "SoxBA_Goto" + (index as string)
		try (
			setUserProp m_workingBipRoot pString val
		) catch ()
	)

	fn SetGotoBtnTextSub ui val = (
		local tString
		if (val == undefined) then (tString = "") else (tString = (val as string))
		ui.text = tString
		ui.tooltip = tString
	)

	fn SetGotoBtnText = (
		SetGotoBtnTextSub uiBtnGoto1 m_goto1
		SetGotoBtnTextSub uiBtnGoto2 m_goto2
		SetGotoBtnTextSub uiBtnGoto3 m_goto3
		SetGotoBtnTextSub uiBtnGoto4 m_goto4
		SetGotoBtnTextSub uiBtnGoto5 m_goto5
		SetGotoBtnTextSub uiBtnGoto6 m_goto6
		SetGotoBtnTextSub uiBtnGoto7 m_goto7
		SetGotoBtnTextSub uiBtnGoto8 m_goto8
	)

	-- m_goto1 등의 변수를 참조 형식으로 &val 매개변수에 전달
	fn GotoFrame ui &val index = (
		if (keyboard.controlPressed) do (
			val = int sliderTime
			SetGotoBtnText()
			SaveGoto ui val index
			return ()
		)

		if (keyboard.altPressed) do (
			val = undefined
			SetGotoBtnText()
			SaveGoto ui val index
			return ()
		)

		if (val != undefined) do (
			try (
				sliderTime = val
			) catch ()
		)
	)
	
		-- 리턴 스트럭쳐의 멤버 : limbName, linkIndex
	function GetBipedType obj = (
		if ( obj == undefined ) do return undefined
		if ( (classof obj.baseobject) != Biped_Object ) do return (bipType limbName:#nonBiped linkIndex:0)
		
		-- biped.maxNumLinks $ 이 방법으로 바이패드의 최대 링크 수를 알아낼 수 있다. 보통 25이지만 넉넉하게 30
		loopCount = 30
		types = #(
			#larm,
			#rarm,
			#lfingers,
			#rfingers,
			#lleg,
			#rleg,
			#ltoes,
			#rtoes,
			#spine,
			#tail,
			#head,
			#pelvis,
			#vertical,
			#horizontal,
			#turn,
			#footprints,
			#neck,
			#pony1,
			#pony2,
			#prop1,
			#prop2,
			#prop3,
			#lfArmTwist,
			#rfArmTwist,
			#lUparmTwist,
			#rUparmTwist,
			#lThighTwist,
			#rThighTwist,
			#lCalfTwist,
			#rCalfTwist,
			#lHorseTwist,
			#rHorseTwist			
		)
		
		for o in types do (
			for p = 1 to loopCount do (
				if ( try ( obj == biped.getNode obj o link:p ) catch false ) do (
					returnType = (bipType limbName:o linkIndex:p)
					return returnType
				)
			)
		)
		
		-- 맥스 스크립트에서 Xtra 본을 전혀 지원하지 않아서 어쩔 수 없이 바이패드 클래스인데 정체를 알아내지 못한건 모두 Xtra로 정의
		-- https://forums.cgsociety.org/t/biped-xtra-maxscript-commands/1570351/5 숨겨진 바이패드 Xtra 함수들을 좀 살펴봐야할듯.
		return (bipType limbName:#xtra linkIndex:0)
	)
	
	-- 현재 오브젝트가 애니메이션 키 지정이 가능한 바이패드인지를 검사 true 와 false 리턴
	function IfKeyableBip obj =
	(
		if ( classof obj.baseobject != Biped_object ) do return false
		
		tType = GetBipedType obj
		
		returnBool = case tType.limbName of
		(
			#footprints: false
			#lfArmTwist: false
			#rfArmTwist: false
			#lUparmTwist: false
			#rUparmTwist: false
			#lThighTwist: false
			#rThighTwist: false
			#lCalfTwist: false
			#rCalfTwist: false
			#lHorseTwist: false
			#rHorseTwist: false
			default: true
		)
		return returnBool
	)
	
	-- 바이패드 부위들 중 Limb, COM, NoKey, Etc 를 구분하여 리턴 (애니메이션 키 복제 방식이 다름)
	function GetBipKeyType obj = (
		if ( classof obj.baseobject != Biped_object ) do return false
		
		tType = GetBipedType obj

		if tType.limbName == #vertical OR\
			tType.limbName == #horizontal OR\
			tType.limbName == #turn do (
			return "COM"
		)

		if tType.limbName == #larm OR\
			tType.limbName == #rarm OR\
			tType.limbName == #lleg OR\
			tType.limbName == #rleg OR\
			tType.limbName == #ltoes OR\
			tType.limbName == #rtoes do (
				return "Limb"
		)

		if tType.limbName == #lfArmTwist OR\
			tType.limbName == #rfArmTwist OR\
			tType.limbName == #lUparmTwist OR\
			tType.limbName == #rUparmTwist OR\
			tType.limbName == #lThighTwist OR\
			tType.limbName == #rThighTwist OR\
			tType.limbName == #lCalfTwist OR\
			tType.limbName == #rCalfTwist OR\
			tType.limbName == #lHorseTwist OR\
			tType.limbName == #rHorseTwist OR\
			tType.limbName == #footprints do (
				return "NoKey"
		)
		
		return "Etc"
	)

	-- 바이패드 Limb 전용 기능을 위해 Limb 인지 체크하는 함수
	function IfLimb obj = (
		if ( classof obj.baseobject != Biped_object ) do return false
		tType = GetBipedType obj
		if tType.limbName == #larm OR\
			tType.limbName == #rarm OR\
			tType.limbName == #lleg OR\
			tType.limbName == #rleg OR\
			tType.limbName == #ltoes OR\
			tType.limbName == #rtoes do (
				return true
		)
		return false
	)
	
    fn DeselectAllKeys obj = (
		-- 처음엔 복잡한 방법으로 일일이 키 하나씩 루프 돌아가며 선택 해제했는데, 뭉뚱그려서 controller 로 하니 잘 되는듯
		deselectKeys obj.controller
	)
	
	-- 이 함수는 삭제 전 Deselect 는 고려하지 않음. (기존에 Deselect 되어서 진입한 것을 전제로 함)
	fn TrimKeys controller frameStart frameEnd ifBip = (
		local firstKeyTime
		local lastKeyTime
		if (ifBip) then (
			local keyCount = numKeys controller
			if keyCount < 1 do return()
			firstKeyTime = (getKey controller 1).time
			lastKeyTime = (getKey controller keyCount).time
		)
		else (
			firstKeyTime = -99999
			lastKeyTime = 99999
		)

		if (firstKeyTime < frameStart) do (
			-- 보존 구간보다 앞쪽에 키가 있는 경우
			selectKeys controller (interval firstKeyTime (frameStart - 1))
		)
		if (lastKeyTime > frameEnd) do (
			-- 보존 구간보다 뒤쪽에 키가 있는 경우
			selectKeys controller (interval lastKeyTime (frameEnd + 1))
		)

		if (ifBip) then (
			biped.deleteKeys controller #selection
		)
		else (
			deleteKeys controller #selection
		)
	)

    -- obj 의 모든 자식들을 배열로 리턴. 배열 순서는 계층구조 순서대로
	function fnGetAllChildren obj = (
		if ( obj == undefined ) do return undefined
		
		local tAllChildren = #()
		if ( obj.children.count != 0 ) do (
			for o in obj.children do (
				append tAllChildren o
				if ( o.children.count != 0 ) do (
					tAllChildren = tAllChildren +  (fnGetAllChildren o)		-- recursive
				)
			)
		)
		return tAllChildren
	)
	
    fn SetComBtnText state = (
        if state then (
            uiCOM.text = m_workingBipRoot.name
        )
        else (
            uiCOM.text = "COM"
        )
    )

    fn SetButtonState state = (
        uiHead.state = state
        uiRArms.state = state
        uiNecks.state = state
        uiLArms.state = state
        uiRClavicle.state = state
        uiLClavicle.state = state
        uiRUpArm.state = state
		uiAllSpine.state = state
		uiSpine2.state = state
		uiSpine1.state = state
		uiSpine0.state = state
        uiLUpArm.state = state
        uiRForArm.state = state
        uiLForArm.state = state
        uiRHand.state = state
        uiCOM.state = state
        if state == false do uiCOM.text = "COM"
        uiLHand.state = state
        uiPelvis.state = state
        uiRThigh.state = state
        uiLThigh.state = state
        uiRCalf.state = state
        uiLCalf.state = state
        uiRFoot.state = state
		uiLFoot.state = state
		uiRToe.state = state
		uiLToe.state = state
        uiRLegs.state = state
        uiAllFoot.state = state
        uiLLegs.state = state
		uiAllBip.state = state
		uiPlayBlock.state = state
    )
	
	-- 씬 내 바이패드 오브젝트를 모두 조사하여 바이패드가 하나만 있으면 그 바이패드를 m_workingBipRoot에 세팅.
	-- 현재 선택된 오브젝트가 바이패드면 그것을 세팅
	-- 선택이 성공하면 true, 실패하면 false 리턴
	function AutoGetBipRoot = (
		if ( try(classof selection[1].baseobject == Biped_object) catch false ) do (
            m_workingBipRoot = selection[1].controller.rootnode
            SetComBtnText true
            return true
		)
		
		for o in objects do (
			if (classof o.baseobject == Biped_object) do (
                m_workingBipRoot = o.controller.rootnode
                SetComBtnText true
                return true
			)
        )
        m_workingBipRoot = undefined -- 씬을 새로 오픈한다거나 하면 삭제된 오브젝트를 기억하고 있을 수 있어서 (undefined 아님) 반드시 undefined 로 초기화해줘야함.
        SetComBtnText false
        SetButtonState false
		return false
	)

	-- 배열 빼기
	function ArraySubtract arrFrom arrSub = (
		if arrSub.count == 0 do (return arrFrom)
		
		for o in arrSub do (
			foundNum = findItem arrFrom o
			if foundNum != 0 do (
				deleteItem arrFrom foundNum
			)
		)
		return arrFrom
	)
	
	-- 기존 selection 백업과 이번에 선택할 selArr 을 입력받아 적절하게 선택한다. 부수적으로 모션패널로의 변경도 같이 수행
    -- selBackup 을 사용할지는 미정
    -- selBackup 은 selection as array
	function CompSelect selBackup selArr = (
		-- 단축키 조합이 아무것도 눌러져있지 않으면 빠르게 그냥 선택 후 리턴
		if (keyboard.controlPressed == false) and (keyboard.altPressed == false) do (
			undo on (
				select selArr
			)
			return()
		)

		if keyboard.controlPressed do (
			selArr += selBackup
		)
		
		if keyboard.altPressed do (
			selArr = ArraySubtract selBackup selArr
		)
		
		undo on (
			if selArr.count == 0 then (
				clearSelection()
			)
			else (
				--setCommandPanelTaskMode mode:#motion
				select selArr
			)
		)
	)

	-- 바이패드 배열이 정상적인지 체크하여 리턴
	fn IfExistBips bipArr = (
		if (bipArr == undefined) do return false
		if (bipArr.count == 0) do return false
		for obj in bipArr do (
			-- 삭제된 오브젝트에 대해 처리하려고 하면 에러가 나므로 try 처리
			try (
				if (obj == undefined) do return false
				if ((classof obj.baseobject) != Biped_Object) do return false
			) catch (return false)
		)
		return true
	)

	-- 이하 바이패드 부위들을 얻어오는 함수들은 m_workingBipRoot를 대상으로 작동
	fn GetHead = (
		selObj = biped.getNode m_workingBipRoot #head
		if ( selObj.isHidden == false ) or uiChkSelHiddenObj.state then (
			return #(selObj)
		)
		else (
			return #()
		)
	)
	fn GetRArms = (
		tArr = #()
		for i = 1 to 4 do (
			selObj = biped.getNode m_workingBipRoot #rarm link:i
			if ( selObj.isHidden == false ) or uiChkSelHiddenObj.state do (
				append tArr selObj
			)
		)
		return tArr
	)
	fn GetNecks = (
		tArr = #()
		testBool = true
		tIndex = 1
		while testBool do (
			selObj = biped.getNode m_workingBipRoot #neck link:tIndex
			if ( selObj == undefined ) then (
				testBool = false
			)
			else (
				if ( selObj.isHidden == false ) or uiChkSelHiddenObj.state do (
					append tArr selObj
				)
			)
			tIndex += 1
		)
		return tArr
	)
	fn GetLArms = (
		tArr = #()
		for i = 1 to 4 do (
			selObj = biped.getNode m_workingBipRoot #larm link:i
			if ( selObj.isHidden == false ) or uiChkSelHiddenObj.state do (
				append tArr selObj
			)
		)
		return tArr
	)
	fn GetRClavicle = (
		selObj = biped.getNode m_workingBipRoot #rarm link:1
		if ( selObj.isHidden == false ) or uiChkSelHiddenObj.state then (
			return #(selObj)
		)
		else (
			return #()
		)
	)
	fn GetLClavicle = (
		selObj = biped.getNode m_workingBipRoot #larm link:1
		if ( selObj.isHidden == false ) or uiChkSelHiddenObj.state then (
			return #(selObj)
		)
		else (
			return #()
		)
	)
	fn GetRUpArm = (
		selObj = biped.getNode m_workingBipRoot #rarm link:2
		if ( selObj.isHidden == false ) or uiChkSelHiddenObj.state then (
			return #(selObj)
		)
		else (
			return #()
		)
	)
	fn GetAllSpine = (
		tArr = #()
		testBool = true
		tIndex = 1
		while testBool do (
			selObj = biped.getNode m_workingBipRoot #spine link:tIndex
			if ( selObj == undefined ) then (
				testBool = false
			)
			else (
				if ( selObj.isHidden == false ) or uiChkSelHiddenObj.state do (
					append tArr selObj
				)
			)
			tIndex += 1
		)
		return tArr
	)
	fn GetSpine index = (
		selObj = biped.getNode m_workingBipRoot #spine link:(index + 1)
		if selObj == undefined do return #()
		if ( selObj.isHidden == false ) or uiChkSelHiddenObj.state then (
			return #(selObj)
		)
		else (
			return #()
		)
	)
	fn GetLUpArm = (
		selObj = biped.getNode m_workingBipRoot #larm link:2
		if ( selObj.isHidden == false ) or uiChkSelHiddenObj.state then (
			return #(selObj)
		)
		else (
			return #()
		)
	)
	fn GetRForArm = (
		selObj = biped.getNode m_workingBipRoot #rarm link:3
		if ( selObj.isHidden == false ) or uiChkSelHiddenObj.state then (
			return #(selObj)
		)
		else (
			return #()
		)
	)
	fn GetLForArm = (
		selObj = biped.getNode m_workingBipRoot #larm link:3
		if ( selObj.isHidden == false ) or uiChkSelHiddenObj.state then (
			return #(selObj)
		)
		else (
			return #()
		)
	)
	fn GetRHand = (
		selObj = biped.getNode m_workingBipRoot #rarm link:4
		if ( selObj.isHidden == false ) or uiChkSelHiddenObj.state then (
			return #(selObj)
		)
		else (
			return #()
		)
	)
	--fn GetCOM = ()
	fn GetLHand = (
		selObj = biped.getNode m_workingBipRoot #larm link:4
		if ( selObj.isHidden == false ) or uiChkSelHiddenObj.state then (
			return #(selObj)
		)
		else (
			return #()
		)
	)
	fn GetPelvis = (
		selObj = biped.getNode m_workingBipRoot #pelvis
		if ( selObj.isHidden == false ) or uiChkSelHiddenObj.state then (
			return #(selObj)
		)
		else (
			return #()
		)
	)
	fn GetRThigh = (
		selObj = biped.getNode m_workingBipRoot #rleg link:1
		if ( selObj.isHidden == false ) or uiChkSelHiddenObj.state then (
			return #(selObj)
		)
		else (
			return #()
		)
	)
	fn GetLThigh = (
		selObj = biped.getNode m_workingBipRoot #lleg link:1
		if ( selObj.isHidden == false ) or uiChkSelHiddenObj.state then (
			return #(selObj)
		)
		else (
			return #()
		)
	)
	fn GetRCalf = (
		selObj = biped.getNode m_workingBipRoot #rleg link:2
		if ( selObj.isHidden == false ) or uiChkSelHiddenObj.state then (
			return #(selObj)
		)
		else (
			return #()
		)
	)
	fn GetLCalf = (
		selObj = biped.getNode m_workingBipRoot #lleg link:2
		if ( selObj.isHidden == false ) or uiChkSelHiddenObj.state then (
			return #(selObj)
		)
		else (
			return #()
		)
	)
	fn GetRFoot = (
		selObj = biped.getNode m_workingBipRoot #rleg link:3
		if ( selObj.isHidden == false ) or uiChkSelHiddenObj.state then (
			return #(selObj)
		)
		else (
			return #()
		)
	)
	fn GetLFoot = (
		selObj = biped.getNode m_workingBipRoot #lleg link:3
		if ( selObj.isHidden == false ) or uiChkSelHiddenObj.state then (
			return #(selObj)
		)
		else (
			return #()
		)
	)
	fn GetRToe = (
		selObj = biped.getNode m_workingBipRoot #rtoes link:1
		if ( selObj.isHidden == false ) or uiChkSelHiddenObj.state then (
			return #(selObj)
		)
		else (
			return #()
		)
	)
	fn GetLToe = (
		selObj = biped.getNode m_workingBipRoot #ltoes link:1
		if ( selObj.isHidden == false ) or uiChkSelHiddenObj.state then (
			return #(selObj)
		)
		else (
			return #()
		)
	)
	fn GetRLegs = (
		tArr = #()
		for i = 1 to 4 do (
			selObj = biped.getNode m_workingBipRoot #rleg link:i
			if selObj != undefined do (		-- HorseLink 가 있기도 하고 없기도 할 수 있음
				if ( selObj.isHidden == false ) or uiChkSelHiddenObj.state do (
					append tArr selObj
				)
			)
		)
		tArr += GetRToe()
		return tArr
	)
	fn GetAllFoot = (
		tArr = #()
		selObj = biped.getNode m_workingBipRoot #rleg link:3
		if ( selObj.isHidden == false ) or uiChkSelHiddenObj.state do ( append tArr selObj )
		selObj = biped.getNode m_workingBipRoot #lleg link:3
		if ( selObj.isHidden == false ) or uiChkSelHiddenObj.state do ( append tArr selObj )
		return tArr
	)
	fn GetLLegs = (
		tArr = #()
		for i = 1 to 4 do (
			selObj = biped.getNode m_workingBipRoot #lleg link:i
			if selObj != undefined do (		-- HorseLink 가 있기도 하고 없기도 할 수 있음
				if ( selObj.isHidden == false ) or uiChkSelHiddenObj.state do (
					append tArr selObj
				)
			)
		)
		tArr += GetLToe()
		return tArr
	)
	fn GetAllBip = (
		local retBips = #()
		for o in objects do (
			if ( classof o.baseobject == Biped_object ) do
			(
				-- 같은Bip001의 자식이면
				if ( o.controller.rootNode == m_workingBipRoot AND (classof o.controller) != Footsteps) do
				(
					append retBips o
				)
			)
		)
		return retBips
	)
	
	-- Go to Mirror frame 버튼이 작동하기 위한 조건 검사 후 버튼 enable 세팅
	-- 루핑 구간 프레임이 짝수여야하고 일정 수 이상이여야함
	fn SetGotoMirrorEnable = (
		--uiBtnGotoMirror
		local fCount = uiSpnLoopEnd.value - uiSpnLoopStart.value
		if (fCount < 2) do (
			uiBtnGotoMirror.enabled = false
			return ()
		)

		local fCountHalf = fCount / 2.0
		-- 홀수인지?
		if float (int fCountHalf) != fCountHalf do (
			uiBtnGotoMirror.enabled = false
			return ()
		)
		uiBtnGotoMirror.enabled = true
	)
    
	-- 작업용 바이패드 루트 노드라던가, 선택용 배열 변수 등을 미리 세팅
	function InitLocalVars = (
		
		--uiBtnLoopDupe.enabled = false -- 개발중인 기능 봉인
		AutoGetBipRoot()
        if m_workingBipRoot == undefined then (
            SetButtonState false
            return ()
        )
        else (
            SetButtonState true
		)
		uiChkBtnScanBiped.text = "Scanning..."
		
		-- 모든 부위 변수들은 배열
		m_Head = GetHead()
		m_RArms = GetRArms()
		m_Necks = GetNecks()
		m_LArms = GetLArms()
		m_RClavicle = GetRClavicle()
		m_LClavicle = GetLClavicle()
		m_RUpArm = GetRUpArm()
		m_AllSpine = GetAllSpine()
		m_Spine2 = GetSpine 2
		if (m_Spine2.count == 0) then (uiSpine2.enabled = false) else (uiSpine2.enabled = true)
		m_Spine1 = GetSpine 1
		if (m_Spine1.count == 0) then (uiSpine1.enabled = false) else (uiSpine1.enabled = true)
		m_Spine0 = GetSpine 0
		if (m_Spine0.count == 0) then (uiSpine0.enabled = false) else (uiSpine0.enabled = true)
		m_LUpArm = GetLUpArm()
		m_RForArm = GetRForArm()
		m_LForArm = GetLForArm()
		m_RHand = GetRHand()
		--m_COM = GetCOM()
		m_LHand = GetLHand()
		m_Pelvis = GetPelvis()
		m_RThigh = GetRThigh()
		m_LThigh = GetLThigh()
		m_RCalf = GetRCalf()
		m_LCalf = GetLCalf()
		m_RFoot = GetRFoot()
		m_LFoot = GetLFoot()
		m_RToe = GetRToe()
		m_LToe = GetLToe()
		m_RLegs = GetRLegs()
		m_AllFoot = GetAllFoot()
		m_LLegs = GetLLegs()
		m_AllBip = GetAllBip()

		uiChkBtnScanBiped.text = "Scan Biped"

		LoadRangeLoop()
		LoadRangeA()
		LoadRangeB()
		LoadGoto()
		SetGotoBtnText()

		uiDropPlaySpeed.selection = timeConfiguration.playbackSpeed

        SetGotoMirrorEnable ()
        
        uiPlayBlock.state = false
		clock.active = false
		m_PBKeyTimeArray = #()
		m_PBKeyMiliSecArray = #()
        SetPBPlaySpeed()
	)

	-- 보정치 회전값을 입력받고 똑바로 펴주는 기능을 한다. bips는 배열. 보정치 회전값은 Toe 등에서 90도 추가 회전이 필요함
	function Straighten bips offsetRotation = (
		for bip in bips do (
			if (bip != undefined AND (isDeleted bip) == false) do (
				biped.setTransform bip #rotation (offsetRotation * bip.parent.transform.rotation) animButtonState
			)
		)
	)

	-- Straighten 함수와 같은 기능이지만 부모 대신에 다른 프록시 오브젝트를 기준으로 한다.
	-- 바이패드의 Triangle Pelvis 옵션때문에 허벅지 부모가 척추인 경우가 종종 있어서 강제로 Pelvis를 지정
	function StraightenByProxy bips proxy offsetRotation = (
		for bip in bips do (
			if (bip != undefined AND (isDeleted bip) == false) do (
				biped.setTransform bip #rotation (offsetRotation * proxy.transform.rotation) animButtonState
			)
		)
	)

	on uiChkBtnScanBiped changed state do (
		uiChkBtnScanBiped.state = true
		InitLocalVars() -- 작업용 바이패드 루트 노드라던가, 선택용 배열 변수 등을 미리 세팅
		if (m_workingBipRoot != undefined) do (select m_AllBip)
	)
	
	on uiBtnSetAllKey changed state do (
		uiBtnSetAllKey.state = true
		if (m_workingBipRoot == undefined or (isDeleted m_workingBipRoot)) do ( SetButtonState false; return ())
		if (m_workingBipRoot.transform.controller.figureMode) do (
			messageBox "You cannot add keyframes in Figure mode." title:"Sox Biped Assist Message"
			return ()
		)

		selBackup = selection as array

		-- 미리 저장한 배열에 문제가 있으면 다시 배열을 초기화
		if (IfExistBips m_AllBip) == false do (
			m_AllBip = GetAllBip()
		)
		if (IfExistBips m_AllBip) == false do return () -- 그래도 문제가 있으면 그냥 리턴
		
		undo on
		(
			for o in m_AllBip do
			(
				if ( o == m_workingBipRoot ) then
				(
					biped.addNewKey o.controller.vertical.controller slidertime
					biped.addNewKey o.controller.horizontal.controller slidertime
					biped.addNewKey o.controller.turning.controller slidertime
				)
				else
				(
					try ( biped.addNewKey o.controller slidertime ) catch ()		-- Footstep 오브젝트때문에 try 처리
				)
			) -- for end
		) -- undo end	
		clearSelection()
		select selBackup
	)

	on uiBtnLimbIK changed state do (
		uiBtnLimbIK.state = on -- 어떤 상태에서도 버튼 스테이트는 눌려있도록
		setCommandPanelTaskMode mode:#motion -- biped.setSlidingKey 등의 기능은 Motion판넬에서만 정상 작동한다. 다른 곳에서 하면 엉뚱한 자세가 덮어써짐
		local timeBefore = sliderTime
		disableSceneRedraw()
		undo on (
			for obj in selection do (
				if (IfLimb obj) do (
					if (keyboard.shiftPressed OR keyboard.controlPressed) then (
						local keys = obj.controller.keys
						local animRangeBackup = animationRange -- 잠시 바깥에 있는 키들도 수정할 수 있도록 현재의 애니메이션 구간을 기억한다.
						animationRange = Interval keys[1].time keys[keys.count].time
						for i = 1 to keys.count do (
							if keyboard.shiftPressed do (
								-- Shift가 눌려있으면 키 선택과 상관 없이 모두 변경
								sliderTime = keys[i].time -- at time 방식으로 하면 sliderTime의 자세로 키가 생성되는 문제가 있어서 실제 sliderTime을 변경시켜서 진행
								biped.setSlidingKey obj
							)
							if keyboard.controlPressed do (
								-- Ctrl이 눌려있으면 선택된 키듦만 변경
								if keys[i].selected == true do (
									sliderTime = keys[i].time -- at time 방식으로 하면 sliderTime의 자세로 키가 생성되는 문제가 있어서 실제 sliderTime을 변경시켜서 진행
									biped.setSlidingKey obj
								)
							)
						)
						animationRange = animRangeBackup -- 다시 원래대로의 애니메이션 구간으로 복구
					)
					else (
						biped.setSlidingKey obj
					)
				)
			) -- for
		) -- Undo
		enableSceneRedraw()
		sliderTime = timeBefore
	)

	on uiBtnLimbFK changed state do (
		uiBtnLimbFK.state = on -- 어떤 상태에서도 버튼 스테이트는 눌려있도록
		setCommandPanelTaskMode mode:#motion -- biped.setSlidingKey 등의 기능은 Motion판넬에서만 정상 작동한다. 다른 곳에서 하면 엉뚱한 자세가 덮어써짐
		local timeBefore = sliderTime
		disableSceneRedraw()
		undo on (
			for obj in selection do (
				if (IfLimb obj) do (
					if (keyboard.shiftPressed OR keyboard.controlPressed) then (
						local keys = obj.controller.keys
						local animRangeBackup = animationRange -- 잠시 바깥에 있는 키들도 수정할 수 있도록 현재의 애니메이션 구간을 기억한다.
						animationRange = Interval keys[1].time keys[keys.count].time
						for i = 1 to keys.count do (
							if keyboard.shiftPressed do (
								-- Shift가 눌려있으면 키 선택과 상관 없이 모두 변경
								sliderTime = keys[i].time -- at time 방식으로 하면 sliderTime의 자세로 키가 생성되는 문제가 있어서 실제 sliderTime을 변경시켜서 진행
								biped.setFreeKey obj
							)
							if keyboard.controlPressed do (
								-- Ctrl이 눌려있으면 선택된 키듦만 변경
								if keys[i].selected == true do (
									sliderTime = keys[i].time -- at time 방식으로 하면 sliderTime의 자세로 키가 생성되는 문제가 있어서 실제 sliderTime을 변경시켜서 진행
									biped.setFreeKey obj
								)
							)
						)
						animationRange = animRangeBackup -- 다시 원래대로의 애니메이션 구간으로 복구
					)
					else (
						biped.setFreeKey obj
					)
				)
			) -- for
		) -- Undo
		enableSceneRedraw()
		sliderTime = timeBefore
	)
	
	on uiHead changed state do (
		if (m_workingBipRoot == undefined or (isDeleted m_workingBipRoot)) do ( SetButtonState false; return ())
		uiHead.state = on -- 어떤 상태에서도 버튼 스테이트는 눌려있도록
		
		if keyboard.shiftPressed do (
			-- Shift 를 누르면 똑바로 펴는 기능
			Straighten m_Head ((eulerangles 0 0 0) as quat)
			return ()
		)
		
		selBackup = selection as array
		
		try(CompSelect selBackup m_Head) catch (
			m_Head = GetHead()
			CompSelect selBackup m_Head
		)
	)

	on uiNecks changed state do (
		if (m_workingBipRoot == undefined or (isDeleted m_workingBipRoot)) do ( SetButtonState false; return ())
		uiNecks.state = on -- 어떤 상태에서도 버튼 스테이트는 눌려있도록
		
		if keyboard.shiftPressed do (
			-- Shift 를 누르면 똑바로 펴는 기능
			Straighten m_Necks ((eulerangles 0 0 0) as quat)
			return ()
		)
		
		selBackup = selection as array

		try(CompSelect selBackup m_Necks) catch (
			m_Necks = GetNecks()
			CompSelect selBackup m_Necks
		)
	)
	
	on uiRArms changed state do (
		if (m_workingBipRoot == undefined or (isDeleted m_workingBipRoot)) do ( SetButtonState false; return ())
		uiRArms.state = on -- 어떤 상태에서도 버튼 스테이트는 눌려있도록
		selBackup = selection as array

		try(CompSelect selBackup m_RArms) catch (
			m_RArms = GetRArms()
			CompSelect selBackup m_RArms
		)
	)
	
	on uiLArms changed state do (
		if (m_workingBipRoot == undefined or (isDeleted m_workingBipRoot)) do ( SetButtonState false; return ())
		uiLArms.state = on -- 어떤 상태에서도 버튼 스테이트는 눌려있도록
		selBackup = selection as array

		try(CompSelect selBackup m_LArms) catch (
			m_LArms = GetLArms()
			CompSelect selBackup m_LArms
		)
	)
	
	on uiRClavicle changed state do (
		if (m_workingBipRoot == undefined or (isDeleted m_workingBipRoot)) do ( SetButtonState false; return ())
		uiRClavicle.state = on -- 어떤 상태에서도 버튼 스테이트는 눌려있도록
		
		if keyboard.shiftPressed do (
			-- Shift 를 누르면 똑바로 펴는 기능
			StraightenByProxy m_RClavicle m_AllSpine[m_AllSpine.count] ((eulerangles 0 90 -180) as quat)
			return ()
		)

		selBackup = selection as array

		try(CompSelect selBackup m_RClavicle) catch (
			m_RClavicle = GetRClavicle()
			CompSelect selBackup m_RClavicle
		)
	)

	on uiLClavicle changed state do (
		if (m_workingBipRoot == undefined or (isDeleted m_workingBipRoot)) do ( SetButtonState false; return ())
		uiLClavicle.state = on -- 어떤 상태에서도 버튼 스테이트는 눌려있도록
		
		if keyboard.shiftPressed do (
			-- Shift 를 누르면 똑바로 펴는 기능
			StraightenByProxy m_LClavicle m_AllSpine[m_AllSpine.count] ((eulerangles 0 -90 -180) as quat)
			return ()
		)
		
		selBackup = selection as array

		try(CompSelect selBackup m_LClavicle) catch (
			m_LClavicle = GetLClavicle()
			CompSelect selBackup m_LClavicle
		)
	)
	
	on uiRUpArm changed state do (
		if (m_workingBipRoot == undefined or (isDeleted m_workingBipRoot)) do ( SetButtonState false; return ())
		uiRUpArm.state = on -- 어떤 상태에서도 버튼 스테이트는 눌려있도록
		
		if keyboard.shiftPressed do (
			-- Shift 를 누르면 똑바로 펴는 기능
			Straighten m_RUpArm ((eulerangles 0 0 0) as quat)
			return ()
		)
		
		selBackup = selection as array

		try(CompSelect selBackup m_RUpArm) catch (
			m_RUpArm = GetRUpArm()
			CompSelect selBackup m_RUpArm
		)
	)

	on uiAllSpine changed state do (
		if (m_workingBipRoot == undefined or (isDeleted m_workingBipRoot)) do ( SetButtonState false; return ())
		uiAllSpine.state = on -- 어떤 상태에서도 버튼 스테이트는 눌려있도록
		
		if keyboard.shiftPressed do (
			-- Shift 를 누르면 똑바로 펴는 기능
			Straighten m_AllSpine ((eulerangles 0 0 0) as quat)
			return ()
		)
		
		selBackup = selection as array

		try(CompSelect selBackup m_AllSpine) catch (
			m_AllSpine = GetAllSpine()
			CompSelect selBackup m_AllSpine
		)
	)

	on uiSpine2 changed state do (
		if (m_workingBipRoot == undefined or (isDeleted m_workingBipRoot)) do ( SetButtonState false; return ())
		uiSpine2.state = on -- 어떤 상태에서도 버튼 스테이트는 눌려있도록
		
		if keyboard.shiftPressed do (
			-- Shift 를 누르면 똑바로 펴는 기능
			Straighten m_Spine2 ((eulerangles 0 0 0) as quat)
			return ()
		)
		
		selBackup = selection as array

		try(CompSelect selBackup m_Spine2) catch (
			m_Spine2 = GetSpine 2
			CompSelect selBackup m_Spine2
		)
	)

	on uiSpine1 changed state do (
		if (m_workingBipRoot == undefined or (isDeleted m_workingBipRoot)) do ( SetButtonState false; return ())
		uiSpine1.state = on -- 어떤 상태에서도 버튼 스테이트는 눌려있도록
		
		if keyboard.shiftPressed do (
			-- Shift 를 누르면 똑바로 펴는 기능
			Straighten m_Spine1 ((eulerangles 0 0 0) as quat)
			return ()
		)
		
		selBackup = selection as array

		try(CompSelect selBackup m_Spine1) catch (
			m_Spine1 = GetSpine 1
			CompSelect selBackup m_Spine1
		)
	)

	on uiSpine0 changed state do (
		if (m_workingBipRoot == undefined or (isDeleted m_workingBipRoot)) do ( SetButtonState false; return ())
		uiSpine0.state = on -- 어떤 상태에서도 버튼 스테이트는 눌려있도록
		
		if keyboard.shiftPressed do (
			-- Shift 를 누르면 똑바로 펴는 기능
			Straighten m_Spine0 ((eulerangles 0 0 0) as quat)
			return ()
		)
		
		selBackup = selection as array

		try(CompSelect selBackup m_Spine0) catch (
			m_Spine0 = GetSpine 0
			CompSelect selBackup m_Spine0
		)
	)

	on uiLUpArm changed state do (
		if (m_workingBipRoot == undefined or (isDeleted m_workingBipRoot)) do ( SetButtonState false; return ())
		uiLUpArm.state = on -- 어떤 상태에서도 버튼 스테이트는 눌려있도록
		
		if keyboard.shiftPressed do (
			-- Shift 를 누르면 똑바로 펴는 기능
			Straighten m_LUpArm ((eulerangles 0 0 0) as quat)
			return ()
		)

		selBackup = selection as array

		try(CompSelect selBackup m_LUpArm) catch (
			m_LUpArm = GetLUpArm()
			CompSelect selBackup m_LUpArm
		)
	)
	
	on uiRForArm changed state do (
		if (m_workingBipRoot == undefined or (isDeleted m_workingBipRoot)) do ( SetButtonState false; return ())
		uiRForArm.state = on -- 어떤 상태에서도 버튼 스테이트는 눌려있도록
		
		if keyboard.shiftPressed do (
			-- Shift 를 누르면 똑바로 펴는 기능
			Straighten m_RForArm ((eulerangles 0 0 0) as quat)
			return ()
		)
		
		selBackup = selection as array

		try(CompSelect selBackup m_RForArm) catch (
			m_RForArm = GetRForArm()
			CompSelect selBackup m_RForArm
		)
	)

	on uiLForArm changed state do (
		if (m_workingBipRoot == undefined or (isDeleted m_workingBipRoot)) do ( SetButtonState false; return ())
		uiLForArm.state = on -- 어떤 상태에서도 버튼 스테이트는 눌려있도록
		
		if keyboard.shiftPressed do (
			-- Shift 를 누르면 똑바로 펴는 기능
			Straighten m_LForArm ((eulerangles 0 0 0) as quat)
			return ()
		)
		
		selBackup = selection as array

		try(CompSelect selBackup m_LForArm) catch (
			m_LForArm = GetLForArm()
			CompSelect selBackup m_LForArm
		)
	)
	
	on uiRHand changed state do (
		if (m_workingBipRoot == undefined or (isDeleted m_workingBipRoot)) do ( SetButtonState false; return ())
		uiRHand.state = on -- 어떤 상태에서도 버튼 스테이트는 눌려있도록
		
		if keyboard.shiftPressed do (
			-- Shift 를 누르면 똑바로 펴는 기능
			Straighten m_RHand ((eulerangles 90 0 0) as quat)
			return ()
		)

		selBackup = selection as array

		try(CompSelect selBackup m_RHand) catch (
			m_RHand = GetRHand()
			CompSelect selBackup m_RHand
		)
	)

	on uiCOM changed state do (
		if (m_workingBipRoot == undefined or (isDeleted m_workingBipRoot)) do ( SetButtonState false; return ())
		uiCOM.state = on -- 어떤 상태에서도 버튼 스테이트는 눌려있도록
		selBackup = selection as array
        
        -- 새로운 씬을 열면 m_workingBipRoot이 undefined는 아니지만 에러 발생함
        try (
            if ( m_workingBipRoot.isHidden == false ) or uiChkSelHiddenObj.state then (
                CompSelect selBackup #(m_workingBipRoot)
            )
            else (
                clearselection()
            )
        )
        catch (
            if (AutoGetBipRoot() == false) do ( SetButtonState false; return ())
            if ( m_workingBipRoot.isHidden == false ) or uiChkSelHiddenObj.state then (
                CompSelect selBackup #(m_workingBipRoot)
            )
            else (
                clearselection()
            )
        )
	)
	
	on uiLHand changed state do (
		if (m_workingBipRoot == undefined or (isDeleted m_workingBipRoot)) do ( SetButtonState false; return ())
		uiLHand.state = on -- 어떤 상태에서도 버튼 스테이트는 눌려있도록
		
		if keyboard.shiftPressed do (
			-- Shift 를 누르면 똑바로 펴는 기능
			Straighten m_LHand ((eulerangles -90 0 0) as quat)
			return ()
		)
		
		selBackup = selection as array

		try(CompSelect selBackup m_LHand) catch (
			m_LHand = GetLHand()
			CompSelect selBackup m_LHand
		)
	)
	
	on uiPelvis changed state do (
		if (m_workingBipRoot == undefined or (isDeleted m_workingBipRoot)) do ( SetButtonState false; return ())
		uiPelvis.state = on -- 어떤 상태에서도 버튼 스테이트는 눌려있도록
		
		if keyboard.shiftPressed do (
			-- Shift 를 누르면 똑바로 펴는 기능
			Straighten m_Pelvis ((eulerangles -90 -90 0) as quat)
			return ()
		)
		
		selBackup = selection as array

		try(CompSelect selBackup m_Pelvis) catch (
			m_Pelvis = GetPelvis()
			CompSelect selBackup m_Pelvis
		)
	)
	
	on uiRThigh changed state do (
		if (m_workingBipRoot == undefined or (isDeleted m_workingBipRoot)) do ( SetButtonState false; return ())
		uiRThigh.state = on -- 어떤 상태에서도 버튼 스테이트는 눌려있도록
		
		if keyboard.shiftPressed do (
			-- Shift 를 누르면 똑바로 펴는 기능
			StraightenByProxy m_RThigh m_Pelvis[1] ((eulerangles 0 180 0) as quat)
			return ()
		)
		
		selBackup = selection as array

		try(CompSelect selBackup m_RThigh) catch (
			m_RThigh = GetRThigh()
			CompSelect selBackup m_RThigh
		)
	)

	on uiLThigh changed state do (
		if (m_workingBipRoot == undefined or (isDeleted m_workingBipRoot)) do ( SetButtonState false; return ())
		uiLThigh.state = on -- 어떤 상태에서도 버튼 스테이트는 눌려있도록
		
		if keyboard.shiftPressed do (
			-- Shift 를 누르면 똑바로 펴는 기능
			StraightenByProxy m_LThigh m_Pelvis[1] ((eulerangles 0 -180 0) as quat)
			return ()
		)
		
		selBackup = selection as array
		
		try(CompSelect selBackup m_LThigh) catch (
			m_LThigh = GetLThigh()
			CompSelect selBackup m_LThigh
		)
	)
	
	on uiRCalf changed state do (
		if (m_workingBipRoot == undefined or (isDeleted m_workingBipRoot)) do ( SetButtonState false; return ())
		uiRCalf.state = on -- 어떤 상태에서도 버튼 스테이트는 눌려있도록
		
		if keyboard.shiftPressed do (
			-- Shift 를 누르면 똑바로 펴는 기능
			Straighten m_RCalf ((eulerangles 0 0 0) as quat)
			return ()
		)
		
		selBackup = selection as array

		try(CompSelect selBackup m_RCalf) catch (
			m_RCalf = GetRCalf()
			CompSelect selBackup m_RCalf
		)
	)

	on uiLCalf changed state do (
		if (m_workingBipRoot == undefined or (isDeleted m_workingBipRoot)) do ( SetButtonState false; return ())
		uiLCalf.state = on -- 어떤 상태에서도 버튼 스테이트는 눌려있도록
		
		if keyboard.shiftPressed do (
			-- Shift 를 누르면 똑바로 펴는 기능
			Straighten m_LCalf ((eulerangles 0 0 0) as quat)
			return ()
		)
		
		selBackup = selection as array

		try(CompSelect selBackup m_LCalf) catch (
			m_LCalf = GetLCalf()
			CompSelect selBackup m_LCalf
		)
	)
	
	on uiRFoot changed state do (
		if (m_workingBipRoot == undefined or (isDeleted m_workingBipRoot)) do ( SetButtonState false; return ())
		uiRFoot.state = on -- 어떤 상태에서도 버튼 스테이트는 눌려있도록
		
		if keyboard.shiftPressed do (
			-- Shift 를 누르면 똑바로 펴는 기능
			Straighten m_RFoot ((eulerangles 0 0 0) as quat)
			return ()
		)
		
		selBackup = selection as array

		try(CompSelect selBackup m_RFoot) catch (
			m_RFoot = GetRFoot()
			CompSelect selBackup m_RFoot
		)
	)
	
	on uiLFoot changed state do (
		if (m_workingBipRoot == undefined or (isDeleted m_workingBipRoot)) do ( SetButtonState false; return ())
		uiLFoot.state = on -- 어떤 상태에서도 버튼 스테이트는 눌려있도록
		
		if keyboard.shiftPressed do (
			-- Shift 를 누르면 똑바로 펴는 기능
			Straighten m_LFoot ((eulerangles 0 0 0) as quat)
			return ()
		)
		
		selBackup = selection as array

		try(CompSelect selBackup m_LFoot) catch (
			m_LFoot = GetLFoot()
			CompSelect selBackup m_LFoot
		)
	)

	on uiRToe changed state do (
		if (m_workingBipRoot == undefined or (isDeleted m_workingBipRoot)) do ( SetButtonState false; return ())
		uiRToe.state = on -- 어떤 상태에서도 버튼 스테이트는 눌려있도록

		if keyboard.shiftPressed do (
			-- Shift 를 누르면 똑바로 펴는 기능
			Straighten m_RToe ((eulerangles 0 0 90) as quat)
			return ()
		)

		selBackup = selection as array
		
		try(CompSelect selBackup m_RToe) catch (
			m_RToe = GetRToe()
			CompSelect selBackup m_RToe
		)
	)

	on uiLToe changed state do (
		if (m_workingBipRoot == undefined or (isDeleted m_workingBipRoot)) do ( SetButtonState false; return ())
		uiLToe.state = on -- 어떤 상태에서도 버튼 스테이트는 눌려있도록

		if keyboard.shiftPressed do (
			-- Shift 를 누르면 똑바로 펴는 기능
			Straighten m_LToe ((eulerangles 0 0 90) as quat)
			return ()
		)

		selBackup = selection as array

		try(CompSelect selBackup m_LToe) catch (
			m_LToe = GetLToe()
			CompSelect selBackup m_LToe
		)
	)
	
	on uiRLegs changed state do (
		if (m_workingBipRoot == undefined or (isDeleted m_workingBipRoot)) do ( SetButtonState false; return ())
		uiRLegs.state = on -- 어떤 상태에서도 버튼 스테이트는 눌려있도록
		selBackup = selection as array

		try(CompSelect selBackup m_RLegs) catch (
			m_RLegs = GetRLegs()
			CompSelect selBackup m_RLegs
		)
	)
	
	on uiAllFoot changed state do (
		if (m_workingBipRoot == undefined or (isDeleted m_workingBipRoot)) do ( SetButtonState false; return ())
		uiAllFoot.state = on -- 어떤 상태에서도 버튼 스테이트는 눌려있도록
		selBackup = selection as array

		try(CompSelect selBackup m_AllFoot) catch (
			m_AllFoot = GetAllFoot()
			CompSelect selBackup m_AllFoot
		)
	)
	
	on uiLLegs changed state do (
		if (m_workingBipRoot == undefined or (isDeleted m_workingBipRoot)) do ( SetButtonState false; return ())
		uiLLegs.state = on -- 어떤 상태에서도 버튼 스테이트는 눌려있도록
		selBackup = selection as array

		try(CompSelect selBackup m_LLegs) catch (
			m_LLegs = GetLLegs()
			CompSelect selBackup m_LLegs
		)
	)
	
	on uiAllBip changed state do (
		if (m_workingBipRoot == undefined or (isDeleted m_workingBipRoot)) do ( SetButtonState false; return ())
		uiAllBip.state = on -- 어떤 상태에서도 버튼 스테이트는 눌려있도록
		selBackup = selection as array

		try(CompSelect selBackup m_AllBip) catch (
			m_AllBip = GetAllBip()
			CompSelect selBackup m_AllBip
		)
	)
	
	on uiSpnLoopStart changed var do (
		SaveRangeLoop()
		SetGotoMirrorEnable() -- Go to Mirror frame 버튼 활성/비활성 설정
	)
	on uiSpnLoopEnd changed var do (
		SaveRangeLoop()
		SetGotoMirrorEnable() -- Go to Mirror frame 버튼 활성/비활성 설정
	)
	on uiSpnAnimRangeAStart changed var do (
		SaveRangeA()
	)
	on uiSpnAnimRangeAEnd changed var do (
		SaveRangeA()
	)
	on uiSpnAnimRangeBStart changed var do (
		SaveRangeB()
	)
	on uiSpnAnimRangeBEnd changed var do (
		SaveRangeB()
	)

	on uiBtnGotoMirror pressed do (
		local now = int sliderTime
		if (now < uiSpnLoopStart.value) OR (now > uiSpnLoopEnd.value) do return ()

		if now == uiSpnLoopEnd.value do (now = uiSpnLoopStart.value) -- 루프 끝 프레임에서 버튼이 눌러졌으면 첫 프레임으로 간주함
		local fCount = uiSpnLoopEnd.value - uiSpnLoopStart.value
		fCount *= 0.5
		local targetFrame = (int sliderTime) + fCount
		if targetFrame == uiSpnLoopEnd.value do (
			sliderTime = uiSpnLoopStart.value
			return ()
		)
		if targetFrame > uiSpnLoopEnd.value then (
			sliderTime = uiSpnLoopStart.value + (targetFrame - uiSpnLoopEnd.value)
			return ()
		)
		else (
			sliderTime = targetFrame
			return ()
		)
	)
    
    fn LoopTrim = (
		undo on (
			for obj in selection do (
				DeselectAllKeys obj
				if (IfBipRoot obj) == false then (
					-- COM이 아니거나 일반 오브젝트인 경우
					if (classof obj.baseobject == Biped_Object) then (
						TrimKeys obj.controller uiSpnLoopStart.value uiSpnLoopEnd.value true
					)
					else (
						TrimKeys obj.controller uiSpnLoopStart.value uiSpnLoopEnd.value false
					)
				)
				else (
					-- COM인 경우
					TrimKeys obj.controller.Vertical.controller uiSpnLoopStart.value uiSpnLoopEnd.value true
					TrimKeys obj.controller.Horizontal.controller uiSpnLoopStart.value uiSpnLoopEnd.value true
					TrimKeys obj.controller.Turning.controller uiSpnLoopStart.value uiSpnLoopEnd.value true
				)
			)
		)
	)
	on uiBtnLoopTrim changed state do (
		uiBtnLoopTrim.state = true
		LoopTrim()
	)

	fn LoopDupeCOM bip = (
		disableSceneRedraw()
		-- Turning
		local loopLength = uiSpnLoopEnd.value - uiSpnLoopStart.value
		local keyCount = numKeys bip.controller.Turning.controller
		-- 중요. 키 자체를 배열로 얻어오면 키를 추가하는 과정에서 인덱스가 다 꼬인다. 배열을 deepCopy로 복사하든 뭘 하든 방법이 없음
		-- 그래서 복사할 키의 시간을 배열로 준비해두는 방법을 사용함
		local refKeyTimes = #() -- 루프 키를 추가하기 전에 미리 다 얻어두어야함.
		for i = 1 to keyCount do (
			append refKeyTimes (getKey bip.controller.Turning.controller i).time
		)

		for i = 1 to keyCount do (
			local newTimeBefore = refKeyTimes[i] - loopLength
			local newTimeAfter = refKeyTimes[i] + loopLength
			sliderTime = refKeyTimes[i] -- 원본 회전값을 얻어올 시간으로 점프
			local refRot = biped.getTransform bip #rotation 
			--Before
			if (newTimeBefore != refKeyTimes[1]) do (
				-- Before의 복사하는 마지막 키가 원본 키의 첫 키와 같은 위치면 복사 안함
				sliderTime = newTimeBefore
				biped.setTransform bip #rotation refRot true
			)
			--After
			if (newTimeAfter != refKeyTimes[refKeyTimes.count]) do (
				-- After의 복사하는 첫 키가 원본 키의 마지막 키와 같은 위치면 복사 안함
				sliderTime = newTimeAfter
				biped.setTransform bip #rotation refRot true
			)

			-- 앞 뒤 키를 생성한 후 세부 값들 복제
			local refKeyIndex = getkeyindex bip.controller.Turning.controller refKeyTimes[i]
			local refKey = biped.getKey bip.controller.Turning.controller refKeyIndex
			local newKeyIndexBefore = getkeyindex bip.controller.Turning.controller newTimeBefore
			local newKeyBefore = biped.getKey bip.controller.Turning.controller newKeyIndexBefore
			local newKeyIndexAfter = getkeyindex bip.controller.Turning.controller newTimeAfter
			local newKeyAfter = biped.getKey bip.controller.Turning.controller newKeyIndexAfter
			newKeyBefore.tension = refKey.tension;newKeyAfter.tension = refKey.tension;
			newKeyBefore.continuity = refKey.continuity;newKeyAfter.continuity = refKey.continuity;
			newKeyBefore.bias = refKey.bias;newKeyAfter.bias = refKey.bias;
			newKeyBefore.easeTo = refKey.easeTo;newKeyAfter.easeTo = refKey.easeTo;
			newKeyBefore.easeFrom = refKey.easeFrom;newKeyAfter.easeFrom = refKey.easeFrom;
		)

		-- Horizontal, Vertical 을 키 찍기 전에 미리 준비하는 이유 : biped.setTransform bip #pos 는 가로 세로 따지지 않고 키를 생성하므로
		-- Horizontal 준비
		keyCount = numKeys bip.controller.Horizontal.controller
		local refKeyTimesHor = #() -- 루프 키를 추가하기 전에 미리 다 얻어두어야함.
		for i = 1 to keyCount do (
			append refKeyTimesHor (getKey bip.controller.Horizontal.controller i).time
		)
		-- Vertical 준비
		keyCount = numKeys bip.controller.Vertical.controller
		local refKeyTimesVer = #() -- 루프 키를 추가하기 전에 미리 다 얻어두어야함.
		for i = 1 to keyCount do (
			append refKeyTimesVer (getKey bip.controller.Vertical.controller i).time
		)

		-- Horizontal
		for i = 1 to refKeyTimesHor.count do (
			local newTimeBefore = refKeyTimesHor[i] - loopLength
			local newTimeAfter = refKeyTimesHor[i] + loopLength
			sliderTime = refKeyTimesHor[i] -- 원본 위치값을 얻어올 시간으로 점프
			local refPos = biped.getTransform bip #pos
			--Before
			if (newTimeBefore != refKeyTimesHor[1]) do (
				-- Before의 복사하는 마지막 키가 원본 키의 첫 키와 같은 위치면 복사 안함
				sliderTime = newTimeBefore
				biped.setTransform bip #pos refPos true
			)
			--After
			if (newTimeAfter != refKeyTimesHor[refKeyTimesHor.count]) do (
				-- After의 복사하는 첫 키가 원본 키의 마지막 키와 같은 위치면 복사 안함
				sliderTime = newTimeAfter
				biped.setTransform bip #pos refPos true
			)
			-- Vertical 시간들을 기록한 배열에서 Hor 시간을 찾을 수 없으면 Vertical 키 삭제
			if (findItem refKeyTimesVer refKeyTimesHor[i]) == 0 do (
				selectKeys bip.controller.Vertical.controller newTimeBefore
				selectKeys bip.controller.Vertical.controller newTimeAfter
				biped.deleteKeys bip.controller.Vertical.controller #selection
			)

			-- 앞 뒤 키를 생성한 후 세부 값들 복제
			local refKeyIndex = getkeyindex bip.controller.Horizontal.controller refKeyTimesHor[i]
			local refKey = biped.getKey bip.controller.Horizontal.controller refKeyIndex
			local newKeyIndexBefore = getkeyindex bip.controller.Horizontal.controller newTimeBefore
			local newKeyBefore = biped.getKey bip.controller.Horizontal.controller newKeyIndexBefore
			local newKeyIndexAfter = getkeyindex bip.controller.Horizontal.controller newTimeAfter
			local newKeyAfter = biped.getKey bip.controller.Horizontal.controller newKeyIndexAfter
			newKeyBefore.tension = refKey.tension;newKeyAfter.tension = refKey.tension;
			newKeyBefore.continuity = refKey.continuity;newKeyAfter.continuity = refKey.continuity;
			newKeyBefore.bias = refKey.bias;newKeyAfter.bias = refKey.bias;
			newKeyBefore.easeTo = refKey.easeTo;newKeyAfter.easeTo = refKey.easeTo;
			newKeyBefore.easeFrom = refKey.easeFrom;newKeyAfter.easeFrom = refKey.easeFrom;
			newKeyBefore.balanceFactor = refKey.balanceFactor;newKeyAfter.balanceFactor = refKey.balanceFactor;
		)

		-- Vertical
		for i = 1 to refKeyTimesVer.count do (
			local newTimeBefore = refKeyTimesVer[i] - loopLength
			local newTimeAfter = refKeyTimesVer[i] + loopLength
			sliderTime = refKeyTimesVer[i] -- 원본 위치값을 얻어올 시간으로 점프
			local refPos = biped.getTransform bip #pos
			--Before
			if (newTimeBefore != refKeyTimesVer[1]) do (
				-- Before의 복사하는 마지막 키가 원본 키의 첫 키와 같은 위치면 복사 안함
				sliderTime = newTimeBefore
				biped.setTransform bip #pos refPos true
			)
			--After
			if (newTimeAfter != refKeyTimesVer[refKeyTimesVer.count]) do (
				-- After의 복사하는 첫 키가 원본 키의 마지막 키와 같은 위치면 복사 안함
				sliderTime = newTimeAfter
				biped.setTransform bip #pos refPos true
			)
			-- Horizontal 시간들을 기록한 배열에서 Vertical 시간을 찾을 수 없으면 Horizontal 키 삭제
			if (findItem refKeyTimesHor refKeyTimesVer[i]) == 0 do (
				selectKeys bip.controller.Horizontal.controller newTimeBefore
				selectKeys bip.controller.Horizontal.controller newTimeAfter
				biped.deleteKeys bip.controller.Horizontal.controller #selection
			)

			-- 앞 뒤 키를 생성한 후 세부 값들 복제
			local refKeyIndex = getkeyindex bip.controller.Vertical.controller refKeyTimesVer[i]
			local refKey = biped.getKey bip.controller.Vertical.controller refKeyIndex
			local newKeyIndexBefore = getkeyindex bip.controller.Vertical.controller newTimeBefore
			local newKeyBefore = biped.getKey bip.controller.Vertical.controller newKeyIndexBefore
			local newKeyIndexAfter = getkeyindex bip.controller.Vertical.controller newTimeAfter
			local newKeyAfter = biped.getKey bip.controller.Vertical.controller newKeyIndexAfter
			newKeyBefore.tension = refKey.tension;newKeyAfter.tension = refKey.tension;
			newKeyBefore.continuity = refKey.continuity;newKeyAfter.continuity = refKey.continuity;
			newKeyBefore.bias = refKey.bias;newKeyAfter.bias = refKey.bias;
			newKeyBefore.easeTo = refKey.easeTo;newKeyAfter.easeTo = refKey.easeTo;
			newKeyBefore.easeFrom = refKey.easeFrom;newKeyAfter.easeFrom = refKey.easeFrom;
			newKeyBefore.dynamicsBlend = refKey.dynamicsBlend;newKeyAfter.dynamicsBlend = refKey.dynamicsBlend;
			newKeyBefore.ballisticTension = refKey.ballisticTension;newKeyAfter.ballisticTension = refKey.ballisticTension;
		)

		enableSceneRedraw()
	)

	-- IK Blend, Body/Object 등의 키값을 조사해서 Planted, Sliding, Free 셋 중 하나의 타입을 리턴한다.
	fn GetLimbKeyType key = (
		-- ikSpace 0 = Body, 1 = Object
		if key.ikBlend == 1 AND key.ikSpace == 1 AND key.ikJoinedPivot == true do return "Planted"
		if key.ikBlend == 1 AND key.ikSpace == 1 AND key.ikJoinedPivot == false  do return "Sliding"
		return "Free"
	)

	fn LoopDupeLimb bip = (
		disableSceneRedraw()

		local loopLength = uiSpnLoopEnd.value - uiSpnLoopStart.value
		local bipKeys = bip.controller.keys


		enableSceneRedraw()
	)

	on uiBtnLoopDupe changed state do (
		uiBtnLoopDupe.state = true
		LoopTrim() -- 복제 전에 범위 밖의 키들을 모두 날린다.
		if (IfExistBips m_AllBip) == false do return ()
		for bip in m_AllBip do (
			local keyTypeStr = GetBipKeyType bip
			case keyTypeStr of (
				"COM": (LoopDupeCOM bip)
				"Limb": (LoopDupeLimb bip)
				"Etc": ()
				"NoKey": ()
			)
		)
	)

	on uiBtnLoopSel changed state do (
		uiBtnLoopSel.state = true

		for obj in selection do (
			DeselectAllKeys obj
			-- 선택시 컨트롤러는 세부 컨트롤러 명시 없어도 대충 잘 선택해줌
			selectKeys obj.controller (interval uiSpnLoopStart.value uiSpnLoopEnd.value)
		)
	)
	
	on uiBtnLoopGet pressed do (
		undo on (
			uiSpnLoopStart.value = animationRange.start as integer / TicksPerFrame
			uiSpnLoopEnd.value = animationRange.end as integer / TicksPerFrame
			SaveRangeLoop()
		)
	)

	on uiBtnLoopSet pressed do (
		undo on (
			tFrame = uiSpnLoopEnd.value
			if ( uiSpnLoopStart.value == tFrame ) do ( tFrame += 1 )
			animationRange = interval (uiSpnLoopStart.value as time) (tFrame as time)
		)
	)
	
	on uiBtnAnimRangeAGet pressed do (
		undo on (
			uiSpnAnimRangeAStart.value = animationRange.start as integer / TicksPerFrame
			uiSpnAnimRangeAEnd.value = animationRange.end as integer / TicksPerFrame
			SaveRangeA()
		)
	)
	
	on uiBtnAnimRangeBGet pressed do (
		undo on (
			uiSpnAnimRangeBStart.value = animationRange.start as integer / TicksPerFrame
			uiSpnAnimRangeBEnd.value = animationRange.end as integer / TicksPerFrame
			SaveRangeB()
		)
	)
	
	/*on uiBtnAnimRangeCGet pressed do (
		undo on (
			uiSpnAnimRangeCStart.value = animationRange.start as integer / TicksPerFrame
			uiSpnAnimRangeCEnd.value = animationRange.end as integer / TicksPerFrame
		)
	)*/
	
	on uiBtnAnimRangeASet pressed do (
		undo on (
			tFrame = uiSpnAnimRangeAEnd.value
			if ( uiSpnAnimRangeAStart.value == tFrame ) do ( tFrame += 1 )
			animationRange = interval (uiSpnAnimRangeAStart.value as time) (tFrame as time)
		)
	)
	
	on uiBtnAnimRangeBSet pressed do (
		undo on (
			tFrame = uiSpnAnimRangeBEnd.value
			if ( uiSpnAnimRangeBStart.value == tFrame ) do ( tFrame += 1 )
			animationRange = interval (uiSpnAnimRangeBStart.value as time) (tFrame as time)
		)
	)
	
	/*on uiBtnAnimRangeCSet pressed do (
		undo on (
			tFrame = uiSpnAnimRangeCEnd.value
			if ( uiSpnAnimRangeCStart.value == tFrame ) do ( tFrame += 1 )
			animationRange = interval (uiSpnAnimRangeCStart.value as time) (tFrame as time)
		)
	)*/

	-- GotoFrame함수에 m_goto1 등의 변수는 참조 형식으로 전달
	on uiBtnGoto1 pressed do (GotoFrame uiBtnGoto1 &m_goto1 1)
	on uiBtnGoto2 pressed do (GotoFrame uiBtnGoto2 &m_goto2 2)
	on uiBtnGoto3 pressed do (GotoFrame uiBtnGoto3 &m_goto3 3)
	on uiBtnGoto4 pressed do (GotoFrame uiBtnGoto4 &m_goto4 4)
	on uiBtnGoto5 pressed do (GotoFrame uiBtnGoto5 &m_goto5 5)
	on uiBtnGoto6 pressed do (GotoFrame uiBtnGoto6 &m_goto6 6)
	on uiBtnGoto7 pressed do (GotoFrame uiBtnGoto7 &m_goto7 7)
	on uiBtnGoto8 pressed do (GotoFrame uiBtnGoto8 &m_goto8 8)

	on uiDropPlaySpeed selected sel do (
        timeConfiguration.playbackSpeed = sel
        SetPBPlaySpeed()
    )

    -- 프레임을 틱으로, 틱을 밀리세컨드로 (integer 리턴)
    function FramToMilisecond frame = (
		-- animationRange.start를 빼주지 않으면 0프레임이 아닌 곳에서 시작할 때 딜레이 발생함
		return ((((frame - animationRange.start) as integer) * (10.0 / 48.0) * m_PBPlaySpeed) as integer)
    )

    function AppendKeyTimeArray m_PBKeyMiliSecArray keys = (
        if keys.count == 0 do return()
        for i = 1 to keys.count do (
            if (keys[i].time >= animationRange.start) AND (keys[i].time <= animationRange.end) do (
                appendifUnique m_PBKeyMiliSecArray (FramToMilisecond keys[i].time)
                appendifUnique m_PBKeyTimeArray keys[i].time
            )
        )
        -- 애니메이션 레인지의 시작과 끝은 무조건 포함시킴
        appendifUnique m_PBKeyMiliSecArray (FramToMilisecond animationRange.start)
        appendifUnique m_PBKeyTimeArray animationRange.start
        appendifUnique m_PBKeyMiliSecArray (FramToMilisecond animationRange.end)
        appendifUnique m_PBKeyTimeArray animationRange.end
	)
	
	function StopBlocking = (
        clock.active = false
        uiPlayBlock.state = false
        uiPlayBlock.text = "Play.B"
	)
    
    function PlayBlocking = (
		m_PBKeyTimeArray = #() -- 블럭킹 애니메이션용 키 타임 배열 로컬 변수 (Frame)
        m_PBKeyMiliSecArray = #() -- 블럭킹 애니메이션용 키 타임 배열 로컬 변수 (밀리세컨드)
        local nowTime = timeStamp()
        for obj in selection do (
            if (classof obj.baseObject) == Biped_Object do (
                if (IfBipRoot obj) then (
                    AppendKeyTimeArray m_PBKeyMiliSecArray obj.transform.controller.horizontal.controller.keys
                    AppendKeyTimeArray m_PBKeyMiliSecArray obj.transform.controller.vertical.controller.keys
                    AppendKeyTimeArray m_PBKeyMiliSecArray obj.transform.controller.turning.controller.keys
                )
                else (
                    AppendKeyTimeArray m_PBKeyMiliSecArray obj.transform.controller.keys
                )
            )
		)
		if m_PBKeyMiliSecArray.count == 0 do (
			StopBlocking()
			return() -- 일반 오브젝트를 선택하면 배열이 비어있음
		)
		
		if (isAnimPlaying()) do (
			stopAnimation()
		)		
		
        sort m_PBKeyTimeArray
        sort m_PBKeyMiliSecArray
        m_PBPointer = 1
        while (m_PBKeyTimeArray[m_PBPointer] < sliderTime) do (
            m_PBPointer += 1
        )

        m_PBStartTime = timeStamp() - (FramToMilisecond sliderTime)
		sliderTime = m_PBKeyTimeArray[m_PBPointer] -- 일단 슬라이더 타임을 동기화 (안하면 강제로 스톱됨)
		clock.active = true
		uiPlayBlock.text = "Stop"
    )
	
	function ReplayBlocking = (
		m_PBPointer = 1
        m_PBStartTime = timeStamp()
        sliderTime = m_PBKeyTimeArray[m_PBPointer]
	)

	on uiPlayBlock changed state do (
        if (selection.count == 0) do (
            StopBlocking()
            return()
        )
		if state then (
            PlayBlocking()
        )
        else (
            StopBlocking()
        )
    )
    
    -- Play Blocking용 틱 이벤트 처리
    on clock tick do (
        if (m_PBPointer > m_PBKeyMiliSecArray.count) do return()
		local now = timeStamp()
		local pointer
		if (m_PBKeyMiliSecArray.count == m_PBPointer) then (
			ReplayBlocking()
			pointer = 1
		)
		else (
			pointer = m_PBStartTime + m_PBKeyMiliSecArray[m_PBPointer + 1] -- 다음 키프레임과 현재 시간을 비교
		)
        
        -- 현재 시간이 다음 프레임을 넘어서면 포인터 증가, 슬라이더 변경
        if ( now > pointer ) do (
            m_PBPointer += 1
            sliderTime = m_PBKeyTimeArray[m_PBPointer]
        )
        
        -- 포인터가 마지막 프레임을 가리키면 처음으로 되돌리고 시작시간 리셋
        if (m_PBPointer >= m_PBKeyMiliSecArray.count) do (
            ReplayBlocking()
        )

        if keyboard.escPressed do (
            StopBlocking()
		)
		
		-- 외부 요인에 의해 강제로 슬라이더 시간이 변경되면 사용자에 의한 플레이 취소로 간주
		if (sliderTime != m_PBKeyTimeArray[m_PBPointer]) do (
			StopBlocking()
		)
    )

	on uiAbout pressed do (
		shellLaunch "http://cafe.naver.com/pinksox/6131" ""
	)
	
	on SoxBipedAssist open do (
        InitLocalVars() -- 작업용 바이패드 루트 노드라던가, 선택용 배열 변수 등을 미리 세팅
        
        callbacks.addScript #filePostOpen "SoxBipedAssist.InitLocalVars ()" id:#SoxBACallbackOpen
		callbacks.addScript #systemPostNew "SoxBipedAssist.InitLocalVars ()" id:#SoxBACallbackNew
		callbacks.addScript #systemPostReset "SoxBipedAssist.InitLocalVars ()" id:#SoxBACallbackReset
	)
	
	on SoxBipedAssist close do (
        callbacks.removeScripts id:#SoxBACallbackOpen
		callbacks.removeScripts id:#SoxBACallbackNew
		callbacks.removeScripts id:#SoxBACallbackReset
	)
)

createDialog SoxBipedAssist style:#(#style_titlebar, #style_toolwindow, #style_sysmenu) lockWidth:true