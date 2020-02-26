
# ########################################################################  by baiwei

# 提供给应用的FM扩展库
$(warnig "DHF YUNOVO_EXT_FM=$(YUNOVO_EXT_FM)")
ifeq ($(strip $(YUNOVO_EXT_FM)),yes)
ADDITIONAL_BUILD_PROPERTIES += yov.sys.extfm_enable=true
PRODUCT_PACKAGES += libextFm_jni_fm_omr1
endif