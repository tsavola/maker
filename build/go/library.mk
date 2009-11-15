include build/common.mk
include build/go/target.mk

ARCHIVE		:= $(NAME).a

O_ARCHIVE	:= $(O)/lib/$(ARCHIVE)

build: build-static
build-static: $(O_ARCHIVE)

$(O_ARCHIVE): $(OBJECTS)
	$(call echo,Archive,$@)
	$(QUIET) mkdir -p $(dir $@)
	$(QUIET) $(AR) crs $@ $(OBJECTS)

install::
	mkdir -p $(DEST_LIBDIR)
	install $(O_ARCHIVE) $(DEST_LIBDIR)/

.PHONY: build build-static
