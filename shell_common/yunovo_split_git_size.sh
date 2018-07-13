#!/bin/bash
# 拆分仓库使用，通常不需要使用该脚本

# 0为执行成功   其余为失败
# 大量运用 || && 来节约行数， false||执行这里的指令， true && 不执行这里的指令

#echo " dir $0 "
#导入共用函数

#GT为 git仓库路径
#PT为要处理的相对路径，合在一起为完整路径

function GIT_IGNORE() { echo ".gitignore"; }
function YO_MVTO() { echo "yunovo"; }

# 判断是否执行命令调试，即只输出命令
function yovo_if_debug_cmd(){
 local CMD=$1;
 for ARG in $@;do #任意参数均可
  case "$ARG" in
   -realrun)  echo "$CMD";return;;
  esac
 done
 echo "echo $CMD"
}

#忽略ln链接文件，但不忽略文件夹
function y_add_ignore_lk_not_dir() {
 local GT="$1/.git"
 local IGFILE="$1/$(GIT_IGNORE)"
 #充分利用git的 .gitignore 语法， 忽略  /目录 但不忽略 !目录/ 即可达到对link文件识别，如果不是一个link文件，则是文件夹，其下面肯定会有内容
 local LKFILE="$2";
 local NODIR="!$2/";
 
 # 如果存在 .git 目录，此时再添加 可能会晚了，因为可能已经添加进去了，如果要强制添加，需修改脚本
 # 存在 才执行 && 后的
 yunovo_is_path_exist "$GT" && du -hs "$GT" ; return $?
 # 空参数则 返回
 yunovo_is_empty "$LKFILE" "ignore" && return $?
 # 不存在返回
 yunovo_is_path_exist "$1" ||  return $?
 if [ -f "$IGFILE" ]; then
  #echo " add ignore $LKFILE , $NODIR to $1 "
  while read -r line || [ -n "$line" ] ; do
   #echo "read $line";
   if [ x"$NODIR" == x"$line" ]; then
    NODIR="";
   elif [ x"$LKFILE" == x"$line" ] ; then
    LKFILE="";
   fi
  done < "$IGFILE"
 fi
 #echo " $LKFILE , $NODIR "
 if [ "x" != x"${LKFILE}" ]; then
  echo " write $LKFILE to $IGFILE ";
  echo "$LKFILE" >> "$IGFILE"
 fi
 if [ "x" != x"${NODIR}" ]; then
  echo " write $NODIR to $IGFILE ";
  echo "$NODIR" >> "$IGFILE"
 fi
 #此时git不一定已经建立，因此无法使用git指令
 #git --git-dir=$1 ignore $2
 #cd $1
 #git ignore $2
 #git ignore !$2/
 #cd -
}
#add_ignore . docs

function yovo_do_ln(){
 local fromPath="$1"
 local toDir="$2"
 local LN=$(yovo_if_debug_cmd "ln -r -s" "$3")
 local RM=$(yovo_if_debug_cmd "rm -i" "$3")
 #只要目标存在，并且当前不是链接，就得删掉当前文件重建
 if [ -d "$toDir" ] && [ ! -L "$fromPath" ]; then
  echo " $fromPath is not exsits or not an symbolic link , rm and ln -s $3$toDir $fromPath   "
  $RM "$fromPath"
  $LN "$toDir" "$fromPath"
  return 0
 fi
 return -1
}

