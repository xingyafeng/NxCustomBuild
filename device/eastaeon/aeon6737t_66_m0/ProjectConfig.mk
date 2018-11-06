#软连接中不生效， build/core/envsetup.mk find 没用加 -l 参数
$(info including $(call my-dir)/ProjectConfig.mk ...)

## 平台配置文件
include $(YUNOVO_ROOT)/$(YUNOVO_BUILD)/$(YUNOVO_DEVICE_P)/config.mk

## 自定义device.mk
include $(YUNOVO_ROOT)/$(YUNOVO_BUILD)/$(YUNOVO_DEVICE_P)/device.mk
