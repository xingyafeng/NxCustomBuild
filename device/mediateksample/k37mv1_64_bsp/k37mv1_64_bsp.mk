# 平台差异模块
# 当增加模块不具支持所有平台时,需要单独以平台为单位增加.
# 若增加模块具有通用性, 此时就需要增加到common/commom.mk 中. <注意>

$(info including $(call my-dir)/$(TARGET_DEVICE).mk ...)

## wilber start, #{
$(warning "YUNOVO_CUSTOM = ${YUNOVO_CUSTOM}")
ifeq ($(YUNOVO_CUSTOM), yes)
# 增加水印浮窗 from yafeng
PRODUCT_PACKAGES += yunovo-services
PRODUCT_SYSTEM_SERVER_JARS += yunovo-services

PRODUCT_PACKAGES += libsys_yov

#PRODUCT_DEFAULT_PROPERTY_OVERRIDES
#PRODUCT_PROPERTY_OVERRIDES += ro.yov.sys.custom=true
ADDITIONAL_BUILD_PROPERTIES += ro.yov.sys.custom=true

# 语言中文
PRODUCT_LOCALES := zh_CN en_US zh_TW

# 性能优化：任务快照,车机需要最近任务快照
ADDITIONAL_BUILD_PROPERTIES += persist.enable_task_snapshots=false

ifeq ($(TARGET_BUILD_VARIANT),user)
# 取消导航栏
ADDITIONAL_BUILD_PROPERTIES += qemu.hw.mainkeys=1
else
ADDITIONAL_BUILD_PROPERTIES += qemu.hw.mainkeys=0

endif

## do not use fs verify, ..
#PRODUCT_SUPPORTS_VERITY := false
$(warning "bbb system PRODUCT_SUPPORTS_VERITY = $(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_SUPPORTS_VERITY)")
PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_SUPPORTS_VERITY := false
PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_SUPPORTS_VERITY_FEC := false
$(warning "bbb after modify PRODUCT_SUPPORTS_VERITY = $(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_SUPPORTS_VERITY)")

# 默认时区
ADDITIONAL_BUILD_PROPERTIES += persist.sys.timezone=Asia/Shanghai

# 强制设为横屏
ADDITIONAL_BUILD_PROPERTIES += yov.sys.force_def_orientation=true

# 增加系統不休眠選項
ADDITIONAL_BUILD_PROPERTIES += yunovo.support.nerver_screenoff=true

# 禁用搜索引擎管理服务,先关闭,com/android/internal/app/AssistUtils.java:160引用报错
#ADDITIONAL_BUILD_PROPERTIES += config.disable_searchmanager=true

# yunovo-frameworks #{
YUNOVO_FRAMEWORKS := $(notdir $(call find-file-folder, yunovo, 4, framework))

PRODUCT_PACKAGES += \
	yunovo-framework

# yunovo-framework boot jar
ifeq ($(strip $(YUNOVO_FRAMEWORKS)), framework)
  PRODUCT_BOOT_JARS += yunovo-framework
endif

# yunovo-frameworks #}
endif

$(info --------------------------------------------------- )
$(info 1. YUNOVO_CUSTOM     = $(YUNOVO_CUSTOM))
$(info 2. YUNOVO_FRAMEWORKS = $(YUNOVO_FRAMEWORKS))
$(info -------------------------------------------------- )
### wilber end #}