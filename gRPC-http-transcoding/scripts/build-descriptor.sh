#!/usr/bin/env bash
set -euo pipefail

GOOGLEAPIS=/mnt/c/Users/david.miranda/Documents/Git/mine/googleapis/

# Genera stubs Go
protoc -I$GOOGLEAPIS -I./proto \
  --go_out=server --go_opt=paths=source_relative \
  --go-grpc_out=server --go-grpc_opt=paths=source_relative \
  proto/calc.proto

# Crea el descriptor (incluye imports y fuente)
protoc -I$GOOGLEAPIS -I./proto \
  --include_imports --include_source_info \
  --descriptor_set_out=proto/calc.pb \
  proto/calc.proto

# Codifica el descriptor a Base64 (línea única)
base64 -w0 proto/calc.pb > proto/calc.pb.b64
echo "Descriptor listo: proto/calc.pb.b64"
