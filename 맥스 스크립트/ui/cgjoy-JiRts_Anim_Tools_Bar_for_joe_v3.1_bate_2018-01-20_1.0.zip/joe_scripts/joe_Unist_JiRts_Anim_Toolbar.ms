-- Unist script by Joe --

rollout Uninst_JiRt "Unist" width:210 height:60
(
    local usermacros = (symbolicPaths.getPathValue "$userMacros")+"\\"
    local userscripts = (symbolicPaths.getPathValue "$userScripts")+"\\"
    local scripts = symbolicPaths.getPathValue "$scripts"+"\\"
    local JiRt_deldir = scripts+"JiRt_Scripts"
    local joe_filedir = userscripts + "joe_scripts"
    --local JiRt_Tools_mcr = #("JiRt_Tools-BoneToggle.mcr","JiRt_Tools-Copy_Objects_To_File.mcr","JiRt_Tools-DeTriangUlator.mcr","JiRt_Tools-Paste_Objects_From_File.mcr")

    label lb01 "是否卸载 JiRts_Anim_Tools_Bar ?"  pos:[26,5] width:200 height:13
    button uninst "卸载原版"        pos:[32,25]    width:60    height:30
    button uninst_v_joe "卸载本版"  pos:[120,25]     width:60    height:30

    fn getFilesRecursive root pattern =
    (
        dir_array = GetDirectories (root+"/*")
            for d in dir_array do
                join dir_array (GetDirectories (d+"/*"))
            my_files = #()
            for f in dir_array do
                join my_files (getFiles (f + pattern))
            my_files
    )

    fn del_JiRts =
    (
        jiRts_file = getFilesRecursive scripts "JiRts*" --del Max root path
        for i in jiRts_file do deleteFile i

        commandd = "RD /S /Q \""+JiRt_deldir+"\""
		HiddenDOSCommand commandd startpath:".\\"

    )
    /*
    fn del_usermcr =
    (

    )
    */
    fn del_joe =
    (
        joe_file = getFilesRecursive userscripts "joe*"
        for jo in joe_file do deleteFile jo

        commandd = "RD /S /Q \""+joe_filedir+"\""
        HiddenDOSCommand commandd startpath:".\\"
    )
    -------------------------------------------------------------------
    on uninst pressed do
    (
        if queryBox "确定卸载JiRts_Anim_Tools_Bar原版 ? " title: "Unist!" do
        (
            del_JiRts()

        )
    )

    on uninst_v_joe pressed do
    (
        if queryBox "确定卸载joe_JiRts_Anim_Tools_Bar_v3.1_bate ? " title: "Unist!" do
        (
            del_joe()
        )
    )

)
createDialog Uninst_JiRt style:#(#style_toolwindow, #style_border, #style_sysmenu)