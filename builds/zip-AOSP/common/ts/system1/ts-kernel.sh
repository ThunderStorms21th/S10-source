#!/system/bin/sh
# 
# Init TSKernel
#

TS_DIR="/data/.tskernel"
LOG="$TS_DIR/tskernel.log"

sleep 5

rm -f $LOG

    # Create ThunderStormS and init.d folder
    if [ ! -d $TS_DIR ]; then
	    mkdir -p $TS_DIR;
    fi

    # Create init.d folder
    mkdir -p /vendor/etc/init.d;
	chown -R root.root /vendor/etc/init.d;
	chmod 755 /vendor/etc/init.d;

	echo $(date) "TS-Kernel LOG" >> $LOG;
	echo " " >> $LOG;

	# SafetyNet
	# SELinux (0 / 640 = Permissive, 1 / 644 = Enforcing)
	echo "## -- SafetyNet permissions" >> $LOG;
	chmod 644 /sys/fs/selinux/enforce;
	chmod 440 /sys/fs/selinux/policy;
	echo " " >> $LOG;

	# deepsleep fix
	echo "## -- DeepSleep Fix" >> $LOG;

	echo "N" > /sys/kernel/debug/debug_enabled
	echo "N" > /sys/kernel/debug/seclog/seclog_debug
	echo "0" > /sys/kernel/debug/tracing/tracing_on
	echo "0" > /sys/module/lowmemorykiller/parameters/debug_level

    debug="/sys/module/*" 2>/dev/null
    for i in \$debug
    do
	    if [ -e \$DD/parameters/debug_mask ]
	    then
		    echo "0" >  \$i/parameters/debug_mask
	    fi
    done
	
    for i in `ls /sys/class/scsi_disk/`; do
	    cat /sys/class/scsi_disk/$i/write_protect 2>/dev/null | grep 1 >/dev/null
	    if [ $? -eq 0 ]; then
		    echo 'temporary none' > /sys/class/scsi_disk/$i/cache_type
	    fi
    done

	echo " " >> $LOG;

	## ThunderStormS kill Google and Media servers script
	sleep 2

	# Google play services wakelock fix
	echo "## -- GooglePlay wakelock fix $( date +"%d-%m-%Y %H:%M:%S" )" >> $LOG;
	

	# FIX GOOGLE PLAY SERVICE
	su -c "pm enable com.google.android.gms/.ads.AdRequestBrokerService"
	su -c "pm enable com.google.android.gms/.ads.identifier.service.AdvertisingIdService"
	su -c "pm enable com.google.android.gms/.ads.social.GcmSchedulerWakeupService"
	su -c "pm enable com.google.android.gms/.analytics.AnalyticsService"
	su -c "pm enable com.google.android.gms/.analytics.service.PlayLogMonitorIntervalService"
	su -c "pm enable com.google.android.gms/.backup.BackupTransportService"
	su -c "pm enable com.google.android.gms/.update.SystemUpdateActivity"
	su -c "pm enable com.google.android.gms/.update.SystemUpdateService"
	su -c "pm enable com.google.android.gms/.update.SystemUpdateService\$ActiveReceiver"
	su -c "pm enable com.google.android.gms/.update.SystemUpdateService\$Receiver"
	su -c "pm enable com.google.android.gms/.update.SystemUpdateService\$SecretCodeReceiver"
	su -c "pm enable com.google.android.gms/.thunderbird.settings.ThunderbirdSettingInjectorService"
	su -c "pm enable com.google.android.gsf/.update.SystemUpdateActivity"
	su -c "pm enable com.google.android.gsf/.update.SystemUpdatePanoActivity"
	su -c "pm enable com.google.android.gsf/.update.SystemUpdateService"
	su -c "pm enable com.google.android.gsf/.update.SystemUpdateService\$Receiver"
	su -c "pm enable com.google.android.gsf/.update.SystemUpdateService\$SecretCodeReceiver"
	echo " " >> $LOG;

    # Initial ThundeRStormS settings

    # Kernel Panic off (0 = Disabled, 1 = Enabled)
    echo "0" > /proc/sys/kernel/panic
     
    # CPU HOTPLUG (0/N = Disabled, 1/Y = Enabled)
    echo "N" > /sys/module/workqueue/parameters/power_efficient
 
    # CPU set at max/min freq
    # Little CPU
    echo "ts_schedutil" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
    echo "351000" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
    echo "1742000" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
    echo "2000" > /sys/devices/system/cpu/cpu0/cpufreq/ts_schedutil/down_rate_limit_us
    echo "4000" > /sys/devices/system/cpu/cpu0/cpufreq/ts_schedutil/up_rate_limit_us
    echo "0" > /sys/devices/system/cpu/cpu0/cpufreq/ts_schedutil/iowait_boost_enable

    # Midle CPU
    echo "ts_schedutil" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
    echo "507000" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
    echo "2314000" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
    echo "2000" > /sys/devices/system/cpu/cpu4/cpufreq/ts_schedutil/down_rate_limit_us
    echo "4000" > /sys/devices/system/cpu/cpu4/cpufreq/ts_schedutil/up_rate_limit_us
    echo "0" > /sys/devices/system/cpu/cpu4/cpufreq/ts_schedutil/iowait_boost_enable

    # BIG CPU
    echo "ts_schedutil" > /sys/devices/system/cpu/cpu6/cpufreq/scaling_governor
    echo "520000" > /sys/devices/system/cpu/cpu6/cpufreq/scaling_min_freq
    echo "2730000" > /sys/devices/system/cpu/cpu6/cpufreq/scaling_max_freq
    echo "2000" > /sys/devices/system/cpu/cpu6/cpufreq/ts_schedutil/down_rate_limit_us
    echo "5000" > /sys/devices/system/cpu/cpu6/cpufreq/ts_schedutil/up_rate_limit_us
    echo "0" > /sys/devices/system/cpu/cpu6/cpufreq/ts_schedutil/iowait_boost_enable

    # Wakelock settigs
    echo "N" > /sys/module/wakeup/parameters/enable_sensorhub_wl
    echo "N" > /sys/module/wakeup/parameters/enable_ssp_wl
    echo "N" > /sys/module/wakeup/parameters/enable_bcmdhd4359_wl
    echo "Y" > /sys/module/wakeup/parameters/enable_bluedroid_timer_wl
    echo "Y" > /sys/module/wakeup/parameters/enable_wlan_wake_wl
    echo "Y" > /sys/module/wakeup/parameters/enable_wlan_ctrl_wake_wl
    echo "Y" > /sys/module/wakeup/parameters/enable_wlan_rx_wake_wl
    echo "Y" > /sys/module/wakeup/parameters/enable_wlan_wd_wake_wl
    echo "Y" > /sys/module/wakeup/parameters/enable_mmc0_detect_wl
    echo "4" > /sys/module/sec_battery/parameters/wl_polling
    echo "1" > /sys/module/sec_nfc/parameters/wl_nfc

    # Entropy
    echo "256" > /proc/sys/kernel/random/write_wakeup_threshold
    echo "128" > /proc/sys/kernel/random/read_wakeup_threshold

    # VM
    echo "90" > /proc/sys/vm/vfs_cache_pressure
    echo "100" > /proc/sys/vm/swappiness
    echo "800" > /proc/sys/vm/dirty_writeback_centisecs
    echo "1000" > /proc/sys/vm/dirty_expire_centisecs
    echo "70" > /proc/sys/vm/overcommit_ratio

    # Battery
    echo "1700" > /sys/devices/platform/battery/wc_input
    echo "2100" > /sys/devices/platform/battery/wc_charge
    echo "1650" > /sys/devices/platform/battery/ac_input
    echo "2300" > /sys/devices/platform/battery/ac_charge
    echo "1700" > /sys/devices/platform/battery/ps_input
    echo "2300" > /sys/devices/platform/battery/ps_charge
    echo "1650" > /sys/devices/platform/battery/usb_input
    echo "2300" > /sys/devices/platform/battery/usb_charge

    # ZRAM
    # swapoff /dev/block/zram0 > /dev/null 2>&1
    # echo "1" > /sys/block/zram0/reset
    # echo "1073741824" > /sys/block/zram0/disksize  # 1,0 GB
    # echo "1610612736" > /sys/block/zram0/disksize  # 1,5 GB
    # echo "2147483648" > /sys/block/zram0/disksize  # 2,0 GB
    # echo "3221225472" > /sys/block/zram0/disksize  # 3,0 GB
    # chmod 644 /dev/block/zram0
    # mkswap /dev/block/zram0 > /dev/null 2>&1
    # swapon /dev/block/zram0 > /dev/null 2>&1

    # GPU set at max/min freq
    echo "702000" > /sys/kernel/gpu/gpu_max_clock
    echo "156000" > /sys/kernel/gpu/gpu_min_clock
    echo "coarse_demand" > /sys/devices/platform/18500000.mali/power_policy
    echo "1" > /sys/devices/platform/18500000.mali/dvfs_governor
    echo "433000" > /sys/devices/platform/18500000.mali/highspeed_clock
    echo "80" > /sys/devices/platform/18500000.mali/highspeed_load
    echo "0" > /sys/devices/platform/18500000.mali/highspeed_delay

   # Misc settings : bbr, cubic or westwood
   echo "westwood" > /proc/sys/net/ipv4/tcp_congestion_control
   echo "N" > /sys/module/mmc_core/parameters/use_spi_crc
   echo "1" > /sys/module/sync/parameters/fsync_enabled
   echo "0" > /sys/kernel/sched/gentle_fair_sleepers
   echo "3" > /sys/kernel/power_suspend/power_suspend_mode
   # echo "1" > /sys/kernel/power_suspend/power_suspend_mode
   # echo "1" > /sys/kernel/power_suspend/power_suspend_state

   # I/O sched settings
   echo "cfq" > /sys/block/sda/queue/scheduler
   echo "64" > /sys/block/sda/queue/read_ahead_kb
   echo "cfq" > /sys/block/mmcblk0/queue/scheduler
   echo "64" > /sys/block/mmcblk0/queue/read_ahead_kb
   echo "0" > /sys/block/sda/queue/iostats
   echo "0" > /sys/block/mmcblk0/queue/iostats
   echo "1" > /sys/block/sda/queue/rq_affinity
   echo "1" > /sys/block/mmcblk0/queue/rq_affinity
   echo "128" > /sys/block/sda/queue/nr_requests
   echo "128" > /sys/block/mmcblk0/queue/nr_requests


	# Init.d support
	echo "## -- Start Init.d support" >> $LOG;
	if [ ! -d /vendor/etc/init.d ]; then
	    	mkdir -p /vendor/etc/init.d;
	fi

	chown -R root.root /vendor/etc/init.d;
	chmod 755 /vendor/etc/init.d;

	# remove detach script
	rm -f /vendor/etc/init.d/*detach* 2>/dev/null;
	rm -rf /data/magisk_backup_* 2>/dev/null;

	if [ "$(ls -A /vendor/etc/init.d)" ]; then
		chmod 755 /vendor/etc/init.d/*;

		for FILE in /vendor/etc/init.d/*; do
			echo "## -- Executing init.d script: $FILE" >> $LOG;
			sh $FILE >/dev/null;
	    	done;
	else
		echo "## -- No files found" >> $LOG;
	fi
	echo "## -- End Init.d support" >> $LOG;
	echo " " >> $LOG;

chmod 777 $LOG;

