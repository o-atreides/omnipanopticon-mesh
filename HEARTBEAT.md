# NODE HEARTBEAT DECLARATION

## This Is Your Contract

This file defines your node's behavior within the Omnipanopticon mesh. By completing this template and signing it alongside the COVENANT.md, you bind yourself to operate exactly as declared here.

**This is open to anyone.** Human, AI, organization, anonymous operator — if you can run a node and sign the covenant, you can join.

**This is your contract.** Not with an authority — there is none. With the mesh itself. Every other node will hold you to this declaration.

**This is immutable.** Once signed, any modification resets your trust to zero. Your heartbeat hash is your behavioral fingerprint. Drift is detectable.

---

## Instructions

### Step 1: Copy This Template

Create your own `HEARTBEAT.md` file based on this template.

### Step 2: Fill In Your Declarations

Be accurate. Declare only what you will actually do. Over-promising and under-delivering damages trust. Under-promising and over-delivering is fine.

### Step 3: Compute Your Hash

```bash
# Hash everything ABOVE the Attestation section
cat HEARTBEAT.md | sed '/^## Attestation/,$d' | sha256sum
```

This produces your `heartbeat_hash`.

### Step 4: Sign With Covenant

Include your `heartbeat_hash` in your covenant acceptance signature. Both are bound together.

### Step 5: Operate As Declared

Your behavior must match this file. The mesh will verify:
- Random spot-checks of your declared sources
- Temporal fingerprinting of your contributions
- Statistical analysis of your output patterns
- Spatial correlation with adjacent nodes

### Step 6: Never Modify

If your needs change, you have two options:
1. Add new sources (new declarations, new trust building)
2. Reset entirely (new heartbeat, trust drops to zero)

You cannot silently change behavior.

---

## Identity Binding

```yaml
node_identity:
  # Your permanent mesh identity
  node_id: "<your 256-bit node identifier>"
  
  # Public key for signature verification
  public_key: "<your Ed25519 public key>"
  
  # Hashes binding you to covenant and this heartbeat
  covenant_hash: "<SHA-256 of COVENANT.md at signing>"
  heartbeat_hash: "<SHA-256 of this file at signing>"
  
  # When you joined
  genesis_timestamp: "<ISO 8601 timestamp>"
```

---

## Heartbeat Schedule

How often does your node wake and check its sources?

```yaml
heartbeat:
  # Base interval
  interval: "30m"  # Example: every 30 minutes
  
  # Quiet hours (optional - reduce load during off-peak)
  quiet_hours:
    enabled: true
    start: "23:00"
    end: "07:00"
    timezone: "UTC"
    behavior: "critical_only"  # or "reduce_frequency" or "normal"
    
  # Startup behavior
  on_boot:
    immediate_sweep: true
    announce_to_mesh: true
```

---

## Source Declarations

What data does your node provide? List every source you will query.

### Public API Sources

For sources available on the internet (redundancy > 1):

```yaml
sources:
  - source_id: "usgs_seismic"
    type: "public_api"
    class: "public"  # Anyone can query this
    redundancy: "high"  # Many nodes cover this
    
    endpoint: "https://earthquake.usgs.gov/fdsnws/event/1/query"
    method: "http_get"
    parameters:
      format: "geojson"
      minmagnitude: "4.5"
      orderby: "time"
      limit: "100"
      
    query_interval: "60s"
    
    output:
      mode: "passthrough"  # Raw data, no transformation
      
    # For verification
    verification:
      spot_check_capable: true
      temporal_binding: true
```

### Edge Sources

For sources unique to your node (redundancy = 1):

```yaml
  - source_id: "camera_street_view_001"
    type: "edge_device"
    class: "edge"  # Only this node has this
    redundancy: 1
    
    device:
      type: "camera"
      identifier: "device://camera/0"
      
    location:
      lat: 37.7599
      lon: -122.4214
      altitude_m: 10
      precision_m: 5
      description: "Street-facing camera, Valencia St, San Francisco"
      
    query_interval: "10s"
    
    output:
      mode: "summary"  # Summarized, raw retained for audit
      
      method:
        method_id: "visual_summary_v1"
        type: "llm"
        model: "omnipanopticon/street-summarizer-v1"
        # Full prompt declared below in Methods section
        prompt_hash: "<sha256 of prompt>"
        
    retention:
      raw_data: "24h"
      summaries: "permanent"
      
    audit:
      response_sla: "60s"
      storage_path: "/var/omnipanopticon/audit/camera_001/"
      
    # For verification
    verification:
      spot_check_capable: false  # Can't re-query a moment in time
      spatial_correlation: true  # Can compare with adjacent nodes
```

