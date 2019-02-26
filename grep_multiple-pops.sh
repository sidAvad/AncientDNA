#!/bin/bash
set +o posix

while read p; do
    echo "$p"
    awk '{print $1}' <(grep "$p" Data/integrated_call_samples_v3.20130502.EUR.panel) > "integrated_call_samples_v3.20130502.${p}.ids"
done < poplist.txt






