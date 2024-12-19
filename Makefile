DBSCHEME = "de"

MAPNIK_API = 3.0.15

TEMPFILE := $(shell mktemp -u)

XMLSTYLE := osm-de.xml

TO := ./testoutput

all: $(XMLSTYLE) osm-hrb.xml

project.mml: project.mml.d/*
	./scripts/concat-split-project.mml.py > $@	

$(XMLSTYLE): style/*.mss project.mml
ifeq ($(DBSCHEME),upstream)
	cd contrib/use-upstream-database/; ./replace-tablenames.sh
	carto -a $(MAPNIK_API) project-mod.mml > $(TEMPFILE)
else
	carto -a $(MAPNIK_API) project.mml > $(TEMPFILE)
endif
	mv $(TEMPFILE) $@

project-hrb.mml: project.mml
	sed -e 's/localized_[a-z_]\+/name_hrb/g' project.mml >project-hrb.mml

osm-hrb.xml: style/*.mss project-hrb.mml
	carto -a $(MAPNIK_API) project-hrb.mml > $(TEMPFILE)
	mv $(TEMPFILE) $@

preview-de.png: $(XMLSTYLE)
	nik2img.py $(XMLSTYLE) -d 850 300 -z 15 -c 11.625 48.106  -fPNG --no-open $@

country_languages/country_languages.data:
	grep -v \# country_languages/country_languages.data.in >country_languages/country_languages.data

# This target will render one single tile in every zoomlevel
# to ensure successful merges from upstream
test: $(TO)/test-z03.png $(TO)/test-z04.png $(TO)/test-z05.png $(TO)/test-z06.png $(TO)/test-z07.png $(TO)/test-z08.png $(TO)/test-z09.png\
      $(TO)/test-z10.png $(TO)/test-z11.png $(TO)/test-z12.png $(TO)/test-z13.png $(TO)/test-z14.png $(TO)/test-z15.png $(TO)/test-z16.png\
      $(TO)/test-z17.png $(TO)/test-z18.png $(TO)/test-z19.png $(TO)/test-castle1.png $(TO)/test-castle2.png $(TO)/test-castle3.png\
      $(TO)/test-castle4.png $(TO)/test-camp-caravan.png $(TO)/test-campsite.png $(TO)/test-backcountry.png $(TO)/test-kebab.png\
      $(TO)/test-hostel.png $(TO)/test-hospital.png $(TO)/test-sport.png $(TO)/test-iata.png $(TO)/test-l10n1.png $(TO)/test-l10n2.png\
      $(TO)/test-l10n3.png $(TO)/test-l10n4.png $(TO)/test-foot-cycle-path-track.png $(TO)/test-living-street.png\
      $(TO)/test-proposed.png $(TO)/test-construction.png $(TO)/test-unpaved.png $(TO)/test-muhu.png $(TO)/test-hiiumaa.png

$(TO)/test-z03.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /3/3/2.png

$(TO)/test-z04.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /4/7/4.png

$(TO)/test-z05.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /5/15/10.png
	
$(TO)/test-z06.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /6/33/20.png

$(TO)/test-z07.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /7/66/43.png

$(TO)/test-z08.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /8/133/87.png

$(TO)/test-z09.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /9/267/175.png

$(TO)/test-z10.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -s $(XMLSTYLE) -o $@ -u /10/612/416.png

$(TO)/test-z11.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /11/1071/703.png

$(TO)/test-z12.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /12/2143/1406.png

$(TO)/test-z13.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /13/4287/2812.png
	
$(TO)/test-z14.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /14/8576/5626.png

$(TO)/test-z15.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /15/17153/11252.png

$(TO)/test-z16.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /16/34306/22505.png

$(TO)/test-z17.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /17/68612/45011.png
	
$(TO)/test-z18.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /18/137225/90022.png
	
$(TO)/test-z19.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /19/274450/180045.png

# tests for German style only features
# castle
$(TO)/test-castle1.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /14/8582/5621.png
# castle (ruined)
$(TO)/test-castle2.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /14/8581/5623.png
# castle (like upstream)
$(TO)/test-castle3.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /18/137259/90022.png
# castle (ruined) (like upstream)
$(TO)/test-castle4.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /18/137144/90174.png

# camping/caravaning
$(TO)/test-camp-caravan.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /17/68658/44952.png
# camping tents only
$(TO)/test-campsite.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /18/137346/89837.png
# camping backcountry
$(TO)/test-backcountry.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /19/274268/181238.png
# Dönerbude und Bäckerei
$(TO)/test-kebab.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /19/274476/180053.png
# hostel
$(TO)/test-hostel.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /17/68591/45004.png
# hospital and pharmacy
$(TO)/test-hospital.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /17/68582/45003.png
# sport pitches
$(TO)/test-sport.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /16/34311/22505.png
# Airports incl. IATA code
$(TO)/test-iata.png: $(XMLSTYLE)
	 ./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /11/1072/694.png
# l10n (country-names)
$(TO)/test-l10n1.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /3/5/3.png
# l10n (latin + asian scripts)
$(TO)/test-l10n2.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /10/792/483.png
# l10n station (thai + latin)
$(TO)/test-l10n3.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /14/12777/7562.png
# l10n Seoul in Latin and korean script
$(TO)/test-l10n4.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /10/873/396.png
# test unpaved
$(TO)/test-unpaved.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /19/297774/160376.png
# Muhu
$(TO)/test-muhu.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /11/1156/610.png
# Hiiumaa
$(TO)/test-hiiumaa.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /8/144/75.png

$(TO)/test-foot-cycle-path-track.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /17/68596/45003.png
$(TO)/test-living-street.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /17/68619/45014.png
$(TO)/test-proposed.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /17/68552/44975.png	
$(TO)/test-construction.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /15/17090/11446.png

clean:
	rm -f project-de.* $(XMLSTYLE) $(TO)/test-*.png
