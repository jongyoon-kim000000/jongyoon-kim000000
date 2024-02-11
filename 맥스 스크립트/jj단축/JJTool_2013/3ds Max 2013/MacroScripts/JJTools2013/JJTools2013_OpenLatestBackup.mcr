----------------------------------------------------------------------------------------
-- Script Name:		JJTools2013_OpenLatestBackup.mcr
-- Compatible:		Max 5, 6, 7, 8, 9, 2008, 2009, 2010, 2011, 2012 and 2013
-- Version:			v3.1
-- Started:      	4 April 2002
-- Last Modified: 	8 May 2012
-- Code by:			Johnny Yuen Ow
--				Jim Jagger
-- Modified by:     Jim Jagger jimjagger@gmail.com
-- Web site:		www.JimJagger.com
----------------------------------------------------------------------------------------
-- v1.0  -- 2002.04.04 -- First release
-- v1.2  -- 2005.11.10 -- Added support for Max 8
-- v1.3  -- 2007.08.19 -- Added support for Max 9
-- v1.4 -- 2007.12.01 -- Added support for Max 2008
-- v1.5 -- 2008.06.01 -- Added support for Max 2009
-- v1.5 -- 2009.05.30 -- Added support for Max 2011
-- v3.0 -- 2011.12.29 -- Added support for Max 2012
-- v3.1 -- 2012.05.08 -- Added support for Max 2013
----------------------------------------------------------------------------------------

macroscript JJTools2013_OpenLatestBackup
category:"JJTools 2013"
tooltip:"Open Latest Backup"
buttontext:"Load Bak"
icon:#("JJTools", 26)

(
	-- Gets a list of files in the backup folder.
	local fileList = getFiles ((getDir #autoback) + "\*.m*x")
	-- Gets the file dates and filters them.
	local fileDate = for i in fileList collect (getFileModDate i)
	
	for i = 1 to fileDate.count  do
	(
		j = filterString fileDate[i] "/ :"
		-- Format the resulting strings and then recombine in order.
		-- Makes certain assumptions about the date format.
		if j.count != 7 do
		(
			messageBox "Unable to get file date."
			return FALSE
		)
		if j[1].count == 1 do (j[1] = "0" + j[1])
		if j[2].count == 1 do (j[2] = "0" + j[2])
		if j[7] == "PM" do (j[4]= ((j[4] as INTEGER) + 12) as STRING)
		if j[4].count == 1 do (j[4]= "0" + j[4])
		fileDate[i]= j[3]+j[1]+j[2]+j[4]+j[5]+j[6]
	)
	
	-- Find the index of the latest file.
	latest_file = fileList[findItem fileDate (amax fileDate)]
	if (loadMaxFile latest_file) == FALSE do 
	(
		messageBox ("Error opening " + latest_file) title:"Open Last Backup File"
	)
)
