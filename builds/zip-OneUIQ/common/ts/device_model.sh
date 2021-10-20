#!/sbin/sh
# Written by @ambasadii and @abrahamgcc

[ -d /data/tmp/ts ] || mkdir -p /data/tmp/ts
cat /proc/cmdline | tr ' ' '\n' | grep "androidboot.em.model=" > /data/tmp/ts/device_model
