----------------------------------------------------------------------------------------
-- Script Name:		JJTools2013_CameraOrbit.mcr
-- Compatible:		Max 5, 6, 7, 8, 9, 2008, 2009, 2010, 2011, 2012 and 2013
-- Version:			v3.1
-- Started:      	25 February 2005
-- Last Modified: 	8 May 2012
-- Code by:			Jim Jagger jimjagger@gmail.com
-- 					www.JimJagger.com
----------------------------------------------------------------------------------------
-- v1.0 -- 2005.02.25 -- First release
-- v1.1 -- 2005.11.10 -- Added support for Max 8
-- v1.2 -- 2007.08.19 -- Added support for Max 9
-- v1.3 -- 2007.12.01 -- Added support for Max 2008
-- v1.4 -- 2008.06.01 -- Added support for Max 2009
-- v1.5 -- 2009.05.30 -- Added support for Max 2011
-- v3.0 -- 2011.12.29 -- Added support for Max 2012
-- v3.1 -- 2012.05.08 -- Added support for Max 2013
----------------------------------------------------------------------------------------

macroscript JJTools2013_CameraOrbit
category:"JJTools 2013"
tooltip:"Camera Orbit"
buttontext:"Camera Orbit"
icon:#("JJTools", 10)

(
	global CR_floater
	global CR_pos = [407,77]
	global jcam
	global jcamorbit
	global jobjSize
	
	rollout CR_cont "Camera Orbit V1.1"
	(
		local astart = animationrange.start,
			  aend = animationrange.end

		group "Frame Range"
		(
			radiobuttons useTimeRange labels:#("Active Range", "Set Range") align:#center default:1
			spinner sframe "Start Time" range:[-1000000,1000000,astart] type:#integer fieldwidth:50 align:#center enabled:false
			spinner eframe "End Time" range:[-1000000,1000000,aend] type:#integer fieldwidth:50 align:#center enabled:false
		)
		
		group "Extended Options"
		(	
			checkbox CamDir "Clockwise" align:#center checked:true
		)
	
		group "Initialise"
		(
			button InitCam "Create Camera" align:#center
			button DeleteCam "Delete Camera" align:#center
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
				astart = animationrange.start
				aend = animationrange.end
			)
		)
		
		on eframe changed val do
		(
			strt = sframe.value
			
		    if val > strt then
			(
				animationRange = interval sframe.value val
			)
			else
			(
				sframe.value = val
			)
		)
		
		on sframe changed val do
		(
			nd = eframe.value
			
	    	if val < nd then
		 	(
				animationRange = interval val eframe.value
		 	)
			else
			(
				eframe.value = val
			)
		)
		
		on InitCam pressed do
		(
			if $ == undefined then
			(
				messagebox "No object selected"
			)
			else
			(
				try
				(
					delete jcamOrbit
					delete jcam
				)catch()
				
				-- frame object
				objL = $.max.x - $.min.x
				objW  = $.max.y - $.min.y
				objH  = $.max.z - $.min.z
				
				if objL > objW AND objL > objH then 
				(
					jobjSize = objL
				)
				else if objW > objH then
				(
					jobjSize = objW
				)
				else
				(
					jobjSize = objH
				)				
				
				jcamOrbit = Circle radius:(jobjSize*3.14) pos:$.center
				jcamtarget = $.center
				jcam = Targetcamera pos:[100,0,0] target:(Targetobject transform:(matrix3 [1,0,0] [0,1,0] [0,0,1] jcamtarget))
				jcam.pos.controller = path_constraint()
				jcam.pos.controller.path = jcamOrbit
				
				hide jcamOrbit
				
				animate on
				(
					if camDir.checked == false then
					(
						at time sframe.value jcam.pos.controller.percent = 0
						at time eframe.value jcam.pos.controller.percent = 100
					)
					else
					(
						at time sframe.value jcam.pos.controller.percent = 100
						at time eframe.value jcam.pos.controller.percent = 0
					)
				)					
			)
		)
		
		on deleteCam pressed do
		(
			try
			(
				delete jcamOrbit
				delete jcam
			)
			catch()
		)
	)
	
	rollout CR_about "About"
	(
		activeXControl ax1 "http://jimjagger.com/JPages/JJTools/JJTools2013_CameraOrbit.htm" height:75 width:130 align:#center 
	)
			
	try
	(
		closerolloutfloater cr_floater
		cr_pos = cr_floater.pos
	)catch()
	cr_floater = newrolloutfloater "Animation Controller 1.0" 170 285
	cr_floater.pos = cr_pos
	addrollout cr_cont cr_floater rolledup:false
	addrollout cr_about cr_floater rolledup:true
)

