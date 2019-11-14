#
# mk26 项目裁剪系统应用
#

$(info including $(call my-dir)/$(strip $(call get_yov_board)).mk ...)

Y_REMOVE_PRODUCT_PACKAGES += \
  NlpService \
  VoiceExtension \
  VoiceCommand \
  MtkCalendar \
  DeskClock

