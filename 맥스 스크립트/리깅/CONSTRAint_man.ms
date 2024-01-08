try (destroyDialog constraintManager) catch ()

rollout constraintManager "Constraint Manager" width:250
(
    edittext prefixEditText "Prefix:" text:"NewPrefix_" fieldWidth:80
    button setPrefixButton "Set" width:80

    edittext originPrefix "Origin Prefix:" text:"ORIGIN_" width:150
    edittext refPrefix "Ref Prefix:" text:"REF_" width:150

    button constraintBtn "Set" width:80
    button resetBtn "Reset" width:80

    on setPrefixButton pressed do
    (
        local prefix = prefixEditText.text
        if selection.count > 0 then
        (
            for obj in selection do
            (
                obj.name = prefix + obj.name
            )
            messagebox ("Prefix set successfully.")
        )
        else
        (
            messagebox "NONE SELECTED." title:"Warning"
        )
    )

    on resetBtn pressed do
    (
        global selectedObjects

        local transformsArray = #()

        for obj in selectedObjects do
        (
            append transformsArray obj.transform
        )

        for i = 1 to selectedObjects.count do
        (
            local obj = selectedObjects[i]
            
            posController = obj.position.controller
            newPositionController = Position_XYZ()
            obj.position.controller = newPositionController

            rotController = obj.rotation.controller
            newRotationController = Euler_XYZ()
            obj.rotation.controller = newRotationController

            obj.transform = transformsArray[i]
        )
    )

    on constraintBtn pressed do
    (
        selectedObjects = selection as array

        originObjects = for obj in selectedObjects where matchPattern obj.name pattern:(originPrefix.text + "*") collect obj
        refObjects = for obj in selectedObjects where matchPattern obj.name pattern:(refPrefix.text + "*") collect obj

        R = for refObj in refObjects collect substring refObj.name (refPrefix.text.count + 1) (refObj.name.count - 1)
        O = for originObj in originObjects collect substring originObj.name (originPrefix.text.count + 1) (originObj.name.count - 1)

        for originObj in originObjects do
        (
            originSuffix = substring originObj.name (originPrefix.text.count + 1) (originObj.name.count - 1)
            index = findItem O originSuffix

            if index > 0 then
            (
                for refObj in refObjects do
                (
                    posController = refObj.position.controller
                    newPositionConstraint = Position_Constraint()
                    newPositionConstraint.appendTarget originObj 50.0
                    refObj.position.controller = newPositionConstraint

                    orientController = refObj.rotation.controller
                    newOrientationConstraint = Orientation_Constraint()
                    newOrientationConstraint.appendTarget originObj 50.0
                    refObj.rotation.controller = newOrientationConstraint
                )
            )
        )
    )
)

createDialog constraintManager
