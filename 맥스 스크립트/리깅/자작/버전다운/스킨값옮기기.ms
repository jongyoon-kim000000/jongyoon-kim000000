스킨값을 옮기는데 도움을 주는 툴입니다.

사용방법
(스킨 모디파이어가 활성화된 상태에서만 사용가능)
1. 셀렉타입을 지정한다. Old bone과 관련된 모든 vertex에 적용하려면 all Type에 체크, 선택한 vertex에만 적용하려면 select Type에 체크한다.
2.	Skin modifier의 본리스트에서 웨이트값을 없앨 본을 선택하고 Old bone버튼을 누른다
	Type을 select에 체크한  경우, Old bone 버튼을 누르기 전에 버텍스를 선택한다.
3.	Skin modifier의 본리스트에서 웨이트값을 옮겨줄 본을 선택하고 New bone버튼을 누른다.
4.	Replace 버튼을 누르면 Old bone의 웨이트값이 New bone으로 옮겨간다.

*/

try (destroydialog ReplaceSkinweight) catch()

rollout ReplaceSkinweight "v1.1 Replace Skin Weight" width:150 height:192
(
	local skinmesh
	local oldBoneIndex
	local newBoneIndex

	local arr_vertexnumber = #()
	local arr_BoneIndex = #()
	local arr_BoneWeight = #()
	local arr_rowBoneID = #()
	local arr_rowWeight = #()

	---------------------------------------------------------------
	--UI
	---------------------------------------------------------------
	--checkbox Chk_sub1 "sub" pos:[85,78] width:47 height:17

	radiobuttons SelType "" pos:[36,17] width:80 height:32 labels:#("All", "Selected") columns:1
	button Btn_ChkoldBone "Old bone" pos:[36,61] width:79 height:21
	button Btn_ChknewBone "New bone" pos:[36,88] width:79 height:21
	button Btn_Replace "Replace" pos:[36,115] width:79 height:21
	button Btn_Reset "Reset" pos:[36,142] width:79 height:21

	---------------------------------------------------------------
	--FUNCTION
	---------------------------------------------------------------
	fn fn_CheckboneName skinmesh SelBoneIndex Bonename =
	(
		theSkin = skinmesh.modifiers[#Skin]
		SelBoneIndex = skinOps.GetSelectedBone theSkin
		Bonename = skinOps.GetBoneName theSkin SelBoneIndex 0
	)

	fn getskinvertexSelection theVertsCount theSkin arr_selvertex=
	(

		for s in 1 to theVertsCount do
		(
			chk = skinOps.IsVertexSelected theSkin s
			if (chk == 1) do	append arr_selvertex s
		)
		return arr_selvertex
	)

	--버텍스 어레이 추출
	fn fn_CheckAffectedVertex skinmesh =
	(

		arr_BoneIndex = #()
		arr_BoneWeight = #()
		theSkin = skinmesh.modifiers[#Skin]
		skinOps.RemoveZeroWeights theSkin
		theVertsCount = getNumVerts $

		if (SelType.state == 1) do
		(
			for v in 1 to theVertsCount do
			(
				theW_count= skinOps.GetVertexWeightCount theSkin v
				for b in 1 to theW_count do
				(
					theBoneIndex = skinOps.GetVertexWeightBoneID theSkin v b	--v 버텍스에 영향을 주는 본의 인덱스값을 추출
					if (theBoneIndex == oldBoneIndex) do appendifUnique arr_vertexnumber v
				)
			)
		)

		if (SelType.state == 2) do
		(
			arr_selvertex=#()
			getskinvertexSelection theVertsCount theSkin arr_selvertex
			print arr_selvertex
			for v in arr_selvertex do
			(
				theW_count= skinOps.GetVertexWeightCount theSkin v
				for b in 1 to theW_count do
				(
					theBoneIndex = skinOps.GetVertexWeightBoneID theSkin v b	--v 버텍스에 영향을 주는 본의 인덱스값을 추출
					if (theBoneIndex == oldBoneIndex) do appendifUnique arr_vertexnumber v
				)
			)
		)
		return arr_vertexnumber
	)

	--추출한 버텍스 배열에서 올드 본 웨이트값을 추출하여 새 본 웨이트로 옮김
	fn fn_ReplacevertexWeight skinmesh oldBoneIndex newBoneIndex =
	(

		theSkin = skinmesh.modifiers[#Skin]
		skinOps.SelectVertices theSkin arr_vertexnumber

		for v in 1 to arr_vertexnumber.count do
		(
			arr_rowBoneID = #()
			arr_rowWeight = #()
			arr_BoneIndex = #()
			arr_BoneWeight = #()

			theW_count= skinOps.GetVertexWeightCount theSkin arr_vertexnumber[v]

			for b in 1 to theW_count do
			(
				theBoneweight = SkinOps.getvertexweight theSkin arr_vertexnumber[v] b
				append arr_rowWeight theBoneweight
				theBoneIndex = skinOps.GetVertexWeightBoneID theSkin arr_vertexnumber[v] b
				append arr_rowBoneID theBoneIndex
			)
			print arr_rowBoneID.count
			checkindex = finditem arr_rowBoneID newBoneIndex --배열에 뉴본인덱스가 있는지 확인
			(
				if (checkindex == 0) do --뉴본인덱스가 없다면
				(
					for c in 1 to arr_rowBoneID.count do
					(
						if (arr_rowBoneID[c] == oldBoneIndex) then (append arr_BoneIndex newBoneIndex)
						else (append arr_BoneIndex arr_rowBoneID[c])
					)
 					for d in 1 to  arr_rowWeight.count do (append arr_BoneWeight arr_rowWeight[d])
				)

				if (checkindex != 0) do --뉴본인덱스가 있다면
				(
					local Nold
					local Nnew

					for c in 1 to arr_rowBoneID.count do
					(
						if (arr_rowBoneID[c] == oldBoneIndex) then (Nold = c
							append arr_BoneIndex newBoneIndex)
						else if (arr_rowBoneID[c] == newBoneIndex) then (Nnew = c)
						else (append arr_BoneIndex arr_rowBoneID[c])
					)
-- 					arr_rowBoneID[Nold] = newBoneIndex
-- 					deleteitem arr_rowBoneID Nnew
-- 					append arr_BoneIndex arr_rowBoneID

					--올드본과 뉴본 웨이트값이 분리되어 있으므로 두개를 더하여 하나의 아이템으로 만듬
					arr_rowWeight[Nold] = arr_rowWeight[Nold] + arr_rowWeight[Nnew]
					deleteitem arr_rowWeight Nnew

					addWeight = 0.0
					for i in 1 to arr_rowWeight.count do
					(
						addWeight += arr_rowWeight[i]
						append arr_BoneWeight arr_rowWeight[i]
					)

					--if (addWeight == 1) then append arr_BoneWeight arr_rowWeight else print arr_vertexnumber[v]

				)
			)

			if ( arr_BoneIndex.count == arr_BoneWeight.count) do
			(
				skinOps.SetVertexWeights theSkin arr_vertexnumber[v] newBoneIndex 1
				skinOps.ReplaceVertexWeights theSkin arr_vertexnumber[v] arr_BoneIndex arr_BoneWeight
			)
		)

	)


	---------------------------------------------------------------
	--EVENT
	---------------------------------------------------------------



	on Btn_ChkoldBone pressed do
	(
		skinmesh = $
		theSkin = skinmesh.modifiers[#Skin]
		oldBoneIndex = skinOps.GetSelectedBone theSkin
		oldBonename = skinOps.GetBoneName theSkin oldBoneIndex 0
		Btn_ChkoldBone.text = oldBonename as string

		arr_vertexnumber = #()
		fn_CheckAffectedVertex skinmesh

		--print arr_vertexnumber.count
	)
	on Btn_ChknewBone pressed do
	(
		theSkin = skinmesh.modifiers[#Skin]
		newBoneIndex = skinOps.GetSelectedBone theSkin
		newBonename = skinOps.GetBoneName theSkin newBoneIndex 0
		if (newBonename as string != Btn_ChkoldBone.text) then Btn_ChknewBone.text = newBonename as string
		else (messageBox "oldbone과 newbone은 같을 수 없습니다.")
	)
	on Btn_Replace pressed do
	(
		 fn_ReplacevertexWeight skinmesh oldBoneIndex newBoneIndex
	)
	on Btn_Reset pressed do
	(
		Btn_ChkoldBone.text = "Old bone"
		Btn_ChknewBone.text = "New bone"

		arr_vertexnumber = #()
		arr_BoneIndex = #()
		arr_BoneWeight = #()
		arr_rowBoneID = #()
		arr_rowWeight = #()
	)

)

createDialog  ReplaceSkinweight 150 195
