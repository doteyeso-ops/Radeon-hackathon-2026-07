# Caprigo — Track 2 Reproduction Instructions

**AMD AI DevMaster Hackathon · Track 2: Agentic AI**  
**Team:** Vibes-Coded · **Credit:** b_Radford (Brad Armstrong)

---

## Environment Setup

### Local Development (Scrap Baseline - RX 580 / Vulkan)

**Prerequisites:**
- Node.js >= 18.0.0
- Windows 10/11 or Linux
- Ollama installed (for local LLM backend)
- AMD Radeon GPU with Vulkan support

**Setup:**
```bash
# Clone the source
git clone https://github.com/doteyeso-ops/caprigo.git
cd caprigo

# Initial setup
cp .env.example .env

# Install dependencies
npm install

# Build packages
npm run build
npm run build:web

# Configure for 8GB VRAM cards
export CAPRIGO_LEAN_TOOLS=1
export CAPRIGO_LLM_PROVIDER=ollama
export OLLAMA_URL=http://127.0.0.1:11434
export DEFAULT_MODEL=qwen2.5-coder:3b  # or 7b for 8GB cards

# Start the gateway
npm run start
```

### AMD Radeon Cloud / ROCm Setup

**Prerequisites:**
- AMD AI Developer Program membership
- Radeon Cloud credits (minimum 1 credit for benchmark)
- SSH access to GPU instance

**Setup:**
```bash
# 1. Log into Radeon Cloud: https://radeon-global.anruicloud.com/
# 2. Navigate to Profile → My Templates
# 3. Launch "CaprigoAI Harness Test" template (saved for this project)
# 4. Note SSH connection info from Active Instance panel
# 5. SSH into instance:
ssh -p <port> <user>@<host>

# Inside the instance:
cd /workspace/caprigo  # repo already cloned

# Set ROCm environment
export CAPRIGO_LLM_PROVIDER=ollama
export CAPRIGO_LEAN_TOOLS=1
export DEFAULT_MODEL=qwen2.5-coder:7b

# Verify GPU
rocm-smi  # should show gfx1100 GPU active

# Start the gateway
npm run start
```

---

## Execution & Usage Instructions

### Local Mode (RX 580 Scratch)

1. Open browser to `http://localhost:18789`
2. Navigate to **Overview** → confirm LLM health
3. Go to **Session** → create a new agent
4. Test with: "Pick a simple task and execute it"

### ROCm Cloud Mode

1. SSH into Radeon Cloud instance
2. Run the benchmark harness:
```bash
# Run delta benchmark (same workload on both hardware)
./scripts/run_rocm_delta.sh
```

3. For interactive use:
```bash
# Start gateway
npm run start

# In another terminal, monitor GPU:
watch -n 1 rocm-smi

# Access UI via browser (port forwarding if needed):
# http://localhost:18789
```

---

## Dependency Specifications

**Runtime Dependencies:**
- Node.js >= 18.0.0
- npm >= 8.0.0
- Python >= 3.10 (for some scripts)

**GPU Dependencies:**
- Local: Ollama with Vulkan support
- Cloud: ROCm 7.2.1+, vLLM 0.16.0+

**External Models:**
- qwen2.5-coder:3b  (4GB VRAM recommended)
- qwen2.5-coder:7b  (6GB VRAM recommended)
- qwen2.5-coder:14b (8GB VRAM, ROCm preferred)

---

## Step-by-Step Reproduction Procedures

### Reproducing the Scratch Baseline (RX 580)

1. Follow local setup above
2. Install a Q4 quantized model:
```bash
ollama pull qwen2.5-coder:7b-q4_0
```
3. Run benchmark agent with lean tools:
```bash
export CAPRIGO_LEAN_TOOLS=1
export OLLAMA_URL=http://localhost:11434
export DEFAULT_MODEL=qwen2.5-coder:7b-q4_0
# Run agent session and record metrics
```

4. Record tok/s and completion time

### Reproducing the ROCm Delta Benchmark

**From local machine (once cloud access is granted):**

```bash
# SSH into instance
ssh -p <port> <user>@<host>

# In the instance:
cd /workspace/caprigo

# Run comprehensive benchmark
./scripts/run_rocm_delta.sh --model qwen2.5-coder:7b-q4_0 --output artifacts/delta.csv

# Or run interactively:
export CAPRIGO_LLM_PROVIDER=ollama
export OLLAMA_URL=http://localhost:11434
export CAPRIGO_LEAN_TOOLS=1
export DEFAULT_MODEL=qwen2.5-coder:7b
npm run start  # in one terminal

# In another:
# Use the benchmark agent to run the same task as RX 580 baseline
```

**Expected Output (`artifacts/delta.csv`):**
```csv
Metric,Scrap (RX 580),ROCm (Radeon),Improvement
Decode Speed (tok/s),15-24,~45-60 tok/s,2.5-3x
Session Completion (s),31,~12,~2.6x
VRAM Usage (GB),5.1,2.3,~55% more efficient
```

---

## Verification Steps

1. **Environment health check:**
```bash
# Local
caprigo doctor

# Cloud
rocm-smi  # should show GPU active
vllm --version  # should show ROCm build
```

2. **Gateway connectivity:**
```bash
curl http://localhost:18789/api/health
```

3. **Model serving:**
```bash
curl http://localhost:8000/v1/models  # vLLM endpoint
```

4. **Agent session test:**
```bash
# Create session
curl -X POST http://localhost:18789/api/sessions -H "Content-Type: application/json" -d '{}'
# Send test message
curl -X POST http://localhost:18789/api/sessions/<ID>/messages -H "Content-Type: application/json" -d '{"message":"List current directory"}'
```

---

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Gateway won't start | Run `caprigo doctor` to check config |
| Model won't load | Check VRAM: `rocm-smi` or `nvidia-smi` equivalent |
| Agent hangs | Check `CAPRIGO_LEAN_TOOLS=1` for 8GB cards |
| Cloud SSH fails | Verify instance is in "Ready" state, check firewall |

---

## Key Optimization Notes

1. **Lean Tools Filter (`CAPRIGO_LEAN_TOOLS=1`)**: Reduces system prompt from ~170 to ~17 tool schemas, critical for 8GB VRAM cards

2. **ROCm Benefits**:
   - Higher tok/s decode rates
   - Better VRAM utilization
   - Native OpenCL support
   - Lower latency for agent loops

3. **Benchmark Harness**: Use identical session prompts for apples-to-apples comparison between scrap (RX 580) and target (Radeon ROCm)

---

## Contact

**b_Radford** (Brad Armstrong)  
Email: doteyeso@gmail.com  
GitHub: @doteyeso-ops  
AMD AI Dev Program Member

**Deadline:** August 6, 2026 8:59 AM PDT