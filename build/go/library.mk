include build/common.mk
include build/go/target.mk

ARCHIVE		:= $(NAME).a

O_ARCHIVE	:= $(O)/lib/go/$(ARCHIVE)

build: build-static
build-static: $(O_ARCHIVE)

$(O_ARCHIVE): $(OBJECTS)
	$(call echo,Archive,$@)
	$(QUIET) mkdir -p $(dir $@)
	$(QUIET) $(AR) crs $@ $(OBJECTS)

install::
	mkdir -p $(DEST_LIBDIR)/go/
	install $(O_ARCHIVE) $(DEST_LIBDIR)/go/

.PHONY: build build-static
