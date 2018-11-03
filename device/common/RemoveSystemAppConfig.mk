# system remove app config

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

  ifeq ($(strip $(call get_yov_board)), ms16)
    Y_REMOVE_PRODUCT_PACKAGES += \
      Calendar \
      Launcher3\
      Home\
	  Music \
	  MusicFX \
	  Gallery2 \
	  SoundRecorder \
	  Calendar \
	  Email \
	  kedaxunfei\
	  BtReverse\
	  driveRecorder\
	  EmailDrmAddon\
	  NoiseField\
	  LiveWallpapers\
	  LiveWallpapersPicker\
	  PhaseBeam\
	  PicoTts\
	  PrintSpooler
  endif

endif
