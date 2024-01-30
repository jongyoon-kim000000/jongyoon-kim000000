/* 만든이 : 김종윤
문의 : https://blog.naver.com/trueb000/223314441951
수정, 배포는 자유이며 많은 피드백 부탁드립니다.
*/

(local a
local b
-- 함수 정의: 웹사이트
fn openInfoWebsite =
(
    shellLaunch "https://blog.naver.com/trueb000/" ""
)

try (destroyDialog lilaa) catch ()

-- Rollout 정의
rollout lilaa "LiL_Align_Anim" width:225 height:340
(
	-- UI 요소들 정의
	groupBox grp "Set Object" pos:[9,4] width:205 height:70
	pickButton Aobj "[ Actor ]" pos:[23,21] width:70 height:24 
	pickButton Bobj "[ Ref ]" pos:[123,21] width:70 height:24 
	label Actobjn "None" pos:[45,49] width:53 height:19 
	label Refobjn "None" pos:[142,50] width:53 height:19 
	-- Pos, Rot 체크박스
		groupBox grp2 "Set Option" pos:[9,80] width:205 height:90
	checkbox chkPos "Set align Positon" pos:[40, 100] width:120 height:15 checked: true
	checkbox chkRot "Set align Rotation" pos:[40, 120] width:120 height:15 checked: true
	checkbox chkScale "Set align Scale" pos:[40, 140] width:120 height:15 checked: true
	
	groupBox grp3 "Set Range" pos:[9,175] width:205 height:47 
	label lb1 "~" pos:[117,195] width:19 height:19 
	spinner startframe "" pos:[64,195] width:45 height:16 range:[-10000,10000,0] scale:1 
	spinner endframe "" pos:[135,195] width:45 height:16 range:[-1000,10000,0] scale:1 
	label lb2 "Frame" pos:[22,195] width:35 height:24 


	button apply "START BUILD" pos:[15,235] width:195 height:40
	label Refobdjn "by_lil_JongYoon" width:53 height:19 align:#center
	button infoButton "Info" pos:[85,300] width:55 height:25
	
	-- [A] 버튼 클릭시 이름변경
	on Aobj picked pic_a do
	(
		a = pic_a
		Actobjn.text = pic_a.name
	)

	-- [B] 버튼 클릭시 이름변경
	on Bobj picked pic_b do
	(	
		b = pic_b
		Refobjn.text = pic_b.name
	)

 -- Start 버튼 클릭 이벤트 핸들러

    on apply pressed do
    (
       undo on
		(
		n1 = startframe.value
		n2 = endframe.value
		n3 = n2-n1+1

		set animate on
		sliderTime = n1 
		select a
		
			
		for a in 1 to n3 do
		   (
                -- Pos 및 Rot 적용 여부에 따라 다르게 동작
                if chkPos.checked do
                (
                    -- Pos 적용
                    $.position = b.position
                )
                if chkRot.checked do
                (
                    -- Rot 적용
                    $.rotation = b.rotation
                )
				if chkScale.checked do
                (
                    -- Rot 적용
                    $.Scale = b.Scale
                )
                sliderTime += 1
            )
        )
    )
	
    on infoButton pressed do
    (
        openInfoWebsite() 
    )
)
)
-- Rollout을 대화 상자로 생성
createdialog lilaa