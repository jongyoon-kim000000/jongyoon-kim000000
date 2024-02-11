----------------------------------------------------------------------------------------
-- Script Name:		JJTools2013_CentrePivot.mcr
-- Compatible:		Max 5, 6, 7, 8, 9, 2008, 2009, 2010, 2011, 2012 and 2013
-- Version:			v3.1
-- Started:      	18 May 2004
-- Last Modified: 	8 May 2012
-- Code by:			Jim Jagger jimjagger@gmail.com
-- 					www.JimJagger.com
----------------------------------------------------------------------------------------
-- v2.1  -- 2004.06.02 -- Re-release
-- v2.2  -- 2005.11.10 -- Added support for Max 8
-- v2.3  -- 2007.08.19 -- Added support for Max 9
-- v2.4 -- 2007.12.01 -- Added support for Max 2008
-- v2.5 -- 2008.06.01 -- Added support for Max 2009
-- v2.5 -- 2009.05.30 -- Added support for Max 2011
-- v3.0 -- 2011.12.29 -- Added support for Max 2012
-- v3.1 -- 2012.05.08 -- Added support for Max 2013
----------------------------------------------------------------------------------------

macroscript JJTools2013_CentrePivot
category:"JJTools 2013"
tooltip:"Centre pivot of selected objects"
buttontext:"Centre Pivot"
icon:#("JJTools", 18)

(
	on isEnabled return (selection.count >= 1)
	on Execute do
	(
		try
		(
			--loop through selected objects and set pivot point to object's centre
			for i in selection do (i.pivot = i.min)
		)
		catch
		(
			messageBox "The object's pivot point could not be centered!" title:"JJTools Error" beep:true
		)
	)
)


