# yunovo apps config

##################### Jenkins构建默认编译模块
ifneq ($(strip $(SPT_VERSION_NO)),)

PRODUCT_PACKAGES += \
    YGPS \
    YOcLogDog

PRODUCT_PACKAGES += yovd init.yunovo.rc

## 蓝牙模块,[诚谦|顾凯]
PRODUCT_PACKAGES += blink gocsdk

## 蓝牙主从功能切换
PRODUCT_PACKAGES += \
    libdevicecontrol_client \
    libdevicecontrolservice \
    libyunovo_bluetoothmanager \
    devicecontrol \
    com.yunovo.device.manager

PRODUCT_BOOT_JARS += \
    com.yunovo.device.manager

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

## default launcher
ifeq ($(call get-product-packages, YOcLauncher), YOcLauncher)
YUNOVO_LAUNCHER_TYPE = yoc
else ifeq ($(call get-product-packages, CarEngine), CarEngine)
YUNOVO_LAUNCHER_TYPE = car
else
PRODUCT_PACKAGES += Launcher3
YUNOVO_LAUNCHER_TYPE = android
endif

endif ### SPT_VERSION_NO endif

#####################

ifeq ($(filter dumpvar-%,$(MAKECMDGOALS)),)
$(warning "===========================================================")
$(warning "    主界面 : ")
$(warning "    1. LAUNCHER_TYPE = $(YUNOVO_LAUNCHER_TYPE)")
$(warning "===========================================================")
endif
