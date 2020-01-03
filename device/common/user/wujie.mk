
# ######################################################################## by wujie

# 蓝牙模块支持的版型
ifneq ($(strip $(filter $(call get_yov_board), ck06)), )

# 不支持蓝牙的版型

else

# 蓝牙模块,[诚谦|顾凯]
PRODUCT_PACKAGES += blink gocsdk gocsdks gocsdks_8_1

# 外置GPS模块，目前仅提供给VST使用.
PRODUCT_PACKAGES += \
       libcompass_client \
       libcompassservice \
       compass \
       libyunovogpsmanager

# 千行GPS SDK
PRODUCT_PACKAGES += \
       librtcm

# 蓝牙主从功能切换
PRODUCT_PACKAGES += \
    libdevicecontrol_client \
    libdevicecontrolservice \
    libyunovo_bluetoothmanager \
    libyunovo_devicenodemanager \
    devicecontrol \
    com.yunovo.device.manager

PRODUCT_BOOT_JARS += \
    com.yunovo.device.manager

# 蓝牙服务
PRODUCT_PACKAGES += \
	libbluetooth_client \
	libbluetoothservice \
	yovbt \
	libyunovobt_jni \
	yunovobluetooth

PRODUCT_BOOT_JARS += \
	yunovobluetooth

# 蓝牙协议栈
ifeq ($(shell expr $(PLATFORM_SDK_VERSION) \> 23), 1)

PRODUCT_PACKAGES += yunbluetooth.default

endif # 蓝牙协议栈 endif

endif # 蓝牙支的版型 endif

