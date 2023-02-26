----------------------------------------------------------------------------------------
-- Script Name:		JJTools2013_ToggleEdgeFaces.mcr
-- Compatible:		Max 5, 6, 7, 8, 9, 2008, 2009, 2010, 2011, 2012 and 2013
-- Version:			v3.1
-- Started:      	18 August 2004
-- Last Modified: 	8 May 2012
-- Code by:			Jim Jagger jimjagger@gmail.com
-- 					www.JimJagger.com
----------------------------------------------------------------------------------------
-- v1.0  -- 2004.18.08 -- First release
-- v1.1  -- 2005.11.10 -- Added support for Max 8
-- v1.2 -- 2007.08.19 -- Added support for Max 9
-- v1.3 -- 2007.12.01 -- Added support for Max 2008
-- v1.4 -- 2008.06.01 -- Added support for Max 2009
-- v1.5 -- 2009.05.30 -- Added support for Max 2011
-- v3.0 -- 2011.12.29 -- Added support for Max 2012
-- v3.1 -- 2012.05.08 -- Added support for Max 2013
----------------------------------------------------------------------------------------

macroscript JJTools2013_ToggleEdgeFaces
category:"JJTools 2013"
tooltip:"Toggle Edge Faces"
buttontext:"Tog Edge Faces"
icon:#("JJTools", 18)

(
	on isEnabled return (selection.count >= 1)
	on Execute do
	(
		try
		(
			--loop through selected objects and set pivot point to object's centre
			for i in selection do 
			(
				if i.alledges == on then
				(
					i.alledges = off
				)
				else
				(
					i.alledges = on
				) 
			)
		)
		catch
		(
			messageBox "The object's edge faces could not be toggled" title:"JJTools Error" beep:true
		)
	)
)


