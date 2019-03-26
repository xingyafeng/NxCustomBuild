## 克制变量，影响范围:
## 1. yunovo/ 目录下的mk文件
## 2. 单独模块Android.mk文件
## 3. 编译系统Makefile
## 4. 其他未测试

$(info including $(call my-dir)/yunovo.mk ...)

### gps,bt,wifi 自定义的补丁，用于提供给系统查看属性，中间不能有空格
#示例 Px.GPS_Px.BT_WIFI_Px
YUNOVO_BUILD_VERNO =

#示例 0.1.xx_SPLIT_xxx
YUNOVO_SYSTEM_VER = 0.1

# 增加水印浮窗
PRODUCT_PACKAGES += yunovo-services
PRODUCT_SYSTEM_SERVER_JARS += yunovo-services