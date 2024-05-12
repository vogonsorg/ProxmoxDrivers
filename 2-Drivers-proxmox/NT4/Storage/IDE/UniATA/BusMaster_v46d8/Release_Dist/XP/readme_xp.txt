Installation for Windows XP
=============================
(for version 30 and higher)

Notes:

  THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
  IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
  OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
  NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

  IMPORTANT !!!

  Only controller(s) described in installation .INF file will be visible
  through standard Device Manager.
  ALL other IDE controllers (see also RAID notes below) may become invisible,
  or listed as unknown devices, or system will report resource conflicts,
  but WILL WORK. UniATA setup also disables PciIde port driver to be able
  to operate with onboard (Native Mode) controllers. This makes IDE Primary
  and Secondary channels to disappear from Device Manager.

  In order to install UniATA for some newer controller, you can add
  entries in device list in uata_xp.inf (for RAID) or uata_xph.inf (for IDE)
  with help of rebuild_inf.bat.
  Just run this batch file to rebuild .INF file.

  You can also modify .INF-file manually:
  Add line before ';DEVLIST' and type there something like this:
    %PCI\VEN_$VV$&DEV_$DD$.DeviceDesc%=uniata_Inst, PCI\VEN_$VV$&DEV_$DD$
  where $VV$ is 4-digit hexedecimal VendorID of controller and
  $DD$ is 4-digit hexedecimal DeviceID of controller.
  Many BIOS'es shows this information at boot-up time, but is you have
  some other BIOS, it is possible to use some PCI enumeration utility
  (for ex. from http://alter.org.ua/soft/win/ntpcidump/index.php).
  Then do similar thing before ';DEVLISTNAME' line:
    PCI\VEN_$DD$&DEV_$VV$.DeviceDesc="Your new ATA controller"
  PS. this process will be automated in future.

RAID Notes:
  
  Current version of UniATA doesn't support RAID arrays. But it can
  manipulate with ATA RAID controllers as with additional ATA
  controllers. This option is disabled by default for Promise and HighPoint
  controllers and can be enabled via registry settings.
  See 'SkipRaids' value in uniata_w2k.reg

  If your ATA controller reports itself as RAID and is not included
  to list of supported devices, UniATA will not recognize it even
  after .INF file modification.


Installation steps:

1.  unpack archive (for ex. to C:\temp\uniata)
2.  My Computer -> Properties -> Hardware -> Device Manager
3.  select device, chose it's
       Properties -> Driver

    Note:
    IDE controllers may be listed no only in 'IDE controllers'
    section, but in 'SCSI and RAID controllers' or 'Other devices'.

4.  Update Driver -> Next
5.  ( ) ....
    (*) Install from a list or specific location (Advanced)
6.  Next
7.  ( ) ....
    (*) Don't search. I will choose the driver to install
8.  Next
9.  Have Disk
10.  enter path to .INF file for new driver
    If this is usual onboard IDE controller, use
        C:\temp\uniata\Release_Dist\uata_xph.inf
    If this is IDE RAID controller or additional PCI IDE controller, use
        C:\temp\uniata\Release_Dist\uata_xp.inf
11. OK

12. chose in the list of available drivers the following line:

      Standard Dual Channel PCI BusMaster IDE Controller
         or
      Your IDE Controller Name

13. say 'Continue Anyway' for the question about missing digital signature.
    (YES, we want to continue the installation)
   
14. REBOOT your computer

