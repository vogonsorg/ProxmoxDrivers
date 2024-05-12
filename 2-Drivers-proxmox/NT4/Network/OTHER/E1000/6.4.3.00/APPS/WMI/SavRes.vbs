'******************************************************************************************************
'version 1.3
'This script saves and restores NCS-WMI settings to and from a text file.
'It is intended to be used in a fully unattended installation of Windows 2000 or Windows 2003 Server
'In this version,the configuration text file can also be modified manually.
'Detailed instructions can be found in SavResUG.doc
'author: Sebastien Michelet 
'version 1.4
'Added support to save and restore Express Teams
'Added support to save and restore Manageability Teams
'author: Radheka Godse 
'******************************************************************************************************


Option Explicit

dim bFileFound						'Boolean true if configuration text file is found
dim SValueSet						'SWbemNamedValueSet holds a session handle name/value set
dim strNetServiceObjPath			'String path to a IANet_NetService instance
dim objSession						'Object holding the session handle
dim wbemServices					'SWbemServices instance
dim objFile							'Textstream Object for configuration
dim strUserChoice 					'String holding first argument save/restore
dim intArgs							'Number of Arguments 
dim strConfigFileName				'String holding configuration file name
dim Adapters()						'3-dimension array holding adapter configuration
dim Teams()							'3-dimension array holding team configuration
dim AdapterName()					'1-dimension array holding adapter names
dim AdapterCapabilities()			'1-dimension array holding adapter capabilities
dim AdapterDescription()			'1-dimension array holding adapter descriptions
dim TeamName()						'1-dimension array holding team names
dim TeamAdapterCount()				'1-dimension array holding team number of member adapters
dim TeamType()						'1-dimension array holding team types
dim ManageabilityTeam()				'boolean TRUE if Manageability team 
dim TeamDescription() 				'1-dimension array holding team descriptions
dim bFoundAdapterInSystem()			'boolean TRUE if adapter is installed in system
dim bAddedToATeam()					'boolean TRUE if adapter is already member of a team
dim bFoundServerAdapter				'boolean TRUE if team has at least one server adapter
dim NumberOfAdapters				'Number of adapters in configuration file
dim NumberofTeams					'Number of teams in configuration file
dim AdapterIndex					'Index identifying adapter in configuration file
dim TeamIndex						'Index identifying team in configuration file
dim strValidAdapterPath()			'1-dimension array holding string paths of adapters found in system
dim intMemberAdapterFunction()		'1-dimension array holding string paths of member adapter functions		
dim Settings()						'1-dimension array holding name/value settings
dim TeamPath						'SWbemObjectPath holding a team path 
dim bIsTeamMember()					'Boolean true if adapter is member of a team
dim bIsServerAdapter()				'Boolean true if adapter is a server adapter
dim bAllSettings						'Boolean true if the user selected "saveall" option
dim bdebug							'Boolean for debugging only
dim bHasVlan						'Boolean true if current adapter or team has at least one vlan
const MaxVlans=64					
const MaxAdapters=64
const MaxTeams=64
const MaxSettings=200
Const wbemFlagUseAmendedQualifiers = &h20000
Const wbemFlagAmendedUpdateOnly = &h20001
Const wbemFlagAmendedCreateOnly = &h20002


'*********************************************************************************
'Main script takes user command line arguments and save or restore to/from a configuration
'text file.
'*********************************************************************************'

strConfigFileName="Wmiconf.txt"
intArgs=WScript.Arguments.count
bAllSettings=FALSE
bDebug=FALSE
On Error Resume Next
If intArgs=1 or intArgs=2 then
	strUserChoice=ucase(WScript.Arguments(0))
	If intArgs=2 then
		strConfigFileName=WScript.Arguments(1)
	End If	
	'Create an instance of SWbemServices 	
	Set wbemServices = GetObject("winmgmts:{impersonationLevel=impersonate}//./root/IntelNcs")	
	'option #1: save configuration without settings
	If strUserChoice= "SAVE" then
		 SaveSettings(strConfigFileName)
	'option #2: save configuration with settings	 
	ElseIf strUserChoice= "SAVEALL" then
	     bAllSettings=TRUE
	     SaveSettings(strConfigFileName)   
	'option #3: restore configuration from the text file		
	ElseIf strUserChoice="RESTORE" Then
		Dim colAdapters 
		Dim objAdapter
		Dim bETFound
		bETFound=FALSE
		Set colAdapters = wbemServices.InstancesOf("IANet_EthernetAdapter where ExpressTeam=1")	
		For each objAdapter In colAdapters	
			wscript.echo "Remove all Express teams before restoring configuration"
			bETFound=TRUE
		Next
		If bETFound=FALSE Then
			Set objFile=OpenConfigFile(strConfigFileName)
			If bFileFound Then
				Set SValueSet = CreateObject("WbemScripting.SWbemNamedValueSet")
				Set objSession= CreateSession()
				SValueSet.Add "SessionHandle", objSession.SessionHandle
				SValueSet.Add "TeamRename", TRUE
				'Delete any existing team or vlan
				RemoveTeamVlans()
				'wscript.sleep 1000
				'Delete any existing express teams
				RemoveExpressTeams()
				'wscript.sleep 1000
				'parse the configuration file
				ReadConfigFile(objFile)
				'validate if adapters in the file are present in the system
				ValidateAdapters()
				'Restore vlans, settings and teams for all adapters found in the system
				For AdapterIndex=1 to NumberOfAdapters
					If bFoundAdapterInSystem(AdapterIndex)=TRUE Then
						 RestoreVlans "Adapter"
						 RestoreSettings "Adapter"
					End If		
				Next
				For TeamIndex=1 to NumberOfTeams
					Set TeamPath=RestoreTeam(TeamIndex)
					wscript.sleep 1000
					If bFoundServerAdapter=TRUE Then
						RestoreVlans "Team"
						RestoreSettings "Team"
					End if	
					wscript.echo ""			
				Next						
				ExecApply strNetServiceObjPath, objSession
				ReleaseHandle strNetServiceObjPath, objSession
			End If
		End If
	Else
		PrintUsage()
	End If
