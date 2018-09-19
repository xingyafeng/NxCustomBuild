# yunovo apps config

##################### Jenkins构建默认编译模块
ifneq ($(strip $(SPT_VERSION_NO)),)

PRODUCT_PACKAGES += \
	YGPS \
	YOcFM \
	CarConfig \
	CarPlatform \
	FactoryTest \
	FileCopyManager \
	CarSystemUpdateAssistant \
	GpsTester \
	GaodeSocol \
	YOcOTA \
	YOcTraffic \
	YOcLogDog \
	CarBandMode

PRODUCT_PACKAGES += yovd init.yunovo.rc libstagefright_soft_mjpeg

## 蓝牙模块,[诚谦|顾凯]
PRODUCT_PACKAGES += blink gocsdk

## 蓝牙主从功能切换
PRODUCT_PACKAGES += \
	libdevicecontrol_client \
	libdevicecontrolservice \
	libyunovo_bluetoothmanager \
	devicecontrol \
	com.yunovo.device.manager

PRODUCT_BOOT_JARS += \
	com.yunovo.device.manager

## 外置GPS模块，目前仅提供给VST使用.
PRODUCT_PACKAGES += \
       libcompass_client \
       libcompassservice \
       compass \
       libyunovogpsmanager

## 千行GPS SDK
PRODUCT_PACKAGES += \
       librtcm

PRODUCT_PACKAGES += libyov lights.$(TARGET_BOARD_PLATFORM)

endif ### SPT_VERSION_NO endif

#####################

###########@@@@ 可选或者必须选一个
## 1.屏保
ifeq ($(strip $(YUNOVO_SCREEN_TYPE)), car_screen)
PRODUCT_PACKAGES += CarScreenSaver
else ifeq ($(strip $(YUNOVO_SCREEN_TYPE)), yoc_screen)
PRODUCT_PACKAGES += YOcScreenSaver
else
PRODUCT_PACKAGES += YOcScreenSaver
endif ### YUNOVO_SCREEN_TYPE endif

## 2. 硬狗
ifeq ($(strip $(YUNOVO_CARDOG_TYPE)), car_dog)
PRODUCT_PACKAGES += CarDog
endif

## 2. 蓝牙电话
ifeq ($(strip $(YUNOVO_BTCALL_TYPE)), bt_call)
PRODUCT_PACKAGES += YOcBTCall
else ifeq ($(strip $(YUNOVO_BTCALL_TYPE)), bt_call_goc)
PRODUCT_PACKAGES += YOcBTCallGoc
else
PRODUCT_PACKAGES += YOcBTCallGoc
endif

ifeq ($(strip $(YUNOVO_BTUPDATE_TYPE)), bt_update)
PRODUCT_PACKAGES += CarUpdateDFU
endif

#########@@@@ 必选项

## 1. 云智主界面模块
ifeq ($(strip $(YUNOVO_LAUNCHER_TYPE)), car_os)
PRODUCT_PACKAGES += CarEngine
PRODUCT_PACKAGES += CarHomeBtn
else ifeq ($(strip $(YUNOVO_LAUNCHER_TYPE)), yoc_os)
PRODUCT_PACKAGES += YOcTools
PRODUCT_PACKAGES += YOcLauncher
PRODUCT_PACKAGES += YOcSplitScreen
PRODUCT_PACKAGES += YOcSettings
else ifeq ($(strip $(YUNOVO_LAUNCHER_TYPE)), newsmy_os)
PRODUCT_PACKAGES += CarEngine
PRODUCT_PACKAGES += CarHomeBtn
else ### YUNOVO_LAUNCHER_TYPE else
ifneq ($(strip $(SPT_VERSION_NO)),)
PRODUCT_PACKAGES += YOcTools
PRODUCT_PACKAGES += YOcLauncher
PRODUCT_PACKAGES += YOcSplitScreen
PRODUCT_PACKAGES += YOcSettings
endif
endif ### YUNOVO_LAUNCHER_TYPE endif

