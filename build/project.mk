O		?= debug
V		?= 

# CONFIG

# CROSS_COMPILE
CCACHE		?= $(if $(shell which ccache),ccache,)
CC		?= $(CCACHE) $(CROSS_COMPILE)gcc
CXX		?= $(CCACHE) $(CROSS_COMPILE)g++
CCLINKER	?= $(CC)
CXXLINKER	?= $(CXX)
AR		?= $(CCACHE) $(CROSS_COMPILE)ar

PKG_CONFIG	?= pkg-config
# PKG_CONFIG_PATH

# CFLAGS
# CCFLAGS
# CXXFLAGS
# LDFLAGS
# LIBS

CXXPATTERNS	?= %.cc %.cp %.cxx %.cpp %.CPP %.c++ %.C

PREFIX		?= /usr/local
BINDIR		?= $(PREFIX)/bin
SBINDIR		?= $(PREFIX)/sbin
LIBDIR		?= $(PREFIX)/lib
PLUGINDIR	?= $(LIBDIR)
DATADIR		?= $(PREFIX)/share
SYSCONFDIR	?= /etc

DESTDIR		?= 

include build/common.mk

ifneq ($(wildcard $(O)/config.mk),)
 include $(O)/config.mk
else
 -include $(O).mk
endif

export O V
export CONFIG
export CROSS_COMPILE CCACHE CC CXX CCLINKER CXXLINKER AR
export PKG_CONFIG PKG_CONFIG_PATH
export CPPFLAGS CFLAGS CCFLAGS CXXFLAGS LDFLAGS LIBS
export CXXPATTERNS
export PREFIX BINDIR SBINDIR LIBDIR PLUGINDIR DATADIR SYSCONFDIR
export DESTDIR

DIST		?= $(BINARIES) $(LIBRARIES) $(PLUGINS)
DO_DIST		:= $(filter-out $(NODIST),$(DIST))

LIBRARY_TARGETS	:= $(foreach L,$(LIBRARIES),$(L)-shared $(L)-static)
TARGETS		:= $(BINARIES) $(TESTS) $(LIBRARY_TARGETS) $(PLUGINS)
CHECK_TARGETS	:= $(foreach T,$(TESTS),check-$(T))
INSTALL_TARGETS	:= $(foreach I,$(DO_DIST),install-$(I))

build:
check: $(CHECK_TARGETS)
all: build check
install: $(INSTALL_TARGETS)

clean:
	$(call echo,Remove,$(O))
	$(QUIET) rm -rf "$(O)"

makefile	= $(firstword $(wildcard $(1).mk) $(1)/build.mk)
librarymakefile	= $(call makefile,$(patsubst %-static,%,$(patsubst %-shared,%,$(1))))
librarytarget	= build-$(call lastword,$(subst -, ,$(1)))
testmakefile	= $(call makefile,$(patsubst check-%,%,$(1)))
distmakefile	= $(call makefile,$(patsubst install-%,%,$(1)))

$(BINARIES) $(TESTS) $(PLUGINS):
	$(QUIET) $(MAKE) --no-print-directory -f $(call makefile,$@) build

$(LIBRARY_TARGETS):
	$(QUIET) $(MAKE) --no-print-directory -f $(call librarymakefile,$@) $(call librarytarget,$@)

$(CHECK_TARGETS): $(TESTS)
	$(QUIET) $(MAKE) --no-print-directory -f $(call testmakefile,$@) check

$(INSTALL_TARGETS): $(DO_DIST)
	$(QUIET) $(MAKE) --no-print-directory -f $(call distmakefile,$@) install

.PHONY: build install all check clean
.PHONY: $(TARGETS) $(CHECK_TARGETS) $(INSTALL_TARGETS) $(LIBRARIES)
