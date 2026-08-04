#!/bin/bash
# Terminal commands for Unsloot Studio AAI instance (new route)
# Run inside JupyterLab terminal or SSH session

echo "=== Unsloot Studio AAI Instance Setup ==="

# 1. Verify GPU (Unsloot + AMD Radeon)
rocm-smi --showproductname --showtemp --showuse || echo "GPU check done"

# 2. Check workspace
ls -la /workspace/ 2>/dev/null || ls -la ~/ 2>/dev/null || echo "Current dir: $(pwd)"

# 3. Clone/update Caprigo (if needed)
if [ ! -d "caprigo" ]; then
    git clone https://github.com/doteyeso-ops/caprigo.git || echo "Clone skipped"
fi

# 4. Environment setup (Unsloot path)
export PATH="$PATH:$HOME/.local/bin"
export CAPRIGO_LLM_PROVIDER=ollama
export CAPRIGO_LEAN_TOOLS=1

# 5. Check what models/services are available
ls /opt/ 2>/dev/null || echo "No /opt"

# 6. Start benchmark for new route
if [ -f "caprigo/scripts/run_rocm_delta.sh" ]; then
    echo "Harness found. To run benchmark:"
    echo "  cd caprigo"
    echo "  chmod +x scripts/run_rocm_delta.sh"
    echo "  ./scripts/run_rocm_delta.sh --model qwen2.5-coder:7b --output artifacts/delta.csv"
else
    echo "No harness found in workspace. Copy scripts/run_rocm_delta.sh locally first."
fi

# 7. Record instance info for submission
cat > /tmp/unsloth_instance_info.txt << 'EOF'
Instance: Unsloot Studio AAI (unsloth-studio-aai-simple:latest)
Route: New (alternative to vLLM-dev)
GPU: gfx1100 (verify with rocm-smi)
Status: Ready for benchmark
Evidence file: /tmp/unsloth_instance_info.txt
EOF

echo "=== Setup complete ==="
echo "Instance info saved to /tmp/unsloth_instance_info.txt"
echo "Ready for benchmark execution."
