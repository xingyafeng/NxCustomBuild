#!/bin/bash

echo
echo "#"
echo "# from yunovoinfo.sh"
echo "#"

# YUNOVO_S:add by yafeng 2017.6.10
if [[ -n "$YUNOVO_PRJ_NAME" ]];then
 echo "ro.yunovo.prj.name=$YUNOVO_PRJ_NAME"
fi

if [[ -n "$YUNOVO_SYSTEM_VERSION_FOTA" ]];then
 echo "ro.nxos.version=$YUNOVO_SYSTEM_VERSION_FOTA"
 echo "ro.yunovo.system.version.fota=$YUNOVO_SYSTEM_VERSION_FOTA"
fi

if [[ -n "$YUNOVO_RELEASE_TAG" ]];then
 echo "ro.release.tag=$YUNOVO_RELEASE_TAG"
fi

if [[ -n "$YUNOVO_RELEASE_TYPE" ]];then
 echo "ro.release.type=$YUNOVO_RELEASE_TYPE"
fi

if [[ -n "${YUNOVO_BUILD_ID}" ]];then
 echo "ro.jenkins.build.id=${YUNOVO_BUILD_ID}"
fi

if [[ -n "${YUNOVO_SIGNATURE_TYPE}" ]]; then
 echo
 echo "# false : 公版签名"
 echo "# true  : 云智签名"
 echo "ro.jenkins.signature.type=${YUNOVO_SIGNATURE_TYPE}"
fi

# YUNOVO_E:add by yafeng 2017.6.10

echo
echo "# end yunovoinfo.sh"
echo