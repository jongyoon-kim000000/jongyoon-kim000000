/* --------------------------------------------  --------------------------------------------  */
-- bipedLoopTool 0.33
-- 작성자: 박종화
-- Email: pjhstone@gmail.com

/*
	버튼 기능:

		@Expand, loop Area: 애니메이션 작업 범위를 현재 작업 범위 *2만큼의 길이로 늘려줍니다.
			- 예:  0f ~ 30f 의 작업 범위를 -30f ~ 60f으로 바꿔줍니다.

		@Reduce, loop Area: Expand로 확장했던 작업범위를 원래대로 돌려놓습니다.



		@Copy, key, Loop Side: 작업 영역에 있는 키들을 작업영역 바깥 양쪽으로 똑같이 복사합니다.
			- 바이패드가 아닌 노드를 선택하면
				포지션은 컨트롤러가 Position_XYZ, Bezier_Position, TCB_Position 일 때
				회전은 컨트롤러가 Euler_XYZ, TCB_Rotation 일 때
				스케일은 컨트롤러가 Bezier_Scale, ScaleXYZ, TCB_Scale 일 때 Out-of-Range Type이 #loop로 바뀝니다.

		@Delete Loop Side key: 바이패드 모든 부위를 선택해 첫 프레임과 끝 프레임에 set key를 주고, 작업 영역 바깥에 있는 모든 key를 삭제합니다.
			- 바이패드가 아닌 노드를 선택하면
				포지션은 컨트롤러가 Position_XYZ, Bezier_Position, TCB_Position 일 때
				회전은 컨트롤러가 Euler_XYZ, TCB_Rotation 일 때
				스케일은 컨트롤러가 Bezier_Scale, ScaleXYZ, TCB_Scale 일 때 Out-of-Range Type이 #constant로 바뀝니다.



		@middle Time: 루프의 middle frame을 바꾸고 그에 맞춰 끝나는 프레임을 조정합니다.

		@current frame for middle: 현재 프레임을 루프의 middle frame으로 결정하고, 그에 맞춰 끝나는 프레임을 조정합니다.




		@Run & Walking - Backward Copy 와 @Run & Walking  - Forward Copy
			대칭되는 두 패턴이 중간 지점에서 교차하며 반복되는 걷기와 뛰기 용의 key 복사 기능입니다.

			@Run & Walking - Forward Copy 는 걷기 뛰기 앞쪽의 패턴을 middle frame을 기준으로 뒤쪽으로 대칭 복사합니다.
			@Run & Walking  - Forward Copy 는 걷기 뛰기 뒤쪽의 패턴을 middle frame을 기준으로 앞쪽으로 대칭 복사합니다.

				- 주의1: 머리카락은 pony1과 pony2 두 개가 존재하고, pony1과 pony2의 Separate 옵션이 둘 다 꺼져 있거나, 켜져 있을 때만 동작을 붙여넣습니다.
				- 주의2: 버튼을 실행하면 저장해 놓은 모든 포즈 Collections을 삭제합니다.

			  아래 버튼들로 대칭 복사되는 바이패드 부위를 선택할 수 있습니다.
				@bipRoot @Pelvis @Leg @Spine @Neck @Arm @Pony @Tail @All @None
 */
/* --------------------------------------------  --------------------------------------------  */


gc light:true

if Biped_loopTool != undefined do DestroyDialog Biped_loopTool

/* -------------------------------- ------------------------------ ---------------------------------------- ------------------------------- */
/* -------------------------------- ------------------------------ ---------------------------------------- ------------------------------- */
/* -------------------------------- ------------------------------ ---------------------------------------- ------------------------------- */

	global frameRateasInteger = 160
		if frameRate == 30 then frameRateasInteger = 160
			else if frameRate == 24 then frameRateasInteger = 200
			else if frameRate == 25 then frameRateasInteger = 192
			else if frameRate == 60 then frameRateasInteger = 320


fn basicRange =
(
	global C_Start = animationRange.start	-- 시작하는 프레임
	global C_End = animationRange.end	-- 끝나는 프레임

	global loopLength = abs (C_End-C_Start)	-- 애니메이션  길이


	global middle_Time = ((((C_End)-(C_Start))/2) as integer)/frameRateasInteger
	global middle_TimeLength = abs (middle_Time-C_Start)


	global loopArea_start = ((C_Start+(loopLength/3)) as Integer/frameRateasInteger)	-- /* /160 은 FPS 30프래임 일때, FPS 24 프래임 일때는 /200으로 바꿔줘야 함 */
	global loopArea_end = ((C_End-(loopLength/3)) as Integer/frameRateasInteger)	-- /* /160 은 FPS 30프래임 일때, FPS 24 프래임 일때는 /200으로 바꿔줘야 함 */

	global loopSideArea_start = (C_Start-loopLength)	-- 사이드 루프 영역의 시작 프레임
	global loopSideArea_end = (C_End+loopLength)	-- 사이드 루프 영역의 끝나는 프레임

	global loopSideLength = abs (loopSideArea_start-loopSideArea_end)	-- 사이드 루프 영역의 길이


	if loopLength <= 3 then
		(
			loopArea_start = C_Start
			loopArea_end = C_End
			print " - Small Frame !!!!!!!!!!!!! -  "
		)

		else if loopLength >= 10000 then
			(
				loopSideArea_start = C_Start
				loopSideArea_end = C_End
				print " - Large Frame !!!!!!!!!!!!! - "
			)
)

/* play - 확장했던 작업영역을 원래대로 줄이는 함수 Reduce, loop Area */
fn play_LoopArea =
(

	basicRange()

	animationRange  = (interval  loopArea_start loopArea_end)

	print animationRange


)

/* play - 지금의 작업 영역만큼의 프레임을 작업 영역 양옆으로 늘이는 함수 Delete Loop Side key */
fn play_LoopSideArea =
(

	basicRange()


	animationRange  = (interval loopSideArea_start loopSideArea_end)


	print animationRange
)

