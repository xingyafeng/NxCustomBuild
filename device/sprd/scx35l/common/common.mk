########add for hyst custom##################################

# 兼容不同版型配置
ifneq ($(strip $(YOV_BOARD)),)
$(call inherit-product-if-exists, $(YUNOVO_ROOT)/$(YUNOVO_BUILD)/$(YUNOVO_DEVICE_P)/$(YOV_BOARD).mk)
endif

####GMS####
ifeq ($(strip $(HYST_GMS_SUPPORT)),true)
$(call inherit-product-if-exists, vendor/google/products/gms.mk)
endif
####GMS####

PRODUCT_PACKAGES += \
    UnreadInfo \
    MMITest

###add by tangzhengyi for VOLTE####
ifeq ($(strip $(VOLTE_SERVICE_ENABLE)), true)
PRODUCT_PACKAGES += ims
PRODUCT_PROPERTY_OVERRIDES += persist.sys.volte.enable=true
endif

###imges-out
ifeq ($(strip $(YUNOVO_CHOOSE_TELECOM_MODEM)),true)
PRODUCT_COPY_FILES += \
	images-out/EXEC_KERNEL_IMAGE0.bin:EXEC_KERNEL_IMAGE0.bin \
	images-out/telecom_modem/LTE_DSP.bin:LTE_DSP.bin \
	images-out/telecom_modem/PM_sharkls_arm7.bin:PM_sharkls_arm7.bin \
	images-out/telecom_modem/SC9600_sharkls_3593_CUST_Base_NV_MIPI.dat:SC9600_sharkls_3593_CUST_Base_NV_MIPI.dat \
	images-out/telecom_modem/SC9600_sharkl_wphy_5mod_volte_zc.bin:SC9600_sharkl_wphy_5mod_volte_zc.bin \
	images-out/telecom_modem/SHARKL_DM_DSP.bin:SHARKL_DM_DSP.bin
else
PRODUCT_COPY_FILES += \
	images-out/EXEC_KERNEL_IMAGE0.bin:EXEC_KERNEL_IMAGE0.bin \
	images-out/LTE_DSP.bin:LTE_DSP.bin \
	images-out/PM_sharkls_arm7.bin:PM_sharkls_arm7.bin \
	images-out/SC9600_sharkls_3593_CUST_Base_NV_MIPI.dat:SC9600_sharkls_3593_CUST_Base_NV_MIPI.dat \
	images-out/SC9600_sharkl_wphy_5mod_volte_zc.bin:SC9600_sharkl_wphy_5mod_volte_zc.bin \
	images-out/SHARKL_DM_DSP.bin:SHARKL_DM_DSP.bin
endif

ifeq ($(strip $(BOARD_TARGET_PROJECT_CTS_TEST)),true)
PRODUCT_PROPERTY_OVERRIDES += persist.sys.cts.hyst=true

ifeq ($(strip $(PRODUCT_RAM)),low)
PRODUCT_PROPERTY_OVERRIDES += persist.ram.low.cts.hyst=true
endif
endif

ifeq ($(strip $(ROCK_GOTA_SUPPORT)),yes)
PRODUCT_PROPERTY_OVERRIDES += ro.rock.gota.enable=true
PRODUCT_PACKAGES += \
	uafs \
	flash_image_gmobi \
	scripter_gmobi
endif

ifeq ($(STORAGE_PRIMARY), internal)
	PRODUCT_PROPERTY_OVERRIDES += ro.hyst.storage.internal=true
endif

ifneq ($(strip $(PAC_SOURCE_FILE_DIR)),)
PAC_SOURCE_FILE_DIR_TRIM=$(strip $(PAC_SOURCE_FILE_DIR))

COPY_FILES := $(shell ls $(BOARDDIR)/$(PAC_SOURCE_FILE_DIR_TRIM))

ifdef is_zen_project
PAC_LOGO_BMP := $(shell ls $(YUNOVO_ROOT)/$(YUNOVO_CONFIG)/$(YUNOVO_CUSTOM_P)/logo | grep "logo.bmp")
else
PAC_LOGO_BMP := $(shell ls $(BOARDDIR)/$(PAC_SOURCE_FILE_DIR_TRIM) | grep ".bmp")
endif

ifeq ($(PAC_LOGO_BMP),)
PAC_LOGO_BMP := $(shell ls $(BOARDDIR)/$(PAC_SOURCE_FILE_DIR_TRIM) | grep ".bmp")
endif

PAC_NVITEM_VERSION := $(shell ls $(BOARDDIR)/$(PAC_SOURCE_FILE_DIR_TRIM) | grep ".bin")
PAC_CONFIG_XML := $(shell ls $(BOARDDIR)/$(PAC_SOURCE_FILE_DIR_TRIM) | grep ".xml")

###copy file to out
ifdef is_zen_project
PRODUCT_COPY_FILES += \
  $(BOARDDIR)/$(PAC_SOURCE_FILE_DIR_TRIM)/$(PAC_NVITEM_VERSION):$(PAC_NVITEM_VERSION) \
  $(BOARDDIR)/$(PAC_SOURCE_FILE_DIR_TRIM)/$(PAC_CONFIG_XML):SC9832 \
  $(YUNOVO_ROOT)/$(YUNOVO_CONFIG)/$(YUNOVO_CUSTOM_P)/logo/$(PAC_LOGO_BMP):logo.bmp \
  $(BOARDDIR)/SharkLS5ModeMarlinAndroid5.1.xml:$(PRODUCT_OUT)/SharkLS5ModeMarlinAndroid6.0.xml
else
PRODUCT_COPY_FILES += \
  $(BOARDDIR)/$(PAC_SOURCE_FILE_DIR_TRIM)/$(PAC_NVITEM_VERSION):$(PAC_NVITEM_VERSION) \
  $(BOARDDIR)/$(PAC_SOURCE_FILE_DIR_TRIM)/$(PAC_CONFIG_XML):SC9832 \
  $(BOARDDIR)/$(PAC_SOURCE_FILE_DIR_TRIM)/$(PAC_LOGO_BMP):logo.bmp \
  $(BOARDDIR)/SharkLS5ModeMarlinAndroid5.1.xml:$(PRODUCT_OUT)/SharkLS5ModeMarlinAndroid6.0.xml
endif

PRODUCT_PROPERTY_OVERRIDES += ro.hyst.nvitem.name=$(PAC_NVITEM_VERSION)
else
PRODUCT_PROPERTY_OVERRIDES += ro.hyst.nvitem.name=Unknow

#copy partition info xml
PRODUCT_COPY_FILES += $(BOARDDIR)/SharkLSGLobalMarlinAndroid5.1.xml:$(PRODUCT_OUT)/SharkLSGLobalMarlinAndroid5.1.xml \
    $(BOARDDIR)/SharkLS5ModeMarlinAndroid5.1.xml:$(PRODUCT_OUT)/SharkLS5ModeMarlinAndroid5.1.xml
endif

####get git log message
GIT_LOG := $(shell git log -1 2>&1 | tee gitlog)
GIT := $(shell tail -1 gitlog |sed 's/^[ \t]*//g' | tee git_message)
RM_GIT_LOG := $(shell rm -rf gitlog)
####get git log message
