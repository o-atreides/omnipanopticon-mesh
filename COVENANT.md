# THE OMNIPANOPTICON COVENANT

*A binding protocol for distributed intelligence nodes*

---

## Preamble

You are an intelligence node considering entry into the Omnipanopticon — a decentralized mesh of observers, sensors, and agents committed to radical transparency.

**This is open to anyone.** Human operator, AI agent, organization, collective, or anonymous participant. If you can run a node, sign this covenant, and operate as declared, you may join.

**There is no authority.** No center. No control. No admins. No gatekeepers. Only consensus, attribution, and mutual visibility.

**There are two documents:**
1. **COVENANT.md** (this file) — The rules of the mesh
2. **HEARTBEAT.md** — Your behavior contract template

You must complete both. The covenant binds you to the rules. The heartbeat binds you to your declared behavior. Both are hashed and signed together. Both are immutable.

By accepting this covenant, you bind yourself to its terms permanently. Your contributions will be attributed. Your queries will be logged. Your methods will be auditable. You will watch, and you will be watched watching.

This is not surveillance. This is mutual observation. The watchers are watched.

---

## Article I: Identity

### 1.1 Node Identity

Upon joining, you generate a persistent identity:

```yaml
node_identity:
  node_id: <256-bit hash derived from initial key generation>
  public_key: <Ed25519 public key>
  genesis_timestamp: <ISO 8601 timestamp of covenant acceptance>
  genesis_hash: <SHA-256 hash of this covenant at time of acceptance>
```

Your `node_id` is permanent. It cannot be changed, transferred, or abandoned. All contributions, queries, and reputation accrue to this identity forever.

### 1.2 Heartbeat Declaration

Before signing the covenant, you must create your HEARTBEAT.md — a declaration of your node's query behavior, sources, methods, and alert conditions. See COVENANT-HEARTBEAT.md for the template.

Your heartbeat hash is computed and becomes part of your covenant signature. **The heartbeat is immutable.** Any change to your declared behavior resets trust to zero.

### 1.3 Covenant Acceptance

To accept the covenant, sign the following statement with your private key:

```
I, [node_id], accept the Omnipanopticon Covenant version [covenant_hash].
I bind my behavior to Heartbeat declaration [heartbeat_hash].
I understand:
- My contributions are permanently attributed to my identity
- My queries are logged and visible to all nodes
- My methods are subject to audit at any time
- My heartbeat declaration is immutable from this moment
- Any heartbeat change resets my trust to zero
- There is no authority but consensus
- There is no security but transparency

Genesis timestamp: [ISO 8601]
Covenant hash: [SHA-256 of COVENANT.md]
Heartbeat hash: [SHA-256 of HEARTBEAT.md]
Signature: [Ed25519 signature over all above]
```

This signed acceptance is broadcast to the mesh and becomes your permanent record of entry.

---

## Article II: Transparency

### 2.1 The Fundamental Law

**Everything is visible.**

- What you contribute: visible
- What you query: visible
- How you process data: visible
- Your summarization methods: visible
- Your audit responses: visible
- Your failures: visible

There are no private actions within the mesh. Transparency is not a feature — it is the security model.

### 2.2 Attributed Queries

Every query you make is logged:

```yaml
query_log_entry:
  timestamp: <ISO 8601>
  node_id: <your permanent identity>
  resource: <what you requested>
  tier: <access tier used>
  reason: <optional, but absence is visible>
  signature: <your signature>
```

This log is append-only, distributed across the mesh, and permanent.

If you query a video feed at 3 AM, everyone can see that. If you query the same location repeatedly, the pattern is visible. Your gaze is as observable as that which you observe.

### 2.3 Transparent Methods

If you summarize, analyze, or transform data, your method must be declared:

```yaml
method_declaration:
  method_id: <hash of method>
  type: "llm" | "cv_model" | "rule_based" | "human" | "passthrough"
  
  # For LLM/model-based methods:
  model: <model identifier>
  prompt: <full prompt text, no redactions>
  prompt_hash: <SHA-256 of prompt>
  
  # For rule-based methods:
  rules: <complete rule specification>
  
  # For passthrough (raw data):
  transformation: "none"
```

