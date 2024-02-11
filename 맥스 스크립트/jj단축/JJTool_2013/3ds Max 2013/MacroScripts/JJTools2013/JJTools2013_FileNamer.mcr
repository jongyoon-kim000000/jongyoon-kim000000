----------------------------------------------------------------------------------------
-- Script Name:		JJTools2013_FileNamer.mcr
-- Compatible:		Max 5, 6, 7, 8, 9, 2008, 2009, 2010, 2011, 2012 and 2013
-- Version:			v3.1
-- Started:      	7 December 2004
-- Last Modified: 	8 May 2012
-- Code by:			Carl Boulay
--				Jim Jagger
-- Modified by:		Jim Jagger jimjagger@gmail.com
-- 					www.JimJagger.com
----------------------------------------------------------------------------------------
-- v1.0  -- 2004.12.07 -- First release from Carl
-- v1.1  -- 2005.11.10 -- Added support for Max 8
-- v1.2  -- 2007.08.19 -- Added support for Max 9
-- v1.3 -- 2007.12.01 -- Added support for Max 2008
-- v1.4 -- 2008.06.01 -- Added support for Max 2009
-- v1.5 -- 2009.05.30 -- Added support for Max 2011
-- v3.0 -- 2011.12.29 -- Added support for Max 2012
-- v3.1 -- 2012.05.08 -- Added support for Max 2013
----------------------------------------------------------------------------------------

macroscript JJTools2013_FileNamer
category:"JJTools 2013"
tooltip:"File Namer"
buttontext:"File Namer"
icon:#("JJTools", 14)

(
	if $'JJTools_Filename' != undefined then
	(
		delete $'JJTools_Filename'
	)
	
	TheText = (maxFileName as string)
	AnimStart = (animationRange.start.frame as integer) as string
	AnimEnd = (animationRange.end.frame as integer) as string
	TheText += " = "+AnimStart+"-"+AnimEnd
	TheObject = text name:"JJTools_Filename" text:TheText size:25 wireColor:(color 88 199 225)
	rotate TheObject (eulerangles 90 0 0)
	TheObject.center = [0,0,-120]
	addModifier TheObject (Edit_Mesh())
	freeze TheObject
)