-include build/pkgconfig.mk

CONFIGFLAGS	:= $(if $(CONFIG),-include $(CONFIG),)
GENERICFLAGS	:= $(CPPFLAGS) $(CONFIGFLAGS) $(CFLAGS) -c -MD
PICFLAGS	:= -DPIC -fPIC

-include build/c.mk
-include build/c++.mk

OBJECTS		:= $(patsubst %,$(O)/obj/%.o,$(basename $(SOURCES)))
PIC_OBJECTS	:= $(patsubst %,$(O)/obj/%.os,$(basename $(SOURCES)))

-include $(SOURCES:%=$(O)/obj/%.d)

$(OBJECTS) $(PIC_OBJECTS): $(CONFIG)
