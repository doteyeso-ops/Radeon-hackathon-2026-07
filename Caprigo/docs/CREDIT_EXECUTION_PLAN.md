# Caprigo — Track 2 Credit Execution Plan

**Deadline:** August 6, 2026 8:59 AM PDT (~2.5 days remaining)

---

## Credits Available: 10 Radeon Cloud Credits

### Phase 1: Core Submission (1 credit) ✅
**Action:** Launch ROCm instance + run benchmark
- [x] Template `CaprigoAI Harness Test` already saved
- [x] Instance `u-14549-080f238e` verified on portal
- [ ] Run benchmark harness
- [ ] Fill delta.csv with results
- [ ] Update AMD.md with tok/s numbers

### Phase 2: Score Enhancement (4 credits) ⏳
**If credits remain after Phase 1:**

| Credit | Action | Value |
|--------|--------|-------|
| 2 | 7B model benchmark | Show ROCm scale advantage |
| 1 | 14B model test | Demonstrate VRAM efficiency |
| 1 | Consistency runs (2x) | Statistical confidence |

### Phase 3: Judge Experience (3 credits) ⏳
| Credit | Action |
|--------|--------|
| 1 | Supplemental demo recording |
| 1 | Extended session video |
| 1 | Reserved for troubleshooting |

---

## Immediate Actions (No Credits Required)

### 1. Free Tier Experiment (Option 1 from User Guide)
Use shared Qwen/DeepSeek APIs for demonstration:

```bash
# Get API key from: https://developer.amd.com.cn/radeon/modelapis
curl https://developer.amd.com.cn/radeon/api/v1/chat/completions \
  -H "Authorization: Bearer <API_KEY>" \
  -H "Content-Type: application/json" \
  -d '{"model":"Qwen3.6-35B-A3B","messages":[{"role":"user","content":"Write a Python fibonacci function"}]}'
```

### 2. Architecture Diagram (Create locally)
Generate visual showing:
- Scrap (RX 580) → ROCm (Radeon) pipeline
- Lean tools optimization layer
- Delta harness workflow

### 3. Source Code Snapshot
Zip/upload `Caprigo/src/` with all dependencies listed.

---

## Credit-Optimized Benchmark Script

```bash
# Efficient credit usage: single instance, multiple runs
# Launch once, test everything, destroy

# 1. Single instance launch (1 credit)
# 2. Pull all models: 3B, 7B, 14B
# 3. Run all benchmarks in sequence
# 4. Destroy instance

# Expected consumption: 1 credit for ~2 hours of GPU time
```

---

## Key Judging Criteria Mapping

| Track 2 Requirement | Evidence Provided |
|---------------------|-------------------|
| Project spec | PROJECT_SPEC.md ✅ |
| Source code | External MIT repo + local package.json ✅ |
| Demo video | Current 72s VO + planned ROCm clip ⏳ |
| Reproducibility | REPRODUCTION_README.md ✅ |
| AMD optimization | 40% score = measured delta ⏳ |

---

## Competitive Edge

1. **Lean-tool filter** — Unique to this submission
2. **Measured delta harness** — Judges can verify numbers
3. **Cross-generation comparison** — RX 580 → RDNA 3
4. **Multiple model sizes** — 3B, 7B, 14B on ROCm

---

## Next Steps Checklist

- [ ] Launch instance via portal
- [ ] SSH or use JupyterLab terminal
- [ ] Run: `./scripts/run_rocm_delta.sh`
- [ ] Capture: tok/s, latency, VRAM
- [ ] Update: `docs/AMD.md` with results
- [ ] Optional: Record supplemental demo video
- [ ] Final push to PR branch

---

**Estimated time required:** 1-2 hours cloud execution + recording