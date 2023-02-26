macroScript BoneToggle category:"EMP"
(
	on execute do
		(
		case of
			(
				(hideByCategory.bones == true): (hideByCategory.bones = false)
				(hideByCategory.bones == false): (hideByCategory.bones = true)
			)	
		)	
)