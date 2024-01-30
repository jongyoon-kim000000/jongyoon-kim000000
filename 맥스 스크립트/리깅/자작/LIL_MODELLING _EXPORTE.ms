-- 함수 정의
function SetZeroPoint =
(
    $.position = [0, 0, 0]
    resetXForm $
    macros.run "Modifier Stack" "Convert_to_Poly"
)

-- 함수 정의
function Y_UP obj =
(
    Select obj
    ResetXForm obj
    modPanel.addModToSelection (XForm ()) ui:on
    obj.modifiers[#XForm].gizmo.rotation += rot as quat
    rotate obj (inverse rot as quat)
    for obj in (selection as array) do (convertToPoly obj)
)
function Ex =
(
actionMan.executeAction 0 "40373"  -- File: Export Selected
)


-- 전역 변수 정의
global rot = eulerToQuat(eulerAngles 90 0 0)

-- UI 정의
try (destroyDialog ::L) catch ()
rollout L "LIL_Exporte_Modelling" width:162 height:160
(
    groupBox grp1 "option" pos:[7,3] width:148 height:140
    button btn1 "Y_UP" pos:[18,23] width:127 height:34
    on btn1 pressed do
		(
        selectedObjects = getCurrentSelection()
        if selectedObjects.count > 0 then 
		(
		for obj in selectedObjects do Y_UP obj
		messagebox "Y_UP" title: "LIL_Exporte_Modelling"
		)
        else Messagebox "No object selected" title: "LIL_Exporte_Modelling"
		)
		
    button btn2 "Set Zero Point" pos:[18,63] width:127 height:34
    on btn2 pressed do 
	(
		selectedObjects = getCurrentSelection()
		if selectedObjects.count > 0 then 
		(
		for obj in selectedObjects do SetZeroPoint()
		messagebox "Set Zero" title: "LIL_Exporte_Modelling"
		)
        else Messagebox "No object selected" title: "LIL_Exporte_Modelling"
		)
	
		
		
	 button btn3 "Exporte Selcted" pos:[18,103] width:127 height:34
	on btn3 pressed do 
	( selectedObjects = getCurrentSelection()
     if selectedObjects.count > 0 then (
       -- 내보내기 설정 및 경로를 정의
       local filePath = "C:\\경로\\파일이름.fbx" -- 내보낼 파일 경로 및 이름을 설정합니다
       local fileType = "FBX" -- 내보낼 파일 형식을 설정합니다

       -- 선택된 객체를 FBX 파일로 내보냅니다
       exportFile filePath fileType #noPrompt

       -- Y_UP 함수를 선택한 객체에 적용
       for obj in selectedObjects do Y_UP obj

       -- 내보내기가 완료된 후 메시지 표시
       messagebox "Exporte Selcted" title: "LIL_Exporte_Modelling"
     ) else messagebox "No object selected" title: "LIL_Exporte_Modelling"

	)
)
createDialog L

