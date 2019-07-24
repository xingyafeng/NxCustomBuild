# override custom
DRIVE_MK := $(YUNOVO_ROOT)/$(YUNOVO_CONFIG)/$(YUNOVO_CUSTOM_P)/drive.mk
OVERRID_CUSTOM := $(YUNOVO_ROOT)/$(YUNOVO_CONFIG)/$(YUNOVO_CUSTOM_P)/override/android

$(shell \
  cd $(YUNOVO_DEVICE_P) > /dev/null; \
  git reset HEAD . > /dev/null; \
  git clean -df > /dev/null; \
  git checkout HEAD . > /dev/null; \
  cd - > /dev/null; \
)

$(info  ****** Forcing override custom : $(OVERRID_CUSTOM)/* ...)
$(shell test -d $(OVERRID_CUSTOM) && cp -rf $(OVERRID_CUSTOM)/* .)
$(shell test -f $(DRIVE_MK) -a -f $(YUNOVO_DEVICE_P)/ProjectConfig.mk && cat $(DRIVE_MK) >> $(YUNOVO_DEVICE_P)/ProjectConfig.mk)