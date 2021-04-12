#!/sbin/sh
#
# ThunderStorms Initial script
#

# Remove another kernel files
rm -f /system_root/system/etc/init/hw/init.spectrum.rc
rm -f /system_root/system/etc/init/hw/init.spectrum.sh
rm -f /system_root/system/etc/init/hw/init.services.rc
rm -f /system_root/system/etc/init/hw/init.ts.rc
rm -f /system_root/system/etc/init/hw/init.ts.sh
rm -f /system_root/system/etc/init/hw/init.custom.sh
rm -f /system_root/system/etc/init/hw//spa

# Remove imported services
sed -i '/import \/init.moro.rc/d' /system_root/system/etc/init/hw/init.rc
sed -i '/import \/init.spectrum.rc/d' /system_root/system/etc/init/hw/init.rc
sed -i '/import \/init.ts.rc/d' /system_root/system/etc/init/hw/init.rc
sed -i '/import \/init.services.rc/d' /system_root/system/etc/init/hw/init.rc
sed -i '/import \/init.custom.rc/d' /system_root/system/etc/init/hw/init.rc
sed -i '/init.moro.rc/d' /system_root/system/etc/init/hw/init.rc
sed -i '/init.spectrum.rc/d' /system_root/system/etc/init/hw/init.rc
sed -i '/init.ts.rc/d' /system_root/system/etc/init/hw/init.rc
sed -i '/init.services.rc/d' /system_root/system/etc/init/hw/init.rc
sed -i '/init.custom.rc/d' /system_root/system/etc/init/hw/init.rc

# Copy kernel files
# cp /data/tmp/ts/system1/init.rc /system_root/system/etc/init/
cp /data/tmp/ts/system1/init.custom.rc /system_root/system/etc/init/hw/
cp /data/tmp/ts/system1/ts-kernel.sh /system_root/system/etc/init/hw/
cp /data/tmp/ts/vendor/* /system_root/vendor
# cp /data/tmp/ts/system1/init.spectrum.sh /system_root/system/etc/init/
# cp /data/tmp/ts/system1/spa /system_root/system/etc/init/
# cp /data/tmp/ts/system1/init.spectrum.rc /system_root/system/etc/init/
# cp /data/tmp/ts/system1/init.custom.rc /system_root/vendor/etc/init/
# cp /data/tmp/ts/system1/ts-kernel.sh /system_root/vendor/etc/init/

chmod 750 /system_root/system/etc/init/hw/init.rc
chmod 750 /system_root/system/etc/init/hw/init.custom.rc
chmod 755 /system_root/system/etc/init/hw/ts-kernel.sh
# chmod 755 /system_root/system/etc/init/init.spectrum.rc
# chmod 755 /system_root/system/etc/init/spa
# chmod 755 /system_root/system/etc/init/init.spectrum.sh
# chmod 750 /system_root/vendor/etc/init/init.custom.rc
# chmod 755 /system_root/vendor/etc/init/ts-kernel.sh

# Import init.ts.rc to init.rc
sed -i '/import \/system\/etc\/init\/hw\/init.${ro.zygote}.rc/a\import \/system\/etc\/init\/hw\/init.custom.rc' /system_root/system/etc/init/hw/init.rc
# sed -i '/import \/init.container.rc/a\import \/system\/etc\/init\/hw\/init.custom.rc' /system_root/system/etc/init/init.rc

# Make init.d folder
mkdir /system_root/vendor/etc/init.d
chmod 755 /system_root/vendor/etc/init.d

