----------------------------------------------------------------------------------------
-- Script Name:		JJTools2013_SelectBiped.mcr
-- Compatible:		Max 5, 6, 7, 8, 9, 2008, 2009, 2010, 2011, 2012 and 2013
-- Requirements:	Character Studio
--					JJTools2013_Functions
-- Version:			v3.1
-- Started:      	5 May 2004
-- Last Modified: 	8 May 2012
-- Code by:			Jim Jagger jimjagger@gmail.com
-- 					www.JimJagger.com
----------------------------------------------------------------------------------------
-- v1.0 -- 2004.05.05 -- first release
-- v1.1 -- 2004.05.18 -- Improved the search method to select the first biped found in
--						 the scene.  Works on any named bipeds.
-- v1.2 -- 2005.11.10 -- Added support for Max 8
-- v1.3 -- 2007.08.19 -- Added support for Max 9
-- v1.4 -- 2007.12.01 -- Added support for Max 2008
-- v1.5 -- 2008.06.01 -- Added support for Max 2009
-- v1.5 -- 2009.05.30 -- Added support for Max 2011
-- v3.0 -- 2011.12.29 -- Added support for Max 2012
-- v3.1 -- 2012.05.08 -- Added support for Max 2013
----------------------------------------------------------------------------------------

macroScript JJTools2013_Bip_Select_Bip
category:"JJTools 2013" 
buttonText:"Root"
tooltip:"Select Root" 
icon:#("JJTools", 46)
(
	try
	(
		allbips = getallbips()
		select allbips[1]
	)
	catch(format "An Error Occured\n")
)

