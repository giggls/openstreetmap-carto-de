CREATE OR REPLACE VIEW planet_osm_line AS
SELECT
osm_id,
tags->'access' as "access",
tags->'addr:interpolation' as "addr:interpolation",
tags->'aerialway' as "aerialway",
tags->'aeroway' as "aeroway",
tags->'barrier' as "barrier",
tags->'building' as "building",
tags->'bicycle' as "bicycle",
tags->'bridge' as "bridge",
tags->'construction' as "construction",
tags->'covered' as "covered",
tags->'culvert' as "culvert",
tags->'disused' as "disused",
tags->'embankment' as "embankment",
tags->'foot' as "foot",
tags->'highway' as "highway",
tags->'historic' as "historic",
tags->'horse' as "horse",
tags->'intermittent' as "intermittent",
tags->'junction' as "junction",
tags->'leisure' as leisure,
tags->'lock' as "lock",
tags->'man_made' as "man_made",
tags->'name' as "name",
tags->'name:de' as "name:de",
tags->'int_name' as "int_name",  
tags->'name:en' as "name:en",
tags->'natural' as "natural",
tags->'oneway' as "oneway",
tags->'operator' as "operator",
tags->'power' as "power",
tags->'proposed' as "proposed",
tags->'railway' as "railway",
tags->'ref' as "ref",
tags->'route' as "route",
tags->'service' as "service",
tags->'surface' as "surface",
tags->'tracktype' as "tracktype",
tags->'tunnel' as "tunnel",
tags->'waterway' as "waterway",
tags->'width' as "width",
way as "way",
z_order as z_order,
TRIM(name_l10n[1] || ' - ' || name_l10n[2], ' - ') as localized_name_second,
TRIM(name_l10n[2] || ' - ' || name_l10n[1], ' - ') as localized_name_first,
COALESCE(nullif(name_l10n[2],''),name_l10n[1]) as localized_name,
TRIM(name_l10n[1] || ' - ' || name_l10n[2], ' - ') as localized_streetname,
COALESCE(tags->'name:hsb',tags->'name:dsb',tags->'name') as name_hrb,
layer as layer,
tags as tags
FROM planet_osm_hstore_line;

GRANT select ON planet_osm_line to public;
