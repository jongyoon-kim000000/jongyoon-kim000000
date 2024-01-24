fn getWorldPosition obj = (
    local tm = obj.transform
    return tm.row4
)

fn getClosestObject baseObj targetArray = (
    local closestDist = 1e9
    local closestObj = undefined

    local basePos = getWorldPosition baseObj
    for obj in targetArray do (
        local dist = distance basePos (getWorldPosition obj)
        if dist < closestDist do (
            closestDist = dist
            closestObj = obj
        )
    )
    return closestObj
)

fn getTopParent obj = (
    while obj.parent != undefined do (
        obj = obj.parent
    )
    return obj
)

rollout myUI "Constraint Manager" width:264 height:432
(
	button 'btnA' "Register A" pos:[24,32] width:220 height:45 align:#left
	checkbox 'chkPosOffset' "Position Keep Initial Offset" pos:[24,184] width:220 height:20 align:#left
	checkbox 'chkOriOffset' "Orientation Keep Initial Offset" pos:[24,276] width:220 height:20 align:#left
	button 'btnB' "Register B" pos:[24,88] width:220 height:45 align:#left
	button 'btnApplyPos' "Apply Position Constraint" pos:[24,206] width:220 height:45 align:#left
	button 'btnApplyOri' "Apply Orientation Constraint" pos:[24,298] width:220 height:45 align:#left
	button 'btnClear' "Clear" pos:[20,368] width:220 height:35 align:#left
	label 'lblDev' "Developed by Creator424 (Kim Sa Jung)" pos:[40,410] width:208 height:20 align:#left
	groupBox 'grp3' "Objects" pos:[8,4] width:248 height:140 align:#left

	groupBox 'grp4' "Apply" pos:[8,152] width:248 height:200 align:#left
	on btnA pressed do
	(
	        global A = getCurrentSelection() as array
	        if A.count == 0 then ( 
	            messagebox "Please select objects first." 
	        ) else (
	            local topParent = getTopParent A[1]
	            btnA.text = "A: " + topParent.name + " (" + A.count as string + " objects)"
	        )
	    )
	on btnB pressed do
	(
	        global B = getCurrentSelection() as array
	        if B.count == 0 then ( 
	            messagebox "Please select objects first." 
	        ) else (
	            local topParent = getTopParent B[1]
	            btnB.text = "B: " + topParent.name + " (" + B.count as string + " objects)"
	        )
	    )
	on btnApplyPos pressed do
	(
	        for obj in A do (
	            local closest = getClosestObject obj B
	                
	            if obj.position.controller == undefined or classof obj.position.controller != Position_Constraint do (
	                pc = position_constraint()
	                obj.position.controller = pc
	            )
	            obj.position.controller.appendTarget closest 100
	            if chkPosOffset.checked then obj.position.controller.relative = true
	        )
	        print "Position Constraints Applied"
	    )
	on btnApplyOri pressed do
	(
	        for obj in A do (
	            local closest = getClosestObject obj B
	                
	            if obj.rotation.controller == undefined or classof obj.rotation.controller != Orientation_Constraint do (
	                oc = orientation_constraint()
	                obj.rotation.controller = oc
	            )
	            obj.rotation.controller.appendTarget closest 100
	            if chkOriOffset.checked then obj.rotation.controller.relative = true
	        )
	        print "Orientation Constraints Applied"
	    )
	on btnClear pressed do
	(
	        global A = #()
	        global B = #()
	        btnA.text = "Register A"
	        btnB.text = "Register B"
	        print "Arrays Cleared"
	    )
)

createdialog myUI