## 2.云智录像模块
ifeq ($(strip $(YUNOVO_RECORD_TYPE)), car_record)
PRODUCT_PACKAGES += CarRecord
else ifeq ($(strip $(YUNOVO_RECORD_TYPE)), car_record_double)
PRODUCT_PACKAGES += CarRecordUsb
PRODUCT_PACKAGES += CarRecordDouble
else ifeq ($(strip $(YUNOVO_RECORD_TYPE)), yoc_record)
PRODUCT_PACKAGES += YOcRecord
PRODUCT_PACKAGES += CarRecordUsb
PRODUCT_PACKAGES += YOcMediaFolder
else ifeq ($(strip $(YUNOVO_RECORD_TYPE)), newsmy_record)
PRODUCT_PACKAGES += NewsmyNewyan
PRODUCT_PACKAGES += NewsmyRecorder
PRODUCT_PACKAGES += NewsmySPTAdapter
PRODUCT_PACKAGES += CarBack
else
PRODUCT_PACKAGES += YOcRecord
PRODUCT_PACKAGES += CarRecordUsb
PRODUCT_PACKAGES += YOcMediaFolder
endif

## 3. 云智语音模块
ifeq ($(strip $(YUNOVO_VOICE_TYPE)), unisound_voice)
PRODUCT_PACKAGES += YOcVoice
PRODUCT_PACKAGES += UniSoundServiceAEC
PRODUCT_PACKAGES += YOcVoiceAssistant
else ifeq ($(strip $(YUNOVO_VOICE_TYPE)), txz_voice)
PRODUCT_PACKAGES += TxzVoice
PRODUCT_PACKAGES += TxzCore
PRODUCT_PACKAGES += YOcVoiceAssistant
else ifeq ($(strip $(YUNOVO_VOICE_TYPE)), aios_voice)
PRODUCT_PACKAGES += AiosAdapterVoice
PRODUCT_PACKAGES += AiosAdapter
PRODUCT_PACKAGES += AiosDaemon
PRODUCT_PACKAGES += YOcVoiceAssistant
PRODUCT_PACKAGES += libandfix libBugly libjpush217 liblasa libmp3lame
PRODUCT_PACKAGES += aios.properties aios.provision wechat.properties
else ifeq ($(strip $(YUNOVO_VOICE_TYPE)), baidu_voice)
PRODUCT_PACKAGES += TxzVoice
PRODUCT_PACKAGES += BaiduCodriver
PRODUCT_PACKAGES += BaiduCustomerNavi
else ifeq ($(strip $(YUNOVO_VOICE_TYPE)), google_voice)
PRODUCT_PACKAGES += GoogleVoice
else
PRODUCT_PACKAGES += AiosAdapterVoice
PRODUCT_PACKAGES += AiosAdapter
PRODUCT_PACKAGES += AiosDaemon
PRODUCT_PACKAGES += YOcVoiceAssistant
PRODUCT_PACKAGES += libandfix libBugly libjpush217 liblasa libmp3lame
PRODUCT_PACKAGES += aios.properties aios.provision wechat.properties
endif

## 4. 输入法
ifeq ($(strip $(YUNOVO_INPUT_TYPE)), sogou_input)
ADDITIONAL_BUILD_PROPERTIES += customer.input.method=com.sohu.inputmethod.sogou/.SogouIME
PRODUCT_PACKAGES += SogoInput
else ifeq ($(strip $(YUNOVO_INPUT_TYPE)), baidu_input)
ADDITIONAL_BUILD_PROPERTIES += customer.input.method=com.baidu.input/.ImeService
PRODUCT_PACKAGES += BaiduInput
else ifeq ($(strip $(YUNOVO_INPUT_TYPE)), google_input)
ADDITIONAL_BUILD_PROPERTIES += customer.input.method=com.google.android.inputmethod.pinyin/.PinyinIME
PRODUCT_PACKAGES += GooglePinyin
else ifeq ($(strip $(YUNOVO_INPUT_TYPE)), pinyin_input)
PRODUCT_PACKAGES += PinyinIME
else ### YUNOVO_INPUT_TYPE else
ADDITIONAL_BUILD_PROPERTIES += customer.input.method=com.google.android.inputmethod.pinyin/.PinyinIME
PRODUCT_PACKAGES += GooglePinyin
endif ### YUNOVO_INPUT_TYPE endif

## 5. 语音微信
ifeq ($(strip $(YUNOVO_WEBCHAT_TYPE)), unisound_webchat)
PRODUCT_PACKAGES += YZSWeChat
else ifeq ($(strip $(YUNOVO_WEBCHAT_TYPE)), aios_webchat)
PRODUCT_PACKAGES += AiosWechat
else ifeq ($(strip $(YUNOVO_WEBCHAT_TYPE)), txz_webchat)
PRODUCT_PACKAGES += TxzWebchat
else
PRODUCT_PACKAGES += AiosWechat
endif

