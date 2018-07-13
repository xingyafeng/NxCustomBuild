## update logo.bin  uboot.bmp and kernel.bmp

CUSTOM_P = $(ROOTDIR)/$(YUNOVO_ROOT)/$(YUNOVO_CONFIG)/$(YUNOVO_CUSTOM_P)

.PHONY: update_custom_logo

$(ZPIPE) : update_custom_logo

update_custom_logo: $(wildcard $(CUSTOM_P)/logo/*.bmp)
	@echo "--->  update custom logo end ... "

$(wildcard $(CUSTOM_P)/logo/uboot.bmp) : $(BUILDDIR)/$(filter %_uboot.raw,$(RESOURCE_OBJ_LIST)) $(BUILDDIR)/$(filter %_kernel.raw, $(RESOURCE_OBJ_LIST))
	@echo "---> update uboot.bmp ..."
	$(hide) $(BMP_TO_RAW) $(BUILDDIR)/uboot.raw $@
	$(hide) mv $(BUILDDIR)/uboot.raw $(BUILDDIR)/$(filter %_uboot.raw,$(RESOURCE_OBJ_LIST))
ifeq ($(filter %kernel.bmp, $(wildcard $(CUSTOM_P)/logo/*.bmp)),)
	$(hide) $(BMP_TO_RAW) $(BUILDDIR)/kernel.raw $@
	$(hide) mv $(BUILDDIR)/kernel.raw $(BUILDDIR)/$(filter %_kernel.raw, $(RESOURCE_OBJ_LIST))
endif

$(wildcard $(CUSTOM_P)/logo/kernel.bmp) : $(BUILDDIR)/$(filter %_uboot.raw,$(RESOURCE_OBJ_LIST)) $(BUILDDIR)/$(filter %_kernel.raw, $(RESOURCE_OBJ_LIST))
	@echo "---> update kernel.bmp ..."
ifeq ($(filter %uboot.bmp, $(wildcard $(CUSTOM_P)/logo/*.bmp)),)
	$(hide) $(BMP_TO_RAW) $(BUILDDIR)/uboot.raw $@
	$(hide) mv $(BUILDDIR)/uboot.raw $(BUILDDIR)/$(filter %_uboot.raw,$(RESOURCE_OBJ_LIST))
endif
	$(hide) $(BMP_TO_RAW) $(BUILDDIR)/kernel.raw $@
	$(hide) mv $(BUILDDIR)/kernel.raw $(BUILDDIR)/$(filter %_kernel.raw, $(RESOURCE_OBJ_LIST))
