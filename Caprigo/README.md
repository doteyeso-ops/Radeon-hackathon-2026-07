# Caprigo — AMD AI DevMaster Hackathon (Track 2: Agentic AI)

| | |
|-|-|
| **Track** | 2 — Agentic AI |
| **Team** | Vibes-Coded (solo) |
| **Credit** | **b_Radford** · Brad Armstrong · `doteyeso@gmail.com` |
| **App** | Caprigo (MIT) |
| **PR title** | `Track 2, Vibes-Coded, Caprigo` |
| **Deadline** | Aug 6, 2026 8:59 AM PDT |

Local-first agent runtime (Overview / Session / HUD Board) with tools, MCP, missions. Scrap baseline: **RX 580 · Ollama · Vulkan**. Supported path: **Radeon Cloud · ROCm · vLLM**. Measured scrap→ROCm decode delta addresses **40% of Track 2 scoring**.

## Headline measured delta

| | Scrap RX 580 Vulkan | ROCm gfx1100 vLLM |
|--|---------------------|-------------------|
| Model class | 7B Q4 | **Qwen2.5-7B-Instruct** |
| Decode tok/s | **~19** | **29.21** |
| Uplift | | **~1.5×** |

Details + CSV: [`docs/AMD.md`](docs/AMD.md) · [`artifacts/delta.csv`](artifacts/delta.csv)  
Instance used for measurement destroyed after capture (credits preserved).

## Track 2 packet map

| Contest requirement | Location |
|---------------------|----------|
| Project specification | [`docs/PROJECT_SPEC.md`](docs/PROJECT_SPEC.md) |
| Complete source | **https://github.com/doteyeso-ops/caprigo** (MIT) — not vendored here |
| Demo video | https://github.com/doteyeso-ops/caprigo/blob/main/docs/demo/Caprigo_AMD_Demo.mp4 (~72s VO; contest recommends 3–5 min) |
| Supplementary poster | [`docs/POSTER.md`](docs/POSTER.md) |
| Reproducibility | [`docs/REPRODUCTION_README.md`](docs/REPRODUCTION_README.md) |
| Checklist | [`docs/SUBMISSION_CHECKLIST.md`](docs/SUBMISSION_CHECKLIST.md) |
| Scrap lived proof | https://github.com/doteyeso-ops/rx580-vulkan-agents |

## Quick start (scrap / local)

```bash
git clone https://github.com/doteyeso-ops/caprigo && cd caprigo
# see upstream README for monorepo install
export CAPRIGO_LEAN_TOOLS=1
export CAPRIGO_LLM_PROVIDER=ollama
export OLLAMA_URL=http://127.0.0.1:11434
```

## Radeon Cloud / ROCm (reproduce delta)

Follow contest [Radeon-Cloud-User Guide](../Radeon-Cloud-User%20Guide/README.md). Same AMD AI Developer Program email. Serve with vLLM, time `/v1/chat/completions` as in `docs/AMD.md`.

— b_Radford / Vibes-Coded
