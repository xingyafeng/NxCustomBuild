# system remove app config

# ----  系统裁剪模块
ifeq ($(strip $(IS_PUBLIC_VERSION)), false)

include $(YUNOVO_ROOT)/$(YUNOVO_BUILD)/$(YUNOVO_COMMON)/config/$(strip $(call get_yov_board)).mk

endif
