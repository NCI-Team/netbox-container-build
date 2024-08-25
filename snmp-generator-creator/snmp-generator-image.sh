#!/bin/bash
yum install gcc make net-snmp net-snmp-utils net-snmp-libs net-snmp-devel
git clone https://github.com/prometheus/snmp_exporter.git
cd snmp_exporter/generator
make docker-generate
podman build --no-cache -t snmp-exporter-s3cmd:latest .

podman save -o snmp-exporter-s3cmd.tar snmp-exporter-s3cmd:latest
