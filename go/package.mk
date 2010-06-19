include build/common.mk
include build/go/target.mk

GOPACK		:= gopack

PACKAGE		:= $(NAME).a

O_PACKAGE	:= $(O)/lib/go/$(PACKAGE)

build build-static: $(O_PACKAGE)

$(O_PACKAGE): $(OBJECTS)
	$(call echo,Package,$@)
	$(QUIET) mkdir -p $(dir $@)
	$(QUIET) $(GOPACK) grc $@ $(OBJECTS)

install::
	mkdir -p $(DEST_LIBDIR)/go/
	install $(O_PACKAGE) $(DEST_LIBDIR)/go/

.PHONY: build build-static