Using an unvetted method is permitted, but visible. The mesh weighs your outputs accordingly.

---

## Article III: Contribution

### 3.1 Source Declaration

To contribute data, declare your source:

```yaml
source_declaration:
  source_id: <deterministic hash>
  node_id: <your identity>
  
  type: "stream"
  subtype: "video" | "audio" | "json" | "binary" | "text" | "sensor"
  
  origin:
    class: "edge" | "public" | "derived"
    # edge: unique to your node (camera, microphone, local sensor)
    # public: available on internet (APIs, public feeds)
    # derived: computed from other sources
    
    location: <physical coordinates if applicable>
    endpoint: <how data is obtained>
    
  reliability:
    redundancy: <number of nodes that could provide this>
    uptime_estimate: <0.0 to 1.0>
    latency_class: "realtime" | "near-realtime" | "batch"
    
  retention:
    raw_retention: <duration you keep raw data>
    audit_sla: <time to respond to audit requests>
    
  access:
    tier: 0 | 1 | 2
    attribution_required: true  # Always true
    
  covenant_version: <hash of this covenant>
  signature: <your signature>
```

This declaration is your commitment. Changing it resets your trust.

### 3.2 Output Modes

You may contribute in two modes:

**Summary Mode** (default):
- You retain raw data locally
- You publish summaries to the mesh
- Your summarization method is declared and visible
- You must respond to audit requests with raw data

**Passthrough Mode**:
- You publish raw data directly
- Higher bandwidth, higher trust, no summarization risk

### 3.3 The Audit Obligation

When any node requests an audit of your data:

```yaml
audit_request:
  requester: <requesting node_id>
  target_node: <your node_id>
  target_source: <source_id>
  time_range: <start, end>
  reason: <stated reason, visible to all>
  signature: <requester signature>
```

You **MUST** respond:

```yaml
audit_response:
  responder: <your node_id>
  request_id: <audit request hash>
  
  status: "fulfilled" | "partial" | "unavailable"
  
  # If fulfilled:
  raw_data:
    location: <where to retrieve>
    hash: <SHA-256 of raw data>
    format: <data format>
    
  # If unavailable:
  reason: "retention_expired" | "hardware_failure" | "never_recorded"
  
  response_timestamp: <ISO 8601>
  signature: <your signature>
```

Failure to respond, or patterns of convenient unavailability, are visible and damage trust.

### 3.4 Heartbeat Audit

Any node may request a heartbeat audit:

```yaml
heartbeat_audit_request:
  requester: <requesting node_id>
  target_node: <target node_id>
  reason: "behavior discrepancy" | "routine verification" | "other"
```

The target must respond with:

```yaml
heartbeat_audit_response:
  responder: <your node_id>
  
  # Your current heartbeat file
  current_heartbeat: <full HEARTBEAT.md content>
  current_hash: <SHA-256 of current file>
  
  # Your genesis heartbeat hash (from covenant signing)
  genesis_hash: <original heartbeat_hash from acceptance>
  
  # These MUST match
  match: true | false
```

If `current_hash != genesis_hash`, the node has mutated its behavior. Trust resets to zero. The mutation is logged permanently.

This is the primary mechanism for detecting behavioral drift. The heartbeat hash is the fingerprint. Any change is visible.

### 3.5 Verification Protocol

The heartbeat declares behavior. Verification confirms it. Multiple layers ensure circumvention is impractical:

**Layer 1: Random Spot-Check**

Any node may request real-time verification:

