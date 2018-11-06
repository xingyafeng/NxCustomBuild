## 自定义客制化 config.mk
$(info including $(call my-dir)/config.mk ...)

## yunovo-common
YUNOVO_COMMON_LIB  := $(notdir $(call find-file-folder, yunovo, 2, yunovo-common))
## common
YUNOVO_COMMON_CODE := $(notdir $(call find-file-folder, yunovo/frameworks, 2, common))
## yunovo-policy

ifeq ($(PLATFORM_VERSION),5.1)
## yunovo-framework
YUNOVO_POLICY_LIB  := $(notdir $(call find-file-folder, yunovo, 3, yunovo-framework))
## policy
YUNOVO_POLICY_CODE := $(notdir $(call find-file-folder, yunovo, 3, policy))
else ifeq ($(PLATFORM_VERSION),6.0)
## yunovo-policy
YUNOVO_POLICY_LIB  := $(notdir $(call find-file-folder, yunovo, 3, yunovo-policy))
## policy
YUNOVO_POLICY_CODE := $(notdir $(call find-file-folder, yunovo, 3, policy))
endif

## yunovo-frameworks
YUNOVO_FRAMEWORKS_LIB := $(notdir $(call find-file-folder, yunovo, 3, yunovo-framework))

## 输出自定义变量
$(info --------------------------------------------------- )
$(info 1. YUNOVO_ROOT           = $(YUNOVO_ROOT))
$(info 2. YUNOVO_BOARD          = $(YUNOVO_BOARD))
$(info 3. YUNOVO_DEVICE_P       = $(YUNOVO_DEVICE_P))
$(info 4. YUNOVO_COMMON_LIB     = $(YUNOVO_COMMON_LIB))
$(info 5. YUNOVO_COMMON_CODE    = $(YUNOVO_COMMON_CODE))
$(info 6. YUNOVO_POLICY_LIB     = $(YUNOVO_POLICY_LIB))
$(info 7. YUNOVO_POLICY_CODE    = $(YUNOVO_POLICY_CODE))
$(info 8. YUNOVO_FRAMEWORKS_LIB = $(YUNOVO_FRAMEWORKS_LIB))
$(info -------------------------------------------------- )

## 框架公共模块抽取到common<源码路径> yunovo-common<库路径>
### yunovo-common start .
ifeq ($(strip $(YUNOVO_COMMON_CODE)), common)

YUNOVO_CODE = yes

endif

ifeq ($(strip $(YUNOVO_COMMON_LIB)), yunovo-common)

YUNOVO_CODE = no

endif

## 不论下载库，还是源码都必须定义 yunovo-common 保证公版正常编译. 若没有二者，无需定义.
ifneq ($(strip $(YUNOVO_CODE)),)

PRODUCT_BOOT_JARS += yunovo-common
PRODUCT_PACKAGES  += yunovo-common

PRODUCT_PACKAGES += YOcFwkPlugin
PRODUCT_PACKAGES += YOcAppPlugin

ADDITIONAL_BUILD_PROPERTIES += ro.yunovo.custom=1

endif
### yunovo-common end .

## 由于客制化框架5.1 与 6.0，源码路径相同，但定义变量不相同.故兼容如下
### yunovo-policy start .
ifeq ($(strip $(YUNOVO_POLICY_CODE)), policy)
  ifeq ($(strip $(PLATFORM_SDK_VERSION)),22)
    PRODUCT_BOOT_JARS += yunovo-framework
    PRODUCT_PACKAGES += yunovo-framework
  endif

  ifeq ($(strip $(PLATFORM_SDK_VERSION)),23)
    PRODUCT_SYSTEM_SERVER_JARS += yunovo-policy
    PRODUCT_PACKAGES += yunovo-policy
  endif
endif

## 由于客制化框架5.1 与 6.0路径有不同，并且定义变量也不相同.故兼容如下
ifeq ($(strip $(YUNOVO_POLICY_LIB)), yunovo-framework)

PRODUCT_BOOT_JARS += yunovo-framework
PRODUCT_PACKAGES += yunovo-framework

else ifeq ($(strip $(YUNOVO_POLICY_LIB)), yunovo-policy)

PRODUCT_SYSTEM_SERVER_JARS += yunovo-policy
PRODUCT_PACKAGES += yunovo-policy

endif
### yunovo-policy end .

#####################
