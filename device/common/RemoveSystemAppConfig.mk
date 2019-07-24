# system remove app config

# ----  系统裁剪模块
ifeq ($(strip $(IS_PUBLIC_VERSION)), false)

  ifneq ($(strip $(filter $(call get_yov_board), cm01 cm02)), )
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

  ifneq ($(strip $(filter $(call get_yov_board), ms16 ms18)), )
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
          PrintSpooler \
          YOcLogDog \
          Browser \
          BrowserXposed \
          DeskClock \
          AndroidAudioRecorder \
          Galaxy4 \
          PerfMon_v1.21 \
          MMITest \
          LatinIME \
          HoloSpiralWallpaper \
          NoteBook \
          KeyChain \
          Omacp \
          UserDictionaryProvider \
          ProxyHandler \
          PacProcessor \
          SprdQuickSearchBox \
	  QuickSearchBox \
          VpnDialogs \
          HTMLViewer \
          FMRadio \
          PhotoTable \
          ManagedProvisioning \
          OneTimeInitializer \
          BasicDreams \
          CalendarProvider \
          WallpaperCropper \
          ContactsBlackListAddon \
          DialerBlackListAddon \
          Calculator \
          SmilPlayer \
          CallLogBackup \
          CellBroadcastReceiver \
          messaging \
          WAPPushManager \
          CarrierConfig \
          Stk \
          Camera2
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

  ifeq ($(strip $(call get_yov_board)), mk26)
    Y_REMOVE_PRODUCT_PACKAGES += \
	  NlpService \
	  VoiceExtension \
	  VoiceCommand \
	  MtkCalendar \
	  DeskClock
  endif
endif
