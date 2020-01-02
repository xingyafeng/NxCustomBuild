#
# ck02项目裁剪系统应用
#

$(info including $(call my-dir)/$(strip $(call get_yov_board)).mk ...)

ifneq ($(strip $(filter $(TARGET_BUILD_VARIANT), user)),)
  ifeq (8.1.0, $(strip $(PLATFORM_VERSION)))
  # delete origin system module
  Y_REMOVE_PRODUCT_PACKAGES += \
	MusicBspPlus \
	BackupRestoreConfirmation \
	BlockedNumberProvider \
	BookmarkProvider \
	CtsShimPrivPrebuilt \
	CtsShimPrebuilt \
	PrintRecommendationService \
	PrintSpooler \
	WallpaperCropper \
	WallpaperPicker \
	WallpaperBackup \
	LiveWallpapersPicker \
	BuiltInPrintService \
	EasterEgg \
	WAPPushManager

  # package module
  # ContactsProvider
  Y_REMOVE_PRODUCT_PACKAGES += \
	BasicDreams \
	Browser2 \
	Camera \
	Calendar \
	CalendarProvider \
	CallLogBackup \
	CellBroadcastReceiver \
	CarrierConfig \
	Contacts \
	Dialer \
	DeskClock \
	DownloadProviderUi \
	DownloadProvider \
	Email \
	EmergencyInfo \
	ExactCalculator \
	Gallery2 \
	Launcher2 \
	Launcher3Go \
	messaging \
	Mms \
	Music \
	MusicFX \
	NfcNci \
	OpenWnn \
	Protips \
	QuickSearchBox \
	SoundRecorder \
	UserDictionaryProvider \
	DocumentsUI \
	FileManager

  # MTK module
  # MtkLauncher3
  # MtkBrowser
  # MtkDownloadProvider
  # MtkDownloadProviderUi
  Y_REMOVE_PRODUCT_PACKAGES += \
	BatteryWarning \
	BtTool \
	Camera2 \
	CalendarImporter \
	CallRecorderService \
	Exchange2 \
	FMRadio \
	LovelyFontContainerService \
	LovelyFonts \
	MDMConfig \
	MDMLSample \
	MtkCalendar \
	MtkCalendarProvider \
	MtkCarrierConfig \
	MtkCellBroadcastReceiver \
	MtkContacts \
	MtkDeskClock \
	MtkDialer \
	MtkEmail \
	MtkEmergencyInfo \
	MtkGallery2 \
	MtkMms \
	MtkNlp \
	MtkWallpaperPicker \
	MusicBspPlus

  # mtk test module
  Y_REMOVE_PRODUCT_PACKAGES += \
	AtciService \
	CDS_INFO \
	MtkTelecomUnitTests

  # third part module
  Y_REMOVE_PRODUCT_PACKAGES += \
	Baidu_Location
  else ifeq (5.1, $(strip $(PLATFORM_VERSION)))
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
	#add by Heaven end
  endif # PLATFORM_VERSION endif
endif # TARGET_BUILD_VARIANT endif
