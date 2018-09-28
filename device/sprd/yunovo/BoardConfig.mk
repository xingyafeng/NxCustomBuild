#配置硬件主板
$(info including $(call my-dir)/BoardConfig.mk ...)

## 定义路径，变量etc
include $(YUNOVO_ROOT)/$(YUNOVO_BUILD)/$(YUNOVO_DEVICE_P)/yunovo.mk
