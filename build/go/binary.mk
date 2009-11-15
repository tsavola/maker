include build/common.mk
include build/go/target.mk

O_NAME		:= $(O)/bin/$(NAME)

build: $(O_NAME)

$(O_NAME): $(OBJECTS)
	$(call echo,Link,$@)
	$(QUIET) mkdir -p $(dir $@)
	$(QUIET) $(LINK) -o $@ $(OBJECTS)

install::
	mkdir -p $(DEST_BINDIR)
	install $(O_NAME) $(DEST_BINDIR)/

.PHONY: build
