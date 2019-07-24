#
# Copyright (C) 2007 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

######################################################################
# This is a do-nothing template file.  To use it, copy it to a file
# named "buildspec.mk" in the root directory, and uncomment or change
# the variables necessary for your desired configuration.  The file
# "buildspec.mk" should never be checked in to source control.
######################################################################

# 云智根路径
YUNOVO_ROOT := yunovo

# Zen计划仓库名
YUNOVO_CONFIG := NxCustomConfig
YUNOVO_BUILD  := NxCustomBuild
YUNOVO_RES    := NxCustomResource

# 公共模块
YUNOVO_COMMON := device/common

ifneq ($(TARGET_PRODUCT),)
AFTER_TARGET_PRODUCT := $(strip $(subst full_, $(space), $(TARGET_PRODUCT)))

# 客制化产品
YUNOVO_BOARD = $(shell find device/ -maxdepth 3 -name $(AFTER_TARGET_PRODUCT) | awk -F/ '{print $$2}')

# 客制化产品路径
YUNOVO_DEVICE_P := $(shell dirname `find device/ -name AndroidProducts.mk | egrep $(AFTER_TARGET_PRODUCT)`)
# YUNOVO_DEVICE_P := device/$(YUNOVO_BOARD)/$(TARGET_PRODUCT)
else
$(error "Do not lunch ...")
endif

# 是否为zen平台构建.
ifneq ($(YOV_CUSTOM),)
  ifneq ($(YOV_PROJECT),)
    is_zen_project := true
  else
    is_zen_project :=
  endif
endif

# 客制化路径
ifdef is_zen_project
    YUNOVO_CUSTOM_P := $(YOV_CUSTOM)/$(YOV_PROJECT)
else
    YUNOVO_CUSTOM_P :=
endif

ifdef is_zen_project

# override custom
include  $(YUNOVO_ROOT)/$(YUNOVO_BUILD)/$(YUNOVO_COMMON)/OverrideCustom.mk

# 支持Zen平台配置
-include $(YUNOVO_ROOT)/$(YUNOVO_CONFIG)/$(YUNOVO_CUSTOM_P)/framework.mk
-include $(YUNOVO_ROOT)/$(YUNOVO_CONFIG)/$(YUNOVO_CUSTOM_P)/app.mk

endif

## Common build system definitions.
include $(YUNOVO_ROOT)/$(YUNOVO_BUILD)/$(YUNOVO_COMMON)/definitions.mk