#参数： 路径 ，要处理的文件夹名，[可选，文件夹名前公共路径部分]
function yovo_do_split(){
 local fromPath="$1/$2"
 local toDir="$(YO_MVTO)/$fromPath"
 local gpath="$toDir/.git"
 #第三个参数位是否真正执行
 local MV=$(yovo_if_debug_cmd "mv -i" "$3")
 local RM=$(yovo_if_debug_cmd "rm -ir" "$3")
 local MKDIR=$(yovo_if_debug_cmd "mkdir -p" "$3")

 #只忽略固定目录，防止误忽略
 yovo_add_ignore_lk_not_dir "$1" "$2"
 # 要移动的如果已经是软链接，代表已经处理了
 # 如果不是一个目录，则有问题，也尝试重新软连下
 if [ -L "$fromPath" ] ; then
   echo " symbolic link $fromPath exsits "
   ls -l "$fromPath"
   ls "$fromPath/"
   return
 elif [ ! -d "$fromPath" ] ; then
  #不是目录有可能是文件或者其他的非link文件，需要重建
  ttt=$(yovo_do_ln "$fromPath" "$toDir" $3)
  #echo " $? , $ttt "
  if [ -z "$ttt" ] ;then
   echo " dir $fromPath not exsits "
  fi
  return
 fi
 echo " move $fromPath to $toDir "
 #git 是否存在无影响，但是输出一下信息以便提醒
 if [ ! -d "$gpath" ] ; then
  echo " git dir $gpath not exsits "
 fi
 #目标文件夹不存在则创建
 if [ ! -d "$toDir" ] ; then
  $MKDIR "$toDir"
 fi
 #移动目录下的所有文件，防止移动软链接过去或者已有软链接但目标无内容
 $MV "$fromPath"/* "$toDir"
 #如果移动目录下内容，则移动完需强制删除空目录，否则不需要
 #echo  " $fromPath dir `ls -l $fromPath` "
 $RM "$fromPath"
 yovo_do_ln "$fromPath" "$toDir" "$3"
}

# 打印现有的 .gitignore
function y_print_all_split_git_gitignore() {
 local P
 for P in $(y_print_all_static_split_git_base_path); do
  # git 仓库打印统计的大小
  yunovo_is_path_exist "$P/.git" && du -hs "$P/.git"
  echo " ---- $P/$(GIT_IGNORE) ---- "
  cat $P/$(GIT_IGNORE)
  echo " --------------------- "
 done
}

# 清理拆分仓库导致的 .gitignore ，如果有别的东西写入会导致误删，清理前最好先查看下
function yovo_clean_all_split_git_gitignore() {
 for P in $(y_print_all_static_split_git_base_path); do
  rm -i $P/$(GIT_IGNORE)
 done
}

# 获取指定路径的相对路径，指定路径需存在，否则会出问题
function yovo_get_relative_path() {
 local RP;local ROOT;local OGN_PATH="$PWD"
 cd / ; ROOT="$PWD" ; cd - > /dev/null ;
 cd $OGN_PATH/$1
 #echo "** $ROOT ** $OGN_PATH ** $PWD **"
 while [ "$OGN_PATH"x != "$PWD"x ] && [ "$ROOT"x != "$PWD"x ]; do 
  cd .. ; RP="../$RP"
  #echo "--- $PWD  --- $RP ---"
 done;
 cd $OGN_PATH
 echo " $RP "
}

# 添加忽略目录，遍历第二个参数依次添加
# 参数  git 仓库目录相对路径 ， 要处理的文件夹名 ， [可选，文件夹名前缀，和文件夹名拼接到一起]
function yovo_add_ignore_lk_not_dir() {
 local GIT_P=$1;local VAL=$2;local PRE=$3;
 # 存在 不执行 || 后的
 yunovo_is_path_exist "$GIT_P" || echo "add ignore fail." ; return $?
 for P in $VAL; do
  y_add_ignore_lk_not_dir "$GIT_P" "$PRE$P"
 done
}

# 批量拆分仓库，加参数 -d ，否则只是打印出命令不真正执行
function yovo_split_main() {
 #echo " yovo_split_main "
 local P;local LEN=${#YOVO_SPLIT_GIT[@]}
 #可根据情况忽略，此处目的是考虑防止多次调用，如果先建立了保存目录，则可能是已经拆分好的
 yunovo_is_path_exist "$(YO_MVTO)" || return $?
 #echo " LEN $LEN "
 for(( LEN -= 1 ; LEN >= 0 ; LEN-- )); do
  #批量添加忽略到.gitignore里
  #yovo_add_ignore_lk_not_dir "${YOVO_SPLIT_GIT[$LEN]}" "${YOVO_SPLIT_GIT_DIR[$LEN]}" "${YOVO_SPLIT_GIT_SUF[$LEN]}" $1
  for P in ${YOVO_SPLIT_GIT_DIR[$LEN]};do
   #yovo_get_relative_path "${YOVO_SPLIT_GIT[$LEN]}/${YOVO_SPLIT_GIT_SUF[$LEN]}$P" $1
   yovo_do_split "${YOVO_SPLIT_GIT[$LEN]}" "${YOVO_SPLIT_GIT_SUF[$LEN]}$P" $1
  done
 done
}

# 打印指定下标拆分仓库的状态，便于查看原因
function yovo_print_split_git() {
 local P;local P1;local LEN=$1
 yunovo_is_illegal_split_len "$LEN" "len" && return $?
 echo " !!!!!!xxxxxxx!!!!!!!! ${YOVO_SPLIT_GIT[$LEN]} !!!!!!!!xxxxxxxxxxx!!!!!! "
 for P in ${YOVO_SPLIT_GIT_DIR[$LEN]};do
  P="${YOVO_SPLIT_GIT[$LEN]}/${YOVO_SPLIT_GIT_SUF[$LEN]}$P"
  P1="`YO_MVTO`/$P"
  if [ -d "$P" ];then
   echo "dir : $P";ls -a "$P"|head -n 6|tr '\n' ' ';echo 
  elif [ -L "$P" ];then
   echo " ok : $P";ls -l "$P"
  else
   echo "fail: $P";ls -a "$P"|head -n 6|tr '\n' ' ';echo 
  fi
  if [ -d "$P1" ];then
   echo " ok : $P1";ls -a "$P1"|head -n 6|tr '\n' ' ';echo 
  else
   echo " $P1";ls -l "$P1"
  fi
  # 原为链接，后为目录，则代表完好
  # 原为目录，后也为目录，则代表有可能有问题，或者是没有分仓库
  # 原存在，后不存在，则可能没建立
  if [ -L "$P" ] && [ -d "$P" ] ;then
   echo " -------good------- "
  elif [ -d "$P" ] && [ -d "$P" ] ;then
   echo "********NOT GOOD******maybe not split******** "
  elif [ -d "$P" ] && [ ! -d "$P1" ] ;then
   echo " ----- ogn ----- "
  else
   echo "****** other ***** "
  fi
  echo ; echo 
 done
}

# 所有客制化目录内容提交
function yunovo_add_commit_all_split_git() {
 local LEN=${#YOVO_SPLIT_GIT[@]}
 for(( LEN -= 1 ; LEN >= 0 ; LEN-- )); do
  for P in ${YOVO_SPLIT_GIT_DIR[$LEN]};do
   P=$(YO_MVTO)/${YOVO_SPLIT_GIT[$LEN]}/${YOVO_SPLIT_GIT_SUF[$LEN]}$P
   if [ -d $P ];then
    cd "$P" ; pwd
    git add -A;git commit -am "init eastaeon mtk 6735t code baseline"
    cd -
   fi
  done
 done
}

# 打印所有拆分仓库的状态，便于查看原因
function y_print_all_split_git() { yovo_for_each_split_dir "" "" "" "yovo_print_split_git"; }

# 移动相关目录并得到空分支进行提交
function yovo_split_this_git() {
 local LEN=$1
 # 已经提交的需要新分支，没有提交的走常规流程
 git ls-tree HEAD:${YOVO_SPLIT_GIT_SUF[$LEN]}$P
 #git checkout --orphan yunovo/tmp
 for P in ${YOVO_SPLIT_GIT_DIR[$LEN]}; do
  #回到根目录执行，当前目录下不支持直接执行
  cd $(gettop)
  yovo_do_split "${YOVO_SPLIT_GIT[$LEN]}" "${YOVO_SPLIT_GIT_SUF[$LEN]}$P" $2
  cd - > /dev/null
  # 切换到拷贝仓库执行相关动作
  if [ -d "$(gettop)/$(YO_MVTO)/${YOVO_SPLIT_GIT[$LEN]}/${YOVO_SPLIT_GIT_SUF[$LEN]}$P" ];then
   cd $(gettop)/$(YO_MVTO)/${YOVO_SPLIT_GIT[$LEN]}/${YOVO_SPLIT_GIT_SUF[$LEN]}$P
   pwd
   ls -a 
   cd - > /dev/null
  fi
 done
 yovo_print_split_git "$LEN"
 git add .gitignore
 git clean -fx
 git add -A ; git commit -am "init eastaeon mtk 6735t code baseline"
 git branch -av
}

# 在已经提交并存在的仓库上拆分仓库
function y_do_split_this_git() {
 #确定处于哪个库上
 local LEN=0; local LST="$(y_print_all_static_split_git_base_path)"
 #echo " -- ${#PWD} -- ${PWD} -- ${PWD:${#PWD}-5} -- "
 for P in $LST; do
  #echo " ${#P} -- ${PWD:${#PWD}-${#P}} "
  # 找到库开始拆分
  if [ "$P"x == "${PWD:${#PWD}-${#P}}"x ]; then
    echo " $P -- ${YOVO_SPLIT_GIT[$LEN]} -- ${YOVO_SPLIT_GIT_SUF[$LEN]} -- "
    yovo_split_this_git "$LEN" "$1"
    break
  fi
  ((LEN++))
 done
 echo " split $LEN git "
}

function yovo_link_dir_show() {
 local P=$1;local TAG=$2;
 if [ -d "$P" ]; then
  echo " --- $TAG $P --- "
  ls -a "$P"|head -n 6|tr '\n' ' ';echo 
 elif [ -L "$P" ];then
  echo " --- $TAG $P --- "
  ls -la "$P"
 else
  echo " $TAG -- $(file $P)"
  return -1
 fi
 return 0
}

# 把客制化目录移回 原目录。（源目录有软链接删除，如果原目录有目录，则提示手动处理）
# 客制化目录不删除，且如果有.git就移动回去
function yovo_mv_dst_to_src_split_dir() {
 local REP;local SWP;local DOLN;local SRC;local DST;local P;local LEN;
 for ARG in $@; do #任意位置的参数均可
  case "$ARG" in
   -r|-repart) echo " repart project ";REP=$ARG;;
   -s|-swap) echo " swap src dst ";SWP=$ARG;;
   -l|-ln) echo " link src to dst ";DOLN=$ARG;;
  esac
 done
 #第三个参数位是否真正执行
 local MV=$(yovo_if_debug_cmd "mv" $@)
 local RM=$(yovo_if_debug_cmd "rm -i" $@)
 local MKDIR=$(yovo_if_debug_cmd "mkdir" $@)
 local LN=$(yovo_if_debug_cmd "ln -s -r" $@)
 for P in $(y_print_all_src_split_dir_path); do
  #要移动的目录
  SRC="$(YO_MVTO)/$P"
  DST="$P"
  #重复目标
  if [ -n "$REP" ];then
   SRC="$SRC/$(basename $SRC)"
  fi
  #交换目标与源
  if [ -n "$SWP" ];then
   DST=$SRC
   SRC=$P
  fi
  if [ -d "$SRC" ];then
   # 目标位置如果软链接，直接删除即可
   if [ -L "$DST" ];then
    echo " remove link "
    $RM "$SRC"
   fi
   #目的位置不存在才可以直接移动操作，否则只显示信息，手动操作
   #if [ ! -x "$DST" ] ; then
    $MKDIR "$DST"
    $MV $SRC/ "$DST/"
    $MV $SRC/.git "$DST/"
    #如果git也移动过去了，就把它移回来, .git有可能是文件或者软连接，忽略类型
    if [ -x "$DST/.git" ] && [ ! -x "$SRC/.git" ];then
     $MV "$DST/.git" "$SRC/.git"
    fi
    #移完扫尾清理目录
    echo "remove mv lost dir"
    $RM -r "$SRC"
    if [ -n "$DOLN" ] ; then
     $LN "$DST" "$(dirname $SRC)"
    fi
    continue
   #else
   # echo "maybe run mv $DST/.git $SRC/.git"
   #fi
  fi
  #源
  yovo_link_dir_show "$SRC" "src"
  yovo_link_dir_show "$DST" "dst"
  echo
 done
}

function yovo_print_repeat_dir(){
 local CMD=${1:-y_print_all_dst_split_dir_path}
 for P in $($CMD); do
  echo $P/$(basename $P)
 done
}

# 把 原目录 移到 客制化目录。（源目录如果为软连接，则提示手动处理）
function yovo_mv_src_to_dst_split_dir() {
 yovo_mv_dst_to_src_split_dir "-swap" "-ln" $@
}