Else
	PrintUsage()
End If	
'*********************************************************************************
'Sub PrintUsage()
'Output the command line options if user choice is not valid
'*********************************************************************************
Sub PrintUsage()

wscript.echo "Usage: cscript savres.vbs save|saveall|restore [FileName]"
wscript.echo 
wscript.echo "Save		: saves configuration with non-default settings to a text file."
wscript.echo "Saveall	: saves configuration with all settings to a text file. "
wscript.echo "Restore		: restores configuration from the text file."
wscript.echo "[FileName]	: configuration file name."
wscript.echo "Default file name is Wmiconf.txt if FileName is not provided"
wscript.echo "Please refer to savresUG.doc for detailed user guide"
End Sub
'*********************************************************************************
'Private Function OpenConfigFile(byVal StrFileName)
'Returns a textstream object for reading of writing to StrFileName.
'*********************************************************************************
Private Function OpenConfigFile(byVal StrFileName)
	dim fso
	bFileFound=TRUE
	Set fso = CreateObject("Scripting.FileSystemObject")
	If fso.FileExists (strFilename) <> True Then
		Wscript.Echo "File "&strFilename&" can not be found or is not in the same directory as savres.vbs"
		WScript.Echo "Try using full pathname to the configuration file."
		Set OpenConfigFile=Nothing
		bFileFound=FALSE
	Else
	    wscript.echo "Restoring configuration from "&strFilename
		Set OpenConfigFile=fso.OpenTextfile(strFileName,1)
	End If
End Function
'*********************************************************************************
'Sub RestoreSettings(strObject)
'Restores advanced settings for adapter or team. Calls SetSettings with 
'appropriate arguments.
'*********************************************************************************
Sub RestoreSettings(strObject)
Redim Settings(MaxSettings)
dim SettingIndex
	Select Case strObject
		Case "Adapter"
		For SettingIndex =0 to MaxSettings
			Settings(SettingIndex)=Adapters(AdapterIndex,0,SettingIndex)
			'wscript.echo "setting("&i&")="&Settings(i)
		Next	
		SetSettings Settings,strValidAdapterPath(AdapterIndex)
		Case "Team"
		For SettingIndex =0 to MaxSettings
			Settings(SettingIndex)=Teams(TeamIndex,1,SettingIndex)
			'wscript.echo "setting("&SettingIndex&")="&Settings(SettingIndex)
		Next
		SetSettings Settings,Teampath.path	
	End Select		
End Sub	
'*********************************************************************************
'Sub RestoreVlans(strObject)
'Restore vlans for adapter or team. Calls CreateVlan with appropriate arguments.
'also restore settings specific to vlans (if any).
'*********************************************************************************
Sub RestoreVlans(strObject)
Redim Settings(MaxSettings)
dim VlanIndex
dim SettingIndex
dim strVlanPath

  bHasVlan=FALSE
  Select Case strObject
	Case "Adapter"
	VlanIndex=1
	While Adapters(AdapterIndex,VlanIndex,0)<>""
		bHasVlan=TRUE
		strVlanPath=CreateVlan(Adapters(AdapterIndex,VlanIndex,0),Adapters(AdapterIndex,VlanIndex,1),strValidAdapterPath(AdapterIndex))
		For SettingIndex=0 to MaxSettings-2
			Settings(SettingIndex)=Adapters(AdapterIndex,VlanIndex,SettingIndex+2)
		Next
		if strVlanPath<>"" then
			SetSettings Settings,strVlanPath		
		end if	
		VlanIndex=VlanIndex+1	
	Wend
	Case "Team"
	VlanIndex=2
	While Teams(TeamIndex,VlanIndex,0)<>""
		bHasVlan=TRUE
		strVlanPath=CreateVlan(Teams(TeamIndex,VlanIndex,0),Teams(TeamIndex,VlanIndex,1),TeamPath.path)
		VlanIndex=VlanIndex+1
	Wend			
  End Select		
End Sub	
'*********************************************************************************
'Function RestoreTeam(TeamIndex)
'Restore the team identified by TeamIndex and returns the object path of the 
'corresponding IANet_EthernetAdapter instance. 
'*********************************************************************************
Function RestoreTeam(TeamIndex)
dim MemberIndex
dim AdapterIndex
dim objIANetTeamClassDef
dim objIANetTeamedAdapterClassDef
dim objTeam
dim objAdapter
dim	objTeamedAdapter
dim objTeamedAdapterPath
dim objTeampath
dim strQuery
dim colVirtualAdapter
dim objVirtualAdapter	
dim index
dim bool
dim pass
dim objTeamInstance
	
