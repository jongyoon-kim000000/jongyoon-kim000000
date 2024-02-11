----------------------------------------------------------------------------------------
-- Script Name:		JJTools2013_ReOpenLastFile.mcr
-- Compatible:		Max 5, 6, 7, 8, 9, 2008, 2009, 2010, 2011, 2012 and 2013
-- Version:			v3.1
-- Started:      	05 November 2002
-- Last Modified: 	8 May 2012
-- Code by:			Jim Jagger jimjagger@gmail.com
-- 					www.JimJagger.com
-- Thanks to Erik Bakker for fixing a bug
----------------------------------------------------------------------------------------
-- v1.0  -- 2002.11.05 -- First release
-- v1.1  -- 2004.06.06 -- Made more generic by using 'getdir' instead of an absolute path
-- v1.2  -- 2004.10.29 -- Now supports Max 7 by searching for FileList before File1
-- v1.3  -- 2005.11.10 -- Added support for Max 8
-- v1.4  -- 2007.08.19 -- Added support for Max 9
-- v1.5 -- 2007.12.01 -- Added support for Max 2008
-- v1.6 -- 2008.06.01 -- Added support for Max 2009
-- v1.7 -- 2009.14.02 -- Fixed bug thanks to Erik Bakker
-- v1.8 -- 2009.05.30 -- Added support for Max 2011
-- v3.0 -- 2011.12.29 -- Added support for Max 2012
-- v3.1 -- 2012.05.08 -- Added support for Max 2013
----------------------------------------------------------------------------------------

macroScript JJTools2013_ReOpenLastFile
category:"JJTools 2013"
toolTip:"Open Recent File 1"
buttontext:"Open File 1"
icon:#("JJTools", 42)

(
	-- loads the most recent file, .max or .mx
	jroot = getMAXIniFile()
	inifile = openfile jroot
	skiptostring inifile "FileList"
	skiptostring inifile "File1="
	lastfilename = readline inifile
	if loadMaxfile lastfilename then
	(
	)
	else
	(
		messagebox ("Problem opening File: " + lastfilename)
	)
)


macroScript JJTools2013_ReOpenRecentFile2
category:"JJTools 2013"
toolTip:"Open Recent File 2"
buttontext:"Open File 2"
icon:#("JJTools", 33)

(
	-- loads the most recent file, .max or .mx
	jroot = getMAXIniFile()
	inifile = openfile jroot
	skiptostring inifile "FileList"
	skiptostring inifile "File2="
	lastfilename = readline inifile
	if loadMaxfile lastfilename then
	(
	)
	else
	(
		messagebox ("Problem opening File: " + lastfilename)
	)
)


macroScript JJTools2013_ReOpenRecentFile3
category:"JJTools 2013"
toolTip:"Open Recent File 3"
buttontext:"Open File 3"
icon:#("JJTools", 33)

(
	-- loads the most recent file, .max or .mx
	jroot = getMAXIniFile()
	inifile = openfile jroot
	skiptostring inifile "FileList"
	skiptostring inifile "File3="
	lastfilename = readline inifile
	if loadMaxfile lastfilename then
	(
	)
	else
	(
		messagebox ("Problem opening File: " + lastfilename)
	)
)