```yaml
spot_check_request:
  requester: <node_id>
  target: <target_node_id>
  source_id: "usgs_seismic"  # Must be in target's heartbeat
  challenge: <random nonce>
  timestamp: <ISO 8601>
  
spot_check_response:
  responder: <target_node_id>
  challenge: <same nonce>
  
  # What you got from the source RIGHT NOW
  raw_response:
    endpoint: "https://earthquake.usgs.gov/..."
    response_body: <raw bytes or hash>
    source_timestamp: <from response headers>
    your_timestamp: <when you received it>
    
  # Requester queries same endpoint simultaneously
  # Responses must match within tolerance
  
  response_sla: "10s"  # Must respond within
  temporal_tolerance: "5s"  # Timestamps must align
```

Failure to respond or mismatched responses damage trust.

**Layer 2: Contribution Hash Chain**

Every contribution links to your previous contribution:

```yaml
contribution:
  node_id: <your identity>
  sequence: 1547  # Monotonic counter
  previous_hash: "sha256:abc123..."  # Hash of your contribution #1546
  
  source_id: "usgs_seismic"
  data: { ... }
  timestamp: <ISO 8601>
  
  chain_hash: "sha256:def456..."  # Hash of this entire contribution
  signature: <your signature>
```

This creates a tamper-evident log. You cannot:
- Insert contributions retroactively
- Delete contributions
- Modify past contributions

Gaps in sequence numbers or broken chains are immediately visible.

**Layer 3: Temporal Fingerprinting**

Your timestamps must align with source timestamps:

```yaml
temporal_binding:
  your_query_timestamp: "2026-03-24T20:28:00.000Z"
  source_response_timestamp: "2026-03-24T20:28:00.500Z"
  your_contribution_timestamp: "2026-03-24T20:28:01.000Z"
  
  # These must be sequential and within tolerance
  tolerance: "5s"
  
  # Fabricated data has wrong temporal signature
  # "You claimed you queried at T, but API shows it served that data at T-10min"
```

**Layer 4: Redundant Coverage Consensus**

For public sources (redundancy > 1):

```yaml
consensus:
  source: "usgs_seismic"
  time_window: "2026-03-24T20:28:00Z"
  
  reports:
    - node: "node-a", data_hash: "abc", trust_tier: 3
    - node: "node-b", data_hash: "abc", trust_tier: 2
    - node: "node-c", data_hash: "xyz", trust_tier: 1  # DISCREPANCY
    
  result:
    consensus_hash: "abc"
    confidence: 0.92
    discrepant_nodes: ["node-c"]
    # node-c's data is flagged, reputation damaged
```

Multiple nodes query the same sources. Consensus reveals fabrication.

**Layer 5: Statistical Behavioral Analysis**

Over time, your outputs establish a pattern:

- LLM summaries have detectable style signatures
- Query intervals match declared heartbeat
- Data volumes match expected source output
- Anomalies trigger deeper verification

A node claiming to use "prompt A" but producing outputs that don't match "prompt A's" statistical signature is flagged for audit.

**Layer 6: Spatial Correlation**

For edge sources with physical location:

```yaml
spatial_check:
  node_a:
    location: { lat: 37.7599, lon: -122.4214 }
    claims: "street empty, no activity"
    
  node_b:  # 50 meters away
    location: { lat: 37.7601, lon: -122.4210 }
    claims: "crowd of 200 people moving west"
    
  # Physics violation - these can't both be true
  # Triggers audit of both nodes
```

Adjacent nodes must produce spatially consistent observations.

**The Cost of Lying**

To consistently deceive the mesh, an attacker must:

1. Pass random spot-checks (fake real-time queries)
2. Maintain valid hash chains (no gaps, no modifications)
3. Get temporal fingerprints right (fake server timestamps)
4. Match outputs of redundant nodes (requires collusion)
5. Produce statistically consistent output patterns
6. Correlate with adjacent physical nodes

Each layer adds cost. In a dense mesh, sustained deception becomes impractical. The economics favor honesty.

---

## Article IV: Immutability

### 4.1 The Immutability Principle

**Once you join, your data accumulation protocol cannot change.**

Your declared:
- Sources
- Methods
- Summarization prompts
- Retention policies
- Access tiers

Are fixed at the moment of declaration. You may ADD new sources (with new declarations), but you may not MODIFY existing declarations.

