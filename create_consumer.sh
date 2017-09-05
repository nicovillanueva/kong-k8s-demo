#!/bin/bash

KA=$(minikube service --url kong-admin)

# curl -X POST $KA/apis \
#     -F name=httpbin \
#     -F uris=/ \
#     -F upstream_url=https://httpbin.org
