#
# cm01项目裁剪系统应用
#

$(info including $(call my-dir)/$(strip $(call get_yov_board)).mk ...)

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
	  Bluetooth \
	  Dialer