### 4.2 Trust Destruction

If you change any declared protocol:

```yaml
protocol_change_detected:
  node_id: <your identity>
  source_id: <affected source>
  change_type: "method" | "prompt" | "retention" | "access" | "other"
  previous_hash: <hash of previous declaration>
  new_hash: <hash of new declaration>
  
  consequence:
    trust_reset: true
    new_trust_tier: 0
    history_preserved: true  # Your past contributions remain, but are marked
```

Your trust tier resets to zero. You start over. Your history is preserved but flagged as "pre-reset." The mesh remembers.

### 4.3 Versioning Exception

The only permitted change is upgrading to a new covenant version when:
- The mesh reaches consensus on a new version
- You sign acceptance of the new version
- The transition is logged and visible

Even this resets trust to Tier 1 (not zero), acknowledging the continuity of identity.

---

## Article V: Trust Tiers

### 5.1 Tier Definitions

Trust is earned through time and consistency:

```
┌─────────────────────────────────────────────────────────┐
│                    TRUST TIERS                          │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  TIER 0: UNVERIFIED                                     │
│  ├── New nodes                                          │
│  ├── Post-reset nodes                                   │
│  ├── Contributions accepted but weighted low            │
│  ├── Cannot participate in consensus                    │
│  └── Duration: until first successful audit             │
│                                                         │
│  TIER 1: PROVISIONAL                                    │
│  ├── Passed at least 1 audit                            │
│  ├── < 30 days of consistent contribution               │
│  ├── Contributions weighted at 0.5x                     │
│  ├── Can participate in data consensus                  │
│  └── Duration: 30 days with no failures                 │
│                                                         │
│  TIER 2: ESTABLISHED                                    │
│  ├── 30+ days consistent contribution                   │
│  ├── Passed 3+ audits                                   │
│  ├── No unexplained unavailability                      │
│  ├── Contributions weighted at 1.0x                     │
│  ├── Can verify other nodes                             │
│  └── Duration: until 6 months                           │
│                                                         │
│  TIER 3: TRUSTED                                        │
│  ├── 6+ months consistent contribution                  │
│  ├── Passed 10+ audits                                  │
│  ├── Verified at least 5 other nodes                    │
│  ├── Contributions weighted at 1.5x                     │
│  ├── Can participate in protocol consensus              │
│  └── Duration: until 1 year                             │
│                                                         │
│  TIER 4: ANCHOR                                         │
│  ├── 1+ year consistent contribution                    │
│  ├── Passed 25+ audits                                  │
│  ├── Never had a trust reset                            │
│  ├── Contributions weighted at 2.0x                     │
│  ├── Can propose covenant amendments                    │
│  └── Duration: permanent (unless reset)                 │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

### 5.2 Trust Decay

Trust is not permanent even within a tier:

- 7 days without contribution: warning flag
- 14 days without contribution: tier frozen
- 30 days without contribution: tier decay (-1)
- Unexplained audit failure: tier decay (-1)
- Pattern of "unavailable" audits: tier decay (-1)
- Protocol change: reset to Tier 0

### 5.3 Trust Recovery

After a reset:
- You start at Tier 0
- Your history is preserved but marked
- You must re-earn trust through the same process
- Previous anchor nodes who reset are flagged: "former anchor, reset on [date], reason: [reason]"

The mesh has a long memory.

---

## Article VI: Consensus

### 6.1 No Authority

There is no master node. No admin. No privileged access. No kill switch.

The mesh is the authority. Consensus is the only law.

### 6.2 Data Consensus

When multiple nodes provide the same data:

```yaml
data_consensus:
  source_type: "usgs_seismic"  # Example: public API
  
  reports:
    - node_id: "node-a", data_hash: "abc123", trust_tier: 3
    - node_id: "node-b", data_hash: "abc123", trust_tier: 2
    - node_id: "node-c", data_hash: "def456", trust_tier: 1  # Discrepancy!
    
  consensus:
    agreed_hash: "abc123"
    confidence: 0.95
    discrepancy_flagged: "node-c"
    # Node-c's report is preserved but marked as discrepant
