rollout addPrefixRollout "BONE NAME EDITING" (
    edittext prefixEditText "HEAD:" text:"Origin_" fieldWidth:150
    button addPrefixButton "GENERATE"
    
    on addPrefixButton pressed do
    (
        local prefix = prefixEditText.text
        if selection.count > 0 then
        (
            for obj in selection do
            (
                obj.name = prefix + obj.name
            )
            format "OK.\n" to:listener
        )
        else
        (
            messagebox "NONE SELECTED." title:"WARNINNING"
        )
    )
)

createDialog addPrefixRollout 200 80