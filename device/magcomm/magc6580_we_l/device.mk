## 自定义客制化 device.mk
$(info including $(call my-dir)/device.mk ...)

## zenportal custom
-include $(YUNOVO_ROOT)/$(YUNOVO_CONFIG)/$(YUNOVO_CUSTOM_P)/framework.mk
-include $(YUNOVO_ROOT)/$(YUNOVO_CONFIG)/$(YUNOVO_CUSTOM_P)/app.mk

## 云智系统APP
include  $(YUNOVO_ROOT)/$(YUNOVO_BUILD)/$(YUNOVO_COMMON)/YunovoAppsConfig.mk
