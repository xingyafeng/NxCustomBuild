
# ########################################################################  by xiongkaihao

# yovd 后门
PRODUCT_PACKAGES += yovd

# mjpeg
PRODUCT_PACKAGES += libstagefright_soft_mjpeg

# 背光
PRODUCT_PACKAGES += libyov lights.$(TARGET_BOARD_PLATFORM)

# 支持exfat
ifneq ($(strip $(YUNOVO_EXFAT_DISABLE)),true)
ADDITIONAL_BUILD_PROPERTIES += yov.sys.exfat_enable=true

PRODUCT_PACKAGES += libfuse
PRODUCT_PACKAGES += mkfs.exfat  fsck.exfat  mount.exfat  libexfat
PRODUCT_PACKAGES += mkfs.ntfs   fsck.ntfs  mount.ntfs  libntfs-3g fsck.ntfs
endif