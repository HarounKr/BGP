#!/bin/bash
docker build -t host-hkrifa -f _hkrifa-1_host .
docker build -t router-hkrifa -f _hkrifa-2 .
