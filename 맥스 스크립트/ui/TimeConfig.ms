--==========================================================================================================
--==========================================================================================================

-- TimeConfig : Animation Range를 편하게 조절하기 위한 스크립트 입니다.
-- 버그나 관련 내용 문의 요청 언제나 환영

-- 제작 : 황군

--==========================================================================================================
--==========================================================================================================

(
global g_TimeConfigRollout

global G_InitTimeConfig



--======================================================================================
-- Callbacks
--======================================================================================	
--------------------------------------------------------------------
-- G_InitTimeConfig
--------------------------------------------------------------------
fn G_InitTimeConfig =
(
	rot = g_TimeConfigRollout
	
	if rot.spn_StartTime.value != animationRange.start then
		rot.spn_StartTime.value = animationRange.start
	
	if rot.spn_EndTime.value != animationRange.end then
		rot.spn_EndTime.value = animationRange.end
)



--======================================================================================
-- DestroyDialog
--======================================================================================
try(cui.UnRegisterDialogBar g_TimeConfigRollout) catch()
try(destroyDialog g_TimeConfigRollout) catch()




--==========================================================================================================

-- SequenceManager Rollout

--==========================================================================================================
rollout g_TimeConfigRollout "Time Config"
(
	button btn_To0f "0f" align:#left width:25 height:25 pos:[0,0]
	button btn_StartNow "Start" align:#left width:55 height:25 pos:[30,0]
	spinner spn_StartTime "Time :" type:#integer range:[-66666,66666,0]width:70 pos:[110,5]
	spinner spn_EndTime "Time :" type:#integer range:[-66666,66666,100] width:70 pos:[220,5]
	button btn_EndNow "End" align:#left width:55 height:25 pos:[290,0]
	
	spinner spn_Sampling "Sampling :" type:#integer range:[-66666,66666,1]width:70 pos:[410,5]
	spinner spn_SamplingTime "Sampling Time :" type:#float range:[0,10,1]width:70 pos:[550,5]
	button btn_SamplingPlay "Play" align:#left width:55 height:25 pos:[630,0]
	
	label lbl_Maker "Hwanggoon" pos:[700,5]
	
	
	
	--======================================================================================
	-- fn
	--======================================================================================
	--------------------------------------------------------------------
	-- ConvertDialogBar
	--------------------------------------------------------------------
	fn ConvertDialogBar rot dockFlag: =
	(
		cui.registerDialogBar rot
		
		if IsKindOf dockFlag Name then
			cui.dockDialogBar rot dockFlag
	)
	
	
	
	--======================================================================================
	-- UI Control
	--======================================================================================
	----------------------------------------------------------------------------------------
	-- btn_To0f
	----------------------------------------------------------------------------------------
	on btn_To0f pressed do
	(
		startF = animationRange.start
		endF = animationRange.end
		
		if 0f < endF then
			animationRange = interval 0f endF
		else
			animationRange = interval startF 0f
		
		sliderTime = 0f
	)
	
	
	----------------------------------------------------------------------------------------
	-- btn_StartNow
	----------------------------------------------------------------------------------------
	on btn_StartNow pressed do
	(
		if animationRange.end > currentTime then
			animationRange = interval currentTime animationRange.end
	)
	
	
	----------------------------------------------------------------------------------------
	-- spn_StartTime
	----------------------------------------------------------------------------------------
	on spn_StartTime changed state do
	(
		local endF = animationRange.end
		if state >= endF then
			endF = state + 1
		
		animationRange = interval state endF
	)
	
	
	----------------------------------------------------------------------------------------
	-- spn_EndTime
	----------------------------------------------------------------------------------------
	on spn_EndTime changed state do
	(
		local startF = animationRange.start
		if state <= startF then
			startF = state - 1
		
		animationRange = interval startF state
	)
	
	
	----------------------------------------------------------------------------------------
	-- btn_EndNow
	----------------------------------------------------------------------------------------
	on btn_EndNow pressed do
	(
		if animationRange.start < currentTime then
			animationRange = interval animationRange.start currentTime
	)
	
	
	----------------------------------------------------------------------------------------
	-- btn_SamplingPlay
	----------------------------------------------------------------------------------------
	on btn_SamplingPlay pressed do
	(
		oldFrame = sliderTime
		
		isESC = false
		for i = animationRange.start to animationRange.end by spn_Sampling.value do
		(
			sliderTime = i
			
			startTime = timeStamp()
			
			isExit = false
			while not isExit do
			(
				endTime = timeStamp()
				if (endTime - startTime) / 1000.0 > spn_SamplingTime.value then
					isExit = true
				
				-- ESC 탈출 --
				if keyboard.escPressed then
				(
					isExit = true
					isESC = true
				)
			)
			
			if isESC then
			(
				sliderTime = oldFrame
				return 0
			)
		)
		
		sliderTime = oldFrame
	)
	
	
	----------------------------------------------------------------------------------------
	-- open
	----------------------------------------------------------------------------------------
	on g_TimeConfigRollout open do
	(
		G_InitTimeConfig()
		
		ConvertDialogBar g_TimeConfigRollout dockFlag:#cui_dock_bottom
		
		callbacks.addScript #animationRangeChange "G_InitTimeConfig()" id:#InitTimeConfig
	)
	
	
	----------------------------------------------------------------------------------------
	-- close
	----------------------------------------------------------------------------------------
	on g_TimeConfigRollout close do
	(
		callbacks.removeScripts #animationRangeChange id:#InitTimeConfig
	)
)

 

--======================================================================================
-- CreateDialog
--======================================================================================
createDialog g_TimeConfigRollout width:770 height:25
)