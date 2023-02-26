----------------------------------------------------------------------------------------
-- Script Name:		JJTools2013_RAMPreview.mcr
-- Compatible:		Max 5, 6, 7, 8, 9, 2008, 2009, 2010, 2011, 2012 and 2013
-- Version:			v3.1
-- Started:      	13 June 2001
-- Last Modified: 	8 May 2012
-- Code by:			Jim Jagger jimjagger@gmail.com
-- 					www.JimJagger.com
----------------------------------------------------------------------------------------
-- v2.0  -- 2001.06.13 -- Second release
-- v2.1  -- 2004.10.29 -- Fixed bug if no previews have ever been made
-- v2.2  -- 2005.11.10 -- Added support for Max 8
-- v2.3  -- 2007.08.19 -- Added support for Max 9
-- v2.4 -- 2007.12.01 -- Added support for Max 2008
-- v2.5 -- 2008.06.01 -- Added support for Max 2009
-- v2.6 -- 2009.05.30 -- Added support for Max 2011
-- v3.0 -- 2011.12.29 -- Added support for Max 2012
-- v3.1 -- 2012.05.08 -- Added support for Max 2013
----------------------------------------------------------------------------------------

macroScript JJTools2013_RamPreview
category:"JJTools 2013"
toolTip:"RAM Play Last Two Previews"
buttontext:"RAM Preview"
icon:#("JJTools", 40)

(
	deletefile ((getDir #preview)+ "\\_scene2.avi")
	copyfile  ((getDir #preview)+ "\\_scene.avi") ((getDir #preview)+ "\\_scene2.avi")
	max preview
	if (doesfileexist ((getDir #preview)+ "\\_scene2.avi")) == false then
	(
		RAMplayer ((getDir #preview)+ "\\_scene.avi") ""
	)
	else
	(
		RAMplayer ((getDir #preview)+ "\\_scene.avi") ((getDir #preview)+ "\\_scene2.avi")	
	)
)
