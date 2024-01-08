rollout changeControllerRollout "Change Controller"
(
    button changeButton "Change" width:120 height:30
    
    on changeButton pressed do
    (
        global selectedObjects
        global createdPoints

        -- 선택된 오브젝트의 트랜스폼 정보를 저장할 배열
        local transformsArray = #()

        -- 선택된 각 오브젝트에 대해 실행
        for obj in selectedObjects do
        (
            -- 트랜스폼 정보를 배열에 추가
            append transformsArray obj.transform
        )

        -- 선택된 각 오브젝트에 대해 실행
        for i = 1 to selectedObjects.count do
        (
            local obj = selectedObjects[i]
            
            -- 오브젝트의 포지션 컨트롤러 가져오기
            posController = obj.position.controller

            -- 새로운 XYZ 포지션 컨트롤러 생성
            newPositionController = Position_XYZ()

            -- 기존 포지션 컨트롤러 대체
            obj.position.controller = newPositionController

            -- 오브젝트의 로테이션 컨트롤러 가져오기
            rotController = obj.rotation.controller

            -- 새로운 XYZ 로테이션 컨트롤러 생성
            newRotationController = Euler_XYZ()

            -- 기존 로테이션 컨트롤러 대체
            obj.rotation.controller = newRotationController

            -- 생성된 포인트의 Transform을 현재 오브젝트에 적용
            obj.transform = transformsArray[i]
        )
    )
)

-- UI 생성
createDialog changeControllerRollout width:150 height:70