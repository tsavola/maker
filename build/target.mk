CROSS_COMPILE	:= 
CCACHE		:= $(if $(shell which ccache),ccache,)
CC		:= $(CCACHE) $(CROSS_COMPILE)gcc
CXX		:= $(CCACHE) $(CROSS_COMPILE)g++
CCLINKER	:= $(CC)
CXXLINKER	:= $(CXX)
AR		:= $(CCACHE) $(CROSS_COMPILE)ar

OBJECTS		:= $(SOURCES:%.c=$(O)/obj/%.o)
PIC_OBJECTS	:= $(SOURCES:%.c=$(O)/obj/%.os)

CXXPATTERNS	:= %.cc %.cp %.cxx %.cpp %.CPP %.c++ %.C
CXXSUFFIX	:= $(call lastword,$(subst ., ,$(filter $(CXXPATTERNS),$(SOURCES))))

ifeq ($(CXXSUFFIX),)
LINKCOMMAND	:= $(CCLINKER)  $(CFLAGS) $(CCFLAGS)  $(LDFLAGS)
else
LINKCOMMAND	:= $(CXXLINKER) $(CFLAGS) $(CXXFLAGS) $(LDFLAGS)

OBJECTS		:= $(OBJECTS:%.$(CXXSUFFIX)=$(O)/obj/%.o)
PIC_OBJECTS	:= $(PIC_OBJECTS:%.$(CXXSUFFIX)=$(O)/obj/%.os)
endif

CONFIGFLAGS	:= $(if $(CONFIG),-include $(CONFIG),)
GENERICFLAGS	:= $(CPPFLAGS) $(CONFIGFLAGS) $(CFLAGS) -c -MD
CCCOMMAND	:= $(CC)  $(GENERICFLAGS) $(CCFLAGS)
CXXCOMMAND	:= $(CXX) $(GENERICFLAGS) $(CXXFLAGS)
PICFLAGS	:= -DPIC -fPIC

$(O)/obj/%.o: %.c
	$(call echo,Compile,$@)
	$(QUIET) mkdir -p $(dir $@)
	$(QUIET) $(CCCOMMAND) \
		-MF $(O)/obj/$(patsubst %,%.d,$*.c) \
		-MT $(O)/obj/$*.o -MT $(O)/obj/$*.os \
		-o $@ $*.c

$(O)/obj/%.os: %.c
	$(call echo,Compile,$@)
	$(QUIET) mkdir -p $(dir $@)
	$(QUIET) $(CCCOMMAND) \
		$(PICFLAGS) \
		-MF $(O)/obj/$(patsubst %,%.d,$*.c) \
		-MT $(O)/obj/$*.o -MT $(O)/obj/$*.os \
		-o $@ \
		$*.c

ifneq ($(CXXSUFFIX),)

$(O)/obj/%.o: %.$(CXXSUFFIX)
	$(call echo,Compile,$@)
	$(QUIET) mkdir -p $(dir $@)
	$(QUIET) $(CXXCOMMAND) \
		-MF $(O)/obj/$(patsubst %,%.d,$*.$(CXXSUFFIX)) \
		-MT $(O)/obj/$*.o -MT $(O)/obj/$*.os \
		-o $@ \
		$*.$(CXXSUFFIX)

$(O)/obj/%.os: %.$(CXXSUFFIX)
	$(call echo,Compile,$@)
	$(QUIET) mkdir -p $(dir $@)
	$(QUIET) $(CXXCOMMAND) \
		$(PICFLAGS) \
		-MF $(O)/obj/$(patsubst %,%.d,$*.$(CXXSUFFIX)) \
		-MT $(O)/obj/$*.o -MT $(O)/obj/$*.os \
		-o $@ \
		$*.$(CXXSUFFIX)

endif

$(OBJECTS) $(PIC_OBJECTS): $(CONFIG)

-include $(SOURCES:%=$(O)/obj/%.d)
