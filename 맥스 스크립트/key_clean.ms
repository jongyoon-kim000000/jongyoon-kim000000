
(


fn delCKey =
(
	for obj in selection do
	(
	
			
			con = obj.controller
			try(
				com_con =obj.transform.controller
			)
			catch()
			
			
			selectkeys con
			deselectKeys con animationRange

				if classof con == BipSlave_Control do
				(
					
					biped.deleteKeys con #selection

				)
				
				
				if (classof obj) != Biped_Object do
				(

						deleteKeys con #selection
				)

				if classof obj.controller == Vertical_Horizontal_Turn do
				(
							 biped.deleteKeys com_con.vertical.controller #selection
							 biped.deleteKeys com_con.horizontal.controller #selection
							 biped.deleteKeys com_con.turning.controller #selection
				)
			
			selectkeys con
		
	
	)

)

	if $ !=undefined do
	(
		delCKey()
	)
)
