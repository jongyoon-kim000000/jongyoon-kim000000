----------------------------------------------------------------------------------------
-- Script Name:		JJTools2013_CleverScale.mcr
-- Compatible:		Max 5, 6, 7, 8, 9, 2008, 2009, 2010, 2011, 2012 and 2013
-- Version:			v3.1
-- Started:      	4 January 2005
-- Last Modified: 	8 May 2012
-- Code by:			Jim Jagger jimjagger@gmail.com
-- 					www.JimJagger.com
----------------------------------------------------------------------------------------
-- v1.0 -- 2005.01.04 -- First release
-- v1.1 -- 2005.11.10 -- Added support for Max 8
-- v1.2 -- 2007.08.19 -- Added support for Max 9
-- v1.3 -- 2007.12.01 -- Added support for Max 2008
-- v1.4 -- 2008.06.01 -- Added support for Max 2009
-- v1.5 -- 2009.05.30 -- Added support for Max 2011
-- v3.0 -- 2011.12.29 -- Added support for Max 2012
-- v3.1 -- 2012.05.08 -- Added support for Max 2013
----------------------------------------------------------------------------------------

macroScript JJTools2013_CleverScale
category:"JJTools 2013"
Buttontext:"Clever Scale"
tooltip:"Clever Scale"
icon:#("JJTools", 20)

(
	global scale_state = 1
	
	on execute do
	(
		case of
		(
			(scale_state == 1): (toolmode.coordsys #view
							      scale_state = 2
							      max scale)
			(scale_state == 2): (toolmode.coordsys #local
							      scale_state = 1
							      max scale)
		)					   
	)	
)
