try(DestroyDialog EnvelopeTool)catch()

rollout EnvelopeTool "Envelope Tool"
(
	PickButton PBtn_GetObj "Get Skined Obj" pos:[10,10]width:220 height:30
	
	spinner Spn_Outer "Outer : " pos:[50,50] width:120 range:[0,100,0]
	spinner Spn_Inner "Inner : " pos:[50,70] width:120 range:[0,100,0]

	button Btn_Parent "Parent" pos:[125,90] width:105
	button Btn_Child "Child" pos:[125,115] width:105
	button Btn_Exclude "Exclude" pos:[125, 140] width:105
	
	button Btn_Grow "Grow" pos:[10, 90] width:105
	button Btn_Paste "Green to Blue" pos:[10, 115] width:105
	checkbutton CBtn_Material "Material On / Off" pos:[10,140] width:105
	
	button Btn_Figuremode "Figure mode" pos:[125, 165] width:105

	ListBox LB_BoneList "Bone List" pos:[10, 170] width:220 height:31
	
	label lb_made "created by Shin Jinho"
	
	on EnvelopeTool open do
		(
			Spn_Outer.Enabled = false
			Spn_Inner.Enabled = false
			Btn_Grow.Enabled = false
			Btn_Parent.Enabled = false
			Btn_Child.Enabled = false
			Btn_Exclude.Enabled = false
			Btn_Paste.Enabled = false
		)
		
	on PBtn_GetObj picked obj do
		(
			if getCommandPanelTaskMode != #modify do setCommandPanelTaskMode #modify
			if obj != undefined do
				(
					max modify mode
					
					if obj.modifiers[1] != undefined do
						(
							if classof obj.modifiers[1] == Skin do
								(									
									local BoneList = #()
									
									PBtn_GetObj.text = obj.name
									
									SkinedMesh = (execute ("$" + PBtn_GetObj.text)).modifiers[#Skin]
									SkinedMesh.showNoEnvelopes = on
									SkinedMesh.wt_activeVertexSet = 1
									SkinedMesh.wt_showAffectedBones = on
									SkinedMesh.crossSectionsAlwaysOnTop = off
										
									modPanel.setCurrentObject SkinedMesh
									subobjectLevel = 1
									
									Spn_Outer.Enabled = true
									Spn_Inner.Enabled = true
									Btn_Grow.Enabled = true
									Btn_Parent.Enabled = true
									Btn_Child.Enabled = true
									Btn_Exclude.Enabled = true
									Btn_Paste.Enabled = true
									
									NumBones = SkinOps.GetNumberBones SkinedMesh
									
									if NumBones > 0 do
										(
											for i = 1 to NumBones do
												(
													AppendIfUnique BoneList (SkinOps.GetBoneName SkinedMesh i 1)
												)
												
											LB_BoneList.items = sort BoneList
												
											for i = 1 to NumBones do
												(
													SP = SkinOps.GetStartPoint SkinedMesh i
													EP = SkinOps.GetEndPoint SkinedMesh i
													GetLength = distance EP SP
													
													if GetLength > 0.02 do
														(
															EPtoSP = EP - SP
															
															SetEP = (EP - (EPtoSP * 0.501))
															SetSP = (SP + (EPtoSP * 0.501))
															skinOps.setEndPoint SkinedMesh i SetEP
															skinOps.setStartPoint SkinedMesh i SetSP
														)
												)
										)
									SkinOps.SelectBone SkinedMesh 1
									Spn_Outer.value = skinOps.GetOuterRadius SkinedMesh 1 1
									Spn_Inner.value = skinOps.GetInnerRadius SkinedMesh 1 1
								)
						)
				)
		)
		
	on LB_BoneList selected idx do
		(
			if getCommandPanelTaskMode != #modify do setCommandPanelTaskMode #modify
			SkinedMesh = (execute ("$" + PBtn_GetObj.text)).modifiers[#Skin]
			
			for i = 1 to LB_BoneList.items.count do
				(
					if LB_BoneList.selected == SkinOps.GetBoneName SkinedMesh i 1 do
						(
							SkinOps.SelectBone SkinedMesh i
							Spn_Outer.value = skinOps.GetOuterRadius SkinedMesh i 1
							Spn_Inner.value = skinOps.GetInnerRadius SkinedMesh i 1
						)
				)
		)
		
	on Spn_Outer changed val do
		(
			if getCommandPanelTaskMode != #modify do setCommandPanelTaskMode #modify
			if $ != undefined do
				(
					SkinedMesh = (execute ("$" + PBtn_GetObj.text)).modifiers[#Skin]
					SelectedBone = skinOps.GetSelectedBone SkinedMesh
					skinOps.SetOuterRadius SkinedMesh SelectedBone 1 Spn_Outer.value
					skinOps.SetOuterRadius SkinedMesh SelectedBone 2 Spn_Outer.value
				)
		)
		
	on Spn_Inner changed val do
		(
			if getCommandPanelTaskMode != #modify do setCommandPanelTaskMode #modify
			if $ != undefined do
				(
					SkinedMesh = (execute ("$" + PBtn_GetObj.text)).modifiers[#Skin]
					SelectedBone = skinOps.GetSelectedBone SkinedMesh
					skinOps.SetInnerRadius SkinedMesh SelectedBone 1 Spn_Inner.value
					skinOps.SetInnerRadius SkinedMesh SelectedBone 2 Spn_Inner.value
				)
		)

	on Btn_Parent pressed do
		(
			if getCommandPanelTaskMode != #modify do setCommandPanelTaskMode #modify
			SkinedMesh = (execute ("$" + PBtn_GetObj.text)).modifiers[#Skin]
			SkinOps.SelectParent SkinedMesh
			SelectedBone = skinOps.GetSelectedBone SkinedMesh
			Spn_Outer.value = skinOps.GetOuterRadius SkinedMesh SelectedBone 1
			Spn_Inner.value = skinOps.GetInnerRadius SkinedMesh SelectedBone 1
				
			CurrentBoneName = SkinOps.GetBoneName SkinedMesh SelectedBone 1
			
			for i = 1 to LB_BoneList.items.count do
				(
					if CurrentBoneName == LB_BoneList.items[i] do
						(
							LB_BoneList.selection = i
						)
				)
		)
		
	on Btn_Child pressed do
		(
			if getCommandPanelTaskMode != #modify do setCommandPanelTaskMode #modify
			SkinedMesh = (execute ("$" + PBtn_GetObj.text)).modifiers[#Skin]
			SkinOps.SelectChild SkinedMesh
			SelectedBone = skinOps.GetSelectedBone SkinedMesh
			Spn_Outer.value = skinOps.GetOuterRadius SkinedMesh SelectedBone 1
			Spn_Inner.value = skinOps.GetInnerRadius SkinedMesh SelectedBone 1
				
			CurrentBoneName = SkinOps.GetBoneName SkinedMesh SelectedBone 1
			
			for i = 1 to LB_BoneList.items.count do
				(
					if CurrentBoneName == LB_BoneList.items[i] do
						(
							LB_BoneList.selection = i
						)
				)
		)
		
	on Btn_Exclude pressed do
		(
			if getCommandPanelTaskMode != #modify do setCommandPanelTaskMode #modify
			undo on
				(
					SkinedMesh = (execute ("$" + PBtn_GetObj.text)).modifiers[#Skin]
					skinOps.buttonExclude SkinedMesh
				)
		)
		
	on Btn_Grow pressed do
		(
			if getCommandPanelTaskMode != #modify do setCommandPanelTaskMode #modify
			undo on
				(
					SkinedMesh = (execute ("$" + PBtn_GetObj.text)).modifiers[#Skin]
					skinOps.growSelection SkinedMesh
				)
		)
		
	on Btn_Figuremode pressed do
		(
			if $Bip001 != undefined do
				(
					$Bip001.controller.Figuremode = not $Bip001.controller.Figuremode
				)
		)
		
	on Btn_Paste pressed do
		(
			if getCommandPanelTaskMode != #modify do setCommandPanelTaskMode #modify
			SkinedMesh = (execute ("$" + PBtn_GetObj.text)).modifiers[#Skin]
			SkinedMesh.mirrorEnabled = on
			skinOps.pasteAllBones SkinedMesh off
			skinOps.pasteAllVerts SkinedMesh off
			SkinedMesh.mirrorEnabled = off
		)
		
	on CBtn_Material Changed state do
		(
			if CBtn_Material.checked == false then
				(
					actionMan.executeAction 0 "63544"  -- Views: Viewport Materials Display as Shaded
					CBtn_Material.text = "Off"
				)
			else
				(
					actionMan.executeAction 0 "63545"  -- Views: Viewport Materials Display as Shaded with Maps
					CBtn_Material.text = "On"
				)
		)
)
CreateDialog EnvelopeTool 240 620