Redim intMemberAdapterFunction(TeamadapterCount(TeamIndex))	
Redim intAdapterIndex(TeamadapterCount(TeamIndex))
	On Error Resume Next
	bFoundServerAdapter=FALSE
	'Find a matching adapter index for each member adapter in the team
	For MemberIndex=1 to TeamAdapterCount(TeamIndex) 
		For AdapterIndex=1 to NumberOfAdapters
			If StrComp(AdapterName(AdapterIndex),Teams(TeamIndex,0,MemberIndex*2-2))=0 and _
			   bFoundAdapterInSystem(AdapterIndex)=TRUE Then	
				If bIsTeamMember(AdapterIndex)=FALSE Then
					 intAdapterIndex(MemberIndex)=AdapterIndex
					 intMemberAdapterFunction(MemberIndex)=Teams(TeamIndex,0,MemberIndex*2-1)
					 bIsTeamMember(AdapterIndex)=TRUE
					 'check if there is at least one server adapter in the team	
					 If bIsServerAdapter(AdapterIndex)=TRUE Then	
					   bFoundServerAdapter=TRUE
					 End if  
					 Exit For
				End if	 	
			End if
		Next
	Next
	'if there is at least one server adapter, restore the team
	If bFoundServerAdapter=TRUE then
		'Create the team instance
		Set objIANetTeamClassDef=wbemServices.Get("IANet_TeamOfAdapters")
		Set objTeam=objIANetTeamClassDef.SpawnInstance_
		objTeam.TeamingMode=TeamType(TeamIndex)
		objTeam.ManageabilityEnabled=ManageabilityTeam(TeamIndex)
		
		Set objTeampath= objTeam.Put_ (wbemFlagAmendedCreateOnly,SvalueSet)
		If err then
		  WScript.Echo "FAIL: Team  "&TeamName(TeamIndex) &" can not be created"
		  err.clear
		else
		  WScript.Echo "SUCCESS: Creating Team: "& TeamName(TeamIndex)  
		End if  
		'Use a team instance to update the team name
		Set objTeamInstance=wbemServices.Get(objTeampath,,SvalueSet)
		objTeamInstance.Caption=TeamName(TeamIndex)
	    objTeamInstance.Put_ wbemFlagAmendedUpdateOnly,SvalueSet
		
		Set objIANetTeamedAdapterClassDef=wbemServices.Get("IANet_TeamedMemberAdapter",,SValueSet)
	    'add all server adapters in pass #1 and all desktop adapters in pass #2
	    bool=TRUE
	    For pass=1 to 2	
			For MemberIndex=1 to TeamAdapterCount(TeamIndex)
				Index=intAdapterIndex(MemberIndex)
				If bIsServerAdapter(Index)=bool Then
					If 	strValidAdapterPath(Index)<>"" Then
					    'create instances of IANet_TeamedMemberAdapter
						Set objTeamedAdapter=objIANetTeamedAdapterClassDef.SpawnInstance_	
						objTeamedAdapter.GroupComponent=objTeamPath.Path
						objTeamedAdapter.PartComponent=strValidAdapterPath(Index) 
						Set objTeamedAdapterPath= objTeamedAdapter.Put_ (wbemFlagAmendedCreateOnly, SValueSet)
						if err then
						  Wscript.echo "FAIL: Adapter "&AdapterName(Index)&" can not be added to "&TeamName(TeamIndex)
						  err.clear
						else
						  WScript.Echo "SUCCESS: Adding Adapter "&AdapterName(Index)
						end if  	  
						'Update the member adapter preferred priority settings
						objTeamedAdapter.AdapterFunction=intMemberAdapterFunction(MemberIndex)
						objTeamedAdapter.Put_ wbemFlagAmendedUpdateOnly, SValueSet	
						if err then 
						  Wscript.echo "FAIL: Priority "&objTeamedAdapter.AdapterFunction&" can not be set on Adapter "&AdapterName(Index)
						  err.clear
						end if
					End If
				End If		
			Next
			bool=FALSE
		Next	 
		'Return the object path of the IANet_EthernetAdapter instance associated with this team
		strQuery="ASSOCIATORS OF {"&objTeampath.Path&"} where ResultClass=IANet_EthernetAdapter"
		Set colVirtualAdapter = wbemServices.ExecQuery(strQuery,,,SValueSet)
		For each objVirtualAdapter in colVirtualAdapter	
			Set RestoreTeam=objVirtualAdapter.Path_
			Exit for
		Next	
	else
		wscript.echo "No Server adapter was found in team "&TeamName(TeamIndex)
		Set RestoreTeam=Nothing
	End if
End Function
'*********************************************************************************
'Function CreateSession()	
'Returns a session object with a property SessionHandle
'*********************************************************************************
Function CreateSession()	
	dim colNetServiceSet
	dim objNetService
	dim objOutParameters
	dim objInParameters
	
	Set colNetServiceSet = wbemServices.InstancesOf("IANet_NetService")	
	For Each objNetService In colNetServiceSet	
		strNetServiceObjPath = objNetService.Path_.Path				
		Set objOutParameters = objNetService.ExecMethod_("GetSessionHandle")
		Set objInParameters = objNetService.Methods_.Item("Apply").InParameters		
		objInParameters.SessionHandle = objOutParameters.SessionHandle
	Next	
	Set CreateSession=objInParameters	
