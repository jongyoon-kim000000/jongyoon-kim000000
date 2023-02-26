----------------------------------------------------------------------------------------
-- Script Name:		JJTools2013_HideUnhideBiped.mcr
-- Compatible:		Max 5, 6, 7, 8, 9, 2008, 2009, 2010, 2011, 2012 and 2013
-- Requirements:	Character Studio
--					JJTools2013_Functions
-- Version:			v3.1
-- Started:      	12 May 2004
-- Last Modified: 	8 May 2012
-- Code by:			Jim Jagger jimjagger@gmail.com
-- 					www.JimJagger.com
----------------------------------------------------------------------------------------
-- v1.0  -- 2004.05.12 -- First release
-- v1.1  -- 2005.11.10 -- Added support for Max 8
-- v1.2  -- 2007.08.19 -- Added support for Max 9
-- v1.3 -- 2007.12.01 -- Added support for Max 2008
-- v1.4 -- 2008.06.01 -- Added support for Max 2009
-- v1.5 -- 2009.05.30 -- Added support for Max 2009
-- v3.0 -- 2011.12.29 -- Added support for Max 2012
-- v3.1 -- 2012.05.08 -- Added support for Max 2013
----------------------------------------------------------------------------------------

macroScript JJTools2013_HideBiped
category:"JJTools 2013"
toolTip:"Hide Biped"
buttontext:"Hide Bip"
icon:#("JJTools", 73)

(
	bip_bones = getAllBipBones()
	hide bip_bones
)

macroScript JJTools2013_UnhideBiped
category:"JJTools 2013"
toolTip:"Unhide Biped"
buttontext:"Unhide Bip"
icon:#("JJTools", 73)

(
	bip_bones = getAllBipBones()
	unhide bip_bones
)
