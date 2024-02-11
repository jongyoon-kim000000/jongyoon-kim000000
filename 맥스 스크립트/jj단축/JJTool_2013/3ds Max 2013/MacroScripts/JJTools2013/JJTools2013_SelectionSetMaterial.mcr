----------------------------------------------------------------------------------------
-- Script Name:		JJTools2013_SelectionSetMaterial.mcr
-- Compatible:		Max 5, 6, 7, 8, 9, 2008, 2009, 2010, 2011, 2012 and 2013
-- Version:			v3.1
-- Started:      	13 June 2001
-- Last Modified: 	8 May 2012
-- Code by:			Jim Jagger jimjagger@gmail.com
-- 					www.JimJagger.com
----------------------------------------------------------------------------------------
-- v2.0  -- 2004.06.02 -- Re-release
-- v2.1  -- 2005.11.10 -- Added support for Max 8
-- v2.2  -- 2007.08.19 -- Added support for Max 9
-- v2.3 -- 2007.12.01 -- Added support for Max 2008
-- v2.4 -- 2008.06.01 -- Added support for Max 2009
-- v2.5 -- 2009.05.30 -- Added support for Max 2011
-- v3.0 -- 2011.12.29 -- Added support for Max 2012
-- v3.1 -- 2012.05.08 -- Added support for Max 2013
----------------------------------------------------------------------------------------

macroscript JJTools2013_SelectionSetMaterial
category:"JJTools 2013"
toolTip:"Organise Material Selection Sets"
buttontext:"Material Set"
icon:#("JJTools", 35)
(	
	fn reset_selection_sets =
	(
		try
		(
			for i = 1 to 50 do
			(
				deleteItem selectionSets 1
				i += 1
			)
		)
		catch()
	)	
	
	fn init_material_selection_sets =
	(		
		for m in sceneMaterials do
		(
			collect_objects = #()
				
			for i in Geometry do
			(
				if i.material == m then
				(
					append collect_objects i
				)
			)
			selectionSets["!Material: "+m.name] = collect_objects
		)
	)
	
	max unhide all
	init_material_selection_sets()
)

