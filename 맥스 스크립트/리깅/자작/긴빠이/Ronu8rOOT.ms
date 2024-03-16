--macroScript RootBoneCreator category:"Round8" tooltip:"Root Bone Creator" icon:#("RootBoneCreator",1)
(
local ver = "V0.4.8.1"

global BC_RootBoneCreator_rollout
global fbxAnimationExporter_rollout
global BC_rootBoneCreator_refreshNodesList
global BC_rootBoneCreator_overlapNodeName
global rootBoneCreator_Refresh4fileOpen
global rootBoneCreator_closeRolloutFloater

/*================================================================================================


RootBoneCreator 


================================================================================================*/


-----------------------------------------------------------------------------
-- BC_rootBoneCreator_getBipObject : Scene안에 있는 Biped Object들을 배열로 모아 반환해 주는 함수
-----------------------------------------------------------------------------
fn BC_rootBoneCreator_getBipObject =
(
local objs = $* 
local result  = for obj in objs where classof obj == Biped_Object collect obj
return result
)

-----------------------------------------------------------------------------
-- BC_rootBoneCreator_getBipComs : Scene안에 있는 Biped COM을 배열로 모아주는 함수
--   BC_rootBoneCreator_getBipObject를 호출함.
-----------------------------------------------------------------------------
fn BC_rootBoneCreator_getBipComs = --Scene안에 있는 Biped COM을 배열로 모아주는 함수
( 
local bipedObjs = BC_rootBoneCreator_getBipObject()
local result = for bipedObj in bipedObjs collect bipedObj.controller.rootNode
result = makeUniqueArray result
return result
)

-----------------------------------------------------------------------------
-- BC_rootBoneCreator_nodeArrayToStringArray : 노드 배열을 문자열 배열로 바꾸어주는 스크립트
----------------------------------------------------------------------------- 
fn BC_rootBoneCreator_nodeArrayToStringArray objs =
(
local result = for obj in objs collect obj.name
return result
)


---------------------------------------------------------------------------------------------
-- BC_rootBoneCreator_stringArrayToNodeArray : 문자 배열을 노드 배열로 변환해서 반환하는 함수. 결과는 2차원 배열.
--    [1] : 변환 성공한 노드 배열
--    [2] : 변환 실패한 문자 배열
-- -Parameter
-- =strArray : Noe로 변환할 문자열 배열 (String array)
--------------------------------------------------------------------------------------------
fn BC_rootBoneCreator_stringArrayToNodeArray strArray = 
(
local result =#(#(),#())
for str in strArray do
(
local theNode = getNodeByName str
if theNode != undefined then append result[1] theNode
else append result[2] str
)
return result
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
 
 
---------------------------------------------------------------------------------------------
-- BC_rootBoneCreator_createRootBone : Root Bone을 만드는 함수
--
-- Pramerter
-- =givenName : Root Bone의 이름을 정하는 매개변수 (string)
-- =boxMode   : Root Bone의 Display as box를 정하는 배개변수. 기본값은 false (Bool)
---------------------------------------------------------------------------------------------
fn BC_rootBoneCreator_createRootBone givenName boxMode:false =        
(
rootBone = BoneSys.createBone [ 0, 0, 0 ] [ 20, 0, 0 ] [ 0, 0, 1 ]
rootBone.name = givenName 
rootBone.sidefins = off
rootBone.frontfin = off
rootBone.width = 4
rootBone.height = 4

if boxMode == true do 
(
rootBone.wirecolor = red
rootBone.boxMode = true
)
return rootBone
)


---------------------------------------------------------------------------------------------
-- BC_rootBoneCreator_createTrjParent : Trjectory parent 헬퍼를 제작하는 함수
--
-- -Pramerter 
-- =bipedRootNode : Biped의 COM 노드를 알려주는 매개변수
---------------------------------------------------------------------------------------------
fn BC_rootBoneCreator_createTrjParent bipedRootNode =
(
local trajectoryParent
if isValidNode $trajectoryParent then trajectoryParent=$trajectoryParent
else trajectoryParent = point size:12.5 cross:off box:on name:"trajectoryParent" pos:[0,0,0]

trajectoryParent.wireColor=red 
trajectoryParent.pos.controller = Position_Constraint ()
trajectoryParent.pos.controller.appendTarget bipedRootNode 50.0


return trajectoryParent 
)


---------------------------------------------------------------------------------------------
-- BC_rootBoneCreator_createTrjPoint : Trajectory Point 헬퍼를 제작하는 함수
--
-- -Pramerter 
-- =trjParentNode : Biped의 COM 노드를 알려주는 매개변수
-- = x  : Trajectory가 X축을 따라갈 것인지 결정하는 매개변수 (Bool)
-- =
-- =
---------------------------------------------------------------------------------------------
fn BC_rootBoneCreator_createTrjPoint trjParentNode x y z =
(
local trajectoryPoint

if isValidNode  $trajectoryPoint then trajectoryPoint=$trajectoryPoint
else trajectoryPoint = point size:12.5 cross:off box:on name:"trajectoryPoint" pos:[0,0,0]

trajectoryPoint.wireColor=yellow
trajectoryPoint.pos= trjParentNode.pos
trajectoryPoint.pos.z= 0
trajectoryPoint.parent = trjParentNode
-------------------------------------------------------------------------------------
xBit =#{}
yBit =#{}
zBit =#{}

if x==true do xBit =#{1}
if y==true do yBit =#{2}
if z==true do zBit =#{3}

trjBit = xBit +yBit +zBit + #{4,5,6,7,8,9}

print trjBit

setInheritanceFlags trajectoryPoint trjBit

------------------------------------------------------------------------------------- 

return trajectoryPoint

)

-------------------------------------------------------------------------------------
-- BC_rootBoneCreator_createTrjOrient : Trajectory Orient 헬퍼를 제작하는 함수
--
-- -Pramerter
-- bipedRootNode : Biped COM을 전달하는 매개변수 (Biped_Object)
-- trjParentNode   : TrajectoryParent 노드를 전달하는 매개변수 (Point)
-------------------------------------------------------------------------------------
fn BC_rootBoneCreator_createTrjOrient bipedRootNode trjParentNode =    
(
local trajectoryOrient

if isValidNode $trajectoryOrient then trajectoryOrient=$trajectoryOrient
else trajectoryOrient = point size:8 cross:on box:off name:"trajectoryOrient" pos:[0,0,0]

trajectoryOrient.wireColor = Orange
trajectoryOrient.pos = trjParentNode.pos
trajectoryOrient.pos.z= 0
trajectoryOrient.parent = trjParentNode 

trajectoryOrient.rotation.controller = LookAt_Constraint ()
trajectoryOrient.rotation.controller.appendTarget bipedRootNode 50.0
trajectoryOrient.rotation.controller.target_axis = 2
trajectoryOrient.rotation.controller.upnode_axis = 1
trajectoryOrient.rotation.controller.StoUP_axis = 1
trajectoryOrient.rotation.controller.RELATIVE = on


trajectoryOrient.rotation.controller.upnode_world = off
trajectoryOrient.rotation.controller.pickUpNode = bipedRootNode
trajectoryOrient.rotation.controller.viewline_length_abs = off

return trajectoryOrient 
)


-------------------------------------------------------------------------------------
-- BC_rootBoneCreator_collaseTRJ Animation Baking하는 함수
-- -Pramerter
-- selOBJs : Animation을 Baking할 노드들을 전달하는 매개변수 (Node_array)
-------------------------------------------------------------------------------------
fn BC_rootBoneCreator_collaseTRJ selOBJs=
( 
local forceUpdate = keyboard.shiftPressed -- if SHIFT is pressed when the macro is called, a viewport redraw is enforced for each timestep to ensure a full update of all controllers
if forceUpdate then format "MB Collapse: Enforcing full viewport update. This might be slow but will ensure proper updating of all controllers\n"

select selOBJs
objlist = selection as array
for bake_obj in objlist do ( -- for every select object do
format "MB Collapse: Collapsing transformation of object %\n" bake_obj.name
local p = undefined
local old_prs_ctrl = copy bake_obj.transform.controller -- store old controller for catch()
with undo on (
if not forceUpdate then disableSceneRedraw(); -- not using redraw context for max4 compatibility
-- disableSceneRedraw is problematic as not all scripted controllers are updated!
try (
p = Point() -- create temp point object
-- copy global transform of source object into temp object
for i = animationRange.start to animationRange.end do (
if forceUpdate then sliderTime = i -- set slider time to force a global update of all animation data
at time i (
with animate on p.transform = bake_obj.transform
)
)
-- kill old transform controller and assign new, clean one
bake_obj.transform.controller = transform_script() 
bake_obj.transform.controller = prs() 

if not (isGroupMember bake_obj) then bake_obj.parent = undefined -- unlink if not in a group
-- copy temp object animation back into source object
for i = animationRange.start to animationRange.end do (
at time i (
with animate on bake_obj.transform = p.transform
)
)
delete p -- delete temp point obj
p = undefined
if not forceUpdate then enableSceneRedraw()
) catch (
format "MB Collapse: Fatal error - exiting\n"
if p!=undefined then delete p
bake_obj.transform.controller = old_prs_ctrl
if not forceUpdate then enableSceneRedraw()
) -- catch 
) -- with undo on
) -- for bake_obj in...
if objlist.count == 0 then (
format "MB Collapse: No object selected\n"
)
)

-------------------------------------------------------------------------------------------------
-- BC_rootBoneCreator_adjustBipLayerRotate : RootBone 제작시, 생성된 Biped Layer에서 회전을 보정해 주는 함수
--
-- -Pramerter
-- bipCOM : Biped COM을 전달해 주는 매개변수 (Biped_Object)
-- rootBone : Root 본을 전달해주는 매개변수 (BoneGeometry)
-------------------------------------------------------------------------------------------------
fn BC_rootBoneCreator_adjustBipLayerRotate bipCOM rootBone = 
(
local userDP_type = units.DisplayType --사용하던  Unit Display type을 변수에 저장
units.DisplayType = #generic --수치 입력시 오류를 방지하기 위해 #generic으로 변경. (스크립트를 통해서 얻어오는 값은 모두  Generic임)

sliderTime = animationRange.start

local bipDummy = dummy()



for i=animationRange.start to animationRange.End do
(
sliderTime = i
rootBoneRot_Z = (in coordsys world rootBone.transform.rotation as eulerAngles).z 

bipDummy.transform=bipCOM.transform
rotate bipDummy (angleaxis -rootBoneRot_Z [0,0,1])
animate on 
(
 at time i bipCom.transform = bipDummy.transform
)
)
delete bipDummy
units.DisplayType = userDP_type
)

local bipNames = BC_rootBoneCreator_nodeArrayToStringArray(BC_rootBoneCreator_getBipComs()) --Scene안에 있는 바이패드 이름을 수집하는 Array
local rootBoneName= "Root" -- RootBone 이름 선언
local matchingtime = sliderTime


rollout BC_RootBoneCreator_rollout "Root Bone Creator "
(
checkbox xChkB "X축 추출     " pos:[13,5] toolTip:"Root Bone을 만들 때,\nX축 이동값을 추출합니다." 
checkbox yChkB "Y축 추출     " pos:[13,25] toolTip:"Root Bone을 만들 때,\nY축 이동값을 추출합니다." 
checkbox zChkB "Z축 추출     " pos:[13,45]  toolTip:"Root Bone을 만들 때,\nZ축 이동값을 추출합니다.\n원점 이하로는 내려가지 않습니다."
checkbox rChkB "회전 추출     " pos:[115,45]  toolTip:"Root Bone을 만들 때,\nZ축 회전값을 추출합니다.\n회전값이 일정하거나, 수동으로 회전값을 조절할 수 없을 때 사용하시면 됩니다." visible:false

checkbox pinX "X축 고정" pos:[115,5] toolTip:"Root Bone을 만들 때,\nX축 이동값을 고정합니다."
checkbox pinY "Y축 고정" pos:[115,25] toolTip:"Root Bone을 만들 때,\nY축 이동값을 고정합니다." 
--dropdownlist pinningOpt "Pin Type: " items:#("no","X","Y","X/Y") pos:[115,5] tooltip:"Root본을 설치할 Biped를 선택합니다." width:50


checkbox bipOrigin "Bip send to Origin" pos:[210,5] toolTip:"활성화될 경우, Biped를 원점에 위치 시킵니다.\nBiped COM에 키가 없을 경우, 제대로 작동하지 않을 수 있습니다." checked:true
checkbox delTrj "Delete Guides" pos:[210,25] toolTip:"활성화될 경우, 가이드 역활을 하는 Point Helper를 지웁니다." checked:true
checkBox rootOrigin "Root to origin" pos:[210,45] tooltip:"Root Bone을 무조건 원점에서 생성 합니다." checked:true
checkbox matchStart "Match in Start" pos:[210,65] toolTip:"시작 frame에서 Root을 맞춥니다.\n이 옵션을 끄면, 자동으로 마지막 프레임으로 이동합니다." checked:true visible:true

--groupBox group1 " Pinning Option " pos:[5,70] width:150 height:35
--radiobuttons pinningOpt labels:#("no","X","Y","X/Y") align:#left pos:[15,85] tooltip:"루트모션을 고정시키는 옵션입니다.\n축을 추출한 경우, 사용할 수 없습니다.\n( Z축은 옵션 없음 )"

dropdownlist bipComList "Biped COM : " items:bipNames pos:[10,75] tooltip:"Root본을 설치할 Biped를 선택합니다."
button BC_rootBoneCreator_createRootBoneBtn "Create Root Bone" width: 300 height:40 pos:[5,120] toolTip:"Root Bone을 만듭니다."
button reviseBipRotBtn "Revise Biped Rotation" width: 300 height:40 pos:[5,170] toolTip:"Root bone의 회전을 수동으로 제작한 경우에 실행하면, Biped 회전을 보정합니다."
button removeRootMotion "Remove Root Motion" width: 300 height:40 pos:[5,220] tooltip:"Root모션을 제거합니다.\nRoot 본도 같이 제거됩니다. "


on xChkB changed state do
(
if state do pinX.state = not state
if state do pinY.state = not state
)

on yChkB changed state do
(
if state do pinX.state = not state
if state do pinY.state = not state
)

on pinX changed state do
(
if state do xChkB.state = not state
if state do yChkB.state = not state
)

on pinY changed state do
(
if state do xChkB.state = not state
if state do yChkB.state = not state
)

on matchStart changed state do
(
if state then
(
slidertime = animationRange.start
matchStart.toolTip = "시작 frame에서 Root을 맞춥니다.\n이 옵션을 끄면, 자동으로 마지막 프레임으로 이동합니다."
)
else
(
slidertime = animationRange.end
matchStart.toolTip = "현재 슬라이더가 위치한 frame에서 Root을 맞춥니다."
)
)

on BC_rootBoneCreator_createRootBoneBtn pressed do
( 
undo on
( 
local bipCOM
local bipHeight
local rootBone
local trjParent 
local trjPoint
local trjOrient 

-------------------------------------------------------------------------------
-- get biped root : Biped COM을 가져옴
------------------------------------------------------------------------------- 
if bipComList.selected !=undefined then bipCOM = getNodeByName (bipComList.selected)
else bipCOM = undefined


-------------------------------------------------------------------------------
-- Biped COM이 있을 경우, 본격적인 Root Bone 설치 시작
------------------------------------------------------------------------------- 
if bipCOM != undefined then 
( 
disablesceneredraw() 

if isValidNode $Root_Sub do delete $Root_Sub --기존에 사용하던 Root_Sub가 있으면 삭제한다.
if isValidNode $Root do delete $Root --기존에 사용하던 Root가 있으면 삭제한다.
-------------------------------------------------------------------------------
-- 기존에 RootMotionLayer가 Biped에 있을 경우, 삭제
------------------------------------------------------------------------------- 
for i=0 to  biped.numLayers bipCOM.controller do
(
local bipLayerName = biped.getLayerName bipCOM.controller i
if bipLayerName == "RootMotionLayer" do
(
biped.deleteLayer bipCOM.controller i
exit
)
)

--------------------------------------------------------------------------------------------
-- FigureMode 해제
-- 
-- *FigureMode가 true이면, 아래 inPlaceMode 해제 시도시에 에러 발생
-- *FigureMode가 true인 상태에서 Biped를 원점으로 보내는 등의 동작 자체가 위험함. (스킨포즈 훼손 우려)
-- *따라서 FigureMode를 꺼주고 Root Bone을 설치하도록 하고, FigureMode가 켜져 있다면 Root 설치 중지
--------------------------------------------------------------------------------------------
if bipCOM.controller.figureMode == true do
(
if queryBox "FigureMode가 켜져 있습니다.\nFigureMode를 해제하고 계속 진행하시겠습니까?" title:"Warining : Biped FigureMode detected!"do bipCOM.controller.figureMode = false 
)


if bipCOM.controller.figureMode == false do --figureMode가 False일때만 계속 진행
(
-------------------------------------------------------------------------------
-- inPlaceMode
------------------------------------------------------------------------------- 

local inplaceMode = bipCOM.controller.inPlaceMode --현재 inplaceMode 저장

bipCOM.controller.inPlaceMode=false --inPlaceMode를 비활성화

-------------------------------------------------------------------------------
-- Scene 정리 : 시작프레임 지정 / Biped 원점으로 보내기 / Motion 패널 활성화
------------------------------------------------------------------------------- 
setCommandPanelTaskMode mode:#motion --Motion패널 활성화

if matchStart.state do sliderTime = animationRange.start -- Time: Go to Start Frame
if bipOrigin.state do BC_rootBoneCreator_bipToOrigin bipCOM -- bipOrigin이 true일 경우, Biped를 원점으로 보냄 


-------------------------------------------------------------------------------
-- create rootBone
------------------------------------------------------------------------------- 

--callback 함수로 인해, 무한루프에 빠지게 되므로, Root Bone을 만들기 전에 callback 함수를 임시로 제거한다.
--callbacks.removeScripts #selectedNodesPostDelete id:#BC_rootBoneCreator_deleteNode
---callbacks.removeScripts #nodeRenamed id:#BC_rootBoneCreator_renameNode

if isValidNode (getNodeByName rootBoneName) do delete (getNodeByName rootBoneName) 
rootBone = BC_rootBoneCreator_createRootBone rootBoneName

--callback 함수 복구
---callbacks.addScript #selectedNodesPostDelete "BC_rootBoneCreator_refreshNodesList classInfo warning:fbxAnimationExporter_rollout.BC_warning.state" id:#BC_rootBoneCreator_deleteNode
---callbacks.addScript #nodeRenamed "BC_rootBoneCreator_refreshNodesList classInfo warning:fbxAnimationExporter_rollout.BC_warning.state" id:#BC_rootBoneCreator_renameNode

bipHeight = bipCOM.controller.horizontal.controller.value[4].z --시작 위치에서의 Biped 높이값 설정


-------------------------------------------------------------------------------
-- create Guide Dummies
------------------------------------------------------------------------------- 
local trjPointXOpt = xChkB.state or pinX.state
local trjPointYOpt = yChkB.state or pinY.state

trjParent = BC_rootBoneCreator_createTrjParent (bipCOM) --Trajectory Parent를 만듭니다.
trjPoint = BC_rootBoneCreator_createTrjPoint trjParent (trjPointXOpt) (trjPointYOpt) zChkB.state -- Trajectory Point를 만듭니다.
trjOrient = BC_rootBoneCreator_createTrjOrient (bipCOM) (trjParent) -- Trajectory Orient를 만듭니다.

-------------------------------------------------------------------------------
-- create rootBone Position Animation
------------------------------------------------------------------------------- 
if xChkB.state==off and yChkB.state==off and zChkB.state==off and pinX.state==off and pinY.state==off then
(
rootBone.pos = trjPoint.pos --이동 관련 XYZ가 모두 꺼져 있을 경우, 위치를 맞춰주기만 합니다. 
)
else
(
rootBone.pos.controller = Position_Constraint () --Position Constraint 적용 
rootBone.pos.controller.appendTarget trjPoint 100.0  --RootBone이 Trajectory Point를 따라가도록 합니다.

BC_rootBoneCreator_collaseTRJ rootBone --RootBone 모션을 Baking합니다.
)

if zChkB.state == true do --Z축 이동을 추출하고자 할 경우, 원점보다는 아래로 내려가지 않도록 설정합니다.
(
rootBone.pos.controller.Z_Position.controller = float_limit ()
rootBone.pos.controller.Z_Position.controller.upper_limit_enabled = off
rootBone.pos.controller.Z_Position.controller.lower_limit = 0
)

if rChkB.state == false do --회전값 키 제거
(
rootBone.rotation.controller = Orientation_Constraint ()
rootBone.rotation.controller = Euler_XYZ ()
)

-------------------------------------------------------------------------------
-- create rootBone Orient Animation
------------------------------------------------------------------------------- 
if rChkB.state == true do
(
rootBone.rotation.controller = Orientation_Constraint () --Orient Constraint 적용
rootBone.rotation.controller.appendTarget trjOrient  100.0 --RootBone이 Trajectory Orient를 따라 회전하도록 합니다.

BC_rootBoneCreator_collaseTRJ rootBone
/*if animButtonState ==true then
(
animButtonState = off
pivot_motion.rotation = quat 0 0 -0.707107 0.707107
animButtonState = on
)else pivot_motion.rotation = quat 0 0 -0.707107 0.707107*/
) 

----------------------------------------------------------------------------
-- create biped layer
----------------------------------------------------------------------------
local bipOriginalPos = bipCOM.transform --바이패드의 원래 위치를 저장

if xChkB.state or yChkB.state or zChkB.state or rChkB.state or pinX.state or pinY.state do
( 

local rootMotionLayerId = biped.numLayers bipCOM.controller + 1
   
biped.createLayer bipCOM.controller rootMotionLayerId "RootMotionLayer"
   
biped.setCurrentLayer bipCOM.controller rootMotionLayerId
   
clearSelection()
   
select bipCOM
   
local horzController = bipCOM.controller.horizontal.controller
local vertController = bipCOM.controller.vertical.controller
local turnController = bipCOM.controller.turning.controller
   
for t = animationRange.start to animationRange.end do
(
if xChkB.state or yChkB.state do biped.addNewKey horzController t
if zChkB.state do biped.addNewKey vertController t
biped.addNewKey turnController t
)
   
animate on
(
for t = animationRange.start to animationRange.end do
(   
at time t
(               
local newPos = horzController.value[ 4 ]
   
if xChkB.state or pinX.state do newPos.x =  0

if yChkB.state or pinY.state do newPos.y =  0 
   
if zChkB.state do
(
newPos.z= amin bipHeight newPos.z 
)
   
biped.setTransform bipCOM #pos newPos false
) --at time End
) -- for End
) --animate on End
)


----------------------------------------------------------------------------
-- Set rootBone as root
----------------------------------------------------------------------------
bipCOM.parent = rootBone


----------------------------------------------------------------------------
-- Revise RootMotionLayer Rotation
----------------------------------------------------------------------------
if rChkB.state do BC_rootBoneCreator_adjustBipLayerRotate bipCOM rootBone

-------------------------------------------------------------------------------
-- Remove Guide Helpers
------------------------------------------------------------------------------- 
if delTrj.state == true do --Delete Guides 체크가 켜져 있을 경우, 오브젝트 이름을 근거로 GuideHelper 삭제
(
delete $trajectoryPoint
delete $trajectoryParent
delete $trajectoryOrient
)

----------------------------------------------------------------------------
-- create biped layer for Bip send to Origin Check off
----------------------------------------------------------------------------
if bipOrigin.state == false do
( 

local mergeLayerId = biped.numLayers bipCOM.controller + 1    
biped.createLayer bipCOM.controller mergeLayerId "MergeToRootMotionLayer"
biped.setCurrentLayer bipCOM.controller mergeLayerId 

animate on  bipCOM.transform = bipOriginalPos 
biped.collapseAtLayer bipCOM.controller (mergeLayerId-1)
)


----------------------------------------------------------------------------
-- Root to Origin Check on
----------------------------------------------------------------------------
if rootOrigin.state do
(
sliderTime = animationRange.start
bipCOM.parent = undefined

local origianlAnimMode = animButtonState
if animButtonState do max Tool animMode

rootBone.transform = matrix3 1
if origianlAnimMode do max Tool animMode

if isValidNode $Base then
(
$Base.parent = rootBone
animate off
(
$Base.transform = $root.transform
)
bipCOM.parent = $Base

)
else bipCOM.parent = rootBone

if isValidNode $ik_foot_root do $ik_foot_root.parent = rootBone
if isValidNode $ik_hand_root do $ik_hand_root.parent = rootBone


-----------------------------------------------------------------------------------------------------------
-- Pinning 옵션 적용
-----------------------------------------------------------------------------------------------------------
selectKeys rootBone.pos.controller (interval (animationRange.start-1) animationRange.end)

if pinX.state == true do
(
deleteKeys rootBone.pos.controller[1] #allKeys 
)

if pinY.state do
(
deleteKeys rootBone.pos.controller[2] #allKeys
)

deselectKeys rootBone.pos.controller animationRange
)
)

enablesceneredraw()
max views redraw
)else messagebox "Root Bone을 설치할 Biped가 없습니다" title:"Error" 
) -- undo End/
) --BC_rootBoneCreator_createRootBoneBtn End

on reviseBipRotBtn pressed do
(
undo on
(
local RootMotionLayerID = 0
local bipCOM
local rootBone = getNodeByName "Root"

if bipComList.selected !=undefined then bipCOM = getNodeByName (bipComList.selected)
else bipCOM = undefined 

if bipCOM != undefined then
(
if rootBone != undefined then
(
for i=0 to  biped.numLayers bipCOM.controller do
(
local bipLayerName = biped.getLayerName bipCOM.controller i
if bipLayerName == "RootMotionLayer" do
(
RootMotionLayerID = i
exit
) 
) 

if RootMotionLayerID !=0 then
(
disablesceneredraw() 

biped.setCurrentLayer bipCOM.controller RootMotionLayerID
BC_rootBoneCreator_adjustBipLayerRotate bipCOM rootBone

enablesceneredraw()
max views redraw
)else messagebox "Biped의 레이어( RootMotionLayer )가 없습니다." title:"Error"
)else messageBox "Root Bone이 없습니다." title:"Error"
)else messagebox (bipComList.selected+"가 Scene안에 없습니다.") title:"Error"
) -- undo End
) --reviseBipRotBtn End

on removeRootMotion pressed do
(
-------------------------------------------------------------------------------
-- get biped root : Biped COM을 가져옴
------------------------------------------------------------------------------- 
if bipComList.selected !=undefined then bipCOM = getNodeByName (bipComList.selected)
else bipCOM = undefined


if bipCOM != undefined do
(
if isValidNode $Root do delete $Root
-------------------------------------------------------------------------------
-- 기존에 RootMotionLayer가 Biped에 있을 경우, 삭제
------------------------------------------------------------------------------- 
for i=0 to  biped.numLayers bipCOM.controller do
(
local bipLayerName = biped.getLayerName bipCOM.controller i
if bipLayerName == "RootMotionLayer" do
(
biped.deleteLayer bipCOM.controller i
exit
)
)
)
)--removeRootMotion end
)



/*================================================================================================


fbx Animation Exporter 


==================================================================================================*/ /*

/*---------------------------------------------------------------------------------------------------
Library 호출  :  
library_dictionary
<struct> dictionary (2개의 맴버변수/다수 매소드 포함)

library_fbxExport
<fn> fbxExport_exec <prameter : string>exportType <prameter : string>exportFileName <prameter : nodeArray>selObjs

library_getNode
<fn> fn_getExportNodesFromScene <parameter : bool> withMesh:false
<fn> getSkinObjs

library_removeUnusedBoneFromSkin
<fn> fn_removeUnusedSkinbone <parameter : node_array>
---------------------------------------------------------------------------------------------------*//*
Include "$userScripts/library/library_dictionary.ms"
Include "$userScripts/library/library_fbxExport.ms"
Include "$userScripts/library/library_getNode.ms"
Include "$userScripts/library/library_removeUnusedBoneFromSkin.ms"


/*---------------------------------------------------------------------------------------------------------
initializeStruct : dictionary 구조체를 INI파일을 기초로 초기화 하는 함수

[매개변수]
inifile : 구조체를 초기화 시킬 INI 파일명 (경로명 포함)
dict : 초기화 시킬 dictionary 구조체

---------------------------------------------------------------------------------------------------------*//*
fn initializeDict inifile dict =
(
dict.del()
local classes = filterstring (getIniSetting inifile "Classes" "ClassNames") ";"
for c in classes do
(
dict.addKey c
local values = filterstring (getIniSetting inifile "Classes" c) ";"
dict.editVal c values
) 
)


/*------------------------------------------------------------------------------------------
 MaxFile 이름을 반환하는 함수
성공시 : 확장자를 제외한 파일명을 반환
실패시 : (파일이 저장되지 않았을 경우) 공백문자  반환

ex) 파일명 : AAA.max -> 반환값 : AAA     
------------------------------------------------------------------------------------------*/ /*
fn getMaxFileName =
(
local result = maxFileName 
if result != "" do
(
local fileName = filterString result "."
result = fileName[1]
)
return result
)



/*---------------------------------------------------------------------------------------------------------
splitMissingNodes : 주어진 문자열 배열을, Scene에 있는 것과 없는 것으로 구분해주는 함수

[매개변수]
nodeArray : 노드 이름을 갖고 있는 1차원 배열

[반환값]
2차원 배열 : #(scene안에 있는 노드 이름 배열, scene안에 없는 노드 이름 배열)
---------------------------------------------------------------------------------------------------------*//*
fn splitMissingNodes key nodeArray =
(
local exists = #()
local missing =#()

for n in nodeArray do
(
if (getNodeByName n) != undefined then append exists n
else append missing n
)
if missing.count !=0 do
(
format"\n---------------------- Missing Node : % -----------------------------------------------\n" key
for i in missing do format "%\n" i
format"-----------------------------------------------------------------------------------\n"
)
return #(exists,missing)
)

/*------------------------------------------------------------------------------------------------------------
BC_rootBoneCreator_overlapNodeName : 주어진 노드 이름 배열을 토대로 Scene안에 중복된 노드를 반환하는 함수

[매개변수]
itemArray : 노드 이름을 갖고 있는 배열 

[반환값]
1차원 배열 : Scene 안에서 이름이 중복된 노드 배열

*반환값이 빈 배열이 아닐 경우, Log를 남김
------------------------------------------------------------------------------------------------------------*//*
fn BC_rootBoneCreator_overlapNodeName  key itemArray =
(
local allObjs = $* as array 

local allName=for obj in allobjs collect obj.name
local keywords=makeuniquearray allName

if keywords.count != allName.count then
(
temp=deepcopy allName

for keyword in keywords do
( 
adress=findItem temp keyword
deleteItem temp adress
)
keywords=deepcopy temp
)else keywords = #()

keywords = makeuniquearray keywords
keywords=sort keywords

local result = #() --반환값 선언 

 for item in itemArray do
 (
for keyword in keywords do if item == keyword do append result keyword
 )  
 
if result.count > 0 do
( 
local overlapNames = ""

for r in result do overlapNames += (r+"\n")

format "\n-------------------Overlap Names : % -------------------------------------------------\n" key
format "%" overlapNames
format "----------------------------------------------------------------------------------\n" 
)
return result
) 


/*----------------------------------------------------------------------------------------
BC_rootBoneCreator_stringArrayToNodeArray : 문자열 배열을 노드배열로 바꾸어주는 함수

[매개변수]
<array> stringArray

[반환값]
<nodeArray> result
----------------------------------------------------------------------------------------*//*
fn BC_rootBoneCreator_stringArrayToNodeArray stringArray =
(
local result = for s in stringArray collect getNodeByName s
return result
)


/*----------------------------------------------------------------------------------------------------
rootBoneCreator_Refresh4fileOpen : 파일을 열었을 때, UI를 갱신시켜주는 함수.
----------------------------------------------------------------------------------------------------*/ /* 
fn rootBoneCreator_Refresh4fileOpen =
(
local bipNames = BC_rootBoneCreator_nodeArrayToStringArray(BC_rootBoneCreator_getBipComs())
BC_RootBoneCreator_rollout.bipComList.items = bipNames
BC_rootBoneCreator_refreshNodesList classInfo warning:fbxAnimationExporter_rollout.BC_warning.state
)



/*----------------------------------------------------------------------------------------------------
rootBoneCreator_closeRolloutFloater : UI를 닫아주는 함수.

[매개변수]
<string> RF : 닫아줄 RolloutFloater 이름
----------------------------------------------------------------------------------------------------*/ /*
fn rootBoneCreator_closeRolloutFloater RF =
(
closeRolloutFloater RF
RF = undefined
)



/*---------------------------------------------------------------------------------------------------------
BC_rootBoneCreator_refreshNodesList : Node List를 갱신해 주는 함수. 오브젝트가 삭제되거나  이름이 변경 되는 경우 작동.
[매개변수]
<struct:dictionary> classInfo : 캐릭터 클래스 정보를 담고 있는 dictionary형 구조체
<bool> warning : 경고메세지를 보여줄지 안보여줄지를 결정하는 매개변수. 기본값은 false
---------------------------------------------------------------------------------------------------------*//*
fn BC_rootBoneCreator_refreshNodesList classInfo warning:false =
( 
fbxAnimationExporter_rollout.BC_export_Btn.enabled = true 

local sel = fbxAnimationExporter_rollout.charClass.selection

local className = fbxAnimationExporter_rollout.charClass.items[fbxAnimationExporter_rollout.charClass.selection] 

local nodeList = splitMissingNodes className (classInfo.get className)
fbxAnimationExporter_rollout.BC_exportNodes_mListBox.items = nodeList[1]
fbxAnimationExporter_rollout.missingNodes_mListBox.items = nodeList[2]


if nodeList[2].count !=0 do
(
if warning==true do messageBox "Scene안에 없는 Node가 있습니다.\nMissing Nodes를 확인하세요" title:"Error : Missing nodes detected" 
fbxAnimationExporter_rollout.BC_export_Btn.enabled = false
)

local overlaps = BC_rootBoneCreator_overlapNodeName className fbxAnimationExporter_rollout.BC_exportNodes_mListBox.items

if overlaps.count !=0 do
(
fbxAnimationExporter_rollout.BC_export_Btn.enabled = false
messagebox "이름이 중복된 노드가 있는 것 같습니다.\n[ F11 ]을 눌러 log를 확인하세요." title:"Error : Name overlaped node detected"
)

if BC_fbxExportedFilePath !=undefined do fbxAnimationExporter_rollout.BC_outputPath.text = BC_fbxExportedFilePath
)


----------------------------------------------------------------------------------------------------------
-- ini 파일 변수화
-- 구조체 생성
---------------------------------------------------------------------------------------------------------- 
global iniFile = systemTools.getEnvVariable "AnimationTeamData"+"\\Script\\iniSettingFiles\\animCharClassNodeInfo.ini" --Animation Class 정보가 담긴 ini파일을 변수에 담는다.
global classInfo = dictionary()


----------------------------------------------------------------------------------------------------------
-- INI 파일 존재여부 체크 (없을 경우, 강재로 만든다)
----------------------------------------------------------------------------------------------------------
if (doesFileExist INIfile) != true do setINISetting INIfile "Classes" "ClassNames" "" 


----------------------------------------------------------------------------------------------------------
-- 구조체 초기화
----------------------------------------------------------------------------------------------------------
initializeDict iniFile classInfo

/*local currentSceneBone = fn_getExportNodesFromScene()
local currentSceneBoneName = #()
if currentSceneBone[1]!=false do currentSceneBoneName = for i in currentSceneBone collect i.name*/
--insertItem #("General Type(mob)",#()) classInfo.data 1

/*
rollout fbxAnimationExporter_rollout ("Single FBX Export ")
( 
dropdownlist BC_exportType "Export to :" items:#("skeletal mesh", "animation") selection:2
dropdownlist charClass "Character Class :" items:(classInfo.keys()) 
MultiListBox missingNodes_mListBox "Missing Nodes :" items:#()  height:5
label txt1 ""


editText BC_outputPath "Output" width:250
button BC_outputPathBrowse "..." width:30  pos:[267,205]


button BC_export_Btn "Export"  width:280 height:50 enabled:false

MultiListBox BC_exportNodes_mListBox items:(classInfo.data[1][2]) visible:false

checkbox BC_warning "Warning" pos:[245,95] 

--button BC_charClassEdit_btn "Edit" width:40 tooltip:"Character Classs Node 정보를 추가/수정하고자 할 때 사용합니다." pos:[245,23]


on BC_outputPath entered txt do
(
BC_export_Btn.enabled = true

if (doesFileExist txt)!=true do BC_export_Btn.enabled = false
if missingNodes_mListBox.items.count > 0 do BC_export_Btn.enabled = false
)

on BC_outputPathBrowse pressed do
(
BC_export_Btn.enabled = true

local txt = getSavePath "Set Output Path"
if txt != undefined then BC_outputPath.text = txt
else BC_outputPath.text = ""

if (doesFileExist BC_outputPath.text)!=true do BC_export_Btn.enabled = false
if missingNodes_mListBox.items.count > 0 do BC_export_Btn.enabled = false
)

on charClass selected var do
(
BC_export_Btn.enabled = true
local className = charClass.selected 

if (doesFileExist BC_outputPath.text)!=true do BC_export_Btn.enabled = false

BC_exportNodes_mListBox.items = classInfo.get className

local existObjCHK = splitMissingNodes className (classInfo.get className)

if existObjCHK[2].count != 0 then
(
BC_export_Btn.enabled = false
missingNodes_mListBox.items = existObjCHK[2]
if fbxAnimationExporter_rollout.BC_warning.state do messageBox "Scene안에 없는 노드가 있는 것 같습니다.\n[ F11 ]키를 눌러 Log를 확인해 보시기 바랍니다." title:className 
)else missingNodes_mListBox.items =#()

local onn = BC_rootBoneCreator_overlapNodeName className fbxAnimationExporter_rollout.BC_exportNodes_mListBox.items
if onn.count >0 do
(
if fbxAnimationExporter_rollout.BC_warning.state do messagebox "이름이 중복된 노드가 있는 것 같습니다.\n[ F11 ]을 눌러 log를 확인하세요." title:"Error : Name overlaped node detected"
BC_export_Btn.enabled = false
)

)

on BC_export_Btn pressed do
(
-- Class Name이 "General Type(mob)"인 경우, 스킨에서 사용하지 않는 Bone제거/Scene안에서 Export할 노드 선택----------------------
local className = charClass.selected
local exportSuccess = true
local skinObjs = getSkinObjs()

if className == "General Type(mob)" do
( 
fn_removeUnusedSkinbone skinObjs

local currentSceneBone = fn_getExportNodesFromScene()
if currentSceneBone[1]!=false then
(
local currentSceneBoneName = #()

currentSceneBoneName = for i in currentSceneBone collect i.name
classInfo.editVal "General Type(mob)" currentSceneBoneName
BC_exportNodes_mListBox.items = currentSceneBoneName
)
else
(
messagebox currentSceneBone[2] title:"Export Failed!"
exportSuccess = false
) 
) 

if exportSuccess !=false then
(
local exportType = BC_exportType.selected
local exportFileName = getMaxFileName()

local filteredName = (filterString exportFileName "_")

if filteredName[filteredName.count] == "Skin" or filteredName[filteredName.count]=="skin" do
(
exportFileName =""
for i=1 to filteredName.count-1 do
(
exportFileName += filteredName[i]
if i<filteredName.count-1 do exportFileName += "_"
)
) 
exportFileName = BC_outputPath.text+"\\"+exportFileName+".fbx"

if (doesFileExist BC_outputPath.text) == true then
(
local objs = BC_rootBoneCreator_stringArrayToNodeArray (BC_exportNodes_mListBox.items)

if isValidNode ($'Bip01 HeadNub') then append objs $'Bip01 HeadNub'
else if isValidNode ($'Bip01-HeadNub') then append objs $'Bip01-HeadNub'
else
(
if isValidNode ($'Bip02 HeadNub') then append objs $'Bip02 HeadNub'
else if isValidNode ($BN_Head) == false do messagebox "HeadNub/BN_Head가 모두 없습니다.\nEffect 연출시, Min/Max 적용에 문제가 있을 수 있습니다." title:"Waning!"
)
------------------Hit소켓의 어태치를 위해 BN_Weapon_R 추가로 배열에 담음-------------------- 
--  if isValidNode ($'BN_Weapon_R') then 
--  (
--  append objs $'BN_Weapon_R'
--  if($'BN_Weapon_R'.children != 0) do
--  (
--  for i in $'BN_Weapon_R'.children do append objs i
--  )
--  )
--  ------------------Hit소켓의 어태치를 위해 BN_Weapon_L 추가로 배열에 담음-------------------- 
--  if isValidNode ($'BN_Weapon_L') then 
--  (
--  append objs $'BN_Weapon_L'
--  if($'BN_Weapon_L'.children != 0) do
--  (
--  for i in $'BN_Weapon_L'.children do append objs i
--  )
--  )
--안전성이 낮고 따로 메서드 제작을 완료하였으므로 롤백합니다.
-----------------------------------Edit by TA/장민호---------------------------------
if exportType=="skeletal mesh" do objs+=skinObjs 

select objs
fbxExport_exec exportType exportFileName objs
messagebox (exportType+" :\n"+exportFileName) title:("FBX Exported!") beep:"false"

persistent global BC_fbxExportedFilePath = BC_outputPath.text
)
else messagebox ("Export Path가 존재하지 않습니다.\n"+BC_outputPath.text) title:"Export failed!"
)
)

on fbxAnimationExporter_rollout close do
(
callbacks.removeScripts #nodeRenamed id:#BC_rootBoneCreator_renameNode
callbacks.removeScripts #selectedNodesPostDelete id:#BC_rootBoneCreator_deleteNode
callbacks.removeScripts #filePostOpen id:#BC_rootBoneCreator_fileOpen
callbacks.removeScripts #systemPostNew id:#BC_rootBoneCreator_newScene
)
) 





global BC_RootBoneCreator_RF
if BC_RootBoneCreator_RF != undefined do
(
closeRolloutFloater BC_RootBoneCreator_RF
BC_RootBoneCreator_RF = undefined
)

callbacks.addScript #nodeRenamed "BC_rootBoneCreator_refreshNodesList classInfo warning:fbxAnimationExporter_rollout.BC_warning.state" id:#BC_rootBoneCreator_renameNode
callbacks.addScript #selectedNodesPostDelete "BC_rootBoneCreator_refreshNodesList classInfo warning:fbxAnimationExporter_rollout.BC_warning.state" id:#BC_rootBoneCreator_deleteNode
callbacks.addScript #filePostOpen "rootBoneCreator_Refresh4fileOpen()" id:#BC_rootBoneCreator_fileOpen
callbacks.addScript #systemPostNew "rootBoneCreator_closeRolloutFloater(BC_RootBoneCreator_RF)" id:#BC_rootBoneCreator_newScene

*/

BC_RootBoneCreator_RF = newrolloutfloater ("Root Bone Creator "+ver) 330 320
addrollout BC_RootBoneCreator_rollout BC_RootBoneCreator_RF 
--addrollout fbxAnimationExporter_rollout BC_RootBoneCreator_RF rolledUp:true

--BC_rootBoneCreator_refreshNodesList classInfo warning:fbxAnimationExporter_rollout.BC_warning.state

)