## 跨平台配置

$(info including $(call my-dir)/common.mk ...)

## 默认打开odex (user)
ifeq ($(TARGET_BUILD_VARIANT),user)
WITH_DEXPREOPT := true
WITH_DEXPREOPT_PIC := true
else
WITH_DEXPREOPT := false
WITH_DEXPREOPT_PIC := false
endif

## 广深OTA脚本路径. FOTA_SH用于区非zen平台.原路径:yunovo/packages/apps/AdupsFotaApp
FOTA_SH := yunovo/NxCustomResource/system/apk/AdupsFotaApp
