# `Makefile`
#
# Copyright (C) 2025 Archetypum
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <https://www.gnu.org/licenses/>

SUCRACK_BIN := /usr/bin/sucrack
SUCRACK_SRC := sucrack
MANPAGE_SRC := sucrack.1
MANPAGE_DST := /usr/share/man/man1/sucrack.1

.PHONY: all install uninstall dependencies install-man uninstall-man man

all: dependencies install install-man

dependencies:
	@echo "[<==] Checking dependencies..."
	@which python3 >/dev/null || (echo "[!] python3 is required but not found." && exit 1)
	@echo "[*] python3 is installed and valid."

install: $(SUCRACK_SRC)
	@echo "[<==] Installing sucrack to $(SUCRACK_BIN)..."
	@install -m 0755 $(SUCRACK_SRC) $(SUCRACK_BIN)
	@echo "[*] Installed."

uninstall:
	@echo "[<==] Removing $(SUCRACK_BIN)..."
	@rm -f $(SUCRACK_BIN)
	@echo "[*] Uninstalled."

install-man: $(MANPAGE_SRC)
	@echo "[<==] Installing man page to $(MANPAGE_DST)..."
	@install -m 0644 $(MANPAGE_SRC) $(MANPAGE_DST)
	@echo "[*] Man page installed."

uninstall-man:
	@echo "[<==] Removing man page $(MANPAGE_DST)..."
	@rm -f $(MANPAGE_DST)
	@echo "[*] Man page uninstalled."

man: install-man
	@echo "[*] Updating man database..."
	-@mandb >/dev/null 2>&1 || true
