utility encScr "Encrypt Script" silentErrors: true
(
	label sct_1 "Encrypt Max Script"
	label dvd_1 "------------------------------"
	button btn_1 "Select" width:150
	button btn_2 "Encrypt" width: 150

	local ffPth = ()
	on btn_1 pressed do 
	(
		ffPth = (getOpenFileName caption: "Select script")
		btn_1.text = getfilenameFile (ffPth)
	)
	on btn_2 pressed do
	(
		
		encryptscript ffPth version:1	-- change this to '0' if using 3ds max version older than '9 SP1'
		local fPth = (getFilenamePath ffPth)
		dcs = ("start \"\" \"" + fPth + "\"")
		print dcs
		hiddenDOSCommand dcs prompt: "Opening encrypted Maxscript location"
	)
)