#!/bin/bash

set -e -u

## evaluate shell variables in template files
find /etc/collectd.d -type f -name '*.in' | while read tmpl_f; do
    echo "processing ${tmpl_f}"
    
    ## escape double quotes so that they pass through without disappearing
    tmpl_str="$( sed -e 's#"#\\"#g' "${tmpl_f}" )"
    
    ## lots of escaping required to make this work!
    ( eval echo \""${tmpl_str}"\" ) >| "${tmpl_f%.in}"
done

exec /usr/sbin/collectd -C /etc/collectd.conf -f
