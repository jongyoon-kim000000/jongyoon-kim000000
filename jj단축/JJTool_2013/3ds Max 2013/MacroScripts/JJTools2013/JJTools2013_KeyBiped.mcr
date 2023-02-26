----------------------------------------------------------------------------------------
-- Script Name:		JJTools2013_KeyBiped.mcr
-- Compatible:		Max 5, 6, 7, 8, 9, 2008, 2009, 2010, 2011, 2012 and 2013
-- Version:			v3.1
-- Started:      	18 August 2004
-- Last Modified: 	8 May 2012
-- Code by:			Jim Jagger jimjagger@gmail.com
-- 					www.JimJagger.com
----------------------------------------------------------------------------------------
-- v1.0  -- 2004.08.18 -- First release
-- v1.1  -- 2005.11.10 -- Added support for Max 8
-- v1.2  -- 2007.08.19 -- Added support for Max 9
-- v1.3 -- 2007.12.01 -- Added support for Max 2008
-- v1.4 -- 2008.06.01 -- Added support for Max 2009
-- v1.5 -- 2009.05.30 -- Added support for Max 2011
-- v3.0 -- 2011.12.29 -- Added support for Max 2012
-- v3.1 -- 2012.05.08 -- Added support for Max 2013
----------------------------------------------------------------------------------------

macroscript JJTools2013_KeyBiped
category:"JJTools 2013"
tooltip:"Key Biped"
buttontext:"Key Biped"
icon:#("JJTools", 16)

(
	global KB_floater
	global KB_pos = [407,77]
	
	rollout KB_cont "Key Biped V1"
	(
		local astart = animationrange.start,
			  aend = animationrange.end
			  
		group "Frame Range"
		(
			radiobuttons useTimeRange labels:#("Active Range", "Set Range") align:#center default:1
			spinner sframe "Start Time" range:[1,1000000,astart] type:#integer fieldwidth:50 align:#center enabled:false
			spinner eframe "End Time" range:[1,1000000,aend] type:#integer fieldwidth:50 align:#center enabled:false
		)

		group "Increments"
		(
			spinner stepCount "Step Count" range:[1,100,1] type:#integer fieldwidth:30 align:#center
		)
		
		group "Animate"
		(
			button AnimKey "Key" align:#center across:2
			button undo_btn "Fake Undo"
			progressbar AnimateAlign "AnimateAlign"
		)

		on useTimeRange changed state do
		(
			if useTimeRange.state == 2 then
			(
				sframe.enabled = true
				eframe.enabled = true
			)
			else
			(
				sframe.enabled = false
				eframe.enabled = false
			)
		)
		
		on startf changed val do
		(
			animationrange.start = val
		)
		
		on undo_btn pressed do
		(
			fetchmaxfile()
		)
		
		on AnimKey pressed do
		(

			if animationrange.start > animationrange.end then
			(
				messageBox "The end time is smaller than start time!\nPlease check your ranges" title:"JJTools Error" beep:true
			)
			else
			(
				undo "Biped Align" on
				(
					holdmaxfile()
					try
					(
						jcount = 0
						setwaitcursor()
						animVal=(((animationrange.end-animationrange.start) as float)/320)
						num = 100.0/(animVal/stepcount.value)
						slidertime = animationrange.start
						for i = animationrange.start to animationrange.end by stepcount.value do
						(
							jcount += 0.5
							animateAlign.value = (num*jcount)
							slidertime = i
		
							if selection.count != 0 AND (selection[1].controller.rootNode).controller.figuremode == false then
							(
								for obj in selection do
								(
									biped.setSelectedKey obj.controller
								)
							)
						)
						slidertime = animationrange.start
						for i = animationrange.start to animationrange.end by stepcount.value do
						(
							jcount += 0.5
							animateAlign.value = (num*jcount)
							slidertime = i
		
							if selection.count != 0 AND (selection[1].controller.rootNode).controller.figuremode == false then
							(
								for obj in selection do
								(
									biped.SetFreeKey obj
								)
							)
						)						
						animateAlign.value = 0
					)
					catch
					(
						messageBox "Animated Align Failed!" title:"JJTools Error" beep:true
					)
				)
			)
		)
	)
	
	rollout KB_about "About"
	(
		activeXControl ax1 "http://jimjagger.com/JPages/JJTools/JJTools2013_KeyBiped.htm" height:75 width:130 align:#center 
	)
			
	try
	(
		closerolloutfloater KB_floater
		KB_pos = KB_floater.pos
	)catch()
	KB_floater = newrolloutfloater "Biped Controller 1.0" 170 276
	KB_floater.pos = KB_pos
	addrollout KB_cont KB_floater rolledup:false
	addrollout KB_about KB_floater rolledup:true
)


