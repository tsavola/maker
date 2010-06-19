include build/common.mk
include build/target.mk

PLUGIN		:= $(NAME).so
O_PLUGIN	:= $(O)/plugin/$(PLUGIN)

build: $(O_PLUGIN)

$(O_PLUGIN): $(PIC_OBJECTS) $(DEPENDS)
	$(call echo,Link,$@)
	$(QUIET) mkdir -p $(dir $@)
	$(QUIET) $(LINKCOMMAND) -fPIC -shared -o $@ $(PIC_OBJECTS) $(LIBS)

install::
	mkdir -p $(DEST_PLUGINDIR)
	install $(O_PLUGIN) $(DEST_PLUGINDIR)/

.PHONY: build
