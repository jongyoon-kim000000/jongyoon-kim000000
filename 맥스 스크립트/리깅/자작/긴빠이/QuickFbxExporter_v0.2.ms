(
	global QuickFbxExpoter
	global ExportPathName = @"...\Desktop"
	local importFiles
	local selectObjectList = #()
	pluginManager.loadClass FbxExporter

	try closeRolloutFloater QuickFbxExpoter catch()

		fn GetExportOptions  =
		(
			FbxExporterSetParam "SmoothingGroups" (FbxExporterGetParam "SmoothingGroups")
			FbxExporterGetParam "NormalsPerPoly" (FbxExporterGetParam "NormalsPerPoly")
			FbxExporterGetParam "TangentSpaceExport" (FbxExporterGetParam "TangentSpaceExport")
			FbxExporterGetParam "SmoothMeshExport" (FbxExporterGetParam "SmoothMeshExport")
			FbxExporterGetParam "Preserveinstances" (FbxExporterGetParam "Preserveinstances")
			FbxExporterGetParam "SelectionSetExport" (FbxExporterGetParam "SelectionSetExport")
			FbxExporterGetParam "GeomAsBone" (FbxExporterGetParam "GeomAsBone")
			FbxExporterGetParam "Triangulate" (FbxExporterGetParam "Triangulate")
			FbxExporterGetParam "Animation" (FbxExporterGetParam "Animation")
			FbxExporterGetParam "UseSceneName" (FbxExporterGetParam "UseSceneName")
			FbxExporterGetParam "Removesinglekeys" (FbxExporterGetParam "Removesinglekeys")
			FbxExporterGetParam "BakeAnimation" (FbxExporterGetParam "BakeAnimation")
			FbxExporterGetParam "BakeFrameStart" (FbxExporterGetParam "BakeFrameStart")
			FbxExporterGetParam "BakeFrameEnd" (FbxExporterGetParam "BakeFrameEnd")
			FbxExporterGetParam "BakeFrameStep" (FbxExporterGetParam "BakeFrameStep")
			FbxExporterGetParam "Skin" (FbxExporterGetParam "Skin")
			FbxExporterGetParam "Shape" (FbxExporterGetParam "Shape")
			FbxExporterGetParam "FilterKeyReducer" (FbxExporterGetParam "FilterKeyReducer")
			FbxExporterGetParam "Resampling" (FbxExporterGetParam "Resampling")
			FbxExporterGetParam "PointCache" (FbxExporterGetParam "PointCache")
			FbxExporterGetParam "CAT2HIK" (FbxExporterGetParam "CAT2HIK")
			FbxExporterGetParam "Cameras" (FbxExporterGetParam "Cameras")
			FbxExporterGetParam "Lights" (FbxExporterGetParam "Lights")
			FbxExporterGetParam "EmbedTextures" (FbxExporterGetParam "EmbedTextures")
			FbxExporterGetParam "ConvertUnit" (FbxExporterGetParam "ConvertUnit")
			FbxExporterGetParam "AxisConversionMethod" (FbxExporterGetParam "AxisConversionMethod")
			FbxExporterGetParam "UpAxis" (FbxExporterGetParam "UpAxis")
			FbxExporterGetParam "ShowWarnings" (FbxExporterGetParam "ShowWarnings")
			FbxExporterGetParam "GenerateLog" (FbxExporterGetParam "GenerateLog")
			FbxExporterGetParam "ASCII" (FbxExporterGetParam "ASCII")
			FbxExporterGetParam "FileVersion" (FbxExporterGetParam "FileVersion")
		)

		fn ExportSelectObjectIndividual =  -- 선택한 오브젝트 따로 저장하기
		(
			if(selection.count == 0) then
			(
				messageBox "익스포트할 오브젝트들을 선택해주세요."
				return false
			)
			else
			(
				if(OpenFbxSetting()) do
				(
					GetExportOptions()
					selectObjectList = selection as array

					for i = 1 to selectObjectList.count do
					(
						objectName = selectObjectList[i].name
						print objectName as string 
						fbxSavePath = ExportPathName + "\\" + objectName
						print fbxSavePath as string 
						select selectObjectList[i]
						exportFile fbxSavePath #noPrompt selectedOnly:true using:FBXEXP
					)

					deselect selection
				)
			)
		)

		rollout BeomFBXmasterRollOut "선택한 모델 함께 내보내기"
		(
			button 'exportFbxTogether_btn' "선택한 오브젝트들을 FBX 하나로 내보내기" pos:[0,5] width:220 height:40 toolTip:"" align:#left

			on exportFbxTogether_btn pressed do -- 선택한 오브젝트 같이 저장하기
			(
				if(selection.count == 0) then -- 데헷 o_< 먼저 0개를 체크하고 돌리게
 				(
					messageBox "익스포트할 오브젝트들을 선택해주세요."
					return false
				)
				else
				(
					if(OpenFbxSetting()) then
					(		
						objectName = getSaveFileName()
						print objectName

						if(objectName != undefined) then --OpenFbxSetting()) do 
						(

							--print "파일 이름 저장하기"
							selectObjectList = selection
		 					exportFile objectName #noPrompt type:"*.fbx" selectedOnly:true using:FBXEXP

							GetExportOptions()
						)
						else
						(
							--print "파일 이름 저장하기 취소"
							return false
						)
					)
					else
					(
						--print "FBX 익스포트 세팅 취소"
						return false
					)

				)
			)
		)

		rollout BeomFBXmasterRollOut2 "선택한 모델 각자 내보내기"
		(
			editText 'savepath' "현재 저장 경로 |  " text:ExportPathName pos:[3,10] width:150 height:27 align:#left readOnly:true  labelOnTop:true
			button 'SetExportPath_btn' "내보낼 경로 지정" pos:[savepath.pos.x+ 82, 10] width:100 height:15 align:#left
			button 'exportFbxIndividual_btn' "선택한 오브젝트들을 개별로 내보내기" pos:[0,60] width:200 height:40 toolTip:"" align:#left		
			--checkbox 'use_SettingPath' "지금 설정된 경로 계속 사용하기" triState:0 pos:[0,0] iconSize:[500,500]

			on SetExportPath_btn pressed do
			(
				try
				(
					savepath.text = getSavePath()
					ExportPathName = savepath.text
				)
				catch()

			)

			on exportFbxIndividual_btn pressed do
			(
				ExportSelectObjectIndividual()
			)
		)

		QuickFbxExpoter = newRolloutFloater "Quick FBX Expoter" 270 400 lockheight:true lockweight:true

		addRollout BeomFBXmasterRollOut QuickFbxExpoter
		addRollout BeomFBXmasterRollOut2 QuickFbxExpoter
)