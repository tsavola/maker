include build/common.mk
include build/target.mk

build: $(O)/bin/$(NAME)

$(O)/bin/$(NAME): $(OBJECTS) $(DEPENDS)
	$(call echo,Link,$@)
	$(QUIET) mkdir -p $(dir $@)
	$(QUIET) $(LINKCOMMAND) -o $@ $(OBJECTS) $(LIBS)

install:
	mkdir -p $(DEST_BINDIR)
	cp $(O)/bin/$(NAME) $(DEST_BINDIR)/
	chmod 755 $(DEST_BINDIR)/$(NAME)

.PHONY: build install
