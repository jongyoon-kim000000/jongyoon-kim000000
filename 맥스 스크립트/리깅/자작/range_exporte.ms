-- UI 생성
rollout exportAnimation "Export Animation" width:200
(
    group "Frame Range:"
    (
        spinner startFrameSpinner "Start Frame: " range:[0, 10000, 0] type:#integer
        spinner endFrameSpinner "End Frame: " range:[0, 10000, 20] type:#integer
    )

    button exportButton "Export" width:100 height:30
    
    on exportButton pressed do
    (

        -- 익스포트할 파일 경로 설정
        local exportPath = getSaveFileName caption:"Export Animation" types:"FBX Files (*.fbx)|*.fbx|All Files (*.*)|*.*" 

        -- 선택 취소했을 때 처리
        if exportPath == undefined then exit

        -- 사용자가 입력한 프레임 범위 가져오기
        local startFrame = startFrameSpinner.value
        local endFrame = endFrameSpinner.value

        -- 프레임 범위 설정
        animationRange = interval startFrame endFrame

        -- 애니메이션 익스포트
        exportFile exportPath #noPrompt using:FBXEXP
    )
)

-- UI 실행
createDialog exportAnimation