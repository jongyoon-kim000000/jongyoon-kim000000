-- 전역 변수로 선택한 오브젝트들을 저장
global selectedObjects
global setTransform -- 새로운 변수 추가

-- 함수 정의: 선택된 객체들의 포지션 및 로테이션 컨트롤러 초기화
fn resetTransformControllers obj =
(
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
)

-- Reset Constraint 버튼을 눌렀을 때 실행되는 코드
on btn_resetConstraint pressed do
(
    -- 현재 선택된 객체들 중에서 컨트롤러를 변경하고자 하는 오브젝트만 골라내기
    selectedObjects = selection

    -- 선택된 각 오브젝트에 대해 실행
    for obj in selectedObjects do
    (
        -- 선택된 오브젝트의 트랜스폼을 SET 변수에 저장
        setTransform = obj.transform

        -- 포지션 및 로테이션 컨트롤러 초기화 함수 호출
        resetTransformControllers obj

        -- SET 변수에 저장된 트랜스폼 값을 사용하여 새로운 포인트의 트랜스폼 설정
        obj.transform = setTransform
    )
)

-- UI 생성
try (destroyDialog lil_Reset_Constraint2.0) catch()

rollout lil_Reset_Constraint_Rollout "lil_Reset_Constraint2.0"
(
    button btn_resetConstraint "Reset Constraint" width:150 height:30
)

createDialog lil_Reset_Constraint_Rollout width:170 height:70