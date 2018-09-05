# 特别的实现
# Y_REMOVE_PRODUCT_PACKAGES  需要移除的原生模块
# PRODUCT_PACKAGES  需要添加的模块
# YUNOVO_BUILD_VERNO 系统补丁版本号
# YUNOVO_SYSTEM_VER 系统版本号

#相对比较靠前生效
$(info including $(call my-dir)/definitions.mk ...)

#以下这句此处无法生效，因为相对靠后了
#SCAN_EXCLUDE_DIRS = "libs.mt6735_64.yo libs.mt6735m_64.yo libs.mt6735m_gmo.yo libs.mt6753_64.yo"

# AndroidProducts.mk  BoardConfig.mk  ProjectConfig.mk

# $(TARGET_DEVICE) = magc6580_we_l  $(TARGET_PRODUCT) = full_magc6580_we_l
# 寻找相应 device 的 mk 文件，常用于 AndroidProducts.mk BoardConfig.mk
define find-dev-platform-mk
$(strip $(wildcard \
  $(shell test -d yunovo/NxCustomBuild/device && find yunovo/NxCustomBuild/device -maxdepth 4 -path '*/$(TARGET_DEVICE)/$(1).mk') \
))
endef

define find-dev-common-mk
$(strip $(wildcard \
  $(shell test -d yunovo/NxCustomBuild/device && find yunovo/NxCustomBuild/device -maxdepth 4 -path '*/$(1).mk') \
))
endef

define get-product-packages
  $(filter $(1)%, $(PRODUCT_PACKAGES))
endef

define get-app-version
  $(subst $(1),,$(2))
endef

YUNOVO_BOARD_LIST := k21 mk21 mk26 mk01 cm01
define get_yov_board
  $(filter $(YOV_BOARD), $(YUNOVO_BOARD_LIST))
endef

define check-yunovo-sing-mk
$(info $(1) = $(words $(1)) )
$(info ${yunovo_board_config_mk} - $(words ${yunovo_board_config_mk}) )
ifneq ($(words $(1)),1)
  $(info  222 Multiple board config files for TARGET_DEVICE $(TARGET_DEVICE): $(1) )
endif
endef

define moved-yunovo-var
$(foreach v,$(1), \
  $(eval $(2)$(v) := $(3)$($(v))) \
  $(eval $(v) := )\
)
endef

define dump-yunovo-var
$(foreach v,$(1), \
  $(info $(2)$(v)=$($(2)$(v)) )\
)
endef

#以下变量集体缓存，待使用完毕还原
_yunovo_cached_var_list := \
PRODUCT_PROPERTY_OVERRIDES \
PRODUCT_PACKAGES

#临时缓存一些原来的值，让使用过程中免受破坏
$(call moved-yunovo-var,$(_yunovo_cached_var_list),YUNOVO_CACHED_)
#$(call dump-yunovo-var,$(_yunovo_cached_var_list))
#$(call dump-yunovo-var,$(_yunovo_cached_var_list),YUNOVO_CACHED_)

## 1. AndroidProducts.mk
yunovo_android_products_mk = $(call find-dev-common-mk,AndroidProducts)
ifeq ($(words $(yunovo_android_products_mk)),1)
  $(info  include AndroidProducts ... )
  -include $(yunovo_android_products_mk)
else ifneq ($(words $(yunovo_board_config_mk)),0)
  $(error  Multiple board config files for TARGET_DEVICE $(TARGET_DEVICE): $(yunovo_android_products_mk))
endif

## 2. BoardConfig.mk
yunovo_board_config_mk = $(call find-dev-platform-mk,BoardConfig)
#$(info  len- $(words ${yunovo_board_config_mk}) - )
#$(check-yunovo-sing-mk,yunovo_board_config_mk)
ifeq ($(words $(yunovo_board_config_mk)),1)
  $(info  include BoardConfig ... )
  -include $(yunovo_board_config_mk)
else ifneq ($(words $(yunovo_board_config_mk)),0)
  $(error  Multiple board config files for TARGET_DEVICE $(TARGET_DEVICE): $(yunovo_board_config_mk))
endif

