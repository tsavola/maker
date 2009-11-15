OBJECTTYPE	:= 6
COMPILE		:= $(OBJECTTYPE)g
LINK		:= $(OBJECTTYPE)l

OBJECTS		:= $(patsubst %,$(O)/obj/%.$(OBJECTTYPE),$(basename $(SOURCES)))

$(O)/obj/%.$(OBJECTTYPE): %.go
	$(call echo,Compile,$@)
	$(QUIET) mkdir -p $(dir $@)
	$(QUIET) $(COMPILE) -o $@ $*.go

$(OBJECTS): $(CONFIG)
