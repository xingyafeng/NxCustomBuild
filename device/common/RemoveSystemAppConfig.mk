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
#add by Heaven start
    Y_REMOVE_PRODUCT_PACKAGES += \
          WallpaperCropper \
          CalendarProvider \
          BasicDreams \
          CalendarImporter \
          PrintSpooler \
          BSPTelephonyDevTool \
          AtciService \
          LiveWallpapersPicker \
          LiveWallpapers \
          VisualizationWallpapers \
          Galaxy4 \
          HoloSpiralWallpaper \
          NoiseField \
          PhaseBeam \
          SmartcardService \
          DrmProvider \
          Omacp \
          OneTimeInitializer \
          KeyChain \
          ManagedProvisioning \
          PhotoTable \
          FMRadio \
          HTMLViewer \
          LatinIME \
          Stk1 \
          VpnDialogs \
          DeskClock \
          Email \
          QuickSearchBox \
          FWUpgrade \
          PacProcessor \
          NlpService \
          ProxyHandler \
          FWUpgradeProvider \
          UserDictionaryProvider \
          MTKAndroidSuiteDaemon \
          Bluetooth
#add by Heaven end
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

  ifeq ($(strip $(call get_yov_board)), k68c)
    Y_REMOVE_PRODUCT_PACKAGES += \
          Home \
          Launcher2 \
          Launcher3 \
          DeskClock \
          Email \
          Exchange2 \
          QuickSearchBox \
          HoloSpiralWallpaper \
          LiveWallpapers \
          LiveWallpapersPicker \
          MagicSmokeWallpapers \
          Music \
          MusicFX
  endif
endif
