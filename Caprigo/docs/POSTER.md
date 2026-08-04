# Caprigo — Track 2 one-pager

**Local-first agent runtime · scrap RX 580 → Radeon/ROCm**

| | |
|-|-|
| Track | 2 Agentic AI · **40% = measured AMD delta** |
| Team | Vibes-Coded · **b_Radford** |
| Code | https://github.com/doteyeso-ops/caprigo (MIT) |
| Baseline | https://github.com/doteyeso-ops/rx580-vulkan-agents |
| Demo | Caprigo `docs/demo/Caprigo_AMD_Demo.mp4` |

## Measured delta

| Scrap RX 580 Vulkan | ROCm gfx1100 vLLM |
|---------------------|-------------------|
| 7B Q4 ~**19** tok/s | Qwen2.5-7B-Instruct **29.21** tok/s |
| | **~1.5×** uplift |

Also: lean tools (`CAPRIGO_LEAN_TOOLS=1`) · backend-agnostic gateway · Session/Board operator UX.

Full table: `docs/AMD.md` · CSV: `artifacts/delta.csv`
