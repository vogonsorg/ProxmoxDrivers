[InstallShield Silent]
Version=v5.00.000
File=Response File
[Application]
Name=Intel DMI 2.0 Service Provider (SP) SDK Version 1.1
Version=1.1
Company=Intel
[DlgOrder]
Dlg0=Welcome-0
Count=6
Dlg1=SdLicense-0
Dlg2=AskDestPath-0
Dlg3=SdComponentDialog2-0
Dlg4=SdSelectFolder-0
Dlg5=SdFinishReboot-0
[Welcome-0]
Result=1
[SdLicense-0]
Result=1
[AskDestPath-0]
szPath=C:\DMI\WIN32
Result=1
[SdComponentDialog2-0]
DMI 2.0 Service Provider-type=string
DMI 2.0 Service Provider-count=3
DMI 2.0 Service Provider-0=DMI 2.0 Service Provider\Local Transport
DMI 2.0 Service Provider-1=DMI 2.0 Service Provider\TCP Transport
DMI 2.0 Service Provider-2=DMI 2.0 Service Provider\SPX Transport
DMI 2.0 DCE Client-type=string
DMI 2.0 DCE Client-count=3
DMI 2.0 DCE Client-0=DMI 2.0 DCE Client\Local Transport
DMI 2.0 DCE Client-1=DMI 2.0 DCE Client\TCP Transport
DMI 2.0 DCE Client-2=DMI 2.0 DCE Client\SPX Transport
Component-type=string
Component-count=3
Component-0=DMI 2.0 Service Provider
Component-1=DMI 2.0 DCE Client
Component-2=System
Result=1
[SdSelectFolder-0]
szFolder=Intel DMI 2.0 SP SDK v1.10
Result=12
[SdFinishReboot-0]
Result=1
BootOption=3
