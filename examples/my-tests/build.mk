NAME		:= my-tests
SOURCES		:= $(wildcard my-tests/*.c)
DEPENDS		:= $(O)/lib/libmy-library.a
LIBS		+= $(DEPENDS)

include build/test.mk
