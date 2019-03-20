##定制文件拷贝
$(info including $(call my-dir)/custom.mk ...)

YUNOVO_COMMON_P := $(YUNOVO_ROOT)/$(YUNOVO_BUILD)/$(YUNOVO_COMMON)

## 1. 产品目录下 system custom
YUNOVO_SYSTEM_FILES := $(shell if [ -d $(YUNOVO_COMMON_P)/system ]; then cd $(YUNOVO_COMMON_P)/system && find | sed 's%^.\/%%'; fi)
PRODUCT_COPY_FILES  += $(foreach fs, $(YUNOVO_SYSTEM_FILES), $(YUNOVO_COMMON_P)/system/$(fs):system/$(fs))

YUNOVO_CUSTOM_FILES := $(shell if [ -d $(YUNOVO_COMMON_P)/custom ]; then cd $(YUNOVO_COMMON_P)/custom && find | sed 's%^.\/%%'; fi)
PRODUCT_COPY_FILES  += $(foreach fs, $(YUNOVO_CUSTOM_FILES), $(YUNOVO_COMMON_P)/custom/$(fs):custom/$(fs))

## 2. Zen平台下 system custom
YUNOVO_ZEN_P = $(YUNOVO_ROOT)/$(YUNOVO_CONFIG)/$(YUNOVO_CUSTOM_P)
YUNOVO_ZEN_OVERRIDE_P = $(YUNOVO_ZEN_P)/override

YUNOVO_SYSTEM_FILES := $(shell if [ -d $(YUNOVO_ZEN_P)/oem ]; then cd $(YUNOVO_ZEN_P)/oem && find | sed 's%^.\/%%'; fi)
PRODUCT_COPY_FILES  += $(foreach fs, $(YUNOVO_SYSTEM_FILES), $(YUNOVO_ZEN_P)/oem/$(fs):oem/$(fs))

YUNOVO_SYSTEM_FILES := $(shell if [ -d $(YUNOVO_ZEN_P)/custom ]; then cd $(YUNOVO_ZEN_P)/custom && find | sed 's%^.\/%%'; fi)
PRODUCT_COPY_FILES  += $(foreach fs, $(YUNOVO_SYSTEM_FILES), $(YUNOVO_ZEN_P)/custom/$(fs):custom/$(fs))

YUNOVO_SYSTEM_FILES := $(shell if [ -d $(YUNOVO_ZEN_OVERRIDE_P)/system ]; then cd $(YUNOVO_ZEN_OVERRIDE_P)/system && find | sed 's%^.\/%%'; fi)
PRODUCT_COPY_FILES  += $(foreach fs, $(YUNOVO_SYSTEM_FILES), $(YUNOVO_ZEN_OVERRIDE_P)/system/$(fs):system/$(fs))