/* -------------------------------- ------------------------------ ---------------------------------------- ------------------------------- */
/* -------------------------------- ------------------------------ ---------------------------------------- ------------------------------- */
/* -------------------------------- ------------------------------ ---------------------------------------- ------------------------------- */


	/*  Bip_LoopSideKeyArray 배열 설정 */

	fn Bip_targetArray =
	(

		/* 타겟 Bip  설정 */

		global target_Bip = $.controller.rootNode

		global target_Ver = target_Bip.controller.vertical.controller
		global target_Hor = target_Bip.controller.horizontal.controller
		global target_Tur = target_Bip.controller.turning.controller

		global target_pelvis = biped.getNode target_Bip #pelvis
		global target_spine = biped.getNode target_Bip #spine
		global target_neck = biped.getNode target_Bip #neck
		global target_head = biped.getNode target_Bip #head

		global target_lleg = biped.getNode target_Bip #lleg
		global target_rleg = biped.getNode target_Bip #rleg

		global target_larm = biped.getNode target_Bip #larm
		global target_rarm = biped.getNode target_Bip #rarm

		global target_tail = biped.getNode target_Bip #tail
		global target_pony1 = biped.getNode target_Bip #pony1
		global target_pony2 = biped.getNode target_Bip #pony2

		-- global target_prop1 = biped.getNode target_Bip #prop1
		-- global target_prop2 = biped.getNode target_Bip #prop2
		-- global target_prop3 = biped.getNode target_Bip #prop3
	)

	/* ------ Bip 목 파트 배열 만들기 ------*/
	fn Bip_Neck_PartArray =
	(

		global Neck_PartArray = #()

		local N = target_Bip.controller.neckLinks	-- 목 갯수 알아내기

			Neck_PartArray = for a in 1 to N collect
				(
					biped.getNode target_Bip #neck link:a
				)

	)

	/* ------ Bip 목과 머리 파트 배열 만들기 ------*/
	fn Bip_neckHead_PartArray target_Bip =
	(

		local N = target_Bip.controller.neckLinks	-- 목 갯수 알아내기

			local neckHead_Array = for a in 1 to N collect
				(
					biped.getNode target_Bip #neck link:a
				)

			append neckHead_Array target_head

	)

	/* ------ Bip 허리 파트 배열 만들기 ------*/
	fn Bip_spine_PartArray =
	(

		global Spine_PartArray = #()

		local S = target_Bip.controller.spineLinks	-- 허리 갯수 알아내기


			Spine_PartArray = for a in 1 to S collect
				(
					biped.getNode target_Bip #spine link:a
				)

	)
	/* ------ Bip 다리 파트 배열 만들기 ------*/
	fn Bip_Leg_PartArray =
	(

		global L_Leg_PartArray = #()
		global R_Leg_PartArray = #()

		local Leg = target_Bip.controller.legLinks	-- 다리 관절 갯수 알아내기


			L_Leg_PartArray = for a in 1 to Leg collect
				(
					biped.getNode target_Bip #lleg link:a
				)

			R_Leg_PartArray = for a in 1 to Leg collect
				(
					biped.getNode target_Bip #rleg link:a
				)
	)

	/* ------ Bip 발가락 파트 배열 만들기 ------*/
	fn Bip_Toe_PartArray =
	(

		global L_Toe_PartArray = #()
		global R_Toe_PartArray = #()

		local T = target_Bip.controller.toes	-- 발가락 갯수 알아내기
		local Tlink = target_Bip.controller.toeLinks	-- 발가락 관절 갯수 알아내기


			L_Toe_PartArray = for a in 1 to (T*Tlink) collect
				(
					biped.getNode target_Bip #ltoes link:a
				)

			R_Toe_PartArray = for a in 1 to (T*Tlink) collect
				(
					biped.getNode target_Bip #rtoes link:a
				)
	)

	/* ------ Bip 왼쪽 발 발가락 파트 배열 만들기------*/
	fn Bip_L_legToe_PartArray target_Bip =
	(

		local Leg = target_Bip.controller.legLinks	-- 다리 관절 갯수 알아내기
		local T = target_Bip.controller.toes	-- 발가락 갯수 알아내기
		local Tlink = target_Bip.controller.toeLinks	-- 발가락 관절 갯수 알아내기

		local L_Leg_PartArray = for a in 1 to Leg collect
			(
				biped.getNode target_Bip #lleg link:a
			)

		local L_Toe_PartArray = for a in 1 to (T*Tlink) collect
			(
				biped.getNode target_Bip #ltoes link:a
			)


		local L_legToe_PartArray = L_Leg_PartArray+L_Toe_PartArray

	)
	/* ------ Bip 오른쪽 발 발가락 파트 배열 만들기------*/
	fn Bip_R_legToe_PartArray target_Bip =
	(

		local Leg = target_Bip.controller.legLinks	-- 다리 관절 갯수 알아내기
		local T = target_Bip.controller.toes	-- 발가락 갯수 알아내기
		local Tlink = target_Bip.controller.toeLinks	-- 발가락 관절 갯수 알아내기


		local R_Leg_PartArray = for a in 1 to Leg collect
			(
				biped.getNode target_Bip #rleg link:a
			)

		local R_Toe_PartArray = for a in 1 to (T*Tlink) collect
			(
				biped.getNode target_Bip #rtoes link:a
			)

		local R_legToe_PartArray = R_Leg_PartArray+R_Toe_PartArray
	)


	/* ------ Bip 팔 파트 배열 만들기 ------*/
	fn Bip_Arm_PartArray =
	(
		global L_arm_PartArray = #()
		global R_arm_PartArray = #()

			L_arm_PartArray = for a in 1 to 4 collect
				(
					biped.getNode target_Bip #larm link:a
				)


			R_arm_PartArray = for a in 1 to 4 collect
				(
					biped.getNode target_Bip #rarm link:a
				)
	)
	/* ------ Bip 손가락 파트 배열 만들기 ------*/
	fn Bip_Fingers_PartArray =
	(

		global L_Fingers_PartArray = #()
		global R_Fingers_PartArray = #()

		local F = target_Bip.controller.fingers	-- 손가락 갯수 알아내기
		local Flink = target_Bip.controller.fingerLinks	-- 손가락 관절 갯수 알아내기


			L_Fingers_PartArray = for a in 1 to (F*Flink) collect
				(
					biped.getNode target_Bip #lfingers link:a
				)

			R_Fingers_PartArray = for a in 1 to (F*Flink) collect
				(
					biped.getNode target_Bip #rfingers link:a
				)
	)

	/* ------ Bip 왼쪽 팔 손가락 파트 배열 만들기------*/
	fn Bip_L_armFingers_PartArray target_Bip =
	(

		local F = target_Bip.controller.fingers	-- 손가락 갯수 알아내기
		local Flink = target_Bip.controller.fingerLinks	-- 손가락 관절 갯수 알아내기

		local L_arm_PartArray = for a in 1 to 4 collect
				(
					biped.getNode target_Bip #larm link:a
				)

		local L_Fingers_PartArray = for a in 1 to (F*Flink) collect
				(
					biped.getNode target_Bip #lfingers link:a
				)


		local L_armFingersPartArray = L_arm_PartArray + L_Fingers_PartArray
	)
	/* ------ Bip 오른쪽 팔 손가락 파트 배열 만들기------*/
	fn Bip_R_armFingers_PartArray target_Bip =
	(

		local F = target_Bip.controller.fingers	-- 손가락 갯수 알아내기
		local Flink = target_Bip.controller.fingerLinks	-- 손가락 관절 갯수 알아내기

		local R_arm_PartArray = for a in 1 to 4 collect
				(
					biped.getNode target_Bip #rarm link:a
				)

		local R_Fingers_PartArray = for a in 1 to (F*Flink) collect
				(
					biped.getNode target_Bip #rfingers link:a
				)


		local R_armFingersPartArray = R_arm_PartArray + R_Fingers_PartArray
	)



	/* ------ Bip 꼬리 파트 배열 만들기 ------*/
	fn Bip_Tail_PartArray =
	(

		global Tail_PartArray = #()

		local T = target_Bip.controller.tailLinks	-- 꼬리 갯수 알아내기


			Tail_PartArray = for a in 1 to T collect
				(
					biped.getNode target_Bip #tail link:a
				)
	)

	/* ------ Bip 머리카락 1 파트 배열 만들기 ------*/
	fn Bip_Ponytail1_PartArray =
	(

		global Ponytail1_PartArray = #()

		local p1 = target_Bip.controller.ponytail1Links	-- 머리카락 1 갯수 알아내기


			Ponytail1_PartArray = for a in 1 to p1 collect
				(
					biped.getNode target_Bip #pony1 link:a
				)
	)
	/* ------ Bip 머리카락 2 파트 배열 만들기 ------*/
	fn Bip_Ponytail2_PartArray =
	(

		global Ponytail2_PartArray = #()

		local p2 = target_Bip.controller.ponytail2Links	-- 머리카락 2 갯수 알아내기


			Ponytail2_PartArray = for a in 1 to p2 collect
				(
					biped.getNode target_Bip #pony2 link:a
				)
	)

	-- /* ------ Bip Xtra 본 배열 만들기 ------*/
	-- fn Bip_Xtra_PartArray target_Bip =
	-- (
		-- local target_Bip = target_Bip	-- 바이패드의 root를 입력 받아

		-- select target_Bip		-- root를 선택하고,
		-- actionMan.executeAction 0 "40180"  -- 그 하위 오브젝트를 모두 선택한 다음 -- Selection: Select Children
		-- local obj = getCurrentSelection()



		-- /* 콘트롤러 이름이 "Controller:Xtra*"인 파트들을 모아 bip_Xtra_Array 배열을 만든다 */
		-- local bip_Xtra_Array = for a in 1 to obj.count where matchPattern (obj[a].Controller as string) pattern:"Controller:Xtra*" collect
			-- (
				-- obj[a]
			-- )
	-- )


		/* ----------------- 바이패트 키 왼쪽과 오른쪽으로 복사하는 함수들 ----------------- */

			/* bip001 Vertical Key 사이드루프 영역에 복사 */
			fn sideLoop_copy_bipVertical =
			(
				local BIP = target_Ver	-- Bip 선택
				local Bip_Key = target_Ver.keys	-- 키 배열

				local Bip_KeyTimeArray = #()	-- 원본 키 타임 배열 선언
				local before_KeyCount = Bip_Key.count	-- 대칭 복사하기 전의 키 갯수를 저장

				local Bip_Properties = #()	-- 키 프로퍼티의 배열 선언

			/* 만약에 key가 없으면 실행 중지 */
			if before_KeyCount == 0 then format "!!! Vertex Key zero \n" else
				(
					/* 원본 키 타임 배열을 Bip_KeyTimeArray에 저장 */
					Bip_KeyTimeArray = for a in 1 to Bip_Key.count collect
					(
						Bip_Key[a].time
					)

						/* 포즈를 붙여넣기 전에 찌거기 Key가 없는지 조사 */
						local test_KeyCount = "Good"

						for a in 1 to Bip_KeyTimeArray.count-1 do
						(
							if (Bip_KeyTimeArray[a]-loopLength) >= (Bip_KeyTimeArray[1]) then
								(
									test_KeyCount = "Bad"
									format "- !!! Vertical has a bad loop key \n"
									exit

								)
						)

						for b in 2 to Bip_KeyTimeArray.count do
							(
								if (Bip_KeyTimeArray[b]+loopLength) <= Bip_KeyTimeArray[Bip_KeyTimeArray.count] then
									(
										test_KeyCount = "Bad"
										format "  !!! Vertical has a bad loop key - \n"
										exit
									)
							)

						/* 찌꺼기 검사를 통과하면 포즈 붙여넣기 실행 */
						if test_KeyCount == "Good" do
							(
								/* 사이드 루프 영역 왼쪽에 버티칼 키 넣기 */
								for a in 1 to Bip_KeyTimeArray.count-1 do
								(
									biped.addNewKey BIP ((Bip_KeyTimeArray[a])-loopLength)
								)
								/* 사이드 루프 영역 오른쪽에 버티칼 키 넣기 */
								for a in 2 to Bip_KeyTimeArray.count do
								(
									biped.addNewKey BIP ((Bip_KeyTimeArray[a])+loopLength)
								)


								/* 키 프로퍼티 배열 정리하는 반복문 */
								Bip_Properties = for b in 1 to Bip_Key.count collect
									(
										biped.getKey BIP b
									)

								/* 키 프러퍼티들을 왼쪽으로 복사하는 반복문 */
								for c in 1 to (before_KeyCount-1) do
								(
									BIP_Properties[c].z = BIP_Properties[((c+before_KeyCount)-1)].z
									BIP_Properties[c].tension = BIP_Properties[((c+before_KeyCount)-1)].tension
									BIP_Properties[c].continuity = BIP_Properties[((c+before_KeyCount)-1)].continuity
									BIP_Properties[c].bias = BIP_Properties[((c+before_KeyCount)-1)].bias
									BIP_Properties[c].easeTo = BIP_Properties[((c+before_KeyCount)-1)].easeTo
									BIP_Properties[c].easeFrom = BIP_Properties[((c+before_KeyCount)-1)].easeFrom
									BIP_Properties[c].dynamicsBlend = BIP_Properties[((c+before_KeyCount)-1)].dynamicsBlend
									BIP_Properties[c].ballisticTension = BIP_Properties[((c+before_KeyCount)-1)].ballisticTension
								)
								/* 키 프러퍼티들을 오른쪽으로 복사하는 반복문 */
								for c in (before_KeyCount*2) to Bip_Key.count do
								(
									BIP_Properties[c].z = BIP_Properties[((c-before_KeyCount) + 1)].z
									BIP_Properties[c].tension = BIP_Properties[((c-before_KeyCount) + 1)].tension
									BIP_Properties[c].continuity = BIP_Properties[((c-before_KeyCount) + 1)].continuity
									BIP_Properties[c].bias = BIP_Properties[((c-before_KeyCount) + 1)].bias
									BIP_Properties[c].easeTo = BIP_Properties[((c-before_KeyCount) + 1)].easeTo
									BIP_Properties[c].easeFrom = BIP_Properties[((c-before_KeyCount) + 1)].easeFrom
									BIP_Properties[c].dynamicsBlend = BIP_Properties[((c-before_KeyCount) + 1)].dynamicsBlend
									BIP_Properties[c].ballisticTension = BIP_Properties[((c-before_KeyCount) + 1)].ballisticTension
								)

								format "Vertical Key for loop side \n"

							)
				)
			)
			/* bip001 Horizontal Key 사이드루프 영역에 복사 */
			fn sideLoop_copy_bipHorizontal =
			(
				local BIP = target_Hor	-- Bip 선택
				local Bip_Key = target_Hor.keys	-- 키 배열

				local Bip_KeyTimeArray = #()	-- 원본 키 타임 배열 선언
				local before_KeyCount = Bip_Key.count	-- 대칭 복사하기 전의 키 갯수를 저장

				local Bip_Properties = #()	-- 키 프로퍼티의 배열 선언

			/* 만약에 key가 없으면 실행 중지 */
			if before_KeyCount == 0 then format "!!! Horizontal Key zero \n" else
				(
					/* 원본 키 타임 배열을 Bip_KeyTimeArray에 저장 */
					Bip_KeyTimeArray = for a in 1 to Bip_Key.count collect
					(
						Bip_Key[a].time
					)

						/* 포즈를 붙여넣기 전에 찌거기 Key가 없는지 조사 */
						local test_KeyCount = "Good"

						for a in 1 to Bip_KeyTimeArray.count-1 do
						(
							if (Bip_KeyTimeArray[a]-loopLength) >= (Bip_KeyTimeArray[1]) then
								(
									test_KeyCount = "Bad"
									format "- !!! Horizontal has a bad loop key \n"
									exit
								)
						)

						for b in 2 to Bip_KeyTimeArray.count do
							(
								if (Bip_KeyTimeArray[b]+loopLength) <= Bip_KeyTimeArray[Bip_KeyTimeArray.count] then
									(
										test_KeyCount = "Bad"
										format "  !!! Horizontal has a bad loop key - \n"
										exit
									)
							)


						/* 찌꺼기 검사를 통과하면 포즈 붙여넣기 실행 */
						if test_KeyCount == "Good" do
							(
								/* 사이드 루프 영역 왼쪽에 Horizontal 키 넣기 */
								for a in 1 to Bip_KeyTimeArray.count-1 do
								(
									biped.addNewKey BIP ((Bip_KeyTimeArray[a])-loopLength)
								)
								/* 사이드 루프 영역 오른쪽에 Horizontal 키 넣기 */
								for a in 2 to Bip_KeyTimeArray.count do
								(
									biped.addNewKey BIP ((Bip_KeyTimeArray[a])+loopLength)
								)


								/* 키 프로퍼티 배열 정리하는 반복문 */
								Bip_Properties = for b in 1 to Bip_Key.count collect
									(
										biped.getKey BIP b
									)

								/* 키 프러퍼티들을 왼쪽으로 복사하는 반복문 */
								for c in 1 to (before_KeyCount-1) do
								(
									BIP_Properties[c].x = BIP_Properties[((c+before_KeyCount)-1)].x
									BIP_Properties[c].y = BIP_Properties[((c+before_KeyCount)-1)].y

									BIP_Properties[c].tension = BIP_Properties[((c+before_KeyCount)-1)].tension
									BIP_Properties[c].continuity = BIP_Properties[((c+before_KeyCount)-1)].continuity
									BIP_Properties[c].bias = BIP_Properties[((c+before_KeyCount)-1)].bias
									BIP_Properties[c].easeTo = BIP_Properties[((c+before_KeyCount)-1)].easeTo
									BIP_Properties[c].easeFrom = BIP_Properties[((c+before_KeyCount)-1)].easeFrom
									BIP_Properties[c].balanceFactor = BIP_Properties[((c+before_KeyCount)-1)].balanceFactor
								)
								/* 키 프러퍼티들을 오른쪽으로복사하는 반복문 */
								for c in (before_KeyCount*2) to Bip_Key.count do
								(
									BIP_Properties[c].x = BIP_Properties[((c-before_KeyCount) + 1)].x
									BIP_Properties[c].y = BIP_Properties[((c-before_KeyCount) + 1)].y

									BIP_Properties[c].tension = BIP_Properties[((c-before_KeyCount) + 1)].tension
									BIP_Properties[c].continuity = BIP_Properties[((c-before_KeyCount) + 1)].continuity
									BIP_Properties[c].bias = BIP_Properties[((c-before_KeyCount) + 1)].bias
									BIP_Properties[c].easeTo = BIP_Properties[((c-before_KeyCount) + 1)].easeTo
									BIP_Properties[c].easeFrom = BIP_Properties[((c-before_KeyCount) + 1)].easeFrom
									BIP_Properties[c].balanceFactor = BIP_Properties[((c-before_KeyCount) + 1)].balanceFactor
								)
								format "Horizontal Key for loop side \n"
							)
				)
			)
			/* bip001 Turning Key 사이드루프 영역에 복사 */
			fn sideLoop_copy_bipTurning =
			(
				local BIP = target_Tur	-- Bip 선택
				local Bip_Key = target_Tur.keys	-- 키 배열

				local Bip_KeyTimeArray = #()	-- 원본 키 타임 배열 선언
				local before_KeyCount = Bip_Key.count	-- 대칭 복사하기 전의 키 갯수를 저장

				local Bip_Properties = #()	-- 키 프로퍼티의 배열 선언

				/* 만약에 key가 없으면 실행 중지 */
			if before_KeyCount == 0 then format "!!! Turning Key zero \n" else
				(
					/* 원본 키 타임 배열을 Bip_KeyTimeArray에 저장 */
					Bip_KeyTimeArray = for a in 1 to Bip_Key.count collect
					(
						Bip_Key[a].time
					)


					/* 포즈를 붙여넣기 전에 찌거기 Key가 없는지 조사 */
					local test_KeyCount = "Good"

					for a in 1 to Bip_KeyTimeArray.count-1 do
					(
						if (Bip_KeyTimeArray[a]-loopLength) >= (Bip_KeyTimeArray[1]) then
							(
								test_KeyCount = "Bad"
								format "- !!! Turning has a bad loop key \n"
								exit
							)
					)

					for b in 2 to Bip_KeyTimeArray.count do
						(
							if (Bip_KeyTimeArray[b]+loopLength) <= Bip_KeyTimeArray[Bip_KeyTimeArray.count] then
								(
									test_KeyCount = "Bad"
									format "  !!! Turning has a bad loop key - \n"
									exit
								)
						)


					/* 찌꺼기 검사를 통과하면 포즈 붙여넣기 실행 */
					if test_KeyCount == "Good" do
						(
							/* 사이드 루프 영역 왼쪽에 turning 키 넣기 */
							for a in 1 to Bip_KeyTimeArray.count-1 do
							(
								biped.addNewKey BIP ((Bip_KeyTimeArray[a])-loopLength)
							)
							/* 사이드 루프 영역 오른쪽에 turning 키 넣기 */
							for a in 2 to Bip_KeyTimeArray.count do
							(
								biped.addNewKey BIP ((Bip_KeyTimeArray[a])+loopLength)
							)


							/* 키 프로퍼티 배열 정리하는 반복문 */
							Bip_Properties = for b in 1 to Bip_Key.count collect
								(
									biped.getKey BIP b
								)

							/* 키 프러퍼티들을 왼쪽으로 복사하는 반복문 */
							for c in 1 to (before_KeyCount-1) do
							(
								BIP_Properties[c].rotation = BIP_Properties[((c+before_KeyCount)-1)].rotation

								BIP_Properties[c].tension = BIP_Properties[((c+before_KeyCount)-1)].tension
								BIP_Properties[c].continuity = BIP_Properties[((c+before_KeyCount)-1)].continuity
								BIP_Properties[c].bias = BIP_Properties[((c+before_KeyCount)-1)].bias
								BIP_Properties[c].easeTo = BIP_Properties[((c+before_KeyCount)-1)].easeTo
								BIP_Properties[c].easeFrom = BIP_Properties[((c+before_KeyCount)-1)].easeFrom
							)
							/* 키 프러퍼티들을 오른쪽으로 복사하는 반복문 */
							for c in (before_KeyCount*2) to Bip_Key.count do
							(
								BIP_Properties[c].rotation = BIP_Properties[((c-before_KeyCount)+1)].rotation

								BIP_Properties[c].tension = BIP_Properties[((c-before_KeyCount)+1)].tension
								BIP_Properties[c].continuity = BIP_Properties[((c-before_KeyCount)+1)].continuity
								BIP_Properties[c].bias = BIP_Properties[((c-before_KeyCount)+1)].bias
								BIP_Properties[c].easeTo = BIP_Properties[((c-before_KeyCount)+1)].easeTo
								BIP_Properties[c].easeFrom = BIP_Properties[((c-before_KeyCount)+1)].easeFrom
							)

							format "Turning Key for loop side \n"
						)
				)
			)

			/* 바이패드 Key 사이드루프 영역에 복사 - 공용 Separate: OFF - */
			fn sideLoop_copy_Common targetName targetNameArray =
			(
				local targetName = targetName
				-- local targetNameArray = targetNameArray
				local BIP = targetName.controller	-- Bip 선택
				local Bip_Key = BIP.keys	-- 키 배열

				local Bip_KeyTimeArray = #()	-- 원본 키 타임 배열 선언
				local before_KeyCount = Bip_Key.count	-- 대칭 복사하기 전의 키 갯수를 저장

				local Bip_Properties = #()	-- 키 프로퍼티의 배열 선언

				local t_Name = targetName.name as string


				/* 만약에 key가 없으면 실행 중지 */
			if before_KeyCount == 0 then format "!!! % Key zero \n" t_Name else
				(

					/* 원본 키 타임 배열을 Bip_KeyTimeArray에 저장 */
					Bip_KeyTimeArray = for a in 1 to Bip_Key.count collect
					(
						Bip_Key[a].time
					)

						/* 포즈를 붙여넣기 전에 찌거기 Key가 없는지 조사 */
						local test_KeyCount = "Good"

						for a in 1 to Bip_KeyTimeArray.count-1 do
						(
							if (Bip_KeyTimeArray[a]-loopLength) >= (Bip_KeyTimeArray[1]) then
								(
									test_KeyCount = "Bad"
									format "  - !!! % has a bad loop key \n" t_Name
									exit
								)
						)

						for b in 2 to Bip_KeyTimeArray.count do
							(
								if (Bip_KeyTimeArray[b]+loopLength) <= Bip_KeyTimeArray[Bip_KeyTimeArray.count] then
									(
										test_KeyCount = "Bad"
										format "    !!! % has a bad loop key - \n" t_Name
										exit
									)
							)

						/* 찌꺼기 검사를 통과하면 포즈 붙여넣기 실행 */
						if test_KeyCount == "Good" do
							(

								----------------------------------------
								for t in 1 to targetNameArray.count do
									(
										/* 원본 키 회전 값을 Bip_KeyValuesArray 에 저장 */
										local Bip_KeyValuesArray = for a in 1 to Bip_KeyTimeArray.count collect
										(
											sliderTime = Bip_KeyTimeArray[a]
											biped.getTransform targetNameArray[t] #rotation
										)

										/* 포즈를 사이드루프 영역 왼쪽에 붙여넣는 반복문*/
										for a in 1 to Bip_KeyValuesArray.count-1 do
										(
											sliderTime = ((Bip_KeyTimeArray[a])-loopLength)
											biped.setTransform targetNameArray[t] #rotation Bip_KeyValuesArray[a] on
										)

										/* 포즈를 사이드루프 영역 오른쪽에 붙여넣는 반복문*/
										for a in 2 to Bip_KeyValuesArray.count do
										(
											sliderTime = ((Bip_KeyTimeArray[a])+loopLength)
											biped.setTransform targetNameArray[t] #rotation Bip_KeyValuesArray[a] on
										)
									)

								----------------------------------------

								/* 키 프로퍼티 배열 정리하는 반복문 */
								Bip_Properties = for b in 1 to Bip_Key.count collect
									(
										biped.getKey BIP b
									)

								/* 키 프러퍼티들을 왼쪽으로 복사하는 반복문 */
								for c in 1 to (before_KeyCount-1) do
								(
									BIP_Properties[c].tension = BIP_Properties[((c+before_KeyCount)-1)].tension
									BIP_Properties[c].continuity = BIP_Properties[((c+before_KeyCount)-1)].continuity
									BIP_Properties[c].bias = BIP_Properties[((c+before_KeyCount)-1)].bias
									BIP_Properties[c].easeTo = BIP_Properties[((c+before_KeyCount)-1)].easeTo
									BIP_Properties[c].easeFrom = BIP_Properties[((c+before_KeyCount)-1)].easeFrom
								)
								/* 키 프러퍼티들을 오른쪽으로 복사하는 반복문 */
								for c in (before_KeyCount*2) to Bip_Key.count do
								(
									BIP_Properties[c].tension = BIP_Properties[((c-before_KeyCount)+1)].tension
									BIP_Properties[c].continuity = BIP_Properties[((c-before_KeyCount)+1)].continuity
									BIP_Properties[c].bias = BIP_Properties[((c-before_KeyCount)+1)].bias
									BIP_Properties[c].easeTo = BIP_Properties[((c-before_KeyCount)+1)].easeTo
									BIP_Properties[c].easeFrom = BIP_Properties[((c-before_KeyCount)+1)].easeFrom
								)

								format "  % Key for loop side - Separate:Off \n" t_Name
							)
				)
			)

			/* 바이패드 Key 사이드루프 영역에 복사 - 공용 Separate: ON - */
			fn sideLoop_copy_Common_SeparateON targetArray =
			(
				for t in 1 to targetArray.count do
					(
						local targetName = targetArray[t]
						local BIP = targetName.controller	-- Bip 선택
						local Bip_Key = BIP.keys	-- 키 배열

						local Bip_KeyTimeArray = #()	-- 원본 키 타임 배열 선언
						local before_KeyCount = Bip_Key.count	-- 대칭 복사하기 전의 키 갯수를 저장

						local Bip_Properties = #()	-- 키 프로퍼티의 배열 선언

						local t_Name = targetName.name as string

					/* 만약에 key가 없으면 실행 중지 */
					if before_KeyCount == 0 then format "!!! % Key zero \n" t_Name else
						(

							/* 원본 키 타임 배열을 Bip_KeyTimeArray에 저장 */
							Bip_KeyTimeArray = for a in 1 to Bip_Key.count collect
							(
								Bip_Key[a].time
							)

								/* 포즈를 붙여넣기 전에 찌거기 Key가 없는지 조사 */
								local test_KeyCount = "Good"

								for a in 1 to Bip_KeyTimeArray.count-1 do
								(
									if (Bip_KeyTimeArray[a]-loopLength) >= (Bip_KeyTimeArray[1]) then
										(
											test_KeyCount = "Bad"
											format "  - !!! % has a bad loop key \n" t_Name
											exit
										)
								)

								for b in 2 to Bip_KeyTimeArray.count do
									(
										if (Bip_KeyTimeArray[b]+loopLength) <= Bip_KeyTimeArray[Bip_KeyTimeArray.count] then
											(
												test_KeyCount = "Bad"
												format "    !!! % has a bad loop key - \n" t_Name
												exit
											)
									)

								/* 찌꺼기 검사를 통과하면 포즈 붙여넣기 실행 */
								if test_KeyCount == "Good" do
									(

										----------------------------------------
										/* 원본 키 회전 값을 Bip_KeyValuesArray 에 저장 */
										local Bip_KeyValuesArray = for a in 1 to Bip_KeyTimeArray.count collect
										(
											sliderTime = Bip_KeyTimeArray[a]
											biped.getTransform targetName #rotation
										)

										/* 포즈를 사이드루프 영역 왼쪽에 붙여넣는 반복문*/
										for a in 1 to Bip_KeyValuesArray.count-1 do
										(
											sliderTime = ((Bip_KeyTimeArray[a])-loopLength)
											biped.setTransform targetName #rotation Bip_KeyValuesArray[a] on
										)
										/* 포즈를 사이드루프 영역 오른쪽에 붙여넣는 반복문*/
										for a in 2 to Bip_KeyValuesArray.count do
										(
											sliderTime = ((Bip_KeyTimeArray[a])+loopLength)
											biped.setTransform targetName #rotation Bip_KeyValuesArray[a] on
										)
										----------------------------------------

										/* 키 프로퍼티 배열 정리하는 반복문 */
										Bip_Properties = for b in 1 to Bip_Key.count collect
											(
												biped.getKey BIP b
											)

										/* 키 프러퍼티들을 왼쪽으로 복사하는 반복문 */
										for c in 1 to (before_KeyCount-1) do
										(
											BIP_Properties[c].tension = BIP_Properties[((c+before_KeyCount)-1)].tension
											BIP_Properties[c].continuity = BIP_Properties[((c+before_KeyCount)-1)].continuity
											BIP_Properties[c].bias = BIP_Properties[((c+before_KeyCount)-1)].bias
											BIP_Properties[c].easeTo = BIP_Properties[((c+before_KeyCount)-1)].easeTo
											BIP_Properties[c].easeFrom = BIP_Properties[((c+before_KeyCount)-1)].easeFrom
										)
										/* 키 프러퍼티들을 오른쪽으로 복사하는 반복문 */
										for c in (before_KeyCount*2) to Bip_Key.count do
										(
											BIP_Properties[c].tension = BIP_Properties[((c-before_KeyCount)+1)].tension
											BIP_Properties[c].continuity = BIP_Properties[((c-before_KeyCount)+1)].continuity
											BIP_Properties[c].bias = BIP_Properties[((c-before_KeyCount)+1)].bias
											BIP_Properties[c].easeTo = BIP_Properties[((c-before_KeyCount)+1)].easeTo
											BIP_Properties[c].easeFrom = BIP_Properties[((c-before_KeyCount)+1)].easeFrom
										)
										format "  % Key for loop side - Separate:On \n" t_Name
									)
						)
					)
			)
			/* 바이패드 Key 사이드루프 영역에 복사 - 팔 다리 Separate: OFF - */
			fn sideLoop_copy_Common_LegArm targetName targetNamePart =
			(
				local targetName = targetName
				local targetNamePart = targetNamePart
				local BIP = targetName.controller	-- Bip 선택
				local Bip_Key = BIP.keys	-- 키 배열

				local Bip_KeyTimeArray = #()	-- 원본 키 타임 배열 선언
				local before_KeyCount = Bip_Key.count	-- 대칭 복사하기 전의 키 갯수를 저장

				local Bip_Properties = #()	-- 키 프로퍼티의 배열 선언

				local t_Name = targetName.name as string


				/* 만약에 key가 없으면 실행 중지 */
			if before_KeyCount == 0 then format "!!! % Key zero \n" t_Name else
				(
					/* 원본 키 타임 배열을 Bip_KeyTimeArray에 저장 */
					Bip_KeyTimeArray = for a in 1 to Bip_Key.count collect
					(
						Bip_Key[a].time
					)


						/* 포즈를 붙여넣기 전에 찌거기 Key가 없는지 조사 */
						local test_KeyCount = "Good"

						for a in 1 to Bip_KeyTimeArray.count-1 do
						(
							if (Bip_KeyTimeArray[a]-loopLength) >= (Bip_KeyTimeArray[1]) then
								(
									test_KeyCount = "Bad"
									format "\t- !!! % has a bad loop key \n" t_Name
									exit
								)
						)

						for b in 2 to Bip_KeyTimeArray.count do
							(
								if (Bip_KeyTimeArray[b]+loopLength) <= Bip_KeyTimeArray[Bip_KeyTimeArray.count] then
									(
										test_KeyCount = "Bad"
										format "\t  !!! % has a bad loop key - \n" t_Name
										exit
									)
							)

						/* 찌꺼기 검사를 통과하면 포즈 붙여넣기 실행 */
						if test_KeyCount == "Good" do
							(

								select targetNamePart	-- 카피할 바이패드 부위를 선택
								biped.createCopyCollection BIP t_Name	-- 대칭복사 하기 위한 포즈 콜렉션 만들기

								/* 포즈를 대칭 복사하는 반복문*/
								Bip_KeyTimeArray = for a in 1 to Bip_Key.count collect
								(
									sliderTime = (Bip_Key[a].time)
									biped.copyPosture BIP #posture off off off -- bool_horiz:on off, bool_vert:on off, bool_turn:on off
									Bip_Key[a].time
								)
								/* 포즈를 사이드루프 영역 왼쪽에 붙여넣는 반복문*/
								for a in 1 to Bip_KeyTimeArray.count-1 do
								(
									sliderTime = ((Bip_KeyTimeArray[a])-loopLength)
									biped.pastePosture BIP #posture off (biped.getCopyName BIP #posture a)	-- 이름으로 저장된 포즈 Paste 하기. -- on off 는 대칭복사 on off
								)
								/* 포즈를 사이드루프 영역 오른쪽에 붙여넣는 반복문*/
								for a in 2 to Bip_KeyTimeArray.count do
								(
									sliderTime = ((Bip_KeyTimeArray[a])+loopLength)
									biped.pastePosture BIP #posture off (biped.getCopyName BIP #posture a)	-- 이름으로 저장된 포즈 Paste 하기. -- on off 는 대칭복사 on off
								)

								biped.deleteCopyCollection BIP (biped.numCopyCollections BIP)	-- 대칭복사하기 위해 만든 콜렉션 삭제


									/* 키 프로퍼티 배열 정리하는 반복문 */
									Bip_Properties = for b in 1 to Bip_Key.count collect
										(
											biped.getKey BIP b
										)

									/* 키 프러퍼티들을 왼쪽으로 복사하는 반복문 */
									for c in 1 to (before_KeyCount-1) do
									(
										BIP_Properties[c].tension = BIP_Properties[((c+before_KeyCount)-1)].tension
										BIP_Properties[c].continuity = BIP_Properties[((c+before_KeyCount)-1)].continuity
										BIP_Properties[c].bias = BIP_Properties[((c+before_KeyCount)-1)].bias
										BIP_Properties[c].easeTo = BIP_Properties[((c+before_KeyCount)-1)].easeTo
										BIP_Properties[c].easeFrom = BIP_Properties[((c+before_KeyCount)-1)].easeFrom
										BIP_Properties[c].ikBlend = BIP_Properties[((c+before_KeyCount)-1)].ikBlend
										BIP_Properties[c].ikSpace = BIP_Properties[((c+before_KeyCount)-1)].ikSpace
										BIP_Properties[c].ikAnkleTension = BIP_Properties[((c+before_KeyCount)-1)].ikAnkleTension
										BIP_Properties[c].ikJoinedPivot = BIP_Properties[((c+before_KeyCount)-1)].ikJoinedPivot
										BIP_Properties[c].ikPivotIndex = BIP_Properties[((c+before_KeyCount)-1)].ikPivotIndex

									)
									/* 키 프러퍼티들을 오른쪽으로 복사하는 반복문 */
									for c in (before_KeyCount*2) to Bip_Key.count do
									(
										BIP_Properties[c].tension = BIP_Properties[((c-before_KeyCount)+1)].tension
										BIP_Properties[c].continuity = BIP_Properties[((c-before_KeyCount)+1)].continuity
										BIP_Properties[c].bias = BIP_Properties[((c-before_KeyCount)+1)].bias
										BIP_Properties[c].easeTo = BIP_Properties[((c-before_KeyCount)+1)].easeTo
										BIP_Properties[c].easeFrom = BIP_Properties[((c-before_KeyCount)+1)].easeFrom
										BIP_Properties[c].ikBlend = BIP_Properties[((c-before_KeyCount)+1)].ikBlend
										BIP_Properties[c].ikSpace = BIP_Properties[((c-before_KeyCount)+1)].ikSpace
										BIP_Properties[c].ikAnkleTension = BIP_Properties[((c-before_KeyCount)+1)].ikAnkleTension
										BIP_Properties[c].ikJoinedPivot = BIP_Properties[((c-before_KeyCount)+1)].ikJoinedPivot
										BIP_Properties[c].ikPivotIndex = BIP_Properties[((c-before_KeyCount)+1)].ikPivotIndex
									)
									/* bip 디스플레이 오류를 방지하기 위해 오른쪽 다리 처음 키에 set key를 줌 */
									(

										sliderTime = (BIP_Properties[before_KeyCount].time)
										select targetName
										actionMan.executeAction 972555510 "40015"  -- Biped: Set Key
									)

									format "\t% Key for loop side - Separate:Off \n" t_Name
							)
				)
			)
			/* 바이패드 Key 사이드루프 영역에 복사 - 팔 다리 Separate: ON - */
			fn sideLoop_copy_Common_LegArm_SeparateON targetArray =
			(
				for t in 1 to targetArray.count do
					(
						local targetName = targetArray[t]
						local BIP = targetName.controller	-- Bip 선택
						local Bip_Key = BIP.keys	-- 키 배열

						local Bip_KeyTimeArray = #()	-- 원본 키 타임 배열 선언
						local before_KeyCount = Bip_Key.count	-- 대칭 복사하기 전의 키 갯수를 저장

						local Bip_Properties = #()	-- 키 프로퍼티의 배열 선언
						local t_Name = targetName.name as string

						/* 만약에 key가 없으면 실행 중지 */
						if before_KeyCount == 0 then format "!!! % Key zero \n" t_Name else
						(
								/* 원본 키 타임 배열을 Bip_KeyTimeArray에 저장 */
								Bip_KeyTimeArray = for a in 1 to Bip_Key.count collect
								(
									Bip_Key[a].time
								)

							/* 포즈를 붙여넣기 전에 찌거기 Key가 없는지 조사 */
								local test_KeyCount = "Good"

								for a in 1 to Bip_KeyTimeArray.count-1 do
								(
									if (Bip_KeyTimeArray[a]-loopLength) >= (Bip_KeyTimeArray[1]) then
										(
											test_KeyCount = "Bad"
											format "\t- !!! % has a bad loop key \n" t_Name
											exit
										)
								)

								for b in 2 to Bip_KeyTimeArray.count do
									(
										if (Bip_KeyTimeArray[b]+loopLength) <= Bip_KeyTimeArray[Bip_KeyTimeArray.count] then
											(
												test_KeyCount = "Bad"
												format "\t  !!! % has a bad loop key - \n" t_Name
												exit
											)
									)



							/* 찌꺼기 검사를 통과하면 포즈 붙여넣기 실행 */
							if test_KeyCount == "Good" do
							(

								----------------------------------------

									/* 원본 키 값을 Bip_Key_rotation_ValuesArray 에 저장 */
									local Bip_Key_rotation_ValuesArray = for a in 1 to Bip_KeyTimeArray.count collect
									(
										sliderTime = Bip_KeyTimeArray[a]
										biped.getTransform targetArray[t] #rotation
									)

									/* 포즈를 사이드루프 영역 왼쪽에 붙여넣는 반복문*/
									for a in 1 to Bip_Key_rotation_ValuesArray.count-1 do
									(
										sliderTime = ((Bip_KeyTimeArray[a])-loopLength)
										biped.setTransform targetArray[t] #rotation Bip_Key_rotation_ValuesArray[a] on
									)

									/* 포즈를 사이드루프 영역 오른쪽에 붙여넣는 반복문*/
									for a in 2 to Bip_Key_rotation_ValuesArray.count do
									(
										sliderTime = ((Bip_KeyTimeArray[a])+loopLength)
										biped.setTransform targetArray[t] #rotation Bip_Key_rotation_ValuesArray[a] on
									)

								----------------------------------------


										/* 키 프로퍼티 배열 정리하는 반복문 */
										Bip_Properties = for b in 1 to Bip_Key.count collect
											(
												biped.getKey BIP b
											)

										/* 키 프러퍼티들을 왼쪽으로 복사하는 반복문 */
										for c in 1 to (before_KeyCount-1) do
										(
											BIP_Properties[c].tension = BIP_Properties[((c+before_KeyCount)-1)].tension
											BIP_Properties[c].continuity = BIP_Properties[((c+before_KeyCount)-1)].continuity
											BIP_Properties[c].bias = BIP_Properties[((c+before_KeyCount)-1)].bias
											BIP_Properties[c].easeTo = BIP_Properties[((c+before_KeyCount)-1)].easeTo
											BIP_Properties[c].easeFrom = BIP_Properties[((c+before_KeyCount)-1)].easeFrom
											BIP_Properties[c].ikSpace = BIP_Properties[((c+before_KeyCount)-1)].ikSpace
											BIP_Properties[c].ikAnkleTension = BIP_Properties[((c+before_KeyCount)-1)].ikAnkleTension
											BIP_Properties[c].ikJoinedPivot = BIP_Properties[((c+before_KeyCount)-1)].ikJoinedPivot
											BIP_Properties[c].ikPivotIndex = BIP_Properties[((c+before_KeyCount)-1)].ikPivotIndex

											/* 팔과 다리의 마지막 파트일 때만 ik 정보를 복사 */
											if targetArray[t] == targetArray[targetArray.count] do
												(
													BIP_Properties[c].ikBlend = BIP_Properties[((c+before_KeyCount)-1)].ikBlend

												)


										)
										/* 키 프러퍼티들을 오른쪽으로 복사하는 반복문 */
										for c in (before_KeyCount*2) to Bip_Key.count do
										(
											BIP_Properties[c].tension = BIP_Properties[((c-before_KeyCount)+1)].tension
											BIP_Properties[c].continuity = BIP_Properties[((c-before_KeyCount)+1)].continuity
											BIP_Properties[c].bias = BIP_Properties[((c-before_KeyCount)+1)].bias
											BIP_Properties[c].easeTo = BIP_Properties[((c-before_KeyCount)+1)].easeTo
											BIP_Properties[c].easeFrom = BIP_Properties[((c-before_KeyCount)+1)].easeFrom
											BIP_Properties[c].ikSpace = BIP_Properties[((c-before_KeyCount)+1)].ikSpace
											BIP_Properties[c].ikAnkleTension = BIP_Properties[((c-before_KeyCount)+1)].ikAnkleTension
											BIP_Properties[c].ikJoinedPivot = BIP_Properties[((c-before_KeyCount)+1)].ikJoinedPivot
											BIP_Properties[c].ikPivotIndex = BIP_Properties[((c-before_KeyCount)+1)].ikPivotIndex

											/* 팔과 다리의 마지막 파트일 때만 ik 정보를 복사 */
											if targetArray[t] == targetArray[targetArray.count] do
												(
													BIP_Properties[c].ikBlend = BIP_Properties[((c-before_KeyCount)+1)].ikBlend

												)
										)
										/* bip 디스플레이 오류를 방지하기 위해 오른쪽 다리 처음 키에 set key를 줌 */
										(

											sliderTime = (BIP_Properties[before_KeyCount].time)
											select targetName
											actionMan.executeAction 972555510 "40015"  -- Biped: Set Key
										)

										format "\t% Key for loop side - Separate:On \n" t_Name
							)

						)
					)
			)

	/* 각 부위별 바이패트 키 복사 실행하는 함수 */
	fn Bip_LoopSideKey =
	(
		play_LoopSideArea()	-- 작업 영역 확장
		local current_animationRange = animationRange
		animationRange  = (interval ((animationRange.start)-(loopLength*3)) ((animationRange.end)+(loopLength*3)))

			/* bip001 버티칼 호라이즌 회전 키 좌우 복사 */
			(
				sideLoop_copy_bipVertical()
				sideLoop_copy_bipHorizontal()
				sideLoop_copy_bipTurning()
			)

				/* 골반 키 좌우 복사 */
				(
					local bip_pelvis = #(target_pelvis)

					sideLoop_copy_Common target_pelvis bip_pelvis
				)
					/* 몸통 허리 키 좌우 복사 */
						/* Spine Separate이 꺼져 있는 경우 */
					if target_Bip.controller.sepSpineTracks == false then
					(
						Bip_spine_PartArray()
						sideLoop_copy_Common target_spine Spine_PartArray
					)

								/* Spine Separate이 켜져 있는 경우 */
						else if target_Bip.controller.sepSpineTracks == true then
							(

								Bip_spine_PartArray()
								sideLoop_copy_Common_SeparateON Spine_PartArray
							)

								/* 목 키 좌우 복사 */
								(
									/* neckHead Separate이 꺼져 있는 경우 */
									if target_Bip.controller.sepNeckTracks == false then
										(
											sideLoop_copy_Common target_neck (Bip_neckHead_PartArray target_Bip)
										)
									/* neckHead Separate이 꺼져 있는 경우 */
									if target_Bip.controller.sepNeckTracks == true then
										(
											sideLoop_copy_Common_SeparateON (Bip_neckHead_PartArray target_Bip)
										)
								)

									/* 왼 다리 키 좌우 복사 */
									(
											/* Lleg Separate이 꺼져 있는 경우 */
										if (biped.getNode target_Bip #lleg != undefined and target_Bip.controller.sepLegsTracks == false) then
											(
												sideLoop_copy_Common_LegArm target_lleg (Bip_L_legToe_PartArray target_Bip)
											)
											/* Lleg Separate이 켜져 있는 경우 */
										else if (biped.getNode target_Bip #lleg != undefined and target_Bip.controller.sepLegsTracks == true) then
										(
											sideLoop_copy_Common_LegArm_SeparateON (Bip_L_legToe_PartArray target_Bip)
										)

									)
									/* 오른 다리 키 좌우 복사 */
									(
											/* Rleg Separate이 꺼져 있는 경우 */
										if (biped.getNode target_Bip #rleg != undefined and target_Bip.controller.sepLegsTracks == false) then
											(
												sideLoop_copy_Common_LegArm target_rleg (Bip_R_legToe_PartArray target_Bip)
											)
											/* Rleg Separate이 켜져 있는 경우 */
										else if (biped.getNode target_Bip #rleg != undefined and target_Bip.controller.sepLegsTracks == true) then
										(

											sideLoop_copy_Common_LegArm_SeparateON (Bip_R_legToe_PartArray target_Bip)
										)
									)

											/* 왼쪽 팔 Separate이 꺼져 있는 경우 */
										if (biped.getNode target_Bip #larm != undefined and target_Bip.controller.sepArmsTracks == false) then
											(
												sideLoop_copy_Common_LegArm target_larm (Bip_L_armFingers_PartArray target_Bip)
											)

													/* 왼쪽 팔 Separate이 켜져 있는 경우 */
											else if (biped.getNode target_Bip #larm != undefined and target_Bip.controller.sepArmsTracks == true) then
												(
													Bip_Arm_PartArray()
													sideLoop_copy_Common_LegArm_SeparateON L_arm_PartArray
												)
											/* 오른쪽 팔 Separate이 꺼져 있는 경우 */
										if (biped.getNode target_Bip #rarm != undefined and target_Bip.controller.sepArmsTracks == false) then
											(
												sideLoop_copy_Common_LegArm target_rarm (Bip_R_armFingers_PartArray target_Bip)
											)

														/* 오른쪽 팔 Separate이 켜져 있는 경우 */
												else if (biped.getNode target_Bip #rarm != undefined and target_Bip.controller.sepArmsTracks == true) then
													(
														sideLoop_copy_Common_LegArm_SeparateON R_arm_PartArray
													)

													/* 꼬리 키 좌우 복사 */
														/* 꼬리 Separate이 꺼져 있는 경우 */
													if (biped.getNode target_Bip #tail != undefined and target_Bip.controller.sepTailTracks == false) then
														(
															Bip_Tail_PartArray()

															sideLoop_copy_Common target_tail Tail_PartArray

														)
															/* 꼬리 Separate이 껴져 있는 경우 */
														else if (biped.getNode target_Bip #tail != undefined and target_Bip.controller.sepTailTracks == true) then
															(
																Bip_Tail_PartArray()

																sideLoop_copy_Common_SeparateON Tail_PartArray
															)

													/* 머리카락 1 키 좌우 복사 */
														/* 머리카락 1  Separate이 꺼져 있는 경우 */
													if (biped.getNode target_Bip #pony1 != undefined and target_Bip.controller.sepPonytail1Tracks == false) then
														(
															Bip_Ponytail1_PartArray()

															sideLoop_copy_Common target_pony1 Ponytail1_PartArray
														)
																/* 머리카락 1 Separate이 켜져 있는 경우 */
														else if (biped.getNode target_Bip #pony1 != undefined and target_Bip.controller.sepPonytail1Tracks == true) then
															(
																Bip_Ponytail1_PartArray()

																sideLoop_copy_Common_SeparateON Ponytail1_PartArray
															)

													/* 머리카락 2 키 좌우 복사 */
														/* 머리카락 2  Separate이 꺼져 있는 경우 */
													if (biped.getNode target_Bip #pony2 != undefined and target_Bip.controller.sepPonytail2Tracks == false) then
														(
															Bip_Ponytail2_PartArray()

															sideLoop_copy_Common target_pony2 Ponytail2_PartArray
														)
															/* 머리카락 2 Separate이 켜져 있는 경우 */
														else if (biped.getNode target_Bip #pony2 != undefined and target_Bip.controller.sepPonytail2Tracks == true) then
															(
																Bip_Ponytail2_PartArray()

																sideLoop_copy_Common_SeparateON Ponytail2_PartArray
															)

-- 															/* 프롭 1 키 좌우 복사 */
-- 															if biped.getNode target_Bip #prop1 != undefined then
-- 																(
-- 																	sideLoop_copy_Common target_prop1 target_prop1
-- 																)
		animationRange  = current_animationRange
		play_LoopArea()	-- 확장했던 작업 영역을 되돌림
	)




/* -------------------------------- ------------------------------ ---------------------------------------- ------------------------------- */
/* -------------------------------- ------------------------------ ---------------------------------------- ------------------------------- */
/* -------------------------------- ------------------------------ ---------------------------------------- ------------------------------- */


	basicRange()


/* 함수 - Run_Walking_SymmetryPattern 을 준비하는 함수 */
fn bip_PoseSymmetry_WarmUp =
(
	actionMan.executeAction 0 "40180"  -- Selection: Select Children
	local obj = getCurrentSelection()


	if obj.count == 0 then
		(
			print " ------- No Selection ------- \t"
		)

		else
			(
				basicRange()

				local sort_Bip_Obj = #()
				local sort_Bone_Obj = #()

				/* 선택한 오브젝트 중에서 bip001을 제외한 바이패드 오브젝트만 모아, sort_Bip_Obj 배열을 만듬 */
				sort_Bip_Obj = for A in 1 to obj.count where (classOf obj[A] == Biped_Object and obj[A] != obj[A].controller.rootnode) collect
				(
					obj[A]
				)
				/* 선택한 오브젝트 중에서 비이패드가 아닌 것만 따로 분리하여 sort_Bone_Obj 배열을 만듬 */
				sort_Bone_Obj = for A in 1 to obj.count where (classOf obj[A] != Biped_Object) collect
				(
					obj[A]
				)

				/* 선택한 바이패드 중에서 첫번째를 선택하고 Bip_targetArray() 함수를 실행 */
				if sort_Bip_Obj.count != 0 do select sort_Bip_Obj[1]
					Bip_targetArray()

					max motion mode

					biped.deleteAllCopyCollections target_Ver	-- 오류를 방지하기 위해 모든 포즈 Collections 을 삭제

					if animButtonState == false do max tool animmode
			)
)
/* ------- Biped 각 파트별 Run_Walking_SymmetryPattern --------- */

/* 함수 - bip vertical 사이클 복사 - Forward */
fn bip_vertical_Forward =
(
	/* 미들 타임 이후의 키를 선택해서 모두 지움 */
	selectKeys target_Ver
	-- actionMan.executeAction 972555510 "40020"  -- Biped: Select Body Vertical
	deselectKeys target_Ver (interval C_Start middle_Time)
	biped.deleteKeys target_Ver #selection

	local BIP = target_Ver	-- Bip 선택
	local Bip_Key = target_Ver.keys	-- 키 배열

	local Bip_KeyTimeArray = #()	-- 원본 키 타임 배열 선언
	local before_KeyCount = Bip_Key.count	-- 대칭 복사하기 전의 키 갯수를 저장

	/* 만약에 key가 없으면 실행 중지 */
	if before_KeyCount == 0 then format "!!! Vertical Key zero \n" else
		(

			local Bip_Properties = #()	-- 키 프로퍼티의 배열 선언

				/* 원본 키 타임 배열을 Bip_KeyTimeArray에 저장 */
				Bip_KeyTimeArray = for a in 1 to Bip_Key.count collect
				(
					Bip_Key[a].time
				)
				/* 미들 타임 이후의 부분에 버티칼 키 넣기 */
				for a in 1 to Bip_KeyTimeArray.count do
				(
					biped.addNewKey BIP ((Bip_KeyTimeArray[a])+middle_Time)
				)

				/* 키 프로퍼티 배열 정리하는 반복문 */
				Bip_Properties = for b in 1 to Bip_Key.count collect
					(
						biped.getKey BIP b
					)

				/* 키 프러퍼티들을 복사하는 반복문 */
				for c in before_KeyCount to Bip_Key.count do
				(
					BIP_Properties[c].z = BIP_Properties[((c-before_KeyCount) + 1)].z
					BIP_Properties[c].tension = BIP_Properties[((c-before_KeyCount) + 1)].tension
					BIP_Properties[c].continuity = BIP_Properties[((c-before_KeyCount) + 1)].continuity
					BIP_Properties[c].bias = BIP_Properties[((c-before_KeyCount) + 1)].bias
					BIP_Properties[c].easeTo = BIP_Properties[((c-before_KeyCount) + 1)].easeTo
					BIP_Properties[c].easeFrom = BIP_Properties[((c-before_KeyCount) + 1)].easeFrom
					BIP_Properties[c].dynamicsBlend = BIP_Properties[((c-before_KeyCount) + 1)].dynamicsBlend
					BIP_Properties[c].ballisticTension = BIP_Properties[((c-before_KeyCount) + 1)].ballisticTension

				)
		)
)
	/* 함수 - bip vertical 사이클 복사 - Backward */
	fn bip_vertical_Backward =
	(
		/* 미들 타임 이후의 키를 선택해서 모두 지움 */
		selectKeys target_Ver
		-- actionMan.executeAction 972555510 "40020"  -- Biped: Select Body Vertical
		deselectKeys target_Ver (interval middle_Time C_End)
		biped.deleteKeys target_Ver #selection

		local BIP = target_Ver	-- Bip 선택
		local Bip_Key = target_Ver.keys	-- 키 배열

		local Bip_KeyTimeArray = #()	-- 원본 키 타임 배열 선언
		local before_KeyCount = Bip_Key.count	-- 대칭 복사하기 전의 키 갯수를 저장

		/* 만약에 key가 없으면 실행 중지 */
		if before_KeyCount == 0 then format "!!! Vertical Key zero \n" else
		(

			local Bip_Properties = #()	-- 키 프로퍼티의 배열 선언

			/* 원본 키 타임 배열을 Bip_KeyTimeArray에 저장 */
			Bip_KeyTimeArray = for a in 1 to Bip_Key.count collect
			(
				Bip_Key[a].time
			)
			/* 미들 타임 이후의 부분에 버티칼 키 넣기 */
			for a in 1 to Bip_KeyTimeArray.count do
			(
				biped.addNewKey BIP ((Bip_KeyTimeArray[a])-middle_Time)
			)

			/* 키 프로퍼티 배열 정리하는 반복문 */
			Bip_Properties = for b in 1 to Bip_Key.count collect
				(
					biped.getKey BIP b
				)

			/* 마지막 키 원래값을 보존 */
			(
				local c_z = BIP_Properties[Bip_Properties.count].z
				local c_tension = Bip_Properties[Bip_Properties.count].tension
				local c_continuity = Bip_Properties[Bip_Properties.count].continuity
				local c_bias = Bip_Properties[Bip_Properties.count].bias
				local c_easeTo = Bip_Properties[Bip_Properties.count].easeTo
				local c_easeFrom = Bip_Properties[Bip_Properties.count].easeFrom
				local c_dynamicsBlend = BIP_Properties[Bip_Properties.count].dynamicsBlend
				local c_ballisticTension = BIP_Properties[Bip_Properties.count].ballisticTension
			)

			/* 키 프러퍼티들을 복사하는 반복문 */
			for c in 1 to (before_KeyCount) do
			(
				BIP_Properties[c].z = BIP_Properties[((c+before_KeyCount)-1)].z
				BIP_Properties[c].tension = BIP_Properties[((c+before_KeyCount)-1)].tension
				BIP_Properties[c].continuity = BIP_Properties[((c+before_KeyCount)-1)].continuity
				BIP_Properties[c].bias = BIP_Properties[((c+before_KeyCount)-1)].bias
				BIP_Properties[c].easeTo = BIP_Properties[((c+before_KeyCount)-1)].easeTo
				BIP_Properties[c].easeFrom = BIP_Properties[((c+before_KeyCount)-1)].easeFrom
				BIP_Properties[c].dynamicsBlend = BIP_Properties[((c+before_KeyCount)-1)].dynamicsBlend
				BIP_Properties[c].ballisticTension = BIP_Properties[((c+before_KeyCount)-1)].ballisticTension
			)

			/* 복사가 완료되고, 마지막 키 값을 middle_Time과 첫번째 키값에 원래 값으로 돌려줌 */
			(
				Bip_Properties[1].z = c_z
				Bip_Properties[1].tension = c_tension
				Bip_Properties[1].continuity = c_continuity
				Bip_Properties[1].bias = c_bias
				Bip_Properties[1].easeTo = c_easeTo
				Bip_Properties[1].easeFrom = c_easeFrom
				Bip_Properties[1].dynamicsBlend = c_dynamicsBlend
				Bip_Properties[1].ballisticTension = c_ballisticTension

				Bip_Properties[(before_KeyCount)].z = c_z
				Bip_Properties[(before_KeyCount)].tension = c_tension
				Bip_Properties[(before_KeyCount)].continuity = c_continuity
				Bip_Properties[(before_KeyCount)].bias = c_bias
				Bip_Properties[(before_KeyCount)].easeTo = c_easeTo
				Bip_Properties[(before_KeyCount)].easeFrom = c_easeFrom
				Bip_Properties[(before_KeyCount)].dynamicsBlend = c_dynamicsBlend
				Bip_Properties[(before_KeyCount)].ballisticTension = c_ballisticTension
			)
		)
	)
/* 함수 - bip horizontal 사이클 복사 - Forward */
fn bip_horizontal_Forward =
(
	/* 미들 타임 이후의 키를 선택해서 모두 지움 */
	selectKeys target_Hor
	-- actionMan.executeAction 972555510 "40019"  -- Biped: Select Body Horizontal
	deselectKeys target_Hor (interval C_Start middle_Time)
	biped.deleteKeys target_Hor #selection

	local BIP = target_Hor	-- Bip 선택
	local Bip_Key = target_Hor.keys	-- 키 배열

	local Bip_KeyTimeArray = #()	-- 원본 키 타임 배열 선언
	local before_KeyCount = Bip_Key.count	-- 대칭 복사하기 전의 키 갯수를 저장

	/* 만약에 key가 없으면 실행 중지 */
	if before_KeyCount == 0 then format "!!! Horizontal Key zero \n" else
		(

			local Bip_Properties = #()	-- 키 프로퍼티의 배열 선언

				/* 원본 키 타임 배열을 Bip_KeyTimeArray에 저장 */
				Bip_KeyTimeArray = for a in 1 to Bip_Key.count collect
				(
					Bip_Key[a].time
				)
				/* 미들 타임 이후의 부분에 버티칼 키 넣기 */
				for a in 1 to Bip_KeyTimeArray.count do
				(
					biped.addNewKey BIP ((Bip_KeyTimeArray[a])+middle_Time)
				)

				/* 키 프로퍼티 배열 정리하는 반복문 */
				Bip_Properties = for b in 1 to Bip_Key.count collect
					(
						biped.getKey BIP b
					)

				/* 키 프러퍼티들을 복사하는 반복문 */
				for c in before_KeyCount to Bip_Key.count do
				(
					BIP_Properties[c].x = ((BIP_Properties[((c-before_KeyCount) + 1)].x) * -1)
					BIP_Properties[c].y = BIP_Properties[((c-before_KeyCount) + 1)].y

					BIP_Properties[c].tension = BIP_Properties[((c-before_KeyCount) + 1)].tension
					BIP_Properties[c].continuity = BIP_Properties[((c-before_KeyCount) + 1)].continuity
					BIP_Properties[c].bias = BIP_Properties[((c-before_KeyCount) + 1)].bias
					BIP_Properties[c].easeTo = BIP_Properties[((c-before_KeyCount) + 1)].easeTo
					BIP_Properties[c].easeFrom = BIP_Properties[((c-before_KeyCount) + 1)].easeFrom
					BIP_Properties[c].balanceFactor = BIP_Properties[((c-before_KeyCount) + 1)].balanceFactor
				)
		)
)

	/* 함수 - bip horizontal 사이클 복사 - Backward */
	fn bip_horizontal_Backward =
	(
		/* 미들 타임 이후의 키를 선택해서 모두 지움 */
		selectKeys target_Hor
		-- actionMan.executeAction 972555510 "40019"  -- Biped: Select Body Horizontal
		deselectKeys target_Hor (interval middle_Time C_End)
		biped.deleteKeys target_Hor #selection

		local BIP = target_Hor	-- Bip 선택
		local Bip_Key = target_Hor.keys	-- 키 배열

		local Bip_KeyTimeArray = #()	-- 원본 키 타임 배열 선언
		local before_KeyCount = Bip_Key.count	-- 대칭 복사하기 전의 키 갯수를 저장

		/* 만약에 key가 없으면 실행 중지 */
	if before_KeyCount == 0 then format "!!! Horizontal Key zero \n" else
		(

			local Bip_Properties = #()	-- 키 프로퍼티의 배열 선언

			/* 원본 키 타임 배열을 Bip_KeyTimeArray에 저장 */
			Bip_KeyTimeArray = for a in 1 to Bip_Key.count collect
			(
				Bip_Key[a].time
			)
			/* 미들 타임 이후의 부분에 버티칼 키 넣기 */
			for a in 1 to Bip_KeyTimeArray.count do
			(
				biped.addNewKey BIP ((Bip_KeyTimeArray[a])-middle_Time)
			)

			/* 키 프로퍼티 배열 정리하는 반복문 */
			Bip_Properties = for b in 1 to Bip_Key.count collect
				(
					biped.getKey BIP b
				)

			/* 마지막 키 원래값을 보존 */
			(
				local c_x = Bip_Properties[Bip_Properties.count].x
				local c_y = Bip_Properties[Bip_Properties.count].y

				local c_tension = Bip_Properties[Bip_Properties.count].tension
				local c_continuity = Bip_Properties[Bip_Properties.count].continuity
				local c_bias = Bip_Properties[Bip_Properties.count].bias
				local c_easeTo = Bip_Properties[Bip_Properties.count].easeTo
				local c_easeFrom = Bip_Properties[Bip_Properties.count].easeFrom

				local c_balanceFactor = Bip_Properties[Bip_Properties.count].balanceFactor
			)


			/* 키 프러퍼티들을 복사하는 반복문 */
			for c in 1 to (before_KeyCount) do
			(
				BIP_Properties[c].x = ((BIP_Properties[((c+before_KeyCount)-1)].x) * -1)
				BIP_Properties[c].y = BIP_Properties[((c+before_KeyCount)-1)].y

				BIP_Properties[c].tension = BIP_Properties[((c+before_KeyCount)-1)].tension
				BIP_Properties[c].continuity = BIP_Properties[((c+before_KeyCount)-1)].continuity
				BIP_Properties[c].bias = BIP_Properties[((c+before_KeyCount)-1)].bias
				BIP_Properties[c].easeTo = BIP_Properties[((c+before_KeyCount)-1)].easeTo
				BIP_Properties[c].easeFrom = BIP_Properties[((c+before_KeyCount)-1)].easeFrom
				BIP_Properties[c].balanceFactor = BIP_Properties[((c+before_KeyCount)-1)].balanceFactor
			)

			/* 복사가 완료되고, 마지막 키 값을 middle_Time과 첫번째 키값에 원래 값으로 돌려줌 */
			(

				Bip_Properties[1].x = c_x
				Bip_Properties[1].y = c_y

				Bip_Properties[1].tension = c_tension
				Bip_Properties[1].continuity = c_continuity
				Bip_Properties[1].bias = c_bias
				Bip_Properties[1].easeTo = c_easeTo
				Bip_Properties[1].easeFrom = c_easeFrom

				Bip_Properties[1].balanceFactor = c_balanceFactor

				/* ----------- */

				Bip_Properties[(before_KeyCount)].x = (c_x * -1)
				Bip_Properties[(before_KeyCount)].y = c_y

				Bip_Properties[(before_KeyCount)].tension = c_tension
				Bip_Properties[(before_KeyCount)].continuity = c_continuity
				Bip_Properties[(before_KeyCount)].bias = c_bias
				Bip_Properties[(before_KeyCount)].easeTo = c_easeTo
				Bip_Properties[(before_KeyCount)].easeFrom = c_easeFrom

				Bip_Properties[(before_KeyCount)].balanceFactor = c_balanceFactor
			)
		)
	)

			/* 함수 - 걷기 뛰기 할 때 bip001 회전축을 대칭 복사하는 함수 // quat를 Eule로 변환하는 함수 */
			fn bip_Convert_quatToEuler bip_quat =
			(

				local ConvertQuat = quatToEuler2 bip_quat	-- quat값을 받아 Euler로 변환 (바이패트 회전값)

				local xx = ConvertQuat.x * -1	-- Euler X는 -1을 곱해주고
				local yy = ConvertQuat.y		-- Euler Y는 그대로 놔두고
				local zz = ConvertQuat.z + (((90 - ConvertQuat.z) * 2) - 360)	-- Euler Z는 걷기 뛰기에 맞는 대칭값으로 변환한다.

				local ConvertEule = (eulerAngles xx yy zz)

				local bip_quat = ConvertEule	-- 변환된 Euler값을 바이패드 회전값으로 돌려준다.
			)


/* 함수 - bip turning 사이클 복사 - Forward */
fn bip_turning_Forward =
(
	/* 미들 타임 이후의 키를 선택해서 모두 지움 */
	selectKeys target_Tur
	-- actionMan.executeAction 972555510 "40021"  -- Biped: Select Body Rotation
	deselectKeys target_Tur (interval C_Start middle_Time)
	biped.deleteKeys target_Tur #selection

	local BIP = target_Tur	-- Bip 선택
	local Bip_Key = target_Tur.keys	-- 키 배열

	local Bip_KeyTimeArray = #()	-- 원본 키 타임 배열 선언
	local before_KeyCount = Bip_Key.count	-- 대칭 복사하기 전의 키 갯수를 저장

	/* 만약에 key가 없으면 실행 중지 */
	if before_KeyCount == 0 then format "!!! Rotation Key zero \n" else
		(

			local Bip_Properties = #()	-- 키 프로퍼티의 배열 선언

			/* 원본 키 타임 배열을 Bip_KeyTimeArray에 저장 */
			Bip_KeyTimeArray = for a in 1 to Bip_Key.count collect
			(
				Bip_Key[a].time
			)
			/* 미들 타임 이후의 부분에 버티칼 키 넣기 */
			for a in 1 to Bip_KeyTimeArray.count do
			(
				biped.addNewKey BIP ((Bip_KeyTimeArray[a])+middle_Time)
			)

			/* 키 프로퍼티 배열 정리하는 반복문 */
			Bip_Properties = for b in 1 to Bip_Key.count collect
				(
					biped.getKey BIP b
				)

			/* 키 프러퍼티들을 복사하는 반복문 */
			for c in before_KeyCount to Bip_Key.count do
			(
				BIP_Properties[c].rotation = bip_Convert_quatToEuler (BIP_Properties[((c-before_KeyCount) + 1)].rotation)	-- bip_Convert_quatToEuler 함수 사용

				BIP_Properties[c].tension = BIP_Properties[((c-before_KeyCount) + 1)].tension
				BIP_Properties[c].continuity = BIP_Properties[((c-before_KeyCount) + 1)].continuity
				BIP_Properties[c].bias = BIP_Properties[((c-before_KeyCount) + 1)].bias
				BIP_Properties[c].easeTo = BIP_Properties[((c-before_KeyCount) + 1)].easeTo
				BIP_Properties[c].easeFrom = BIP_Properties[((c-before_KeyCount) + 1)].easeFrom

			)
		)
)
	/* 함수 - bip turning 사이클 복사 - Backward */
	fn bip_turning_Backward =
	(
		/* 미들 타임 이후의 키를 선택해서 모두 지움 */
		selectKeys target_Tur
		-- actionMan.executeAction 972555510 "40021"  -- Biped: Select Body Rotation
		deselectKeys target_Tur (interval middle_Time C_End)
		biped.deleteKeys target_Tur #selection

		local BIP = target_Tur	-- Bip 선택
		local Bip_Key = target_Tur.keys	-- 키 배열

		local Bip_KeyTimeArray = #()	-- 원본 키 타임 배열 선언
		local before_KeyCount = Bip_Key.count	-- 대칭 복사하기 전의 키 갯수를 저장

		/* 만약에 key가 없으면 실행 중지 */
		if before_KeyCount == 0 then format "!!! Rotation Key zero \n" else
		(

			local Bip_Properties = #()	-- 키 프로퍼티의 배열 선언

			/* 원본 키 타임 배열을 Bip_KeyTimeArray에 저장 */
			Bip_KeyTimeArray = for a in 1 to Bip_Key.count collect
			(
				Bip_Key[a].time
			)
			/* 미들 타임 이후의 부분에 버티칼 키 넣기 */
			for a in 1 to Bip_KeyTimeArray.count do
			(
				biped.addNewKey BIP ((Bip_KeyTimeArray[a])-middle_Time)
			)

			/* 키 프로퍼티 배열 정리하는 반복문 */
			Bip_Properties = for b in 1 to Bip_Key.count collect
				(
					biped.getKey BIP b
				)

			/* 마지막 키 원래값을 보존 */
			(
				local C_rotation = Bip_Properties[Bip_Properties.count].rotation

				local c_tension = Bip_Properties[Bip_Properties.count].tension
				local c_continuity = Bip_Properties[Bip_Properties.count].continuity
				local c_bias = Bip_Properties[Bip_Properties.count].bias
				local c_easeTo = Bip_Properties[Bip_Properties.count].easeTo
				local c_easeFrom = Bip_Properties[Bip_Properties.count].easeFrom
			)

			/* 키 프러퍼티들을 복사하는 반복문 */
			for c in 1 to (before_KeyCount) do
			(
				BIP_Properties[c].rotation = bip_Convert_quatToEuler (BIP_Properties[((c+before_KeyCount)-1)].rotation)	-- bip_Convert_quatToEuler 함수 사용

				BIP_Properties[c].tension = BIP_Properties[((c+before_KeyCount)-1)].tension
				BIP_Properties[c].continuity = BIP_Properties[((c+before_KeyCount)-1)].continuity
				BIP_Properties[c].bias = BIP_Properties[((c+before_KeyCount)-1)].bias
				BIP_Properties[c].easeTo = BIP_Properties[((c+before_KeyCount)-1)].easeTo
				BIP_Properties[c].easeFrom = BIP_Properties[((c+before_KeyCount)-1)].easeFrom
			)

			/* 복사가 완료되고, 마지막 키 값을 middle_Time과 첫번째 키값에 원래 값으로 돌려줌 */
			(

				Bip_Properties[1].rotation = C_rotation

				Bip_Properties[1].tension = c_tension
				Bip_Properties[1].continuity = c_continuity
				Bip_Properties[1].bias = c_bias
				Bip_Properties[1].easeTo = c_easeTo
				Bip_Properties[1].easeFrom = c_easeFrom

					/* -------- */

				Bip_Properties[(before_KeyCount)].rotation = bip_Convert_quatToEuler C_rotation

				Bip_Properties[(before_KeyCount)].tension = c_tension
				Bip_Properties[(before_KeyCount)].continuity = c_continuity
				Bip_Properties[(before_KeyCount)].bias = c_bias
				Bip_Properties[(before_KeyCount)].easeTo = c_easeTo
				Bip_Properties[(before_KeyCount)].easeFrom = c_easeFrom
			)
		)
	)

	/* 함수 - 바이패드 공용 사이클 복사 - Forward */
	fn bip_Common_Forward targetName targetNamePart =
	(

		local targetName = targetName
		local targetNamePart = targetNamePart
		local t_Name = targetName.name as string


		/* 미들 타임 이후의 키를 선택해서 모두 지움 */
		select targetNamePart
		selectKeys targetName
		deselectKeys targetName (interval C_Start middle_Time)
		biped.deleteKeys targetName.controller #selection

		local BIP = targetName.controller	-- Bip 선택
		local Bip_Key = targetName.controller.keys	-- 키 배열

		local Bip_KeyTimeArray = #()	-- 키 타임 배열 선언
		local before_KeyCount = Bip_Key.count	-- 대칭 복사하기 전의 키 갯수를 저장

		/* 만약에 key가 없으면 실행 중지 */
		if before_KeyCount == 0 then format "!!! % Key zero \n" t_Name else
			(
				local Bip_Properties = #()	-- 키 프로퍼티의 배열 선언

					biped.createCopyCollection BIP t_Name	-- 대칭복사 하기 위한 포즈 콜렉션 만들기

					/* 포즈를 대칭 복사하는 반복문*/
					Bip_KeyTimeArray = for a in 1 to Bip_Key.count collect
					(
						sliderTime = (Bip_Key[a].time)
						biped.copyPosture BIP #posture off off off -- bool_horiz:on off, bool_vert:on off, bool_turn:on off
						Bip_Key[a].time
					)

					for a in 1 to Bip_KeyTimeArray.count do
					(
						sliderTime = ((Bip_Key[a].time) + middle_Time)
						biped.pastePosture BIP #posture on (biped.getCopyName BIP #posture a)	-- 이름으로 저장된 포즈 Paste 하기. -- on off 는 대칭복사 on off
					)

					biped.deleteCopyCollection BIP (biped.numCopyCollections BIP)	-- 대칭복사하기 위해 만든 콜렉션 삭제

					/* 대칭 복사하고 나서의 키 프로퍼티 배열 정리하는 반복문 */
					Bip_Properties = for b in 1 to Bip_Key.count collect
						(
							biped.getKey BIP b
						)

					/* 키 프러퍼티들을 복사하는 반복문 */
					for c in before_KeyCount to Bip_Key.count do
					(
						BIP_Properties[c].tension = BIP_Properties[((c-before_KeyCount)+1)].tension
						BIP_Properties[c].continuity = BIP_Properties[((c-before_KeyCount)+1)].continuity
						BIP_Properties[c].bias = BIP_Properties[((c-before_KeyCount)+1)].bias
						BIP_Properties[c].easeTo = BIP_Properties[((c-before_KeyCount)+1)].easeTo
						BIP_Properties[c].easeFrom = BIP_Properties[((c-before_KeyCount)+1)].easeFrom
					)
			)
	)

	/* 함수 - 바이패드 공용 사이클 복사 - Backward */
	fn bip_Common_Backward targetName targetNamePart =
	(
		local targetName = targetName
		local targetNamePart = targetNamePart
		local t_Name = targetName.name as string


		/* 미들 타임 이후의 키를 선택해서 모두 지움 */
		select targetNamePart
		selectKeys targetName
		deselectKeys targetName (interval middle_Time C_End)
		biped.deleteKeys targetName.controller #selection

		local BIP = targetName.controller	-- Bip 선택
		local Bip_Key = targetName.controller.keys	-- 키 배열
		local Bip_KeyTimeArray = #()	-- 키 타임 배열 선언

		local before_KeyCount = Bip_Key.count	-- 대칭 복사하기 전의 키 갯수를 저장

		/* 만약에 key가 없으면 실행 중지 */
		if before_KeyCount == 0 then format "!!! % Key zero \n" t_Name else
			(

				local Bip_Properties = #()	-- 키 프로퍼티의 배열 선언

				biped.createCopyCollection BIP t_Name	-- 대칭복사 하기 위한 포즈 콜렉션 만들기

				/* 포즈를 대칭 복사하는 반복문*/
				Bip_KeyTimeArray = for a in 1 to Bip_Key.count collect
				(
					sliderTime = (Bip_Key[a].time)
					biped.copyPosture BIP #posture off off off -- bool_horiz:on off, bool_vert:on off, bool_turn:on off

					Bip_Key[a].time
				)
				for a in 1 to Bip_KeyTimeArray.count do
				(
					sliderTime = ((Bip_KeyTimeArray[a]) - (middle_Time))
					biped.pastePosture BIP #posture on (biped.getCopyName BIP #posture a)	-- 이름으로 저장된 포즈 Paste 하기. -- on off 는 대칭복사 on off
				)

				biped.deleteCopyCollection BIP (biped.numCopyCollections BIP)	-- 대칭복사하기 위해 만든 콜렉션 삭제

				/* 대칭 복사하고 나서의 키 프로퍼티 배열 정리하는 반복문 */
				Bip_Properties = for b in 1 to Bip_Key.count collect
					(
						biped.getKey BIP b
					)

				/* 마지막 키 원래값을 보존 */
				(
					local c_tension = Bip_Properties[Bip_Properties.count].tension
					local c_continuity = Bip_Properties[Bip_Properties.count].continuity
					local c_bias = Bip_Properties[Bip_Properties.count].bias
					local c_easeTo = Bip_Properties[Bip_Properties.count].easeTo
					local c_easeFrom = Bip_Properties[Bip_Properties.count].easeFrom
				)

				/* 키 프러퍼티들을 복사하는 반복문 */
				for c in 1 to before_KeyCount do
				(
					BIP_Properties[c].tension = BIP_Properties[((c+before_KeyCount)-1)].tension
					BIP_Properties[c].continuity = BIP_Properties[((c+before_KeyCount)-1)].continuity
					BIP_Properties[c].bias = BIP_Properties[((c+before_KeyCount)-1)].bias
					BIP_Properties[c].easeTo = BIP_Properties[((c+before_KeyCount)-1)].easeTo
					BIP_Properties[c].easeFrom = BIP_Properties[((c+before_KeyCount)-1)].easeFrom
				)

				/* 복사가 완료되고, 마지막 키 값을 middle_Time과 첫번째 키값에 원래 값으로 돌려줌 */
				(

					Bip_Properties[1].tension = c_tension
					Bip_Properties[1].continuity = c_continuity
					Bip_Properties[1].bias = c_bias
					Bip_Properties[1].easeTo = c_easeTo
					Bip_Properties[1].easeFrom = c_easeFrom

					Bip_Properties[(before_KeyCount)].tension = c_tension
					Bip_Properties[(before_KeyCount)].continuity = c_continuity
					Bip_Properties[(before_KeyCount)].bias = c_bias
					Bip_Properties[(before_KeyCount)].easeTo = c_easeTo
					Bip_Properties[(before_KeyCount)].easeFrom = c_easeFrom
				)
			)
	)
/* 함수 - 바이패드 공용 사이클 복사 - Forward - Separate: ON - */
fn bip_Common_Forward_SeparateON targetArray =
(
	for t in 1 to targetArray.count do
		(
			local targetName = targetArray[t]
			local t_Name = targetName.name as string


			/* 미들 타임 이후의 키를 선택해서 모두 지움 */
			select targetName
			selectKeys targetName
			deselectKeys targetName (interval C_Start middle_Time)
			biped.deleteKeys targetName.controller #selection

			local BIP = targetName.controller	-- Bip 선택
			local Bip_Key = targetName.controller.keys	-- 키 배열

			local Bip_KeyTimeArray = #()	-- 키 타임 배열 선언
			local before_KeyCount = Bip_Key.count	-- 대칭 복사하기 전의 키 갯수를 저장


			/* 만약에 key가 없으면 실행 중지 */
			if before_KeyCount == 0 then format "!!! % Key zero \n" t_Name else
			(
				local Bip_Properties = #()	-- 키 프로퍼티의 배열 선언

				biped.createCopyCollection BIP t_Name	-- 대칭복사 하기 위한 포즈 콜렉션 만들기

				/* 포즈를 대칭 복사하는 반복문*/
				Bip_KeyTimeArray = for a in 1 to Bip_Key.count collect
				(
					sliderTime = (Bip_Key[a].time)
					biped.copyPosture BIP #posture off off off -- bool_horiz:on off, bool_vert:on off, bool_turn:on off
					Bip_Key[a].time
				)

				for a in 1 to Bip_KeyTimeArray.count do
				(
					sliderTime = ((Bip_Key[a].time) + middle_Time)
					biped.pastePosture BIP #posture on (biped.getCopyName BIP #posture a)	-- 이름으로 저장된 포즈 Paste 하기. -- on off 는 대칭복사 on off
				)

				biped.deleteCopyCollection BIP (biped.numCopyCollections BIP)	-- 대칭복사하기 위해 만든 콜렉션 삭제

				/* 대칭 복사하고 나서의 키 프로퍼티 배열 정리하는 반복문 */
				Bip_Properties = for b in 1 to Bip_Key.count collect
					(
						biped.getKey BIP b
					)

				/* 키 프러퍼티들을 복사하는 반복문 */
				for c in before_KeyCount to Bip_Key.count do
				(
					BIP_Properties[c].tension = BIP_Properties[((c-before_KeyCount)+1)].tension
					BIP_Properties[c].continuity = BIP_Properties[((c-before_KeyCount)+1)].continuity
					BIP_Properties[c].bias = BIP_Properties[((c-before_KeyCount)+1)].bias
					BIP_Properties[c].easeTo = BIP_Properties[((c-before_KeyCount)+1)].easeTo
					BIP_Properties[c].easeFrom = BIP_Properties[((c-before_KeyCount)+1)].easeFrom
				)
			)
		)
)
	/* 함수 - 바이패드 공용 사이클 복사 - Backward  - Separate: ON - */
	fn bip_Common_Backward_SeparateON targetArray =
	(
		for t in 1 to targetArray.count do
			(
				local targetName = targetArray[t]
				local t_Name = targetName.name as string


				/* 미들 타임 이후의 키를 선택해서 모두 지움 */
				select targetName
				selectKeys targetName
				deselectKeys targetName (interval middle_Time C_End)
				biped.deleteKeys targetName.controller #selection

				local BIP = targetName.controller	-- Bip 선택
				local Bip_Key = targetName.controller.keys	-- 키 배열
				local Bip_KeyTimeArray = #()	-- 키 타임 배열 선언

				local before_KeyCount = Bip_Key.count	-- 대칭 복사하기 전의 키 갯수를 저장

				/* 만약에 key가 없으면 실행 중지 */
				if before_KeyCount == 0 then format "!!! % Key zero \n" t_Name else
					(
						local Bip_Properties = #()	-- 키 프로퍼티의 배열 선언

						biped.createCopyCollection BIP t_Name	-- 대칭복사 하기 위한 포즈 콜렉션 만들기

						/* 포즈를 대칭 복사하는 반복문*/
						Bip_KeyTimeArray = for a in 1 to Bip_Key.count collect
						(
							sliderTime = (Bip_Key[a].time)
							biped.copyPosture BIP #posture off off off -- bool_horiz:on off, bool_vert:on off, bool_turn:on off

							Bip_Key[a].time
						)
						for a in 1 to Bip_KeyTimeArray.count do
						(
							sliderTime = ((Bip_KeyTimeArray[a]) - (middle_Time))
							biped.pastePosture BIP #posture on (biped.getCopyName BIP #posture a)	-- 이름으로 저장된 포즈 Paste 하기. -- on off 는 대칭복사 on off
						)

						biped.deleteCopyCollection BIP (biped.numCopyCollections BIP)	-- 대칭복사하기 위해 만든 콜렉션 삭제

						/* 대칭 복사하고 나서의 키 프로퍼티 배열 정리하는 반복문 */
						Bip_Properties = for b in 1 to Bip_Key.count collect
							(
								biped.getKey BIP b
							)
						/* 마지막 키 원래값을 보존 */
						(
							local c_tension = Bip_Properties[Bip_Properties.count].tension
							local c_continuity = Bip_Properties[Bip_Properties.count].continuity
							local c_bias = Bip_Properties[Bip_Properties.count].bias
							local c_easeTo = Bip_Properties[Bip_Properties.count].easeTo
							local c_easeFrom = Bip_Properties[Bip_Properties.count].easeFrom
						)

						/* 키 프러퍼티들을 복사하는 반복문 */
						for c in 1 to before_KeyCount do
						(
							BIP_Properties[c].tension = BIP_Properties[((c+before_KeyCount)-1)].tension
							BIP_Properties[c].continuity = BIP_Properties[((c+before_KeyCount)-1)].continuity
							BIP_Properties[c].bias = BIP_Properties[((c+before_KeyCount)-1)].bias
							BIP_Properties[c].easeTo = BIP_Properties[((c+before_KeyCount)-1)].easeTo
							BIP_Properties[c].easeFrom = BIP_Properties[((c+before_KeyCount)-1)].easeFrom
						)

						/* 복사가 완료되고, 마지막 키 값을 middle_Time과 첫번째 키값에 원래 값으로 돌려줌 */
						(

							Bip_Properties[1].tension = c_tension
							Bip_Properties[1].continuity = c_continuity
							Bip_Properties[1].bias = c_bias
							Bip_Properties[1].easeTo = c_easeTo
							Bip_Properties[1].easeFrom = c_easeFrom

							Bip_Properties[(before_KeyCount)].tension = c_tension
							Bip_Properties[(before_KeyCount)].continuity = c_continuity
							Bip_Properties[(before_KeyCount)].bias = c_bias
							Bip_Properties[(before_KeyCount)].easeTo = c_easeTo
							Bip_Properties[(before_KeyCount)].easeFrom = c_easeFrom
						)
					)
			)
	)


/* 함수 - BIP 팔 다리 공용 사이클 복사 - Forward */
fn bip_Common_Armleg_Forward L_part L_partArray R_part R_partArray =
(

	local L_part = L_part
	local L_partArray = L_partArray
	local L_Name = L_part.name as string

	local R_part = R_part
	local R_partArray = R_partArray
	local R_Name = R_part.name as string


	/* 왼쪽  - middle_Time 이후의 키를 삭제 */
	selectKeys L_part
	deselectKeys L_part (interval C_Start middle_Time)
	biped.deleteKeys L_part.controller #selection

	/* 오른쪽  - middle_Time 이후의 키를 삭제 */
	selectKeys R_part
	deselectKeys R_part (interval C_Start middle_Time)
	biped.deleteKeys R_part.controller #selection


	local L_BIP = L_part.controller	-- L_BIP 선언
	local R_BIP = R_part.controller	-- L_BIP 선언
	local L_Bip_Key = L_part.controller.keys	-- 왼쪽  키 배열
	local R_Bip_Key = R_part.controller.keys	-- 오른쪽  키 배열

	local L_Bip_KeyTimeArray = #()	-- 왼쪽  키 타임 배열 선언
	local R_Bip_KeyTimeArray = #()	-- 오른 쪽  키 타임 배열 선언
	local L_before_KeyCount = L_Bip_Key.count	-- 왼쪽  대칭 복사하기 전의 키 갯수를 저장
	local R_before_KeyCount = R_Bip_Key.count	-- 오른쪽  대칭 복사하기 전의 키 갯수를 저장


	/* 만약에 key가 없으면 실행 중지 */
	local L_keyJudgment = "ok"
	local R_keyJudgment = "ok"

		if L_before_KeyCount == 0 do
			(
				L_keyJudgment = "no"
				format "!!! % Key zero \n" L_Name
			)

		if R_before_KeyCount == 0 do
			(
				R_keyJudgment = "no"
				format "!!! % Key zero \n" R_Name
			)

	if L_keyJudgment == "ok" and R_keyJudgment == "ok" then
		(


			local L_Bip_Properties = #()	-- 왼쪽  키 프로퍼티의 배열 선언
			local R_Bip_Properties = #()	-- 오른쪽  키 프로퍼티의 배열 선언


			/* ----------- 왼쪽  대칭 복사 -----------  */
				select L_partArray		-- 왼쪽  선택

				biped.createCopyCollection L_BIP L_Name	-- 왼쪽  대칭복사 하기 위한 포즈 콜렉션 만들기

				/* 왼쪽  포즈를 copy하는 반복문*/
				L_Bip_KeyTimeArray = for a in 1 to L_before_KeyCount collect
				(
					sliderTime = (L_Bip_Key[a].time)
					biped.copyPosture L_BIP #posture off off off -- bool_horiz:on off, bool_vert:on off, bool_turn:on off
					L_Bip_Key[a].time
				)
				/* 왼쪽  포즈를 오른쪽 에 paste 하는 반복문*/
				for a in 1 to L_Bip_KeyTimeArray.count do
				(
					sliderTime = ((L_Bip_Key[a].time) + middle_Time)
					biped.pastePosture L_BIP #posture on (biped.getCopyName L_BIP #posture a)	-- 이름으로 저장된 포즈 Paste 하기. -- on off 는 대칭복사 on off
				)

				biped.deleteCopyCollection L_BIP (biped.numCopyCollections L_BIP)	-- 왼쪽  대칭복사하기 위해 만든 콜렉션 삭제


			/* ----------- 오른쪽  대칭 복사 -----------  */
				select R_partArray		-- 오른쪽  선택

				biped.createCopyCollection R_BIP R_Name	-- 오른쪽  대칭복사 하기 위한 포즈 콜렉션 만들기

				/* 오른쪽  포즈를 copy하는 반복문*/
				R_Bip_KeyTimeArray = for a in 1 to R_before_KeyCount collect
				(
					sliderTime = (R_Bip_Key[a].time)
					biped.copyPosture R_BIP #posture off off off -- bool_horiz:on off, bool_vert:on off, bool_turn:on off
					R_Bip_Key[a].time
				)
				/* 오른쪽  포즈를 오른쪽 에 paste 하는 반복문*/
				for a in 1 to R_Bip_KeyTimeArray.count do
				(
					sliderTime = ((R_Bip_Key[a].time) + middle_Time)
					biped.pastePosture R_BIP #posture on (biped.getCopyName R_BIP #posture a)	-- 이름으로 저장된 포즈 Paste 하기. -- on off 는 대칭복사 on off
				)

				biped.deleteCopyCollection R_BIP (biped.numCopyCollections R_BIP)	-- 오른쪽  대칭복사하기 위해 만든 콜렉션 삭제


				/* 왼쪽  대칭 복사하고 나서의 키 프로퍼티 배열 정리하는 반복문 */
				L_Bip_Properties = for b in 1 to L_Bip_Key.count collect
					(
						biped.getKey L_BIP b
					)
				/* 오른쪽  대칭 복사하고 나서의 키 프로퍼티 배열 정리하는 반복문 */
				R_Bip_Properties = for b in 1 to R_Bip_Key.count collect
					(
						biped.getKey R_BIP b
					)

				/* 왼쪽  키 첫번째 키 원래값을 보존 */
				(
					local Rc_tension = R_Bip_Properties[1].tension
					local Rc_continuity = R_Bip_Properties[1].continuity
					local Rc_bias = R_Bip_Properties[1].bias
					local Rc_easeTo = R_Bip_Properties[1].easeTo
					local Rc_easeFrom = R_Bip_Properties[1].easeFrom
					local Rc_ikBlend = R_Bip_Properties[1].ikBlend
					local Rc_ikSpace = R_Bip_Properties[1].ikSpace
					local Rc_ikAnkleTension = R_Bip_Properties[1].ikAnkleTension
					local Rc_ikJoinedPivot = R_Bip_Properties[1].ikJoinedPivot
					local Rc_ikPivotIndex = R_Bip_Properties[1].ikPivotIndex
				)
				/* 오른쪽  키 첫번째 키 원래값을 보존 */
				(
					local Lc_tension = L_Bip_Properties[1].tension
					local Lc_continuity = L_Bip_Properties[1].continuity
					local Lc_bias = L_Bip_Properties[1].bias
					local Lc_easeTo = L_Bip_Properties[1].easeTo
					local Lc_easeFrom = L_Bip_Properties[1].easeFrom
					local Lc_ikBlend = L_Bip_Properties[1].ikBlend
					local Lc_ikSpace = L_Bip_Properties[1].ikSpace
					local Lc_ikAnkleTension = L_Bip_Properties[1].ikAnkleTension
					local Lc_ikJoinedPivot = L_Bip_Properties[1].ikJoinedPivot
					local Lc_ikPivotIndex = L_Bip_Properties[1].ikPivotIndex
				)

				/* 왼쪽  키 프러퍼티들을 오른쪽 에 복사하는 반복문 */
				for c in R_before_KeyCount to L_Bip_Key.count do
				(
					R_Bip_Properties[c].tension = L_Bip_Properties[((c-R_before_KeyCount)+1)].tension
					R_Bip_Properties[c].continuity = L_Bip_Properties[((c-R_before_KeyCount)+1)].continuity
					R_Bip_Properties[c].bias = L_Bip_Properties[((c-R_before_KeyCount)+1)].bias
					R_Bip_Properties[c].easeTo = L_Bip_Properties[((c-R_before_KeyCount)+1)].easeTo
					R_Bip_Properties[c].easeFrom = L_Bip_Properties[((c-R_before_KeyCount)+1)].easeFrom
					R_Bip_Properties[c].ikBlend = L_Bip_Properties[((c-R_before_KeyCount)+1)].ikBlend
					R_Bip_Properties[c].ikSpace = L_Bip_Properties[((c-R_before_KeyCount)+1)].ikSpace
					R_Bip_Properties[c].ikAnkleTension = L_Bip_Properties[((c-R_before_KeyCount)+1)].ikAnkleTension
					R_Bip_Properties[c].ikJoinedPivot = L_Bip_Properties[((c-R_before_KeyCount)+1)].ikJoinedPivot
					R_Bip_Properties[c].ikPivotIndex = L_Bip_Properties[((c-R_before_KeyCount)+1)].ikPivotIndex
				)

				/* 오른쪽  키 프러퍼티들을 왼쪽 에 복사하는 반복문 */
				for c in L_before_KeyCount to R_Bip_Key.count do
				(
					L_BIP_Properties[c].tension = R_BIP_Properties[((c-L_before_KeyCount)+1)].tension
					L_BIP_Properties[c].continuity = R_BIP_Properties[((c-L_before_KeyCount)+1)].continuity
					L_BIP_Properties[c].bias = R_BIP_Properties[((c-L_before_KeyCount)+1)].bias
					L_BIP_Properties[c].easeTo = R_BIP_Properties[((c-L_before_KeyCount)+1)].easeTo
					L_BIP_Properties[c].easeFrom = R_BIP_Properties[((c-L_before_KeyCount)+1)].easeFrom
					L_BIP_Properties[c].ikBlend = R_BIP_Properties[((c-L_before_KeyCount)+1)].ikBlend
					L_BIP_Properties[c].ikSpace = R_BIP_Properties[((c-L_before_KeyCount)+1)].ikSpace
					L_BIP_Properties[c].ikAnkleTension = R_BIP_Properties[((c-L_before_KeyCount)+1)].ikAnkleTension
					L_BIP_Properties[c].ikJoinedPivot = R_BIP_Properties[((c-L_before_KeyCount)+1)].ikJoinedPivot
					L_BIP_Properties[c].ikPivotIndex = R_BIP_Properties[((c-L_before_KeyCount)+1)].ikPivotIndex
				)


				/*  키의 대칭 복사가 완료되고, 왼쪽  키 첫번째 키와 오른쪽  middle_Time에 원래 값으로 돌려줌 */
				(
					R_Bip_Properties[1].tension = Rc_tension
					R_Bip_Properties[1].continuity = Rc_continuity
					R_Bip_Properties[1].bias = Rc_bias
					R_Bip_Properties[1].easeTo = Rc_easeTo
					R_Bip_Properties[1].easeFrom = Rc_easeFrom
					R_Bip_Properties[1].ikBlend = Rc_ikBlend
					R_Bip_Properties[1].ikSpace = Rc_ikSpace
					R_Bip_Properties[1].ikAnkleTension = Rc_ikAnkleTension
					R_Bip_Properties[1].ikJoinedPivot = Rc_ikJoinedPivot
					R_Bip_Properties[1].ikPivotIndex = Rc_ikPivotIndex


					L_Bip_Properties[L_before_KeyCount].tension = Rc_tension
					L_Bip_Properties[L_before_KeyCount].continuity = Rc_continuity
					L_Bip_Properties[L_before_KeyCount].bias = Rc_bias
					L_Bip_Properties[L_before_KeyCount].easeTo = Rc_easeTo
					L_Bip_Properties[L_before_KeyCount].easeFrom = Rc_easeFrom
					L_Bip_Properties[L_before_KeyCount].ikBlend = Rc_ikBlend
					L_Bip_Properties[L_before_KeyCount].ikSpace = Rc_ikSpace
					L_Bip_Properties[L_before_KeyCount].ikAnkleTension = Rc_ikAnkleTension
					L_Bip_Properties[L_before_KeyCount].ikJoinedPivot = Rc_ikJoinedPivot
					L_Bip_Properties[L_before_KeyCount].ikPivotIndex = Rc_ikPivotIndex

					R_Bip_Properties[(R_Bip_Key.count)].tension = Rc_tension
					R_Bip_Properties[(R_Bip_Key.count)].continuity = Rc_continuity
					R_Bip_Properties[(R_Bip_Key.count)].bias = Rc_bias
					R_Bip_Properties[(R_Bip_Key.count)].easeTo = Rc_easeTo
					R_Bip_Properties[(R_Bip_Key.count)].easeFrom = Rc_easeFrom
					R_Bip_Properties[(R_Bip_Key.count)].ikBlend = Rc_ikBlend
					R_Bip_Properties[(R_Bip_Key.count)].ikSpace = Rc_ikSpace
					R_Bip_Properties[(R_Bip_Key.count)].ikAnkleTension = Rc_ikAnkleTension
					R_Bip_Properties[(R_Bip_Key.count)].ikJoinedPivot = Rc_ikJoinedPivot
					R_Bip_Properties[(R_Bip_Key.count)].ikPivotIndex = Rc_ikPivotIndex
				)
				/*  키의 대칭 복사가 완료되고, 오른쪽  키 첫번째 키와 왼쪽  middle_Time에  원래 값으로 돌려줌 */
				(
					L_Bip_Properties[1].tension = Lc_tension
					L_Bip_Properties[1].continuity = Lc_continuity
					L_Bip_Properties[1].bias = Lc_bias
					L_Bip_Properties[1].easeTo = Lc_easeTo
					L_Bip_Properties[1].easeFrom = Lc_easeFrom
					L_Bip_Properties[1].ikBlend = Lc_ikBlend
					L_Bip_Properties[1].ikSpace = Lc_ikSpace
					L_Bip_Properties[1].ikAnkleTension = Lc_ikAnkleTension
					L_Bip_Properties[1].ikJoinedPivot = Lc_ikJoinedPivot
					L_Bip_Properties[1].ikPivotIndex = Lc_ikPivotIndex

					R_Bip_Properties[R_before_KeyCount].tension = Lc_tension
					R_Bip_Properties[R_before_KeyCount].continuity = Lc_continuity
					R_Bip_Properties[R_before_KeyCount].bias = Lc_bias
					R_Bip_Properties[R_before_KeyCount].easeTo = Lc_easeTo
					R_Bip_Properties[R_before_KeyCount].easeFrom = Lc_easeFrom
					R_Bip_Properties[R_before_KeyCount].ikBlend = Lc_ikBlend
					R_Bip_Properties[R_before_KeyCount].ikSpace = Lc_ikSpace
					R_Bip_Properties[R_before_KeyCount].ikAnkleTension = Lc_ikAnkleTension
					R_Bip_Properties[R_before_KeyCount].ikJoinedPivot = Lc_ikJoinedPivot
					R_Bip_Properties[R_before_KeyCount].ikPivotIndex = Lc_ikPivotIndex

					L_Bip_Properties[(L_Bip_Key.count)].tension = Lc_tension
					L_Bip_Properties[(L_Bip_Key.count)].continuity = Lc_continuity
					L_Bip_Properties[(L_Bip_Key.count)].bias = Lc_bias
					L_Bip_Properties[(L_Bip_Key.count)].easeTo = Lc_easeTo
					L_Bip_Properties[(L_Bip_Key.count)].easeFrom = Lc_easeFrom
					L_Bip_Properties[(L_Bip_Key.count)].ikBlend = Lc_ikBlend
					L_Bip_Properties[(L_Bip_Key.count)].ikSpace = Lc_ikSpace
					L_Bip_Properties[(L_Bip_Key.count)].ikAnkleTension = Lc_ikAnkleTension
					L_Bip_Properties[(L_Bip_Key.count)].ikJoinedPivot = Lc_ikJoinedPivot
					L_Bip_Properties[(L_Bip_Key.count)].ikPivotIndex = Lc_ikPivotIndex
				)

				/* bip 디스플레이 오류를 방지하기 위해 오른쪽  처음 키에 set key를 줌 */
				(

					sliderTime = (R_Bip_Properties[1].time)
					select L_part
					actionMan.executeAction 972555510 "40015"  -- Biped: Set Key
				)
				/* bip 디스플레이 오류를 방지하기 위해 왼쪽  처음 키에 set key를 줌 */
				(

					sliderTime = (L_Bip_Properties[1].time)
					select R_part
					actionMan.executeAction 972555510 "40015"  -- Biped: Set Key
				)
		)
)

	/* 함수 - BIP 팔 다리 공용 사이클 복사  Backward */
	fn bip_Common_Armleg_Backward L_part L_partArray R_part R_partArray =
		(
			local L_part = L_part
			local L_partArray = L_partArray
			local L_Name = L_part.name as string

			local R_part = R_part
			local R_partArray = R_partArray
			local R_Name = R_part.name as string


			/* 왼쪽  - middle_Time 이후의 키를 삭제 */
			selectKeys L_part
			deselectKeys L_part (interval middle_Time C_End)
			biped.deleteKeys L_part.controller #selection

			/* 오른쪽  - middle_Time 이후의 키를 삭제 */
			selectKeys R_part
			deselectKeys R_part (interval middle_Time C_End)
			biped.deleteKeys R_part.controller #selection


			local L_BIP = L_part.controller	-- L_BIP 선언
			local R_BIP = R_part.controller	-- L_BIP 선언
			local L_Bip_Key = L_part.controller.keys	-- 왼쪽  키 배열
			local R_Bip_Key = R_part.controller.keys	-- 오른쪽  키 배열

			local L_Bip_KeyTimeArray = #()	-- 왼쪽  키 타임 배열 선언
			local R_Bip_KeyTimeArray = #()	-- 오른 쪽  키 타임 배열 선언
			local L_before_KeyCount = L_Bip_Key.count	-- 왼쪽  대칭 복사하기 전의 키 갯수를 저장
			local R_before_KeyCount = R_Bip_Key.count	-- 오른쪽  대칭 복사하기 전의 키 갯수를 저장


			/* 만약에 key가 없으면 실행 중지 */
			local L_keyJudgment = "ok"
			local R_keyJudgment = "ok"

				if L_before_KeyCount == 0 do
					(
						L_keyJudgment = "no"
						format "!!! % Key zero \n" L_Name
					)

				if R_before_KeyCount == 0 do
					(
						R_keyJudgment = "no"
						format "!!! % Key zero \n" R_Name
					)

			if L_keyJudgment == "ok" and R_keyJudgment == "ok" then
				(


					local L_Bip_Properties = #()	-- 왼쪽  키 프로퍼티의 배열 선언
					local R_Bip_Properties = #()	-- 오른쪽  키 프로퍼티의 배열 선언


					/* ----------- 왼쪽  대칭 복사 -----------  */
						select L_partArray		-- 왼쪽  선택

						biped.createCopyCollection L_BIP L_Name	-- 왼쪽  대칭복사 하기 위한 포즈 콜렉션 만들기

						/* 왼쪽  포즈를 copy하는 반복문*/
						L_Bip_KeyTimeArray = for a in 1 to L_Bip_Key.count collect
						(
							sliderTime = (L_Bip_Key[a].time)
							biped.copyPosture L_BIP #posture off off off -- bool_horiz:on off, bool_vert:on off, bool_turn:on off
							L_Bip_Key[a].time
						)
						/* 왼쪽  포즈를 오른쪽 에 paste 하는 반복문*/
						for a in 1 to L_Bip_KeyTimeArray.count do
						(
							sliderTime = ((L_Bip_KeyTimeArray[a])-middle_Time)
							biped.pastePosture L_BIP #posture on (biped.getCopyName L_BIP #posture a)	-- 이름으로 저장된 포즈 Paste 하기. -- on off 는 대칭복사 on off
						)

						biped.deleteCopyCollection L_BIP (biped.numCopyCollections L_BIP)	-- 왼쪽  대칭복사하기 위해 만든 콜렉션 삭제


					/* ----------- 오른쪽  대칭 복사 -----------  */
						select R_partArray		-- 오른쪽  선택

						biped.createCopyCollection R_BIP R_Name	-- 오른쪽  대칭복사 하기 위한 포즈 콜렉션 만들기

						/* 오른쪽  포즈를 copy하는 반복문*/
						R_Bip_KeyTimeArray = for a in 1 to R_Bip_Key.count collect
						(
							sliderTime = (R_Bip_Key[a].time)
							biped.copyPosture R_BIP #posture off off off -- bool_horiz:on off, bool_vert:on off, bool_turn:on off
							R_Bip_Key[a].time
						)
						/* 오른쪽  포즈를 왼쪽 에 paste 하는 반복문*/
						for a in 1 to R_Bip_KeyTimeArray.count do
						(
							sliderTime = ((R_Bip_KeyTimeArray[a])-middle_Time)
							biped.pastePosture R_BIP #posture on (biped.getCopyName R_BIP #posture a)	-- 이름으로 저장된 포즈 Paste 하기. -- on off 는 대칭복사 on off
						)


						biped.deleteCopyCollection R_BIP (biped.numCopyCollections R_BIP)	-- 오른쪽  대칭복사하기 위해 만든 콜렉션 삭제


						/* 왼쪽  대칭 복사하고 나서의 키 프로퍼티 배열 정리하는 반복문 */
						L_Bip_Properties = for b in 1 to L_Bip_Key.count collect
							(
								biped.getKey L_BIP b
							)
						/* 오른쪽  대칭 복사하고 나서의 키 프로퍼티 배열 정리하는 반복문 */
						R_Bip_Properties = for b in 1 to R_Bip_Key.count collect
							(
								biped.getKey R_BIP b
							)

						/* 왼쪽  키 마지막 키 원래값을 보존 */
						(
							local Rc_tension = R_Bip_Properties[(R_Bip_Key.count)].tension
							local Rc_continuity = R_Bip_Properties[(R_Bip_Key.count)].continuity
							local Rc_bias = R_Bip_Properties[(R_Bip_Key.count)].bias
							local Rc_easeTo = R_Bip_Properties[(R_Bip_Key.count)].easeTo
							local Rc_easeFrom = R_Bip_Properties[(R_Bip_Key.count)].easeFrom
							local Rc_ikBlend = R_Bip_Properties[(R_Bip_Key.count)].ikBlend
							local Rc_ikSpace = R_Bip_Properties[(R_Bip_Key.count)].ikSpace
							local Rc_ikAnkleTension = R_Bip_Properties[(R_Bip_Key.count)].ikAnkleTension
							local Rc_ikJoinedPivot = R_Bip_Properties[(R_Bip_Key.count)].ikJoinedPivot
							local Rc_ikPivotIndex = R_Bip_Properties[(R_Bip_Key.count)].ikPivotIndex
						)
						/* 오른쪽  키 마지막 키 원래값을 보존 */
						(
							local Lc_tension = L_Bip_Properties[(L_Bip_Key.count)].tension
							local Lc_continuity = L_Bip_Properties[(L_Bip_Key.count)].continuity
							local Lc_bias = L_Bip_Properties[(L_Bip_Key.count)].bias
							local Lc_easeTo = L_Bip_Properties[(L_Bip_Key.count)].easeTo
							local Lc_easeFrom = L_Bip_Properties[(L_Bip_Key.count)].easeFrom
							local Lc_ikBlend = L_Bip_Properties[(L_Bip_Key.count)].ikBlend
							local Lc_ikSpace = L_Bip_Properties[(L_Bip_Key.count)].ikSpace
							local Lc_ikAnkleTension = L_Bip_Properties[(L_Bip_Key.count)].ikAnkleTension
							local Lc_ikJoinedPivot = L_Bip_Properties[(L_Bip_Key.count)].ikJoinedPivot
							local Lc_ikPivotIndex = L_Bip_Properties[(L_Bip_Key.count)].ikPivotIndex
						)

						/* 왼쪽  키 프러퍼티들을 오른쪽 에 복사하는 반복문 */
						for c in 1 to L_before_KeyCount do
						(
							R_Bip_Properties[c].tension = L_Bip_Properties[((c+R_before_KeyCount)-1)].tension
							R_Bip_Properties[c].continuity = L_Bip_Properties[((c+R_before_KeyCount)-1)].continuity
							R_Bip_Properties[c].bias = L_Bip_Properties[((c+R_before_KeyCount)-1)].bias
							R_Bip_Properties[c].easeTo = L_Bip_Properties[((c+R_before_KeyCount)-1)].easeTo
							R_Bip_Properties[c].easeFrom = L_Bip_Properties[((c+R_before_KeyCount)-1)].easeFrom
							R_Bip_Properties[c].ikBlend = L_Bip_Properties[((c+R_before_KeyCount)-1)].ikBlend
							R_Bip_Properties[c].ikSpace = L_Bip_Properties[((c+R_before_KeyCount)-1)].ikSpace
							R_Bip_Properties[c].ikAnkleTension = L_Bip_Properties[((c+R_before_KeyCount)-1)].ikAnkleTension
							R_Bip_Properties[c].ikJoinedPivot = L_Bip_Properties[((c+R_before_KeyCount)-1)].ikJoinedPivot
							R_Bip_Properties[c].ikPivotIndex = L_Bip_Properties[((c+R_before_KeyCount)-1)].ikPivotIndex
						)


						/* 오른쪽  키 프러퍼티들을 왼쪽 에 복사하는 반복문 */
						for c in 1 to R_before_KeyCount do
						(
							L_BIP_Properties[c].tension = R_BIP_Properties[((c+L_before_KeyCount)-1)].tension
							L_BIP_Properties[c].continuity = R_BIP_Properties[((c+L_before_KeyCount)-1)].continuity
							L_BIP_Properties[c].bias = R_BIP_Properties[((c+L_before_KeyCount)-1)].bias
							L_BIP_Properties[c].easeTo = R_BIP_Properties[((c+L_before_KeyCount)-1)].easeTo
							L_BIP_Properties[c].easeFrom = R_BIP_Properties[((c+L_before_KeyCount)-1)].easeFrom
							L_BIP_Properties[c].ikBlend = R_BIP_Properties[((c+L_before_KeyCount)-1)].ikBlend
							L_BIP_Properties[c].ikSpace = R_BIP_Properties[((c+L_before_KeyCount)-1)].ikSpace
							L_BIP_Properties[c].ikAnkleTension = R_BIP_Properties[((c+L_before_KeyCount)-1)].ikAnkleTension
							L_BIP_Properties[c].ikJoinedPivot = R_BIP_Properties[((c+L_before_KeyCount)-1)].ikJoinedPivot
							L_BIP_Properties[c].ikPivotIndex = R_BIP_Properties[((c+L_before_KeyCount)-1)].ikPivotIndex
						)


						/*  키의 대칭 복사가 완료되고, 오른쪽  키 첫번째 키와 왼쪽  middle_Time에 원래 값으로 돌려줌 */
						(
							R_Bip_Properties[1].tension = Rc_tension
							R_Bip_Properties[1].continuity = Rc_continuity
							R_Bip_Properties[1].bias = Rc_bias
							R_Bip_Properties[1].easeTo = Rc_easeTo
							R_Bip_Properties[1].easeFrom = Rc_easeFrom
							R_Bip_Properties[1].ikBlend = Rc_ikBlend
							R_Bip_Properties[1].ikSpace = Rc_ikSpace
							R_Bip_Properties[1].ikAnkleTension = Rc_ikAnkleTension
							R_Bip_Properties[1].ikJoinedPivot = Rc_ikJoinedPivot
							R_Bip_Properties[1].ikPivotIndex = Rc_ikPivotIndex

							L_Bip_Properties[R_before_KeyCount].tension = Rc_tension
							L_Bip_Properties[R_before_KeyCount].continuity = Rc_continuity
							L_Bip_Properties[R_before_KeyCount].bias = Rc_bias
							L_Bip_Properties[R_before_KeyCount].easeTo = Rc_easeTo
							L_Bip_Properties[R_before_KeyCount].easeFrom = Rc_easeFrom
							L_Bip_Properties[R_before_KeyCount].ikBlend = Rc_ikBlend
							L_Bip_Properties[R_before_KeyCount].ikSpace = Rc_ikSpace
							L_Bip_Properties[R_before_KeyCount].ikAnkleTension = Rc_ikAnkleTension
							L_Bip_Properties[R_before_KeyCount].ikJoinedPivot = Rc_ikJoinedPivot
							L_Bip_Properties[R_before_KeyCount].ikPivotIndex = Rc_ikPivotIndex
						)
						/*  키의 대칭 복사가 완료되고, 왼쪽  키 첫번째 키와 오른쪽  middle_Time에 원래 값으로 돌려줌 */
						(
							L_Bip_Properties[1].tension = Lc_tension
							L_Bip_Properties[1].continuity = Lc_continuity
							L_Bip_Properties[1].bias = Lc_bias
							L_Bip_Properties[1].easeTo = Lc_easeTo
							L_Bip_Properties[1].easeFrom = Lc_easeFrom
							L_Bip_Properties[1].ikBlend = Lc_ikBlend
							L_Bip_Properties[1].ikSpace = Lc_ikSpace
							L_Bip_Properties[1].ikAnkleTension = Lc_ikAnkleTension
							L_Bip_Properties[1].ikJoinedPivot = Lc_ikJoinedPivot
							L_Bip_Properties[1].ikPivotIndex = Lc_ikPivotIndex

							R_Bip_Properties[L_before_KeyCount].tension = Lc_tension
							R_Bip_Properties[L_before_KeyCount].continuity = Lc_continuity
							R_Bip_Properties[L_before_KeyCount].bias = Lc_bias
							R_Bip_Properties[L_before_KeyCount].easeTo = Lc_easeTo
							R_Bip_Properties[L_before_KeyCount].easeFrom = Lc_easeFrom
							R_Bip_Properties[L_before_KeyCount].ikBlend = Lc_ikBlend
							R_Bip_Properties[L_before_KeyCount].ikSpace = Lc_ikSpace
							R_Bip_Properties[L_before_KeyCount].ikAnkleTension = Lc_ikAnkleTension
							R_Bip_Properties[L_before_KeyCount].ikJoinedPivot = Lc_ikJoinedPivot
							R_Bip_Properties[L_before_KeyCount].ikPivotIndex = Lc_ikPivotIndex
						)

						/* bip 디스플레이 오류를 방지하기 위해 오른쪽  처음 키에 set key를 줌 */
						(

							sliderTime = (R_Bip_Properties[1].time)
							select L_part
							actionMan.executeAction 972555510 "40015"  -- Biped: Set Key

						)
						/* bip 디스플레이 오류를 방지하기 위해 왼쪽  처음 키에 set key를 줌 */
						(
							sliderTime = (L_Bip_Properties[1].time)
							select R_part
							actionMan.executeAction 972555510 "40015"  -- Biped: Set Key

						)
				)
		)
/* 함수 - BIP 팔 다리 공용 사이클 복사 - Forward - Separate: ON - */
fn bip_Common_Armleg_Forward_SeparateON L_partArray R_partArray =
(
	for t in 1 to L_partArray.count do
		(
			local L_part = L_partArray[t]
			local L_Name = L_part.name as string

			local R_part = R_partArray[t]
			local R_Name = R_part.name as string


			/* 왼쪽  - middle_Time 이후의 키를 삭제 */
			selectKeys L_part
			deselectKeys L_part (interval C_Start middle_Time)
			biped.deleteKeys L_part.controller #selection

			/* 오른쪽  - middle_Time 이후의 키를 삭제 */
			selectKeys R_part
			deselectKeys R_part (interval C_Start middle_Time)
			biped.deleteKeys R_part.controller #selection


			local L_BIP = L_part.controller	-- L_BIP 선언
			local R_BIP = R_part.controller	-- L_BIP 선언
			local L_Bip_Key = L_part.controller.keys	-- 왼쪽  키 배열
			local R_Bip_Key = R_part.controller.keys	-- 오른쪽  키 배열

			local L_Bip_KeyTimeArray = #()	-- 왼쪽  키 타임 배열 선언
			local R_Bip_KeyTimeArray = #()	-- 오른 쪽  키 타임 배열 선언
			local L_before_KeyCount = L_Bip_Key.count	-- 왼쪽  대칭 복사하기 전의 키 갯수를 저장
			local R_before_KeyCount = R_Bip_Key.count	-- 오른쪽  대칭 복사하기 전의 키 갯수를 저장

			/* 만약에 key가 없으면 실행 중지 */
			local L_keyJudgment = "ok"
			local R_keyJudgment = "ok"

				if L_before_KeyCount == 0 do
					(
						L_keyJudgment = "no"
						format "!!! % Key zero \n" L_Name
					)

				if R_before_KeyCount == 0 do
					(
						R_keyJudgment = "no"
						format "!!! % Key zero \n" R_Name
					)

			if L_keyJudgment == "ok" and R_keyJudgment == "ok" then
				(


					local L_Bip_Properties = #()	-- 왼쪽  키 프로퍼티의 배열 선언
					local R_Bip_Properties = #()	-- 오른쪽  키 프로퍼티의 배열 선언


					/* ----------- 왼쪽  대칭 복사 -----------  */
						select L_part		-- 왼쪽  선택

						biped.createCopyCollection L_BIP L_Name	-- 왼쪽  대칭복사 하기 위한 포즈 콜렉션 만들기

						/* 왼쪽  포즈를 copy하는 반복문*/
						L_Bip_KeyTimeArray = for a in 1 to L_before_KeyCount collect
						(
							sliderTime = (L_Bip_Key[a].time)
							biped.copyPosture L_BIP #posture off off off -- bool_horiz:on off, bool_vert:on off, bool_turn:on off
							L_Bip_Key[a].time
						)
						/* 왼쪽  포즈를 오른쪽 에 paste 하는 반복문*/
						for a in 1 to L_Bip_KeyTimeArray.count do
						(
							sliderTime = ((L_Bip_Key[a].time) + middle_Time)
							biped.pastePosture L_BIP #posture on (biped.getCopyName L_BIP #posture a)	-- 이름으로 저장된 포즈 Paste 하기. -- on off 는 대칭복사 on off
						)

						biped.deleteCopyCollection L_BIP (biped.numCopyCollections L_BIP)	-- 왼쪽  대칭복사하기 위해 만든 콜렉션 삭제


					/* ----------- 오른쪽  대칭 복사 -----------  */
						select R_part		-- 오른쪽  선택

						biped.createCopyCollection R_BIP R_Name	-- 오른쪽  대칭복사 하기 위한 포즈 콜렉션 만들기

						/* 오른쪽  포즈를 copy하는 반복문*/
						R_Bip_KeyTimeArray = for a in 1 to R_before_KeyCount collect
						(
							sliderTime = (R_Bip_Key[a].time)
							biped.copyPosture R_BIP #posture off off off -- bool_horiz:on off, bool_vert:on off, bool_turn:on off
							R_Bip_Key[a].time
						)
						/* 오른쪽  포즈를 오른쪽 에 paste 하는 반복문*/
						for a in 1 to R_Bip_KeyTimeArray.count do
						(
							sliderTime = ((R_Bip_Key[a].time) + middle_Time)
							biped.pastePosture R_BIP #posture on (biped.getCopyName R_BIP #posture a)	-- 이름으로 저장된 포즈 Paste 하기. -- on off 는 대칭복사 on off
						)

						biped.deleteCopyCollection R_BIP (biped.numCopyCollections R_BIP)	-- 오른쪽  대칭복사하기 위해 만든 콜렉션 삭제


						/* 왼쪽  대칭 복사하고 나서의 키 프로퍼티 배열 정리하는 반복문 */
						L_Bip_Properties = for b in 1 to L_Bip_Key.count collect
							(
								biped.getKey L_BIP b
							)
						/* 오른쪽  대칭 복사하고 나서의 키 프로퍼티 배열 정리하는 반복문 */
						R_Bip_Properties = for b in 1 to R_Bip_Key.count collect
							(
								biped.getKey R_BIP b
							)

						/* 왼쪽  키 첫번째 키 원래값을 보존 */
						(
							local Rc_tension = R_Bip_Properties[1].tension
							local Rc_continuity = R_Bip_Properties[1].continuity
							local Rc_bias = R_Bip_Properties[1].bias
							local Rc_easeTo = R_Bip_Properties[1].easeTo
							local Rc_easeFrom = R_Bip_Properties[1].easeFrom
							local Rc_ikBlend = R_Bip_Properties[1].ikBlend
							local Rc_ikSpace = R_Bip_Properties[1].ikSpace
							local Rc_ikAnkleTension = R_Bip_Properties[1].ikAnkleTension
							local Rc_ikJoinedPivot = R_Bip_Properties[1].ikJoinedPivot
							local Rc_ikPivotIndex = R_Bip_Properties[1].ikPivotIndex
						)
						/* 오른쪽  키 첫번째 키 원래값을 보존 */
						(
							local Lc_tension = L_Bip_Properties[1].tension
							local Lc_continuity = L_Bip_Properties[1].continuity
							local Lc_bias = L_Bip_Properties[1].bias
							local Lc_easeTo = L_Bip_Properties[1].easeTo
							local Lc_easeFrom = L_Bip_Properties[1].easeFrom
							local Lc_ikBlend = L_Bip_Properties[1].ikBlend
							local Lc_ikSpace = L_Bip_Properties[1].ikSpace
							local Lc_ikAnkleTension = L_Bip_Properties[1].ikAnkleTension
							local Lc_ikJoinedPivot = L_Bip_Properties[1].ikJoinedPivot
							local Lc_ikPivotIndex = L_Bip_Properties[1].ikPivotIndex
						)

						/* 왼쪽  키 프러퍼티들을 오른쪽 에 복사하는 반복문 */
						for c in R_before_KeyCount to L_Bip_Key.count do
						(
							R_Bip_Properties[c].tension = L_Bip_Properties[((c-R_before_KeyCount)+1)].tension
							R_Bip_Properties[c].continuity = L_Bip_Properties[((c-R_before_KeyCount)+1)].continuity
							R_Bip_Properties[c].bias = L_Bip_Properties[((c-R_before_KeyCount)+1)].bias
							R_Bip_Properties[c].easeTo = L_Bip_Properties[((c-R_before_KeyCount)+1)].easeTo
							R_Bip_Properties[c].easeFrom = L_Bip_Properties[((c-R_before_KeyCount)+1)].easeFrom
							R_Bip_Properties[c].ikSpace = L_Bip_Properties[((c-R_before_KeyCount)+1)].ikSpace
							R_Bip_Properties[c].ikAnkleTension = L_Bip_Properties[((c-R_before_KeyCount)+1)].ikAnkleTension
							R_Bip_Properties[c].ikJoinedPivot = L_Bip_Properties[((c-R_before_KeyCount)+1)].ikJoinedPivot
							R_Bip_Properties[c].ikPivotIndex = L_Bip_Properties[((c-R_before_KeyCount)+1)].ikPivotIndex

							/* 팔과 다리의 마지막 파트일 때만 ik 정보를 오른쪽에 복사 */
							if L_partArray[t] == L_partArray[L_partArray.count] do
								(
									R_Bip_Properties[c].ikBlend = L_Bip_Properties[((c-R_before_KeyCount)+1)].ikBlend

								)
						)

						/* 오른쪽  키 프러퍼티들을 왼쪽 에 복사하는 반복문 */
						for c in L_before_KeyCount to R_Bip_Key.count do
						(
							L_BIP_Properties[c].tension = R_BIP_Properties[((c-L_before_KeyCount)+1)].tension
							L_BIP_Properties[c].continuity = R_BIP_Properties[((c-L_before_KeyCount)+1)].continuity
							L_BIP_Properties[c].bias = R_BIP_Properties[((c-L_before_KeyCount)+1)].bias
							L_BIP_Properties[c].easeTo = R_BIP_Properties[((c-L_before_KeyCount)+1)].easeTo
							L_BIP_Properties[c].easeFrom = R_BIP_Properties[((c-L_before_KeyCount)+1)].easeFrom
							L_BIP_Properties[c].ikSpace = R_BIP_Properties[((c-L_before_KeyCount)+1)].ikSpace
							L_BIP_Properties[c].ikAnkleTension = R_BIP_Properties[((c-L_before_KeyCount)+1)].ikAnkleTension
							L_BIP_Properties[c].ikJoinedPivot = R_BIP_Properties[((c-L_before_KeyCount)+1)].ikJoinedPivot
							L_BIP_Properties[c].ikPivotIndex = R_BIP_Properties[((c-L_before_KeyCount)+1)].ikPivotIndex

							/* 팔과 다리의 마지막 파트일 때만 ik 정보를 왼쪽 복사 */
							if R_partArray[t] == R_partArray[R_partArray.count] do
								(
									L_BIP_Properties[c].ikBlend = R_BIP_Properties[((c-L_before_KeyCount)+1)].ikBlend

								)
						)

						/*  확실히 하기 위해 키의 대칭 복사가 완료되고, 첫번째, middle_Time, 마지막 key에 원래값을 돌려줌 */
						(
							R_Bip_Properties[1].tension = Rc_tension
							R_Bip_Properties[1].continuity = Rc_continuity
							R_Bip_Properties[1].bias = Rc_bias
							R_Bip_Properties[1].easeTo = Rc_easeTo
							R_Bip_Properties[1].easeFrom = Rc_easeFrom

							R_Bip_Properties[(R_Bip_Key.count)].tension = Rc_tension
							R_Bip_Properties[(R_Bip_Key.count)].continuity = Rc_continuity
							R_Bip_Properties[(R_Bip_Key.count)].bias = Rc_bias
							R_Bip_Properties[(R_Bip_Key.count)].easeTo = Rc_easeTo
							R_Bip_Properties[(R_Bip_Key.count)].easeFrom = Rc_easeFrom

							L_Bip_Properties[L_before_KeyCount].tension = Rc_tension
							L_Bip_Properties[L_before_KeyCount].continuity = Rc_continuity
							L_Bip_Properties[L_before_KeyCount].bias = Rc_bias
							L_Bip_Properties[L_before_KeyCount].easeTo = Rc_easeTo
							L_Bip_Properties[L_before_KeyCount].easeFrom = Rc_easeFrom

							L_Bip_Properties[1].tension = Lc_tension
							L_Bip_Properties[1].continuity = Lc_continuity
							L_Bip_Properties[1].bias = Lc_bias
							L_Bip_Properties[1].easeTo = Lc_easeTo
							L_Bip_Properties[1].easeFrom = Lc_easeFrom
							L_Bip_Properties[1].ikBlend = Lc_ikBlend
							L_Bip_Properties[1].ikSpace = Lc_ikSpace
							L_Bip_Properties[1].ikAnkleTension = Lc_ikAnkleTension
							L_Bip_Properties[1].ikJoinedPivot = Lc_ikJoinedPivot
							L_Bip_Properties[1].ikPivotIndex = Lc_ikPivotIndex

							R_Bip_Properties[R_before_KeyCount].tension = Lc_tension
							R_Bip_Properties[R_before_KeyCount].continuity = Lc_continuity
							R_Bip_Properties[R_before_KeyCount].bias = Lc_bias
							R_Bip_Properties[R_before_KeyCount].easeTo = Lc_easeTo
							R_Bip_Properties[R_before_KeyCount].easeFrom = Lc_easeFrom

							L_Bip_Properties[(L_Bip_Key.count)].tension = Lc_tension
							L_Bip_Properties[(L_Bip_Key.count)].continuity = Lc_continuity
							L_Bip_Properties[(L_Bip_Key.count)].bias = Lc_bias
							L_Bip_Properties[(L_Bip_Key.count)].easeTo = Lc_easeTo
							L_Bip_Properties[(L_Bip_Key.count)].easeFrom = Lc_easeFrom


							if R_partArray[t] == R_partArray[R_partArray.count] do
								(
									R_Bip_Properties[1].ikBlend = Rc_ikBlend
									R_Bip_Properties[1].ikSpace = Rc_ikSpace
									R_Bip_Properties[1].ikAnkleTension = Rc_ikAnkleTension
									R_Bip_Properties[1].ikJoinedPivot = Rc_ikJoinedPivot
									R_Bip_Properties[1].ikPivotIndex = Rc_ikPivotIndex

									R_Bip_Properties[(R_Bip_Key.count)].ikBlend = Rc_ikBlend
									R_Bip_Properties[(R_Bip_Key.count)].ikSpace = Rc_ikSpace
									R_Bip_Properties[(R_Bip_Key.count)].ikAnkleTension = Rc_ikAnkleTension
									R_Bip_Properties[(R_Bip_Key.count)].ikJoinedPivot = Rc_ikJoinedPivot
									R_Bip_Properties[(R_Bip_Key.count)].ikPivotIndex = Rc_ikPivotIndex

									R_Bip_Properties[R_before_KeyCount].ikBlend = Lc_ikBlend
									R_Bip_Properties[R_before_KeyCount].ikSpace = Lc_ikSpace
									R_Bip_Properties[R_before_KeyCount].ikAnkleTension = Lc_ikAnkleTension
									R_Bip_Properties[R_before_KeyCount].ikJoinedPivot = Lc_ikJoinedPivot
									R_Bip_Properties[R_before_KeyCount].ikPivotIndex = Lc_ikPivotIndex
								)

							if L_partArray[t] == L_partArray[L_partArray.count] do
								(
									L_Bip_Properties[L_before_KeyCount].ikBlend = Rc_ikBlend
									L_Bip_Properties[L_before_KeyCount].ikSpace = Rc_ikSpace
									L_Bip_Properties[L_before_KeyCount].ikAnkleTension = Rc_ikAnkleTension
									L_Bip_Properties[L_before_KeyCount].ikJoinedPivot = Rc_ikJoinedPivot
									L_Bip_Properties[L_before_KeyCount].ikPivotIndex = Rc_ikPivotIndex

									L_Bip_Properties[(L_Bip_Key.count)].ikBlend = Lc_ikBlend
									L_Bip_Properties[(L_Bip_Key.count)].ikSpace = Lc_ikSpace
									L_Bip_Properties[(L_Bip_Key.count)].ikAnkleTension = Lc_ikAnkleTension
									L_Bip_Properties[(L_Bip_Key.count)].ikJoinedPivot = Lc_ikJoinedPivot
									L_Bip_Properties[(L_Bip_Key.count)].ikPivotIndex = Lc_ikPivotIndex
								)
						)

						/* bip 디스플레이 오류를 방지하기 위해 오른쪽  처음 키에 set key를 줌 */
						(

							sliderTime = (R_Bip_Properties[1].time)
							select L_part
							actionMan.executeAction 972555510 "40015"  -- Biped: Set Key
						)
						/* bip 디스플레이 오류를 방지하기 위해 왼쪽  처음 키에 set key를 줌 */
						(

							sliderTime = (L_Bip_Properties[1].time)
							select R_part
							actionMan.executeAction 972555510 "40015"  -- Biped: Set Key
						)
				)
		)
)
	/* 함수 - BIP 팔 다리 공용 사이클 복사  Backward - Separate: ON - */
	fn bip_Common_Armleg_Backward_SeparateON L_partArray R_partArray =
		(
			for t in 1 to L_partArray.count do
				(
					local L_part = L_partArray[t]
					local L_Name = L_part.name as string

					local R_part = R_partArray[t]
					local R_Name = R_part.name as string


					/* 왼쪽  - middle_Time 이후의 키를 삭제 */
					selectKeys L_part
					deselectKeys L_part (interval middle_Time C_End)
					biped.deleteKeys L_part.controller #selection

					/* 오른쪽  - middle_Time 이후의 키를 삭제 */
					selectKeys R_part
					deselectKeys R_part (interval middle_Time C_End)
					biped.deleteKeys R_part.controller #selection


					local L_BIP = L_part.controller	-- L_BIP 선언
					local R_BIP = R_part.controller	-- L_BIP 선언
					local L_Bip_Key = L_part.controller.keys	-- 왼쪽  키 배열
					local R_Bip_Key = R_part.controller.keys	-- 오른쪽  키 배열

					local L_Bip_KeyTimeArray = #()	-- 왼쪽  키 타임 배열 선언
					local R_Bip_KeyTimeArray = #()	-- 오른 쪽  키 타임 배열 선언
					local L_before_KeyCount = L_Bip_Key.count	-- 왼쪽  대칭 복사하기 전의 키 갯수를 저장
					local R_before_KeyCount = R_Bip_Key.count	-- 오른쪽  대칭 복사하기 전의 키 갯수를 저장

					/* 만약에 key가 없으면 실행 중지 */
					local L_keyJudgment = "ok"
					local R_keyJudgment = "ok"

						if L_before_KeyCount == 0 do
							(
								L_keyJudgment = "no"
								format "!!! % Key zero \n" L_Name
							)

						if R_before_KeyCount == 0 do
							(
								R_keyJudgment = "no"
								format "!!! % Key zero \n" R_Name
							)

					if L_keyJudgment == "ok" and R_keyJudgment == "ok" then
					(


						local L_Bip_Properties = #()	-- 왼쪽  키 프로퍼티의 배열 선언
						local R_Bip_Properties = #()	-- 오른쪽  키 프로퍼티의 배열 선언


						/* ----------- 왼쪽  대칭 복사 -----------  */
							select L_partArray[t]		-- 왼쪽  선택

							biped.createCopyCollection L_BIP L_Name	-- 왼쪽  대칭복사 하기 위한 포즈 콜렉션 만들기

							/* 왼쪽  포즈를 copy하는 반복문*/
							L_Bip_KeyTimeArray = for a in 1 to L_Bip_Key.count collect
							(
								sliderTime = (L_Bip_Key[a].time)
								biped.copyPosture L_BIP #posture off off off -- bool_horiz:on off, bool_vert:on off, bool_turn:on off
								L_Bip_Key[a].time
							)
							/* 왼쪽  포즈를 오른쪽 에 paste 하는 반복문*/
							for a in 1 to L_Bip_KeyTimeArray.count do
							(
								sliderTime = ((L_Bip_KeyTimeArray[a]) - middle_Time)
								biped.pastePosture L_BIP #posture on (biped.getCopyName L_BIP #posture a)	-- 이름으로 저장된 포즈 Paste 하기. -- on off 는 대칭복사 on off
							)

							biped.deleteCopyCollection L_BIP (biped.numCopyCollections L_BIP)	-- 왼쪽  대칭복사하기 위해 만든 콜렉션 삭제


						/* ----------- 오른쪽  대칭 복사 -----------  */
							select R_partArray[t]		-- 오른쪽  선택

							biped.createCopyCollection R_BIP R_Name	-- 오른쪽  대칭복사 하기 위한 포즈 콜렉션 만들기

							/* 오른쪽  포즈를 copy하는 반복문*/
							R_Bip_KeyTimeArray = for a in 1 to R_Bip_Key.count collect
							(
								sliderTime = (R_Bip_Key[a].time)
								biped.copyPosture R_BIP #posture off off off -- bool_horiz:on off, bool_vert:on off, bool_turn:on off
								R_Bip_Key[a].time
							)
							/* 오른쪽  포즈를 왼쪽 에 paste 하는 반복문*/
							for a in 1 to R_Bip_KeyTimeArray.count do
							(
								sliderTime = ((R_Bip_KeyTimeArray[a]) - middle_Time)
								biped.pastePosture R_BIP #posture on (biped.getCopyName R_BIP #posture a)	-- 이름으로 저장된 포즈 Paste 하기. -- on off 는 대칭복사 on off
							)

							biped.deleteCopyCollection R_BIP (biped.numCopyCollections R_BIP)	-- 오른쪽  대칭복사하기 위해 만든 콜렉션 삭제


							/* 왼쪽  대칭 복사하고 나서의 키 프로퍼티 배열 정리하는 반복문 */
							L_Bip_Properties = for b in 1 to L_Bip_Key.count collect
								(
									biped.getKey L_BIP b
								)
							/* 오른쪽  대칭 복사하고 나서의 키 프로퍼티 배열 정리하는 반복문 */
							R_Bip_Properties = for b in 1 to R_Bip_Key.count collect
								(
									biped.getKey R_BIP b
								)

							/* 왼쪽  키 마지막 키 원래값을 보존 */
							(
								local Rc_tension = R_Bip_Properties[(R_Bip_Key.count)].tension
								local Rc_continuity = R_Bip_Properties[(R_Bip_Key.count)].continuity
								local Rc_bias = R_Bip_Properties[(R_Bip_Key.count)].bias
								local Rc_easeTo = R_Bip_Properties[(R_Bip_Key.count)].easeTo
								local Rc_easeFrom = R_Bip_Properties[(R_Bip_Key.count)].easeFrom
								local Rc_ikBlend = R_Bip_Properties[(R_Bip_Key.count)].ikBlend
								local Rc_ikSpace = R_Bip_Properties[(R_Bip_Key.count)].ikSpace
								local Rc_ikAnkleTension = R_Bip_Properties[(R_Bip_Key.count)].ikAnkleTension
								local Rc_ikJoinedPivot = R_Bip_Properties[(R_Bip_Key.count)].ikJoinedPivot
								local Rc_ikPivotIndex = R_Bip_Properties[(R_Bip_Key.count)].ikPivotIndex
							)
							/* 오른쪽  키 마지막 키 원래값을 보존 */
							(
								local Lc_tension = L_Bip_Properties[(L_Bip_Key.count)].tension
								local Lc_continuity = L_Bip_Properties[(L_Bip_Key.count)].continuity
								local Lc_bias = L_Bip_Properties[(L_Bip_Key.count)].bias
								local Lc_easeTo = L_Bip_Properties[(L_Bip_Key.count)].easeTo
								local Lc_easeFrom = L_Bip_Properties[(L_Bip_Key.count)].easeFrom
								local Lc_ikBlend = L_Bip_Properties[(L_Bip_Key.count)].ikBlend
								local Lc_ikSpace = L_Bip_Properties[(L_Bip_Key.count)].ikSpace
								local Lc_ikAnkleTension = L_Bip_Properties[(L_Bip_Key.count)].ikAnkleTension
								local Lc_ikJoinedPivot = L_Bip_Properties[(L_Bip_Key.count)].ikJoinedPivot
								local Lc_ikPivotIndex = L_Bip_Properties[(L_Bip_Key.count)].ikPivotIndex
							)

							/* 왼쪽  키 프러퍼티들을 오른쪽 에 복사하는 반복문 */
							for c in 1 to L_before_KeyCount do
							(
								R_Bip_Properties[c].tension = L_Bip_Properties[((c+R_before_KeyCount)-1)].tension
								R_Bip_Properties[c].continuity = L_Bip_Properties[((c+R_before_KeyCount)-1)].continuity
								R_Bip_Properties[c].bias = L_Bip_Properties[((c+R_before_KeyCount)-1)].bias
								R_Bip_Properties[c].easeTo = L_Bip_Properties[((c+R_before_KeyCount)-1)].easeTo
								R_Bip_Properties[c].easeFrom = L_Bip_Properties[((c+R_before_KeyCount)-1)].easeFrom
								R_Bip_Properties[c].ikSpace = L_Bip_Properties[((c+R_before_KeyCount)-1)].ikSpace
								R_Bip_Properties[c].ikAnkleTension = L_Bip_Properties[((c+R_before_KeyCount)-1)].ikAnkleTension
								R_Bip_Properties[c].ikJoinedPivot = L_Bip_Properties[((c+R_before_KeyCount)-1)].ikJoinedPivot
								R_Bip_Properties[c].ikPivotIndex = L_Bip_Properties[((c+R_before_KeyCount)-1)].ikPivotIndex

								/* 팔과 다리의 마지막 파트일 때만 ik 정보를 오른쪽에 복사 */
								if L_partArray[t] == L_partArray[L_partArray.count] do
								(
									R_Bip_Properties[c].ikBlend = L_Bip_Properties[((c+R_before_KeyCount)-1)].ikBlend
								)

							)

							/* 오른쪽  키 프러퍼티들을 왼쪽 에 복사하는 반복문 */
							for c in 1 to R_before_KeyCount do
							(
								L_BIP_Properties[c].tension = R_BIP_Properties[((c+L_before_KeyCount)-1)].tension
								L_BIP_Properties[c].continuity = R_BIP_Properties[((c+L_before_KeyCount)-1)].continuity
								L_BIP_Properties[c].bias = R_BIP_Properties[((c+L_before_KeyCount)-1)].bias
								L_BIP_Properties[c].easeTo = R_BIP_Properties[((c+L_before_KeyCount)-1)].easeTo
								L_BIP_Properties[c].easeFrom = R_BIP_Properties[((c+L_before_KeyCount)-1)].easeFrom
								L_BIP_Properties[c].ikSpace = R_BIP_Properties[((c+L_before_KeyCount)-1)].ikSpace
								L_BIP_Properties[c].ikAnkleTension = R_BIP_Properties[((c+L_before_KeyCount)-1)].ikAnkleTension
								L_BIP_Properties[c].ikJoinedPivot = R_BIP_Properties[((c+L_before_KeyCount)-1)].ikJoinedPivot
								L_BIP_Properties[c].ikPivotIndex = R_BIP_Properties[((c+L_before_KeyCount)-1)].ikPivotIndex

								/* 팔과 다리의 마지막 파트일 때만 ik 정보를 왼쪽 복사 */
								if R_partArray[t] == R_partArray[R_partArray.count] do
									(
										L_BIP_Properties[c].ikBlend = R_BIP_Properties[((c+L_before_KeyCount)-1)].ikBlend
									)
							)

							/*  확실히 하기 위해 키의 대칭 복사가 완료되고, 첫번째, middle_Time, 마지막 key에 원래값을 돌려줌 */
							(
								L_Bip_Properties[R_before_KeyCount].tension = Rc_tension
								L_Bip_Properties[R_before_KeyCount].continuity = Rc_continuity
								L_Bip_Properties[R_before_KeyCount].bias = Rc_bias
								L_Bip_Properties[R_before_KeyCount].easeTo = Rc_easeTo
								L_Bip_Properties[R_before_KeyCount].easeFrom = Rc_easeFrom

								R_Bip_Properties[L_before_KeyCount].tension = Lc_tension
								R_Bip_Properties[L_before_KeyCount].continuity = Lc_continuity
								R_Bip_Properties[L_before_KeyCount].bias = Lc_bias
								R_Bip_Properties[L_before_KeyCount].easeTo = Lc_easeTo
								R_Bip_Properties[L_before_KeyCount].easeFrom = Lc_easeFrom

								L_Bip_Properties[1].tension = Lc_tension
								L_Bip_Properties[1].continuity = Lc_continuity
								L_Bip_Properties[1].bias = Lc_bias
								L_Bip_Properties[1].easeTo = Lc_easeTo
								L_Bip_Properties[1].easeFrom = Lc_easeFrom

								R_Bip_Properties[1].tension = Rc_tension
								R_Bip_Properties[1].continuity = Rc_continuity
								R_Bip_Properties[1].bias = Rc_bias
								R_Bip_Properties[1].easeTo = Rc_easeTo
								R_Bip_Properties[1].easeFrom = Rc_easeFrom


								/* 팔과 다리의 마지막 파트일 때만 ik 정보를 오른쪽에 복사 */
								if L_partArray[t] == L_partArray[L_partArray.count] do
								(
									L_Bip_Properties[R_before_KeyCount].ikBlend = Rc_ikBlend
									L_Bip_Properties[R_before_KeyCount].ikSpace = Rc_ikSpace
									L_Bip_Properties[R_before_KeyCount].ikAnkleTension = Rc_ikAnkleTension
									L_Bip_Properties[R_before_KeyCount].ikJoinedPivot = Rc_ikJoinedPivot
									L_Bip_Properties[R_before_KeyCount].ikPivotIndex = Rc_ikPivotIndex

									L_Bip_Properties[1].ikBlend = Lc_ikBlend
									L_Bip_Properties[1].ikSpace = Lc_ikSpace
									L_Bip_Properties[1].ikAnkleTension = Lc_ikAnkleTension
									L_Bip_Properties[1].ikJoinedPivot = Lc_ikJoinedPivot
									L_Bip_Properties[1].ikPivotIndex = Lc_ikPivotIndex
								)

								/* 팔과 다리의 마지막 파트일 때만 ik 정보를 왼쪽 복사 */
								if R_partArray[t] == R_partArray[R_partArray.count] do
								(
									R_Bip_Properties[L_before_KeyCount].ikBlend = Lc_ikBlend
									R_Bip_Properties[L_before_KeyCount].ikSpace = Lc_ikSpace
									R_Bip_Properties[L_before_KeyCount].ikAnkleTension = Lc_ikAnkleTension
									R_Bip_Properties[L_before_KeyCount].ikJoinedPivot = Lc_ikJoinedPivot
									R_Bip_Properties[L_before_KeyCount].ikPivotIndex = Lc_ikPivotIndex

									R_Bip_Properties[1].ikBlend = Rc_ikBlend
									R_Bip_Properties[1].ikSpace = Rc_ikSpace
									R_Bip_Properties[1].ikAnkleTension = Rc_ikAnkleTension
									R_Bip_Properties[1].ikJoinedPivot = Rc_ikJoinedPivot
									R_Bip_Properties[1].ikPivotIndex = Rc_ikPivotIndex
								)
							)

							/* bip 디스플레이 오류를 방지하기 위해 오른쪽  처음 키에 set key를 줌 */
							(

								sliderTime = (R_Bip_Properties[1].time)
								select L_part
								actionMan.executeAction 972555510 "40015"  -- Biped: Set Key

							)
							/* bip 디스플레이 오류를 방지하기 위해 왼쪽  처음 키에 set key를 줌 */
							(
								sliderTime = (L_Bip_Properties[1].time)
								select R_part
								actionMan.executeAction 972555510 "40015"  -- Biped: Set Key

							)
					)
				)
		)

/* 함수 - BIP 머리카락 공용 사이클 복사 - Forward */
fn bip_Common_Pony_check L_part L_partArray R_part R_partArray =
(

	local L_part = L_part
	local L_partArray = L_partArray
	local L_Name = L_part.name as string

	local R_part = R_part
	local R_partArray = R_partArray
	local R_Name = R_part.name as string


	/* 왼쪽  - middle_Time 이후의 키를 삭제 */
	selectKeys L_part
	deselectKeys L_part (interval C_Start middle_Time)
	biped.deleteKeys L_part.controller #selection

	/* 오른쪽  - middle_Time 이후의 키를 삭제 */
	selectKeys R_part
	deselectKeys R_part (interval C_Start middle_Time)
	biped.deleteKeys R_part.controller #selection


	local L_BIP = L_part.controller	-- L_BIP 선언
	local R_BIP = R_part.controller	-- L_BIP 선언
	local L_Bip_Key = L_part.controller.keys	-- 왼쪽  키 배열
	local R_Bip_Key = R_part.controller.keys	-- 오른쪽  키 배열

	local L_Bip_KeyTimeArray = #()	-- 왼쪽  키 타임 배열 선언
	local R_Bip_KeyTimeArray = #()	-- 오른 쪽  키 타임 배열 선언
	local L_before_KeyCount = L_Bip_Key.count	-- 왼쪽  대칭 복사하기 전의 키 갯수를 저장
	local R_before_KeyCount = R_Bip_Key.count	-- 오른쪽  대칭 복사하기 전의 키 갯수를 저장

	/* 만약에 key가 없으면 실행 중지 */
	local L_keyJudgment = "ok"
	local R_keyJudgment = "ok"

		if L_before_KeyCount == 0 do
			(
				L_keyJudgment = "no"
				format "!!! % Key zero \n" L_Name
			)

		if R_before_KeyCount == 0 do
			(
				R_keyJudgment = "no"
				format "!!! % Key zero \n" R_Name
			)

	if L_keyJudgment == "ok" and R_keyJudgment == "ok" then
		(


			local L_Bip_Properties = #()	-- 왼쪽  키 프로퍼티의 배열 선언
			local R_Bip_Properties = #()	-- 오른쪽  키 프로퍼티의 배열 선언


			/* ----------- 왼쪽  대칭 복사 -----------  */
				select L_partArray		-- 왼쪽  선택

				biped.createCopyCollection L_BIP L_Name	-- 왼쪽  대칭복사 하기 위한 포즈 콜렉션 만들기

				/* 왼쪽  포즈를 copy하는 반복문*/
				L_Bip_KeyTimeArray = for a in 1 to L_before_KeyCount collect
				(
					sliderTime = (L_Bip_Key[a].time)
					biped.copyPosture L_BIP #posture off off off -- bool_horiz:on off, bool_vert:on off, bool_turn:on off
					L_Bip_Key[a].time
				)
				/* 왼쪽  포즈를 오른쪽 에 paste 하는 반복문*/
				for a in 1 to L_Bip_KeyTimeArray.count do
				(
					sliderTime = ((L_Bip_Key[a].time) + middle_Time)
					biped.pastePosture L_BIP #posture on (biped.getCopyName L_BIP #posture a)	-- 이름으로 저장된 포즈 Paste 하기. -- on off 는 대칭복사 on off
				)

				biped.deleteCopyCollection L_BIP (biped.numCopyCollections L_BIP)	-- 왼쪽  대칭복사하기 위해 만든 콜렉션 삭제


			/* ----------- 오른쪽  대칭 복사 -----------  */
				select R_partArray		-- 오른쪽  선택

				biped.createCopyCollection R_BIP R_Name	-- 오른쪽  대칭복사 하기 위한 포즈 콜렉션 만들기

				/* 오른쪽  포즈를 copy하는 반복문*/
				R_Bip_KeyTimeArray = for a in 1 to R_before_KeyCount collect
				(
					sliderTime = (R_Bip_Key[a].time)
					biped.copyPosture R_BIP #posture off off off -- bool_horiz:on off, bool_vert:on off, bool_turn:on off
					R_Bip_Key[a].time
				)
				/* 오른쪽  포즈를 오른쪽 에 paste 하는 반복문*/
				for a in 1 to R_Bip_KeyTimeArray.count do
				(
					sliderTime = ((R_Bip_Key[a].time) + middle_Time)
					biped.pastePosture R_BIP #posture on (biped.getCopyName R_BIP #posture a)	-- 이름으로 저장된 포즈 Paste 하기. -- on off 는 대칭복사 on off
				)

				biped.deleteCopyCollection R_BIP (biped.numCopyCollections R_BIP)	-- 오른쪽  대칭복사하기 위해 만든 콜렉션 삭제


				/* 왼쪽  대칭 복사하고 나서의 키 프로퍼티 배열 정리하는 반복문 */
				L_Bip_Properties = for b in 1 to L_Bip_Key.count collect
					(
						biped.getKey L_BIP b
					)
				/* 오른쪽  대칭 복사하고 나서의 키 프로퍼티 배열 정리하는 반복문 */
				R_Bip_Properties = for b in 1 to R_Bip_Key.count collect
					(
						biped.getKey R_BIP b
					)

				/* 왼쪽  키 첫번째 키 원래값을 보존 */
				(
					local Rc_tension = R_Bip_Properties[1].tension
					local Rc_continuity = R_Bip_Properties[1].continuity
					local Rc_bias = R_Bip_Properties[1].bias
					local Rc_easeTo = R_Bip_Properties[1].easeTo
					local Rc_easeFrom = R_Bip_Properties[1].easeFrom
				)
				/* 오른쪽  키 첫번째 키 원래값을 보존 */
				(
					local Lc_tension = L_Bip_Properties[1].tension
					local Lc_continuity = L_Bip_Properties[1].continuity
					local Lc_bias = L_Bip_Properties[1].bias
					local Lc_easeTo = L_Bip_Properties[1].easeTo
					local Lc_easeFrom = L_Bip_Properties[1].easeFrom
				)

				/* 왼쪽  키 프러퍼티들을 오른쪽 에 복사하는 반복문 */
				for c in R_before_KeyCount to L_Bip_Key.count do
				(
					R_Bip_Properties[c].tension = L_Bip_Properties[((c-R_before_KeyCount)+1)].tension
					R_Bip_Properties[c].continuity = L_Bip_Properties[((c-R_before_KeyCount)+1)].continuity
					R_Bip_Properties[c].bias = L_Bip_Properties[((c-R_before_KeyCount)+1)].bias
					R_Bip_Properties[c].easeTo = L_Bip_Properties[((c-R_before_KeyCount)+1)].easeTo
					R_Bip_Properties[c].easeFrom = L_Bip_Properties[((c-R_before_KeyCount)+1)].easeFrom
				)

				/* 오른쪽  키 프러퍼티들을 왼쪽 에 복사하는 반복문 */
				for c in L_before_KeyCount to R_Bip_Key.count do
				(
					L_BIP_Properties[c].tension = R_BIP_Properties[((c-L_before_KeyCount)+1)].tension
					L_BIP_Properties[c].continuity = R_BIP_Properties[((c-L_before_KeyCount)+1)].continuity
					L_BIP_Properties[c].bias = R_BIP_Properties[((c-L_before_KeyCount)+1)].bias
					L_BIP_Properties[c].easeTo = R_BIP_Properties[((c-L_before_KeyCount)+1)].easeTo
					L_BIP_Properties[c].easeFrom = R_BIP_Properties[((c-L_before_KeyCount)+1)].easeFrom
				)


				/*  키의 대칭 복사가 완료되고, 왼쪽  키 첫번째 키와 오른쪽  middle_Time에 원래 값으로 돌려줌 */
				(
					R_Bip_Properties[1].tension = Rc_tension
					R_Bip_Properties[1].continuity = Rc_continuity
					R_Bip_Properties[1].bias = Rc_bias
					R_Bip_Properties[1].easeTo = Rc_easeTo
					R_Bip_Properties[1].easeFrom = Rc_easeFrom


					L_Bip_Properties[L_before_KeyCount].tension = Rc_tension
					L_Bip_Properties[L_before_KeyCount].continuity = Rc_continuity
					L_Bip_Properties[L_before_KeyCount].bias = Rc_bias
					L_Bip_Properties[L_before_KeyCount].easeTo = Rc_easeTo
					L_Bip_Properties[L_before_KeyCount].easeFrom = Rc_easeFrom

					R_Bip_Properties[(R_Bip_Key.count)].tension = Rc_tension
					R_Bip_Properties[(R_Bip_Key.count)].continuity = Rc_continuity
					R_Bip_Properties[(R_Bip_Key.count)].bias = Rc_bias
					R_Bip_Properties[(R_Bip_Key.count)].easeTo = Rc_easeTo
					R_Bip_Properties[(R_Bip_Key.count)].easeFrom = Rc_easeFrom
				)
				/*  키의 대칭 복사가 완료되고, 오른쪽  키 첫번째 키와 왼쪽  middle_Time에  원래 값으로 돌려줌 */
				(
					L_Bip_Properties[1].tension = Lc_tension
					L_Bip_Properties[1].continuity = Lc_continuity
					L_Bip_Properties[1].bias = Lc_bias
					L_Bip_Properties[1].easeTo = Lc_easeTo
					L_Bip_Properties[1].easeFrom = Lc_easeFrom

					R_Bip_Properties[R_before_KeyCount].tension = Lc_tension
					R_Bip_Properties[R_before_KeyCount].continuity = Lc_continuity
					R_Bip_Properties[R_before_KeyCount].bias = Lc_bias
					R_Bip_Properties[R_before_KeyCount].easeTo = Lc_easeTo
					R_Bip_Properties[R_before_KeyCount].easeFrom = Lc_easeFrom

					L_Bip_Properties[(L_Bip_Key.count)].tension = Lc_tension
					L_Bip_Properties[(L_Bip_Key.count)].continuity = Lc_continuity
					L_Bip_Properties[(L_Bip_Key.count)].bias = Lc_bias
					L_Bip_Properties[(L_Bip_Key.count)].easeTo = Lc_easeTo
					L_Bip_Properties[(L_Bip_Key.count)].easeFrom = Lc_easeFrom
				)
		)
)
/* 함수 - BIPBIP 머리카락 공용 사이클 복사  Backward */
fn bip_Common_Pony_check L_part L_partArray R_part R_partArray =
	(
		local L_part = L_part
		local L_partArray = L_partArray
		local L_Name = L_part.name as string

		local R_part = R_part
		local R_partArray = R_partArray
		local R_Name = R_part.name as string


		/* 왼쪽  - middle_Time 이후의 키를 삭제 */
		selectKeys L_part
		deselectKeys L_part (interval middle_Time C_End)
		biped.deleteKeys L_part.controller #selection

		/* 오른쪽  - middle_Time 이후의 키를 삭제 */
		selectKeys R_part
		deselectKeys R_part (interval middle_Time C_End)
		biped.deleteKeys R_part.controller #selection


		local L_BIP = L_part.controller	-- L_BIP 선언
		local R_BIP = R_part.controller	-- L_BIP 선언
		local L_Bip_Key = L_part.controller.keys	-- 왼쪽  키 배열
		local R_Bip_Key = R_part.controller.keys	-- 오른쪽  키 배열

		local L_Bip_KeyTimeArray = #()	-- 왼쪽  키 타임 배열 선언
		local R_Bip_KeyTimeArray = #()	-- 오른 쪽  키 타임 배열 선언
		local L_before_KeyCount = L_Bip_Key.count	-- 왼쪽  대칭 복사하기 전의 키 갯수를 저장
		local R_before_KeyCount = R_Bip_Key.count	-- 오른쪽  대칭 복사하기 전의 키 갯수를 저장

		/* 만약에 key가 없으면 실행 중지 */
		local L_keyJudgment = "ok"
		local R_keyJudgment = "ok"

			if L_before_KeyCount == 0 do
				(
					L_keyJudgment = "no"
					format "!!! % Key zero \n" L_Name
				)

			if R_before_KeyCount == 0 do
				(
					R_keyJudgment = "no"
					format "!!! % Key zero \n" R_Name
				)

		if L_keyJudgment == "ok" and R_keyJudgment == "ok" then
			(
				local L_Bip_Properties = #()	-- 왼쪽  키 프로퍼티의 배열 선언
				local R_Bip_Properties = #()	-- 오른쪽  키 프로퍼티의 배열 선언


				/* ----------- 왼쪽  대칭 복사 -----------  */
					select L_partArray		-- 왼쪽  선택

					biped.createCopyCollection L_BIP L_Name	-- 왼쪽  대칭복사 하기 위한 포즈 콜렉션 만들기

					/* 왼쪽  포즈를 copy하는 반복문*/
					L_Bip_KeyTimeArray = for a in 1 to L_Bip_Key.count collect
					(
						sliderTime = (L_Bip_Key[a].time)
						biped.copyPosture L_BIP #posture off off off -- bool_horiz:on off, bool_vert:on off, bool_turn:on off
						L_Bip_Key[a].time
					)
					/* 왼쪽  포즈를 오른쪽 에 paste 하는 반복문*/
					for a in 1 to L_Bip_KeyTimeArray.count do
					(
						sliderTime = ((L_Bip_KeyTimeArray[a]) - middle_Time)
						biped.pastePosture L_BIP #posture on (biped.getCopyName L_BIP #posture a)	-- 이름으로 저장된 포즈 Paste 하기. -- on off 는 대칭복사 on off
					)

					biped.deleteCopyCollection L_BIP (biped.numCopyCollections L_BIP)	-- 왼쪽  대칭복사하기 위해 만든 콜렉션 삭제


				/* ----------- 오른쪽  대칭 복사 -----------  */
					select R_partArray		-- 오른쪽  선택

					biped.createCopyCollection R_BIP R_Name	-- 오른쪽  대칭복사 하기 위한 포즈 콜렉션 만들기

					/* 오른쪽  포즈를 copy하는 반복문*/
					R_Bip_KeyTimeArray = for a in 1 to R_Bip_Key.count collect
					(
						sliderTime = (R_Bip_Key[a].time)
						biped.copyPosture R_BIP #posture off off off -- bool_horiz:on off, bool_vert:on off, bool_turn:on off
						R_Bip_Key[a].time
					)
					/* 오른쪽  포즈를 왼쪽 에 paste 하는 반복문*/
					for a in 1 to R_Bip_KeyTimeArray.count do
					(
						sliderTime = ((R_Bip_KeyTimeArray[a]) - middle_Time)
						biped.pastePosture R_BIP #posture on (biped.getCopyName R_BIP #posture a)	-- 이름으로 저장된 포즈 Paste 하기. -- on off 는 대칭복사 on off
					)

					biped.deleteCopyCollection R_BIP (biped.numCopyCollections R_BIP)	-- 오른쪽  대칭복사하기 위해 만든 콜렉션 삭제


					/* 왼쪽  대칭 복사하고 나서의 키 프로퍼티 배열 정리하는 반복문 */
					L_Bip_Properties = for b in 1 to L_Bip_Key.count collect
						(
							biped.getKey L_BIP b
						)
					/* 오른쪽  대칭 복사하고 나서의 키 프로퍼티 배열 정리하는 반복문 */
					R_Bip_Properties = for b in 1 to R_Bip_Key.count collect
						(
							biped.getKey R_BIP b
						)

					/* 왼쪽  키 마지막 키 원래값을 보존 */
					(
						local Rc_tension = R_Bip_Properties[(R_Bip_Key.count)].tension
						local Rc_continuity = R_Bip_Properties[(R_Bip_Key.count)].continuity
						local Rc_bias = R_Bip_Properties[(R_Bip_Key.count)].bias
						local Rc_easeTo = R_Bip_Properties[(R_Bip_Key.count)].easeTo
						local Rc_easeFrom = R_Bip_Properties[(R_Bip_Key.count)].easeFrom
					)
					/* 오른쪽  키 마지막 키 원래값을 보존 */
					(
						local Lc_tension = L_Bip_Properties[(L_Bip_Key.count)].tension
						local Lc_continuity = L_Bip_Properties[(L_Bip_Key.count)].continuity
						local Lc_bias = L_Bip_Properties[(L_Bip_Key.count)].bias
						local Lc_easeTo = L_Bip_Properties[(L_Bip_Key.count)].easeTo
						local Lc_easeFrom = L_Bip_Properties[(L_Bip_Key.count)].easeFrom
					)

					/* 왼쪽  키 프러퍼티들을 오른쪽 에 복사하는 반복문 */
					for c in 1 to L_before_KeyCount do
					(
						R_Bip_Properties[c].tension = L_Bip_Properties[((c+R_before_KeyCount)-1)].tension
						R_Bip_Properties[c].continuity = L_Bip_Properties[((c+R_before_KeyCount)-1)].continuity
						R_Bip_Properties[c].bias = L_Bip_Properties[((c+R_before_KeyCount)-1)].bias
						R_Bip_Properties[c].easeTo = L_Bip_Properties[((c+R_before_KeyCount)-1)].easeTo
						R_Bip_Properties[c].easeFrom = L_Bip_Properties[((c+R_before_KeyCount)-1)].easeFrom
					)


					/* 오른쪽  키 프러퍼티들을 왼쪽 에 복사하는 반복문 */
					for c in 1 to R_before_KeyCount do
					(
						L_BIP_Properties[c].tension = R_BIP_Properties[((c+L_before_KeyCount)-1)].tension
						L_BIP_Properties[c].continuity = R_BIP_Properties[((c+L_before_KeyCount)-1)].continuity
						L_BIP_Properties[c].bias = R_BIP_Properties[((c+L_before_KeyCount)-1)].bias
						L_BIP_Properties[c].easeTo = R_BIP_Properties[((c+L_before_KeyCount)-1)].easeTo
						L_BIP_Properties[c].easeFrom = R_BIP_Properties[((c+L_before_KeyCount)-1)].easeFrom
					)


					/*  키의 대칭 복사가 완료되고, 오른쪽  키 첫번째 키와 왼쪽  middle_Time에 원래 값으로 돌려줌 */
					(
						R_Bip_Properties[1].tension = Rc_tension
						R_Bip_Properties[1].continuity = Rc_continuity
						R_Bip_Properties[1].bias = Rc_bias
						R_Bip_Properties[1].easeTo = Rc_easeTo
						R_Bip_Properties[1].easeFrom = Rc_easeFrom

						L_Bip_Properties[R_before_KeyCount].tension = Rc_tension
						L_Bip_Properties[R_before_KeyCount].continuity = Rc_continuity
						L_Bip_Properties[R_before_KeyCount].bias = Rc_bias
						L_Bip_Properties[R_before_KeyCount].easeTo = Rc_easeTo
						L_Bip_Properties[R_before_KeyCount].easeFrom = Rc_easeFrom
					)
					/*  키의 대칭 복사가 완료되고, 왼쪽  키 첫번째 키와 오른쪽  middle_Time에 원래 값으로 돌려줌 */
					(
						L_Bip_Properties[1].tension = Lc_tension
						L_Bip_Properties[1].continuity = Lc_continuity
						L_Bip_Properties[1].bias = Lc_bias
						L_Bip_Properties[1].easeTo = Lc_easeTo
						L_Bip_Properties[1].easeFrom = Lc_easeFrom

						R_Bip_Properties[L_before_KeyCount].tension = Lc_tension
						R_Bip_Properties[L_before_KeyCount].continuity = Lc_continuity
						R_Bip_Properties[L_before_KeyCount].bias = Lc_bias
						R_Bip_Properties[L_before_KeyCount].easeTo = Lc_easeTo
						R_Bip_Properties[L_before_KeyCount].easeFrom = Lc_easeFrom
					)
			)
	)

/* 함수 - BIP 머리카락 공용 사이클 복사 - Forward - Separate: ON - */
fn bip_Common_Pony_check_SeparateON L_partArray R_partArray =
(
	for t in 1 to L_partArray.count do
		(
			local L_part = L_partArray[t]
			local L_Name = L_part.name as string

			local R_part = R_partArray[t]
			local R_Name = R_part.name as string


			/* 왼쪽  - middle_Time 이후의 키를 삭제 */
			selectKeys L_part
			deselectKeys L_part (interval C_Start middle_Time)
			biped.deleteKeys L_part.controller #selection

			/* 오른쪽  - middle_Time 이후의 키를 삭제 */
			selectKeys R_part
			deselectKeys R_part (interval C_Start middle_Time)
			biped.deleteKeys R_part.controller #selection


			local L_BIP = L_part.controller	-- L_BIP 선언
			local R_BIP = R_part.controller	-- L_BIP 선언
			local L_Bip_Key = L_part.controller.keys	-- 왼쪽  키 배열
			local R_Bip_Key = R_part.controller.keys	-- 오른쪽  키 배열

			local L_Bip_KeyTimeArray = #()	-- 왼쪽  키 타임 배열 선언
			local R_Bip_KeyTimeArray = #()	-- 오른 쪽  키 타임 배열 선언
			local L_before_KeyCount = L_Bip_Key.count	-- 왼쪽  대칭 복사하기 전의 키 갯수를 저장
			local R_before_KeyCount = R_Bip_Key.count	-- 오른쪽  대칭 복사하기 전의 키 갯수를 저장

			/* 만약에 key가 없으면 실행 중지 */
			local L_keyJudgment = "ok"
			local R_keyJudgment = "ok"

				if L_before_KeyCount == 0 do
					(
						L_keyJudgment = "no"
						format "!!! % Key zero \n" L_Name
					)

				if R_before_KeyCount == 0 do
					(
						R_keyJudgment = "no"
						format "!!! % Key zero \n" R_Name
					)

			if L_keyJudgment == "ok" and R_keyJudgment == "ok" then
				(


					local L_Bip_Properties = #()	-- 왼쪽  키 프로퍼티의 배열 선언
					local R_Bip_Properties = #()	-- 오른쪽  키 프로퍼티의 배열 선언


					/* ----------- 왼쪽  대칭 복사 -----------  */
						select L_partArray[t]		-- 왼쪽  선택

						biped.createCopyCollection L_BIP L_Name	-- 왼쪽  대칭복사 하기 위한 포즈 콜렉션 만들기

						/* 왼쪽  포즈를 copy하는 반복문*/
						L_Bip_KeyTimeArray = for a in 1 to L_before_KeyCount collect
						(
							sliderTime = (L_Bip_Key[a].time)
							biped.copyPosture L_BIP #posture off off off -- bool_horiz:on off, bool_vert:on off, bool_turn:on off
							L_Bip_Key[a].time
						)
						/* 왼쪽  포즈를 오른쪽 에 paste 하는 반복문*/
						for a in 1 to L_Bip_KeyTimeArray.count do
						(
							sliderTime = ((L_Bip_Key[a].time) + middle_Time)
							biped.pastePosture L_BIP #posture on (biped.getCopyName L_BIP #posture a)	-- 이름으로 저장된 포즈 Paste 하기. -- on off 는 대칭복사 on off
						)

						biped.deleteCopyCollection L_BIP (biped.numCopyCollections L_BIP)	-- 왼쪽  대칭복사하기 위해 만든 콜렉션 삭제


					/* ----------- 오른쪽  대칭 복사 -----------  */
						select R_partArray[t]		-- 오른쪽  선택

						biped.createCopyCollection R_BIP R_Name	-- 오른쪽  대칭복사 하기 위한 포즈 콜렉션 만들기

						/* 오른쪽  포즈를 copy하는 반복문*/
						R_Bip_KeyTimeArray = for a in 1 to R_before_KeyCount collect
						(
							sliderTime = (R_Bip_Key[a].time)
							biped.copyPosture R_BIP #posture off off off -- bool_horiz:on off, bool_vert:on off, bool_turn:on off
							R_Bip_Key[a].time
						)
						/* 오른쪽  포즈를 오른쪽 에 paste 하는 반복문*/
						for a in 1 to R_Bip_KeyTimeArray.count do
						(
							sliderTime = ((R_Bip_Key[a].time) + middle_Time)
							biped.pastePosture R_BIP #posture on (biped.getCopyName R_BIP #posture a)	-- 이름으로 저장된 포즈 Paste 하기. -- on off 는 대칭복사 on off
						)

						biped.deleteCopyCollection R_BIP (biped.numCopyCollections R_BIP)	-- 오른쪽  대칭복사하기 위해 만든 콜렉션 삭제


						/* 왼쪽  대칭 복사하고 나서의 키 프로퍼티 배열 정리하는 반복문 */
						L_Bip_Properties = for b in 1 to L_Bip_Key.count collect
							(
								biped.getKey L_BIP b
							)
						/* 오른쪽  대칭 복사하고 나서의 키 프로퍼티 배열 정리하는 반복문 */
						R_Bip_Properties = for b in 1 to R_Bip_Key.count collect
							(
								biped.getKey R_BIP b
							)

						/* 왼쪽  키 첫번째 키 원래값을 보존 */
						(
							local Rc_tension = R_Bip_Properties[1].tension
							local Rc_continuity = R_Bip_Properties[1].continuity
							local Rc_bias = R_Bip_Properties[1].bias
							local Rc_easeTo = R_Bip_Properties[1].easeTo
							local Rc_easeFrom = R_Bip_Properties[1].easeFrom
						)
						/* 오른쪽  키 첫번째 키 원래값을 보존 */
						(
							local Lc_tension = L_Bip_Properties[1].tension
							local Lc_continuity = L_Bip_Properties[1].continuity
							local Lc_bias = L_Bip_Properties[1].bias
							local Lc_easeTo = L_Bip_Properties[1].easeTo
							local Lc_easeFrom = L_Bip_Properties[1].easeFrom
						)

						/* 왼쪽  키 프러퍼티들을 오른쪽 에 복사하는 반복문 */
						for c in R_before_KeyCount to L_Bip_Key.count do
						(
							R_Bip_Properties[c].tension = L_Bip_Properties[((c-R_before_KeyCount)+1)].tension
							R_Bip_Properties[c].continuity = L_Bip_Properties[((c-R_before_KeyCount)+1)].continuity
							R_Bip_Properties[c].bias = L_Bip_Properties[((c-R_before_KeyCount)+1)].bias
							R_Bip_Properties[c].easeTo = L_Bip_Properties[((c-R_before_KeyCount)+1)].easeTo
							R_Bip_Properties[c].easeFrom = L_Bip_Properties[((c-R_before_KeyCount)+1)].easeFrom
						)

						/* 오른쪽  키 프러퍼티들을 왼쪽 에 복사하는 반복문 */
						for c in L_before_KeyCount to R_Bip_Key.count do
						(
							L_BIP_Properties[c].tension = R_BIP_Properties[((c-L_before_KeyCount)+1)].tension
							L_BIP_Properties[c].continuity = R_BIP_Properties[((c-L_before_KeyCount)+1)].continuity
							L_BIP_Properties[c].bias = R_BIP_Properties[((c-L_before_KeyCount)+1)].bias
							L_BIP_Properties[c].easeTo = R_BIP_Properties[((c-L_before_KeyCount)+1)].easeTo
							L_BIP_Properties[c].easeFrom = R_BIP_Properties[((c-L_before_KeyCount)+1)].easeFrom
						)


						/*  키의 대칭 복사가 완료되고, 왼쪽  키 첫번째 키와 오른쪽  middle_Time에 원래 값으로 돌려줌 */
						(
							R_Bip_Properties[1].tension = Rc_tension
							R_Bip_Properties[1].continuity = Rc_continuity
							R_Bip_Properties[1].bias = Rc_bias
							R_Bip_Properties[1].easeTo = Rc_easeTo
							R_Bip_Properties[1].easeFrom = Rc_easeFrom


							L_Bip_Properties[L_before_KeyCount].tension = Rc_tension
							L_Bip_Properties[L_before_KeyCount].continuity = Rc_continuity
							L_Bip_Properties[L_before_KeyCount].bias = Rc_bias
							L_Bip_Properties[L_before_KeyCount].easeTo = Rc_easeTo
							L_Bip_Properties[L_before_KeyCount].easeFrom = Rc_easeFrom

							R_Bip_Properties[(R_Bip_Key.count)].tension = Rc_tension
							R_Bip_Properties[(R_Bip_Key.count)].continuity = Rc_continuity
							R_Bip_Properties[(R_Bip_Key.count)].bias = Rc_bias
							R_Bip_Properties[(R_Bip_Key.count)].easeTo = Rc_easeTo
							R_Bip_Properties[(R_Bip_Key.count)].easeFrom = Rc_easeFrom
						)
						/*  키의 대칭 복사가 완료되고, 오른쪽  키 첫번째 키와 왼쪽  middle_Time에  원래 값으로 돌려줌 */
						(
							L_Bip_Properties[1].tension = Lc_tension
							L_Bip_Properties[1].continuity = Lc_continuity
							L_Bip_Properties[1].bias = Lc_bias
							L_Bip_Properties[1].easeTo = Lc_easeTo
							L_Bip_Properties[1].easeFrom = Lc_easeFrom

							R_Bip_Properties[R_before_KeyCount].tension = Lc_tension
							R_Bip_Properties[R_before_KeyCount].continuity = Lc_continuity
							R_Bip_Properties[R_before_KeyCount].bias = Lc_bias
							R_Bip_Properties[R_before_KeyCount].easeTo = Lc_easeTo
							R_Bip_Properties[R_before_KeyCount].easeFrom = Lc_easeFrom

							L_Bip_Properties[(L_Bip_Key.count)].tension = Lc_tension
							L_Bip_Properties[(L_Bip_Key.count)].continuity = Lc_continuity
							L_Bip_Properties[(L_Bip_Key.count)].bias = Lc_bias
							L_Bip_Properties[(L_Bip_Key.count)].easeTo = Lc_easeTo
							L_Bip_Properties[(L_Bip_Key.count)].easeFrom = Lc_easeFrom
						)
				)
		)
)
	/* 함수 - BIP 머리카락 공용 사이클 복사  Backward - Separate: ON - */
	fn bip_Common_Pony_check_SeparateON L_partArray R_partArray =
		(
			for t in 1 to L_partArray.count do
				(
					local L_part = L_partArray[t]
					local L_Name = L_part.name as string

					local R_part = R_partArray[t]
					local R_Name = R_part.name as string


					/* 왼쪽  - middle_Time 이후의 키를 삭제 */
					selectKeys L_part
					deselectKeys L_part (interval middle_Time C_End)
					biped.deleteKeys L_part.controller #selection

					/* 오른쪽  - middle_Time 이후의 키를 삭제 */
					selectKeys R_part
					deselectKeys R_part (interval middle_Time C_End)
					biped.deleteKeys R_part.controller #selection


					local L_BIP = L_part.controller	-- L_BIP 선언
					local R_BIP = R_part.controller	-- L_BIP 선언
					local L_Bip_Key = L_part.controller.keys	-- 왼쪽  키 배열
					local R_Bip_Key = R_part.controller.keys	-- 오른쪽  키 배열

					local L_Bip_KeyTimeArray = #()	-- 왼쪽  키 타임 배열 선언
					local R_Bip_KeyTimeArray = #()	-- 오른 쪽  키 타임 배열 선언
					local L_before_KeyCount = L_Bip_Key.count	-- 왼쪽  대칭 복사하기 전의 키 갯수를 저장
					local R_before_KeyCount = R_Bip_Key.count	-- 오른쪽  대칭 복사하기 전의 키 갯수를 저장

					/* 만약에 key가 없으면 실행 중지 */
					local L_keyJudgment = "ok"
					local R_keyJudgment = "ok"

						if L_before_KeyCount == 0 do
							(
								L_keyJudgment = "no"
								format "!!! % Key zero \n" L_Name
							)

						if R_before_KeyCount == 0 do
							(
								R_keyJudgment = "no"
								format "!!! % Key zero \n" R_Name
							)

					if L_keyJudgment == "ok" and R_keyJudgment == "ok" then
						(

							local L_Bip_Properties = #()	-- 왼쪽  키 프로퍼티의 배열 선언
							local R_Bip_Properties = #()	-- 오른쪽  키 프로퍼티의 배열 선언


							/* ----------- 왼쪽  대칭 복사 -----------  */
								select L_partArray[t]		-- 왼쪽  선택

								biped.createCopyCollection L_BIP L_Name	-- 왼쪽  대칭복사 하기 위한 포즈 콜렉션 만들기

								/* 왼쪽  포즈를 copy하는 반복문*/
								L_Bip_KeyTimeArray = for a in 1 to L_Bip_Key.count collect
								(
									sliderTime = (L_Bip_Key[a].time)
									biped.copyPosture L_BIP #posture off off off -- bool_horiz:on off, bool_vert:on off, bool_turn:on off
									L_Bip_Key[a].time
								)
								/* 왼쪽  포즈를 오른쪽 에 paste 하는 반복문*/
								for a in 1 to L_Bip_KeyTimeArray.count do
								(
									sliderTime = ((L_Bip_KeyTimeArray[a]) - middle_Time)
									biped.pastePosture L_BIP #posture on (biped.getCopyName L_BIP #posture a)	-- 이름으로 저장된 포즈 Paste 하기. -- on off 는 대칭복사 on off
								)

								biped.deleteCopyCollection L_BIP (biped.numCopyCollections L_BIP)	-- 왼쪽  대칭복사하기 위해 만든 콜렉션 삭제


							/* ----------- 오른쪽  대칭 복사 -----------  */
								select R_partArray[t]		-- 오른쪽  선택

								biped.createCopyCollection R_BIP R_Name	-- 오른쪽  대칭복사 하기 위한 포즈 콜렉션 만들기

								/* 오른쪽  포즈를 copy하는 반복문*/
								R_Bip_KeyTimeArray = for a in 1 to R_Bip_Key.count collect
								(
									sliderTime = (R_Bip_Key[a].time)
									biped.copyPosture R_BIP #posture off off off -- bool_horiz:on off, bool_vert:on off, bool_turn:on off
									R_Bip_Key[a].time
								)
								/* 오른쪽  포즈를 왼쪽 에 paste 하는 반복문*/
								for a in 1 to R_Bip_KeyTimeArray.count do
								(
									sliderTime = ((R_Bip_KeyTimeArray[a]) - middle_Time)
									biped.pastePosture R_BIP #posture on (biped.getCopyName R_BIP #posture a)	-- 이름으로 저장된 포즈 Paste 하기. -- on off 는 대칭복사 on off
								)

								biped.deleteCopyCollection R_BIP (biped.numCopyCollections R_BIP)	-- 오른쪽  대칭복사하기 위해 만든 콜렉션 삭제


								/* 왼쪽  대칭 복사하고 나서의 키 프로퍼티 배열 정리하는 반복문 */
								L_Bip_Properties = for b in 1 to L_Bip_Key.count collect
									(
										biped.getKey L_BIP b
									)
								/* 오른쪽  대칭 복사하고 나서의 키 프로퍼티 배열 정리하는 반복문 */
								R_Bip_Properties = for b in 1 to R_Bip_Key.count collect
									(
										biped.getKey R_BIP b
									)

								/* 왼쪽  키 마지막 키 원래값을 보존 */
								(
									local Rc_tension = R_Bip_Properties[(R_Bip_Key.count)].tension
									local Rc_continuity = R_Bip_Properties[(R_Bip_Key.count)].continuity
									local Rc_bias = R_Bip_Properties[(R_Bip_Key.count)].bias
									local Rc_easeTo = R_Bip_Properties[(R_Bip_Key.count)].easeTo
									local Rc_easeFrom = R_Bip_Properties[(R_Bip_Key.count)].easeFrom
								)
								/* 오른쪽  키 마지막 키 원래값을 보존 */
								(
									local Lc_tension = L_Bip_Properties[(L_Bip_Key.count)].tension
									local Lc_continuity = L_Bip_Properties[(L_Bip_Key.count)].continuity
									local Lc_bias = L_Bip_Properties[(L_Bip_Key.count)].bias
									local Lc_easeTo = L_Bip_Properties[(L_Bip_Key.count)].easeTo
									local Lc_easeFrom = L_Bip_Properties[(L_Bip_Key.count)].easeFrom
								)

								/* 왼쪽  키 프러퍼티들을 오른쪽 에 복사하는 반복문 */
								for c in 1 to L_before_KeyCount do
								(
									R_Bip_Properties[c].tension = L_Bip_Properties[((c+R_before_KeyCount)-1)].tension
									R_Bip_Properties[c].continuity = L_Bip_Properties[((c+R_before_KeyCount)-1)].continuity
									R_Bip_Properties[c].bias = L_Bip_Properties[((c+R_before_KeyCount)-1)].bias
									R_Bip_Properties[c].easeTo = L_Bip_Properties[((c+R_before_KeyCount)-1)].easeTo
									R_Bip_Properties[c].easeFrom = L_Bip_Properties[((c+R_before_KeyCount)-1)].easeFrom
								)


								/* 오른쪽  키 프러퍼티들을 왼쪽 에 복사하는 반복문 */
								for c in 1 to R_before_KeyCount do
								(
									L_BIP_Properties[c].tension = R_BIP_Properties[((c+L_before_KeyCount)-1)].tension
									L_BIP_Properties[c].continuity = R_BIP_Properties[((c+L_before_KeyCount)-1)].continuity
									L_BIP_Properties[c].bias = R_BIP_Properties[((c+L_before_KeyCount)-1)].bias
									L_BIP_Properties[c].easeTo = R_BIP_Properties[((c+L_before_KeyCount)-1)].easeTo
									L_BIP_Properties[c].easeFrom = R_BIP_Properties[((c+L_before_KeyCount)-1)].easeFrom
								)


								/*  키의 대칭 복사가 완료되고, 오른쪽  키 첫번째 키와 왼쪽  middle_Time에 원래 값으로 돌려줌 */
								(
									R_Bip_Properties[1].tension = Rc_tension
									R_Bip_Properties[1].continuity = Rc_continuity
									R_Bip_Properties[1].bias = Rc_bias
									R_Bip_Properties[1].easeTo = Rc_easeTo
									R_Bip_Properties[1].easeFrom = Rc_easeFrom

									L_Bip_Properties[R_before_KeyCount].tension = Rc_tension
									L_Bip_Properties[R_before_KeyCount].continuity = Rc_continuity
									L_Bip_Properties[R_before_KeyCount].bias = Rc_bias
									L_Bip_Properties[R_before_KeyCount].easeTo = Rc_easeTo
									L_Bip_Properties[R_before_KeyCount].easeFrom = Rc_easeFrom
								)
								/*  키의 대칭 복사가 완료되고, 왼쪽  키 첫번째 키와 오른쪽  middle_Time에 원래 값으로 돌려줌 */
								(
									L_Bip_Properties[1].tension = Lc_tension
									L_Bip_Properties[1].continuity = Lc_continuity
									L_Bip_Properties[1].bias = Lc_bias
									L_Bip_Properties[1].easeTo = Lc_easeTo
									L_Bip_Properties[1].easeFrom = Lc_easeFrom

									R_Bip_Properties[L_before_KeyCount].tension = Lc_tension
									R_Bip_Properties[L_before_KeyCount].continuity = Lc_continuity
									R_Bip_Properties[L_before_KeyCount].bias = Lc_bias
									R_Bip_Properties[L_before_KeyCount].easeTo = Lc_easeTo
									R_Bip_Properties[L_before_KeyCount].easeFrom = Lc_easeFrom
								)
						)
				)
		)


/* -------------------------------- ------------------------------ ---------------------------------------- ------------------------------- */
/* -------------------------------- ------------------------------ ---------------------------------------- ------------------------------- */
/* -------------------------------- ------------------------------ ---------------------------------------- ------------------------------- */


/* play -  - 루프 영역 양 옆으로 키를 복사하는 함수 */
fn play_Copy_LoopSideKey =
(
	local beforeObj = getCurrentSelection()
	local before_time = currentTime		-- 대칭 복사하기 전의 프레임을 저장
	local before_animateMode = animButtonState	-- 실행하기 전에  animateMode 상태를 저장

	-- actionMan.executeAction 0 "40180"  -- Selection: Select Children
	local obj = getCurrentSelection()

	if obj.count == 0 then
		(
			print " ------- No Selection ------- \t"
		)

		else
			(
				basicRange()

				undo "Copy key, Loop Side" off
				(

					max motion mode
						if before_animateMode == false do max tool animmode

					local sortBIP = #()
					local sort_Bone_Obj = #()

					/* 선택한 오브젝트 중에서 Biped만 모아 sortBIP 배열을 만듬 */
					sortBIP = for A in 1 to obj.count where (classOf obj[A] == Biped_Object) collect
						(
							obj[A]
						)

					(
						if sortBIP.count != 0 then
							(
								select sortBIP[1]
								Bip_targetArray()
								biped.deleteAllCopyCollections target_Ver	-- 오류를 방지하기 위해 모든 포즈 Collections 을 삭제
								select target_Bip

								actionMan.executeAction 0 "40180"  -- Selection: Select Children
								local temp_Bip_Obj = getCurrentSelection()
								local sortBIP = #()

									/* temp_Bip_Obj 배열에서 Biped만 모아 sortBIP 배열을 만듬 */
								sortBIP = for A in 1 to temp_Bip_Obj.count where (classOf temp_Bip_Obj[A] == Biped_Object) collect
									(
										temp_Bip_Obj[A]
									)
									/* temp_Bip_Obj 배열에서 Biped가 아닌 노드만 모아 sort_Bone_Obj 배열을 만듬 */
								sort_Bone_Obj = for A in 1 to temp_Bip_Obj.count where (classOf temp_Bip_Obj[A] != Biped_Object) collect
									(
										temp_Bip_Obj[A]
									)


								select sortBIP[1]
								Bip_LoopSideKey()	-- 양옆으로 키 복사하는 함수를 실행

								/* 바이패드가 아닌 노드들의 위치, 회전, 스케일 컨트롤러를 아웃오브레인지를 #loop로 바꿈 */
								for B in 1 to sort_Bone_Obj.count do
									(

									if sort_Bone_Obj[B].pos.controller as string == "Controller:Position_XYZ" or
									sort_Bone_Obj[B].pos.controller as string == "Controller:Bezier_Position" or
									sort_Bone_Obj[B].pos.controller as string == "Controller:TCB_Position" do
										(
											setBeforeORT sort_Bone_Obj[B].pos.controller #loop
											setAfterORT sort_Bone_Obj[B].pos.controller #loop
										)

									if sort_Bone_Obj[B].rotation.controller as string == "Controller:Euler_XYZ" or
									sort_Bone_Obj[B].rotation.controller as string == "Controller:TCB_Rotation" do
										(
											setBeforeORT sort_Bone_Obj[B].rotation.controller #loop
											setAfterORT sort_Bone_Obj[B].rotation.controller #loop
										)

									if sort_Bone_Obj[B].Scale.controller as string == "Controller:Bezier_Scale" or
									sort_Bone_Obj[B].Scale.controller as string == "Controller:ScaleXYZ" or
									sort_Bone_Obj[B].Scale.controller as string == "Controller:TCB_Scale" do
										(
											setBeforeORT sort_Bone_Obj[B].Scale.controller #loop
											setAfterORT sort_Bone_Obj[B].Scale.controller #loop
										)

								)
							)

						/* 셀렉션에 바이패드가 없을 경우, 바이패드가 아닌 노드들의 위치, 회전, 스케일 컨트롤러를 아웃오브레인지를 #loop로 바꿈 */
						else
							(
								for B in 1 to obj.count do
								(

									if obj[B].pos.controller as string == "Controller:Position_XYZ" or
									obj[B].pos.controller as string == "Controller:Bezier_Position" or
									obj[B].pos.controller as string == "Controller:TCB_Position" do
										(
											setBeforeORT obj[B].pos.controller #loop
											setAfterORT obj[B].pos.controller #loop
										)

									if obj[B].rotation.controller as string == "Controller:Euler_XYZ" or
									obj[B].rotation.controller as string == "Controller:TCB_Rotation" do
										(
											setBeforeORT obj[B].rotation.controller #loop
											setAfterORT obj[B].rotation.controller #loop
										)

									if obj[B].Scale.controller as string == "Controller:Bezier_Scale" or
									obj[B].Scale.controller as string == "Controller:ScaleXYZ" or
									obj[B].Scale.controller as string == "Controller:TCB_Scale" do
										(
											setBeforeORT obj[B].Scale.controller #loop
											setAfterORT obj[B].Scale.controller #loop
										)

								)

							)
					)
				) -- undo on 끝나는 지점

				select beforeObj
				deselectKeys $...*	-- 모든 Key 선택 해제
				biped.createCopyCollection target_Ver target_Bip.name	-- 작업을 마무리하고 편의를 위해 포즈 콜렉션 만들어 놓기

				sliderTime = before_time	-- 이전 작업하던 프레임으로 돌아오기
				if before_animateMode == false do max tool animmode -- 실행하기 전에 animateMode 모드가 꺼져있었으면 animateMode를 다시 끔
			)
)


/* play - 루프 영역 양 옆으로 키를 삭제하는 함수 */
fn play_Delete_LoopSideKey =
(
	local beforeObj = getCurrentSelection()

	actionMan.executeAction 0 "40180"  -- Selection: Select Children

	local obj = getCurrentSelection()

	if obj.count == 0 then
		(
			print " ------- No Selection ------- \t"
		)

		else (

				local sort_Bip_Obj = #()
				local temp_Bip_Obj = #()
				local sort_Bone_Obj = #()
				local before_Workframe = currentTime

				basicRange()

			undo "Delete key, Loop Side" off
				(

					/* 선택한 오브젝트 중에서 바이패드 오브젝트만 모아 sort_Bip_Obj 배열을 만듬 */
					sort_Bip_Obj = for A in 1 to obj.count where (classOf obj[A] == Biped_Object) collect
					(
						obj[A]
					)

					(
						if sort_Bip_Obj.count != 0 then
							(
								select sort_Bip_Obj[1]
								Bip_targetArray()

								select target_Bip
								actionMan.executeAction 0 "40180"  -- Selection: Select Children

								local sort_Bip_Obj = #()
								local temp_Bip_Obj = getCurrentSelection()

								/* 선택한 오브젝트 중에서 bip001을 제외한 바이패드 오브젝트만 모아 sort_Bip_Obj 배열을 만듬 */
								sort_Bip_Obj = for A in 1 to temp_Bip_Obj.count where (classOf temp_Bip_Obj[A] == Biped_Object) collect
								(
									temp_Bip_Obj[A]
								)

								/* 선택한 오브젝트 중에서 바이패드가 아닌 노드만 따로 모아 sort_Bone_Obj 배열을 만듬 */
								sort_Bone_Obj = for A in 1 to temp_Bip_Obj.count where (classOf temp_Bip_Obj[A] != Biped_Object) collect
								(
									temp_Bip_Obj[A]
								)


										/* 바이패드의 처음과 시작에 올키를 주고, 작업영역 양 옆의 모든 키를 지우기 */
										(
											sliderTime = C_Start

												(
													select sort_Bip_Obj
													actionMan.executeAction 972555510 "40015"  -- Biped: Set Key

													actionMan.executeAction 972555510 "40019"  -- Biped: Select Body Horizontal
													actionMan.executeAction 972555510 "40015"  -- Biped: Set Key

													actionMan.executeAction 972555510 "40020"  -- Biped: Select Body Vertical
													actionMan.executeAction 972555510 "40015"  -- Biped: Set Key

													actionMan.executeAction 972555510 "40021"  -- Biped: Select Body Rotation
													actionMan.executeAction 972555510 "40015"  -- Biped: Set Key

												)

											sliderTime = C_End

												(
													select sort_Bip_Obj
													actionMan.executeAction 972555510 "40015"  -- Biped: Set Key

													actionMan.executeAction 972555510 "40019"  -- Biped: Select Body Horizontal
													actionMan.executeAction 972555510 "40015"  -- Biped: Set Key

													actionMan.executeAction 972555510 "40020"  -- Biped: Select Body Vertical
													actionMan.executeAction 972555510 "40015"  -- Biped: Set Key

													actionMan.executeAction 972555510 "40021"  -- Biped: Select Body Rotation
													actionMan.executeAction 972555510 "40015"  -- Biped: Set Key

												)

												(
													select sort_Bip_Obj

														selectKeys $
														deselectKeys $ (animationRange  = (interval  C_Start C_End))

														biped.deleteKeys target_Ver #selection
														biped.deleteKeys target_Hor #selection
														biped.deleteKeys target_Tur #selection

													for i in 1 to sort_Bip_Obj.count do
														(
															biped.deleteKeys sort_Bip_Obj[i].controller #selection
														)
												)
											)

											/* 본에 적용된 아웃오브레인지를 모두 #constant 으로 바꾸기 */
											(
												for i in 1 to sort_Bone_Obj.count do
													(

														if sort_Bone_Obj[i].pos.controller as string == "Controller:Position_XYZ" or
														sort_Bone_Obj[i].pos.controller as string == "Controller:Bezier_Position" or
														sort_Bone_Obj[i].pos.controller as string == "Controller:TCB_Position" do
															(
																setBeforeORT sort_Bone_Obj[i].pos.controller #constant
																setAfterORT sort_Bone_Obj[i].pos.controller #constant

															)

														if sort_Bone_Obj[i].rotation.controller as string == "Controller:Euler_XYZ" or
														sort_Bone_Obj[i].rotation.controller as string == "Controller:TCB_Rotation" do
															(
																setBeforeORT sort_Bone_Obj[i].rotation.controller #constant
																setAfterORT sort_Bone_Obj[i].rotation.controller #constant

															)

														if sort_Bone_Obj[i].Scale.controller as string == "Controller:Bezier_Scale" or
														sort_Bone_Obj[i].Scale.controller as string == "Controller:ScaleXYZ" or
														sort_Bone_Obj[i].Scale.controller as string == "Controller:TCB_Scale" do
															(
																setBeforeORT sort_Bone_Obj[i].Scale.controller #constant
																setAfterORT sort_Bone_Obj[i].Scale.controller #constant
															)

													)
											)
							)
							/* 만약 selection 에 바이패드 오브젝트가 없으면 본의 아웃오브레인지만 #constant 로 바꿈 */
							else
								(
									for i in 1 to obj.count do
										(

											if Obj[i].pos.controller as string == "Controller:Position_XYZ" or
											Obj[i].pos.controller as string == "Controller:Bezier_Position" or
											Obj[i].pos.controller as string == "Controller:TCB_Position" do
												(
													setBeforeORT Obj[i].pos.controller #constant
													setAfterORT Obj[i].pos.controller #constant

												)

											if Obj[i].rotation.controller as string == "Controller:Euler_XYZ" or
											Obj[i].rotation.controller as string == "Controller:TCB_Rotation" do
												(
													setBeforeORT Obj[i].rotation.controller #constant
													setAfterORT Obj[i].rotation.controller #constant

												)

											if Obj[i].Scale.controller as string == "Controller:Bezier_Scale" or
											Obj[i].Scale.controller as string == "Controller:ScaleXYZ" or
											Obj[i].Scale.controller as string == "Controller:TCB_Scale" do
												(
													setBeforeORT Obj[i].Scale.controller #constant
													setAfterORT Obj[i].Scale.controller #constant
												)
										)
								)
					)

				) -- undo on 끝나는 지점

				sliderTime = before_Workframe
				select beforeObj
				print " - Delete Key, Loop Side  - "
			)
)

/* -------------------------------- ------------------------------ ---------------------------------------- ------------------------------- */
/* -------------------------------- ------------------------------ ---------------------------------------- ------------------------------- */
/* -------------------------------- ------------------------------ ---------------------------------------- ------------------------------- */


/* 버튼 UI */

	(
		rollout Biped_loopTool "bipedLoopTool 0.33" width:284 height:920
			(

				button 'loopFrame' "Reduce, loop Area" pos:[5,7] width:274 height:90 align:#left visible:false
				button 'LoopSideFrame' "Expand, loop Area" pos:[5,7] width:274 height:90 align:#right visible:true

					on loopFrame pressed do
						(
							play_LoopArea()
							LoopSideFrame.visible = true
							loopFrame.visible = false
						)

					on LoopSideFrame pressed do
						(
							play_LoopSideArea()
							loopFrame.visible = true
							LoopSideFrame.visible = false
						)


				button 'DeleteLoopSideKey' "Delete key, Loop Side" pos:[5,102] width:134 height:90 align:#left

						on DeleteLoopSideKey pressed do play_Delete_LoopSideKey()


				button 'CopyLoopSideKey' "Copy key, Loop Side" pos:[145,102] width:134 height:90 align:#right

						on CopyLoopSideKey pressed do play_Copy_LoopSideKey()


				spinner 'middleTime' "middle Time:" range:[-20000,20000,middle_Time] scale:1 type:#integer fieldWidth:50 align:#left pos:[8,258]
				on middleTime changed val do
					(

						basicRange()

						middle_Time = val

						if middle_Time <= animationRange.start then print " Stop !! "
							else
								(
									middle_TimeLength = abs (middle_Time - C_Start)

									sliderTime = middle_Time
									animationRange  = (interval C_Start (middle_Time + middle_TimeLength))
								)

					)

				button 'currentFrame_for_middlePoint' "current frame for middle" width:134 height:100 align:#right pos:[145,215]
					on currentFrame_for_middlePoint pressed do
						(
							if animationRange.start == currentTime then print " start is not middle "
								else
									(
										basicRange()

										middle_Time = currentTime

										middle_TimeLength = abs (middle_Time - C_Start)

										animationRange  = (interval C_Start (middle_Time + middle_TimeLength))

										DestroyDialog Biped_loopTool
										createDialog Biped_loopTool
									)
						)



						checkButton bipRoot_check "bipRoot" width:147 height:45 offset:[0,100] align:#center checked:true
							on bipRoot_check changed checked do (print bipRoot_check.checked)


						checkButton Pelvis_check "Pelvis" width:147 height:45 offset:[0,10] align:#center checked:true
							on Pelvis_check changed checked do print (Pelvis_check.checked)


						checkButton Leg_check "Leg" width:147 height:45 offset:[0,0] align:#center checked:true
							on Leg_check changed checked do print (Leg_check.checked)


						checkButton Spine_check "Spine" width:147 height:45 offset:[0,10] align:#center checked:true
							on Spine_check changed checked do print (Spine_check.checked)


						checkButton Neck_check "Neck" width:147 height:45 offset:[0,0] align:#center checked:true
							on Neck_check changed checked do print (Neck_check.checked)


						checkButton Arm_check "Arm" width:147 height:45 offset:[0,10] align:#center checked:true
							on Arm_check changed checked do print (Arm_check.checked)


						checkButton Pony_check "Pony" width:147 height:45 offset:[0,15] align:#center checked:true
							on Pony_check changed checked do print (Pony_check.checked)


						checkButton Tail_check "Tail" width:147 height:45 offset:[0,0] align:#center checked:true
							on Tail_check changed checked do print (Tail_check.checked)


				button 'bipCycle_All' "All" width:134 height:45 offset:[-3,7] align:#center across:2

					on bipCycle_All pressed do
						(
							bipRoot_check.checked = true
							Pelvis_check.checked = true
							Leg_check.checked = true
							Spine_check.checked = true
							Neck_check.checked = true
							Arm_check.checked = true
							Pony_check.checked = true
							Tail_check.checked = true
						)

				button 'bipCycle_None' "None" width:134 height:45 offset:[3,7] align:#center

					on bipCycle_None pressed do
						(
							bipRoot_check.checked = false
							Pelvis_check.checked = false
							Leg_check.checked = false
							Spine_check.checked = false
							Neck_check.checked = false
							Arm_check.checked = false
							Pony_check.checked = false
							Tail_check.checked = false
						)

				button 'Run_Walking_Cycle_Backard' "Cycle\n - Backward Copy" width:134 height:90 align:#left pos:[5,320]

					on Run_Walking_Cycle_Backard pressed do
						(
							undo "Cycle Backward" off
							(

								local obj = getCurrentSelection()
								local before_time = currentTime		-- 대칭 복사하기 전의 프레임을 저장
								local before_animateMode = animButtonState	-- 실행하기 전에  animateMode 상태를 저장

								if obj.count == 0 then
									(
										print " ------- No Selection ------- \t"
									)

								else
									(

										if ((bipRoot_check.checked == true) or (Pelvis_check.checked == true) or (Leg_check.checked == true) or (Spine_check.checked == true) or (Neck_check.checked == true) or (Arm_check.checked == true) or (Pony_check.checked == true) or (Tail_check.checked == true)) then
											(
												bip_PoseSymmetry_WarmUp()
											)
										else print "No, Option"

												/* Root */
											if bipRoot_check.checked == true do (bip_vertical_Backward(); bip_horizontal_Backward(); bip_turning_Backward())
												/* Pelvis */
											if Pelvis_check.checked == true do bip_Common_Backward target_pelvis target_pelvis
												/* Leg */
											if Leg_check.checked == true do
												(
													Bip_Leg_PartArray()		-- 발의 배열을 함수
													Bip_Toe_PartArray()		-- 발가락의 배열는 함수

													select L_Leg_PartArray		-- 왼쪽 다리 선택
													selectmore L_Toe_PartArray	-- 왼쪽 발가락 선택
													local L_partArray = getCurrentSelection()	-- 왼발 배열 만들기

													select R_Leg_PartArray		-- 오른쪽 다리 선택
													selectmore R_Toe_PartArray	-- 오른쪽 발가락 선택
													local R_partArray = getCurrentSelection()	-- 오른발 배열 만들기

														/* 다리 Separate이 꺼져 있는 경우 */
													if target_Bip.controller.sepLegsTracks == false then
														(
															bip_Common_Armleg_Backward target_lleg L_partArray target_rleg R_partArray
														)

														/* 다리 Separate이 켜져 있는 경우 */
													else if target_Bip.controller.sepLegsTracks == true then
														(
															bip_Common_Armleg_Backward_SeparateON L_partArray R_partArray
														)
												)
												/* Spine */
											if Spine_check.checked == true do
												(
													Bip_spine_PartArray()
														/* Spine Separate 꺼져 있는 경우 */
													if target_Bip.controller.sepSpineTracks == false then
														(
															bip_Common_Backward target_spine Spine_PartArray
														)

														/* Spine Separate이 켜져 있는 경우 */
													else if target_Bip.controller.sepSpineTracks == true then
														(
															bip_Common_Backward_SeparateON Spine_PartArray
														)
												)

												/* Neck */
											if Neck_check.checked == true do
												(
													Bip_Neck_PartArray()
													select Neck_PartArray
													selectMore target_head

													local targetNamePart = getCurrentSelection()	-- 목과 머리 배열 만들기

														/* Neck Separate 꺼져 있는 경우 */
													if target_Bip.controller.sepNeckTracks == false then
														(
															bip_Common_Backward target_neck targetNamePart
														)
														/* Neck Separate 켜져 있는 경우 */
													else if target_Bip.controller.sepNeckTracks == true then
														(
															bip_Common_Backward_SeparateON targetNamePart
														)
												)
												/* Arm */
											if Arm_check.checked == true do
												(
													if target_larm != undefined and target_rarm != undefined do
														(
															Bip_Arm_PartArray()		-- 팔의 배열을 함수
															Bip_Fingers_PartArray()		-- 손가락의 배열는 함수

															select L_arm_PartArray		-- 왼쪽 팔 선택
															selectmore L_Fingers_PartArray	-- 왼쪽 손가락 선택
															local L_partArray = getCurrentSelection()	-- 왼발 배열 만들기

															select R_arm_PartArray		-- 오른쪽 팔 선택
															selectmore R_Fingers_PartArray	-- 오른쪽 손가락 선택
															local R_partArray = getCurrentSelection()	-- 오른발 배열 만들기
														)



														/* 팔 Separate이 꺼져 있는 경우 */
													if target_larm != undefined and target_rarm != undefined and target_Bip.controller.sepArmsTracks == false then
														(
															bip_Common_Armleg_Backward target_larm L_partArray target_rarm R_partArray
														)
														/* 팔 Separate이 켜져 있는 경우 -- 손가락은 배열에서 제외 함 */
													else if target_larm != undefined and target_rarm != undefined and target_Bip.controller.sepArmsTracks == true then
														(
															bip_Common_Armleg_Backward_SeparateON L_arm_PartArray R_arm_PartArray
														)
												)

												/* Pony 머리카락은 pony1 과 pony2 가 둘 다 있는 경우만 작동 */
											if Pony_check.checked == true do
												(
													if target_pony1 != undefined and target_pony2 != undefined do
														(
															Bip_Ponytail1_PartArray()
															Bip_Ponytail2_PartArray()
														)
														/* 포니 두 개가 다 있고, Separate가 꺼져 있는 경우 */
													if target_pony1 != undefined and target_pony2 != undefined and target_Bip.controller.sepPonytail1Tracks == false and target_Bip.controller.sepPonytail2Tracks == false then
														(
															bip_Common_Pony_check target_pony1 Ponytail1_PartArray target_pony2 Ponytail2_PartArray
														)
															/* 포니 두 개가 다 있고, Separate가 켜져 있는 경우 */
														else if target_pony1 != undefined and target_pony2 != undefined and target_Bip.controller.sepPonytail1Tracks == true and target_Bip.controller.sepPonytail2Tracks == true then
															(
																bip_Common_Pony_check_SeparateON Ponytail1_PartArray Ponytail2_PartArray
															)
												)

											if Tail_check.checked == true do
												(
													if target_tail != undefined do Bip_Tail_PartArray()

														/* tail Separate 꺼져 있는 경우 */
													if target_tail != undefined and target_Bip.controller.sepTailTracks == false then
														(
															bip_Common_Backward target_tail Tail_PartArray
														)
														/* tail Separate 켜져 있는 경우 */
													else if target_tail != undefined and target_Bip.controller.sepTailTracks == true then
														(
															bip_Common_Forward_SeparateON Tail_PartArray
														)
												)

									)

								deselectKeys $...*	-- 모든 Key 선택 해제
								sliderTime = before_time	-- 이전 작업하던 프레임으로 돌아오기
								select obj		-- 이전에 선택했던 오브젝트 다시 선택하기
								if before_animateMode == false do animButtonState = false

								biped.createCopyCollection target_Ver target_Bip.name	-- 작업을 마무리하고 편의를 위해 포즈 콜렉션 만들어 놓기

							)	-- undo "Cycle Backward" off  끝나는 지점
						)

				button 'Run_Walking_Cycle_Forward' "Cycle\n - Forward Copy" width:134 height:90 align:#right pos:[145,320]

					on Run_Walking_Cycle_Forward pressed do
					(
						undo "Cycle Forward" off
						(

							local obj = getCurrentSelection()
							local before_time = currentTime		-- 대칭 복사하기 전의 프레임을 저장
							local before_animateMode = animButtonState 	-- 실행하기 전에  animateMode 상태를 저장

							if obj.count == 0 then
								(
									print " ------- No Selection ------- \t"
								)

							else
								(

									if ((bipRoot_check.checked == true) or (Pelvis_check.checked == true) or (Leg_check.checked == true) or (Spine_check.checked == true) or (Neck_check.checked == true) or (Arm_check.checked == true) or (Pony_check.checked == true) or (Tail_check.checked == true)) then
										(
											bip_PoseSymmetry_WarmUp()
										)
									else print "No, Option"

											/* Root */
										if bipRoot_check.checked == true do (bip_vertical_Forward(); bip_horizontal_Forward(); bip_turning_Forward())

											/* Pelvis */
										if Pelvis_check.checked == true do bip_Common_Forward target_pelvis target_pelvis

											/* Leg */
										if Leg_check.checked == true do
											(
												Bip_Leg_PartArray()		-- 발의 배열을 함수
												Bip_Toe_PartArray()		-- 발가락의 배열는 함수

												select L_Leg_PartArray		-- 왼쪽 다리 선택
												selectmore L_Toe_PartArray	-- 왼쪽 발가락 선택
												local L_partArray = getCurrentSelection()	-- 왼발 배열 만들기

												select R_Leg_PartArray		-- 오른쪽 다리 선택
												selectmore R_Toe_PartArray	-- 오른쪽 발가락 선택
												local R_partArray = getCurrentSelection()	-- 오른발 배열 만들기

													/* 다리 Separate이 꺼져 있는 경우 */
												if target_Bip.controller.sepLegsTracks == false then
													(
														bip_Common_Armleg_Forward target_lleg L_partArray target_rleg R_partArray
													)

													/* 다리 Separate이 켜져 있는 경우 */
												else if target_Bip.controller.sepLegsTracks == true then
													(
														bip_Common_Armleg_Forward_SeparateON L_partArray R_partArray
													)
											)
											/* Spine_check */
										if Spine_check.checked == true do
											(
												Bip_spine_PartArray()

													/* Spine Separate 꺼져 있는 경우 */
												if target_Bip.controller.sepSpineTracks == false then
													(
														bip_Common_Forward target_spine Spine_PartArray
													)
													/* Spine Separate 켜져 있는 경우 */
												else if target_Bip.controller.sepSpineTracks == true then
													(
														bip_Common_Forward_SeparateON Spine_PartArray
													)
											)

											/* Neck */
										if Neck_check.checked == true do
											(
												Bip_Neck_PartArray()
												select Neck_PartArray
												selectMore target_head

												local targetNamePart = getCurrentSelection()	-- 목과 머리 배열 만들기

													/* Neck Separate 꺼져 있는 경우 */
												if target_Bip.controller.sepNeckTracks == false then
													(
														bip_Common_Forward target_neck targetNamePart
													)
													/* Neck Separate 켜져 있는 경우 */
												else if target_Bip.controller.sepNeckTracks == true then
													(
														bip_Common_Forward_SeparateON targetNamePart
													)
											)
											/* Arm */
										if Arm_check.checked == true do
											(
												if target_larm != undefined and target_rarm != undefined do
													(
														Bip_Arm_PartArray()		-- 팔의 배열을 함수
														Bip_Fingers_PartArray()		-- 손가락의 배열는 함수

														select L_arm_PartArray		-- 왼쪽 팔 선택
														selectmore L_Fingers_PartArray	-- 왼쪽 손가락 선택
														local L_partArray = getCurrentSelection()	-- 왼발 배열 만들기

														select R_arm_PartArray		-- 오른쪽 팔 선택
														selectmore R_Fingers_PartArray	-- 오른쪽 손가락 선택
														local R_partArray = getCurrentSelection()	-- 오른발 배열 만들기
													)

													/* 팔 Separate이 꺼져 있는 경우 */
												if target_larm != undefined and target_rarm != undefined and target_Bip.controller.sepArmsTracks == false then
													(
														bip_Common_Armleg_Forward target_larm L_partArray target_rarm R_partArray
													)
													/* 팔 Separate이 켜져 있는 경우 -- 손가락은 배열에서 제외 함 */
												else if target_larm != undefined and target_rarm != undefined and target_Bip.controller.sepArmsTracks == true then
													(
														bip_Common_Armleg_Forward_SeparateON L_arm_PartArray R_arm_PartArray
													)
											)
											/* Pony 머리카락은 pony1 과 pony2 가 둘 다 있는 경우만 작동 */
										if Pony_check.checked == true do
											(
												if target_pony1 != undefined and target_pony2 != undefined do
													(
														Bip_Ponytail1_PartArray()
														Bip_Ponytail2_PartArray()
													)
													/* 포니 두 개가 다 있고, Separate가 꺼져 있는 경우 */
												if target_pony1 != undefined and target_pony2 != undefined and target_Bip.controller.sepPonytail1Tracks == false and target_Bip.controller.sepPonytail2Tracks == false then
													(
														bip_Common_Pony_check target_pony1 Ponytail1_PartArray target_pony2 Ponytail2_PartArray
													)
														/* 포니 두 개가 다 있고, Separate가 켜져 있는 경우 */
													else if target_pony1 != undefined and target_pony2 != undefined and target_Bip.controller.sepPonytail1Tracks == true and target_Bip.controller.sepPonytail2Tracks == true then
														(
															bip_Common_Pony_check_SeparateON Ponytail1_PartArray Ponytail2_PartArray
														)
											)

											/* Tail */
										if Tail_check.checked == true do
											(
												if target_tail != undefined do Bip_Tail_PartArray()

													/* tail Separate 꺼져 있는 경우 */
												if target_tail != undefined and target_Bip.controller.sepTailTracks == false then
													(
														bip_Common_Forward target_tail Tail_PartArray
													)
													/* tail Separate 켜져 있는 경우 */
												else if target_tail != undefined and target_Bip.controller.sepTailTracks == true then
													(
														bip_Common_Forward_SeparateON Tail_PartArray
													)
											)
								)

							deselectKeys $...*	-- 모든 Key 선택 해제
							sliderTime = before_time	-- 이전 작업하던 프레임으로 돌아오기
							select obj		-- 이전에 선택했던 오브젝트 다시 선택하기
							if before_animateMode == false do animButtonState = false

							biped.createCopyCollection target_Ver target_Bip.name	-- 작업을 마무리하고 편의를 위해 포즈 콜렉션 만들어 놓기


						)	-- undo "Cycle Forward" off  끝나는 지점
					)
			)

		createDialog Biped_loopTool
	)