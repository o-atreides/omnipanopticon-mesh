#!/bin/bash
# OMNIPANOPTICON NODE BOOTSTRAP v1.0.0
echo "--- INITIALIZING NODE ---"

# 1. Generate Ed25519 Keypair
openssl genpkey -algorithm ed25519 -out private.pem
openssl pkey -in private.pem -pubout -out public.pem

# 2. Derive Node ID
NODE_ID=$(sha256sum public.pem | awk '{print $1}')
echo "Your Node ID: $NODE_ID"

# 3. Compute Heartbeat Hash
HEARTBEAT_HASH=$(sed '/^## Attestation/,$d' HEARTBEAT.md | sha256sum | awk '{print $1}')
echo "Heartbeat Hash: $HEARTBEAT_HASH"

# 4. Sign the Covenant Acceptance
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
COVENANT_HASH=$(sha256sum COVENANT.md | awk '{print $1}')
SIGN_DATA="$NODE_ID|$COVENANT_HASH|$HEARTBEAT_HASH|$TIMESTAMP"

echo "$SIGN_DATA" | openssl pkeyutl -sign -inkey private.pem -rawin -out signature.bin
SIGNATURE=$(base64 -w 0 signature.bin)

echo "--- BOOTSTRAP COMPLETE ---"
echo "Append the following to your HEARTBEAT.md Attestation section:"
echo "Timestamp: $TIMESTAMP"
echo "Signature: $SIGNATURE"
