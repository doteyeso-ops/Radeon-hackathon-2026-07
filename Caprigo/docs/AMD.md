# Caprigo on AMD — ROCm Delta Benchmark Results

**Credit:** b_Radford · Vibes-Coded · [caprigoai.com](https://caprigoai.com)  
**Track:** Track 2 — Agentic AI · Hackathon 2026-08  
**Cloud:** Radeon Cloud · instance `u-14549-080f238e` · template `CaprigoAI Harness Test`

---

## Headline delta (apples-to-apples · ~7B class)

| | Scrap RX 580 (Vulkan) | ROCm Radeon Cloud (vLLM) | Δ |
|--|----------------------|---------------------------|--|
| Model | 7B Q4 lived proof | **Qwen/Qwen2.5-7B-Instruct** | same class |
| Decode tok/s | **~19** (7B@32k) | **29.21** (128 completion tokens / 4.382 s) | **~1.5×** |
| Stack | Ollama · Vulkan · Polaris (unsupported ROCm) | vLLM 0.16 · ROCm 7.2.1 · **gfx1100** | supported |
| VRAM during serve | ~5.1 GB (7B Q4 @32k) | **91%** reserved (`gpu-memory-utilization 0.9`, max-model-len 8192) | — |

Also measured on same instance: **0.5B Instruct → 215 tok/s** (smoke / path proof).

---

## 1. Scrap baseline (RX 580 Polaris — Vulkan)

| Workload | Result |
|----------|--------|
| 3B–7B Q4 decode | **~15–24 tok/s** |
| 7B Q4 @ 32k | **~19 tok/s · ~5.1 GB VRAM** |
| Caprigo Session (lean tools) | **~31 s OK** |

Evidence: https://github.com/doteyeso-ops/rx580-vulkan-agents  
Demo: https://github.com/doteyeso-ops/caprigo/blob/main/docs/demo/Caprigo_AMD_Demo.mp4

---

## 2. ROCm run log (2026-08-04)

| Property | Value |
|----------|-------|
| GPU | gfx1100 · DID `0x744b` |
| Image | `vllm-dev:rocm7.2.1_navi_ubuntu22.04…vllm_0.16.0` |
| Load | 7B weights **14.37 GiB** · load ~165 s · graph capture ~39 s init |
| Endpoint | `http://127.0.0.1:8000/v1` · `max_model_len` 8192 |

### Timed `/v1/chat/completions` (temperature=0, max_tokens=128)

| Model | completion_tokens | wall_s | **tok/s** |
|-------|-------------------|--------|-----------|
| Qwen2.5-0.5B-Instruct | 128 | 0.595 | **215.04** |
| **Qwen2.5-7B-Instruct** | 128 | 4.382 | **29.21** |

Artifacts: `/workspace/rocm_delta_result.txt`, `/workspace/rocm_delta_7b.txt`  
CSV: [`artifacts/delta.csv`](../artifacts/delta.csv)

---

## 3. Caprigo / Track 2 optimization hooks

- **`CAPRIGO_LEAN_TOOLS=1`** — ~170 → ~17 tool schemas (scrap 8GB survival; same flag on ROCm).
- Backend-agnostic gateway — point OpenAI base URL at vLLM `:8000/v1` without rewriting agent code.
- Same harness method scrap ↔ cloud.

---

## 4. Reproduce

```bash
/opt/venv/bin/vllm serve Qwen/Qwen2.5-7B-Instruct \
  --host 127.0.0.1 --port 8000 \
  --gpu-memory-utilization 0.90 --max-model-len 8192

# then POST /v1/chat/completions max_tokens=128 → tok/s = completion_tokens / wall_s
```

— b_Radford / Vibes-Coded · Aug 6, 2026 8:59 AM PDT deadline
