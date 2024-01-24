a = $Bip001Pelvis
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
--myExposeTransform.isHidden = true


--루트본에 expression 추가
Root.pos.controller = position_script ()