macroScript JJTools2013_Bip_Select_Pelvis
category:"JJTools 2013" 
buttonText:"Pelvis"
tooltip:"Select Pelvis" 
icon:#("JJTools", 46)
(
	try
	(
		allbips = getallbips()
		select (biped.getNode allbips[1] #pelvis link:1)
	)

	catch(format "An Error Occured\n")
)

macroScript JJTools2013_Bip_Select_Spine
category:"JJTools 2013" 
buttonText:"Spine"
tooltip:"Select Spine" 
icon:#("JJTools", 47)
(
	try
	(
		allbips = getallbips()
		select (biped.getNode allbips[1] #spine link:1)
	)
	catch(format "An Error Occured\n")
)

macroScript JJTools2013_Bip_Select_Spine1
category:"JJTools 2013" 
buttonText:"Spine 1"
tooltip:"Select Spine 1" 
icon:#("JJTools", 47)
(
	try
	(
		allbips = getallbips()
		select (biped.getNode allbips[1] #spine link:2)
	)
	catch(format "An Error Occured\n")
)

macroScript JJTools2013_Bip_Select_Spine2
category:"JJTools 2013" 
buttonText:"Spine 2"
tooltip:"Select Spine 2" 
icon:#("JJTools", 47)
(
	try
	(
		allbips = getallbips()
		select (biped.getNode allbips[1] #spine link:3)
	)
	catch(format "An Error Occured\n")
)

macroScript JJTools2013_Bip_Select_Spine3
category:"JJTools 2013" 
buttonText:"Spine 3"
tooltip:"Select Spine 3" 
icon:#("JJTools", 47)
(
	try
	(
		allbips = getallbips()
		select (biped.getNode allbips[1] #spine link:4)
	)
	catch(format "An Error Occured\n")
)

macroScript JJTools2013_Bip_Select_Spine4
category:"JJTools 2013" 
buttonText:"Spine 4"
tooltip:"Select Spine 4" 
icon:#("JJTools", 47)
(
	try
	(
		allbips = getallbips()
		select (biped.getNode allbips[1] #spine link:5)
	)
	catch(format "An Error Occured\n")
)

macroScript JJTools2013_Bip_Select_Head
category:"JJTools 2013" 
buttonText:"Head"
tooltip:"Select Head" 
icon:#("JJTools", 48)
(
	try
	(
		allbips = getallbips()
		select (biped.getNode allbips[1] #head link:1)
	)
	catch(format "An Error Occured\n")
)

macroScript JJTools2013_Bip_Select_Neck
category:"JJTools 2013" 
buttonText:"Neck"
tooltip:"Select Neck" 
icon:#("JJTools", 48)
(
	try
	(
		allbips = getallbips()
		select (biped.getNode allbips[1] #neck link:1)
	)
	catch(format "An Error Occured\n")
)

macroScript JJTools2013_Bip_Select_Neck1
category:"JJTools 2013" 
buttonText:"Neck 1"
tooltip:"Select Neck 1" 
icon:#("JJTools", 48)
(
	try
	(
		allbips = getallbips()
		select (biped.getNode allbips[1] #neck link:2)
	)
	catch(format "An Error Occured\n")
)

macroScript JJTools2013_Bip_Select_Neck2
category:"JJTools 2013" 
buttonText:"Neck 2"
tooltip:"Select Neck 2" 
icon:#("JJTools", 48)
(
	try
	(
		allbips = getallbips()
		select (biped.getNode allbips[1] #neck link:3)
	)
	catch(format "An Error Occured\n")
)

macroScript JJTools2013_Bip_Select_Neck3
category:"JJTools 2013" 
buttonText:"Neck 3"
tooltip:"Select Neck 3" 
icon:#("JJTools", 48)
(
	try
	(
		allbips = getallbips()
		select (biped.getNode allbips[1] #neck link:4)
	)
	catch(format "An Error Occured\n")
)

macroScript JJTools2013_Bip_Select_Neck4
category:"JJTools 2013" 
buttonText:"Neck 4"
tooltip:"Select Neck 4" 
icon:#("JJTools", 48)
(
	try
	(
		allbips = getallbips()
		select (biped.getNode allbips[1] #neck link:5)
	)
	catch(format "An Error Occured\n")
)

macroScript JJTools2013_Bip_Select_R_Clavicle
category:"JJTools 2013" 
buttonText:"R Clavicle"
tooltip:"Select R Clavicle" 
icon:#("JJTools", 49)
(
	try
	(
		allbips = getallbips()
		select (biped.getNode allbips[1] #rarm link:1)
	)
	catch(format "An Error Occured\n")
)

macroScript JJTools2013_Bip_Select_R_UpperArm
category:"JJTools 2013" 
buttonText:"R UpperArm"
tooltip:"Select R UpperArm" 
icon:#("JJTools", 49)
(
	try
	(
		allbips = getallbips()
		select (biped.getNode allbips[1] #rarm link:2)
	)
	catch(format "An Error Occured\n")
)

macroScript JJTools2013_Bip_Select_R_ForeArm
category:"JJTools 2013" 
buttonText:"R ForeArm"
tooltip:"Select R ForeArm" 
icon:#("JJTools", 49)
(
	try
	(
		allbips = getallbips()
		select (biped.getNode allbips[1] #rarm link:3)
	)
	catch(format "An Error Occured\n")
)

macroScript JJTools2013_Bip_Select_R_Hand
category:"JJTools 2013" 
buttonText:"R Hand"
tooltip:"Select R Hand" 
icon:#("JJTools", 49)
(
	try
	(
		allbips = getallbips()
		select (biped.getNode allbips[1] #rarm link:4)
	)
	catch(format "An Error Occured\n")
)

macroScript JJTools2013_Bip_Select_L_Clavicle
category:"JJTools 2013" 
buttonText:"L Clavicle"
tooltip:"Select L Clavicle" 
icon:#("JJTools", 49)
(
	try
	(
		allbips = getallbips()
		select (biped.getNode allbips[1] #larm link:1)
	)
	catch(format "An Error Occured\n")
)

macroScript JJTools2013_Bip_Select_L_UpperArm
category:"JJTools 2013" 
buttonText:"L UpperArm"
tooltip:"Select L UpperArm" 
icon:#("JJTools", 49)
(
	try
	(
		allbips = getallbips()
		select (biped.getNode allbips[1] #larm link:2)
	)
	catch(format "An Error Occured\n")
)
macroScript JJTools2013_Bip_Select_L_ForeArm
category:"JJTools 2013" 
buttonText:"L ForeArm"
tooltip:"Select L ForeArm" 
icon:#("JJTools", 49)
(
	try
	(
		allbips = getallbips()
		select (biped.getNode allbips[1] #larm link:3)
	)
	catch(format "An Error Occured\n")
)

macroScript JJTools2013_Bip_Select_L_Hand
category:"JJTools 2013" 
buttonText:"L Hand"
tooltip:"Select L Hand" 
icon:#("JJTools", 50)
(
	try
	(
		allbips = getallbips()
		select (biped.getNode allbips[1] #larm link:4)
	)
	catch(format "An Error Occured\n")
)

macroScript JJTools2013_Bip_Select_R_Thigh
category:"JJTools 2013" 
buttonText:"R Thigh"
tooltip:"Select R Thigh" 
icon:#("JJTools", 51)
(
	try
	(
		allbips = getallbips()
		select (biped.getNode allbips[1] #rleg link:1)
	)
	catch(format "An Error Occured\n")
)

macroScript JJTools2013_Bip_Select_R_Calf
category:"JJTools 2013" 
buttonText:"R Calf"
tooltip:"Select R Calf" 
icon:#("JJTools", 51)
(
	try
	(
		allbips = getallbips()
		select (biped.getNode allbips[1] #rleg link:2)
	)
	catch(format "An Error Occured\n")
)

macroScript JJTools2013_Bip_Select_R_Foot
category:"JJTools 2013" 
buttonText:"R Foot"
tooltip:"Select R Foot" 
icon:#("JJTools", 51)
(
	try
	(
		allbips = getallbips()
		select (biped.getNode allbips[1] #rleg link:3)
	)
	catch(format "An Error Occured\n")
)

macroScript JJTools2013_Bip_Select_L_Thigh
category:"JJTools 2013" 
buttonText:"L Thigh"
tooltip:"Select L Thigh" 
icon:#("JJTools", 51)
(
	try
	(
		allbips = getallbips()
		select (biped.getNode allbips[1] #lleg link:1)
	)
	catch(format "An Error Occured\n")
)

macroScript JJTools2013_Bip_Select_L_Calf
category:"JJTools 2013" 
buttonText:"L Calf"
tooltip:"Select L Calf" 
icon:#("JJTools", 51)
(
	try
	(
		allbips = getallbips()
		select (biped.getNode allbips[1] #lleg link:2)
	)
	catch(format "An Error Occured\n")
)

macroScript JJTools2013_Bip_Select_L_Foot
category:"JJTools 2013" 
buttonText:"L Foot"
tooltip:"Select L Foot" 
icon:#("JJTools", 51)
(
	try
	(
		allbips = getallbips()
		select (biped.getNode allbips[1] #lleg link:3)
	)
	catch(format "An Error Occured\n")
)

macroScript JJTools2013_Bip_Select_Tail
category:"JJTools 2013" 
buttonText:"Tail"
tooltip:"Select Tail" 
icon:#("JJTools", 51)
(
	try
	(
		allbips = getallbips()
		select (biped.getNode allbips[1] #tail link:1)
	)
	catch(format "An Error Occured\n")
)

macroScript JJTools2013_Bip_Select_Tail1
category:"JJTools 2013" 
buttonText:"Tail 1"
tooltip:"Select Tail 1" 
icon:#("JJTools", 51)
(
	try
	(
		allbips = getallbips()
		select (biped.getNode allbips[1] #tail link:2)
	)
	catch(format "An Error Occured\n")
)

macroScript JJTools2013_Bip_Select_Tail2
category:"JJTools 2013" 
buttonText:"Tail 2"
tooltip:"Select Tail 2" 
icon:#("JJTools", 51)
(
	try
	(
		allbips = getallbips()
		select (biped.getNode allbips[1] #tail link:3)
	)
	catch(format "An Error Occured\n")
)

macroScript JJTools2013_Bip_Select_Tail3
category:"JJTools 2013" 
buttonText:"Tail 3"
tooltip:"Select Tail 3" 
icon:#("JJTools", 51)
(
	try
	(
		allbips = getallbips()
		select (biped.getNode allbips[1] #tail link:4)
	)
	catch(format "An Error Occured\n")
)

macroScript JJTools2013_Bip_Select_Tail4
category:"JJTools 2013" 
buttonText:"Tail 4"
tooltip:"Select Tail 4" 
icon:#("JJTools", 51)
(
	try
	(
		allbips = getallbips()
		select (biped.getNode allbips[1] #tail link:5)
	)
	catch(format "An Error Occured\n")
)
