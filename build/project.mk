O		:= debug
V		:= 

include build/common.mk

PREFIX		:= /usr/local
BINDIR		:= $(PREFIX)/bin
SBINDIR		:= $(PREFIX)/sbin
LIBDIR		:= $(PREFIX)/lib
DATADIR		:= $(PREFIX)/share
SYSCONFDIR	:= /etc

DESTDIR		:= 

ifneq ($(wildcard $(O)/config.mk),)
 include $(O)/config.mk
else
 -include $(O).mk
endif

export CROSS_COMPILE CCACHE CC CXX CCLINKER CXXLINKER AR
export CPPFLAGS CFLAGS CCFLAGS CXXFLAGS LDFLAGS LIBS
export O V
export PREFIX BINDIR SBINDIR LIBDIR DATADIR SYSCONFDIR
export DESTDIR

ifeq ($(BINARIES),)
BINARIES	:= $(patsubst %/Binary.mk,%,$(wildcard */Binary.mk))
endif

ifeq ($(LIBRARIES),)
LIBRARIES	:= $(patsubst %/Library.mk,%,$(wildcard */Library.mk))
endif

ifeq ($(TESTS),)
TESTS		:= $(patsubst %/Test.mk,%,$(wildcard */Test.mk))
endif

ifeq ($(INSTALL),)
INSTALL		:= $(BINARIES) $(LIBRARIES)
endif

LIBRARY_TARGETS	:= $(foreach L,$(LIBRARIES),$(L)-shared $(L)-static)
TARGETS		:= $(BINARIES) $(TESTS) $(LIBRARY_TARGETS)
CHECK_TARGETS	:= $(foreach T,$(TESTS),check-$(T))
INSTALL_TARGETS	:= $(foreach I,$(INSTALL),install-$(I))

build:
all: $(TARGETS)
check: $(CHECK_TARGETS)
install: $(INSTALL_TARGETS)

clean:
	$(call echo,Remove,$(O))
	$(QUIET) rm -rf "$(O)"

$(BINARIES):
	$(QUIET) $(MAKE) --no-print-directory $@/Binary.mk build

$(TESTS):
	$(QUIET) $(MAKE) --no-print-directory $@/Test.mk build

$(LIBRARY_TARGETS):
	$(QUIET) $(MAKE) --no-print-directory \
		-f $(firstword $(subst -, ,$@))/Library.mk \
		build-$(lastword $(subst -, ,$@))

$(CHECK_TARGETS): $(TESTS)
	$(QUIET) $(MAKE) --no-print-directory \
		-f $(patsubst check-%,%,$@)/Test.mk check

$(INSTALL_TARGETS): $(INSTALL)
	$(QUIET) $(MAKE) --no-print-directory \
		-f $(wildcard $(patsubst install-%,%,$@)/T*t.mk) install

.PHONY: build install all check clean
.PHONY: $(TARGETS) $(CHECK_TARGETS) $(INSTALL_TARGETS) $(LIBRARIES)
