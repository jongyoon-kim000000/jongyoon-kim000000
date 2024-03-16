-------------------------------------------------------------------------------
-- Function : BuildRootMotion
-------------------------------------------------------------------------------
function BuildRootMotion removeX removeY removeZ bipRootBoneName bipBottomBoneName =
(
    -- Biped의 루트를 가져옵니다.
    local bipedRoot = getNodeByName bipRootBoneName
  
    -- Biped 루트가 존재하는지 확인합니다.
    if bipedRoot == undefined do
    (
        messagebox ( "Biped 루트가 존재하지 않거나 이름이 틀렸습니다" )
        return false
    )

    -- Biped 바닥 본을 가져옵니다.
    local bipedBottom = getNodeByName bipBottomBoneName
     
    -- Biped 바닥 본이 존재하는지 확인합니다.
    if bipedBottom == undefined do
    (
        messagebox( "Biped 바닥 본의 이름이 틀리므로 무시됩니다" )
    )
  
    -- Root 본이 이미 존재하는지 확인합니다.
    local rootBone = getNodeByName "Root"
  
    if rootBone != undefined do
    (
        messagebox ( "Root 본이 이미 존재합니다" )
        return false
    )
  
    -- Root 본을 생성합니다.
    local rootBone = BoneSys.createBone [ 0, 0, 0 ] [ 20, 0, 0 ] [ 0, 0, 1 ]
  
    rootBone.name = "Root"
  
    clearSelection()
  
    select rootBone
  
    -- Root 본의 위치 컨트롤러를 생성합니다.
    rootBone.position.controller = Position_XYZ()
  
    for t = animationRange.start to animationRange.end do
    (
        addNewKey rootBone.position.controller t
    )
  
    -- Biped의 루트와 관련된 위치 제한 컨트롤러를 생성합니다.
    local tempRootController = Position_Constraint()
    tempRootController.constraints.appendTarget bipedRoot 1.0
     
    -- Biped의 바닥 본과 관련된 위치 제한 컨트롤러를 생성합니다.
    local tempBottomController = Position_Constraint()
    if bipedBottom != undefined do
    (
        tempBottomController.constraints.appendTarget bipedBottom 1.0
    )
      
    -- Root 본의 위치 컨트롤러를 채웁니다.
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
      
    -- Biped 루트의 새 레이어를 생성합니다.
    local rootMotionLayerId = biped.numLayers bipedRoot.controller + 1
    biped.createLayer bipedRoot.controller rootMotionLayerId "RootMotionLayer"
    biped.setCurrentLayer bipedRoot.controller rootMotionLayerId
      
    clearSelection()
    select bipedRoot
    local horzController = bipedRoot.controller.horizontal.controller
      
    for t = animationRange.start to animationRange.end do
    (
        biped.addNewKey horzController t
    )
      
    -- Root 본의 위치 제한을 설정합니다.
    animate on
    (
        for t = animationRange.start to animationRange.end do
        (   
            at time t
            (               
                local newPos = horzController.value[4]
                  
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
      
    -- Root 본을 Biped의 루트로 설정합니다.
    bipedRoot.parent = rootBone 
      
    return true
)
  
---------------------------------------------------------------------------------------------
--  bipCom : biped를 원점(높이값 제외)으로 보내주는 함수
-- -Prameter
-- =bipCom : Biped의 COM 노드를 전하는 매겨변수 (Biped_Object)
---------------------------------------------------------------------------------------------
fn BC_rootBoneCreator_bipToOrigin bipCom = 
( 
disablesceneredraw() 

local currentBipLayerID = biped.getCurrentLayer bipCom.controller
biped.setCurrentLayer bipCom.controller 0

local userDP_type = units.DisplayType --사용하던  Unit Display type을 변수에 저장
units.DisplayType = #generic --수치 입력시 오류를 방지하기 위해 #generic으로 변경. 스크립트를 통해서 얻어오는 값은 모두  Generic임

local bipPos = biped.getTransform bipCom #pos

bipCom.transform.controller.moveAllMode = true --move All Mode를 활성화 한다.
biped.setTransform bipCom #pos [0,0,bipPos.Z] false --Biped의 위치값을 원점으로 한다.
--biped.setTransform bipCom #rotation (quat 1) false --Biped의 회전값을 (0,0,0)으로 한다. 

biped.collapseMoveAllMode bipCom.controller  --move All Mode collapse
bipCom.transform.controller.moveAllMode = false --move All Mode 비활성화

biped.setCurrentLayer bipCom.controller currentBipLayerID
enablesceneredraw()
max views redraw
units.DisplayType = userDP_type
 )  
 
 
-------------------------------------------------------------------------------
-- UI
-------------------------------------------------------------------------------
try (destroyDialog ::RootMotionUI) catch ()
  
rollout RootMotionUI "SetRootMotion"width:215 height:220
(
    checkbox checkRemoveX "Remove X" checked:true
    checkbox checkRemoveY "Remove Y"
    checkbox checkRemoveZ "Remove Z" checked:true
     
    edittext bipedRootName "Biped Root : " text:"Bip001"
    edittext bipedBottomName "Biped Bottom : " text:"Bip001 L Toe0Nub" readOnly:true
     
    button buttonOK "Create" pos:[40,120]width:120 height:30
    on buttonOK pressed do
    (
        BuildRootMotion checkRemoveX.checked checkRemoveY.checked checkRemoveZ.checked bipedRootName.text bipedBottomName.text
        DestroyDialog RootMotionUI
    )
     
    on checkRemoveZ changed theState do
    (
        bipedBottomName.readOnly = checkRemoveZ.checked
    )
	
	
	
	
	button Del "Remove Root motion" pos:[40,155]width:120 height:30
	on Del pressed do
    (  
			-------------------------------------------------------------------------------
			-- get biped root : Biped COM을 가져옴
			------------------------------------------------------------------------------- 

					if isValidNode $Root do delete $Root
					-------------------------------------------------------------------------------
					-- 기존에 RootMotionLayer가 Biped에 있을 경우, 삭제
					------------------------------------------------------------------------------- 
					if isValidNode selectedBiped and isKindOf selectedBiped Biped_Object do
					for i=0 to  biped.numLayers selectedBiped.controller do
					(
						bipLayerName = biped.getLayerName selectedBiped.controller i
						if bipLayerName == "RootMotionLayer" do
						(
						biped.deleteLayer selectedBiped.controller i
						exit
						)
					)
			
    )

	)	
  

createDialog RootMotionUI


-------------------------------------------------------------------------------
-- open UI
-------------------------------------------------------------------------------
  
CreateDialog RootMotionUI 200 150