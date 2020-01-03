# Yunovo config

# #################### Jenkins构建默认编译模块

ifeq ($(strip $(IS_PUBLIC_VERSION)), false)

# ######################################################################## 系统预制属性
# 1. default.prop
ADDITIONAL_DEFAULT_PROPERTIES += ro.system.version=$(YUNOVO_SYSTEM_VERSION_FOTA)

# 2. system.prop
#ADDITIONAL_BUILD_PROPERTIES += ro.yunovo.xxx
#PRODUCT_PROPERTY_OVERRIDES  += ro.yunovo.xxx

# ######################################################################## 系统预制应用
PRODUCT_PACKAGES += \
    YGPS

# default launcher
ifneq ($(strip $(call get-product-packages-custom, YOcLauncher)),)
YUNOVO_LAUNCHER_TYPE = yoc
else ifneq ($(strip $(call get-product-packages-custom, CarEngine)),)
YUNOVO_LAUNCHER_TYPE = car
else
YUNOVO_LAUNCHER_TYPE = droidcar
endif

# ######################################################################## 系统预制应用
# 系统开发部,各种的模块
-include $(YUNOVO_ROOT)/$(YUNOVO_BUILD)/$(YUNOVO_COMMON)/user/*.mk

else # IS_PUBLIC_VERSION else

# 公版项目定义

endif # IS_PUBLIC_VERSION endif

# @@@@@@@@@@@@@@@@@@@@@@@

# ######################################################################## 系统默认桌面
ifeq ($(strip $(YUNOVO_LAUNCHER_TYPE)),)
YUNOVO_LAUNCHER_TYPE := Android
endif

ifeq ($(filter dumpvar-%,$(MAKECMDGOALS)),)
$(warning "===========================================================")
$(warning "    主界面 : ")
$(warning "    1. LAUNCHER_TYPE = $(YUNOVO_LAUNCHER_TYPE)")
$(warning "===========================================================")
endif