include build/common.mk
include build/target.mk

LIBRARY		:= lib$(NAME).so.$(VERSION)
LIBRARY_LINK	:= lib$(NAME).so

ARCHIVE		:= lib$(NAME).a

build: build-shared build-static
build-shared: $(O)/lib/$(LIBRARY)
build-static: $(O)/lib/$(ARCHIVE)

$(O)/lib/$(LIBRARY): $(PIC_OBJECTS) $(DEPENDS)
	$(call echo,Link,$@)
	$(QUIET) mkdir -p $(dir $@)
	$(QUIET) $(LINKCOMMAND) -fPIC -shared -Wl,-soname,$(LIBRARY) \
		-o $@ $(PIC_OBJECTS) $(LIBS)
	$(QUIET) chmod -x $@
	$(QUIET) ln -sf $(LIBRARY) $(O)/lib/$(LIBRARY_LINK)

$(O)/lib/$(ARCHIVE): $(OBJECTS)
	$(call echo,Archive,$@)
	$(QUIET) mkdir -p $(dir $@)
	$(QUIET) $(AR) crs $@ $(OBJECTS)

install:
	mkdir -p $(DEST_LIBDIR)
	cp $(O)/lib/$(LIBRARY) $(DEST_LIBDIR)/
	cp $(O)/lib/$(ARCHIVE) $(DEST_LIBDIR)/
	chmod 644 $(DEST_LIBDIR)/$(LIBRARY)
	chmod 644 $(DEST_LIBDIR)/$(ARCHIVE)
	ln -sf $(LIBRARY) $(DEST_LIBDIR)/$(LIBRARY_LINK)

.PHONY: build build-shared build-static install
