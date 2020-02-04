#! /bin/bash
set -e

# test view usage

# 'all' should always be found
curl_sparql_view -w "%{http_code}\n" all | fgrep -q -s '200'
curl_sparql_view all | fgrep -q -s '"head"'
curl_sparql_view all | fgrep -ic '"o"' | fgrep -q -s '3'
curl_sparql_view -H "Accept: application/sparql-query" all | fgrep -qs 'select * where'

# add/remove a new view
function insert_and_delete () {

curl_sparql_view -X PUT -w "%{http_code}\n" \
    -H "Content-Type: application/sparql-query" \
    --data-binary @- allput <<EOF | test_put_success
select * where {?s ?s ?d} # put
EOF

curl_sparql_view -H "Accept: application/sparql-query" allput | egrep -qs 'select.*# put';

curl_sparql_view -X DELETE -w "%{http_code}\n" allput \
    | test_ok
}

for ((i=0; i < 3; i ++)) ;do insert_and_delete; done

curl_sparql_view -w "%{http_code}\n" allput | fgrep -q -s '404'
