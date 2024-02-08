rollout CreatDummy "Create Help v.01" width:208 height:150
(
    local get_txt_name = ""

    checkbox NewPointbox "Box" pos:[16,24] enabled:true checked:true across:3
    checkbox NewPointcross "Cross" pos:[75,24]
    checkbox N_link "Link" pos:[142,24]

    --checkbox NewPoint_root "Root" pos:[142,48] width:76 height:15
    --checkbox NewPointcenM "Center Marker" pos:[16,48] width:91 height:15 --width:143 height:24
 --width:143 height:24
    spinner spn_PointSize "Size:" pos:[30,50] range:[0,300,20] type:#integer width:40 height:16
    button btn_CreatPoint "Create" pos:[130,100]
    --radiobuttons N_stype "" labels:#("Null","Link","Root") pos:[142,24] width:44 height:15 across:3
    --checkbox New_cat "CAT" pos:[16,106]

    button bt_origin "Oringin" pos:[30,100] --width:31 height:21
    groupBox grp1 "Display" pos:[8,8] width:192 height:125
    --groupBox grp2 "Origin Root" pos:[8,90] width:192 height:160

    editText edt_name "Name:" pos:[80,50] fieldWidth:70
    --editText edt_name "Name:" pos:[16,70] wfieldWidth:20 labelOnTop:true
 --height:24
    --label label_1 "Name:" pos:[40,155] width:32 height:24
    --edittext btn5 "Button" pos:[40,184] width:128 height:24
    --checkbox N_par "X"
    --groupBox Display "Display" width:185 height:186


    --on N_par changed state do edt1.enabled = state
    on edt_name entered txt do(
        if txt !="" then (get_txt_name = true )
        else (get_txt_name = false)

    )
    -----------------------------------------
    on btn_CreatPoint pressed do
    (
        undo on
        (

                if selection.count != 0  then (
                    AllPoint = #()
                    for o in selection do
                    (
                        NewPoint = point()
                        if NewPointbox.checked == true then (NewPoint.box=on)
                        else (NewPoint.box=off)

                        if NewPointcross.checked == true then(NewPoint.cross=on)
                        else(NewPoint.cross=off)

                        NewPoint.transform = o.transform
                        NewPoint.size = spn_PointSize.value
                        --Newpoint.name = "Point_"+ o.name
                        if get_txt_name == true then (NewPoint.name = edt_name.text + "_" + o.name )
                        else(NewPoint.name = "Point_" + o.name)

                        if N_link.checked == true do(Newpoint.parent = o )
                        append AllPoint  Newpoint
                    )

                    select AllPoint
                    selectionSets ["Point_ji"] = AllPoint
                )
                else(

                        NewPoint = point()
                        if NewPointbox.checked == true then ( NewPoint.box=on)
                        else ( NewPoint.box=off )

                        if NewPointcross.checked == true then (NewPoint.cross=on)
                        else ( NewPoint.cross=off )

                        if get_txt_name == true do (NewPoint.name = edt_name.text)
                        --else(NewPoint.name = "Point_" + o.name)
                        /*if NewPoint_root.checked == true do(
                            Newpoint.name = "Root"
                            --Newpoint.transform = (matrix3 [0,0,1] [-1.50996e-007,-1,0] [1,-1.50996e-007,0] [0,0,0])

                            --$boy_Hub.parent = Newpoint
                            Newpoint.boneEnable=true
                        )*/

                )
        )


    )
    on bt_origin pressed do
    (
        undo on(
            if selection.count == 0 do (
                NewPoint = point()
                if NewPointbox.checked == true then (NewPoint.box=on)
                else (NewPoint.box=off)

                if NewPointcross.checked == true then (NewPoint.cross=on)
                else(NewPoint.cross=off)

                if get_txt_name == true do (NewPoint.name = edt_name.text)
                --else(NewPoint.name = "Root_" )

                --if New_cat.checked == true do ( Newpoint.transform = (matrix3 [0,0,1] [-1.50996e-007,-1,0] [1,-1.50996e-007,0] [0,0,0]) )
                Newpoint.boneEnable=true
            )

            if selection.count == 1 do (
                NewPoint = point()
                if NewPointbox.checked == true then (NewPoint.box=on)
                else (NewPoint.box=off)

                if NewPointcross.checked == true then (NewPoint.cross=on)
                else(NewPoint.cross=off)

                if get_txt_name == true then (NewPoint.name = edt_name.text)
                else(NewPoint.name = "Root_" + $.name)
                $.parent = Newpoint
                Newpoint.boneEnable=true
            )

            if selection.count > 1 do ( messageBox ("只能选择一个物体") )
        )
    )

)
createDialog CreatDummy