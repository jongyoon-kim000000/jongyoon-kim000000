macroScript BipLayerNextKeyFrame category:"Custom_Script" tooltip:"Bip Layer Go to Next Keyframe"
	(
		try(
			if $ != undefined and (classof $) == Biped_Object do
				(
					disableSceneRedraw()
					
					i = biped.getCurrentLayer $.controller
					biped.setCurrentLayer $.controller (i-1)
					SliderTime = (at time Slidertime Maxops.Trackbar.GetNextKeytime())
					
					biped.setCurrentLayer $.controller i
					EnableSceneRedraw()
					RedrawViews()
				)
			)
		catch(RedrawViews())
			
	)
	
	
macroScript BipLayerPreviousKeyFrame category:"Custom_Script" tooltip:"Bip Layer Go to Previous Keyframe"
	(
		try(
			if $ != undefined and (classof $) == Biped_Object do
				(
					disableSceneRedraw()
					
					i = biped.getCurrentLayer $.controller

					biped.setCurrentLayer $.controller (i-1)

					SliderTime = (at time Slidertime Maxops.Trackbar.GetPreviousKeytime())
						
					biped.setCurrentLayer $.controller i
					EnableSceneRedraw()
					RedrawViews()
				)
			)
		catch(RedrawViews())
	)