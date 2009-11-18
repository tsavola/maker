OBJECTTYPE	:= 6

COMPILE		:= $(OBJECTTYPE)g
COMPILEFLAGS	:= $(foreach DIR,$(PKGDIRS),-I $(DIR))

OBJECTS		:= $(O)/obj/$(NAME).$(OBJECTTYPE)

$(OBJECTS): $(SOURCES)
	$(call echo,Compile,$@)
	$(QUIET) mkdir -p $(dir $@)
	$(QUIET) $(COMPILE) $(COMPILEFLAGS) -o $@ $(SOURCES)

$(OBJECTS): $(CONFIG)
