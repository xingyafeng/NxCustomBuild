
# ########################################################################  by baiwei

# 提供一些给APP层面使用的接口和一些调试功能
PRODUCT_PACKAGES += YOcCoreServer

# wilber start #{
# 共享内存服务,提供给摄像头预览数据．
ifeq ($(strip $(YUNOVO_MEDIA_SHAREBUFFER)),yes)
ADDITIONAL_BUILD_PROPERTIES += yov.sys.sharebuffer_enable=true
PRODUCT_PACKAGES += libsharebufferservice
endif
# wilber end #}