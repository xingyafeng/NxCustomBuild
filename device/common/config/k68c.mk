#
# k68c项目裁剪系统应用
#

$(info including $(call my-dir)/$(strip $(call get_yov_board)).mk ...)

Y_REMOVE_PRODUCT_PACKAGES += \
	  Home \
	  Launcher2 \
	  Launcher3 \
	  DeskClock \
	  Email \
	  Exchange2 \
	  QuickSearchBox \
	  HoloSpiralWallpaper \
	  LiveWallpapers \
	  LiveWallpapersPicker \
	  MagicSmokeWallpapers \
	  Music \
	  MusicFX