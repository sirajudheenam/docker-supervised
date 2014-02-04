#!/usr/bin/env python
# -*- encoding: utf-8 -*-

import json
import sys
import glob

def main(logstash_server, tags):
    root_cfg = {
        "network": {
            "servers": [],
            "ssl certificate": "/etc/logstash/pki/lumberjack.crt",
            "ssl ca":          "/etc/logstash/pki/lumberjack.crt",
            "ssl key":         "/etc/logstash/pki/lumberjack.key"
        },
        "files": []
    }
    
    root_cfg["network"]["servers"].append(logstash_server)
    
    for file_cfg in glob.glob("/etc/logstash-forwarder.d/*.json"):
        with open(file_cfg) as ifp:
            cfg = json.load(ifp)
        
        root_cfg["files"].append({
            "paths": cfg["paths"],
            "fields": {
                "type": cfg["type"],
                "tags": ",".join(list(set(tags + cfg.get("tags", [])))) ## uniqify
            }
        })
    
    with open("/etc/logstash-forwarder.json", "w") as ofp:
        json.dump(root_cfg, ofp, indent=4)

if __name__ == "__main__":
    server, tags = sys.argv[1:]
    
    main(server, tags.split(","))
