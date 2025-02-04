#!/bin/bash
docker build -t routeur_hkrifa -f _hkrifa-2 .
docker build -t host_hkrifa -f _hkrifa-1_host .