## 6. 音乐
ifeq ($(strip $(YUNOVO_MUSIC_TYPE)), kw_music)
########酷我音乐电台
PRODUCT_PACKAGES += KwPlayer
else ifeq ($(strip $(YUNOVO_MUSIC_TYPE)), txz_music)
#######同行者电台之家
PRODUCT_PACKAGES += TxzAudio
else ifeq ($(strip $(YUNOVO_MUSIC_TYPE)), txz_xmly_music)
#同行者 喜马拉雅电台
PRODUCT_PACKAGES += TxzXimlaya
else ifeq ($(strip $(YUNOVO_MUSIC_TYPE)), unisound_xmly_music)
#云之声 喜马拉雅电台
PRODUCT_PACKAGES += Ximalaya
else ifeq ($(strip $(YUNOVO_MUSIC_TYPE)), aios_music)
#######思必驰音乐
PRODUCT_PACKAGES += AiosMusic
else ifeq ($(strip $(YUNOVO_MUSIC_TYPE)), cyb_music)
########车悦宝电台
PRODUCT_PACKAGES += CheYueBao
else
########车悦宝电台
PRODUCT_PACKAGES += CheYueBao
endif

## 7.电子狗
ifeq ($(strip $(YUNOVO_DOG_TYPE)), anan_edog)
PRODUCT_COPY_FILES += yunovo/packages/apps/AnAnEDog/preinstall.sh:system/bin/preinstall.sh
PRODUCT_COPY_FILES += yunovo/packages/apps/AnAnEDog/AnAnEDog.apk:system/preinstall/AnAnEDog.apk
else ifeq ($(strip $(YUNOVO_DOG_TYPE)), anan_edog_m)
PRODUCT_COPY_FILES += packages/apps/AnAnEDog/preinstall.sh:system/bin/preinstall.sh
PRODUCT_COPY_FILES += packages/apps/AnAnEDog/AnAnEDog.apk:system/preinstall/AnAnEDog.apk
else ifeq ($(strip $(YUNOVO_DOG_TYPE)), anan_edog_ue)
PRODUCT_COPY_FILES += yunovo/packages/apps/AnAnEDogUE/preinstall.sh:system/bin/preinstall.sh
PRODUCT_COPY_FILES += yunovo/packages/apps/AnAnEDogUE/AnAnEDogUE.apk:system/preinstall/AnAnEDogUE.apk
else ifeq ($(strip $(YUNOVO_DOG_TYPE)), anan_edog_ue_m)
PRODUCT_COPY_FILES += packages/apps/AnAnEDogUE/preinstall.sh:system/bin/preinstall.sh
PRODUCT_COPY_FILES += packages/apps/AnAnEDogUE/AnAnEDogUE.apk:system/preinstall/AnAnEDogUE.apk
else ifeq ($(strip $(YUNOVO_DOG_TYPE)), baidu_dog)
PRODUCT_PACKAGES += BaiduGou
else ifeq ($(strip $(YUNOVO_DOG_TYPE)), jlg_dog)
PRODUCT_PACKAGES += JLG-eDOG
endif

## 8.导航
ifeq ($(strip $(YUNOVO_MAP_TYPE)), gaode_customer_map)
#高德车镜版 (注：高德地图不能与同行者语音一起使用)
PRODUCT_PACKAGES += GaodeCustomerMap
else ifeq ($(strip $(YUNOVO_MAP_TYPE)), gaode_car_map)
#高德车机版
PRODUCT_PACKAGES += GaodeCarMap
else ifeq ($(strip $(YUNOVO_MAP_TYPE)), gaode_phone_map)
#高德手机版
PRODUCT_PACKAGES += GaodeMap
else ifeq ($(strip $(YUNOVO_MAP_TYPE)), baidu_customer_map)
#百度定制版，配合百度语音
PRODUCT_PACKAGES += BaiduCustomerNavi
else ifeq ($(strip $(YUNOVO_MAP_TYPE)), baidu_map)
#百度官方导航
PRODUCT_PACKAGES += BaiduNavigation
else ifeq ($(strip $(YUNOVO_MAP_TYPE)), txz_map)
#高德地图，配合同行者语音
PRODUCT_PACKAGES += TxzNavi
else ifeq ($(strip $(YUNOVO_MAP_TYPE)), aios_map)
#图吧地图，配合思必驰语音
PRODUCT_PACKAGES += AiosTubaNav
else
#高德车镜版 (注：高德地图不能与同行者语音一起使用)
PRODUCT_PACKAGES += GaodeCustomerMap
endif

