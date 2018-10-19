# yunovo apps config

##################### Jenkins构建默认编译模块
ifneq ($(strip $(SPT_VERSION_NO)),)

PRODUCT_PACKAGES += \
    YGPS \
    YOcLogDog

PRODUCT_PACKAGES += yovd init.yunovo.rc libstagefright_soft_mjpeg

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

## Zen 支持客制化项目的overlay
PRODUCT_PACKAGE_OVERLAYS += $(YUNOVO_ROOT)/$(YUNOVO_CONFIG)/$(YUNOVO_CUSTOM_P)/overlay

## 音频策略,由吴杰控制.
PRODUCT_COPY_FILES += \
	$(YUNOVO_ROOT)/$(YUNOVO_BUILD)/$(YUNOVO_COMMON)/audio_config/naviapplist.txt:system/etc/naviapplist.txt \
	$(YUNOVO_ROOT)/$(YUNOVO_BUILD)/$(YUNOVO_COMMON)/audio_config/notiapplist.txt:system/etc/notiapplist.txt \
	$(YUNOVO_ROOT)/$(YUNOVO_BUILD)/$(YUNOVO_COMMON)/audio_config/voiceapplist.txt:system/etc/voiceapplist.txt

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

ifeq ($(filter dumpvar-%,$(MAKECMDGOALS)),)
$(warning "===========================================================")
$(warning "    主界面 : ")
$(warning "    1. LAUNCHER_TYPE = $(YUNOVO_LAUNCHER_TYPE)")
$(warning "===========================================================")
endif