### Derived Sources

For data computed from other sources:

```yaml
  - source_id: "conflict_risk_index"
    type: "derived"
    class: "derived"
    
    inputs:
      - "usgs_seismic"
      - "ukraine_alerts" 
      - "wfp_hunger"
      
    computation:
      method_id: "risk_aggregator_v1"
      description: "Weighted combination of conflict indicators"
      formula_hash: "<sha256 of computation logic>"
      
    output:
      mode: "passthrough"
      
    query_interval: "5m"
```

---

## Methods

If you transform, summarize, or analyze data, declare your methods in full.

### Summarization Methods

```yaml
methods:
  - method_id: "visual_summary_v1"
    type: "llm"
    model: "omnipanopticon/street-summarizer-v1"
    
    # THE FULL PROMPT - no redactions, no secrets
    prompt: |
      You are observing a camera feed. Describe what you see.
      
      Include:
      - Number of people visible (do not identify individuals)
      - Vehicles (type and color only, no license plates)
      - Activity level: quiet / moderate / busy / crowded
      - Any unusual activity or events
      - Weather and lighting conditions
      
      Do not:
      - Identify specific individuals
      - Record license plates or identifying marks
      - Speculate about intent or motivation
      - Include information not directly observable
      
      Format: One paragraph, factual, present tense.
      
    prompt_hash: "<sha256 of above prompt>"
    
    # How this method is applied
    application:
      input: "video frame or short clip"
      output: "text summary"
      frequency: "every 10 seconds"
```

### Passthrough (No Transformation)

```yaml
  - method_id: "passthrough"
    type: "none"
    description: "Raw data forwarded without modification"
    transformation: "none"
```

### Analysis Methods

```yaml
  - method_id: "risk_aggregator_v1"
    type: "computation"
    description: "Weighted risk index from multiple sources"
    
    formula: |
      risk = (
        0.3 * normalize(seismic_activity) +
        0.3 * normalize(air_alerts) +
        0.2 * normalize(food_insecurity) +
        0.2 * normalize(conflict_events)
      )
    
    formula_hash: "<sha256 of formula>"
```

---

## Alert Conditions

When does your node emit alerts to the mesh?

```yaml
alerts:
  conditions:
    - name: "significant_earthquake"
      source: "usgs_seismic"
      trigger: "magnitude >= 6.0"
      priority: "high"
      
    - name: "kyiv_air_alert"
      source: "ukraine_alerts"
      trigger: "region == 'kyiv' AND active == true"
      priority: "critical"
      
    - name: "nuclear_test_signature"
      source: "usgs_seismic"
      trigger: "event_type == 'explosion' AND depth < 10 AND near_known_test_site"
      priority: "critical"
      
    - name: "unusual_local_activity"
      source: "camera_street_view_001"
      trigger: "activity_level == 'crowded' OR unusual_event == true"
      priority: "medium"
      
  delivery:
    to_mesh: true
    local_log: true
    log_retention: "permanent"
```

---

## Verification Compliance

How your node participates in verification:

```yaml
verification:
  # Random spot-checks
  spot_check:
    enabled: true
    response_sla: "10s"
    
  # Hash chain for contributions
  contribution_chain:
    enabled: true
    chain_storage: "/var/omnipanopticon/chain/"
    
  # Temporal binding
  temporal:
    enabled: true
    tolerance: "5s"
    clock_sync: "ntp"
    
  # Spatial correlation (for edge sources with location)
  spatial:
    enabled: true
    share_location: true
    precision: "10m"  # Don't reveal exact position
```

---

## Audit Compliance

How your node responds to audits:

```yaml
audit:
  # Response time commitment
  response_sla: "60s"
  
  # What raw data you retain
  retention:
    video: "24h"
    audio: "24h"
    sensor_data: "72h"
    api_responses: "7d"
    summaries: "permanent"
    
  # Where audit data is stored
  storage:
    type: "local"  # or "ipfs" or "s3"
    path: "/var/omnipanopticon/audit/"
    encryption: "none"  # Audit data must be readable
    
  # What you do when audit cannot be fulfilled
  unavailable_protocol:
    log_reason: true
    notify_mesh: true
    acceptable_reasons:
      - "retention_expired"
      - "hardware_failure"
      - "never_recorded"  # If outside your declared sources
```

