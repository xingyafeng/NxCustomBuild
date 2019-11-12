#
# Copyright (C) 2008 The Android Open Source Project
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

##
## Common build system definitions.  Mostly standard
## commands for building various types of targets, which
## are used by others to construct the final targets.
##

define get-product-packages
  $(filter $(1)%, $(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES))
endef

define get-product-packages-custom
  $(filter $(1)%, $(PRODUCT_PACKAGES))
endef

define get-app-version
  $(subst $(1),,$(2))
endef

# 蓝牙支持的版型
BT_SUPPORT_BOARD := k21 mk21 mk01 mk26 mk28 ms16 ms18
define is-support-bluetoth
  $(filter $(YOV_BOARD), $(BT_SUPPORT_BOARD))
endef

# 实例
ifeq ($(words $(call is-support-bluetoth)),1)
#表示支持
else ifneq ($(words $(call is-support-bluetoth)),0)
#表示不支持
endif