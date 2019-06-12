# yunovo apps config

##################### Jenkins构建默认编译模块
ifneq ($(strip $(SPT_VERSION_NO)),)

PRODUCT_PACKAGES += \
    YGPS \
    YOcLogDog

PRODUCT_PACKAGES += yovd init.yunovo.rc libstagefright_soft_mjpeg

## 蓝牙模块,[诚谦|顾凯]
PRODUCT_PACKAGES += blink gocsdk gocsdks

## 蓝牙主从功能切换
PRODUCT_PACKAGES += \
    libdevicecontrol_client \
    libdevicecontrolservice \
    libyunovo_bluetoothmanager \
    libyunovo_devicenodemanager \
    devicecontrol \
    com.yunovo.device.manager

PRODUCT_BOOT_JARS += \
    com.yunovo.device.manager

## 蓝牙服务
PRODUCT_PACKAGES += \
	libbluetooth_client \
	libbluetoothservice \
	yovbt \
	libyunovobt_jni \
	yunovobluetooth

PRODUCT_BOOT_JARS += \
	yunovobluetooth

## 外置GPS模块，目前仅提供给VST使用.
PRODUCT_PACKAGES += \
       libcompass_client \
       libcompassservice \
       compass \
       libyunovogpsmanager

## 千行GPS SDK
PRODUCT_PACKAGES += \
       librtcm

PRODUCT_PACKAGES += libyov lights.$(TARGET_BOARD_PLATFORM)

## 提供一些给APP层面使用的接口和一些调试功能
PRODUCT_PACKAGES += YOcCoreServer

# 系统级的后台服务APP
PRODUCT_PACKAGES += nxPAL

# SSH
PRODUCT_PACKAGES += ssh
# dropbear
PRODUCT_PACKAGES += dropbear
# dropbearkey
PRODUCT_PACKAGES += dropbearkey

## Zen 支持客制化项目的overlay
PRODUCT_PACKAGE_OVERLAYS += $(YUNOVO_ROOT)/$(YUNOVO_CONFIG)/$(YUNOVO_CUSTOM_P)/overlay

## default launcher
ifneq ($(strip $(call get-product-packages-custom, YOcLauncher)),)
YUNOVO_LAUNCHER_TYPE = yoc
else ifneq ($(strip $(call get-product-packages-custom, CarEngine)),)
YUNOVO_LAUNCHER_TYPE = car
else
YUNOVO_LAUNCHER_TYPE = droidcar
endif

endif ### SPT_VERSION_NO endif
#####################

ifeq ($(strip $(YUNOVO_LAUNCHER_TYPE)),)
YUNOVO_LAUNCHER_TYPE := Android
endif

## wilber start #{
ifeq ($(strip $(YUNOVO_MEDIA_SHAREBUFFER)),yes)
ADDITIONAL_BUILD_PROPERTIES += yov.sys.sharebuffer_enable=true
PRODUCT_PACKAGES += libsharebufferservice
endif
## wilber end #}

ifeq ($(filter dumpvar-%,$(MAKECMDGOALS)),)
$(warning "===========================================================")
$(warning "    主界面 : ")
$(warning "    1. LAUNCHER_TYPE = $(YUNOVO_LAUNCHER_TYPE)")
$(warning "===========================================================")
endif
