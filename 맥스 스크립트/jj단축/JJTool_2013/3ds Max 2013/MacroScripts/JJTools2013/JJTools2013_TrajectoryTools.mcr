----------------------------------------------------------------------------------------
-- Script Name:		JJTools2013_TrajectoryTools.mcr
-- Compatible:		Max 5, 6, 7, 8, 9, 2008, 2009, 2010, 2011, 2012 and 2013
-- Version:			v3.1
-- Started:      	17 May 2004
-- Last Modified: 	8 May 2012
-- Code by:			Jim Jagger jimjagger@gmail.com
-- 					www.JimJagger.com
----------------------------------------------------------------------------------------
-- v1.0  -- 2004.05.17 -- First release
-- v1.1  -- 2004.06.04 -- Included support for biped
-- v1.2  -- 2004.10.29 -- Fixed bug with trajectories not turning off on biped
-- v1.3  -- 2005.11.10 -- Added support for Max 8
-- v1.4  -- 2007.08.19 -- Added support for Max 9
-- v1.5 -- 2007.12.01 -- Added support for Max 2008
-- v1.6 -- 2008.06.01 -- Added support for Max 2009
-- v1.7 -- 2009.05.30 -- Added support for Max 2011
-- v3.0 -- 2011.12.29 -- Added support for Max 2012
-- v3.1 -- 2012.05.08 -- Added support for Max 2013
----------------------------------------------------------------------------------------

macroScript JJTools2013_HideAllTrajectories
category:"JJTools 2013"
toolTip:"Hide All Trajectories"
buttontext:"Hide Traj"
icon:#("JJTools", 73)

(
	for obj in objects do
	(
		settrajectoryon obj false	

		if iskindof obj biped_object then
		(
			(obj.controller.rootnode).controller.displaytrajectories = false
		)
	)
)

macroScript JJTools2013_ToggleTrajectories
category:"JJTools 2013"
toolTip:"Toggle Trajectories"
buttontext:"Toggle Traj"
icon:#("JJTools", 73)

(	
	on isEnabled return (selection.count > 0)
	on execute do
	(
		for obj in selection do
		(
			if iskindof obj Biped_Object then
			(
				(obj.controller.rootnode).controller.displaytrajectories = not((obj.controller.rootnode).controller.displayTrajectories)
			)
			else if (iskindof obj biped_object == false) then
			(
				settrajectoryon obj (not(getTrajectoryOn obj))
			)
		)
	)
)



