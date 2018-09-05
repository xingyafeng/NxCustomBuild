#软连接中不生效，build/core/product.mk 中 find 没用加 -l 参数
# PRODUCT_MAKEFILES  该变量的值为产品版本定义文件名的列表
# 继承 full_base.mk 文件中的定义
# $(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
$(info including $(call my-dir)/AndroidProducts.mk ...)

## 云智根路径
YUNOVO_ROOT = yunovo

## Zen 计划仓库名
YUNOVO_CONFIG = NxCustomConfig
YUNOVO_BUILD  = NxCustomBuild
YUNOVO_RES    = NxCustomResource

## 客制化产品
YUNOVO_BOARD = $(shell find device/ -maxdepth 2 -name $(MTK_TARGET_PROJECT) | awk -F/ '{print $$2}')

## 公共模块
YUNOVO_COMMON = device/common

## 客制化产品路径
YUNOVO_DEVICE_P = device/$(YUNOVO_BOARD)/$(MTK_TARGET_PROJECT)

## 是否为zen平台构建.
ifneq ($(YOV_CUSTOM),)
  ifneq ($(YOV_PROJECT),)
    is_zen_project := true
  else
    is_zen_project :=
  endif
endif

## 默认打开odex (user)
ifeq ($(TARGET_BUILD_VARIANT),user)
WITH_DEXPREOPT := true
WITH_DEXPREOPT_PIC := true
endif

## 客制化路径
ifdef is_zen_project
    YUNOVO_CUSTOM_P = $(YOV_CUSTOM)/$(YOV_PROJECT)
else
    YUNOVO_CUSTOM_P :=
endif

## 广深OTA脚本路径. FOTA_SH用于区非zen平台.原路径:yunovo/packages/apps/AdupsFotaApp
FOTA_SH := yunovo/NxCustomResource/system/apk/AdupsFotaApp

## 裁剪系统应用模块
include  $(YUNOVO_ROOT)/$(YUNOVO_BUILD)/$(YUNOVO_COMMON)/SystemRemoveAppConfig.mk