## 3. ProjectConfig.mk
yunovo_project_config_mk := $(call find-dev-platform-mk,ProjectConfig)
ifeq ($(words $(yunovo_project_config_mk)),1)
  $(info  include ProjectConfig ... )
  -include $(yunovo_project_config_mk)
else ifneq ($(words $(yunovo_board_config_mk)),0)
  $(error Multiple project config files for TARGET_DEVICE $(TARGET_DEVICE): $(yunovo_project_config_mk))
endif

#由于 PRODUCT_PROPERTY_OVERRIDES 本身附加于 ADDITIONAL_BUILD_PROPERTIES 之后，因此此处直接使用最终值
#将自定义属性置于所有属性之前
YUNOVO_BUILD_VERNO := $(strip $(YUNOVO_BUILD_VERNO))
ifneq ($(YUNOVO_BUILD_VERNO),)
 ADDITIONAL_BUILD_PROPERTIES := ro.yunovo.version.release=$(YUNOVO_BUILD_VERNO) $(ADDITIONAL_BUILD_PROPERTIES)
endif
YUNOVO_SYSTEM_VER := $(strip $(YUNOVO_SYSTEM_VER))
ifneq ($(YUNOVO_SYSTEM_VER),)
 ADDITIONAL_BUILD_PROPERTIES := ro.yunovo.system.version=$(YUNOVO_SYSTEM_VER) $(ADDITIONAL_BUILD_PROPERTIES)
endif

#PRODUCT_COPY_FILES += yunovo/device/common/yunovo.md:/system/etc/yunovo.md

## 5. 自定义的模块 PRODUCT_PACKAGES
#格式化变量
PRODUCT_PACKAGES := $(strip $(PRODUCT_PACKAGES))

ifneq ($(PRODUCT_PACKAGES),)
 #排序
 PRODUCT_PACKAGES := $(sort $(PRODUCT_PACKAGES))

 #排重
 PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES := $(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES) $(PRODUCT_PACKAGES)
 #$(warning  PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES = $(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES) )

 $(info  PRODUCT_PACKAGES = $(PRODUCT_PACKAGES) )
else
# 原生系统模块,有:
 $(info  PRODUCT_PACKAGES = $(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES))
endif

## 6. 自定义中删除需要编译的模块 Y_REMOVE_PRODUCT_PACKAGES
#格式化变量值  INTERNAL_PRODUCT  PRODUCTS
Y_REMOVE_PRODUCT_PACKAGES := $(strip $(Y_REMOVE_PRODUCT_PACKAGES))

ifneq ($(Y_REMOVE_PRODUCT_PACKAGES),)
 #排重
 Y_REMOVE_PRODUCT_PACKAGES := $(sort $(Y_REMOVE_PRODUCT_PACKAGES))
 $(info  Y_REMOVE_PRODUCT_PACKAGES = $(Y_REMOVE_PRODUCT_PACKAGES) )

 #滤除不需要的
 PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES := $(filter-out $(Y_REMOVE_PRODUCT_PACKAGES),$(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES))
 PRODUCT_PACKAGES := $(filter-out $(Y_REMOVE_PRODUCT_PACKAGES),$(PRODUCT_PACKAGES))
 #$(warning  PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES = $(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES) )

 #清空值，后续无需使用
 Y_REMOVE_PRODUCT_PACKAGES :=
endif

# Add the product-defined properties to the build properties.
ADDITIONAL_BUILD_PROPERTIES := \
    $(ADDITIONAL_BUILD_PROPERTIES) \
    $(PRODUCT_PROPERTY_OVERRIDES)

#还原值供以后使用
$(call moved-yunovo-var,$(_yunovo_cached_var_list),,YUNOVO_CACHED_)
#$(call dump-yunovo-var,ADDITIONAL_BUILD_PROPERTIES $(_yunovo_cached_var_list))
#$(call dump-yunovo-var,$(_yunovo_cached_var_list),YUNOVO_CACHED_)
$(call dump-yunovo-var,YUNOVO_BUILD_VERNO YUNOVO_SYSTEM_VER)

#$(warning  PRODUCTS.$(PRODUCTS).PRODUCT_PACKAGES = $(PRODUCTS.$(PRODUCTS).PRODUCT_PACKAGES) )
