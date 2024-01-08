/*
만든이 : 릴종윤
https://blog.naver.com/trueb000
수정배포 자유롭게 하셔도 됩니다.
*/
rollout addPrefixRollout "OBJ prefix" 
(
    edittext prefixEditText "HEAD:" text:"Origin_" fieldWidth:80
    button addPrefixButton "generate"
    
    on addPrefixButton pressed do
    (
        local prefix = prefixEditText.text
        if selection.count > 0 then
        (
            for obj in selection do
            (
                obj.name = prefix + obj.name
            )
            messagebox ("success")
        )
        else
        (
            messagebox "NONE SELECTED." title:"warnning"
        )
    )
)

createDialog addPrefixRollout 150 60