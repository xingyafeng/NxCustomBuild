#软连接中不生效，build/core/product.mk 中 find 没用加 -l 参数
# PRODUCT_MAKEFILES  该变量的值为产品版本定义文件名的列表
# 继承 full_base.mk 文件中的定义
# $(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
$(info including $(call my-dir)/AndroidProducts.mk ...)

## 跨平台配置
include  $(YUNOVO_ROOT)/$(YUNOVO_BUILD)/$(YUNOVO_COMMON)/common.mk

## 定制文件拷贝: 1. system/ 2. custom/　分区
include  $(YUNOVO_ROOT)/$(YUNOVO_BUILD)/$(YUNOVO_COMMON)/custom.mk

## 裁剪系统应用模块
include  $(YUNOVO_ROOT)/$(YUNOVO_BUILD)/$(YUNOVO_COMMON)/RemoveSystemAppConfig.mk

## 增加平台差异化模块
-include $(YUNOVO_ROOT)/$(YUNOVO_BUILD)/$(YUNOVO_DEVICE_P)/$(TARGET_DEVICE).mk
