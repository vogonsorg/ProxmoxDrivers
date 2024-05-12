Manual installation for Windows NT4
===================================
      (for version prior 23b)

Note:

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

Installation steps:

1. make a copy of your default Hardware Profile and set it as Default
   a) My Computer->Properties->Hardware Profiles
   b) select the Prrolile, marked as (Current)
      usually it's name is "Original Configuration"
   c) click on Copy button & name your copy (for ex. "UniATA")
   d) place UniATA profile at the top of list
      by clicking Up Arrow button
   e) click on Apply button
2. copy idedma.sys to your WINNT/System32/drivers directory
3. register driver in system
   a) make "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\Root"
      writeable for Administrator using RegEdt32
      (Security->Permissions)
   b) import idedma.reg into registry (just press Enter on this file)
   c) restore original parmissions on
      "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\Root"
4. reboot your computer

5. disable "Universal ATA Driver" driver in Original Configuration HW Profile
   a) Control Panel->Devices
   b) select driver from list (idedma)
   c) click on HW Profiles button
   d) disable driver in appropriate HW Profile
      by selecting Profile Name from list and clicking
      Enable button
   e) click on OK button

7. disable "Atapi" driver in UniATA HW Profile

   IMPORTANT !!!

   If you have installed IDE/ATA/BusMaster drivers from
   Motherboard's CD, the initial state of "Atapi" driver
   would be "Disabled" !!!
   In this case you should disable that driver instead
   of "Atapi" !!!

8. set startup mode of "Universal ATA Driver" to Boot
   by clicking Startup button

You should see the following:

--- Universal ATA Driver ---
Startup: Boot
HW Profiles:
  UniATA                 - Enabled
  Original Configuration - Disabled

       --- Atapi ---
Startup: Boot
HW Profiles:
  UniATA                 - Disabled
  Original Configuration - Enabled


8. reboot your computer
