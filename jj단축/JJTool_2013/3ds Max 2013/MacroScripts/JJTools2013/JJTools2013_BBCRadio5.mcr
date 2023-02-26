----------------------------------------------------------------------------------------
-- Script Name:		JJTools2013_BBCRadio5.mcr
-- Compatible:		Max 5, 6, 7, 8, 9, 2008, 2009, 2010, 2011, 2012 and 2013
-- Version:			v3.1
-- Started:      	4 June 2004
-- Last Modified: 	8 May 2012
-- Code by:			Jim Jagger jimjagger@gmail.com
-- 					www.JimJagger.com
----------------------------------------------------------------------------------------
-- 1.0  -- 2004.06.04 -- First release
-- 1.1  -- 2005.11.10 -- Added support for Max 8
-- 1.2  -- 2007.08.19 -- Added support for Max 9
-- 1.3 -- 2007.12.01 -- Added support for Max 2008
-- 1.4 -- 2008.06.01 -- Added support for Max 2009
-- 1.4 -- 2009.05.30 -- Added support for Max 2011
-- v3.0 -- 2011.12.29 -- Added support for Max 2012
-- v3.1 -- 2012.05.08 -- Added support for Max 2013
----------------------------------------------------------------------------------------

macroscript JJTools2013_BBCRadio5
category:"JJTools 2013"
tooltip:"BBC Radio 5"
buttontext:"Radio 5"
icon:#("JJTools", 38)

(
	global ActiveX_floater
	global ActiveX_floater_pos = [407,77]
	
	rollout AX1_cont "Football Commentary"
	(
		activeXControl ax1 "http://www.bbc.co.uk/radio/aod/fivelive.shtml?listen" height:359 width:662 align:#center
	)
	
	rollout AX2_about "About"
	(
		activeXControl ax2 "http://jimjagger.com/JPages/JJTools/JJTools2013_BBCRadio5.htm" height:75 width:130 align:#center 
	)
			
	try
	(
		closerolloutfloater ActiveX_floater
		ax_pos = ax_floater.pos
	)
	catch()
	
	ActiveX_floater = newrolloutfloater "BBC Radio 5" 700 425
	ActiveX_floater.pos = ActiveX_floater_pos
	addrollout AX1_cont ActiveX_floater rolledup:false
	addrollout AX2_about ActiveX_floater rolledup:true
)