End Function
'*********************************************************************************
'Sub ExecApply(ByVal strNetSerObjPath, ByVal SessionObject)	
'Execute the Apply method with SessionObject as an argument
'*********************************************************************************
Sub ExecApply(ByVal strNetSerObjPath, ByVal SessionObject)
	dim NetServiceObject
	dim FinalTargetObj
	
	WScript.Echo "Applying configuration..."	
	Set NetServiceObject = wbemServices.Get(strNetSerObjPath)
	Set FinalTargetobj = NetServiceObject.ExecMethod_("Apply", SessionObject)
End Sub
'*********************************************************************************
'Sub ReleaseHandle(ByVal strNetSerObjPath, ByVal SessionObject)
'Execute the ReleaseSessionHandle method with SessionObject as an argument
'*********************************************************************************
Sub ReleaseHandle(ByVal strNetSerObjPath, ByVal SessionObject)
	dim NetServiceObject
	dim FinalTargetObj
	
	WScript.Echo "Releasing Session Handle"
	Set NetServiceObject = wbemServices.Get(strNetSerObjPath)
	Set FinalTargetobj = NetServiceObject.ExecMethod_("ReleaseSessionHandle", SessionObject)
End Sub
'*****************************************************************************************
'Sub RemoveTeamVlans()
'Remove any existing team or vlan instances
'*****************************************************************************************
Sub RemoveTeamVlans()
	dim VLANObjSet
	dim VLANObj
	dim TeamsObjSet
	dim TeamObj
	
	'Remove any existing teams or vlans
	Set VLANObjSet = wbemServices.InstancesOf("IANet_VLAN",,SValueSet)
	For Each VLANObj In VLANObjSet
			'bHasTeamOrVLAN = TRUE 
			WScript.Echo "Removing existing VLAN "&VLANObj.Caption
			VLANObj.Delete_ 0, SValueSet
	Next
	Set TeamsObjSet = wbemServices.InstancesOf("IANet_TeamOfAdapters",,SValueSet)
	For Each TeamObj In TeamsObjSet
			WScript.Echo "Removing existing Team "&TeamObj.caption
			'bHasTeamOrVLAN = True
			TeamObj.Delete_ 0, SValueSet
	Next
	
End Sub

'*****************************************************************************************
'Sub RemoveExpressTeams()
'Remove any existing team or vlan instances
'*****************************************************************************************
Sub RemoveExpressTeams()
	dim colAdapters
	dim objAdapter
	dim getobjAdapter
	dim objOutParameters
	dim objInParameters
	dim	oOutParams
	On Error Resume Next
	Set colAdapters = wbemServices.InstancesOf("IANet_EthernetAdapter where ExpressTeam=1")	
	For Each objAdapter In colAdapters	
		wscript.echo "Removing Express team"
		Set objInParameters=objAdapter.Methods_.Item("RemoveExpressTeam").InParameters
		objOutParameters = objAdapter.ExecMethod_("RemoveExpressTeam",objInParameters,0,SvalueSet)
	Next
		wscript.echo " "
'	If err then	
'		wscript.echo "FAIL: Remove Express Team"
'		err.clear
'	else 
'		wscript.echo "SUCCESS: Remove Express Team"
'	End if
End Sub


'*****************************************************************************************
'Function CreateVlan(strVlanName,intVlanID,strAdapterPath)
'Returns a vlan object path with name strVlanName and ID intVlanID under the adapter identified 
'by strAdapterPath
'*****************************************************************************************
Function CreateVlan(strVlanName,intVlanID,strAdapterPath)
	dim colVlanServices
	dim objVlanService 
	dim objInParameters
	dim objOutParameters
	dim strQuery
	On Error Resume Next
	strQuery="Associators of {"&strAdapterPath&"} where ResultClass=IANet_802dot1QVlanService"
	Set colVlanServices=wbemServices.ExecQuery(strQuery,,,SValueSet)
	'wscript.echo "vlanservice="&colvlanservices.count
	For Each objVlanService in colVlanServices
		Set objInParameters=objVlanService.Methods_.Item("CreateVlan").InParameters
		objInParameters.VlanNumber=intVlanID
		objInParameters.Name=strVlanName
		Set objOutParameters=objVlanService.ExecMethod_("CreateVlan",objInParameters,0,SvalueSet)
	Next
		CreateVlan=objOutParameters.vlanpath
	If err then	
		wscript.echo "FAIL: Vlan "&strVlanName&" can not be created"
		err.clear
	else 
		wscript.echo "SUCCESS: Creating Vlan "&strVlanName
	End if		
End Function
'*****************************************************************************************
'Sub SetSettings(ArrayofSettings,strAdapterPath)
'Update the settings contained in ArrayofSettings for the adapter (or team) defined by strAdapterPath
'ArrayofSettings stores data as (name1,value1,name2,value2,...)
'*****************************************************************************************
Sub SetSettings(ArrayofSettings,strAdapterPath)
	dim colConfigurations
	dim objConfiguration
	dim colDefaultSettings
	dim objSetting
	dim SettingIndex
	dim strQuery
	
	strQuery="Associators of {"&strAdapterPath&"} where ResultClass=IANet_Configuration"
	Set colConfigurations= wbemServices.ExecQuery(strQuery,,,SValueSet)
	For Each objConfiguration in colConfigurations
		strQuery="Associators of {"&objConfiguration.Path_.Path&"} where AssocClass=IANet_SettingContext"	
		Set colDefaultSettings= wbemServices.ExecQuery(strQuery,,,SValueSet)
		For Each objSetting in colDefaultSettings
			'Find the matching setting index in the array passed to the function
			 SettingIndex= FoundInArray(objSetting.Caption,ArrayofSettings)
			 If SettingIndex<>-1 Then
			 	If objSetting.Caption<>"NetworkAddress" Then
			 		If objSetting.Caption<>"TaggingMode" or bHasVlan=FALSE Then
						objSetting.CurrentValue=ArrayofSettings(SettingIndex+1)
						objSetting.Put_ wbemFlagUseAmendedQualifiers, SValueSet	
					End if
				End If				
			 End If	
		Next		 	
	Next				