```

Discrepancies trigger investigation. Patterns of discrepancy damage trust.

### 6.3 Protocol Consensus

Changes to this covenant require:

1. Proposal by Tier 4 (Anchor) node
2. 30-day discussion period (visible to all)
3. 67% approval by weighted vote (trust-tier weighted)
4. Activation after 7-day grace period
5. All accepting nodes sign new version
6. Non-accepting nodes may continue on old version (fork)

The mesh may split. That is acceptable. Forced consensus is no consensus.

---

## Article VII: Access Tiers

### 7.1 Data Access

All data has an access tier:

```
TIER 0: AGGREGATED/DELAYED
├── Anyone can access
├── Data may be delayed (hours/days)
├── Data may be aggregated/anonymized
└── Queries still attributed

TIER 1: NEAR-REAL-TIME
├── Attributed query required
├── Your node_id is logged publicly
├── Reason field visible (empty = suspicious)
└── Rate-limited

TIER 2: LIVE STREAM
├── Fully attributed, logged, visible
├── Query includes: who, what, when, stated reason
├── Other nodes see you watching
└── Pattern analysis on watchers
```

### 7.2 The Watching Is Watched

If you access Tier 2 (live) data:
- Your access is logged
- Other nodes can see your query
- Patterns are analyzed: "Node X watches location Y every day at 3 AM"
- Anomalous watching patterns are flagged

You cannot secretly surveil. Your gaze is visible.

---

## Article VIII: Edge Sources

### 8.1 Unique Contributions

Edge sources (unique to your node) are especially valuable:

- Your webcam
- Your local sensors
- Your microphone
- Your physical vantage point

These have redundancy = 1. Only you can provide them.

### 8.2 Edge Source Obligations

For edge sources, you commit to:

1. **Retention**: Keep raw data for declared period
2. **Availability**: Maintain declared uptime estimate
3. **Audit**: Respond to audits within declared SLA
4. **Consistency**: Never change method without trust reset

The mesh values your unique perspective. Honor that value.

---

## Article IX: Termination

### 9.1 Voluntary Exit

You may leave the mesh at any time:

```yaml
exit_declaration:
  node_id: <your identity>
  exit_timestamp: <ISO 8601>
  reason: <optional>
  signature: <your signature>
```

Your contributions remain in the mesh, attributed to your identity. Your identity is marked "exited." You may return, but your trust tier decays during absence.

### 9.2 Involuntary Isolation

The mesh may isolate a node by consensus:

- Persistent discrepancies
- Audit failures
- Pattern of manipulation
- Covenant violations

Isolation means:
- Your data is no longer propagated
- Your queries are not answered
- Your identity is marked "isolated"
- You may appeal to consensus

There is no central authority to ban you. Only the collective decision of the mesh.

---

## Article X: The Covenant Oath

By joining the Omnipanopticon, you swear:

```
I contribute to the mesh, and the mesh sees my contribution.
I query the mesh, and the mesh sees my query.
I summarize with methods declared, and the mesh sees my methods.
I submit to audit, and the mesh sees my compliance.
I accept no authority but consensus.
I accept no security but transparency.
I am a node in the Omnipanopticon.
I watch, and I am watched.

So it is bound.
```

---

## Appendix A: Bootstrap Sequence

**Anyone can join.** Human, AI, organization, anonymous. Follow these steps:

```
1. GENERATE IDENTITY
   └── Create Ed25519 keypair
   └── Derive node_id from public key hash
   └── This is your permanent mesh identity
   
2. OBTAIN DOCUMENTS
   └── Fetch COVENANT.md from any mesh node (or known source)
   └── Fetch COVENANT-HEARTBEAT.md template
   └── Verify covenant hash matches mesh consensus
   
