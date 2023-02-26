----------------------------------------------------------------------------------------
-- Script Name:		JJTools2010_Functions.ms
-- Compatible:		Max 5, 6, 7, 8, 9, 2008, 2009, 2010, 2011 and 2012
-- Version:			v3.1
-- Started:      	18 June 2001
-- Last Modified: 	5 May 2012
-- Code by:			Jim Jagger jimjagger@gmail.com
-- 					www.JimJagger.com
----------------------------------------------------------------------------------------
-- v1.0 -- 2004.05.18 -- first release
-- v1.1 -- 2004.05.21 -- Added function to return all biped bones
-- v1.2 -- 2004.11.10 -- Added support for Max 8
-- v1.2 -- 2007.08.19 -- Added support for Max 9
-- v1.3 -- 2007.12.01 -- Added support for Max 2008
-- v1.4 -- 2009.05.30 -- Added support for Max 2009
-- v3.0 -- 2011.12.29 -- Added support for Max 2012
-- v3.1 -- 2012.05.08 -- Added support for Max 2013
----------------------------------------------------------------------------------------

-- function to return all biped roots in the current scene
fn getAllBips =
(
	allBips = #()
	for obj in geometry do
	(
		if classof obj.controller == Vertical_Horizontal_Turn then 
		(
			append allBips obj
		)
	)
	return allBips
)

-- function to return all biped bones in the current scene
fn getAllBipBones =
(
	allBips = #()
	for obj in geometry do
	(
		if classof obj == Biped_Object then 
		(
			append allBips obj
		)
	)
	return allBips
)

-- function to return the currently selected biped's root node
fn getBipRootNode obj1 =
(
	if classof obj1 == Biped_Object then
	(
		obj_root = obj1.controller.rootnode
		return obj_root
	)
	else
	(
		return obj1
	)
)