# Caprigo — AMD AI DevMaster Hackathon (Track 2: Agentic AI)

| | |
|-|-|
| **Track** | 2 — Agentic AI |
| **Team** | Vibes-Coded (solo) |
| **Credit** | **b_Radford** · Brad Armstrong |
| **App** | Caprigo |
| **License** | MIT |
| **Deadline** | Aug 6, 2026 8:59 AM PDT |

Local-first agent runtime (Overview / Session / HUD Board) with tools, MCP, missions, and offline scripts. Scrap baseline runs on a PowerColor **RX 580** via **Ollama + Vulkan**. Same agent loops target **AMD Radeon + ROCm** (and Lemonade / Halo) for measured scrap→supported delta (**40% of Track 2 score**).

## Canonical source (complete code)

**https://github.com/doteyeso-ops/caprigo**

- AMD notes: https://github.com/doteyeso-ops/caprigo/blob/main/docs/AMD.md  
- Demo MP4 (~72s, VO): https://github.com/doteyeso-ops/caprigo/blob/main/docs/demo/Caprigo_AMD_Demo.mp4  
- Product site: https://caprigoai.com/

## Lived proof baseline (Polaris scrap)

**https://github.com/doteyeso-ops/rx580-vulkan-agents**

| Metric | Result |
|--------|--------|
| Hardware | RX 580 8GB · Ryzen 5 2600 · Windows · Vulkan |
| 3B–7B Q4 decode | ~15–24 tok/s |
| 7B Q4 @ 32k ctx | ~19 tok/s · ~5.1 GB VRAM |
| Caprigo Session (lean tools) | scrap ok ~31s on `b_Radford-coder-3b-128k` |

Delta harness: [`bench_agent_delta.ps1`](https://github.com/doteyeso-ops/rx580-vulkan-agents/blob/main/scripts/bench_agent_delta.ps1) — fill **after** on Radeon Cloud / ROCm.

## Submission packet (this folder)

| File | Requirement |
|------|-------------|
| [docs/PROJECT_SPEC.md](docs/PROJECT_SPEC.md) | Track 2 project specification |
| [docs/POSTER.md](docs/POSTER.md) | Supplementary one-pager |
| This README | Source + demo + setup pointers |

## Quick start (local AMD / Vulkan scrap)

```bash
git clone https://github.com/doteyeso-ops/caprigo
cd caprigo
# see repo README for monorepo install
# point gateway at Ollama (Vulkan) or OpenAI-compatible ROCm endpoint
export CAPRIGO_LLM_PROVIDER=ollama
export OLLAMA_URL=http://127.0.0.1:11434
export CAPRIGO_LEAN_TOOLS=1
```

Lean tools cut unrestricted agent tool dumps from ~170 → ~17 schemas — critical for 8GB / short-ctx local models.

## Radeon Cloud / ROCm

Follow upstream [Radeon-Cloud-User Guide](../Radeon-Cloud-User%20Guide/README.md). Use the **same email** as AMD AI Developer Program. After access: run the same Session workload, record tok/s + latency in `docs/AMD.md` / delta CSV.

— b_Radford / Vibes-Coded · `doteyeso@gmail.com` · GitHub `doteyeso-ops`
