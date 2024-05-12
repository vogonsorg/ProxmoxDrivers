        Realtek Semiconductor Corp. AC'97 Sound System Software     ver:A3.62
                        Installation and Setup


Driver & Application Installation/Removal Procedure For Realtek AC'97 Codec:
=================================================================================

<<< For Win2000/WinME/WinXP (WDM driver)/Win98 Gold(First Edition)/Win98SE >>>

---------------------------------------
Setup Driver/Application at first time:
---------------------------------------

Step 1. Before installing the Realtek AC'97 Drivers & Applications, Press the
        [Cancel] button if Windows detect the PCI Multimedia Audio device. 
          
Step 2. Insert the "Realtek AC'97 Drivers & Applications" CD into the CD-ROM 
        drive and run the setup.exe program to finish the installation. 

Step 3. Click on [Next/OK/Go] to continue the procedure. If the Windows popup 
        "Digital Signature Not Found" message, press [Yes] to continue the 
        installation.
        
Step 4. Finally, select to restart the system and press [Finish] to complete
        the installation.  

        The system will reload the drivers and do some adjustments in the INF
        file if so required.

--------------------------
Update Driver/Application:
--------------------------

Step 1. Follow Step 2,3,4 described in [Setup at first time] above to complete
        the procedure.

--------------------------
Remove Driver/Application:
--------------------------

Step 1. Go to Start\Settings\Control Panel.

Step 2. Select [Add/Remove Programs] icon.

Step 3. Select "Realtek AC'97 Drivers and Applications" and press [Change/Remove]
        button.

Step 4. Click on [Next/OK/Go] to finish the uninstallation.        

Step 5. At the end of the procedure, select to restart the system and press
        [Finish] to complete the uninstallation.


<<< For WinNT 4.0 (NT4 driver) >>>

---------------------------------------
Setup Driver/Application at first time:
---------------------------------------

    Ignore Step 1, and follow the same procedure in Win2000/WinME/WinXP.

--------------------------
Update Driver/Application:
--------------------------

    The same procedure in Win2000/WinME/WinXP.
    
--------------------------
Remove Driver/Application:
--------------------------

    The same procedure in Win2000/WinME/WinXP.

<< Other Informations >>

--------------------
Silent Installation:
--------------------

Run "Setup -s -f2<path\LogFile>"
i.e. setup -s -f2c:\mylog.log 


Note: 1. AVRack only works fine under WinNT 4.0 after installing
         Service Pick 3 or later.
      2. Please update Directx version to DirectX8.0 or above.

---------------------
Version Informations:
---------------------

WDM driver for Win98/WinMe/Win2000/WinXP   : 5.10.0.5650
VXD driver for Win95		           : 4.5.0.3019
VXD Software wavetable driver              : 3.1.0.0
NT4 driver for Windows NT4                 : 4.3.0.3039
NT4 software wavetable driver              : 4.3.0.2002

RtlRack for Win98/Me/2000/XP               : 1.9.0.0
AvRack for Win95/NT4                       : 2003.4.4.1

Realtek Soundman			   : 5.1.0.29
Realtek Sound Effect Manager(CPL)          : 2.2.0.31
Realtek Sound Effect Manager(RtlCpl)       : 1.0.1.32
Realtek Sound Effect Manager for NT4       : 2.3.0.3

Driver/Application Setup Program           : 4.96

--------
History:
--------
A3.62
1. Add some customized settings.
2. Fix SPDIF Copy protect issue in Mediaplayer.
3. Support AC3 SPDIF and 8 channels for Ali1689 chipsets.
4. Reduce POP noise with EAPD for power change.

A3.61 -
1. Add some customized settings.

A3.60 -
1. Add some customized settings.
2. Add workaround code when pause DMA engine for ICH6 / Hance Rapid.
3. Fix bug for "Force 44K SPDIF" feature when disable direct sound acceleration engine.
4. Set Surr-out pin as HP-out pin for ALC655 when disable multi-channels function.

A3.59 -
1. Add some customized settings.
2. Add channel status information of SPDIF output for ATi chipset(SB150/SB200/SB250).

A3.58 -
1. Add some customized settings.
2. Fix some UI issues for Realtek control panel.
3. Fix some issues for ATi chipset(SB150/SB200/SB250).
4. Solve pop noise for noise suppression feature.

A3.57 -
1. Add some customized settings.
2. Fix some issues for the certain page of control panel.

A3.56 -
1. Add some customized settings.
2. Update directsound acceleration engine.
3. Fix the issue which control panel shows the improper item in 
   "Microphone" tab under some situation.

