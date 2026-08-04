# Caprigo — Winning Narrative (Judge Quick-Read)

Track 2 rewards agentic product + **AMD Radeon/ROCm optimization (40%)**. Caprigo is a real local agent runtime (Session / Board / tools / MCP), not a bench-only demo, with a measured scrap→supported decode delta.

## The 40% lever

| Scrap (unsupported Polaris) | Supported (contest Radeon Cloud) |
|-----------------------------|----------------------------------|
| RX 580 · Ollama · Vulkan · 7B Q4 ~**19** tok/s | gfx1100 · vLLM ROCm 7.2.1 · Qwen2.5-7B-Instruct **29.21** tok/s (~**1.5×**) |

Agent-side optimization: `CAPRIGO_LEAN_TOOLS=1` cuts ~170 → ~17 tool schemas so 8GB scrap can run agents; same flag on ROCm.

## Packet

- Spec: `docs/PROJECT_SPEC.md`
- Delta: `docs/AMD.md` + `artifacts/delta.csv`
- Source: https://github.com/doteyeso-ops/caprigo
- Demo: Caprigo demo MP4 (~72s)
- Poster: `docs/POSTER.md`

## Honest notes

- Demo shorter than the 3–5 min recommendation.
- Cloud instance destroyed after measurement (results retained in repo).
- Caprigo Session scrap ~31s measured; ROCm Session wall-clock not re-run — decode tok/s is the published cloud delta.

— b_Radford · `doteyeso@gmail.com`
