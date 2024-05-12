Installation for Windows NT4
============================
(for version 26e and higher)

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

1.  unpack archive

2.  Install driver using INF-file:
    a) Control Panel->SCSI Adapters
    b) select Drivers property sheet
    c) click on Add button
    d) click on Have Disk button
    e) enter path to UATA_NT4.INF from UniATA distribution
       and click on OK button
    f) select "Universal ATA Driver"
       from list and click on OK button
    g) enter path to UniATA.sys from UniATA distribution
       and click on OK button

    IMPORTANT !!!

    If you have installed IDE/ATA/BusMaster drivers from
    Motherboard's CD, you may need to uninstall them after
    UniATA installation.

    To ensure safity of IDE BusMaster installation/deinstallation
    please refer to points 1 and 6-8 of Manual installation for NT4
    (see readme_nt4_old.txt).

3.  REBOOT your computer

