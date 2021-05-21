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
	# echo "## -- SafetyNet permissions" >> $LOG;
	# chmod 644 /sys/fs/selinux/enforce;
	# chmod 440 /sys/fs/selinux/policy;
    # echo "0" > /sys/fs/selinux/enforce
	# echo " " >> $LOG;

	# deepsleep fix
	echo "## -- DeepSleep Fix" >> $LOG;

    dmesg -n 1 -C
	echo "N" > /sys/kernel/debug/debug_enabled
	echo "N" > /sys/kernel/debug/seclog/seclog_debug
	echo "0" > /sys/kernel/debug/tracing/tracing_on
	echo "0" > /sys/module/lowmemorykiller/parameters/debug_level
    echo "0" > /sys/module/alarm_dev/parameters/debug_mask
    echo "0" > /sys/module/binder/parameters/debug_mask
    echo "0" > /sys/module/binder_alloc/parameters/debug_mask
    echo "0" > /sys/module/powersuspend/parameters/debug_mask
    echo "0" > /sys/module/xt_qtaguid/parameters/debug_mask
    echo "0" > /sys/module/lowmemorykiller/parameters/debug_level
    echo "0" > /sys/module/kernel/parameters/initcall_debug

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
	# Google play services wakelock fix
	# echo "## -- GooglePlay wakelock fix $( date +"%d-%m-%Y %H:%M:%S" )" >> $LOG;

	# FIX GOOGLE PLAY SERVICE
	# su -c "pm enable com.google.android.gms/.ads.AdRequestBrokerService"
	# su -c "pm enable com.google.android.gms/.ads.identifier.service.AdvertisingIdService"
	# su -c "pm enable com.google.android.gms/.ads.social.GcmSchedulerWakeupService"
	# su -c "pm enable com.google.android.gms/.analytics.AnalyticsService"
	# su -c "pm enable com.google.android.gms/.analytics.service.PlayLogMonitorIntervalService"
	# su -c "pm enable com.google.android.gms/.backup.BackupTransportService"
	# su -c "pm enable com.google.android.gms/.update.SystemUpdateActivity"
	# su -c "pm enable com.google.android.gms/.update.SystemUpdateService"
	# su -c "pm enable com.google.android.gms/.update.SystemUpdateService\$ActiveReceiver"
	# su -c "pm enable com.google.android.gms/.update.SystemUpdateService\$Receiver"
	# su -c "pm enable com.google.android.gms/.update.SystemUpdateService\$SecretCodeReceiver"
	# su -c "pm enable com.google.android.gms/.thunderbird.settings.ThunderbirdSettingInjectorService"
	# su -c "pm enable com.google.android.gsf/.update.SystemUpdateActivity"
	# su -c "pm enable com.google.android.gsf/.update.SystemUpdatePanoActivity"
	# su -c "pm enable com.google.android.gsf/.update.SystemUpdateService"
	# su -c "pm enable com.google.android.gsf/.update.SystemUpdateService\$Receiver"
	# su -c "pm enable com.google.android.gsf/.update.SystemUpdateService\$SecretCodeReceiver"
	# echo " " >> $LOG;

    # Initial ThundeRStormS settings

	echo "## -- Initial settings by ThundeRStormS" >> $LOG;

    # Kernel Panic off (0 = Disabled, 1 = Enabled)
    echo "0" > /proc/sys/kernel/panic
     
    # CPU HOTPLUG (0/N = Disabled, 1/Y = Enabled)
    echo "N" > /sys/module/workqueue/parameters/power_efficient

    # CPU SUSPEND FREQ (0/N = Disabled, 1/Y = Enabled)
    echo "N" > /sys/module/exynos_acme/parameters/enable_suspend_freqs

   # FINGERPRINT BOOST (0 = Disabled, 1 = Enabled)
    echo "0" > /sys/kernel/fp_boost/enabled

    # CPU set at max/min freq
    # Little CPU
    echo "ts_schedutil" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
    echo "351000" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
    echo "1950000" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
    echo "4000" > /sys/devices/system/cpu/cpu0/cpufreq/ts_schedutil/down_rate_limit_us
    echo "4000" > /sys/devices/system/cpu/cpu0/cpufreq/ts_schedutil/up_rate_limit_us
    echo "0" > /sys/devices/system/cpu/cpu0/cpufreq/ts_schedutil/iowait_boost_enable
    echo "1" > /sys/devices/system/cpu/cpu0/cpufreq/ts_schedutil/fb_legacy

    # Midle CPU
    echo "ts_schedutil" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
    echo "377000" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
    echo "2314000" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
    echo "4000" > /sys/devices/system/cpu/cpu4/cpufreq/ts_schedutil/down_rate_limit_us
    echo "4000" > /sys/devices/system/cpu/cpu4/cpufreq/ts_schedutil/up_rate_limit_us
    echo "0" > /sys/devices/system/cpu/cpu4/cpufreq/ts_schedutil/iowait_boost_enable
    echo "1" > /sys/devices/system/cpu/cpu4/cpufreq/ts_schedutil/fb_legacy

    # BIG CPU
    echo "ts_schedutil" > /sys/devices/system/cpu/cpu6/cpufreq/scaling_governor
    echo "520000" > /sys/devices/system/cpu/cpu6/cpufreq/scaling_min_freq
    echo "2730000" > /sys/devices/system/cpu/cpu6/cpufreq/scaling_max_freq
    echo "4000" > /sys/devices/system/cpu/cpu6/cpufreq/ts_schedutil/down_rate_limit_us
    echo "4000" > /sys/devices/system/cpu/cpu6/cpufreq/ts_schedutil/up_rate_limit_us
    echo "0" > /sys/devices/system/cpu/cpu6/cpufreq/ts_schedutil/iowait_boost_enable
    echo "1" > /sys/devices/system/cpu/cpu6/cpufreq/ts_schedutil/fb_legacy

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
    echo "3" > /sys/module/sec_battery/parameters/wl_polling
    echo "1" > /sys/module/sec_nfc/parameters/wl_nfc

    # Entropy
    echo "512" > /proc/sys/kernel/random/write_wakeup_threshold
    echo "64" > /proc/sys/kernel/random/read_wakeup_threshold

    # VM
    echo "85" > /proc/sys/vm/vfs_cache_pressure
    echo "0" > /proc/sys/vm/swappiness
    echo "800" > /proc/sys/vm/dirty_writeback_centisecs
    echo "1200" > /proc/sys/vm/dirty_expire_centisecs
    echo "60" > /proc/sys/vm/overcommit_ratio

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
    echo "100000" > /sys/kernel/gpu/gpu_min_clock
    echo "coarse_demand" > /sys/devices/platform/18500000.mali/power_policy
    echo "1" > /sys/devices/platform/18500000.mali/dvfs_governor
    echo "325000" > /sys/devices/platform/18500000.mali/highspeed_clock
    echo "95" > /sys/devices/platform/18500000.mali/highspeed_load
    echo "1" > /sys/devices/platform/18500000.mali/highspeed_delay

   # Misc settings : bbr2, bbr, cubic or westwood
   echo "westwood" > /proc/sys/net/ipv4/tcp_congestion_control
   echo "N" > /sys/module/mmc_core/parameters/use_spi_crc
   echo "1" > /sys/module/sync/parameters/fsync_enabled
   echo "0" > /sys/kernel/sched/gentle_fair_sleepers
   echo "3" > /sys/kernel/power_suspend/power_suspend_mode
   # echo "1" > /sys/kernel/power_suspend/power_suspend_mode
   # echo "1" > /sys/kernel/power_suspend/power_suspend_state

   # I/O sched settings
   echo "cfq" > /sys/block/sda/queue/scheduler
   # echo "256" > /sys/block/sda/queue/read_ahead_kb
   echo "cfq" > /sys/block/mmcblk0/queue/scheduler
   # echo "256" > /sys/block/mmcblk0/queue/read_ahead_kb
   echo "0" > /sys/block/sda/queue/iostats
   echo "0" > /sys/block/mmcblk0/queue/iostats
   echo "1" > /sys/block/sda/queue/rq_affinity
   echo "1" > /sys/block/mmcblk0/queue/rq_affinity
   echo "256" > /sys/block/sda/queue/nr_requests
   echo "256" > /sys/block/mmcblk0/queue/nr_requests

   ## Kernel Stune
   # GLOBAL
   echo "5" > /dev/stune/schedtune.boost
   echo "0" > /dev/stune/schedtune.band
   echo "0" > /dev/stune/schedtune.prefer_idle
   echo "1" > /dev/stune/schedtune.prefer_perf  # 1
   echo "0" > /dev/stune/schedtune.util_est_en
   echo "0" > /dev/stune/schedtune.ontime_en
   # TOP-APP
   # echo "20" > /dev/stune/top-app/schedtune.boost
   # echo "1" > /dev/stune/top-app/schedtune.prefer_idle
   # echo "1" > /dev/stune/top-app/schedtune.prefer_perf
   # echo "1" > /dev/stune/top-app/schedtune.util_est_en
   # echo "1" > /dev/stune/top-app/schedtune.ontime_en

   ## Kernel Scheduler
   echo "2000000" > /proc/sys/kernel/sched_wakeup_granularity_ns
   echo "10000000" > /proc/sys/kernel/sched_latency_ns
   echo "550000" > /proc/sys/kernel/sched_min_granularity_ns
   echo "1000000" > /proc/sys/kernel/sched_migration_cost_ns
   echo "1000000" > /proc/sys/kernel/sched_rt_period_us

   # CPU EFF_mode
   # echo "1" > /sys/kernel/ems/eff_mode

   # CPU Energy Aware
   # echo "0" > /proc/sys/kernel/sched_energy_aware
   # echo "0" > /proc/sys/kernel/sched_tunable_scaling

   # Thermal Governors
   # BIG Cluster
   echo "step_wise" > /sys/devices/virtual/thermal/thermal_zone0/policy
   # MID Cluster
   echo "step_wise" > /sys/devices/virtual/thermal/thermal_zone1/policy
   # LITTLE Cluster
   echo "step_wise" > /sys/devices/virtual/thermal/thermal_zone2/policy
   # GPU
   echo "step_wise" > /sys/devices/virtual/thermal/thermal_zone3/policy
   # ISP
   echo "step_wise" > /sys/devices/virtual/thermal/thermal_zone4/policy
   # AC
   echo "step_wise" > /sys/devices/virtual/thermal/thermal_zone5/policy
   # BATTERY
   echo "step_wise" > /sys/devices/virtual/thermal/thermal_zone6/policy

   # Boeffla wakelocks
   chmod 0644 /sys/devices/virtual/misc/boeffla_wakelock_blocker/wakelock_blocker
   echo 'wlan_pm_wake;wlan_rx_wake;wlan_wake;wlan_ctrl_wake;wlan_txfl_wake;BT_bt_wake;BT_host_wake;nfc_wake_lock;rmnet0;nfc_wake_lock;bluetooth_timer;event0;GPSD;umts_ipc0;NETLINK;ssp_comm_wake_lock;epoll_system_server_file:[timerfd4_system_server];epoll_system_server_file:[timerfd7_system_server];epoll_InputReader_file:event1;epoll_system_server_file:[timerfd5_system_server];epoll_InputReader_file:event10;epoll_InputReader_file:event0;epoll_InputReader_epollfd;epoll_system_server_epollfd' > /sys/devices/virtual/misc/boeffla_wakelock_blocker/wakelock_blocker
	echo " " >> $LOG;

	# echo "## -- Sched features Fix" >> $LOG;

    ## Enhanched SlickSleep
    echo "NO_NORMALIZED_SLEEPER" > /sys/kernel/debug/sched_features
    echo "NO_GENTLE_FAIR_SLEEPERS" > /sys/kernel/debug/sched_features
    echo "NO_NORMALIZED_SLEEPER" > /sys/kernel/debug/sched_features
    echo "NO_NEW_FAIR_SLEEPERS" > /sys/kernel/debug/sched_features
    echo "NO_START_DEBIT" > /sys/kernel/debug/sched_features
    echo "NO_HRTICK" > /sys/kernel/debug/sched_features
    echo "NO_CACHE_HOT_BUDDY" > /sys/kernel/debug/sched_features
    echo "NO_LB_BIAS" > /sys/kernel/debug/sched_features
    echo "NO_OWNER_SPIN" > /sys/kernel/debug/sched_features
    echo "NO_DOUBLE_TICK" > /sys/kernel/debug/sched_features
    echo "NO_AFFINE_WAKEUPS" > /sys/kernel/debug/sched_features
    echo "NO_NEXT_BUDDY" > /sys/kernel/debug/sched_features
    echo "NO_WAKEUP_OVERLAP" > /sys/kernel/debug/sched_features
	
	## Kernel no debugs
    echo "NO_AFFINE_WAKEUPS" >> /sys/kernel/debug/sched_features
    echo "NO_ARCH_POWER" >> /sys/kernel/debug/sched_features
    echo "NO_CACHE_HOT_BUDDY" >> /sys/kernel/debug/sched_features
    echo "NO_DOUBLE_TICK" >> /sys/kernel/debug/sched_features
    echo "NO_FORCE_SD_OVERLAP" >> /sys/kernel/debug/sched_features
    echo "NO_GENTLE_FAIR_SLEEPERS" >> /sys/kernel/debug/sched_features
    echo "NO_HRTICK" >> /sys/kernel/debug/sched_features
    echo "NO_LAST_BUDDY" >> /sys/kernel/debug/sched_features
    echo "NO_LB_BIAS" >> /sys/kernel/debug/sched_features
    echo "NO_LB_MIN" >> /sys/kernel/debug/sched_features
    echo "NO_NEW_FAIR_SLEEPERS" >> /sys/kernel/debug/sched_features
    echo "NO_NEXT_BUDDY" >> /sys/kernel/debug/sched_features
    echo "NO_NONTASK_POWER" >> /sys/kernel/debug/sched_features
    echo "NO_NORMALIZED_SLEEPERS" >> /sys/kernel/debug/sched_features
    echo "NO_OWNER_SPIN" >> /sys/kernel/debug/sched_features
    echo "NO_RT_RUNTIME_SHARE" >> /sys/kernel/debug/sched_features
    echo "NO_START_DEBIT" >> /sys/kernel/debug/sched_features
    echo "NO_TTWU_QUEUE" >> /sys/kernel/debug/sched_features
	echo " " >> $LOG;

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

