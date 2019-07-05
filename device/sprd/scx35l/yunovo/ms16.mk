# 版型差异
$(info including $(YUNOVO_ROOT)/$(YUNOVO_BUILD)/$(YUNOVO_DEVICE_P)/$(YOV_BOARD).mk ...)

## 默认系统签名
PRODUCT_DEFAULT_DEV_CERTIFICATE := build/target/product/security/testkey

## OEM 分区
BOARD_HAVE_OEM_PARTITION := true