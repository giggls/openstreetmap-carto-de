DBSCHEME = "de"

MAPNIK_API = 3.0.15

TEMPFILE := $(shell mktemp -u)

XMLSTYLE := osm.xml

TO := ./testoutput

# This target will render test tiles for l10n stuff
test: $(TO)/test-l10n1.png $(TO)/test-l10n2.png $(TO)/test-l10n3.png $(TO)/test-l10n4.png $(TO)/test-l10n5.png

# l10n (country-names)
$(TO)/test-l10n1.png: $(XMLSTYLE)
	mkdir -p $(TO)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /3/5/3.png

# l10n (latin + asian scripts)
$(TO)/test-l10n2.png: $(XMLSTYLE)
	mkdir -p $(TO)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /10/792/483.png

# l10n station (thai + latin)
$(TO)/test-l10n3.png: $(XMLSTYLE)
	mkdir -p $(TO)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /14/12777/7562.png

# l10n Seoul in Latin and korean script
$(TO)/test-l10n4.png: $(XMLSTYLE)
	mkdir -p $(TO)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /10/873/396.png

# l10n near east
$(TO)/test-l10n5.png: $(XMLSTYLE)
	mkdir -p $(TO)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /10/612/416.png

clean:
	rm -f $(TO)/test-*.png
