----------------------------------------------------------------------------------------
-- Script Name:		JJTools2013_AffectPivot.mcr
-- Compatible:		Max 5, 6, 7, 8, 9, 2008, 2009, 2010, 2011, 2012 and 2013
-- Version:			v3.1
-- Started:      	26 October 2004
-- Last Modified: 	8 May 2012
-- Code by:			Jim Jagger jimjagger@gmail.com
-- 					www.JimJagger.com
----------------------------------------------------------------------------------------
-- v1.0  -- 2004.10.26 -- First release
-- v1.1  -- 2005.11.10 -- Added support for Max 8
-- v1.2  -- 2007.08.19 -- Added support for Max 9
-- v1.3 -- 2007.12.01 -- Added support for Max 2008
-- v1.3 -- 2008.06.01 -- Added support for Max 2009
-- v1.4 -- 2009.05.30 -- Added support for Max 2011
-- v3.0 -- 2011.12.29 -- Added support for Max 2012
-- v3.1 -- 2012.05.08 -- Added support for Max 2013
----------------------------------------------------------------------------------------

macroScript JJTools2013_AffectPivot
category:"JJTools 2013"
toolTip:"Affect Pivot"
buttontext:"Affect Pivot"
icon:#("JJTools", 73)

(
	Try
	(
		jj_point = pickpoint prompt:"Click to select new pivot position."
		$.pivot = jj_point
	)
	catch()
)