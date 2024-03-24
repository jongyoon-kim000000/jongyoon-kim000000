-- 함수 정의: RootBone 설정을 처리하는 함수
fn setRootBone =
(
a = $Bip001
-- 0,0,0 위치에 크기가 20인 포인트 헬퍼 생성
Root= Point name:"Root" size:20 position:[0,0,0]

-- 포인트 헬퍼의 상태를 활성화
Root.box = on
Root.cross = off
	
-- 0,0,0 위치에 크기가 20인 포인트 헬퍼 생성
zeropoint = Point name:"zero" size:4 position:[0,0,0]

-- 포인트 헬퍼의 상태를 활성화
zeropoint.box = on
zeropoint.isHidden = true

-- 더미 생성
newDummy = Dummy name:"Con_Root" position:[0,0,0]
-- "Con_Root"의 Y축으로 +10 이동
newDummy.position.y = newDummy.position.y + 10


--커스텀파라미터 정의
con = newDummy
ca=attributes RootControl
(
	parameters params rollout:ro_camControls
	(
		FX type:#boolean ui:followX
		FY type:#boolean ui:followY
	)
	rollout ro_camControls "Position Root" width:162 height:77
	(
		checkbox followX "Follow X" checked:true
		checkbox followY "Follow Y" checked:true
	)
)
 --newDummy에 커스텀파라미터 적용
custAttributes.add con ca


--거리측정용 오브젝트설치
myExposeTransform = ExposeTM()

myExposeTransform.exposeNode = $Bip001Pelvis
myExposeTransform.useParent = off
myExposeTransform.localReferenceNode = zeropoint
myExposeTransform.isHidden = true


--루트본에 expression 추가
Root.pos.controller = Position_XYZ ()
Root.pos.controller.X_Position.controller = Float_Expression ()
Root.pos.controller.Y_Position.controller = Float_Expression ()

/*
이부분은 테스트중인데 
체크박스가 FLOAT 속성이기때문에 
퍼센트로 바꾸고 체크박스에 0.01을 곱해서 사용해야 합니다.
각 변수에 특정 오브젝트의 특정 파라미터 값을 넣는 방법을 찾고 있습니다.
FolX = root
FolY = root
locaX = root
locaY = root

--루트본의 포지션 컨트롤러 
Root.pos.controller = Position_XYZ ()
Root.pos.controller = position_script ()
			Root.pos.controller.AddNode "FX" FolX
            Root.pos.controller.AddNode "FY" FolY
			Root.pos.controller.AddNode "lX"locaX
            Root.pos.controller.AddNode "lY"locaY
			Root.pos.controller.SetExpression "[ FX*lX, FY*lY, 0 ] "
*/

)

-- 함수 정의: 정보 버튼을 눌렀을 때 실행되는 함수
fn openInfoWebsite =
(
    shellLaunch "https://blog.naver.com/trueb000/" ""
)

-- UI 생성
try (destroyDialog ::LIL_Auto_RootBone) catch ()

rollout LIL_Auto_RootBone "LIL_Auto RootBone" width:180 height:80
(
    button setButton "Set" width:150 height:30 align:#center
    button infoButton "Info" width:60 height:20  align:#center


    on setButton pressed do
    (
        setRootBone() -- set 버튼을 눌렀을 때 호출되는 함수
        messagebox "RootBone 설정이 완료되었습니다."
    )

    on infoButton pressed do
    (
        openInfoWebsite() -- info 버튼을 눌렀을 때 호출되는 함수
    )
)

-- UI 실행
createDialog LIL_Auto_RootBone width:180 height:80