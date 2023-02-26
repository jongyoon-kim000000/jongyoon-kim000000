----------------------------------------------------------------------------------------
-- Script Name:		JJTools2013_PlaybackSpeeds.mcr
-- Compatible:		Max 5, 6, 7, 8, 9, 2008, 2009, 2010, 2011, 2012 and 2013
-- Version:			v3.1
-- Started:      	10 May 2004
-- Last Modified: 	8 May 2012
-- Code by:			Jim Jagger jimjagger@gmail.com
-- 					www.JimJagger.com
----------------------------------------------------------------------------------------
-- v1.0  -- 2004.05.10 -- First release
-- v1.1  -- 2005.11.10 -- Added support for Max 8
-- v1.2  -- 2007.08.19 -- Added support for Max 9
-- v1.3 -- 2007.12.01 -- Added support for Max 2008
-- v1.4 -- 2008.06.01 -- Added support for Max 2009
-- v1.5 -- 2009.05.30 -- Added support for Max 2011
-- v3.0 -- 2011.12.29 -- Added support for Max 2012
-- v3.1 -- 2012.05.08 -- Added support for Max 2013
----------------------------------------------------------------------------------------

macroScript JJTools2013_StopAnimation
category:"JJTools 2013"
toolTip:"Playback Stop"
buttontext:"Stop"
icon:#("JJTools", 73)

(
	stopAnimation()
)


macroScript JJTools2013_PlaybackSpeed14
category:"JJTools 2013"
toolTip:"Playback 1/4x Speed"
buttontext:"1/4x Speed"
icon:#("JJTools", 73)

(
	stopAnimation()
	timeconfiguration.playbackspeed = 1
	playAnimation()
)


macroScript JJTools2013_PlaybackSpeed12
category:"JJTools 2013"
toolTip:"Playback 1/2x Speed"
buttontext:"1/2x Speed"
icon:#("JJTools", 73)

(
	stopAnimation()
	timeconfiguration.playbackspeed = 2
	playAnimation()
)


macroScript JJTools2013_PlaybackSpeed1
category:"JJTools 2013"
toolTip:"Playback 1x Speed"
buttontext:"1x Speed"
icon:#("JJTools", 73)

(
	stopAnimation()
	timeconfiguration.playbackspeed = 3
	playAnimation()
)


macroScript JJTools2013_PlaybackSpeed2
category:"JJTools 2013"
toolTip:"Playback 2x Speed"
buttontext:"2x Speed"
icon:#("JJTools", 73)

(
	stopAnimation()
	timeconfiguration.playbackspeed = 4
	playAnimation()
)


macroScript JJTools2013_PlaybackSpeed4
category:"JJTools 2013"
toolTip:"Playback 4x Speed"
buttontext:"4x Speed"
icon:#("JJTools", 73)

(
	stopAnimation()
	timeconfiguration.playbackspeed = 5
	playAnimation()
)
