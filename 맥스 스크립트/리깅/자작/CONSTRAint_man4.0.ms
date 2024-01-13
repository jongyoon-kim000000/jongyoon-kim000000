/*만든이 :김종윤
문의: https://blog.naver.com/trueb000/223314441951
수정, 배포는 자유이며 많은 피드백 부탁드립니다.
*/

--다이얼로그창이 이미 켜져있다면 닫고 실행한다
try (destroyDialog constraintManager) catch ()

rollout constraintManager "lil_Constraint Manager" width:250
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
    button constraintBtn "SetConstraint" width:80
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
    (
-- 선택한 모든 객체 배열에 저장
selectedObjects = selection as array

-- 배열에서 ORIGIN_ 가 앞에 붙은 객체들과 REF_ 가 앞에 붙은 객체들을 각각 필터링
originObjects = for obj in selectedObjects where matchPattern obj.name pattern:"ORIGIN_*" collect obj
refObjects = for obj in selectedObjects where matchPattern obj.name pattern:"REF_*" collect obj

-- "REF_" 다음에 오는 문자들을 R 배열에 저장
R = for refObj in refObjects collect substring refObj.name 5 (refObj.name.count - 1)

-- ORIGIN_ 다음에 오는 문자들을 O 배열에 저장
O = for originObj in originObjects collect substring originObj.name 8 (originObj.name.count - 1)
-- 각 REF 오브젝트에 대해 해당되는 ORIGIN 오브젝트를 찾아서 타겟으로 추가
for refObj in refObjects do
(
    -- R 배열에서 일치하는 객체 찾기
    indexRef = findItem R (substring refObj.name 5 (refObj.name.count - 1))

    -- 찾은 경우에만 실행
    if indexRef > 0 then
    (
        -- 해당 REF 오브젝트에 대한 ORIGIN 오브젝트 찾기
        correspondingOriginObj = undefined
        for originObj in originObjects do
        (
            -- O 배열에서 찾기
            indexO = findItem O (substring originObj.name 8 (originObj.name.count - 1))

            -- 찾은 경우
            if indexO > 0 then
            (
                -- 일치하는 문자열이 있는 경우에만 실행
                if substring refObj.name 5 (refObj.name.count - 1) == substring originObj.name 8 (originObj.name.count - 1) then
                (
                    correspondingOriginObj = originObj
                    exit -- 찾은 경우 루프 종료
                )
            )
        )

        -- 찾은 ORIGIN 오브젝트가 있으면 타겟으로 추가
        if correspondingOriginObj != undefined then
        (
            -- 포지션 컨트롤러 가져오기
            posController = refObj.position.controller

            -- 새로운 포지션 컨스트레인트 생성
            newPositionConstraint = Position_Constraint()
            
            -- 타겟으로 사용할 ORIGIN 오브젝트를 포지션 컨스트레인트에 추가
            newPositionConstraint.appendTarget correspondingOriginObj 50.0

            -- 기존 포지션 컨트롤러 대체
            refObj.position.controller = newPositionConstraint

            -- 오리엔테이션 컨트롤러 가져오기
                    orientController = refObj.rotation.controller

                    -- 새로운 오리엔테이션 컨스트레인트 생성
                    newOrientationConstraint = Orientation_Constraint()
                    
                    -- 타겟으로 사용할 ORIGIN 오브젝트를 오리엔테이션 컨스트레인트에 추가
                    newOrientationConstraint.appendTarget correspondingoriginObj 50.0

                    -- 기존 오리엔테이션 컨트롤러 대체
                    refObj.rotation.controller = newOrientationConstraint
        )
    )
)



)
)
createDialog constraintManager