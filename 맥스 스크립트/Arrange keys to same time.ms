macroscript ArrangeKeysToSameTime category:"Custom_Script" tooltip:"Arrange keys to same time"
(
	undo on
		(
			Sel = selection as array
			
			for i = 2 to Sel.count do
				(
					for t = AnimationRange.Start to AnimationRange.End do
						(
							if selection[1] == $Bip001 then
							(
								if (getkeyindex selection[1].controller.horizontal.controller t) != 0 or (getkeyindex selection[1].controller.vertical.controller t) != 0 or (getkeyindex selection[1].controller.turning.controller t) != 0 then
								(
									AddNewKey selection[i].controller t
								)
								else if (getkeyindex selection[1].controller.horizontal.controller t) == 0 and (getkeyindex selection[1].controller.vertical.controller t) == 0 and (getkeyindex selection[1].controller.turning.controller t) == 0 do
								(
									selectkeys selection[i].controller t
									deletekeys selection[i].controller #selection
								)
							)
							else
							(
								k = getkeyindex selection[1].controller t
								if k != 0 do AddNewKey selection[i].controller t
								if k == 0 do selectkeys selection[i].controller t
								deletekeys selection[i].controller #selection
							)
						)
				)
		)
)