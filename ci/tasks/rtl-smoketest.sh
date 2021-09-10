#!/bin/bash

set -eu

namespace=${NAMESPACE:-$(cat testflight/env_name)}
host=${HOST:-rtl.${namespace}.svc.cluster.local}
port=${PORT:-3000}

set +e
for i in {1..15}; do
  echo "Attempt ${i} to curl rtl"
  curl ${host}:${port}
  if [[ $? == 0 ]]; then success="true"; break; fi;
  sleep 1
done
set -e

if [[ "$success" != "true" ]]; then echo "Smoke test failed" && exit 1; fi;