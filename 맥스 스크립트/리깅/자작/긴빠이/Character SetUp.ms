try(DestroyDialog Character_SetUp) catch()

rollout Character_SetUp "Chraracter SetUp"
(
	groupbox Body_SetUp "Body Setting" pos:[10,10] width:180 height:300
	
	DropdownList BipRootNode pos:[70,30] width:100
	
	checkbox chk1 "Neck" pos:[20,30]
	checkbox chk2 "UpperArm Twist  /  Deltoid" pos:[20,60]
	checkbox chk3 "Elbow" pos:[20,90]
	checkbox chk4 "Wrist Twist" pos:[20,120]
	checkbox chk5 "Thigh Twist  /  Hip" pos:[20,150]
	checkbox chk6 "Knee" pos:[20,180]
	
	button Btn_Setup "Setup" pos:[20,200] width:160 height:40
	
	label lab1 "Red color bone is joint." pos:[45,250]
	label lab2 "Yellow color bone is twist."
	label Copyright "Created by Shin Jin Ho"
	
	on Character_SetUp open do
		(
			BipObjSort = #()
			BipObjList = #()
			
			for o in objects do
				(
					if (classof o) == Biped_Object do (AppendIfUnique BipObjSort o)
					for i = 1 to BipObjSort.count do
					(
						if (classof BipObjSort[i].controller.RootNode) == Biped_Object do (AppendIfUnique BipObjList BipObjSort[i].controller.RootNode)
					)
				)
			
			if BipObjList.count > 0  do
				(
					BipRootNode.items = for i in BipObjList collect i.controller.RootName
				)
		)
	
	on Btn_Setup pressed do
		(
			BaseName = BipRootNode.selected
			
			undo on
			(
				if BipRootNode.items.count != 0 then
				(
					if chk1.checked == true do
						(
							neckpos = (execute ("$'" + BaseName + " Neck'")).transform.pos
							headpos = (execute ("$'" + BaseName + " Head'")).transform.pos
							
							BoneNeck_Cre = BoneSys.CreateBone neckpos headpos headpos
							BoneNeck_Cre.wirecolor = color 250 220 0
							BoneNeck_Cre.width = 2
							BoneNeck_Cre.height = 2
							BoneNeck_Cre.taper = 90
							BoneNeck_Cre.controller.rotation = (execute ("$'" + BaseName + " Neck'")).transform.rotation
							BoneNeck_Cre.Name = BaseName + "_B_NeckTwist"
							BoneNeck_Cre.Parent = execute ("$'" + BaseName + " Neck'")
							
							PointNeck_Cre = point size:3 box:on cross:off Centermarker:off axistripod:off  wirecolor:green
							PointNeck_Cre.Name = BaseName + "_PH_NeckTwist"
							PointNeck_Cre.controller.rotation = (execute ("$'" + BaseName + " Neck'")).transform.rotation
							PointNeck_Cre.pos = (execute ("$'" + BaseName + " Neck'")).transform.pos
							PointNeck_Cre.parent = execute ("$'" + BaseName + " Neck'")
							
							BoneNeck_Cre.rotation.controller = LookAt_Constraint()
							BoneNeck_Cre.rotation.controller.appendtarget (execute ("$'" + BaseName + " Head'")) 50
							BoneNeck_Cre.rotation.controller.viewline_length_abs = off
							BoneNeck_Cre.rotation.controller.upnode_world = off
							BoneNeck_Cre.rotation.controller.pickUpnode = PointNeck_Cre
							
							PointNeck_Cre.rotation.controller = Orientation_Constraint()
							PointNeck_Cre.rotation.controller.appendtarget (execute ("$'" + BaseName + " Head'")) 50
							PointNeck_Cre.rotation.controller.appendtarget (execute ("$'" + BaseName + " Neck'")) 50
							PointNeck_Cre.rotation.controller.relative = on
						)
					
					if chk2.checked == true do
						(
							--Right
							PointClavicle = point size:3 box:off cross:off Centermarker:off axistripod:on  wirecolor:green
							PointClavicle.Name = BaseName + "_PH_R Clavicle"
							PointClavicle.controller.rotation = (execute ("$'" + BaseName + " R Clavicle'")).transform.rotation
							PointClavicle.pos = (execute ("$'" + BaseName + " R Clavicle'")).transform.pos
							PointClavicle.parent = execute ("$'" + BaseName + " R Clavicle'")
							
							PointUpperArm = point size:3 box:off cross:on Centermarker:off axistripod:off  wirecolor:green
							PointUpperArm.Name = BaseName + "_PH_R UpperArm"
							PointUpperArm.controller.rotation = (execute ("$'" + BaseName + " R UpperArm'")).transform.rotation
							PointUpperArm.pos = (execute ("$'" + BaseName + " R UpperArm'")).transform.pos
							PointUpperArm.parent = execute ("$'" + BaseName + " R UpperArm'")
							
							disAB = distance PointClavicle PointUpperArm
							
							in coordsys local PointUpperArm.pos = [disAb,0,0]
								
							PointClavicle.rotation.controller = LookAt_Constraint()
							PointClavicle.rotation.controller.appendtarget PointUpperArm 50
							PointClavicle.rotation.controller.viewline_length_abs = off
							PointClavicle.rotation.controller.upnode_world = off
							PointClavicle.rotation.controller.pickUpnode = execute ("$'" + BaseName + " R Clavicle'")
							
							UpperArmPos = (execute ("$'" + BaseName + " R UpperArm'")).transform.pos
							
							PointUpperArm_Twist = point size:3 box:on cross:off Centermarker:off axistripod:off  wirecolor:green
							PointUpperArm_Twist.Name = BaseName + "_PH_R UpperArm Twist"
							PointUpperArm_Twist.Parent = execute ("$'" + BaseName + " R UpperArm'")
							PointUpperArm_Twist.controller.rotation = (execute ("$'" + BaseName + " R UpperArm'")).transform.rotation
							PointUpperArm_Twist.pos = (UpperArmPos + PointUpperArm.Pos) / 2
							
							PointUpperArm_Twist.rotation.controller = LookAt_Constraint()
							PointUpperArm_Twist.rotation.controller.appendtarget (execute ("$'" + BaseName + " R ForeArm'")) 50
							PointUpperArm_Twist.rotation.controller.viewline_length_abs = off
							PointUpperArm_Twist.rotation.controller.upnode_world = off
							PointUpperArm_Twist.rotation.controller.pickUpnode = PointClavicle
							
							ForeArmPos = (execute ("$'" + BaseName + " R ForeArm'")).transform.pos
							endPos = (UpperArmPos + ForeArmPos) / 2
							
							BoneUpperTwist_R_Cre = BoneSys.CreateBone UpperArmPos endPos UpperArmPos
							BoneUpperTwist_R_Cre.wirecolor = color 250 220 0
							BoneUpperTwist_R_Cre.width = 2
							BoneUpperTwist_R_Cre.height = 2
							BoneUpperTwist_R_Cre.taper = 90
							BoneUpperTwist_R_Cre.FrontFin = on
							BoneUpperTwist_R_Cre.FrontFinsize = 1
							BoneUpperTwist_R_Cre.Name = BaseName + "_B_R UpperArm Twist"
							BoneUpperTwist_R_Cre.Parent = execute ("$'" + BaseName + " R UpperArm'")
							
							BoneUpperTwist_R_Cre.rotation.controller = Orientation_Constraint()
							BoneUpperTwist_R_Cre.rotation.controller.appendtarget (execute ("$'" + BaseName + " R UpperArm'")) 25
							BoneUpperTwist_R_Cre.rotation.controller.appendtarget PointUpperArm_Twist 75
							
							ClaviclePos = (execute ("$'" + BaseName + " R Clavicle'")).transform.pos
							
							BoneDeltoid_R_Cre = BoneSys.CreateBone UpperArmPos ((UpperArmPos + ClaviclePos) / 2) UpperArmPos
							BoneDeltoid_R_Cre.wirecolor = color 255 0 0
							BoneDeltoid_R_Cre.width = 2
							BoneDeltoid_R_Cre.height = 2
							BoneDeltoid_R_Cre.taper = 90
							BoneDeltoid_R_Cre.Name = BaseName + "_B_R Deltoid"
							BoneDeltoid_R_Cre.Parent = execute ("$'" + BaseName + " R Clavicle'")
							in coordsys local BoneDeltoid_R_Cre.rotation = (EulerAngles 0 140 0)
							in coordsys local BoneDeltoid_R_Cre.rotation = (EulerAngles 90 0 0)
							
							BoneDeltoid_R_Cre.rotation.controller = Orientation_Constraint()
							BoneDeltoid_R_Cre.rotation.controller.appendtarget PointClavicle 70
							BoneDeltoid_R_Cre.rotation.controller.appendtarget (execute ("$'" + BaseName + " R UpperArm'")) 30
							
							
							--Left
							PointClavicle = point size:3 box:off cross:off Centermarker:off axistripod:on  wirecolor:green
							PointClavicle.Name = BaseName + "_PH_L Clavicle"
							PointClavicle.controller.rotation = (execute ("$'" + BaseName + " L Clavicle'")).transform.rotation
							PointClavicle.pos = (execute ("$'" + BaseName + " L Clavicle'")).transform.pos
							PointClavicle.parent = execute ("$'" + BaseName + " L Clavicle'")
							
							PointUpperArm = point size:3 box:off cross:on Centermarker:off axistripod:off  wirecolor:green
							PointUpperArm.Name = BaseName + "_PH_L UpperArm"
							PointUpperArm.controller.rotation = (execute ("$'" + BaseName + " L UpperArm'")).transform.rotation
							PointUpperArm.pos = (execute ("$'" + BaseName + " L UpperArm'")).transform.pos
							PointUpperArm.parent = execute ("$'" + BaseName + " L UpperArm'")
							
							disAB = distance PointClavicle PointUpperArm
							
							in coordsys local PointUpperArm.pos = [disAb,0,0]
								
							PointClavicle.rotation.controller = LookAt_Constraint()
							PointClavicle.rotation.controller.appendtarget PointUpperArm 50
							PointClavicle.rotation.controller.viewline_length_abs = off
							PointClavicle.rotation.controller.upnode_world = off
							PointClavicle.rotation.controller.pickUpnode = execute ("$'" + BaseName + " L Clavicle'")
							
							UpperArmPos = (execute ("$'" + BaseName + " L UpperArm'")).transform.pos
							
							PointUpperArm_Twist = point size:3 box:on cross:off Centermarker:off axistripod:off  wirecolor:green
							PointUpperArm_Twist.Name = BaseName + "_PH_L UpperArm Twist"
							PointUpperArm_Twist.Parent = execute ("$'" + BaseName + " L UpperArm'")
							PointUpperArm_Twist.controller.rotation = (execute ("$'" + BaseName + " L UpperArm'")).transform.rotation
							PointUpperArm_Twist.pos = (UpperArmPos + PointUpperArm.Pos) / 2
							
							PointUpperArm_Twist.rotation.controller = LookAt_Constraint()
							PointUpperArm_Twist.rotation.controller.appendtarget (execute ("$'" + BaseName + " L ForeArm'")) 50
							PointUpperArm_Twist.rotation.controller.viewline_length_abs = off
							PointUpperArm_Twist.rotation.controller.upnode_world = off
							PointUpperArm_Twist.rotation.controller.pickUpnode = PointClavicle
							
							ForeArmPos = (execute ("$'" + BaseName + " L ForeArm'")).transform.pos
							endPos = (UpperArmPos + ForeArmPos) / 2
							
							BoneUpperTwist_L_Cre = BoneSys.CreateBone UpperArmPos endPos UpperArmPos
							BoneUpperTwist_L_Cre.wirecolor = color 250 220 0
							BoneUpperTwist_L_Cre.width = 2
							BoneUpperTwist_L_Cre.height = 2
							BoneUpperTwist_L_Cre.taper = 90
							BoneUpperTwist_L_Cre.FrontFin = on
							BoneUpperTwist_L_Cre.FrontFinsize = 1
							BoneUpperTwist_L_Cre.Name = BaseName + "_B_L UpperArm Twist"
							BoneUpperTwist_L_Cre.Parent = execute ("$'" + BaseName + " L UpperArm'")
							
							BoneUpperTwist_L_Cre.rotation.controller = Orientation_Constraint()
							BoneUpperTwist_L_Cre.rotation.controller.appendtarget (execute ("$'" + BaseName + " L UpperArm'")) 25
							BoneUpperTwist_L_Cre.rotation.controller.appendtarget PointUpperArm_Twist 75
							
							ClaviclePos = (execute ("$'" + BaseName + " L Clavicle'")).transform.pos
							
							BoneDeltoid_L_Cre = BoneSys.CreateBone UpperArmPos ((UpperArmPos + ClaviclePos) / 2) UpperArmPos
							BoneDeltoid_L_Cre.wirecolor = color 255 0 0
							BoneDeltoid_L_Cre.width = 2
							BoneDeltoid_L_Cre.height = 2
							BoneDeltoid_L_Cre.taper = 90
							BoneDeltoid_L_Cre.Name = BaseName + "_B_L Deltoid"
							BoneDeltoid_L_Cre.Parent = execute ("$'" + BaseName + " L Clavicle'")
							in coordsys local BoneDeltoid_L_Cre.rotation = (EulerAngles 0 140 0)
							in coordsys local BoneDeltoid_L_Cre.rotation = (EulerAngles 90 0 0)
							
							BoneDeltoid_L_Cre.rotation.controller = Orientation_Constraint()
							BoneDeltoid_L_Cre.rotation.controller.appendtarget PointClavicle 70
							BoneDeltoid_L_Cre.rotation.controller.appendtarget (execute ("$'" + BaseName + " L UpperArm'")) 30

						)
						
					if chk3.checked == true do
						(
							--Right
							ForeArmPos = (execute ("$'" + BaseName + " R ForeArm'")).transform.pos
							HandPos = (execute ("$'" + BaseName + " R Hand'")).transform.pos
							
							ExTmElbow_len = ExposeTm size:5
							ExTmElbow_len.transform = (execute ("$'" + BaseName + " R ForeArm'")).transform
							ExTmElbow_len.exposeNode = execute ("$'" + BaseName + " R ForeArm'")
							ExTmElbow_len.localReferenceNode = execute ("$'" + BaseName + " R Hand'")
							ExTmElbow_len.useParent = false
							Elbow_len = (ExTmElbow_len.Distance)/5
							in coordsys local ExTmElbow_len.pos = [Elbow_len,0,0]
							
							BoneElbow_R_Cre = BoneSys.CreateBone ForeArmPos ExTmElbow_len.pos HandPos
							BoneElbow_R_Cre.wirecolor = color 255 0 0
							BoneElbow_R_Cre.width = 2
							BoneElbow_R_Cre.height = 2
							BoneElbow_R_Cre.taper = 90
							BoneElbow_R_Cre.controller.rotation = (execute ("$'" + BaseName + " R ForeArm'")).transform.rotation
							BoneElbow_R_Cre.Name = BaseName + "_B_R Elbow"
							BoneElbow_R_Cre.Parent = execute ("$'" + BaseName + " R ForeArm'")
							in coordsys local BoneElbow_R_Cre.rotation = (EulerAngles 0 0 -90)
							
							BoneElbow_R_Cre.rotation.controller = Orientation_Constraint()
							BoneElbow_R_Cre.rotation.controller.appendtarget (execute ("$'" + BaseName + " R UpperArm'")) 50
							BoneElbow_R_Cre.rotation.controller.appendtarget (execute ("$'" + BaseName + " R ForeArm'")) 50
							BoneElbow_R_Cre.rotation.controller.relative = on
							
							delete ExTmElbow_len
							
							--Left
							
							ForeArmPos = (execute ("$'" + BaseName + " L ForeArm'")).transform.pos
							HandPos = (execute ("$'" + BaseName + " L Hand'")).transform.pos
							
							ExTmElbow_len = ExposeTm size:5
							ExTmElbow_len.transform = (execute ("$'" + BaseName + " L ForeArm'")).transform
							ExTmElbow_len.exposeNode = execute ("$'" + BaseName + " L ForeArm'")
							ExTmElbow_len.localReferenceNode = execute ("$'" + BaseName + " L Hand'")
							ExTmElbow_len.useParent = false
							Elbow_len = (ExTmElbow_len.Distance)/5
							in coordsys local ExTmElbow_len.pos = [Elbow_len,0,0]
							
							BoneElbow_L_Cre = BoneSys.CreateBone ForeArmPos ExTmElbow_len.pos HandPos
							BoneElbow_L_Cre.wirecolor = color 255 0 0
							BoneElbow_L_Cre.width = 2
							BoneElbow_L_Cre.height = 2
							BoneElbow_L_Cre.taper = 90
							BoneElbow_L_Cre.controller.rotation = (execute ("$'" + BaseName + " L ForeArm'")).transform.rotation
							BoneElbow_L_Cre.Name = BaseName + "_B_L Elbow"
							BoneElbow_L_Cre.Parent = execute ("$'" + BaseName + " L ForeArm'")
							in coordsys local BoneElbow_L_Cre.rotation = (EulerAngles 0 0 -90)
							
							BoneElbow_L_Cre.rotation.controller = Orientation_Constraint()
							BoneElbow_L_Cre.rotation.controller.appendtarget (execute ("$'" + BaseName + " L UpperArm'")) 50
							BoneElbow_L_Cre.rotation.controller.appendtarget (execute ("$'" + BaseName + " L ForeArm'")) 50
							BoneElbow_L_Cre.rotation.controller.relative = on
							
							delete ExTmElbow_len
						)
					
					if chk4.checked == true do
						(
							--Right
							ForeArmPos = (execute ("$'" + BaseName + " R ForeArm'")).transform.pos
							HandPos = (execute ("$'" + BaseName + " R Hand'")).transform.pos
							
							ExTmWrist_len = ExposeTm size:5
							ExTmWrist_len.transform = (execute ("$'" + BaseName + " R ForeArm'")).transform
							ExTmWrist_len.exposeNode = (execute ("$'" + BaseName + " R ForeArm'"))
							ExTmWrist_len.localReferenceNode = execute ("$'" + BaseName + " R Hand'")
							ExTmWrist_len.useParent = false
							Wrist_len = (ExTmWrist_len.Distance)*2/3
							in coordsys local ExTmWrist_len.pos = [Wrist_len,0,0]
							
							ExTmFore_Hand = ExposeTm size:5
							ExTmFore_Hand.transform = (execute ("$'" + BaseName + " R ForeArm'")).transform
							ExTmFore_Hand.exposeNode = (execute ("$'" + BaseName + " R ForeArm'"))
							ExTmFore_Hand.localReferenceNode = execute ("$'" + BaseName + " R Hand'")
							ExTmFore_Hand.useParent = false
							Fore_Hand_Distance = ExTmFore_Hand.Distance
							
							PointWristTarget_R = point size:3 box:off cross:on Centermarker:off axistripod:off  wirecolor:green
							PointWristTarget_R.Name = BaseName + "_PH_R Wrist Target"
							PointWristTarget_R.transform = (execute ("$'" + BaseName + " R Hand'")).transform
							PointWristTarget_R.parent = execute ("$'" + BaseName + " R Hand'")
							in coordsys local PointWristTarget_R.pos = [Fore_Hand_Distance,0,0]
							
							PointWristTarget_R.rotation.controller = LookAt_Constraint()
							PointWristTarget_R.rotation.controller.appendtarget (execute ("$'" + BaseName + " R ForeArm'")) 50
							PointWristTarget_R.rotation.controller.viewline_length_abs = off
							PointWristTarget_R.rotation.controller.upnode_world = off
							PointWristTarget_R.rotation.controller.pickUpnode = execute ("$'" + BaseName + " R Hand'")
							
							BoneWrist_R_Cre = BoneSys.CreateBone ExTmWrist_len.pos HandPos HandPos
							BoneWrist_R_Cre.wirecolor = color 250 220 0
							BoneWrist_R_Cre.width = 2
							BoneWrist_R_Cre.height = 2
							BoneWrist_R_Cre.taper = 90
							BoneWrist_R_Cre.BackFin = on
							BoneWrist_R_Cre.BackFinsize = 1
							BoneWrist_R_Cre.Name = BaseName + "_B_R Wrist"
							BoneWrist_R_Cre.Parent = execute ("$'" + BaseName + " R ForeArm'")
							
							BoneWrist_R_Cre.rotation.controller = LookAt_Constraint()
							BoneWrist_R_Cre.rotation.controller.appendtarget (execute ("$'" + BaseName + " R Hand'")) 50
							BoneWrist_R_Cre.rotation.controller.viewline_length_abs = off
							BoneWrist_R_Cre.rotation.controller.upnode_world = off
							BoneWrist_R_Cre.rotation.controller.pickUpnode = PointWristTarget_R

							delete ExTmWrist_len
							delete ExTmFore_Hand
							
							
							--Left
							ForeArmPos = (execute ("$'" + BaseName + " L ForeArm'")).transform.pos
							HandPos = (execute ("$'" + BaseName + " L Hand'")).transform.pos
							
							ExTmWrist_len = ExposeTm size:5
							ExTmWrist_len.transform = (execute ("$'" + BaseName + " L ForeArm'")).transform
							ExTmWrist_len.exposeNode = execute ("$'" + BaseName + " L ForeArm'")
							ExTmWrist_len.localReferenceNode = execute ("$'" + BaseName + " L Hand'")
							ExTmWrist_len.useParent = false
							Wrist_len = (ExTmWrist_len.Distance)*2/3
							in coordsys local ExTmWrist_len.pos = [Wrist_len,0,0]
							
							ExTmFore_Hand = ExposeTm size:5
							ExTmFore_Hand.transform = (execute ("$'" + BaseName + " L ForeArm'")).transform
							ExTmFore_Hand.exposeNode = execute ("$'" + BaseName + " L ForeArm'")
							ExTmFore_Hand.localReferenceNode = execute ("$'" + BaseName + " L Hand'")
							ExTmFore_Hand.useParent = false
							Fore_Hand_Distance = ExTmFore_Hand.Distance
							
							PointWristTarget_L = point size:3 box:off cross:on Centermarker:off axistripod:off  wirecolor:green
							PointWristTarget_L.Name = BaseName + "_PH_L Wrist Target"
							PointWristTarget_L.transform = (execute ("$'" + BaseName + " L Hand'")).transform
							PointWristTarget_L.parent = execute ("$'" + BaseName + " L Hand'")
							in coordsys local PointWristTarget_L.pos = [Fore_Hand_Distance,0,0]
							
							PointWristTarget_L.rotation.controller = LookAt_Constraint()
							PointWristTarget_L.rotation.controller.appendtarget (execute ("$'" + BaseName + " L ForeArm'")) 50
							PointWristTarget_L.rotation.controller.viewline_length_abs = off
							PointWristTarget_L.rotation.controller.upnode_world = off
							PointWristTarget_L.rotation.controller.pickUpnode = execute ("$'" + BaseName + " L Hand'")
							
							BoneWrist_L_Cre = BoneSys.CreateBone ExTmWrist_len.pos HandPos HandPos
							BoneWrist_L_Cre.wirecolor = color 250 220 0
							BoneWrist_L_Cre.width = 2
							BoneWrist_L_Cre.height = 2
							BoneWrist_L_Cre.taper = 90
							BoneWrist_L_Cre.BackFin = on
							BoneWrist_L_Cre.BackFinsize = 1
							BoneWrist_L_Cre.Name = BaseName + "_B_L Wrist"
							BoneWrist_L_Cre.Parent = execute ("$'" + BaseName + " L ForeArm'")
							
							BoneWrist_L_Cre.rotation.controller = LookAt_Constraint()
							BoneWrist_L_Cre.rotation.controller.appendtarget (execute ("$'" + BaseName + " L Hand'")) 50
							BoneWrist_L_Cre.rotation.controller.viewline_length_abs = off
							BoneWrist_L_Cre.rotation.controller.upnode_world = off
							BoneWrist_L_Cre.rotation.controller.pickUpnode = PointWristTarget_L

							delete ExTmWrist_len
							delete ExTmFore_Hand
						)
						
					if chk5.checked == true do
						(
							--Right Thigh Twist
							ThighPos = (execute ("$'" + BaseName + " R Thigh'")).transform.pos
							CalfPos = (execute ("$'" + BaseName + " R Calf'")).transform.pos
							
							ExTmThigh_len = ExposeTm size:5
							ExTmThigh_len.transform = (execute ("$'" + BaseName + " R Thigh'")).transform
							ExTmThigh_len.exposeNode = execute ("$'" + BaseName + " R Thigh'")
							ExTmThigh_len.localReferenceNode = execute ("$'" + BaseName + " R Calf'")
							ExTmThigh_len.useParent = false
							Thigh_len = (ExTmThigh_len.Distance)/4
							
							PointThigh2_R = point size:3 box:on cross:off Centermarker:off axistripod:off  wirecolor:green
							PointThigh2_R.transform = (execute ("$'" + BaseName + " R Thigh'")).transform
							PointThigh2_R.Name = BaseName + "_PH_R Thigh02"
							PointThigh2_R.Parent = execute ("$'" + BaseName + " R Thigh'")
							in coordsys local PointThigh2_R.pos = [Thigh_len,0,0]

							PointThigh1_R = point size:3 box:off cross:off Centermarker:off axistripod:on  wirecolor:green
							PointThigh1_R.transform = (execute ("$'" + BaseName + " R Thigh'")).transform
							PointThigh1_R.Name = BaseName + "_PH_R Thigh01"
							PointThigh1_R.Parent = execute ("$'" + BaseName + " Pelvis'")
							in coordsys local PointThigh1_R.pos = [-Thigh_len,0,0]
							
							PointThigh1_R.rotation.controller = LookAt_Constraint()
							PointThigh1_R.rotation.controller.appendtarget PointThigh2_R 50
							PointThigh1_R.rotation.controller.viewline_length_abs = off
							PointThigh1_R.rotation.controller.upnode_world = off
							PointThigh1_R.rotation.controller.StoUP_axisFlip = on
							PointThigh1_R.rotation.controller.pickUpnode = execute ("$'" + BaseName + " Pelvis'")

							delete ExTmThigh_len
							
							PointThigh3_R = point size:3 box:off cross:on Centermarker:off axistripod:off  wirecolor:green
							PointThigh3_R.transform = (execute ("$'" + BaseName + " R Thigh'")).transform
							PointThigh3_R.Name = BaseName + "_PH_R Thigh03"
							PointThigh3_R.Parent = execute ("$'" + BaseName + " R Thigh'")
							
							PointThigh3_R.rotation.controller = LookAt_Constraint()
							PointThigh3_R.rotation.controller.appendtarget (execute ("$'" + BaseName + " R Calf'")) 50
							PointThigh3_R.rotation.controller.viewline_length_abs = off
							PointThigh3_R.rotation.controller.upnode_world = off
							PointThigh3_R.rotation.controller.pickUpnode = PointThigh1_R
							
							BoneThighTwist_R_Cre = BoneSys.CreateBone (execute ("$'" + BaseName + " R Thigh'")).transform.pos PointThigh2_R.pos PointThigh2_R.pos
							BoneThighTwist_R_Cre.wirecolor = color 250 220 0
							BoneThighTwist_R_Cre.width = 2
							BoneThighTwist_R_Cre.height = 2
							BoneThighTwist_R_Cre.taper = 90
							BoneThighTwist_R_Cre.FrontFin = on
							BoneThighTwist_R_Cre.FrontFinSize = 2
							BoneThighTwist_R_Cre.BackFin = on
							BoneThighTwist_R_Cre.BackFinSize = 1
							BoneThighTwist_R_Cre.Name = BaseName + "_B_R Thigh Twist"
							BoneThighTwist_R_Cre.Parent = execute ("$'" + BaseName + " R Thigh'")
							
							BoneThighTwist_R_Cre.rotation.controller = Orientation_Constraint()
							BoneThighTwist_R_Cre.rotation.controller.appendtarget (execute ("$'" + BaseName + " R Thigh'")) 25
							BoneThighTwist_R_Cre.rotation.controller.appendtarget PointThigh3_R 75
							
							
							--Right Hip
							PointPelvis = point size:3 box:on cross:off Centermarker:off axistripod:off  wirecolor:green
							PointPelvis.Name = BaseName + "_PH_Pelvis"
							PointPelvis.pos = (((execute ("$'" + BaseName + " Spine'")).transform.pos + (execute ("$'" + BaseName + " Pelvis'")).transform.pos) / 2)
							PointPelvis.Parent = execute ("$'" + BaseName + " Pelvis'")
							in coordsys local PointPelvis.rotation = (EulerAngles 0 90 0)
							in coordsys local PointPelvis.rotation = (EulerAngles 0 0 180)
							
							ExTmHip_len = ExposeTm size:5
							ExTmHip_len.transform = (execute ("$'" + BaseName + " R Thigh'")).transform
							ExTmHip_len.exposeNode = execute ("$'" + BaseName + " R Thigh'")
							ExTmHip_len.localReferenceNode = execute ("$'" + BaseName + " R Calf'")
							ExTmHip_len.useParent = false
							Hip_len = (ExTmHip_len.Distance)/4
							in coordsys local ExTmHip_len.pos = [Hip_len,0,0]
							
							BoneHip_R_Cre = BoneSys.CreateBone (execute ("$'" + BaseName + " R Thigh'")).transform.pos ExTmHip_len.pos ExTmHip_len.pos
							BoneHip_R_Cre.wirecolor = color 255 0 0
							BoneHip_R_Cre.width = 2
							BoneHip_R_Cre.height = 2
							BoneHip_R_Cre.taper = 90
							BoneHip_R_Cre.FrontFin = on
							BoneHip_R_Cre.FrontFinSize = 1
							BoneHip_R_Cre.BackFin = on
							BoneHip_R_Cre.BackFinSize = 2
							BoneHip_R_Cre.Name = BaseName + "_B_R Hip"
							BoneHip_R_Cre.controller.rotation = (execute ("$'" + BaseName + " R Thigh'")).transform.rotation
							BoneHip_R_Cre.Parent = execute ("$'" + BaseName + " R Thigh'")
							in coordsys local BoneHip_R_Cre.rotation = (EulerAngles 0 0 90)
							in coordsys local BoneHip_R_Cre.rotation = (EulerAngles 180 0 0)
							
							delete ExTmHip_len
							
							BoneHip_R_Cre.rotation.controller = Orientation_Constraint()
							BoneHip_R_Cre.rotation.controller.relative = on
							BoneHip_R_Cre.rotation.controller.appendtarget BoneThighTwist_R_Cre 30
							BoneHip_R_Cre.rotation.controller.appendtarget PointPelvis 70
							
							
							--Left Thigh Twist
							ThighPos = (execute ("$'" + BaseName + " L Thigh'")).transform.pos
							CalfPos = (execute ("$'" + BaseName + " L Calf'")).transform.pos
							
							ExTmThigh_len = ExposeTm size:5
							ExTmThigh_len.transform = (execute ("$'" + BaseName + " L Thigh'")).transform
							ExTmThigh_len.exposeNode = execute ("$'" + BaseName + " L Thigh'")
							ExTmThigh_len.localReferenceNode = execute ("$'" + BaseName + " L Calf'")
							ExTmThigh_len.useParent = false
							Thigh_len = (ExTmThigh_len.Distance)/4
							
							PointThigh2_L = point size:3 box:on cross:off Centermarker:off axistripod:off  wirecolor:green
							PointThigh2_L.transform = (execute ("$'" + BaseName + " L Thigh'")).transform
							PointThigh2_L.Name = BaseName + "_PH_L Thigh02"
							PointThigh2_L.Parent = execute ("$'" + BaseName + " L Thigh'")
							in coordsys local PointThigh2_L.pos = [Thigh_len,0,0]

							PointThigh1_L = point size:3 box:off cross:off Centermarker:off axistripod:on  wirecolor:green
							PointThigh1_L.transform = (execute ("$'" + BaseName + " L Thigh'")).transform
							PointThigh1_L.Name = BaseName + "_PH_L Thigh01"
							PointThigh1_L.Parent = execute ("$'" + BaseName + " Pelvis'")
							in coordsys local PointThigh1_L.pos = [-Thigh_len,0,0]
							
							PointThigh1_L.rotation.controller = LookAt_Constraint()
							PointThigh1_L.rotation.controller.appendtarget PointThigh2_L 50
							PointThigh1_L.rotation.controller.viewline_length_abs = off
							PointThigh1_L.rotation.controller.upnode_world = off
							PointThigh1_L.rotation.controller.StoUP_axisFlip = on
							PointThigh1_L.rotation.controller.pickUpnode = execute ("$'" + BaseName + " Pelvis'")

							delete ExTmThigh_len
							
							PointThigh3_L = point size:3 box:off cross:on Centermarker:off axistripod:off  wirecolor:green
							PointThigh3_L.transform = (execute ("$'" + BaseName + " L Thigh'")).transform
							PointThigh3_L.Name = BaseName + "_PH_L Thigh03"
							PointThigh3_L.Parent = execute ("$'" + BaseName + " L Thigh'")
							
							PointThigh3_L.rotation.controller = LookAt_Constraint()
							PointThigh3_L.rotation.controller.appendtarget (execute ("$'" + BaseName + " L Calf'")) 50
							PointThigh3_L.rotation.controller.viewline_length_abs = off
							PointThigh3_L.rotation.controller.upnode_world = off
							PointThigh3_L.rotation.controller.pickUpnode = PointThigh1_L
							
							BoneThighTwist_L_Cre = BoneSys.CreateBone (execute ("$'" + BaseName + " L Thigh'")).transform.pos PointThigh2_L.pos PointThigh2_L.pos
							BoneThighTwist_L_Cre.wirecolor = color 250 220 0
							BoneThighTwist_L_Cre.width = 2
							BoneThighTwist_L_Cre.height = 2
							BoneThighTwist_L_Cre.taper = 90
							BoneThighTwist_L_Cre.FrontFin = on
							BoneThighTwist_L_Cre.FrontFinSize = 2
							BoneThighTwist_L_Cre.BackFin = on
							BoneThighTwist_L_Cre.BackFinSize = 1
							BoneThighTwist_L_Cre.Name = BaseName + "_B_L Thigh Twist"
							BoneThighTwist_L_Cre.Parent = execute ("$'" + BaseName + " L Thigh'")
							
							BoneThighTwist_L_Cre.rotation.controller = Orientation_Constraint()
							BoneThighTwist_L_Cre.rotation.controller.appendtarget (execute ("$'" + BaseName + " L Thigh'")) 25
							BoneThighTwist_L_Cre.rotation.controller.appendtarget PointThigh3_L 75
							
							
							--Left Hip
							ExTmHip_len = ExposeTm size:5
							ExTmHip_len.transform = (execute ("$'" + BaseName + " L Thigh'")).transform
							ExTmHip_len.exposeNode = execute ("$'" + BaseName + " L Thigh'")
							ExTmHip_len.localReferenceNode = execute ("$'" + BaseName + " L Calf'")
							ExTmHip_len.useParent = false
							Hip_len = (ExTmHip_len.Distance)/4
							in coordsys local ExTmHip_len.pos = [Hip_len,0,0]
							
							BoneHip_L_Cre = BoneSys.CreateBone (execute ("$'" + BaseName + " L Thigh'")).transform.pos ExTmHip_len.pos ExTmHip_len.pos
							BoneHip_L_Cre.wirecolor = color 255 0 0
							BoneHip_L_Cre.width = 2
							BoneHip_L_Cre.height = 2
							BoneHip_L_Cre.taper = 90
							BoneHip_L_Cre.FrontFin = on
							BoneHip_L_Cre.FrontFinSize = 1
							BoneHip_L_Cre.BackFin = on
							BoneHip_L_Cre.BackFinSize = 2
							BoneHip_L_Cre.Name = BaseName + "_B_L Hip"
							BoneHip_L_Cre.controller.rotation = (execute ("$'" + BaseName + " L Thigh'")).transform.rotation
							BoneHip_L_Cre.Parent = execute ("$'" + BaseName + " L Thigh'")
							in coordsys local BoneHip_L_Cre.rotation = (EulerAngles 0 0 90)
							in coordsys local BoneHip_L_Cre.rotation = (EulerAngles 180 0 0)
							
							delete ExTmHip_len
							
							BoneHip_L_Cre.rotation.controller = Orientation_Constraint()
							BoneHip_L_Cre.rotation.controller.relative = on
							BoneHip_L_Cre.rotation.controller.appendtarget BoneThighTwist_L_Cre 30
							BoneHip_L_Cre.rotation.controller.appendtarget PointPelvis 70
						)
						
					if chk6.checked == true do
						(
							--Right
							CalfPos = (execute ("$'" + BaseName + " R Calf'")).transform.pos
							FootPos = (execute ("$'" + BaseName + " R Foot'")).transform.pos
							
							ExTmKnee_len = ExposeTm size:5
							ExTmKnee_len.transform = (execute ("$'" + BaseName + " R Calf'")).transform
							ExTmKnee_len.exposeNode = execute ("$'" + BaseName + " R Calf'")
							ExTmKnee_len.localReferenceNode = execute ("$'" + BaseName + " R Foot'")
							ExTmKnee_len.useParent = false
							Knee_len = (ExTmKnee_len.Distance)/5
							in coordsys local ExTmKnee_len.pos = [Knee_len,0,0]
							
							BoneKnee_R_Cre = BoneSys.CreateBone CalfPos ExTmKnee_len.pos FootPos
							BoneKnee_R_Cre.wirecolor = color 255 0 0
							BoneKnee_R_Cre.width = 2
							BoneKnee_R_Cre.height = 2
							BoneKnee_R_Cretaper = 90
							BoneKnee_R_Cre.controller.rotation = (execute ("$'" + BaseName + " R Calf'")).transform.rotation
							BoneKnee_R_Cre.Name = BaseName + "_B_R Knee"
							BoneKnee_R_Cre.Parent = execute ("$'" + BaseName + " R Calf'")
							in coordsys local BoneKnee_R_Cre.rotation = (EulerAngles 0 0 -90)
							
							BoneKnee_R_Cre.rotation.controller = Orientation_Constraint()
							BoneKnee_R_Cre.rotation.controller.appendtarget (execute ("$'" + BaseName + " R Calf'")) 50
							BoneKnee_R_Cre.rotation.controller.appendtarget (execute ("$'" + BaseName + " R Thigh'")) 50
							BoneKnee_R_Cre.rotation.controller.relative = on
							
							delete ExTmKnee_len
							
							
							--Left
							CalfPos = (execute ("$'" + BaseName + " L Calf'")).transform.pos
							FootPos = (execute ("$'" + BaseName + " L Foot'")).transform.pos
							
							ExTmKnee_len = ExposeTm size:5
							ExTmKnee_len.transform = (execute ("$'" + BaseName + " L Calf'")).transform
							ExTmKnee_len.exposeNode = execute ("$'" + BaseName + " L Calf'")
							ExTmKnee_len.localReferenceNode = execute ("$'" + BaseName + " L Foot'")
							ExTmKnee_len.useParent = false
							Knee_len = (ExTmKnee_len.Distance)/5
							in coordsys local ExTmKnee_len.pos = [Knee_len,0,0]
							
							BoneKnee_L_Cre = BoneSys.CreateBone CalfPos ExTmKnee_len.pos FootPos
							BoneKnee_L_Cre.wirecolor = color 255 0 0
							BoneKnee_L_Cre.width = 2
							BoneKnee_L_Cre.height = 2
							BoneKnee_L_Cretaper = 90
							BoneKnee_L_Cre.controller.rotation = (execute ("$'" + BaseName + " L Calf'")).transform.rotation
							BoneKnee_L_Cre.Name = BaseName + "_B_L Knee"
							BoneKnee_L_Cre.Parent = execute ("$'" + BaseName + " L Calf'")
							in coordsys local BoneKnee_L_Cre.rotation = (EulerAngles 0 0 -90)
							
							BoneKnee_L_Cre.rotation.controller = Orientation_Constraint()
							BoneKnee_L_Cre.rotation.controller.appendtarget (execute ("$'" + BaseName + " L Calf'")) 50
							BoneKnee_L_Cre.rotation.controller.appendtarget (execute ("$'" + BaseName + " L Thigh'")) 50
							BoneKnee_L_Cre.rotation.controller.relative = on
							
							delete ExTmKnee_len
						)
				)
				else
				(
					false
				)
			)
		)
)
createdialog Character_SetUp 200 320