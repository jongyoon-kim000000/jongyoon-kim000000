----------------------------------------------------------------------------------------
-- Script Name:		JJTools2013_QuickAlign.mcr
-- Compatible:		Max 5, 6, 7, 8, 9, 2008, 2009, 2010, 2011, 2012 and 2013
-- Version:			v3.1
-- Started:      	13 June 2001
-- Last Modified: 	8 May 2012
-- Code by:			Jim Jagger jimjagger@gmail.com
-- 					www.JimJagger.com
----------------------------------------------------------------------------------------
-- v2.0  -- 2001.06.13 -- Second release
-- v2.1  -- 2005.11.10 -- Added support for Max 8
-- v2.2  -- 2007.08.19 -- Added support for Max 9
-- v2.3 -- 2007.12.01 -- Added support for Max 2008
-- v2.4 -- 2008.06.01 -- Added support for Max 2009
-- v2.5 -- 2009.05.30 -- Added support for Max 2011
-- v3.0 -- 2011.12.29 -- Added support for Max 2012
-- v3.1 -- 2012.05.08 -- Added support for Max 2013
----------------------------------------------------------------------------------------

macroScript JJTools2013_QuickAlign
category:"JJTools 2013" 
toolTip:"Qucik Align" 
buttontext:"Quick Align"
icon:#("JJTools", 39)

(
	on isEnabled return (selection.count > 0)
	on Execute do
	(
		try(
		Toolmode.coordsys #local

		selectedobj = selection as array
		targetobj = pickobject()
		selectedobj.rotation = targetobj.rotation
		selectedobj.pos = targetobj.transform.position
		)catch()
	)
)

