# system remove app config

bb = $(call get_yov_board)
$(info bb = $(bb))

##################### Jenkins构建裁剪模块
ifneq ($(strip $(SPT_VERSION_NO)),)
  ifeq ($(strip $(call get_yov_board)), cm01)
    Y_REMOVE_PRODUCT_PACKAGES += \
      Calendar \
	  Music \
	  MusicFX \
	  batterywarning \
	  SchedulePowerOnOff \
	  BatteryWarning \
	  SDKGallery \
	  Gallery2 \
	  MtkBt \
	  mtkbt \
	  SoundRecorder \
	  Calendar
  endif
endif
