# Yunovo config

# #################### Jenkins构建默认编译模块

ifeq ($(strip $(IS_PUBLIC_VERSION)), false)

# 系统预制应用
PRODUCT_PACKAGES += \
    YGPS

# 云智核心模块
PRODUCT_PACKAGES += yovd init.yunovo.rc libstagefright_soft_mjpeg
# 背光
PRODUCT_PACKAGES += libyov lights.$(TARGET_BOARD_PLATFORM)
# 提供一些给APP层面使用的接口和一些调试功能
PRODUCT_PACKAGES += YOcCoreServer
# SSH
PRODUCT_PACKAGES += ssh
# dropbear
PRODUCT_PACKAGES += dropbear
# dropbearkey
PRODUCT_PACKAGES += dropbearkey

# ######################################################################### 系统预制应用

# 蓝牙模块支持的情况
ifneq ($(strip $(filter $(call get_yov_board), ck03 ck05)), )

# 蓝牙模块,[诚谦|顾凯]
PRODUCT_PACKAGES += blink gocsdk gocsdks

else

# 蓝牙模块,[诚谦|顾凯]
PRODUCT_PACKAGES += blink gocsdk gocsdks

# 外置GPS模块，目前仅提供给VST使用.
PRODUCT_PACKAGES += \
       libcompass_client \
       libcompassservice \
       compass \
       libyunovogpsmanager

# 千行GPS SDK
PRODUCT_PACKAGES += \
       librtcm

# 蓝牙主从功能切换
PRODUCT_PACKAGES += \
    libdevicecontrol_client \
    libdevicecontrolservice \
    libyunovo_bluetoothmanager \
    libyunovo_devicenodemanager \
    devicecontrol \
    com.yunovo.device.manager

PRODUCT_BOOT_JARS += \
    com.yunovo.device.manager

# 蓝牙服务
PRODUCT_PACKAGES += \
	libbluetooth_client \
	libbluetoothservice \
	yovbt \
	libyunovobt_jni \
	yunovobluetooth

PRODUCT_BOOT_JARS += \
	yunovobluetooth

# yunovo蓝牙协议栈
ifeq ($(shell expr $(PLATFORM_SDK_VERSION) \> 23), 1)

PRODUCT_PACKAGES += yunbluetooth.default

endif #蓝牙协议栈 end

endif #蓝牙各个版型支持情况 end

# ######################################################################### 系统蓝牙模块

# Zen 支持客制化项目的overlay
PRODUCT_PACKAGE_OVERLAYS += $(YUNOVO_ROOT)/$(YUNOVO_CONFIG)/$(YUNOVO_CUSTOM_P)/overlay

# default launcher
ifneq ($(strip $(call get-product-packages-custom, YOcLauncher)),)
YUNOVO_LAUNCHER_TYPE = yoc
else ifneq ($(strip $(call get-product-packages-custom, CarEngine)),)
YUNOVO_LAUNCHER_TYPE = car
else
YUNOVO_LAUNCHER_TYPE = droidcar
endif

# ######################################################################### 系统默认桌面

endif # IS_PUBLIC_VERSION endif
# @@@@@@@@@@@@@@@@@@@@@@@

ifeq ($(strip $(YUNOVO_LAUNCHER_TYPE)),)
YUNOVO_LAUNCHER_TYPE := Android
endif

# wilber start #{
# 共享内存服务,提供给摄像头预览数据．
ifeq ($(strip $(YUNOVO_MEDIA_SHAREBUFFER)),yes)
ADDITIONAL_BUILD_PROPERTIES += yov.sys.sharebuffer_enable=true
PRODUCT_PACKAGES += libsharebufferservice
endif
# wilber end #}

ifeq ($(filter dumpvar-%,$(MAKECMDGOALS)),)
$(warning "===========================================================")
$(warning "    主界面 : ")
$(warning "    1. LAUNCHER_TYPE = $(YUNOVO_LAUNCHER_TYPE)")
$(warning "===========================================================")
endif
