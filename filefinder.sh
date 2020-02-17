#! /bin/bash


if [ "$#" -ne 2 ]; then
    echo "Usage: $0 [FileWithDomains] [FileWithFilenames]"
    exit
fi


domainsfile=$1
filenames=$2

for file in $(cat $filenames)
do

  xargs -I{} -P0 --arg-file=$domainsfile curl -L -m 1 -w "%{http_code};%{url_effective}\n" -s -o /dev/null http://{}/$file
  xargs -I{} -P0 --arg-file=$domainsfile curl -L -m 1 -w "%{http_code};%{url_effective}\n" -s -o /dev/null https://{}/$file

done