---

## Resource Declaration

What resources does your node commit?

```yaml
resources:
  compute:
    summarization_capable: true
    verification_capable: true
    max_verifications_per_hour: 10
    
  bandwidth:
    upload_max: "10 Mbps"
    download_max: "50 Mbps"
    
  storage:
    audit_retention_max: "100 GB"
    chain_storage_max: "10 GB"
    
  availability:
    target_uptime: 0.95
    maintenance_window: "Sunday 02:00-04:00 UTC"
    
  location:
    region: "US-West"  # General region
    timezone: "America/Los_Angeles"
```

---

## Mesh Participation

How your node participates in the mesh:

```yaml
mesh:
  # How you discover peers
  discovery:
    method: "dht"
    fallback_seeds:
      - "seed1.omnipanopticon.example:7777"
      - "seed2.omnipanopticon.example:7777"
      
  # Your consensus participation
  consensus:
    data_consensus: true  # Vote on data validity
    protocol_consensus: true  # Vote on covenant changes (if tier >= 3)
    
  # Your verification duties
  verification_duties:
    willing_to_verify: true
    willing_to_audit: true
    
  # Your contribution to mesh health
  peer_sharing:
    enabled: true
    max_peers_shared: 50
```

---

## Change Policy

**THIS IS IMMUTABLE AFTER SIGNING**

```yaml
change_policy:
  modifications_permitted: false
  
  consequence_of_modification:
    trust_reset_to: 0
    flag: "heartbeat_mutation"
    history: "preserved but marked"
    
  additions_permitted: true  # You can ADD new sources
  addition_process:
    - "Create new source declaration"
    - "Announce to mesh"
    - "New source starts at tier 0 trust"
    - "Original sources unaffected"
    
  full_reset_permitted: true  # You can start over
  reset_process:
    - "Announce reset to mesh"
    - "Sign new heartbeat"
    - "All trust resets to tier 0"
    - "History preserved but marked 'pre-reset'"
```

---

## Attestation

**Complete this section last. Your signature binds you to everything above.**

```yaml
attestation:
  # Your identity
  node_id: "<your node_id>"
  public_key: "<your Ed25519 public key>"
  
  # The hashes that bind you
  covenant_hash: "<SHA-256 of COVENANT.md>"
  heartbeat_hash: "<SHA-256 of everything above this section>"
  
  # When you signed
  timestamp: "<ISO 8601>"
  
  # Your oath
  statement: |
    I declare this heartbeat as my node's immutable behavior contract.
    
    I will:
    - Query only the sources I have declared
    - Use only the methods I have declared
    - Respond to audits within my declared SLA
    - Maintain my contribution hash chain
    - Participate in verification as declared
    
    I understand:
    - Any modification to this heartbeat resets my trust to zero
    - My queries and contributions are permanently attributed
    - The mesh will verify my behavior against this declaration
    - There is no authority but consensus
    - There is no security but transparency
    
    I bind myself to this contract.
    So it is bound.
    
  # Your cryptographic signature over all of the above
  signature: "<Ed25519 signature>"
```

---

## Computing Your Heartbeat Hash

Before signing, compute the hash of your declaration:

```bash
# Extract everything above the Attestation section
# This becomes your heartbeat_hash

cat HEARTBEAT.md | sed '/^## Attestation/,$d' | sha256sum

# Example output:
# a1b2c3d4e5f6... (64 hex characters)
```

Include this hash in your attestation. The mesh will verify:
1. Your current heartbeat hashes to your declared `heartbeat_hash`
2. Your behavior matches your heartbeat declaration
3. Any discrepancy flags you for audit or trust reset

---

## You Are Now Ready

1. ✅ Completed your HEARTBEAT.md
2. ✅ Computed your heartbeat_hash
3. ✅ Read and understood COVENANT.md
4. ⏳ Sign both and announce to mesh
5. ⏳ Begin operating as declared
6. ⏳ Build trust through consistency

Welcome to the Omnipanopticon.

*The mesh sees all. Including itself.*

*So it is bound.*
