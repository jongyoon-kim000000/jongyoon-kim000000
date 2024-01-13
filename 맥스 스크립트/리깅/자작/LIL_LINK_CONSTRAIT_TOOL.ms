
--다이얼로그창이 이미 켜져있다면 닫고 실행한다
try (destroyDialog constraintManager) catch ()

rollout constraintManager "Constraint Manager_LINK" width:250
(
    --수정가능한 접두사의 디폴트 문구 설정
    edittext prefixEditText "Prefix:" text:"NewPrefix_" fieldWidth:80
     --버튼생성
    button setPrefixButton "Set" width:80
    button deletePrefixBtn "Delete" width:80 

     --사용할 접두사를 선언
    edittext originPrefix "Origin Prefix:" text:"ORIGIN_" width:150
    edittext refPrefix "Ref Prefix:" text:"REF_" width:150
     --버튼생성
    button constraintBtn "SetLinkConstraint" width:80
    button resetBtn "Reset" width:80

   --setprefix에 대한 기능 정의
    on setPrefixButton pressed do
    (
        local prefix = prefixEditText.text
        if selection.count > 0 then
        (
            for obj in selection do
            (
                obj.name = prefix + obj.name
            )
            messagebox ("Prefix set successfully.")
        )
        else
        (
            messagebox "NONE SELECTED." title:"Warning"
        )
    )
    --delete버튼의 기능정의

    on deletePrefixBtn pressed do  
    (
      if selection.count > 0 then
(
    for obj in selection do
    (
        local prefixLength = prefixEditText.text.count
        obj.name = substring obj.name prefixLength (obj.name.count )
    )

)
else
(
    messagebox "NONE SELECTED." title:"Warning"
)
    )

  on resetBtn pressed do
    (
global selectedObjects
global setTransform 

-- 현재 선택된 객체들 중에서 컨트롤러를 변경하고자 하는 오브젝트만 골라내기
selectedObjects = for obj in selection where (classof obj != Biped_Object) collect obj

-- 선택된 각 오브젝트에 대해 실행
for obj in selectedObjects do
(
    -- 선택된 오브젝트의 트랜스폼을 SET 변수에 저장
    setTransform = obj.transform

    -- 오브젝트의 포지션 컨트롤러 가져오기
    posController = obj.position.controller

    -- 새로운 XYZ 포지션 컨트롤러 생성
    newPositionController = Position_XYZ()

    -- 기존 포지션 컨트롤러 대체
    obj.position.controller = newPositionController
    obj.transform = setTransform

    -- 오브젝트의 로테이션 컨트롤러 가져오기
    rotController = obj.rotation.controller

    -- 새로운 XYZ 로테이션 컨트롤러 생성
    newRotationController = Euler_XYZ()

    -- 기존 로테이션 컨트롤러 대체
    obj.rotation.controller = newRotationController
    
    -- SET 변수에 저장된 트랜스폼 값을 사용하여 새로운 포인트의 트랜스폼 설정
    obj.transform = setTransform
)
        
    )
--컨스트레인 버튼 기능정의
    on constraintBtn pressed do
    (-- 선택된 객체를 배열로 가져오기
selectedObjects = selection as array

-- "ORIGIN_"로 시작하는 객체와 "REF_"로 시작하는 객체를 분리하기
originObjects = for obj in selectedObjects where matchPattern obj.name pattern:"ORIGIN_*" collect obj
refObjects = for obj in selectedObjects where matchPattern obj.name pattern:"REF_*" collect obj

-- "REF_"에서 'R'을 추출하기
R = for refObj in refObjects collect substring refObj.name 5 (refObj.name.count - 1)

-- "ORIGIN_"에서 'O'를 추출하기
O = for originObj in originObjects collect substring originObj.name 8 (originObj.name.count - 1)

-- 각 "REF_" 객체에 대한 처리
for refObj in refObjects do
(
    -- 'R'에 대한 인덱스 찾기
    indexRef = findItem R (substring refObj.name 5 (refObj.name.count - 1))

    -- 인덱스가 있는 경우
    if indexRef > 0 then
    (
        -- 해당하는 "ORIGIN_" 객체 찾기
        correspondingOriginObj = undefined
        for originObj in originObjects do
        (
            -- 'O'에 대한 인덱스 찾기
            indexO = findItem O (substring originObj.name 8 (originObj.name.count - 1))

            -- 인덱스가 있는 경우
            if indexO > 0 then
            (
                -- "REF_" 객체와 "ORIGIN_" 객체의 일치 확인
                if substring refObj.name 5 (refObj.name.count - 1) == substring originObj.name 8 (originObj.name.count - 1) then
                (
                    correspondingOriginObj = originObj
                    exit -- 해당하는 "ORIGIN_" 객체를 찾았으므로 루프 종료
                )
            )
        )

        -- 일치하는 "ORIGIN_" 객체가 있는 경우
        if correspondingOriginObj != undefined then
        (
            -- "REF_" 객체의 Transform 컨트롤러 가져오기
            TransformController = refObj.Transform.controller
            print ("TransformController : " + TransformController as string)

            -- 새로운 Transform 제약 생성
            newTransformConstraint = Link_Constraint ()

            -- "REF_" 객체의 Transform 컨트롤러를 새로운 제약으로 설정
            refObj.Transform.controller = newTransformConstraint
            newTransformConstraint.AddTarget correspondingoriginObj 0
        )
    )
)




)
)
createDialog constraintManager