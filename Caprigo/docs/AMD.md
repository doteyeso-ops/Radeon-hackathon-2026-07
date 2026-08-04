# Caprigo on AMD — ROCm Delta Benchmark Results

**Credit:** b_Radford · Vibes-Coded · [caprigoai.com](https://caprigoai.com)  
**Track:** Track 2 — Agentic AI · Hackathon 2026-08  
**Cloud:** Radeon Cloud · instance `u-14549-080f238e` · template `CaprigoAI Harness Test`

---

## 1. Scrap baseline (RX 580 Polaris — Vulkan)

| Workload | Hardware | Result |
|----------|----------|--------|
| 3B–7B Q4 decode | RX 580 8GB · Windows · Vulkan | **~15–24 tok/s** |
| 7B Q4 @ 32k context | RX 580 | **~19 tok/s · ~5.1 GB VRAM** |
| Caprigo Session (lean tools) | RX 580 · `b_Radford-coder-3b-128k` | **~31 s OK path** |

Evidence: https://github.com/doteyeso-ops/rx580-vulkan-agents  
Demo: https://github.com/doteyeso-ops/caprigo/blob/main/docs/demo/Caprigo_AMD_Demo.mp4

---

## 2. ROCm Radeon Cloud (measured 2026-08-04)

| Property | Value |
|----------|-------|
| GPU | gfx1100 (DID `0x744b`) via `rocm-smi` |
| Image | `vllm-dev:rocm7.2.1_navi_ubuntu22.04_py3.10_pytorch_2.9_vllm_0.16.0` |
| Runtime | vLLM serve · OpenAI-compatible `:8000` |
| Model (this run) | `Qwen/Qwen2.5-0.5B-Instruct` · `max_model_len` 32768 |
| During decode | ~94 W · **87% VRAM** reserved (`gpu-memory-utilization 0.9`) |

### Timed chat completion (same host)

| Metric | Value |
|--------|-------|
| `completion_tokens` | 128 |
| wall clock | **0.595 s** |
| **decode tok/s (wall)** | **215.0** |
| Prompt | short ROCm paragraph request · `temperature=0` · `max_tokens=128` |

Artifact on instance: `/workspace/rocm_delta_result.txt`  
CSV mirror: [`artifacts/delta.csv`](../artifacts/delta.csv)

> **Fairness note:** scrap headline is **7B Q4 ~19 tok/s**; this ROCm row is **0.5B Instruct** (fast smoke proving the ROCm/vLLM path). Same Caprigo gateway can point at a 7B when HF weights are pulled; method is identical (`/v1/chat/completions`).

---

## 3. Delta table (as measured)

| Metric | Scrap (RX 580) | ROCm (Radeon Cloud) | Notes |
|--------|----------------|---------------------|--------|
| Path | Ollama · Vulkan · Polaris | vLLM 0.16 · ROCm 7.2.1 · gfx1100 | Supported stack |
| Model class | 7B Q4 (headline) | 0.5B Instruct (measured) | Different size — labeled |
| Decode tok/s | **~19** (7B@32k) | **215** (0.5B, 128 tok) | ROCm path live |
| Caprigo Session | **~31 s** lean tools | *gateway loop pending* | Env ready for same harness |
| GPU util proof | Vulkan0 lived pack | `rocm-smi` + vLLM logs | Screenshots / terminal capture |

---

## 4. How to reproduce

```bash
# On Radeon Cloud Jupyter/SSH terminal
/opt/venv/bin/vllm serve Qwen/Qwen2.5-0.5B-Instruct \
  --host 127.0.0.1 --port 8000 --gpu-memory-utilization 0.9

# Then timed client (see /workspace/rocm_delta_result.txt pattern)
curl -s http://127.0.0.1:8000/v1/models
# POST /v1/chat/completions max_tokens=128 → wall tok/s = completion_tokens / wall_s
```

Caprigo agent path (same OpenAI-compatible URL):

```bash
export CAPRIGO_LEAN_TOOLS=1
# point gateway OpenAI base URL at http://127.0.0.1:8000/v1
```

Harness script: [`scripts/run_rocm_delta.sh`](../scripts/run_rocm_delta.sh)

---

## 5. Why this matters for Track 2 (40% AMD optimization)

1. **Scrap → supported** is real: Polaris/Vulkan agents already ship; Radeon Cloud ROCm/vLLM is the uplift path.  
2. **Lean tools** (`CAPRIGO_LEAN_TOOLS=1`) keeps agent schemas viable on 8GB scrap and transfers unchanged to ROCm.  
3. **Measured decode** on contest hardware (not a slide claim).

— b_Radford / Vibes-Coded · deadline Aug 6, 2026 8:59 AM PDT
