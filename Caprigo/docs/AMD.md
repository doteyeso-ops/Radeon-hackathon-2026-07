# Caprigo on AMD — ROCm Delta Benchmark Results

**Credit:** b_Radford · Vibes-Coded · [caprigoai.com](https://caprigoai.com)  
**Track:** Track 2 — Agentic AI · Hackathon 2026-08  
**Cloud account:** 10 Radeon Cloud credits confirmed (`radeon-global.anruicloud.com`)

---

## 1. Scrap Baseline (RX 580 Polaris — Legacy Hardware)

Unsupported by modern ROCm. Verified working:

| Workload | Hardware | Result |
|----------|----------|--------|
| 3B–7B Q4 decode | RX 580 8GB · Windows · Vulkan | **~15–24 tok/s** |
| 7B @ 32k context | RX 580 | **~19 tok/s · ~5.1 GB VRAM** |
| Caprigo Session (lean tools) | RX 580 | **~31 s OK path** |

Full writeup + CSVs: `doteyeso-ops/rx580-vulkan-agents`  
Demo video: `docs/demo/Caprigo_AMD_Demo.mp4`

---

## 2. ROCm Radeon Cloud Instance (Verified)

**Instance launched:** ✅ `u-14549-080f238e`  
**Credits remaining:** 9 (1 consumption for instance launch)

| Property | Value |
|----------|-------|
| GPU | gfx1100 (RDNA 3) |
| GPU Temp | 27.0°C · 10.0W · 0% util |
| Image | `vllm-dev:rocm7.2.1_navi_ubuntu22.04_py3.10_pytorch_2.9_vllm_0.16.0` |
| vLLM serving | `Qwen/Qwen2.5-0.5B-Instruct` on port 8000 |
| SSH Access | Port 31358 · Key: `keys/caprigo_radeon` |
| Source | `/workspace/caprigo/` cloned |
| Environment | `CAPRIGO_LEAN_TOOLS=1` · `DEFAULT_MODEL=qwen2.5-coder:7b` |

---

## 3. Benchmark Results Table (TO BE FILLED)

Run `./scripts/run_rocm_delta.sh` in the cloud instance to populate:

| Metric | Scrap (RX 580) | ROCm (Radeon) | **Improvement** |
|--------|----------------|---------------|-----------------|
| Decode tok/s (7B Q4) | 15–24 | *pending* | *pending* |
| Session time (31s path) | ~31s | *pending* | *pending* |
| VRAM usage (7B) | ~5.1 GB | *pending* | *pending* |
| Gateway startup | N/A | *pending* | - |

**Expected outcome:** ROCm Radeon should show **2–3x tok/s improvement** and **~50% VRAM efficiency gain** over scrap.

**Results file:** `artifacts/delta.csv`

---

## 4. Benchmark Harness

Location: `scripts/run_rocm_delta.sh`

Usage:
```bash
# On Radeon Cloud instance
./scripts/run_rocm_delta.sh --model qwen2.5-coder:7b --output artifacts/delta.csv
```

Options:
- `--model`: Model to benchmark (default: qwen2.5-coder:7b)
- `--output`: Output CSV path

---

## 5. Next Steps (Credits Required)

| Step | Credits | Description |
|------|---------|-------------|
| 1. Launch ROCm instance | 1 | Template `CaprigoAI Harness Test` saved |
| 2. Run benchmark | 0 | Same script as scrap baseline |
| 3. Record session | 0 | Agent completes same task |
| **TOTAL** | **1** | Remaining 9 credits reserved |

---

## 6. Credit Optimization Strategy

**Preserving credits for post-submission:**
- 1 credit for core benchmark (already spent when launched)
- 2 credits reserve for additional model sizes (7B, 14B)
- 3 credits for extended stress tests
- 4 credits remaining for judging if request sent

**Efficient credit usage:**
- vLLM 0.16 supports continuous batch scheduling
- Single instance can serve multiple models (load/unload)
- No need to persist instance; destroy after data capture

---

## 7. Reproduction Instructions

For local reproduction:

```bash
git clone https://github.com/doteyeso-ops/caprigo.git
cd caprigo
cp .env.example .env
npm install
npm run build
npm run start

# Scrap baseline
export CAPRIGO_LEAN_TOOLS=1
export CAPRIGO_LLM_PROVIDER=ollama
```

For ROCm reproduction:
1. Launch template on Radeon Cloud
2. SSH in (`ssh -p <port> <user>@<host>`)
3. Run benchmark harness

---

## 8. Evidence Checklist

| Item | Status | Location |
|------|--------|----------|
| Instance verification | ✅ | Section 2 |
| Baseline numbers | ✅ | Section 1 |
| Delta CSV | ⏳ | `artifacts/delta.csv` (pending benchmark) |
| Full session trace | ⏳ | Will capture via API logs |
| Supplementary video | ⏳ | ROCm-run segment (credit-dependent) |

---

**Contact:** b_Radford (`doteyeso@gmail.com`) · Deadline: **August 6, 2026 8:59 AM PDT**