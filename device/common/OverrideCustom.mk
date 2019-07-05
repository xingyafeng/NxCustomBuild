# override custom
DRIVE_MK := $(YUNOVO_ROOT)/$(YUNOVO_CONFIG)/$(YUNOVO_CUSTOM_P)/drive.mk

$(shell cd $(YUNOVO_DEVICE_P) > /dev/null && git reset HEAD . && git clean -df && git checkout HEAD .)
$(info  Restore the original appearance ...)
$(info  ****** Forcing override custom >>>> $(YUNOVO_ROOT)/$(YUNOVO_CONFIG)/$(YUNOVO_CUSTOM_P)/override/android/* ...)
$(shell cp -rf $(YUNOVO_ROOT)/$(YUNOVO_CONFIG)/$(YUNOVO_CUSTOM_P)/override/android/* .)
$(info  ****** Done with the override , now starting the real build.)

$(shell test -f $(DRIVE_MK) -a -f $(YUNOVO_DEVICE_P)/ProjectConfig.mk && cat $(DRIVE_MK) >> $(YUNOVO_DEVICE_P)/ProjectConfig.mk)