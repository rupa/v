OBJ = v
PREFIX ?= /usr/local
BINDIR = $(PREFIX)/bin
MANDIR = $(PREFIX)/share/man/man1

install : $(OBJ)
	echo "Installing program to $(DESTDIR)$(BINDIR) ..."
	@mkdir -p $(DESTDIR)$(BINDIR)
	@install -pm0755 $(OBJ) $(DESTDIR)$(BINDIR)/$(TARGET) || \
	echo "Failed. Try "make PREFIX=~ install" ?"
	@echo "Installing manpage to $(DESTDIR)$(MANDIR) ..."
	@mkdir -p $(DESTDIR)$(MANDIR)
	@install -pm0644 v.1 $(DESTDIR)$(MANDIR)/ || \
	echo "Failed. Try "make PREFIX=~ install" ?"
