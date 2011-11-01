CXXCOMMAND	:= $(CXX) $(GENERICFLAGS) $(CXXFLAGS)
CXXLINKCOMMAND	:= $(CXXLINKER) $(CFLAGS) $(CXXFLAGS) $(LDFLAGS)

CXXSUFFIX	:= $(firstword $(suffix $(filter $(CXXPATTERNS),$(SOURCES))))

ifneq ($(CXXSUFFIX),)

LINKCOMMAND	:= $(CXXLINKCOMMAND)

$(O)/obj/%.o: %$(CXXSUFFIX)
	$(call echo,Compile,$@)
	$(QUIET) mkdir -p $(dir $@)
	$(QUIET) $(CXXCOMMAND) \
		-MF $(O)/obj/$(patsubst %,%.d,$*$(CXXSUFFIX)) \
		-MT $(O)/obj/$*.o -MT $(O)/obj/$*.os \
		-o $@ $*$(CXXSUFFIX)

$(O)/obj/%.os: %$(CXXSUFFIX)
	$(call echo,Compile,$@)
	$(QUIET) mkdir -p $(dir $@)
	$(QUIET) $(CXXCOMMAND) $(PICFLAGS) \
		-MF $(O)/obj/$(patsubst %,%.d,$*$(CXXSUFFIX)) \
		-MT $(O)/obj/$*.o -MT $(O)/obj/$*.os \
		-o $@ $*$(CXXSUFFIX)

endif
