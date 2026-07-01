# Build a Large Language Model (From Scratch) — Runnable Notebooks

Chapter-by-chapter, **beginner-friendly** Jupyter notebooks that build a GPT-style
language model from the ground up, following Sebastian Raschka's book
*Build a Large Language Model (From Scratch)*.

Every notebook is **self-contained** (it re-defines what it needs), runs on a
plain **laptop CPU** in minutes, and also runs unchanged on **Google Colab**. You
end up having built — and understood — a real GPT-2, then fine-tuned it into a
spam classifier and an instruction-following assistant.

> These notebooks were each executed end-to-end in a clean virtual environment
> before shipping, so they run top-to-bottom without edits.

---

## What's inside

| # | Notebook | You build / learn |
|---|----------|-------------------|
| 0 | `notebooks/00_ch1_intro_and_setup.ipynb` | Big picture: what an LLM is, how GPT works, and an environment check |
| 1 | `notebooks/01_ch2_working_with_text_data.ipynb` | Tokenization, byte-pair encoding, embeddings, positional encoding |
| 2 | `notebooks/02_ch3_attention_mechanisms.ipynb` | Self-attention → causal attention → multi-head attention |
| 3 | `notebooks/03_ch4_gpt_model.ipynb` | Layer norm, GELU, transformer blocks, the full GPT model, text generation |
| 4 | `notebooks/04_ch5_pretraining.ipynb` | Loss, the training loop, sampling, and loading **real OpenAI GPT-2 weights** |
| 5 | `notebooks/05_ch6_classification_finetuning.ipynb` | Fine-tune GPT-2 into a **spam classifier** |
| 6 | `notebooks/06_ch7_instruction_finetuning.ipynb` | Fine-tune GPT-2 to **follow instructions** (like a mini ChatGPT) |
| 7 | `notebooks/07_appendix_extras.ipynb` | Bonus: LoRA, learning-rate warmup + cosine decay, gradient clipping |
| 8 | `notebooks/08_nifty50_news_llm.ipynb` | Capstone: collect live Nifty 50 news, train a GPT from scratch on it, and answer stock questions (RAG) |

**Do them in order** — each builds on the previous ideas.

Every notebook has an **"Open in Colab"** badge at the top — click it to open that
notebook directly on Colab.

### GPU auto-scaling
Chapters 5–7 and the Nifty 50 capstone **detect a GPU automatically**: on a Colab
GPU they train the full-size models (e.g., GPT‑2 124M/355M) for more epochs on more
data; on a CPU they use small models so everything still runs quickly. No edits needed.

---

## Option A — Run on Google Colab (easiest, zero install)

1. Go to [colab.research.google.com](https://colab.research.google.com).
2. `File → Upload notebook` and pick a notebook from the `notebooks/` folder
   (or `File → Open notebook → GitHub` if you push this repo to GitHub).
3. (Optional but recommended for chapters 5–7) `Runtime → Change runtime type →
   T4 GPU` for a big speed-up. CPU works too.
4. `Runtime → Run all`. Each notebook installs any missing packages in its first
   cell.

That's it — nothing to set up locally.

---

## Option B — Run locally (Windows, step by step)

You need **Python 3.10 or newer**. Check with `python --version`.

### 1. Create and activate a virtual environment (PowerShell)

```powershell
cd path\to\llm-from-scratch
python -m venv .venv
.\.venv\Scripts\Activate.ps1
```

If activation is blocked, run PowerShell once as:
`Set-ExecutionPolicy -Scope CurrentUser RemoteSigned` then try again.

### 2. Install the dependencies

PyTorch's CPU build is installed from its own index (smaller, no GPU drivers
needed):

```powershell
pip install --upgrade pip
pip install torch --index-url https://download.pytorch.org/whl/cpu
pip install tiktoken numpy pandas matplotlib transformers nbclient nbformat ipykernel
```

### 3. Open the notebooks

**Easiest:** open this folder in **VS Code** (install the *Python* and *Jupyter*
extensions), open a notebook, and pick the `.venv` interpreter as the kernel in
the top-right. Run cells with `Shift+Enter`.

**Or** register the venv as a Jupyter kernel and use the classic notebook UI:

```powershell
python -m ipykernel install --user --name llmscratch --display-name "Python (llm-from-scratch)"
pip install notebook          # only if you want the browser UI
jupyter notebook
```

> On macOS/Linux the steps are identical except activation is
> `source .venv/bin/activate`.

---

## How the notebooks are sized for a laptop

Training a full 124M-parameter GPT from scratch needs a GPU and lots of data. So
for the *from-scratch training* parts we use a **small** model and a **short**
text so everything finishes in a minute or two on a CPU while still clearly
showing the model learning.

Where seeing real quality matters (chapters 5–7), the notebooks **download
OpenAI's pretrained GPT-2 (124M) weights** (~500 MB, once) via the `transformers`
library and load them into the *from-scratch* model — so you get fluent output
without training for days.

Every "make it bigger" knob is called out in the notebooks (e.g. swap in the full
124M config, remove the data `SUBSET`, train more epochs) — do that on a Colab
GPU.

---

## Downloads the notebooks make

- **the-verdict.txt** — a short public-domain story used as training text (ch 2, 5).
- **OpenAI GPT-2 124M weights** — via `transformers` (ch 5, 6, 7).
- **SMS Spam Collection** — the spam dataset (ch 6).
- **instruction-data.json** — instruction/response pairs (ch 7).

If any download is unavailable, the notebook prints a note and falls back to a
small built-in sample so it still runs.

---

## Troubleshooting

- **`ModuleNotFoundError`** — run the first setup cell; on Colab it installs
  what's missing.
- **Pretrained GPT-2 fails to download** — check your internet; the notebook will
  fall back to a small model automatically.
- **It's slow** — you're on CPU; that's expected for chapters 5–7. Use a Colab
  GPU runtime, or just let it finish (a few minutes each).
- **`pip install jupyterlab` fails on Windows** with a long-path error — you don't
  need JupyterLab; use VS Code, or enable
  [long paths](https://pip.pypa.io/warnings/enable-long-paths) and use
  `pip install notebook` instead.

---

*Built from the book "Build a Large Language Model (From Scratch)" by Sebastian
Raschka (Manning, 2025). Code here is an independent, teaching-oriented
reimplementation for learning purposes.*
