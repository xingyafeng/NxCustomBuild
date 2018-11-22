#!/usr/bin/env bash

## 创建空的pac.ini
function touch_empyt_pac_ini()
{
    if [ -f $IMG/SharkLSGLobalMarlinAndroid6.0.xml ];then
        perl make_package/from_xml_to_ini.pl $IMG/SharkLSGLobalMarlinAndroid6.0.xml
    else
        echo "--- SharkLSGLobalMarlinAndroid6.0.xml file no found."
        return 0
    fi
}

## 创建客制化的pac.ini
function touch_custom_pac_ini()
{
    local ret=""

    if [ -f $tmpfs/pac.ini ];then
        rm $tmpfs/pac.ini
    fi

    if [ -f $BASE_PAC ];then
        cp -vf $BASE_PAC $tmpfs/pac.ini
    fi

    while read line;do

        case $line in

            PAC_CONFILE=)
                ret="SharkLSGLobalMarlinAndroid6.0.xml"
                sed -i "s#${line}#${line}$IMG/$ret#g" $tmpfs/pac.ini
                ;;

            FDL=1@)
                ret="fdl1.bin"
                sed -i "s#${line}#${line}$IMG/$ret#g" $tmpfs/pac.ini
                ;;

            ## 射频参数
            FDL2=1@)
                ret="fdl2.bin"
                sed -i "s#${line}#${line}$IMG/$ret#g" $tmpfs/pac.ini
                ;;

            NV_WLTE=1@)
                ret="nvitem.bin"
                sed -i "s#${line}#${line}$IMG/$ret#g" $tmpfs/pac.ini
                ;;

            PhaseCheck=1@)
                ret="PhaseCheck=1@"
                sed -i "s#${line}#$ret#g" $tmpfs/pac.ini
                ;;

            EraseUBOOT=1@)
                ret="EraseUBOOT=1@"
                sed -i "s#${line}#$ret#g" $tmpfs/pac.ini
                ;;

            ProdNV=1@)
                ret="prodnv.img"
                sed -i "s#${line}#${line}$IMG/$ret#g" $tmpfs/pac.ini
                ;;

            SPLLoader=1@)
                ret="u-boot-spl-16k.bin"
                sed -i "s#${line}#${line}$IMG/$ret#g" $tmpfs/pac.ini
                ;;

            Modem_WLTE=1@)
                ret="SC9600_sharkls_3593_CUST_Base_NV_MIPI.dat"
                sed -i "s#${line}#${line}$IMG/$ret#g" $tmpfs/pac.ini
                ;;

            DSP_WLTE_LTE=1@)
                ret="LTE_DSP.bin"
                sed -i "s#${line}#${line}$IMG/$ret#g" $tmpfs/pac.ini
                ;;

            DSP_WLTE_GGE=1@)
                ret="SHARKL_DM_DSP.bin"
                sed -i "s#${line}#${line}$IMG/$ret#g" $tmpfs/pac.ini
                ;;

            WARM_WLTE=1@)
                ret="SC9600_sharkl_wphy_5mod_volte_zc.bin"
                sed -i "s#${line}#${line}$IMG/$ret#g" $tmpfs/pac.ini
                ;;

            DFS=1@)
                ret="PM_sharkls_arm7.bin"
                sed -i "s#${line}#${line}$IMG/$ret#g" $tmpfs/pac.ini
                ;;

            FDL_WCN=1@)
                ret="fld_wcn.bin"
                sed -i "s#${line}#${line}$IMG/$ret#g" $tmpfs/pac.ini
                ;;

            Modem_WCN=1@)
                ret="EXEC_KERNEL_IMAGE0.bin"
                sed -i "s#${line}#${line}$IMG/$ret#g" $tmpfs/pac.ini
                ;;

            BOOT=1@)
                ret="boot.img"
                sed -i "s#${line}#${line}$IMG/$ret#g" $tmpfs/pac.ini
                ;;

            Recovery=1@)
                ret="recovery.img"
                sed -i "s#${line}#${line}$IMG/$ret#g" $tmpfs/pac.ini
                ;;

            System=1@)
                ret="system.img"
                sed -i "s#${line}#${line}$IMG/$ret#g" $tmpfs/pac.ini
                ;;

            Oem=1@)
                ret="oem.img"
                sed -i "s#${line}#${line}$IMG/$ret#g" $tmpfs/pac.ini
                ;;

            UserData=1@)
                ret="userdata.img"
                sed -i "s#${line}#${line}$IMG/$ret#g" $tmpfs/pac.ini
                ;;

            BootLogo=1@)
                ret="logo.bmp"
                sed -i "s#${line}#${line}$IMG/$ret#g" $tmpfs/pac.ini
                ;;

            Fastboot_Logo=1@)
                ret="logo.bmp"
                sed -i "s#${line}#${line}$IMG/$ret#g" $tmpfs/pac.ini
                ;;

            Cache=1@)
                ret="cache.img"
                sed -i "s#${line}#${line}$IMG/$ret#g" $tmpfs/pac.ini
                ;;

            FLASH_WLTE=1@)
                ret="FLASH_WLTE=1@"
                sed -i "s#${line}#$ret#g" $tmpfs/pac.ini
                ;;

            EraseMisc=1@)
                ret="EraseMisc=1@"
                sed -i "s#${line}#$ret#g" $tmpfs/pac.ini
                ;;

            Persist=1@)
                ret="persist.img"
                sed -i "s#${line}#${line}$IMG/$ret#g" $tmpfs/pac.ini
                ;;

            SysInfo=1@)
                ret="sysinfo.img"
                sed -i "s#${line}#${line}$IMG/$ret#g" $tmpfs/pac.ini
                ;;

            UBOOTLoader=1@)
                ret="u-boot.bin"
                sed -i "s#${line}#${line}$IMG/$ret#g" $tmpfs/pac.ini
                ;;

            *)
                :
                ;;
        esac
    done < $BASE_PAC

    # 备份pac.ini
    cp -vf $tmpfs/pac.ini $TARGET_PAC_OUT
}

