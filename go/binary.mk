include build/common.mk
include build/go/target.mk

LINK		:= $(OBJECTTYPE)l
LINKFLAGS	:= $(foreach DIR,$(PKGDIRS),-L $(DIR))

O_NAME		:= $(O)/bin/$(NAME)

build: $(O_NAME)

$(O_NAME): $(OBJECTS)
	$(call echo,Link,$@)
	$(QUIET) mkdir -p $(dir $@)
	$(QUIET) $(LINK) $(LINKFLAGS) -o $@ $(OBJECTS)

install::
	mkdir -p $(DEST_BINDIR)
	install $(O_NAME) $(DEST_BINDIR)/

.PHONY: build
