#! /bin/sh

curl -v -L -X POST -H "Accept: application/sparql-results+json" \
 --data "TRANSCRIBE LIST" \
-H "Content-Type: application/sparql-query" \
'http://de8.dydra.com/skorkmaz/qa_test/dydra-query'