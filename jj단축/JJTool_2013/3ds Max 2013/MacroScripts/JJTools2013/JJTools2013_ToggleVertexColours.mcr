----------------------------------------------------------------------------------------
-- Script Name:		JJTools2013_ToggleVertexColours.mcr
-- Compatible:		Max 5, 6, 7, 8, 9, 2008, 2009, 2010, 2011, 2012 and 2013
-- Version:			v3.1
-- Started:      	13 June 2001
-- Last Modified: 	8 May 2012
-- Code by:			Jim Jagger jimjagger@gmail.com
-- 					www.JimJagger.com
----------------------------------------------------------------------------------------
-- v2.0  -- 2001.06.32 -- Second release
-- v2.1  -- 2005.11.10 -- Added support for Max 8
-- v2.2  -- 2007.08.19 -- Added support for Max 9
-- v2.3 -- 2007.12.01 -- Added support for Max 2008
-- v2.4 -- 2008.06.01 -- Added support for Max 2009
-- v2.5 -- 2009.05.30 -- Added support for Max 2011
-- v3.0 -- 2011.12.29 -- Added support for Max 2012
-- v3.1 -- 2012.05.08 -- Added support for Max 2013
----------------------------------------------------------------------------------------

macroScript JJTools2013_ToggleVertexColors
category:"JJTools 2013"
toolTip:"Toggle Vertex Colours"
buttontext:"Vert Colours"
icon:#("JJTools", 58)

(
	on isEnabled return (selection.count >= 1)
	global gbVertexColorState
	
	on Execute do
	(
		--store the current global state of the vertex color toggle
		--if its already defined ( meaning you already used this script ) then
		--simply switch its state. If not call it true.
		if gbVertexColorState != UNDEFINED then gbVertexColorState = NOT gbVertexColorState
		else gbVertexColorState = TRUE
		
		--get current selection as array
		selArray = GetCurrentSelection()
		
		--loop through selected objects
		for obj in selArray do 
		(
			if obj != UNDEFINED do 
				(
					try ( obj.showVertexColors = gbVertexColorState )
					catch ( format "Unable to change vertex color toggle for some reason\n" 
				)
			)
		)
	)
)	

