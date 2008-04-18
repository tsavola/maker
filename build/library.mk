include build/common.mk
include build/target.mk

LIBRARY		:= lib$(NAME).so.$(VERSION)
LIBRARY_LINK	:= lib$(NAME).so
ARCHIVE		:= lib$(NAME).a

O_LIBRARY	:= $(O)/lib/$(LIBRARY)
O_LIBRARY_LINK	:= $(O)/lib/$(LIBRARY_LINK)
O_ARCHIVE	:= $(O)/lib/$(ARCHIVE)

build: build-shared build-static
build-shared: $(O_LIBRARY)
build-static: $(O_ARCHIVE)
install: install-shared install-static

$(O_LIBRARY): $(PIC_OBJECTS) $(DEPENDS)
	$(call echo,Link,$@)
	$(QUIET) mkdir -p $(dir $@)
	$(QUIET) $(LINKCOMMAND) -fPIC -shared -Wl,-soname,$(LIBRARY) \
		-o $@ $(PIC_OBJECTS) $(LIBS)
	$(QUIET) ln -sf $(LIBRARY) $(O_LIBRARY_LINK)

$(O_ARCHIVE): $(OBJECTS)
	$(call echo,Archive,$@)
	$(QUIET) mkdir -p $(dir $@)
	$(QUIET) $(AR) crs $@ $(OBJECTS)

install-shared:
ifneq ($(wildcard $(O_LIBRARY)),)
	mkdir -p $(DEST_LIBDIR)
	install $(O_LIBRARY) $(DEST_LIBDIR)/
	ln -sf $(LIBRARY) $(DEST_LIBDIR)/$(LIBRARY_LINK)
endif

install-static:
ifneq ($(wildcard $(O_ARCHIVE)),)
	mkdir -p $(DEST_LIBDIR)
	install $(O_ARCHIVE) $(DEST_LIBDIR)/
endif

.PHONY: build build-shared build-static install install-static install-shared
