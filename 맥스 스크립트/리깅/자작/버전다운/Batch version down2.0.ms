
(
	global Batch_Ver_down
    try(destroyDialog Batch_Ver_down)catch()
    rollout Batch_Ver_down "Multi version Down"
    (
		local curMaxVersion = ((maxVersion())[1] / 1000)
		local openFileRoll = dotNetObject "System.Windows.Forms.OpenFileDialog"	
        local disableForeColor = (dotNetClass "System.Drawing.Color").white
        local maxFiles = #()   
		fn openInfoWebsite =
		(
  		  shellLaunch "https://blog.naver.com/trueb000/" ""
		)

	
		function VersionNums = 
		(
			longVersion = ((curMaxVersion - 2) + 2000) 
			for i = 0 to 3 collect (longVersion - (1 * i))
		)
		local versions = versionNums()
		
       
		button btn_getDir "Directory" width:155 height:30 pos:[10,20]
      		button btn_getFile "file" width:155  height:30 pos:[170,20] 
       		button btn_Clear "Clear" width:155  height:30 pos:[330,20] 
		dotNetControl lv_Batch "system.windows.forms.listView" height:200 width:480 pos:[10,60]
		
		
		label lbl_select "Select:" pos:[250,275]
		button btn_all "All" pos:[297,275] width:40 height:18
		button btn_none "None" pos:[340,275] width:40 height:18
        button btn_invert "Invert" pos:[383,275]	width:40 height:18	
		label lbl_saveToVersion "Save as Version:" pos:[40,275] width:80
		dropdownList ddl_version "" pos:[120,273] width:96 height:40 items:(for v in versions collect v as string) 
		

	
		button bnt_saveAsPrevious "Save As Max file" width:475 height:30 pos:[10,320]
		progressBar pb_xRefprogress value:0 color:green width:475 pos:[10,365]
		button infoButton "Info" pos:[190,390] width:105 height:25
        	
        function AddColumns theLv columnsAr=
        (
                w=(theLv.width)+500
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
				fileType = ".max"
				
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
			openFileRoll.FilterIndex = 4
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
        


		function SaveExportAsPrevious _export: =
		(	
			_isMaxFile = false

			
			
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
		

        
	
	
        on Batch_Ver_down open do
        ( 
			openFileRoll.title = "Select Files"
			openFileRoll.Multiselect = true
			openFileRoll.Filter = "OBJ (*.obj)|*.obj|FBX (*.fbx)|*.fbx|3DS (*.3ds)|*.3ds|MAX (*.max)|*.max"
			openFileRoll.FilterIndex = 1
			openFileRoll.RestoreDirectory = true	
			
            InitListView lv_Batch
            AddColumns lv_Batch #("Files")
        )
    )
    createdialog Batch_Ver_down width:500 height:430 
)