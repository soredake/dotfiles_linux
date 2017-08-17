# Steam profile
# protect me from https://github.com/ValveSoftware/steam-for-linux/issues/3671 
# with >=llvm-4 we need to whitelist llvm stuff to avoid `libGL: dlopen /usr/lib32/dri/nouveau_dri.so failed (libLLVMObjCARCOpts.so.4: невозможно открыть разделяемый объектный файл: Нет такого файла или каталога)`
#noblacklist /usr/lib/llvm*
noblacklist /sbin/ldconfig
include /etc/firejail/steam.profile