A3.55 -
1. Improve the algorithm of Jack sensing.
2. Add some customized settings.
3. Support ICH6.
4. Improve the algorithm for ALC250 Hardware EQ feature.
5. Fix the issue which AUX volume register will be set the improper value.
6. Improve the algorithm of Noise suppression feature.
7. Fix SPDIF output issue for "WaveCyclic" architecture.

A3.54 -
1. Add some customized settings.
2. Support Microphone Noise Suppression feature.
3. Toggle Vref before change Microphone jack type for AC97 2.3 codecs.
4. Modify Peak filter parameters for ALC655.

A3.53 -
1. Add some customized settings.
2. Add "Remove recording DC offset" feature.
3. Fix Hardware EQ noise issue for ALC250.
4. Support 1 nVidia chipset (CK8S).    
5. Add workaround code for ATI chipset recording issue.
6. Support 8 channels playback feature for nVidia chipset with ALC850.
7. Fix the issue about SPDIF function type feature with ALC850.
8. Modify Peak Filter parameters for ALC655 and ALC850. 
9. Fix side channel noise issue for VIA chipset with ALC850.  
10.Add a new feature: SPDIF out can be sent to ACLink for ATI and nVidia Chipset.
11.Fix SPDIF slot assignment error for ALC850.
12.Support "Smart GPIO Volume Control" & "DC Voltage Volume Control" features for ALC250 and ALC203.
13.Turn on bit 14 of DC97_AUDIO_REG_INTERRUPT_ENABLE while audio playing for ATi chipset.
14.Add flexibility for "Preventing ICH hang up" feature.
15.Improve DirectMusic startup latency when HyperThreading was enabled.
16.Fix Pinball delay problem on Win2000.
17.This vesion does not include ALi 1535 chipset support.

A3.52 -
1. Add some customized settings.
2. Fix SPDIF output frequency issue for nVidia chipset.
3. Disable Hardware EQ first before restore Hardware EQ for ALC250 when resuem.
4. Disable Hardware EQ first before restore Hardware EQ for ALC250 polling function.
5. Turn on UAJ function for ALC850.
6. Set SPDIF control register to proper value when driver initialize.
7. Improve Read/Write codec register algorithm.
8. Reduce resume time.
9. Add "Remove Recording DC offset" feature.
10.Check ALC850 JD5 to decide if support 8-channels feature.
11.Fix SPDIF output slot assignment error for ALC850.

A3.51 -
1. Add ICH2, ICH3 and ATI Chipset IDs.

A3.50 -
1. Support ALC850.
2. Add some customized settings.
3. Use "Wave PCI" architecture for ATI chipset.
4. Improve Jack Sensing algorithm to eliminate noise.
5. Show "Real-Time SPDIF-in Monitor" node for nVidia chipset.
6. Remove ICH2/ICH3/ATi chipsets IDs.
7. Change JD bit definition of Front-out detection function for ALC658 (C version / D version).
8. Set "Direct DAC Mode" to Summation of DAC and analog inputs if H/w EQ is bypassed for ALC250.

A3.49 -
1. Modify some customize settings.
2. Fine tune some registers for ALC655 to avoid noise.
3. Fine tune Surround DAC Volume and Center/LFE DAC volume for ALC655.
4. Set ALC655 Vrefout as 4V for 1 customer.
5. Fix Intel audio device DMA hang up issue for some customers.

A3.48 -
1. Add some customize settings.
2. Turn on "Ignore SPDIF in Invalid Bit" option as default if codec support.
3. Set Pin 47 as EAPD pin and turn off SPDIF in function as default for ALC250&ALC203.
4. Use "WaveCyclic" architecture under Windows 98 Gold version.
5. Modify Realtek control panel that don't detect UAJ automatically 
   while Windows start for some customer's request.
6. Fix the failures on HCT 9.6 (WinME) "KS Position Accuracy" test. 
7. Fix the problems with SPDIF output through DirectSound. 
8. Prevent potential discontinuities in 8-bit streams. 
9. Prevent potential audio system hangs on badly behaved audio drivers. 

A3.47 -
1. Add some customize settings.
2. Turn off SPDIF-In Schmitt Trigger Control for ALC655.
3. Fix the problem that AC3 stream will hang with the older revision of VIA8233 under Win98 SE.
4. Fix the problem that AC3 stream will be abnormal with Direct sound API.
5. Add hand-shaking protocol between audio driver and modem driver for ATI chipset.
6. Disable "Mic2 Select" node in mixer for ALC655/ALC658.
7. Fix the bugcheck D1 in HCT verifier for nVidia chipset.

A3.46 -
1. Add some customize settings.
2. Add Hardware EQ function for ALC250.
3. Support independent SPDIF engine for nVidia CK8 chipset.
4. Modify driver for UAJ function.
5. Modify UAJ thresholds for ALC658.
6. Fix audio driver bug for ATI chipset.
7. Fix audio driver bug about nVidia independent SPDIF engine.
8. Change direct sound acceleration engine.(New engine require DirectX 8.1 under Windows 98 SE).

