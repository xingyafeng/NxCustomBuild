#软连接中不生效， build/core/envsetup.mk find 没用加 -l 参数
$(info including $(call my-dir)/ProjectConfig.mk ...)

## 定制文件拷贝: 1. system/ 2. custom　分区
include $(YUNOVO_ROOT)/$(YUNOVO_BUILD)/$(YUNOVO_DEVICE_P)/custom.mk

## 云智自定义device.mk
include $(YUNOVO_ROOT)/$(YUNOVO_BUILD)/$(YUNOVO_DEVICE_P)/device.mk
