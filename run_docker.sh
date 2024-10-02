#!/bin/sh

docker run --rm \
    -v $(pwd)/run_attack.sh:/run_attack.sh \
    -v $(pwd)/mtm-api.json:/mtm-api.json \
    --name imperva-atk-tool \
    --network mtm-dast \
    imperva-atk-tool bash /run_attack.sh
