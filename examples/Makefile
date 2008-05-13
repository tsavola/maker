CONFIG		:= config.h

CCFLAGS		+= -std=c99
CXXFLAGS	+= -std=c++98

BINARIES	:= my-program
LIBRARIES	:= my-library
TESTS		:= my-tests

DIST		:= $(LIBRARIES)

# High-level targets
build: my-program my-library-shared
my-library: my-library-shared

# Inter-module dependencies
my-program: my-library-shared
my-tests: my-library-static

include build/project.mk
