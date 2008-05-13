NAME		:= my-library
VERSION		:= 0
SOURCES		:= $(wildcard my-library/*.c)
CFLAGS		+= -pthread

include build/library.mk