End Sub
'*****************************************************************************************
'Function FoundInArray(strString,strArray)
'Returns the strArray index where strString is found, returns -1 if not found
'*****************************************************************************************
Function FoundInArray(strString,strArray)
dim Index
	FoundInArray=-1
	For Index=0 to Ubound(strArray)
		If StrComp(strArray(index),strString,1)=0 Then
			FoundInArray=Index
			Exit For	
		End if	
	Next
End Function
'*****************************************************************************************
'Sub ReadConfigFile(objFile)
'Parse the configuration file and stores the data in the following arrays:
'   I Adapter index, J Vlan index, K Setting index
'   AdapterName(I)
'   AdapterCapabilities(I)
'	AdapterDescription(I)
'	Adapters(I,0,K)=Adapter setting #K name  (K=3 to Maxsettings)
'	Adapters(I,0,K+1)=Adapter setting #K value 
'	Adapters(I,J,0)=Vlan #J Name
'	Adapters(I,J,1)=Vlan #J ID
'	Adapters(I,J,K)=Vlan #J Setting #K Name (K=2 to MaxSettings)
'	Adapters(I,J,K+1)=Vlan J Setting #K Value

'	TeamName(TeamIndex)
'	TeamAdapterCount(TeamIndex)
'	TeamType(TeamIndex)
'	ManageabilityTeam(TeamIndex)
'	TeamDescription(TeamIndex) 
'	Teams(I,0,K)=Team Member #K Adapter Name
'	Teams(I,0,K+1)=Team Member #K Adapter Function (K=5 to Adapter count)
'	Teams(I,1,K)=Team setting #K Name
'	Teams(I,1,K+1)=Team setting #K Value
'	Teams(I,J,0)=Vlan #J Name
'	Teams(I,J,1)=Vlan #J ID	
'*****************************************************************************************
Sub ReadConfigFile(objFile)
dim AdapterIndex
dim strLine
dim SettingIndex,i,j,k	
dim VlanIndex
dim TeamIndex
dim MemberIndex
dim NumberofSettings
	
	Redim Adapters(MaxAdapters,MaxVlans,MaxSettings)
	Redim Teams(MaxTeams,MaxVlans,MaxSettings)
	AdapterIndex=0
	TeamIndex=0
	VlanIndex=0
	SettingIndex=0
	On Error Resume Next
	Do until objFile.AtEndOfStream
		strLine=objFile.ReadLine()
		While Instr(1,strLine,"***",1)<>0
	 	 	strLine=objFile.ReadLine()
		Wend 	
		Do While Instr(1,strLine,"Adapter Name",1)<>0 
			'process adapter data
			AdapterIndex=AdapterIndex+1
			Redim Preserve AdapterName(AdapterIndex)
			Redim Preserve AdapterCapabilities(AdapterIndex)
			Redim Preserve AdapterDescription(AdapterIndex)
			
			AdapterName(AdapterIndex)=ReadValue("Adapter name=",strLine)
			strLine=objFile.ReadLine()
			SettingIndex=0
			While Instr(1,strLine,"Setting name",1)<>0
				Adapters(AdapterIndex,0,SettingIndex)=ReadValue("Setting Name=",strLine)
				strLine=objFile.ReadLine()
				Adapters(AdapterIndex,0,SettingIndex+1)=ReadValue("Setting Value=",strLine)
				strLine=objFile.ReadLine()
				SettingIndex=SettingIndex+2
			Wend
			VlanIndex=1
			While Instr(1,strLine,"Vlan Name",1)<>0	
				Adapters(AdapterIndex,VlanIndex,0)=ReadValue("Vlan Name=",strLine)	
				strLine=objFile.ReadLine()
				Adapters(AdapterIndex,VlanIndex,1)=ReadValue("Vlan ID=",strLine)	
				strLine=objFile.ReadLine()
				SettingIndex=0
				While Instr(1,strLine,"Setting name",1)<>0
					Adapters(AdapterIndex,VlanIndex,SettingIndex+2)=ReadValue("Setting Name=",strLine)
					strLine=objFile.ReadLine()
					Adapters(AdapterIndex,VlanIndex,SettingIndex+3)=ReadValue("Setting Value=",strLine)
					strLine=objFile.ReadLine()
					SettingIndex=SettingIndex+2		
				Wend
				VlanIndex=VlanIndex+1
			Wend
			NumberOfAdapters=AdapterIndex
			if err then 
				err.clear
				exit Do
			end if
		Loop	
		Do While Instr(1,strLine,"Team Name",1)<>0 	
		'process team data"
			TeamIndex=TeamIndex+1
			Redim Preserve TeamName(TeamIndex)
			Redim Preserve TeamAdapterCount(TeamIndex)
			Redim Preserve TeamType(TeamIndex)
			Redim Preserve ManageabilityTeam(TeamIndex)
			Redim Preserve TeamDescription(TeamIndex) 

			TeamName(TeamIndex)=ReadValue("Team name=",strLine)
			strLine=objFile.ReadLine()

			TeamType(TeamIndex)=ReadValue("Team Type=",strLine)
			strLine=objFile.ReadLine()

			ManageabilityTeam(TeamIndex)=ReadValue("Manageability Team=",strLine)
			strLine=objFile.ReadLine()

			MemberIndex=0
			Do While Instr(1,strLine,"Member Adapter",1)<>0
				Teams(TeamIndex,0,MemberIndex)=ReadValue("Member Adapter=",strLine)
				strLine=objFile.ReadLine()

				if Instr(1,strLine,"Priority",1)<>0 then
					Teams(TeamIndex,0,MemberIndex+1)=ReadValue("Priority Setting=",strLine)
					strLine=objFile.ReadLine()
				else
					Teams(TeamIndex,0,MemberIndex+1)=0	'set default priority setting to 0
				End If	
				MemberIndex=MemberIndex+2	
				if err then 
					err.clear
					exit Do
				end if	
			Loop
			TeamAdapterCount(TeamIndex)=MemberIndex/2
			SettingIndex=0
			While Instr(1,strLine,"Setting Name",1)<>0
				Teams(TeamIndex,1,SettingIndex)=ReadValue("setting Name=",strLine)
				strLine=objFile.ReadLine()
				Teams(TeamIndex,1,SettingIndex+1)=ReadValue("setting Value=",strLine)
				strLine=objFile.ReadLine()
				SettingIndex=SettingIndex+2
			Wend
			VlanIndex=0
			While Instr(1,strLine,"Vlan Name",1)<>0
				Teams(TeamIndex,VlanIndex+2,0)=ReadValue("Vlan Name=",strLine)	
				strLine=objFile.ReadLine()	
				Teams(TeamIndex,VlanIndex+2,1)=ReadValue("Vlan ID=",strLine)	
				strLine=objFile.ReadLine() 
				VlanIndex=VlanIndex+1
			Wend
			NumberOfTeams=TeamIndex		
		if err then
			err.clear
			exit Do	
		end if	
		Loop
	Loop	
	objFile.close
	if bdebug=TRUE then
		For i=1 to NumberofAdapters
			For j=0 to 2
				For k=0 to 2
					wscript.echo "adapters("&i&","&j&","&k&")="&adapters(i,j,k)
				Next
			Next
		Next
	    For i=1 to NumberofTeams
			For j=0 to 3
				For k=0 to 10
					wscript.echo "Teams("&i&","&j&","&k&")="&teams(i,j,k)
				Next
			Next
		Next
	end if				
