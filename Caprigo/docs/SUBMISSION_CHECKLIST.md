# Caprigo — Track 2 Competitive Submission Checklist

**Competition:** AMD AI DevMaster Hackathon · Track 2 — Agentic AI  
**Deadline:** Aug 6, 2026 8:59 AM PDT  
**Team:** Vibes-Coded (solo) · **Credit:** b_Radford (doteyeso@gmail.com)  
**App:** Caprigo · **Repo:** https://github.com/doteyeso-ops/caprigo · MIT  
**Cloud status:** 10 credits confirmed · instance launch blocked by temporary maintenance · ready to launch when cleared.

---

## Track 2 Scoring (40% = measured delta)

| Requirement | Evidence | Status |
|---|---|---|
| 1. Project spec (scenarios, architecture, core capabilities, model/deployment, AMD optimization) | `docs/PROJECT_SPEC.md` | COMPLETE |
| 2. Source code (complete repo) | `Caprigo/src/` (cloned upstream) + this folder | COMPLETE |
| 3. Demo video (3–5 min, actual operation + AMD GPU) | `Caprigo/docs/AMD.md` links upstream video (`docs/demo/Caprigo_AMD_Demo.mp4`) | REFERENCED (video hosted upstream; will supplement with ROCm-run recording when instance launches) |
| 4. Supplementary (PPT / Poster) | `docs/POSTER.md` + this file | COMPLETE |
| **40% optimization / measured delta** | `docs/AMD.md` has scrap baseline + harness; ROCm results pending instance | **PENDING (blocked by cloud maintenance)** |

---

## Innovation & technical contribution (judge-facing highlights)

1. **Lean-tool filter (`CAPRIGO_LEAN_TOOLS=1`)** — reduces agent system prompt from ~170 → ~17 schemas. This is not cosmetic: on 8 GB VRAM it directly determines whether the agent can hold context + model weights without CPU spill.
2. **Scrap → supported measured harness** — same `bench_agent_delta.ps1` workload runs on unsupported Polaris (RX 580 Vulkan) AND target ROCm Radeon. Judges get an apples-to-apples number, not a vibe claim.
3. **Backend-agnostic gateway** — agent code unchanged when backend swaps (Ollama → vLLM → any OpenAI-compatible endpoint). Enables rapid cloud evaluation.
4. **Permission hardening** — filesystem scoped to approved paths, blocked shell commands, `~/.caprigo/permissions.json`. Production-grade, not demo-grade.
5. **Trace/replay layer** — lightweight execution log export (markdown/JSON) for evaluator auditability.

---

## What is done (no cloud needed)

- [x] Canonical source cloned (`Caprigo/src/`)
- [x] `docs/PROJECT_SPEC.md` completed
- [x] `docs/POSTER.md` completed
- [x] `docs/AMD.md` updated with scrap baseline, harness description, pending table
- [x] SSH key (`keys/caprigo_radeon.pub`) saved for future instance
- [x] Template `CaprigoAI Harness Test` saved on portal (`ROCm vLLM-dev` + Notebook + SSH enabled)
- [x] `scripts/run_rocm_delta.sh` harness script ready
- [x] `docs/AMD.md` delta table ready to fill once instance is live

---

## What is blocked (requires instance launch — maintenance in progress)

- [ ] Launch instance when credit redemption resumes
- [ ] SSH into instance (`ssh -p <port> ...`)
- [ ] Run harness (`run_rocm_delta.sh` or manual equivalent)
- [ ] Record tok/s + latency results in `docs/AMD.md`
- [ ] Attach CSV to `Caprigo/artifacts/`
- [ ] Optionally extend demo video with ROCm-run segment
- [ ] Push final branch / open PR with title format: `"Track 2, Vibes-Coded, Caprigo"`

---

## Winning strategy (post-maintenance execution plan)

When maintenance clears (estimated: retry within 24h or contact administrator):

1. Launch `CaprigoAI Harness Test` (burn 1 credit).
2. Copy SSH connection info from instance page.
3. SSH in, clone/update caprigo source, set env (`CAPRIGO_LLM_PROVIDER=ollama`, `CAPRIGO_LEAN_TOOLS=1`, point at vLLM endpoint if serving; else manual vLLM start).
4. Run same Session workload used for RX 580 baseline.
5. Fill `docs/AMD.md` table + write `Caprigo/artifacts/delta.csv`.
6. Confirm results match (or exceed) scrap numbers with more headroom; document any anomalies honestly.
7. Push commit to `track2-caprigo` branch and submit PR before Aug 6 8:59 AM PDT.

---

## Honest disclosure (required for judge trust)

- No fabricated results. The ROCm delta table in `docs/AMD.md` is explicitly labeled `*pending instance launch*`.
- The upstream demo video (`Caprigo_AMD_Demo.mp4`) is the current video evidence; a supplementary ROCm-run clip will be added after cloud execution.
- All optimization claims (`lean-tool filter`, `permission hardening`, `trace replay`) are observable in source (`Caprigo/src/`) and documented.

---

— b_Radford / Vibes-Coded · `doteyeso@gmail.com` · Deadline: Aug 6, 2026 8:59 AM PDT
