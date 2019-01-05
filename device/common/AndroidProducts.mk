#软连接中不生效，build/core/product.mk 中 find 没用加 -l 参数
# PRODUCT_MAKEFILES  该变量的值为产品版本定义文件名的列表
# 继承 full_base.mk 文件中的定义
# $(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
$(info including $(call my-dir)/AndroidProducts.mk ...)

## 云智根路径
YUNOVO_ROOT = yunovo

## Zen计划仓库名
YUNOVO_CONFIG = NxCustomConfig
YUNOVO_BUILD  = NxCustomBuild
YUNOVO_RES    = NxCustomResource

## 客制化产品
YUNOVO_BOARD = $(shell find device/ -maxdepth 3 -name $(TARGET_DEVICE) | awk -F/ '{print $$2}')

## 公共模块
YUNOVO_COMMON = device/common

## 客制化产品路径
YUNOVO_DEVICE_P = device/$(YUNOVO_BOARD)/$(TARGET_DEVICE)

## 是否为zen平台构建.
ifneq ($(YOV_CUSTOM),)
  ifneq ($(YOV_PROJECT),)
    is_zen_project := true
  else
    is_zen_project :=
  endif
endif

## 客制化路径
ifdef is_zen_project
	YUNOVO_CUSTOM_P := $(YOV_CUSTOM)/$(YOV_PROJECT)
else
    YUNOVO_CUSTOM_P :=
endif

## 跨平台配置
include  $(YUNOVO_ROOT)/$(YUNOVO_BUILD)/$(YUNOVO_COMMON)/common.mk

## 定制文件拷贝: 1. system/ 2. custom/　分区
include  $(YUNOVO_ROOT)/$(YUNOVO_BUILD)/$(YUNOVO_COMMON)/custom.mk

## 裁剪系统应用模块
include  $(YUNOVO_ROOT)/$(YUNOVO_BUILD)/$(YUNOVO_COMMON)/RemoveSystemAppConfig.mk

## 增加平台差异化模块
-include $(YUNOVO_ROOT)/$(YUNOVO_BUILD)/$(YUNOVO_DEVICE_P)/$(TARGET_DEVICE).mk