A3.45 -          
1. Add some customize settings.
2. Reduce resume time for VIA chipset.
3. Modify mixer volume control algorithm for multi-channels codec to prevent
   the value of mixer out of range.
4. Implement ATI dedicate SPDIF DMA engine.
5. Support ALC250 and ALC658.
6. Fix the problem that Jack Sensing will hang in Windows 98SE.
7. Fix ICH5 pause DMA issue.

A3.44 -
1. Support independent SPDIF engine for nVidia MCP2 chipset under Windows 98 SE.
2. Improve the initialize procedure and the DMA access algorithm for VIA chipsets.
3. Add some customize settings.
4. Apply the Channel Order and FIFO Flush procedure for ATI A41 chipset.

A3.43 -
1. Support ALC203 UAJ function.
2. Add some customize settings.
3. Support independent SPDIF engine for VIA 8233 (Only for newer chipset version) under Windows 98 SE.
4. Fix hang up issue when system suspend for Ali 1563 chipset.
5. Fully support Jack sensing function with multiple language.
6. Fix Jack sensing problem with DirectX 6.1.

A3.42 -
1. Support ALC655.
2. Modify driver for some customized settings.
3. Add SPDIF function for nVidia chipsets.
4. Zero recording data when recording gain is muted.
5. Support independent SPDIF engine for VIA 8233 (Only for newer chipset version).

A3.41 -
1. Modify driver for some customized settings.
2. Support ATI SB200 south bridge.
3. Support Intel ICH5 south bridge.

A3.40 -
1. The setting of switching Center/LFE is saved before system is shut down, restored after system boot up.
2. Fix click noise generated by playing short time wave.
3. Fix some problem about AC3 stream for VIA chipset.
4. Add some customize settings.

A3.38 -
1. Fix some problem for Ali 1563 chipset.
2. Set 1 timer to check SPDIF in status for ALC650 ver. F
3. Save playback volume value to registry key when the mixer is adjusted.
4. Combine Cyclic WDM driver and PCI WDM driver.

A3.37 -
1. Update DirectSound 3D Positional Audio Engine to fix some noisy problem for
   some DirectSound3D game (like Unreal Tournament 2003).
2. A3D compatible
3. Correct the gain settings of master volume for ALC650 ver.F

A3.36 -
1. Restore AC97REG_EXT_AUDIO_CTRL value first when resuming from suspend.
   Otherwise, Sample rate can't be restored because VRA was not enabled.
2. Support 6-bits capability for Master Volume control if hardware support it.
3. Also set GPIO for Jack Sharing with ALC650 ver.E excecpt some special models.
4. Add 1 customized settings "Disable3DDepthLine" to disable 3D Depth mixer Line.
    
A3.35 -
1.  change company name from "Avance" to "Realtek".
2.  add some new ID of motherboard
3.  change some default settings for specific models

A3.32 -
1.  compensate the gain for 3D sound when 2 speaker mode was selected.
2.  support memory I/O for ICH4/ICH5 chipset
3.  support SPDIF AC-3 playback using DirectSound API for ICH4/SiS chipset
4.  correct DataRange declaration of S/PDIF pin to avoid blue screen on Win2000
    with DirectX 8.1 installed.

A3.30 -
1.  turn on/off EAPD by GPIO for specific model
2.  correct EAX initial setting.
3.  support I3DL2 interface
4.  fix wake on ring problem
5.  support DirectSound 3D positional audio by using HRTF algorithm
6.  Add "Loudness" control for ALC202/ALC202A.

A3.29 -
1.  Add "S/PDIF IN/OUT Pass-Through" mode for specific model
2.  fix S/PDIF-In Realtime monitor noise issue
3.  fully support EAX compatible sound effect
4.  fix S1 suspend/resume failure problem for some specific model using SiS audio controller
5.  only disable "3D depth" line for specific model
6.  duplicate analog input source according to output channel mode
7.  support DirectSound hardware acceleration features by default
8.  fix WinDVD problem when enabling video acceleration

A3.26 -
1.  Improve compatibility with Agere software modem
2.  Improve recording quality when IDE was in PIO mode.
3.  Remove 3D Depth mixer line for some models

A3.23 -
1.  Add "Loudness" mixer control for ALC650 front channel.
2.  Add "SPDIF in pass through to SPDIF output" option for specific model.
3.  Remove 3D depth mixer line.
4.  Improve compatibility with WinDVD 4.0 playing AC3 bit stream through DirectSound API.
5.  Improve recording quality for some specific models.

A3.22 -
1.  Support S/PDIF-In function for ALC650 ver.E
    
