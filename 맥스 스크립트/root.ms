-------------------------------------------------------------------------------
-- Function : BuildRootMotion
-------------------------------------------------------------------------------

function BuildRootMotion removeX removeY removeZ bipRootBoneName bipBottomBoneName =
(
    ----------------------------------------------------------------------------
    -- biped com 추적 
    ----------------------------------------------------------------------------
  
    local bipedRoot = getNodeByName bipRootBoneName
  
    if bipedRoot == undefined do
    (
        messagebox ( "Biped 루트 본을 찾을 수 없습니다." )
        return false
    )
     
    ----------------------------------------------------------------------------
    -- 바이패드 바텀 추적
    ----------------------------------------------------------------------------
     
    local bipedBottom = getNodeByName bipBottomBoneName
     
    if bipedBottom == undefined do
    (
        messagebox( "Biped 바텀 본을 찾을 수 없습니다." )
    )
     
    ----------------------------------------------------------------------------
    -- 루트 본이 존재하는지 확인
    ----------------------------------------------------------------------------
  
    local rootBone = getNodeByName "Root"
  
    if rootBone != undefined do
    (
        messagebox ( "Root 본이 이미 존재합니다." )
        return false
    )
  
    ----------------------------------------------------------------------------
    -- rootBone 생성
    ----------------------------------------------------------------------------
  
    local rootBone = Dummy size:10 wirecolor:yellow
  
    rootBone.name = "Root"
  
    clearSelection()
  
    select rootBone
  
    ----------------------------------------------------------------------------
    -- rootBone 위치 컨트롤러 생성
    ----------------------------------------------------------------------------
  
    rootBone.position.controller = Position_XYZ()
  
    for t = animationRange.start to animationRange.end do
    (
        addNewKey rootBone.position.controller t
    )
  
    ----------------------------------------------------------------------------
    -- root에 대한 위치 제약 컨트롤러 생성
    ----------------------------------------------------------------------------
  
    local tempRootController = Position_Constraint()
  
    tempRootController.constraints.appendTarget bipedRoot 1.0
     
    ----------------------------------------------------------------------------
    -- 바텀에 대한 위치 제약 컨트롤러 생성
    ----------------------------------------------------------------------------
     
    local tempBottomController = Position_Constraint()
     
    if bipedBottom != undefined do
    (
        tempBottomController.constraints.appendTarget bipedBottom 1.0
    )
      
    ----------------------------------------------------------------------------
    -- rootBone 위치 컨트롤러 채우기
    ----------------------------------------------------------------------------
  
    animate on
    (
        for t = animationRange.start to animationRange.end do
        (
            at time t
            (
                if true == removeX then
                    rootBone.position.controller.value.x = 0.0
                else
                    rootBone.position.controller.value.x = tempRootController.value.x
                  
                if true == removeY then
                    rootBone.position.controller.value.y = 0.0
                else
                    rootBone.position.controller.value.y = tempRootController.value.y
                  
                if true == removeZ then
                (
                    rootBone.position.controller.value.z = 0.0
                )
                else
                (
                    local zValue = 0.0
                     
                    if bipedBottom != undefined then
                        zValue = tempBottomController.value.z
                    else
                        zValue = tempRootController.value.z
                     
                    rootBone.position.controller.value.z = zValue
                )
            )
        )
    )
      
    ----------------------------------------------------------------------------
    -- biped 레이어 생성
    ----------------------------------------------------------------------------
      
    rootMotionLayerId = biped.numLayers bipedRoot.controller + 1
      
    biped.createLayer bipedRoot.controller rootMotionLayerId "RootMotionLayer"
      
    biped.setCurrentLayer bipedRoot.controller rootMotionLayerId
      
    clearSelection()
      
    select bipedRoot
      
    horzController = bipedRoot.controller.horizontal.controller
      
    for t = animationRange.start to animationRange.end do
    (
        biped.addNewKey horzController t
    )
      
    animate on
    (
        for t = animationRange.start to animationRange.end do
        (   
            at time t
            (               
                newPos = horzController.value[ 4 ]
                  
                if false == removeX do
                    newPos.x = 0.0
                  
                if false == removeY do
                    newPos.y = 0.0
                  
                if false == removeZ do
				(
					if bipedBottom != undefined then
						newPos.z = newPos.z - tempBottomController.value.z
					else
                        newPos.z = 0.0
				)
                  
                biped.setTransform bipedRoot #pos newPos false
            )
        )
    )
      
    ----------------------------------------------------------------------------
    -- rootBone을 루트로 설정
    ----------------------------------------------------------------------------
      
    bipedRoot.parent = rootBone 
      
    return true
)
  
-------------------------------------------------------------------------------
-- UI
-------------------------------------------------------------------------------
  
rollout RootMotionUI "Root bone Helper"
(
    checkbox checkRemoveX "Follow X "
    checkbox checkRemoveY "Follow Y"
    checkbox checkRemoveZ "Follow Z" checked:true
     
    edittext bipedRootName "Biped COM: " text:"Bip001"

    button buttonOK "Create" pos:[40,90]width:120 height:30
      
    on buttonOK pressed do
    (
        BuildRootMotion checkRemoveX.checked checkRemoveY.checked checkRemoveZ.checked bipedRootName.text bipedBottomName.text
        DestroyDialog RootMotionUI
    )
     
    on checkRemoveZ changed theState do
    (
        bipedBottomName.readOnly = checkRemoveZ.checked
    )
	    button Del "Remove Root motion" pos:[40,120]width:120 height:30
on button Del pressed do
    (
	actionMan.executeAction 972555510 "40172" 
    )

)
  


-------------------------------------------------------------------------------
-- UI 열기
-------------------------------------------------------------------------------
  
CreateDialog RootMotionUI 200 170