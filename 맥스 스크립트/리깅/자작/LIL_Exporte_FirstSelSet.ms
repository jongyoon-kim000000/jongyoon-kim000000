
/*만든사람 : 릴종윤 
작업과정
https://blog.naver.com/trueb000/223364025224

*/




theNodes=#()
NamedSelectionSetManager.GetNamedSelSetlList &theNodes 1
select theNodes



pluginManager.loadClass FBXExporter




--Gometry

pluginManager.loadClass FBXExporter
FBXExporterSetParam "SmoothingGroups" true
FBXExporterSetParam "NormalsPerPoly" false
FBXExporterSetParam "TangentSpaceExport" true
FBXExporterSetParam "SmoothMeshExport" false
FBXExporterSetParam "Preserveinstances" false
FBXExporterSetParam "SelectionSetExport" false
FBXExporterSetParam "GeomAsBone" true
FBXExporterSetParam "Triangulate" false  

--Animation 

FBXExporterSetParam "Animation" true
FBXExporterSetParam "UseSceneName" true
FBXExporterSetParam "Removesinglekeys" false
FBXExporterSetParam "BakeAnimation" true
FBXExporterSetParam "BakeFrameStart" (animationRange.start.frame as integer)
FBXExporterSetParam "BakeFrameEnd" (animationRange.end.frame as integer)
FBXExporterSetParam "BakeFrameStep" 1
FBXExporterSetParam "Skin" true
FBXExporterSetParam "Shape" true
FBXExporterSetParam "FilterKeyReducer" false
FBXExporterSetParam "PointCache" false                

 

--Advanced option

FBXExporterSetParam "ScaleFactor"  1.0
FBXExporterSetParam "ConvertUnit" "cm" 
FBXExporterSetParam "UpAxis" "Z"

--ui

FBXExporterSetParam "ShowWarnings" false
FBXExporterSetParam "GenerateLog" false

--fileformat
FBXExporterSetParam "ASCII" false
FBXExporterSetParam "FileVersion" E"FBX201600" 



 

exptFileName = getFilenameFile maxFileName
Filepath = maxfilepath + "\\" + exptFileName + ".fbx"
exportFile Filepath #noPrompt selectedOnly:true



