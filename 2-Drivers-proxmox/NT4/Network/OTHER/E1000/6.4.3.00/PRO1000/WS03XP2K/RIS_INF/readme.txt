Setting up Intel PRO/1000 Drivers for RIS Installation
======================================================

To set up network drivers for RIS installation, you need to copy files to two locations (from the root of the RIS image, which we will refer to as [IMAGE_ROOT]).


1. Copy all the files from the PRO1000\WIN2K (Windows 2000) or PRO1000\WS03XP32 (Windows XP & Server 2003) directory to the [IMAGE_ROOT]\$oem$\$1\Drivers\NIC directory.
This directory is specified by a line in the .SIF file that is located in the [IMAGE_ROOT]\I386\Templates directory.

2. Copy all .SYS files from the directory mentioned above to the [IMAGE_ROOT]\i386 directory.

3. Extract the zipped INF file located in the PRO1000\WIN2K\RIS_INF (Windows 2000) or PRO1000\WS03XP32\RIS_INF (Windows XP & Server 2003) directory and copy that INF to the [IMAGE_ROOT]\i386 directory.

Do not copy the INF files at the root of the PRO1000\WIN2K or PRO1000\WS03 directories to this location.

4. Once these steps are complete, restart the Boot Information Negotiation Layer service (Windows 2000) or the Remote Installation Service (XP & Windows Server 2003).

5. Follow the rest of the Microsoft instructions for adding a new network driver to the RIS installation.
