# Caprigo — ROCm measurement log (verbatim)

**Instance:** `u-14549-080f238e` · template `CaprigoAI Harness Test`  
**Image:** `vllm-dev:rocm7.2.1_navi_ubuntu22.04_py3.10_pytorch_2.9_vllm_0.16.0`  
**Captured:** 2026-08-04 · instance **destroyed** after capture  

## A. GPU identity (`rocm-smi`)

```
Device 0 · DID 0x744b · Temp ~26–31°C · PwrCap 241W · gfx1100 class
During 0.5B serve: ~94W · 87% VRAM
After 7B serve idle sample: ~21W · 91% VRAM
```

## B. vLLM models endpoint (7B)

```json
{"id":"Qwen/Qwen2.5-7B-Instruct","max_model_len":8192,...}
```

Load notes from engine log:

- Model loading took **14.37 GiB** · ~165 s  
- Graph capturing finished · init engine ~39 s  
- GPU KV cache size: 504,064 tokens · max concurrency @ 8192: ~61×  

## C. Timed decode (temperature=0, max_tokens=128)

### 0.5B smoke

```
model=Qwen/Qwen2.5-0.5B-Instruct
completion_tokens=128
wall_s=0.595
tok_per_s=215.04
```

### 7B apples-to-apples (vs scrap ~19 tok/s)

```
model=Qwen/Qwen2.5-7B-Instruct
completion_tokens=128
wall_s=4.382
tok_per_s=29.21
```

Method: `POST /v1/chat/completions` · wall clock around request · `tok/s = completion_tokens / wall_s`.

## D. Scrap reference (not this instance)

| Source | Result |
|--------|--------|
| rx580-vulkan-agents lived proof | 7B Q4 @32k ~**19** tok/s |
| `artifacts/bench-agent-delta.csv` | Caprigo Session lean · **31287 ms** · ok · 17 tools |

## E. Repro

See `REPRODUCTION_README.md` and `scripts/measure_vllm_toks.py`.
