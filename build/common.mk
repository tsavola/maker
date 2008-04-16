define echo
	@ printf "  %-8s  %s\n" "$(1)" "$(2)"
endef

QUIET		:= $(if $(V),,@)

lastword	= $(word $(words $(1)),$(1))

DEST_PREFIX	= $(DESTDIR)$(PREFIX)
DEST_BINDIR	= $(DESTDIR)$(BINDIR)
DEST_SBINDIR	= $(DESTDIR)$(SBINDIR)
DEST_LIBDIR	= $(DESTDIR)$(LIBDIR)
DEST_DATADIR	= $(DESTDIR)$(DATADIR)
DEST_SYSCONFDIR	= $(DESTDIR)$(SYSCONFDIR)
