( 
	local a
	local b
	rollout aa "Auto Align" width:196 height:159
(
	pickButton picobject "[A]" pos:[11,8] width:75 height:24 align:#left
	pickButton upobject "[B]" pos:[112,8] width:75 height:24 align:#left
	spinner startframe "" pos:[64,85] width:45 height:16 range:[-10000,10000,0] scale:1 align:#left
	spinner endframe "" pos:[135,85] width:45 height:16 range:[-1000,10000,0] scale:1 align:#left
	button applybotton "Start" pos:[52,125] width:95 height:25 align:#left tooltip: "make:1234sosem@naver.com"
	--??? ?? ???
	label picobjectname "None" pos:[13,36] width:73 height:19 align:#left
	label alignobjectname "None" pos:[114,37] width:73 height:19 align:#left
	--??? ??? ??? ??? ??
	label lbl1 "~" pos:[117,84] width:19 height:19 align:#left
	label lbl4 "Frame" pos:[22,85] width:35 height:24 align:#left
	groupBox grp1 "Frame Range" pos:[9,64] width:177 height:47 align:#left
	label lbl5 "->" pos:[93,14] width:20 height:21 align:#left
	--???? ???
	

	on picobject picked pic_a do
	(
		a = pic_a
		picobjectname.text = pic_a.name -- ?? ??? ??? ?? ?? ??
	)
	
		on upobject picked pic_b do
	(
		b = pic_b
		alignobjectname.text = pic_b.name -- ?? ??? ??? ?? ?? ??
	)
	

	
	on applybotton pressed do
	(	undo on
		(
		n1 = startframe.value
		n2 = endframe.value
		n3 = n2-n1+1

		set animate on
		sliderTime = n1 -- n1 ????? ??
		select a
		
			
		for a in 1 to n3 do
		(
 
			$.Transform = b.Transform
			sliderTime += 1 -- 1??? ?? ??
			
		)
	)
	)

	
)

createdialog aa

)