A3.21 -
1.  Fix Front Mic problem.
2.  Turn off "Analog input bypass to surround" when enter D1 mode.
3.  Change back the default volume of Master to the middle position.
4.  Add "EnableDCVoltageControl" customized option for ALC202/ALC202A.
5.  Support customized DirectSound 2D/3D Acceleration (bypass kmixer).
    Add "EnableDS3DLibrary" customized option to enble it.
    It is turned off by default.
6.  Add "PreventRegisterReset" customized option for VIA8233.
7.  Only ALC201 series and ALC650 series can use "Enable 3.3V support" customized option.
    For ALC202/A, it is work autometically.
8.  Reset DMA when change state to Pause for ICH4 to fix HCT DiectSound failure in WinMe.

A3.13 -
1. To avoid mapping lost on Win98SE by raising IRQ level and adding TagCount before get mappings.
2. Disable "Phone Line" for some specific models.
3. Improve S/W SRC (if needed) quality to meet PC99 requirement.
4. Mute SPDIF while master volume was muted.
5. Improve EAX 1.0 compatible issue.

A2.94 -
1. Modify mixer control for multichannel output - master/front/surround/center/subwoofer line.
   a.The master volume/mute control will adjust all of front/surround/center/subwoofer
     volume/mute now to avoid confusion.
   b.The independent front/surround/center/subwoofer line offer volume control to balance the
     multichannel output.
2. Support "Front Mic" instead of Mic2.
3. Support Center and LFE output swap function.
4. Turn off analog input pass to surround function when suspend.
5. To avoid mapping lost on Win98SE (it can also fixed by QFE).
6. Improve S/W SRC (if needed) quality to meet PC99 requirement.
7. Mute SPDIF while master volume was muted.

A2.84 -
1.  Support ALC650.

A2.82 -
1. Support ICH4
2. Implement workaround for Intel 440MX audio controller
3. Set analog CD Maximum volume to 12dB.
   
A2.81 -
A2.80 -
1. Remove "SPDIF SRC" Node if turn on "Enable 48K SPDIF" option.
2. Turn on "Saving LED power" feature for G version
3. Save/Restore AC97 extended registers when Suspend/Resume
4. Modify Servie() function for set SPDIF Invalid bit.
5. Modify data 0 insertion method for SPDIF.
6. Fix C3/C4 issue.

A2.73 -
1.  Support ALC202A.

A2.71 -
A2.70 -
1.set CD Maximum volume to +12dB.

A2.62 -
A2.61 -
A2.60 -
1.  Fix 48KHz if SPDIF SRC was enabled.
2.  Fix NT4 driver for IRQ sharing on VIA8233A
   
A2.58 -
1.  Support ALC101.

A2.56 -
A2.55 -
1.  update VXD driver for VIA8233A.

A2.53 -
A2.52 -
1.  Support VIA8233A audio controller.
2.  Eliminate the PCM noise while playing AC-3 stream through SPDIF-out.
3.  Power down EAPD when master volume mute.
4.  Fix HCT full duplex unstable problem for VIA8233 audio controller.
5.  The driver now support only VID/DID/SVID/SSID entry for WHQL requirement

A2.51 -
A2.50 -
1.  Fix HCT ACPI stress device I/O test for VIA8233.
2.  Improve compatibility with software modem for power management.

A2.48 -
1.  The driver now support the VID/DID entry

A2.46 -
1.  Add customized options.
2.  Mute volume when volume slider was adjusted to the bottom.
   
A2.45 -
1.  Support ALC201A.
2.  The driver only support the VID/DID/SVID/SID entry to meet the
    INF requirement for PCI devices for WHQL logo.

A2.43 -
1.  Add SPDIF Mute control and SPDIF SRC On/Off control.
2.  Modify 3D depth control behavior.
    When the slider was adjusted to the bottom,
    the 3D depth will be turned off.
3.  Sound Effect Control Panel now installed by setup program.
    It will not be installed with INF file.
4.  AvRack support CD track auto-load function.

A2.42 -
1.  Add Mic2 select control
2.  Improve MR card compatibility
3.  Change volume default settings

A2.40 -
1.  Enable ALC201 3.3V function (INF optional)
2.  Auto Power down DAC/ADC (INF optional)
3.  Avoid scandisk problem on some machines
4.  Fix HCT system test for VIA 686 (ACPI / Stress Device I/O)
5.  Change version number to 5.10.00.xxxx for WinXP versioning requirement
6.  Save/Restore recording mux setting
7.  Improve compatibility with PCTel MR card
8.  Fix hang problem while burn-in PowerDVD on some machines.
9.  Fix IBM ViaVoice Mixer problem.
10. Add MIC 20dB Boost control on recording MIC source line
11. Add Subsystem IDs


