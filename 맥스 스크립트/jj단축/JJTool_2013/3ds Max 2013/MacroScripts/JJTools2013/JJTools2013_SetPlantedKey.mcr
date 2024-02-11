----------------------------------------------------------------------------------------
-- Script Name:		JJTools2013_SetPlantedKey.mcr
-- Compatible:		Max 5, 6, 7, 8, 9, 2008, 2009, 2010, 2011, 2012 and 2013
-- Requirements:	Character Studio
-- Version:			v3.1
-- Started:      	25 April 2005
-- Last Modified: 	2 June 2008
-- Code by:			Cameron Fielding and Jim Jagger jimjagger@gmail.com
-- 					www.JimJagger.com
----------------------------------------------------------------------------------------
-- v1.0  -- 2005.04.25 -- First release
-- v1.2  -- 2005.11.10 -- Added support for Max 8
-- v1.3  -- 2007.08.19 -- Added support for Max 9
-- v1.4 -- 2007.12.01 -- Added support for Max 2008
-- v1.5 -- 2008.06.01 -- Added support for Max 2009
-- v1.5 -- 2009.05.30 -- Added support for Max 2011
-- v3.0 -- 2011.12.29 -- Added support for Max 2012
-- v3.1 -- 2012.05.08 -- Added support for Max 2013
----------------------------------------------------------------------------------------

macroScript JJTools2013_SetPlantedKey
category:"JJTools 2013" 
toolTip:"Set Planted Key" 
buttontext:"Plabted Key" 
icon:#("JJTools", 8)

(
	if selection.count > 0 then
	(
		for i = 1 to selection.count do
		(
			try
			(
				biped.setPlantedKey selection[i]
			)
			catch()
			
			try
			(
				biped.setPlantedKey selection[i] true true true
			)	
			catch()	 
		)
	)
)