## 创建pac.ini
function touch_pac_ini()
{
    touch_empyt_pac_ini
    touch_custom_pac_ini
}

## 配置路径
function setpacpaths()
{
     local T=$(pwd)

     if [ ! "$T"  ]; then
         echo "Couldn't locate the top of the tree. Try setting TOP."
         return
     fi

     # android 根路径
     ANDROID_ROOT_PATH=$T

     # PAC制作成品路径
     TARGET_PAC_OUT=$T/release_images/$PRODUCT_BRAND

     # 编译项目名称
     BUILD_PROJECT=${TARGET_BOARD}-${TARGET_BUILD_VARIANT}

     # PAC脚本路径
     PAC_ENV_SCRIPT=$T/make_package
}

## 设置环境变量,为制作pac包
function set_pac_for_environment()
{
    setpacpaths
}

## 拿到PAC版本号
function get_pac_version()
{
    V=`date +%V`
    V=`expr $V + 1`

    if [ $V -lt 10  ];then
        V=`echo "0$V"`
    fi

    if [ -z "$JOB_NAME"  ];then
        PACVER=MorcorDroid_`date +W%g.$V.%u-%H%M%S`
    else
        PACVER=${JOB_NAME}_`date +W%g.$V.%u-%H%M%S`
    fi

    #echo "PACVER = $PACVER"
}

function get_pac_command()
{
    local command=""

    command="/usr/bin/perl ${PAC_ENV_SCRIPT}/pac_via_conf.pl $TARGET_PAC_OUT/${BUILD_PROJECT}-native_${PROJ_TYPE}.pac $PACVER  $tmpfs/pac.ini"

    PAC_COMMAND=$command
}

## 制作pac包
function makepac()
{
    local start_time=$(date +"%s")
    local end_time=$(date +"%s")
    local tdiff=$(($end_time-$start_time))
    local hours=$(($tdiff / 3600 ))
    local mins=$((($tdiff % 3600) / 60))
    local secs=$(($tdiff % 60))
    local ncolors=$(tput colors 2>/dev/null)
    local ret=""

    get_pac_version
    get_pac_command

    ${PAC_COMMAND} "${PROJ_TYPE}"
    ret=$?

    if [ -n "$ncolors"  ] && [ $ncolors -ge 8  ]; then
        color_failed=$'\E'"[0;31m"
        color_success=$'\E'"[0;32m"
        color_reset=$'\E'"[00m"
    else
        color_failed=""
        color_success=""
        color_reset=""
    fi

    if [ $ret -eq 0  ] ; then
        echo -n "${color_success}#### make pac completed successfully "
    else
        echo -n "${color_failed}#### make pac failed to package some targets "
    fi

    if [ $hours -gt 0  ] ; then
        printf "(%02g:%02g:%02g (hh:mm:ss))" $hours $mins $secs
    elif [ $mins -gt 0  ] ; then
        printf "(%02g:%02g (mm:ss))" $mins $secs
    elif [ $secs -gt 0  ] ; then
        printf "(%s seconds)" $secs
    fi

    echo " ####${color_reset}"
    echo

    return $ret
}

function main()
{
    local OUT=$1
    local DEVICE=$2/$3
    local TARGET_BOARD=$3
    local PRODUCT_BRAND=$4

    local TARGET_PAC_OUT=""
    local ANDROID_ROOT_PATH=""
    local PAC_ENV_SCRIPT=""
    local BUILD_PROJECT=""
    local PROJ_TYPE="PacParam"

    ## pac版本
    local PACVER=""

    ## pac 打包命令行
    local PAC_COMMAND=""

    local tmpfs=~/.tmpfs
    local BASE_PAC=pac.ini
    local IMG=release_images/$PRODUCT_BRAND

    if [ ! -d $tmpfs ]; then
        mkdir -p $tmpfs
    fi

    set_pac_for_environment
    touch_pac_ini
    makepac
}

main $@
