#!/usr/bin/env bash
# Run all notebooks on a Google Colab runtime via the official `google-colab-cli`,
# saving the executed outputs back into each notebook.
#
# PREREQUISITE (one-time, interactive — only YOU can do this Google login):
#     wsl -d Ubuntu
#     export PATH="$HOME/.local/bin:$PATH"
#     colab new -s llm --gpu A100    # or --gpu T4, or plain `colab new` for CPU (no GPU units)
#   ...visit the URL it prints, approve, paste the authorization code back.
#
# THEN run this script (inside WSL):
#     bash /mnt/c/Users/Somanshu/Documents/code/agents/llm-from-scratch/run_on_colab.sh
#
# For each notebook it runs the remote kernel, writes <name>_output.ipynb, and then
# replaces the original with the executed version. Finally it stops the runtime.
set -uo pipefail
export PATH="$HOME/.local/bin:$PATH"

SESSION="${1:-llm}"
NB_DIR="/mnt/c/Users/Somanshu/Documents/code/agents/llm-from-scratch/notebooks"
cd "$NB_DIR"

echo "Colab session: $SESSION | notebooks dir: $NB_DIR"
echo

for nb in 0[0-8]_*.ipynb; do
    case "$nb" in *_output.ipynb) continue;; esac
    echo "==================== exec: $nb ===================="
    if colab exec -s "$SESSION" -f "$nb"; then
        out="${nb%.ipynb}_output.ipynb"
        if [ -f "$out" ]; then
            mv -f "$out" "$nb"     # keep the executed version as the notebook
            echo "  saved outputs into $nb"
        fi
    else
        echo "  !! exec failed for $nb"
    fi
    echo
done

echo "Stopping the runtime to release compute units..."
colab stop -s "$SESSION" || true
echo "Done."
