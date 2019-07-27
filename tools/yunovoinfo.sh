#!/bin/bash

# YUNOVO_S:add by yafeng 2017.6.10
if [[ -n "$YUNOVO_PRJ_NAME" ]];then
 echo "ro.yunovo.prj.name=$YUNOVO_PRJ_NAME"
fi

if [[ -n "$YUNOVO_SYSTEM_VERSION_FOTA" ]];then
 echo "ro.nxos.version=$YUNOVO_SYSTEM_VERSION_FOTA"
fi

if [[ -n "$YUNOVO_RELEASE_TAG" ]];then
 echo "ro.release.tag=$YUNOVO_RELEASE_TAG"
fi

if [[ -n "$YUNOVO_RELEASE_TYPE" && "$YUNOVO_RELEASE_TYPE" == "Release" ]];then
 echo "ro.release.type=$YUNOVO_RELEASE_TYPE"
fi
# YUNOVO_E:add by yafeng 2017.6.10