End Sub
'*****************************************************************************************
'Function ReadValue(strStringpart,strString)
'returns the value string (right of strStringpart) from the string strString 
'*****************************************************************************************
Function ReadValue(strStringpart,strString)
	ReadValue=Trim(Mid(strString,len(strStringPart)+1))	
End Function
'*****************************************************************************************
'Sub ValidateAdapters()
'For each adapter in the configuration file,check if the adapter is in the system, is a 
'phantom adapter or is a server adapter. Then output the list of found adapters
'*****************************************************************************************
Sub ValidateAdapters()
	dim colAdapters
	dim objAdapter
	dim AdapterIndex
	dim colPCIDevice
	dim strQuery
	dim strAdapterName
	Redim strValidAdapterPath(NumberOfAdapters)
	Redim bFoundAdapterInSystem(NumberOfAdapters)
	Redim bIsTeamMember(NumberOfAdapters)
	Redim bIsServerAdapter(NumberOfAdapters)
	'Initialize arrays
	For AdapterIndex=1 to NumberOfAdapters
		bFoundAdapterInSystem(AdapterIndex)=FALSE
		bIsTeamMember(AdapterIndex)=FALSE
		bIsServerAdapter(AdapterIndex)=FALSE
		strValidAdapterPath(AdapterIndex)=""
	Next
	'Check if adapter in config file is present in the system or is a phantom adapter	
	Set colAdapters=wbemServices.InstancesOf("IANet_EthernetAdapter where IsATeam=FALSE")
	For each objAdapter in colAdapters
		strQuery="Associators of {"&objAdapter.Path_.Path&"} where ResultClass=IANet_EthernetPCIDevice"
		Set colPCIDevice=wbemServices.ExecQuery(strQuery)
		If colPCIDevice.count<>0 Then
			For AdapterIndex=1 to NumberOfAdapters 
				If objAdapter.ExpressTeam=1 or objAdapter.ExpressTeam=2 Then 
					strAdapterName = objAdapter.OriginalDisplayName
				Else
					strAdapterName = objAdapter.Caption
				End If		
				If StrComp(AdapterName(AdapterIndex),strAdapterName,1)=0 and bFoundAdapterInSystem(AdapterIndex)=FALSE Then
					bFoundAdapterInSystem(AdapterIndex)=TRUE
					strValidAdapterPath(AdapterIndex)=objAdapter.Path_.Path
					'check if the adapter is a server adapter
					If foundInArray("46",objAdapter.Capabilities)<>-1 Then
					  bIsServerAdapter(AdapterIndex)=TRUE
					End if  
					Exit For	
				End if	
			Next
		Else 
			Wscript.echo ObjAdapter.Caption &" is a Phantom Adapter (Adapter is not installed in the system)"
		End if		
	Next
	
	Wscript.Echo "The following adapters are found in the system:" 	
	For adapterindex=1 to NumberOfAdapters
		If bFoundAdapterInSystem(AdapterIndex)=TRUE Then
			Wscript.echo "->"&AdapterName(AdapterIndex) 
		End if
	Next
	wscript.echo ""
