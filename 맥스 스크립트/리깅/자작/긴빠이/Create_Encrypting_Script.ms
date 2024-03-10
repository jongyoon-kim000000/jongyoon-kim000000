(
	global ms_file
	
	fr = newRolloutFloater "Create Encrypting Max Script" 305 230
	
	rollout ab "Help" category:1
	(
		label h "---------------------------------------"
		label a "Choose Max Script file to convert in Encrypt Max Script file"
		label b "Choose the version of the .mse"
		label c "Version 0 is uses the old encryption"
        label c1 "scheme of 3ds Max 2 to 9"
		label d "Version 1 is uses the new encryption scheme"
		label d1 "introduced in 3ds Max 9 SP 1"
		label _e "The new script is saved in the"
        label _e1 "same directory as the source script file"
		label h1 "---------------------------------------"
	)
	
rollout esf "Encrypting Script" width:304 height:160 category:2
(
	GroupBox group1 "Encrypt Max Script" pos:[8,8] width:288 height:144
	button cmf "Choose Max Script file" pos:[16,32] width:272 height:24 toolTip:"Choose the Max Script to convert in Encrypting Max Script "
	label lb1 "Path: " pos:[16,64] width:272 height:40 toolTip:"Path filename of the Max Script "
	radiobuttons ver "" pos:[64,120] width:62 height:16 labels:#("0", "1") default:1 columns:2  toolTip:"Choose the version of the .mse file:\
	0 uses the old encryption scheme of 3ds Max 2 to 9, 1 is uses the new encryption scheme introduced in 3ds Max 9 SP 1"
	button gmsf "Create Encrypt Max Script file " pos:[128,112] width:160 height:32 toolTip:"Create Encrypting Max Script"
	label lb2 "Version =" pos:[16,120] width:48 height:16
	
fn find ms = (
ms_file = getOpenFileName caption:"Open MaxSript" filename:(GetDir #scripts+"\\") types:"script(*.ms)|*.ms|"
if ms_file != undefined and (getFilenameType ms_file) == ".ms" then lb1.text= ms_file as string
)



	on cmf pressed do find ms
		
	on gmsf pressed do
	(
		if ver.state == 1 do encryptScript ms_file version:0
			if ver.state == 2 do encryptScript ms_file version:1
				gmsf.text = if ver.state == 1 then "Create .mse Version 0" else "Create .mse Version 1"
	)
	
)

	rollout inf "About" category:3
	(
				label _1 "Create Encrypting Max Script"
		label _2 "by Michele71"
		label _3 "Medal71@Hotmail.it"
	)
	
	
addrollout esf fr
addrollout  ab fr rolledUp:True
addrollout inf fr rolledUp: true
)