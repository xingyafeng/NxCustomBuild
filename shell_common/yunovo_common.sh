#!/bin/bash

#shell 所在根路径，唯一且固定
#function y_get_shell_root_path() { echo "$(gettop)/yunovo/build/shell_common"; }

# TARGET_OUT  PRODUCT_OUT HOST_OUT_EXECUTABLES
#移除所有的 prop ，用于重新编译 prop
function y_rm_all_prop() {
# 6.0 多了 out/target/product/aeon6735_66c_m0/obj/ETC/system_build_prop_intermediates/build.prop
# system/build.prop root/default.prop recovery/root/default.prop
# `get_build_var TARGET_OUT_VENDOR`/build.prop `get_build_var PRODUCT_OUT`/sdk/sdk-build.prop
 local TMP="$(get_build_var TARGET_ROOT_OUT)/build.prop $(get_build_var TARGET_OUT)/build.prop \
 $(get_build_var PRODUCT_OUT)/obj/ETC/system_build_prop_intermediates/build.prop "
 for P in $TMP; do
  if [ -f "$P" ] ; then rm -i $P; fi
 done
}

# 会导致定制化的静态路径，当还未曾创建相关目录时使用
function y_print_all_static_custom_link() {
 cat "$(y_get_shell_root_path)/yovo_cunstom_path.txt" | sort 
}

# 所有拆分的仓库的根目录
YOVO_SPLIT_GIT=(
"frameworks/base"
"vendor/eastaeon/libs"
"vendor/mediatek/proprietary/bootable/bootloader/lk"
)

# 仓库的相对目录，公用部分
YOVO_SPLIT_GIT_SUF=(
""
""
"dev/logo/"
)

# 所有拆分的仓库的根目录对应要拆分的目录
#拆分文档，视频资源 ，二进制库，logo 为单独仓库
YOVO_SPLIT_GIT_DIR=(
"docs media/tests/contents/media_api"
"$YOVO_IGNORE_LIBS"
"cmcc_lte_wvga cmcc_wvga ct_lte_wvga ct_wvga cu_lte_wvga cu_wvga cmcc_fwvga cmcc_lte_fwvga ct_lte_fwvga cu_fwvga cu_lte_fwvga cmcc_lte_qhd cmcc_qhd ct_lte_qhd ct_qhd cu_lte_qhd cu_qhd qvgal qvganl wqvga cmcc_hd720 cmcc_lte_hd720 ct_hd720 ct_lte_hd720 cu_hd720 cu_lte_hd720 qvga cmcc_fhd cmcc_lte_fhd ct_fhd ct_lte_fhd cu_fhd cu_lte_fhd ct_lte_wuxga cu_lte_wuxga cu_wuxga hvga wvgalnl cmcc_lte_wqhd cmcc_wqhd ct_lte_wqhd cu_lte_wqhd cu_wqhd wsvgalnl wsvga wsvganl wvga fwvga xga xganl qhd wxga wxganl hd720 wuxga wuxganl qxga fhd wqxganl wqhd wqxga"
)

# 获得所有拆分的仓库的根目录
function y_print_all_static_split_git_base_path() { echo ${YOVO_SPLIT_GIT[*]}; }

# 判断 路径是否存在，默认判断文件夹
function yunovo_is_path_exist() {
 local P=$1; local O=${2:-d};
 if [ -$O "$P" ]; then #满足标准，执行成功
  return 0
 else
  echo " [$O] $P not exist "
 fi
 return -1
}
# 空串判断，全空格也人为空串， //TODO \t 也要判定为空串
function yunovo_is_empty() {
 local TAG=$2;
 if [ -z "${1// /}" ];then #满足标准，执行成功
  echo " arg \$$TAG is empty "
  return 0
 fi
 return -1
}
# 检测长度是否非法
function yunovo_is_illegal_len() {
 local LEN=$1;local TAG=$2;local MIN=$3;local MAX=$4;
 #空串 则返回，即执行 && 后的
 yunovo_is_empty "$LEN" "$TAG" && return $?
 # 小于 参数3 和 大于等于 参数4 数组上限 
 if [ $LEN -lt $MIN ] || [ $LEN -ge $MAX ];then #满足标准，执行成功
  echo " arg \$$TAG = $LEN must >0 and <${#YOVO_SPLIT_GIT[@]} "
  return 0
 fi
 return -1
}

# 检测长度是否非法
function yunovo_is_illegal_split_len() {
 # 小于0 和 大于等于数组上限 
 yunovo_is_illegal_len "$1" "$2" 0 ${#YOVO_SPLIT_GIT[@]}
 return $?
}

# 大量运用 || && 来节约行数， false||执行这里的指令， true && 不执行这里的指令

# 对指定下标的拆分仓库执行指定命令，严格注意此无脑执行，不校验命令正确性
# 参数：下标，[指定命令字符串(默认echo)，前缀，后缀]
function yunovo_cmd_split_dir() {
 local LEN=$1;local CMD=${2:-echo};local PRE=$3;local SUFFIX=$4;
 #参数非法校验
 yunovo_is_illegal_split_len "$LEN" "len" && return $?
 yunovo_is_empty "$CMD" "cmd" && return $?
 for P in ${YOVO_SPLIT_GIT_DIR[$LEN]};do
  $CMD ${PRE}${YOVO_SPLIT_GIT[$LEN]}/${YOVO_SPLIT_GIT_SUF[$LEN]}$P${SUFFIX}
 done
}

# 对所有拆分仓库执行批量命令 参数: [每个文件夹执行的命令(默认 echo)， 每个仓库执行的命（目前3个默认调用yunovo_cmd_split_dir，前缀，后缀]
function yunovo_for_each_cmd_split_dir() {
 local LEN=${#YOVO_SPLIT_GIT[@]};local CMD=${1:-echo};local PRE=$2;local SUFFIX=$3;local RCMD=${4:-yunovo_cmd_split_dir};
 yunovo_is_empty "$CMD" "cmd" && return $?
 for(( LEN -= 1 ; LEN >= 0 ; LEN-- )); do
  $RCMD "$LEN" "$CMD" "$PRE" "$SUFFIX"
 done
}

# 获得所有准备拆分的目录的根目录
function y_print_all_src_split_dir_path() { yunovo_for_each_cmd_split_dir; }
# 获得所有移动过去准备拆分的目录的根目录
function y_print_all_dst_split_dir_path() { yunovo_for_each_cmd_split_dir "" "yunovo/"; }

# 查找所有定制引发的软链接 ，目前客制化包含 文档，视频资源，闭源二进制库，开机动画和图片
function y_find_all_custom_link() {
 # frameworks/base/prepare-commit-msg 为东拓残留
 local TMP=" vendor/yunovo frameworks/base/docs frameworks/base/media/tests/contents/media_api vendor/eastaeon/libs vendor/mediatek/proprietary/bootable/bootloader/lk/dev/logo "
 find $TMP -maxdepth 1 -type l
}

#清除所有定制化，便于编译出原始系统
function y_clean_custom() {
 rm -i $(gettop)/vendor/yunovo
}