End Sub
'*****************************************************************************************	
'Sub SaveSettings(ByVal strFilename)
'Save Adapter's, team's and VLAN's info and settings info.(if the user selected it) to a text file. 
'*****************************************************************************************
Sub SaveSettings(byVal strFileName)	
	dim colNetDevices
	dim objNetDevice
	dim objFile
	dim DeviceIndex
	dim colTeams
	dim objTeam
	
	'Create a configuration file 
	Set objFile=CreateConfigFile(strFileName)	
	WriteUsage(objFile)	
		
	'Get all instances from IANet_EthernetAdapter (Adapters and Teams)
	Set wbemServices = GetObject("winmgmts://./root/IntelNcs")
	Set colNetDevices = wbemServices.InstancesOf("IANet_EthernetAdapter")
	'Save Adapters and Team Settings Set 
	Wscript.echo "Saving Adapters, Teams and Vlans configurations to "&strFileName
	DeviceIndex=0	
	For each objNetDevice in colNetDevices
		DeviceIndex=DeviceIndex + 1
		objFile.WriteBlankLines(1)	
		if objNetDevice.IsATeam=TRUE Then
			'Save Team information (name,type and member adapters)
			SaveTeamInfo objFile, objNetDevice
		Else
			'Save Adapter name
			'If Express Team then save Adapter's Original Display name
			if objNetDevice.ExpressTeam=1 Then
				objFile.WriteLine "Adapter Name=" & objNetDevice.OriginalDisplayName
				'@@objFile.WriteLine "ExpressTeam Name=" & objNetDevice.Caption
			Else
				objFile.WriteLine "Adapter Name=" & objNetDevice.Caption
			End If
		End If
			'Save settings if user chose this option
			'if bAllSettings=TRUE then
			 SaveAdvancedSettings objFile, objNetDevice
			'end if
			'Save vlan information (vlan name and ID)
			 SaveVlanInfo objFile, objNetDevice
	Next
	objFile.WriteBlankLines(1)
	objFile.close
	Wscript.Echo "Saving done!"		
End Sub
'*****************************************************************************
'Private sub WriteUsage(objF)
'Output Date/Time and usage to configuration text file
'*****************************************************************************
Private sub WriteUsage(objF)
    objF.WriteLine "*** TEAMING and VLAN Configuration Data "
	objF.WriteLine "*** Date " & Date & " Time " & Time() & "  "
	objF.WriteLine "***"
	objF.WriteLine "*** Usage: This text file can be modified using the following layout and labels:"
	objF.WriteLine "*** (only fields marked with a * are mandatory)"
	objF.WriteLine "***"
	objF.WriteLine "***    Adapter Name=*"		
	objF.WriteLine "***    Setting Name="
	objF.WriteLine "***    Setting Value="
	objF.WriteLine "***    Vlan Name="
	objF.WriteLine "***    Vlan ID="
	objF.WriteLine "***"
	objF.WriteLine "***    Team Name=*"
	objF.WriteLine "***    Team Type=* 				(0=AFT,1=ALB,2=FEC,3=GEC,4=IEEE 802.3ad,5=SFT)"
	objF.WriteLine "***    Manageability Team=	 	(TRUE if Manageability team)"
	objF.WriteLine "***    Member Adapter=*		(must be one of the Adapter Names)"		
	objF.WriteLine "***    Priority Setting= 	(0=Unknown,1=Primary adapter,2=Secondary adapter)"
	objF.WriteLine "***    Setting Name="
	objF.WriteLine "***    Setting Value="
	objF.WriteLine "***    Vlan name="
	objF.WriteLine "***    Vlan ID="
	objF.WriteLine "***"
	objF.WriteLine "*** Each adapter or team set should be separated with a blank line."
	objF.WriteLine "*** Setting name/value and vlan name/id pairs can be added in the order shown above."
	objF.WriteLine "*** Adapter names should match exactly the syntax displayed in Intel(R) Proset"
	objF.WriteLine "*** Labels and values are not case-sensitive."
	objF.WriteLine ""
End sub
'*****************************************************************************
'Private Function CreateConfigFile(byVal strFileName)
'Returns textstream for writing to strFileName
'*****************************************************************************
Private Function CreateConfigFile(byVal strFileName)
	dim fso
	Set fso = CreateObject("Scripting.FileSystemObject")
	Set CreateConfigFile=fso.CreateTextFile(strFileName,True)
End Function
'*****************************************************************************
'Private sub SaveAdvancedSettings(objFile,objAdapter)
'writes objAdapter settings name and value to objFile 		
'*****************************************************************************
Private Sub SaveAdvancedSettings(objFile,objAdapter)
	dim strQuery
	dim IANET_config
	dim IANet_Obj
	dim index

		strQuery = "ASSOCIATORS OF {" & objAdapter.Path_.Path & "} WHERE ResultClass = IANet_Configuration"
		Set IANet_config = wbemServices.ExecQuery(strQuery)
		For Each IANet_Obj In IANet_config
			strQuery = "ASSOCIATORS OF {" & IANet_Obj.Path_.Path & "} WHERE AssocClass = IANet_SettingContext"
			Set IANet_config = wbemServices.ExecQuery(strQuery)
		Exit For
		Next
		For Each IANet_Obj In IANet_config
			If IANet_Obj.caption<>"NetworkAddress" then
				If bAllSettings=TRUE or IANet_Obj.CurrentValue<>IANet_Obj.DefaultValue Then
					objFile.WriteLine "setting Name=" & IANet_Obj.Caption                             
					objFile.WriteLine "setting Value=" & IANet_Obj.CurrentValue
				End If
			End If		
		Next	
