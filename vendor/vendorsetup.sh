#!/bin/bash
#最先生效的文件，初始化一些环境变量

# Force JAVA_HOME to point to java 1.7/1.8 if it isn't or is already set.
export ANDROID_SET_JAVA_HOME=true

YOVO_IGNORE_LIBS="mt6735_64 mt6735m_64 mt6735m_gmo mt6753_64 mt6737m mt6737m_64_gmo mt6737m_gmo mt6737t mt6737t_64 mt6737t_gmo"

# shell 所在根路径，唯一且固定
function y_get_shell_root_path() { echo "$(gettop)/yunovo/NxCustomBuild/shell_common"; }

# 包含所有定制的辅助函数，目录yunovo/build/shell_common 中所有 sh
function y_include_all_common_shell() {
 local T_S ;local T_SS="`find $(y_get_shell_root_path) -name 'yunovo*.sh'`"
 for T_S in $T_SS; do
  echo " include $T_S "
  . $T_S
 done
}

function y_get_ignore_libs() {
 local P;local S;
 for P in $YOVO_IGNORE_LIBS; do
  S="$S libs.$P.yo"
 done
 echo $S
}

#only for android 6.0 , ignore all under libs dir Android.mk yunovo/vendor/eastaeon/libs
#add_lunch_combo
export SCAN_EXCLUDE_DIRS="$(y_get_ignore_libs)"
echo " include yunovo vendorsetup.sh "
y_include_all_common_shell
