/* 만든이 : 김종윤
문의 : https://blog.naver.com/trueb000/223314441951
수정, 배포는 자유이며 많은 피드백 부탁드립니다.
*/



global rot = eulerToQuat(eulerAngles 90 0 0)
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


fn movePivotToOrigin obj =
(
    -- 오브젝트의 피봇을 월드 좌표 0,0,0으로 설정합니다.
    obj.pivot = [0,0,0]
    )


-- UI 정의
try (destroyDialog ::L) catch ()
rollout L "LIL_Modell_Edit" width:162 height:300
(
		groupBox grp1 "option" pos:[7,3] width:148 height:220
		button btn1 "Y_UP" pos:[18,23] width:127 height:34
		on btn1 pressed do
		(
		rot = eulerToQuat(eulerAngles 90 0 0)
        selectedObjects = getCurrentSelection()
        if selectedObjects.count > 0 then 
		(
		for obj in selectedObjects do Y_UP obj
		messagebox "        Y_UP       " title: "LIL_Modell_Edit"
		  actionMan.executeAction 0 "40021"
		)
        else Messagebox "No object selected" title: "LIL_Modell_Edit"
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
	
		
		button btn22 "Reset Pivot to Zero" pos:[18,103] width:127 height:34
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
			macros.run "Modifier Stack" "Convert_to_Poly"

        -- Reset XForm이 완료된 후 메시지 표시
        messagebox "Reset XForm Completed" title: "LIL_Modell_Edit"
		)
		else messagebox "No object selected" title: "LIL_Modell_Edit"
		)

	
		button btn4 "Skin" pos:[18,183] width:63 height:30
		on btn4 pressed do 
		(
		allNode = selection as array
			print allNode

			if allNode.count > 0 then
			(

				for i = 1 to allNode.count do
				(
					addModifier allNode[i] (skin ()) ui:on
				)
			)
		

		)
     
		button btn5 "Skin Wrap" pos:[82,183] width:63 height:30
		on btn5 pressed do 
		(
			allNode = selection as array
			print allNode

			if allNode.count > 0 then
			(

				for i = 1 to allNode.count do
				(
					addModifier allNode[i] (Skin_Wrap()) ui:on
				)
			)
			
		)

		button infoButton "Info" pos:[50,255]  width:60 height:25  align:#center
		  on infoButton pressed do
  		(
       		 openInfoWebsite() 
		)
		
		label lil "made by lil JongYoon" pos:[30,230] width:148 height:20
		
)

createDialog L

