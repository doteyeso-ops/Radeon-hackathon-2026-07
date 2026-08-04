# Caprigo — Track 2 one-pager

**Local-first agent runtime · scrap RX 580 → Radeon/ROCm · measured ~1.5×**

| | |
|-|-|
| Track | 2 Agentic AI · **40% = AMD delta** · 60% = agent product |
| Team | Vibes-Coded · **b_Radford** |
| Code | https://github.com/doteyeso-ops/caprigo (MIT) |
| Judge start | `docs/JUDGING_SCORECARD.md` |

## Numbers

| Scrap RX 580 Vulkan | ROCm gfx1100 vLLM |
|---------------------|-------------------|
| 7B Q4 ~**19** tok/s | Qwen2.5-7B-Instruct **29.21** tok/s |
| Session lean ~**31 s** | Decode delta published · method in `MEASUREMENT_LOG.md` |

## Product edge

Overview · Session · Board · tools/MCP · **`CAPRIGO_LEAN_TOOLS=1`** (~170→17 schemas) · backend-agnostic gateway.

Demo: Caprigo `docs/demo/Caprigo_AMD_Demo.mp4` (+ `DEMO_WALKTHROUGH.md`)
