----------------------------------------------------------------------------------------
-- Script Name:		JJTools2013_BipedPivotPoints.mcr
-- Compatible:		Max 5, 6, 7, 8, 9, 2008, 2009, 2010, 2011, 2012 and 2013
-- Requirements:	Character Studio
-- Version:			v3.1
-- Started:      	25 May 2004
-- Last Modified: 	8 May 2012
-- Code by:			Jim Jagger jimjagger@gmail.com
-- 					www.JimJagger.com
-- Based on an idea by Carl Boulay
----------------------------------------------------------------------------------------
-- v1.0  -- 2004.05.25 -- First release
-- v1.1  -- 2005.11.10 -- Added support for Max 8
-- v1.2  -- 2007.08.19 -- Added support for Max 9
-- v1.3 -- 2007.12.01 -- Added support for Max 2008
-- v1.4 -- 2008.06.01 -- Added support for Max 2009
-- v1.5 -- 2009.05.30 -- Added support for Max 2011
-- v3.0 -- 2011.12.29 -- Added support for Max 2012
-- v3.1 -- 2012.05.08 -- Added support for Max 2013
----------------------------------------------------------------------------------------

macroScript JJTools2013_BipedPivotPoints
category:"JJTools 2013"
Buttontext:"Bip Pivots"
tooltip:"Toggle Biped Pivot Points"
icon:#("JJTools", 22)

(
----------
--CONFIG--
----------
--PivotNumber settings:
--		1 == Ankle
--		3 == MidHeel
--		6 == MidToeBase
--		8 == ToeTip

	global bipedPivot_state
	
	if bipedPivot_state == undefined then (bipedPivot_state = 1)

	fn BipedPivot PivotNumber =
	(
		TheKeyIndex = getKeyIndex ($.controller) currentTime
		if TheKeyIndex != 0 then
		(
			TheKey = biped.getKey $.controller TheKeyIndex
			TheKey.ikPivotIndex = PivotNumber
		)
	)--end script
	
	on isEnabled return (selection.count == 1 and iskindof $ biped_object and (((biped.getIDLink $).x == 5) or ((biped.getIDLink $).x == 6) or ((biped.getIDLink $).x == 1) or ((biped.getIDLink $).x == 2) or ((biped.getIDLink $).x == 3) or ((biped.getIDLink $).x == 4) or ((biped.getIDLink $).x == 7) or ((biped.getIDLink $).x == 8)))
	on Execute do
	(
		case of
		(
			(bipedPivot_state == 1): (
										bipedPivot(bipedPivot_state)
									  	bipedPivot_state = 3
										format "Ankle\n"
							     	 )
									 
			(bipedPivot_state == 3): (
										bipedPivot(bipedPivot_state)
							      	  	bipedPivot_state = 6
										format "Heel\n"
							      	 )
									 
			(bipedPivot_state == 6): (
										bipedPivot(bipedPivot_state)
							      	  	bipedPivot_state = 8
										format "ToeBase\n"
							      	 )
									 
			(bipedPivot_state == 8): (
										bipedPivot(bipedPivot_state)
							      	    bipedPivot_state = 1
										format "ToeTip\n"
							      	 )
		)					   
	)	
)