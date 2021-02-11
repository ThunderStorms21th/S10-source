# Gaming v2
   
    # Little CPU
    chmod 0644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
    write /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor ts_schedutil
    chmod 0644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
    write /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq 442000
    chmod 0644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
    write /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq 1950000
    chmod 0644 /sys/devices/system/cpu/cpu0/cpufreq/ts_schedutil/down_rate_limit_us
    write /sys/devices/system/cpu/cpu0/cpufreq/ts_schedutil/down_rate_limit_us 4000
    chmod 0644 /sys/devices/system/cpu/cpu0/cpufreq/ts_schedutil/up_rate_limit_us
    write /sys/devices/system/cpu/cpu0/cpufreq/ts_schedutil/up_rate_limit_us 4000
    chmod 0644 /sys/devices/system/cpu/cpu0/cpufreq/ts_schedutil/iowait_boost_enable
    write /sys/devices/system/cpu/cpu0/cpufreq/ts_schedutil/iowait_boost_enable 0

    # Midle CPU
    chmod 0644 /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
    write /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor ts_schedutil
    chmod 0644 /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
    write /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq 507000
    chmod 0644 /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
    write /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq 2314000
    chmod 0644 /sys/devices/system/cpu/cpu4/cpufreq/ts_schedutil/down_rate_limit_us
    write /sys/devices/system/cpu/cpu4/cpufreq/ts_schedutil/down_rate_limit_us 4000
    chmod 0644 /sys/devices/system/cpu/cpu4/cpufreq/ts_schedutil/up_rate_limit_us
    write /sys/devices/system/cpu/cpu4/cpufreq/ts_schedutil/up_rate_limit_us 4000
    chmod 0644 /sys/devices/system/cpu/cpu4/cpufreq/ts_schedutil/iowait_boost_enable
    write /sys/devices/system/cpu/cpu4/cpufreq/ts_schedutil/iowait_boost_enable 0

    # BIG CPU
    chmod 0644 /sys/devices/system/cpu/cpu6/cpufreq/scaling_governor
    write /sys/devices/system/cpu/cpu6/cpufreq/scaling_governor ts_schedutil
    chmod 0644 /sys/devices/system/cpu/cpu6/cpufreq/scaling_min_freq
    write /sys/devices/system/cpu/cpu6/cpufreq/scaling_min_freq 520000
    chmod 0644 /sys/devices/system/cpu/cpu6/cpufreq/scaling_max_freq
    write /sys/devices/system/cpu/cpu6/cpufreq/scaling_max_freq 2730000
    chmod 0644 /sys/devices/system/cpu/cpu6/cpufreq/ts_schedutil/down_rate_limit_us
    write /sys/devices/system/cpu/cpu6/cpufreq/ts_schedutil/down_rate_limit_us 4000
    chmod 0644 /sys/devices/system/cpu/cpu6/cpufreq/ts_schedutil/up_rate_limit_us
    write /sys/devices/system/cpu/cpu6/cpufreq/ts_schedutil/up_rate_limit_us 4000
    chmod 0644 /sys/devices/system/cpu/cpu6/cpufreq/ts_schedutil/iowait_boost_enable
    write /sys/devices/system/cpu/cpu6/cpufreq/ts_schedutil/iowait_boost_enable 0

   # GPU
    chmod 0644 /sys/kernel/gpu/gpu_max_clock
    write /sys/kernel/gpu/gpu_max_clock 702000
    chmod 0644 /sys/kernel/gpu/gpu_min_clock
    write /sys/kernel/gpu/gpu_min_clock 200000
    chmod 0644 /sys/devices/platform/18500000.mali/power_policy
    write /sys/devices/platform/18500000.mali/power_policy coarse_demand
    chmod 0644 /sys/devices/platform/18500000.mali/dvfs_governor
    write /sys/devices/platform/18500000.mali/dvfs_governor 1
    chmod 0644 /sys/devices/platform/18500000.mali/highspeed_clock
    write /sys/devices/platform/18500000.mali/highspeed_clock 433000
    chmod 0644 /sys/devices/platform/18500000.mali/highspeed_load
    write /sys/devices/platform/18500000.mali/highspeed_load 80
    chmod 0644 /sys/devices/platform/18500000.mali/highspeed_delay
    write /sys/devices/platform/18500000.mali/highspeed_delay 0

   #Entropy settings
    chmod 0644 /proc/sys/kernel/random/write_wakeup_threshold
    write /proc/sys/kernel/random/write_wakeup_threshold 896
    chmod 0644 /proc/sys/kernel/random/read_wakeup_threshold
    write /proc/sys/kernel/random/read_wakeup_threshold 128

   # I/O sched settings
   chmod 0644 /sys/block/sda/queue/scheduler
   write /sys/block/sda/queue/scheduler cfq
   write /sys/block/sda/queue/read_ahead_kb 64
   chmod 0644 /sys/block/mmcblk0/queue/scheduler
   write /sys/block/mmcblk0/queue/scheduler cfq
   write /sys/block/mmcblk0/queue/read_ahead_kb 64
   chmod 0644 /sys/block/sda/queue/iostats
   write /sys/block/sda/queue/iostats 0
   chmod 0644 /sys/block/mmcblk0/queue/iostats
   write /sys/block/mmcblk0/queue/iostats 0
   chmod 0644 /sys/block/sda/queue/rq_affinity
   write /sys/block/sda/queue/rq_affinity 1
   chmod 0644 /sys/block/mmcblk0/queue/rq_affinity
   write /sys/block/mmcblk0/queue/rq_affinity 1
   chmod 0644 /sys/block/sda/queue/nr_requests
   write /sys/block/sda/queue/nr_requests 256
   chmod 0644 /sys/block/mmcblk0/queue/nr_requests
   write /sys/block/mmcblk0/queue/nr_requests 256

   # Wakelocks
   chmod 0644 /sys/module/wakeup/parameters/enable_sensorhub_wl
   write /sys/module/wakeup/parameters/enable_sensorhub_wl Y
   chmod 0644 /sys/module/wakeup/parameters/enable_mmc0_detect_wl
   write /sys/module/wakeup/parameters/enable_mmc0_detect_wl Y
   chmod 0644 /sys/module/wakeup/parameters/enable_wlan_wd_wake_wl
   write /sys/module/wakeup/parameters/enable_wlan_wd_wake_wl Y
   chmod 0644 /sys/module/wakeup/parameters/enable_wlan_rx_wake_wl
   write /sys/module/wakeup/parameters/enable_wlan_rx_wake_wl Y
   chmod 0644 /sys/module/wakeup/parameters/enable_wlan_ctrl_wake_wl
   write /sys/module/wakeup/parameters/enable_wlan_ctrl_wake_wl Y
   chmod 0644 /sys/module/wakeup/parameters/enable_ssp_wl
   write /sys/module/wakeup/parameters/enable_ssp_wl Y
   chmod 0644 /sys/module/wakeup/parameters/enable_bcmdhd4359_wl
   write /sys/module/wakeup/parameters/enable_bcmdhd4359_wl Y
   chmod 0644 /sys/module/wakeup/parameters/enable_bluedroid_timer_wl
   write /sys/module/wakeup/parameters/enable_bluedroid_timer_wl Y
   chmod 0644 /sys/module/wakeup/parameters/enable_wlan_wake_wl
   write /sys/module/wakeup/parameters/enable_wlan_wake_wl Y
   chmod 0644 /sys/module/sec_battery/parameters/wl_polling
   write /sys/module/sec_battery/parameters/wl_polling 8
   chmod 0644 /sys/module/sec_nfc/parameters/wl_nfc
   write /sys/module/sec_nfc/parameters/wl_nfc 2

   # Misc settings
   chmod 0644 /proc/sys/net/ipv4/tcp_congestion_control
   write /proc/sys/net/ipv4/tcp_congestion_control westwood
   chmod 0644 /sys/module/sync/parameters/fsync_enabled
   write /sys/module/sync/parameters/fsync_enabled 1
   chmod 0644 /sys/module/mmc_core/parameters/use_spi_crc
   write /sys/module/mmc_core/parameters/use_spi_crc N
   chmod 0644 /sys/kernel/sched/gentle_fair_sleepers
   write /sys/kernel/sched/gentle_fair_sleepers 0
   chmod 0644 /sys/kernel/power_suspend/power_suspend_mode
   write /sys/kernel/power_suspend/power_suspend_mode 3
   #write /sys/kernel/power_suspend/power_suspend_mode 1
   #write /sys/kernel/power_suspend/power_suspend_state 1
 
   # VM
   chmod 0644 /proc/sys/vm/dirty_expire_centisecs
   write /proc/sys/vm/dirty_expire_centisecs 500
   chmod 0644 /proc/sys/vm/dirty_writeback_centisecs
   write /proc/sys/vm/dirty_writeback_centisecs 500
   chmod 0644 /proc/sys/vm/vfs_cache_pressure
   write /proc/sys/vm/vfs_cache_pressure 100
   chmod 0644 /proc/sys/vm/swappiness
   write /proc/sys/vm/swappiness 160
   chmod 0644 /proc/sys/vm/overcommit_ratio
   write /proc/sys/vm/overcommit_ratio 60
   
   # Boeffla wakelocks
   chmod 0644 /sys/devices/virtual/misc/boeffla_wakelock_blocker/wakelock_blocker
   write /sys/devices/virtual/misc/boeffla_wakelock_blocker/wakelock_blocker 'wlan_pm_wake;wlan_rx_wake;wlan_wake;wlan_ctrl_wake;wlan_txfl_wake;BT_bt_wake;BT_host_wake;nfc_wake_lock;rmnet0;nfc_wake_lock;bluetooth_timer;event0;GPSD;umts_ipc0;NETLINK;ssp_comm_wake_lock;epoll_system_server_file:[timerfd4_system_server];epoll_system_server_file:[timerfd7_system_server];epoll_InputReader_file:event1;epoll_system_server_file:[timerfd5_system_server];epoll_InputReader_file:event10;epoll_InputReader_file:event0;epoll_InputReader_epollfd;epoll_system_server_epollfd'
