PKG_CONFIG	:= pkg-config

ifneq ($(PKGS),)

 ifeq ($(shell $(PKG_CONFIG) --exists --print-errors $(PKGS) && echo ok),)
  $(error PKGS not found)
 endif

CPPFLAGS	+= $(shell $(PKG_CONFIG) --cflags-only-I $(PKGS))
CFLAGS		+= $(shell $(PKG_CONFIG) --cflags-only-other $(PKGS))
LDFLAGS		+= $(shell $(PKG_CONFIG) --libs-only-other $(PKGS))
LIBS		+= $(shell $(PKG_CONFIG) --libs-only-L --libs-only-l $(PKGS))

endif
