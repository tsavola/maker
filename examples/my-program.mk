NAME		:= my-program
SOURCES		:= my-program.cpp
CPPFLAGS	:= -D_POSIX_SOURCE
DEPENDS		:= $(O)/lib/libmy-library.so
LIBS		+= -L$(O)/lib -lmy-library

include build/binary.mk
