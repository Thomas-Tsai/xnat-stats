#!/bin/bash

projectIDs=$(curl -u admin:admin@steps -k  https://dmxnat.nchc.org.tw/data/projects?format=json | jq .ResultSet.Result[].ID)

for proid in $projectIDs; do 
    xproid=$(echo $proid | sed s/\"//g)
    echo -n "$xproid, "
    curl -u admin:admin@steps -k -s https://dmxnat.nchc.org.tw/data/projects/$xproid/subjects?format=json | jq .ResultSet.totalRecords

done

