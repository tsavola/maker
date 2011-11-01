CXXYPATTERNS	:= $(patsubst %,%y,$(CXXPATTERNS))
CXXYSUFFIX	:= $(firstword $(suffix $(filter $(CXXYPATTERNS),$(SOURCES))))

ifneq ($(CXXYSUFFIX),)

LINKCOMMAND	:= $(CXXLINKCOMMAND)

$(O)/src/%.ii: %$(CXXYSUFFIX)
	$(call echo,Process,$@)
	$(QUIET) mkdir -p $(dir $@) $(dir $(patsubst $(O)/src/%,$(O)/obj/%,$@))
	$(QUIET) $(CXXCOMMAND) -E \
		-MF $(O)/obj/$(patsubst %,%.d,$*$(CXXYSUFFIX)) \
		-MT $(O)/obj/$*.o -MT $(O)/obj/$*.os \
		-o $@ $(O)/src/$*$(CXXSUFFIX)
	$(QUIET) $(PREPARE_POST) $@

.PRECIOUS: $(patsubst %,$(O)/src/%.ii,$(basename $(filter %$(CXXYSUFFIX),$(SOURCES))))

$(O)/obj/%.o: $(O)/src/%.ii
	$(call echo,Compile,$@)
	$(QUIET) $(CXXCOMMAND) -o $@ $(O)/src/$*.ii

$(O)/obj/%.os: $(O)/src/%.ii
	$(call echo,Compile,$@)
	$(QUIET) $(CXXCOMMAND) $(PICFLAGS) -o $@ $(O)/src/$*.ii

endif
