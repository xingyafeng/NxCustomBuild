#!/bin/bash
#最先生效的文件，初始化一些环境变量

# Add source Flag
export SOURCE_ANDROID=true

# Force JAVA_HOME to point to java 1.7/1.8 if it isn't or is already set.
export ANDROID_SET_JAVA_HOME=true

YOVO_IGNORE_LIBS="mt6735_64 mt6735m_64 mt6735m_gmo mt6753_64 mt6737m mt6737m_64_gmo mt6737m_gmo mt6737t mt6737t_64 mt6737t_gmo"

# 硬件平台 芯片信息
function get-target-board-platform() {

    get_build_var TARGET_BOARD_PLATFORM
}

# BRM 平台
function get-target-brm-platform() {

    get_build_var TARGET_BRM_PLATFORM
}

# build 类型
function get-target-build-variant() {

    get_build_var TARGET_BUILD_VARIANT
}

# android 版本
function get-platform-version() {

    get_build_var PLATFORM_VERSION
}

# sdk 版本
function get-platform-sdk-version() {

    get_build_var PLATFORM_SDK_VERSION
}

# 设备信息
function get-target-device
{
    get_build_var TARGET_DEVICE
}

# 产品信息
function get-target-product() {

    get_build_var TARGET_PRODUCT
}

# 硬件信息
function get-target-hardware() {

    get_build_var TARGET_HARDWARE
}

# 制造商 <制造商的名称>
function get-product-manufacturer() {

    get_build_var PRODUCT_MANUFACTURER
}

# 产品型号 <产品的型号，这也是最终用户将看到的>
function get-product-model() {

    get_build_var PRODUCT_MODEL
}

# 产品名称 <最终用户将看到的完整产品名，会出现在“关于手机”信息中>
function get-product-name() {

    get_build_var PRODUCT_NAME
}

# 产品设备 <该产品的工业设计的名称>
function get-product-device() {

    get_build_var PRODUCT_DEVICE
}

# arm 版本
function get-target-arch() {

    get_build_var TARGET_ARCH
}

# locales <语言环境>
function get-product-locales() {

    get_build_var PRODUCT_LOCALES
}

# 该产品专门定义的商标 (如果有的话)
function get-product-brand() {

    get_build_var PRODUCT_BRAND
}

function get-product-out
{
    get_build_var PRODUCT_OUT
}

function get-device-path() {

    croot
    dirname `find device/ -name AndroidProducts.mk` | egrep -w  $(get-target-device) --color=never
}

function cdevice()
{
    local T=$(gettop)
    local DEVICE_P=$(get-device-path)

    if [[ -n "$T" && -n ${DEVICE_P} ]]; then
        \cd $(gettop)/${DEVICE_P} > /dev/null
    else
        echo "Couldn't locate the top of the tree.  Try setting TOP."
    fi
}

function cout()
{
    local OUT=$(get-product-out)

    if [[ -n "$OUT" ]];then
        \cd $(gettop)/${OUT} > /dev/null
    else
        echo "Couldn't locate the top of the tree.  Try setting TOP."
    fi
}

# lunch default product
function lunch-config() {

    local target_product=
    local target_build_variant=

    if [[ "${SOURCE_ANDROID}" == "true"  ]]; then

        if [[ -f ${OUT}/previous_build_config.mk ]]; then
            target_product="`cat ${OUT}/previous_build_config.mk | grep ^PREVIOUS_BUILD_CONFIG | awk '{ print $3 }' | awk -F '-' '{ print $1 }'`"
            target_build_variant="`cat ${OUT}/previous_build_config.mk | grep ^PREVIOUS_BUILD_CONFIG | awk '{ print $3 }' | awk -F '-' '{ print $2 }'`"
        else
            target_product="$(get-target-product)"
            target_build_variant="$(get-target-build-variant)"
        fi

        if [[ -d .repo && -f build/core/envsetup.mk && -f Makefile ]];then
            if [[ -n "${target_product}" && -n "${target_build_variant}" ]]; then
                lunch "${target_product}"-"${target_build_variant}"
            else
                lunch
            fi
        else
            echo "Couldn't locate ANDRODI_TOP . Please change it."
        fi
    else
        echo "Do not source project ..."
    fi
}

# shell 所在根路径，唯一且固定
function y_get_shell_root_path() { echo "$(gettop)/yunovo/NxCustomBuild/shell_common"; }

# 包含所有定制的辅助函数，目录yunovo/build/shell_common 中所有 sh
function y_include_all_common_shell() {
 local T_S ;local T_SS="`find $(y_get_shell_root_path) -name 'yunovo*.sh'`"
 for T_S in ${T_SS}; do
  echo " include $T_S "
  . ${T_S}
 done
}

function y_get_ignore_libs() {
 local P;local S;
 for P in ${YOVO_IGNORE_LIBS}; do
  S="$S libs.$P.yo"
 done
 echo ${S}
}

#only for android 6.0 , ignore all under libs dir Android.mk yunovo/vendor/eastaeon/libs
#add_lunch_combo
export SCAN_EXCLUDE_DIRS="$(y_get_ignore_libs)"
echo " include yunovo vendorsetup.sh "
y_include_all_common_shell
