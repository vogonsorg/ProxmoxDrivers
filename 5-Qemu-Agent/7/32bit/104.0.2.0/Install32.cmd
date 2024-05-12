robocopy /MIR "%~dp0qemu-ga" "c:\Program Files\Qemu-ga"
C:
cd "c:\Program Files\Qemu-ga"
qemu-ga -s install
@pause