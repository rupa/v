OBJ = v
PREFIX ?= /usr/local
BINDIR = $(PREFIX)/bin
MANDIR = $(PREFIX)/share/man/man1

install : $(OBJ)
	@echo "Installing program to $(DESTDIR)$(BINDIR) ..."
	@mkdir -p $(DESTDIR)$(BINDIR)
	@install -pm0755 $(OBJ) $(DESTDIR)$(BINDIR)/$(TARGET) || \
	echo "Failed. Try "make PREFIX=~ install" ?"
	@echo "Installing manpage to $(DESTDIR)$(MANDIR) ..."
	@mkdir -p $(DESTDIR)$(MANDIR)
	@install -pm0644 $(OBJ).1 $(DESTDIR)$(MANDIR)/ || \
	echo "Failed. Try "make PREFIX=~ install" ?"

uninstall:
	@echo "Remving program from $(DESTDIR)$(BINDIR) ..."
	@rm $(DESTDIR)$(BINDIR)/$(OBJ) || \
	echo "Failed. Try "make PREFIX=~ install" ?"
	@echo "Removing manpage from $(DESTDIR)$(MANDIR) ..."
	@rm $(DESTDIR)$(MANDIR)/$(OBJ).1 || \
	echo "Failed. Try "make PREFIX=~ install" ?"
