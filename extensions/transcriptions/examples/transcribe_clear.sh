#! /bin/sh

curl  -L -X POST -H "Accept: application/sparql-results+json" \
 --data "TRANSCRIBE CLEAR" \
-H "Content-Type: application/sparql-query" \
'http://de8.dydra.com/skorkmaz/qa_test/dydra-query'