End Sub
'*****************************************************************************
'Private Sub SaveVlanInfo(objFile,objAdapter)
'writes vlans name and ID associated with objAdapter to objFile
'writes vlan settings if user selected "SaveAll" option
'*****************************************************************************
Private Sub SaveVlanInfo(objFile,objAdapter)
	dim strQuery
	dim IANet_802dot1VLANService
	dim IANet_802dot1VLANObj
	dim IANet_VLANSet
	dim IANet_VLANObj

		strQuery = "ASSOCIATORS OF {" & objAdapter.Path_.Path & "} WHERE ResultClass = IANet_802dot1QVLANService"
		Set IANet_802dot1VLANService = wbemServices.ExecQuery(strQuery)
		If IANet_802dot1VLANService.Count <> 0 Then 
			For Each IANet_802dot1VLANObj In IANet_802dot1VLANService	      
				strQuery = "ASSOCIATORS OF {" & IANet_802dot1VLANObj.Path_.Path & "} WHERE ResultClass = IANet_VLAN"
				Set IANet_VLANSet = wbemServices.ExecQuery(strQuery)
				If IANet_VLANSet.Count > 0 Then
					For Each IANet_VLANObj In IANet_VLANSet
						objFile.WriteLine "VLAN Name=" & IANet_VLANObj.VLANName
						objFile.WriteLine "VLAN Id=" & IANet_VLANObj.VLANNumber
						If bAllSettings=TRUE then
						 SaveAdvancedSettings objFile,IANet_VLANObj
						End if 
					Next
				End If
			Next
		End If
End Sub
'*****************************************************************************
'Private Sub SaveTeamInfo(objFile,objNetDevice)
'writes team name,type and member adapters (with priority settings) to objFile
'*****************************************************************************
Private Sub SaveTeamInfo(objFile,objNetDevice)
 	dim colTeamedAdapters
 	dim TeamedAdapter
    dim	colTeamedMemberAdapter
    dim TeamedMemberAdapter
    dim strQuery
    dim colTeam
    dim objTeam
    
    'Access the same Team from IANet_TeamOfAdapters 
    strQuery="ASSOCIATORS OF {" & objNetDevice.Path_.Path & "} where ResultRole=SameElement"
	Set colTeam = wbemServices.ExecQuery(strQuery)
    For Each objTeam In colTeam 'only one team in this collection
	    objFile.WriteLine "Team Name=" & objTeam.Caption		
		'Get Team Mode and Adapter count
		objFile.WriteLine "Team Type=" & objTeam.TeamingMode
		'if objTeam.ManageabilityEnabled = TRUE
		objFile.WriteLine "Manageability Team=" & objTeam.ManageabilityEnabled
		'Access Members of this Team
		strQuery="ASSOCIATORS OF {" & objTeam.Path_.Path & "} where ResultRole=PartComponent"
		Set colTeamedAdapters = wbemServices.ExecQuery(strQuery) 		
		For Each TeamedAdapter In colTeamedAdapters
			objFile.WriteLine "Member Adapter="&TeamedAdapter.Caption		
			'Get Priority settings for this member adapter
			strQuery="REFERENCES OF {" & TeamedAdapter.Path_.Path & "} where ResultClass=IANet_TeamedMemberAdapter"
			Set colTeamedMemberAdapter= wbemServices.ExecQuery(strQuery)
			For Each TeamedMemberAdapter In colTeamedMemberAdapter
				objFile.WriteLine "Priority Setting="&TeamedMemberAdapter.AdapterFunction
			Next	
		Next	
	Next
End Sub	
'*****************************************************************************
'Private Function UpdateTeam()	
'This function is for debugging only. Not used in this script
'update team name or priority settings for any existing team	
'*****************************************************************************
Private Function UpdateTeam()
 	dim colTeamedAdapters
 	dim TeamedAdapter
    dim	colTeamedMemberAdapter
    dim TeamedMemberAdapter
    dim strQuery
    dim colTeam
    dim objTeam
    
    strQuery="select * from IANet_TeamOfAdapters"
	Set colTeam = wbemServices.ExecQuery(strQuery)	
    For Each objTeam In colTeam 
		objTeam.Caption="myteam"
		objteam.Put_ &h20001,SvalueSet
		strQuery="ASSOCIATORS OF {" & objTeam.Path_.Path & "} where ResultRole=PartComponent"
		Set colTeamedAdapters = wbemServices.ExecQuery(strQuery) 		
		For Each TeamedAdapter In colTeamedAdapters
			strQuery="REFERENCES OF {" & TeamedAdapter.Path_.Path & "} where ResultClass=IANet_TeamedMemberAdapter"
			Set colTeamedMemberAdapter= wbemServices.ExecQuery(strQuery)
			For Each TeamedMemberAdapter In colTeamedMemberAdapter
			    wscript.echo "Priority Setting="&TeamedMemberAdapter.AdapterFunction
			    TeamedMemberAdapter.AdapterFunction=1
			    TeamedMemberAdapter.put_ &h20001, SvalueSet
				wscript.echo "Priority Setting="&TeamedMemberAdapter.AdapterFunction	
			Next
		exit for		
		Next	
	Next
	
End Function			