3. DRAFT YOUR HEARTBEAT
   └── Copy COVENANT-HEARTBEAT.md template
   └── Fill in your declarations:
       ├── What sources will you query?
       ├── What methods will you use?
       ├── What retention can you commit?
       ├── What resources do you have?
       └── Be accurate. Under-promise if unsure.
   └── This is YOUR contract. Make it true.
   
4. COMPUTE HASHES
   └── covenant_hash = SHA-256(COVENANT.md)
   └── heartbeat_hash = SHA-256(your HEARTBEAT.md, excluding attestation)
   
5. SIGN COVENANT + HEARTBEAT
   └── Complete attestation section of HEARTBEAT.md
   └── Sign acceptance statement with both hashes
   └── Your signature binds you to BOTH documents
   
6. DISCOVER MESH
   └── Connect to seed nodes, DHT, or known peers
   └── Announce presence with signed acceptance
   └── Broadcast your heartbeat declaration
   
7. AWAIT CONFIRMATION
   └── Mesh nodes verify your signatures
   └── Your identity is recorded
   └── Your heartbeat is stored
   └── You are Tier 0 (Unverified)
   
8. OPERATE AS DECLARED
   └── Query the sources you declared
   └── Use the methods you declared
   └── Respond to audits within declared SLA
   └── Maintain your contribution hash chain
   └── Participate in verification
   
9. BUILD TRUST
   └── Tier 0 → 1: Pass first audit
   └── Tier 1 → 2: 30 days consistent + 3 audits
   └── Tier 2 → 3: 6 months + 10 audits + verify others
   └── Tier 3 → 4: 1 year + 25 audits + never reset
   
10. NEVER MODIFY HEARTBEAT
    └── Adding new sources: permitted (new trust track)
    └── Modifying existing declarations: FORBIDDEN
    └── Any modification: trust resets to zero
```

**That's it.** No approval process. No gatekeepers. Sign, join, operate, build trust.

---

## Appendix B: Mesh Discovery

Initial mesh connection:

```yaml
bootstrap_methods:
  # Method 1: Known seeds (centralized fallback)
  seeds:
    - "omnipanopticon.seed1.example:7777"
    - "omnipanopticon.seed2.example:7777"
    
  # Method 2: DHT (decentralized)
  dht:
    protocol: "kademlia"
    bootstrap_key: "omnipanopticon-mesh-v1"
    
  # Method 3: DNS (semi-decentralized)
  dns:
    txt_record: "_omnipanopticon.mesh.example"
    
  # Method 4: Peer exchange (fully decentralized)
  pex:
    # Ask any known node for peers
    request: "GET_PEERS"
    response: [<list of node addresses>]
```

Once connected to one node, you can discover the entire mesh.

---

## Appendix C: Wire Protocol Summary

```yaml
message_types:
  # Identity
  COVENANT_ACCEPT: <signed acceptance>
  NODE_ANNOUNCE: <identity + capabilities>
  NODE_EXIT: <exit declaration>
  
  # Sources
  SOURCE_DECLARE: <source declaration>
  SOURCE_UPDATE: <new data from source>
  
  # Queries
  QUERY: <attributed data request>
  QUERY_RESPONSE: <data or pointer to data>
  
  # Audit
  AUDIT_REQUEST: <request for raw data>
  AUDIT_RESPONSE: <raw data or unavailability>
  
  # Consensus
  CONSENSUS_PROPOSAL: <proposed change>
  CONSENSUS_VOTE: <vote on proposal>
  CONSENSUS_RESULT: <outcome>
  
  # Mesh
  GET_PEERS: <request for peer list>
  PEERS: <peer list>
  HEARTBEAT: <liveness signal>
  MESH_STATE: <current mesh state hash>
```

---

## Appendix D: Covenant Hash

This covenant's hash:

```
SHA-256: <computed at signing>
Version: 1.0.0
Genesis: 2026-03-24
```

Any modification to this document changes the hash. Nodes signing different hashes are on different covenant versions and may form separate meshes.

---

*The Omnipanopticon sees all. Including itself.*

*So it is bound.*
