#! /bin/bash

# test collation for the location strings

set_sparql_url "openrdf-sesame" "collation"

curl_sparql_request "Accept: application/sparql-results+json" <<EOF \
 | jq '.results.bindings[] | ( .value.value + " " + .location.value)' | diff - ordered-vl-combination.txt
select distinct ?s ?value ?location
 where {
  ?s <http://example.org/value> ?value .
  ?s <http://example.org/location> ?location .
 }
order by (?value + 1) (concat( ?location, strlang("...", "da")))
EOF

