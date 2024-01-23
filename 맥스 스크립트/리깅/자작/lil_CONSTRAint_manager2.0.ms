/*만든이 :김종윤
문의: https://blog.naver.com/trueb000/223314441951
수정, 배포는 자유이며 많은 피드백 부탁드립니다.
*/

--다이얼로그창이 이미 켜져있다면 닫고 실행한다
try (destroyDialog constraintManager) catch ()

rollout constraintManager "LiLConstraint_Tool" width:229 height:376
(
	groupBox 'prefix' "Edit prefix" pos:[14,10] width:195 height:158 align:#left
    --수정가능한 접두사의 디폴트 문구 설정
	edittext prefixEditText "Prefix:" text:"NewPrefix_" fieldWidth:80 pos:[32,34] width:140 height:20 enabled:true align:#left
    --버튼생성
	button setPrefix  "set" pos:[27,61] width:76 height:24 align:#left
	button deletePrefix "reset" pos:[116,61] width:76 height:24 align:#left
   --setprefix에 대한 기능 정의
    on setPrefix pressed do
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

    on deletePrefix pressed do  
    (
      if selection.count > 0 then
(
    for obj in selection do
    (
        local prefixLength = prefixEditText.text.count + 1
        obj.name = substring obj.name prefixLength (obj.name.count )
    )

)
else
(
    messagebox "NONE SELECTED." title:"Warning"
)
    )

    --사용할 접두사를 선언
    edittext originPrefix "Origin Prefix:" text:"ORIGIN_" width:150 pos:[38,96] width:133 height:20 enabled:true align:#left
    edittext refPrefix "Ref Prefix:" text:"REF_" width:150 pos:[38,124] width:134 height:20 enabled:true align:#left

    --여기서부턴 컨스트레인트입니다.
    --링크컨스트레인트
	button 'constraintBtn' "link " pos:[27,205] width:76 height:24 align:#left
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

            -- 새로운 Transform 제약 생성
            newTransformConstraint = Link_Constraint ()

            -- "REF_" 객체의 Transform 컨트롤러를 새로운 제약으로 설정
            refObj.Transform.controller = newTransformConstraint
            newTransformConstraint.AddTarget correspondingoriginObj 0
        )
    )
	
  )
 )
 button 'resetLC' "reset" pos:[117,204] width:76 height:24 align:#left
-- 현재 선택된 객체들 중에서 컨트롤러를 변경하고자 하는 오브젝트만 골라내기
on resetBtn pressed do
(
    -- 선택된 객체와 임시 트랜스폼을 저장할 전역 변수 정의
    global selectedObjects
    global setTransform 

    -- Biped_Object 클래스가 아닌 객체만 필터링하여 선택된 객체들을 저장
    selectedObjects = for obj in selection where (classof obj != Biped_Object) collect obj

    -- 각 선택된 객체에 대해 반복
    for obj in selectedObjects do
    (
        -- 객체의 현재 트랜스폼을 setTransform 변수에 저장
        setTransform = obj.transform

            --객체의 Transform 컨트롤러 가져오기
            TransformController = obj.Transform.controller

            -- 새로운 Transform생성
            newTransformController = prs ()

            -- 기존  컨트롤러를 새로운 것으로 대체
            obj.Transform.controller = newTransformController

        -- setTransform 변수를 사용하여 원래의 트랜스폼을 복원
        obj.transform = setTransform
     )
 )

	button 'btn4' "position" pos:[27,239] width:76 height:24 align:#left
	button 'btn5' "reset" pos:[118,239] width:76 height:24 align:#left
	button 'btn6' "orientaition" pos:[26,299] width:76 height:24 align:#left
	button 'btn7' "reset" pos:[116,300] width:76 height:24 align:#left
	checkbox 'chk1' "keep initial offset" pos:[55,273] width:121 height:19 align:#left
	checkbox 'chk2' "keep initial offset" pos:[52,330] width:121 height:19 align:#left
	groupBox 'const' "Set Constraint" pos:[13,178] width:194 height:181 align:#left

)
createDialog constraintManager