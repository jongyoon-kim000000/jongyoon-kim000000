(
	
		fn Fn_Bip_Selection=(
		Local Bip_Select=#()
		Local Bip_Selection=Selection as Array()
		Local j=0
		for i in Bip_Selection do (
			if classof i ==Biped_Object do (
				j+=1
				Bip_Select[j]=i
			)
		)
		Bip_Select--return  Key조절에 필요한 바이페드만 배열로 리턴함
	)
	
	fn Fn_TCBwho Check_tension Check_Continuity Check_Bias=(
		Local Var_TCBwho=#(0,0,0)
		if Check_tension.triState > 0 do Var_TCBwho[1]=1
		if Check_Continuity.triState > 0 do Var_TCBwho[2]=1
		if Check_Bias.triState >0 do Var_TCBwho[3]=1
		Var_TCBwho
	)--tension 이체크되어있는지 뭐가 체크되어있는지 검사해서 배열로 넘겨줌
	
	fn Fn_ChangeTCB BipName Var_index Var_TCBwho Var_TCB =(
		for i in 1 to Var_TCBwho.count do(
			case i of(
				1:(if Var_TCBwho[i] > 0 do (Biped.getkey BipName.controller Var_index).tension=Var_TCB[i])
				2:(if Var_TCBwho[i] > 0 do (Biped.getkey BipName.controller Var_index).Continuity=Var_TCB[i])
				3:(if Var_TCBwho[i] > 0 do (Biped.getkey BipName.controller Var_index).Bias=Var_TCB[i])
				default:messagebox("인자잘못전달")
			)
		)
	)
		
	fn Fn_Change_BipCom BipName Var_TCBwho whoCom Var_index Var_TCB=(
		if whoCom == 1 then(--1이 horizontal 2:vertical
			for i in 1 to Var_TCBwho.count do(--var_TCBwho.count 가 지금 tension Continuity Bias 세개를 가리키고있음
				case i of(
				1:(if Var_TCBwho[i] > 0 do (Biped.getkey BipName.controller.horizontal.controller Var_index).tension=Var_TCB[i])
				2:(if Var_TCBwho[i] > 0 do (Biped.getkey BipName.controller.horizontal.controller Var_index).continuity=Var_TCB[i])
				3:(if Var_TCBwho[i] > 0 do (Biped.getkey BipName.controller.horizontal.controller Var_index).bias=Var_TCB[i])
				)
			)
		)
			
		else if whoCom == 2 then(
			for i in 1 to Var_TCBwho.count do(
				case i of(
					1:(if Var_TCBwho[i] > 0 do (Biped.getkey BipName.controller.vertical.controller Var_index).tension=Var_TCB[i])
					2:(if Var_TCBwho[i] > 0 do (Biped.getkey BipName.controller.vertical.controller Var_index).continuity=Var_TCB[i])
					3:(if Var_TCBwho[i] > 0 do (Biped.getkey BipName.controller.vertical.controller Var_index).bias=Var_TCB[i])
				)
			)
		)

		else if whoCom == 3 then(
			for i in 1 to Var_TCBwho.count do(
				case i of(
					1:(if Var_TCBwho[i] > 0 do (Biped.getkey BipName.controller.turning.controller Var_index).tension=Var_TCB[i])
					2:(if Var_TCBwho[i] > 0 do (Biped.getkey BipName.controller.turning.controller Var_index).continuity=Var_TCB[i])
					3:(if Var_TCBwho[i] > 0 do (Biped.getkey BipName.controller.turning.controller Var_index).bias=Var_TCB[i])
				)
			)
		)
	)
		
	
	fn fn_BipCom_CheckBox Check_com_hori Check_com_vert Check_com_turn =(
		if Check_com_hori.checked or Check_com_vert.checked or Check_com_turn.checked then(
			Check_com_hori.checked=false
			Check_com_vert.checked=false
			Check_com_turn.checked=false
		)else(
			Check_com_hori.checked=true
			Check_com_vert.checked=true
			Check_com_turn.checked=true
		)
		
	)

	---------------------------------------------------------------------------------------------------------------
	fn Fn_Check_BipedCom BipedName Check_com_hori Check_com_vert Check_com_turn Check_tension Check_Continuity Check_Bias Val_tension Val_Continuity Val_Bias=(
		Local Var_index=0 /*Var_index:선택된것들의 키 인덱스번호  Var_TCBwho:tension,등들중에 어떤걸 적용할것인지 체크용  */
		Local Var_TCBwho=Fn_TCBwho Check_tension Check_Continuity Check_Bias --뭐가체크되어있는지검사
		Local j=0
		Local var_TCB=#(Val_tension.value,Val_Continuity.value,Val_Bias.value)--조절할 스피너 수치값, 조절할 항목 추가한다면 이부분과 나머지 조절부분다 수정해야함
		
			
		for i in BipedName do(
			--messagebox("Var_index" + Var_index as string)
			
			if classof i.controller == Vertical_Horizontal_Turn then
				(
					if Check_com_hori.triState > 0 and i.controller.horizontal.controller.keys.count > 0 do (
						for Var_index in 1 to i.controller.horizontal.controller.keys.count do(
							if i.controller.horizontal.controller.keys[Var_index].selected do(
								Fn_Change_BipCom i Var_TCBwho 1 Var_index Var_TCB--1: horizontal 2:vertical 3:turning 로 작동하도록함수설정
							)-- i 가  BipName과 대응하는 인자이다
						)
					)
					if Check_com_vert.triState > 0  and i.controller.vertical.controller.keys.count > 0 do(
						for Var_index in 1 to i.controller.vertical.controller.keys.count do(
							if i.controller.vertical.controller.keys[Var_index].selected do(
								Fn_Change_BipCom i Var_TCBwho 2 Var_index Var_TCB
							)
						)
					)
					if Check_com_turn.triState > 0 and i.controller.turning.controller.keys.count > 0 do(
						for Var_index in 1 to i.controller.turning.controller.keys.count do(
							if i.controller.turning.controller.keys[Var_index].selected do(
								Fn_Change_BipCom i Var_TCBwho 3 Var_index Var_TCB
							)
						)
				)
			)	
			else(
				if i.controller.keys.count > 0 do (
					for Var_index in 1 to i.controller.keys.count do(
						if i.controller.keys[Var_index].selected do(
							Fn_ChangeTCB i Var_index Var_TCBwho Var_TCB
						)
					)
				)
			)
		)
	)
	
	
	fn Fn_nowFrame BipedName Check_com_hori Check_com_vert Check_com_turn Check_tension Check_Continuity Check_Bias Val_tension Val_Continuity Val_Bias=(
		Local var_index=0
		Local var_TCB=#(Val_tension.value,Val_Continuity.value,Val_Bias.value)
		Local Var_TCBwho=Fn_TCBwho Check_tension Check_Continuity Check_Bias
				
		for i in BipedName do(
			if classof i.controller == Vertical_Horizontal_Turn then(
				if Check_com_hori.triState > 0 And (var_index=getkeyindex i.controller.horizontal.controller slidertime) > 0 do(Fn_Change_BipCom i Var_TCBwho 1 Var_index Var_TCB)
				if Check_com_vert.triState > 0 And (var_index=getkeyindex i.controller.vertical.controller slidertime) > 0 do(Fn_Change_BipCom i Var_TCBwho 2 Var_index Var_TCB)
				if Check_com_turn.triState > 0 And (var_index=getkeyindex i.controller.turning.controller slidertime) > 0 do(Fn_Change_BipCom i Var_TCBwho 3 Var_index Var_TCB)
			)
			else(
				if (var_index=getkeyindex i.controller slidertime) > 0 do(Fn_ChangeTCB i Var_index Var_TCBwho Var_TCB)
			)
		)
	)
	
	fn fn_sel_Children a b=(
		append b a
		for i in a.children do(
			if classof i == Biped_Object do(
				for c in a.children do b=fn_sel_Children c b
				b
			)
		)
		b
	)
	
	------------------------------------------------------------------------------------------------------------------
	
	rollout Biped_TCB_Control_2_00 "EMP TCB EDIT"(
		
		--button Btn_Bip_Com "Com" offset:[-55,-5] width:57
		--button Btn_select_Bip "sel_Bip" offset:[2,-26]width:57
		button Btn_notName "" offset:[59,-26]width:57
		--checkbox Check_com_hori "hor" offset:[0,0] checked:true tooltip:"Horizontal"
		--checkbox Check_com_vert "ver" offset:[50,-20] checked:true tooltip:"Vertical"
		--checkbox Check_com_turn "rot" offset:[100,-20] checked:true tooltip:"Rotation"
		--groupbox Group_comGroup "Bip_Com" offset:[-7,-40] width:150 height:40
	
		checkbox Check_tension offset:[-3,10]
		spinner Val_tension "Tension" range:[0,50,25] type:#float offset:[3,-20]
		checkbox Check_Continuity offset:[-3,0] checked:true
		spinner Val_Continuity "Continuity" range:[0,50,0] type:#float offset:[3,-20]
		checkbox Check_Bias offset:[-3,0]
		spinner Val_Bias "Bias" range:[0,50,25] type:#float offset:[3,-20]
		groupbox Group_TCB "" width:170 height:83 offset:[-20,-77]
		
		button Btn_SelectKey "선택된 타임라인 적용" width:150 height:35 offset:[0,10]
		--button Btn_NowFrame "Current Key" width:200 height:25 offset:[0,-5]
		
		 Label Label_Testing "* COM은 클릭하지마세요"
		
		/*on Biped_TCB_Control_2_00 open do(
		
		)*/
		local biproot2=#()
		on Btn_select_Bip pressed do(
			BipedName=Fn_Bip_Selection()
			Local A, B
			Local BipRoot=#()
			Local BipAll=#()
			if BipedName.count >0 do (
				BipRoot[1]=BipedName[1].controller.rootnode
				if BipedName.count > 1 do(
					for i in 2 to BipedName.count do (
						B=BipedName[i].controller.rootnode
						A=BipedName[i-1].controller.rootnode
						if A!=B do append BipRoot B
					)
				)
				
				for i in BipRoot do(
					q=fn_sel_children i #()
					join BipAll q
				)
				select BipAll
				
			)
		)
		on Btn_SelectKey pressed do(
			BipedName=Fn_Bip_Selection()
			Fn_Check_BipedCom BipedName Check_com_hori Check_com_vert Check_com_turn Check_tension Check_Continuity Check_Bias Val_tension Val_Continuity Val_Bias--함수보다 아래쪽에 롤아웃이 위치해서 변수명들을 인식못해서 이렇게 인자로 전달해주는 방법을 써야했다
		)
		
		on Btn_bip_com pressed do(fn_BipCom_CheckBox Check_com_hori Check_com_vert Check_com_turn)
		
		on Btn_NowFrame pressed do(
			BipedName=Fn_Bip_Selection()
			Fn_nowFrame BipedName Check_com_hori Check_com_vert Check_com_turn Check_tension Check_Continuity Check_Bias Val_tension Val_Continuity Val_Bias
		)
	)
	
	
	try(destroydialog Biped_TCB_Control_2_00)catch()--로컬영역에서 롤아웃이 선언되서 Biped_TCB_Control_ver2_00 변수를 찾지못해 닫기가안된다.현재
	createdialog Biped_TCB_Control_2_00
)