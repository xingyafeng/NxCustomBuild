# 平台差异模块
# 当增加模块不具支持所有平台时,需要单独以平台为单位增加.
# 若增加模块具有通用性, 此时就需要增加到common/commom.mk 中. <注意>

$(info including $(call my-dir)/$(TARGET_DEVICE).mk ...)

# 增加水印浮窗
PRODUCT_PACKAGES += yunovo-services
PRODUCT_SYSTEM_SERVER_JARS += yunovo-services