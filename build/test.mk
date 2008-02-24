include build/binary.mk

check: build
	$(call echo,Check,$(O)/bin/$(NAME))
	$(QUIET) LD_LIBRARY_PATH=$(O)/lib $(O)/bin/$(NAME)

.PHONY: check