#系统分屏属性
ifeq ($(strip $(YUNOVO_SPLIT_VERSION)), yoc_split_v10)
ADDITIONAL_BUILD_PROPERTIES += yunovo.split.enable=true
ADDITIONAL_BUILD_PROPERTIES += yunovo.navibar.width=124
ADDITIONAL_BUILD_PROPERTIES += yunovo.statusbar.width=0
else ifeq ($(strip $(YUNOVO_SPLIT_VERSION)), yoc_split_v20)
ADDITIONAL_BUILD_PROPERTIES += yunovo.split.enable=true
ADDITIONAL_BUILD_PROPERTIES += yunovo.navibar.width=124
ADDITIONAL_BUILD_PROPERTIES += yunovo.statusbar.width=0
else ifeq ($(strip $(YUNOVO_SPLIT_VERSION)), yoc_split_v21)
ADDITIONAL_BUILD_PROPERTIES += yunovo.split.enable=true
ADDITIONAL_BUILD_PROPERTIES += yunovo.navibar.width=70
ADDITIONAL_BUILD_PROPERTIES += yunovo.statusbar.width=70
else ifeq ($(strip $(YUNOVO_SPLIT_VERSION)), yoc_split_v22)
ADDITIONAL_BUILD_PROPERTIES += yunovo.split.enable=true
ADDITIONAL_BUILD_PROPERTIES += yunovo.navibar.width=100
ADDITIONAL_BUILD_PROPERTIES += yunovo.statusbar.width=0
else ifeq ($(strip $(YUNOVO_SPLIT_VERSION)), yoc_split_v23)
ADDITIONAL_BUILD_PROPERTIES += yunovo.split.enable=true
ADDITIONAL_BUILD_PROPERTIES += yunovo.navibar.width=100
ADDITIONAL_BUILD_PROPERTIES += yunovo.statusbar.width=0
else ifeq ($(strip $(YUNOVO_SPLIT_VERSION)), yoc_split_v24)
ADDITIONAL_BUILD_PROPERTIES += yunovo.split.enable=true
ADDITIONAL_BUILD_PROPERTIES += yunovo.navibar.width=220
ADDITIONAL_BUILD_PROPERTIES += yunovo.statusbar.width=220
else
ADDITIONAL_BUILD_PROPERTIES += yunovo.navibar.width=90
ADDITIONAL_BUILD_PROPERTIES += yunovo.statusbar.width=115
ADDITIONAL_BUILD_PROPERTIES += yunovo.split.enable=true
endif

ifeq ($(filter dumpvar-%,$(MAKECMDGOALS)),)
$(warning "===========================================================")
$(warning "    云智系统APP 定制: ")
$(warning "    1. YUNOVO_LAUNCHER_TYPE = $(YUNOVO_LAUNCHER_TYPE)")
$(warning "    2. YUNOVO_RECORD_TYPE   = $(YUNOVO_RECORD_TYPE)")
$(warning "    3. YUNOVO_VOICE_TYPE    = $(YUNOVO_VOICE_TYPE)")
$(warning "    4. YUNOVO_INPUT_TYPE    = $(YUNOVO_INPUT_TYPE)")
$(warning "    5. YUNOVO_WEBCHAT_TYPE  = $(YUNOVO_WEBCHAT_TYPE)")
$(warning "    6. YUNOVO_MUSIC_TYPE    = $(YUNOVO_MUSIC_TYPE)")
$(warning "    7. YUNOVO_DOG_TYPE      = $(YUNOVO_DOG_TYPE)")
$(warning "    8. YUNOVO_CARDOG_TYPE   = $(YUNOVO_CARDOG_TYPE)")
$(warning "    9. YUNOVO_MAP_TYPE      = $(YUNOVO_MAP_TYPE)")
$(warning "    10.YUNOVO_SCREEN_TYPE   = $(YUNOVO_SCREEN_TYPE)")
$(warning "    11.YUNOVO_BTCALL_TYPE   = $(YUNOVO_BTCALL_TYPE)")
$(warning "    12.YUNOVO_BTUPDATE_TYPE = $(YUNOVO_BTUPDATE_TYPE)")
$(warning "    13.YUNOVO_SPLIT_VERSION = $(YUNOVO_SPLIT_VERSION)")
$(warning "===========================================================")
endif
