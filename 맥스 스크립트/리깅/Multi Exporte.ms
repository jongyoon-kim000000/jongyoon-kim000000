
(
	global rol_miauuBatchSaveObjToMax
    try(destroyDialog rol_miauuBatchSaveObjToMax)catch()
    rollout rol_miauuBatchSaveObjToMax "Multi Exporte"
    (
		local curMaxVersion = ((maxVersion())[1] / 1000)
		local openFileRoll = dotNetObject "System.Windows.Forms.OpenFileDialog"	
        local disableForeColor = (dotNetClass "System.Drawing.Color").white
        local maxFiles = #()   
	
		function VersionNums = 
		(
			longVersion = ((curMaxVersion - 2) + 2000) 
			for i = 0 to 3 collect (longVersion - (1 * i))
		)
		local versions = versionNums()
		
       
		label lbl_fileTypeToLoad "File type to load:" pos:[10 ,10 ] width:80
		radiobuttons rb_fileType "" labels:#("OBJ", "FBX", "3DS", "MAX") default:1 columns:4 pos:[95,10]
		button btn_getDir "Get Directory" width:90 pos:[10,30] tooltip:"Select all .max files in the given folder and/or its sub-folders"
        button btn_getFile "Get file(s)" width:90 pos:[101,30] tooltip:"Select one or multiple .max files in given folder"
        button btn_Clear "Clear" width:90 pos:[192,30] 
		
		dotNetControl lv_Batch "system.windows.forms.listView" height:200 width:273 pos:[10,60]
			
		checkbox chkBox_showFullPath "Show Full Path" pos:[10,265]
		label lbl_select "Select:" pos:[120,265]
		button btn_all "All" pos:[157,264] width:40 height:18
		button btn_none "None" pos:[200,264] width:40 height:18
        button btn_invert "Invert" pos:[243,264]	width:40 height:18
		
		label lbl_saveToVersion "Save as Version:" pos:[10,288] width:80
		dropdownList ddl_version "" pos:[90,285] width:96 height:40 items:(for v in versions collect v as string) 
			
		button bnt_saveAsPrevious "Save As Max file" width:275 height:30 pos:[10,310]
		
		label lbl_exp "Export to:" pos:[10,350] width:50
		checkBox chkBox_exportToFBX ".FBX" pos:[65,350]
		checkBox chkBox_exportToObj ".OBJ" pos:[120,350]
		checkBox chkBox_exportTo3ds ".3ds" pos:[175,350]
		
		button bnt_Export "EXPORT" width:275 height:30 pos:[10,370]
		
		progressBar pb_xRefprogress value:0 color:green width:275 pos:[10,405]

        	
        function AddColumns theLv columnsAr=
        (
            if chkBox_showFullPath.state == false then
                w=(theLv.width)-6
            else
                w=(theLv.width)+400
            for x in columnsAr do
            (
                theLv.columns.add x w
            )
        )
        function PopulateListView theLv=
        (
            rows=#()
            for x=1 to maxFiles.count do
            (
                if chkBox_showFullPath.state == false then
                    mapName = (getFilenameFile maxFiles[x])
                else
                    mapName = maxFiles[x]
                
                li = dotNetObject "System.Windows.Forms.ListViewItem" mapName
                append rows li
            )
            theLv.items.addRange rows
        )
        function InitListView theLv=
        (            
            theLv.clear()
			theLv.headerStyle = theLv.headerStyle.none
            theLv.view = (dotNetClass "system.windows.forms.view").details
            theLv.FullRowSelect = true    
            theLv.MultiSelect = true    
            theLv.checkBoxes = true                
            theLv.backcolor = (dotNetClass "System.Drawing.Color").DimGray
            theLv.forecolor = (dotNetClass "System.Drawing.Color").lightGray
        )
        function BatchListViewReIinit =
        (
            InitListView lv_Batch
            AddColumns lv_Batch #("")    
            PopulateListView lv_Batch
        )
        function TurnBatchLVchkBoxOn =
        (
            for i = 0 to lv_Batch.Items.count-1 do
                lv_Batch.Items.Item[i].checked = true
            lv_Batch.forecolor = disableForeColor
        )    
        function OpenFolders folderToOpen =
        (
            local checkFolderName = substring folderToOpen 1 (folderToOpen.count-1)
            if (symbolicPaths.isPathName checkFolderName) then
            (
                folderToOpen = symbolicPaths.getPathValue checkFolderName
            )                
            shellLaunch "explorer.exe" folderToOpen
        )        
        
        function GetFilesRecursive root pattern =
        (        
            dir_array = GetDirectories (root+"\*")
            for d in dir_array do
                join dir_array (GetDirectories (d+"*"))    
            
            my_files = #()                
            for f in dir_array do
                join my_files (getFiles (f + pattern))
                    
            my_files
        )
		
        on btn_getDir pressed do
        (
            dir = getSavePath caption:"Select the directory" initialDir:"$scenes"
            if dir != undefined do
            (
				fileType = case rb_fileType.state of
				(
					1: ".obj"
					2: ".fbx"
					3: ".3ds"
					4: ".max"
				)
                maxFiles = #()
                maxFiles = getFiles (dir+"\*" + fileType)
                subFiles = GetFilesRecursive dir ("*" + fileType)
                if subFiles.count != 0 then
                (
                    msg = "The selected folder have subfolders!\n"
                    msg += "Do you want to include the files from the subfolders too?"
                    if queryBox  msg title:"Sub-folders found" do
                        join maxFiles subFiles
                )
				makeUniqueArray maxFiles
                PopulateListView lv_Batch
                TurnBatchLVchkBoxOn()
            )
        )
        
        on btn_getFile pressed do
        (
			openFileRoll.FilterIndex = rb_fileType.state
			result = openFileRoll.showDialog()
			result.ToString() 
			if (result.Equals result.OK) do 
			(
				filePath = (openFileRoll.fileNames)
				join maxFiles filePath
				makeUniqueArray maxFiles
                BatchListViewReIinit()
                TurnBatchLVchkBoxOn()
			)
        )
		
		on btn_all pressed do
		(
			for i = 0 to lv_Batch.Items.count-1 do lv_Batch.Items.Item[i].checked = true
		)
		
		on btn_none pressed do
		(
			for i = 0 to lv_Batch.Items.count-1 do lv_Batch.Items.Item[i].checked = false
		)
		
		on btn_invert pressed do
		(
			for i = 0 to lv_Batch.Items.count-1 do lv_Batch.Items.Item[i].checked = not lv_Batch.Items.Item[i].checked
		)
		
        on btn_Clear pressed do
        (
            maxFiles = #()
            BatchListViewReIinit()
        )
	
        on lv_Batch MouseDown arg do
        (
            if arg.button==arg.button.middle then
            (                
                if (hitNode = lv_Batch.GetItemAt arg.x arg.y) != undefined do
                (
                    deleteItem maxFiles (hitNode.index+1)
                    BatchListViewReIinit()
                )                
            )
            if arg.button==arg.button.right then
            (                
                if (hitNode = lv_Batch.GetItemAt arg.x arg.y) != undefined do
                (
                    f = (hitNode.index+1)
                    folderToOpen = (getFilenamePath maxFiles[f])
                    OpenFolders folderToOpen
                )                
            )
        )
        
        on chkBox_showFullPath changed state do
        (
			cbState = for i = 0 to lv_Batch.Items.count-1 collect lv_Batch.Items.Item[i].checked
            BatchListViewReIinit()
            for i = 0 to lv_Batch.Items.count-1 do lv_Batch.Items.Item[i].checked = cbState[i + 1]
        ) 

		function SaveExportAsPrevious _export: =
		(	
			_isMaxFile = case rb_fileType.state of
				(
					4: true
					default:false
				)
			
			
			local fileCnt = (lv_Batch.Items.count - 1)
			
			local versionIndex = ddl_version.selected
			local versionN = ddl_version.selection
			setWaitCursor()
			suspendEditing()
			resetMaxFile #noPrompt
			for i = 0 to fileCnt where (lv_Batch.Items.Item[i].checked == true) do with redraw off
			(
				if _isMaxFile then
					loadMaxFile maxFiles[i+1] quiet:true
				else
					importFile maxFiles[i+1] #noPrompt
				
				filePath = getFilenamePath maxFiles[i+1]
				
				if _export == false then
				(
					fileName = (getFilenameFile maxFiles[i+1]) + "_" + (versionIndex as string)
					newName = filePath + "\\" + fileName + ".max"
					if versionN == 1 then
						saveMaxFile newName useNewFile:true quiet:true
					else
						saveMaxFile newName saveAsVersion:(versionIndex as integer ) useNewFile:true quiet:true
				)
				else
				(
					fileName = (getFilenameFile maxFiles[i+1])
					if chkBox_exportToFBX.checked do
					(
						newName = filePath + "\\" + fileName + ".fbx"
						exportFile newName #noPrompt 
					)
					if chkBox_exportToObj.checked do
					(
						newName = filePath + "\\" + fileName + ".obj"
						exportFile newName #noPrompt 
					)
					if chkBox_exportTo3ds.checked do
					(
						newName = filePath + "\\" + fileName + ".3ds"
						exportFile newName #noPrompt 
					)
				)
				resetMaxFile #noPrompt
				pb_xRefprogress.value = 100.0 * i / fileCnt
				if curMaxVersion > 12 do
					windows.processPostedMessages()
			)
			completeRedraw()
			resumeEditing()
			setArrowCursor()
		)
		
		on bnt_saveAsPrevious pressed do
		(	
			SaveExportAsPrevious _export:false
		)
		
		on bnt_Export pressed do
		(
			SaveExportAsPrevious _export:true
		)
		
		on rol_miauuBatchSaveObjToMax resized size do
		(
			lv_Batch.width = size.x - 20
			lv_Batch.height = size.y - 180
			
			lvHeight = lv_Batch.height
			chkBox_showFullPath.pos.y = lv_Batch.pos.y + lvHeight + 5
			lbl_select.pos.y = lv_Batch.pos.y + lvHeight + 8
			btn_all.pos.y = lv_Batch.pos.y + lvHeight + 5
			btn_none.pos.y = lv_Batch.pos.y + lvHeight + 5
			btn_invert.pos.y = lv_Batch.pos.y + lvHeight + 5 			
			lbl_saveToVersion.pos.y = lv_Batch.pos.y + lvHeight + 28
			ddl_version.pos.y = lv_Batch.pos.y + lvHeight + 25		
			bnt_saveAsPrevious.pos.y = lv_Batch.pos.y + lvHeight + 55
			pb_xRefprogress.pos.y = lv_Batch.pos.y + lvHeight + 90
			http_miauu.pos.y = lv_Batch.pos.y + lvHeight + 105
		)
        
		function String2Bmp string =
		(
			local clipboardClass = dotNetClass "System.Windows.Forms.Clipboard"
			local ConvertClass = dotnetclass "system.convert"
			local imageclass = dotNetclass "System.Drawing.image"
			local bytearr = convertclass.FromBase64String string
			local memstream = dotnetobject "System.IO.MemoryStream" bytearr
			local DecodedImg = ImageClass.fromstream memstream
			memstream.close()
			DecodedImg
		)
		function LoadMyLogoAsTitlebarIcon =
		(

			d = (windows.getChildHWND 0 rol_miauuBatchSaveObjToMax.title)[1]
			WM_SETICON = 0x0080
			ICON_SMALL = 0
			bm = dotnetobject "System.Drawing.Bitmap" (String2Bmp logoIcon)			
			ptr = bm.GetHicon()
			icon = (dotnetclass "System.Drawing.Icon").FromHandle (dotnetobject "IntPtr" ptr)			
			windows.SendMessage d WM_SETICON ICON_SMALL icon.handle
		)
        on rol_miauuBatchSaveObjToMax open do
        ( 
			try(LoadMyLogoAsTitlebarIcon())catch()
				
			openFileRoll.title = "Select Files"
			openFileRoll.Multiselect = true
			openFileRoll.Filter = "OBJ (*.obj)|*.obj|FBX (*.fbx)|*.fbx|3DS (*.3ds)|*.3ds|MAX (*.max)|*.max"
			openFileRoll.FilterIndex = 1
			openFileRoll.RestoreDirectory = true	
			
            InitListView lv_Batch
            AddColumns lv_Batch #("Files")
        )
    )
    createdialog rol_miauuBatchSaveObjToMax width:293 height:440 style:#(#style_titlebar, #style_border, #style_sysmenu, #style_resizing)
)