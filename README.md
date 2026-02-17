# 🦞 Grago

**Pre-fetch data via shell, feed it to tool-less local models for analysis.**

Grago bridges the gap for local LLMs (Ollama, llama.cpp, etc.) that can't use tools natively. It runs bash scripts to gather data from APIs, websites, and local files — then pipes the results as plain text to any model for summarization, analysis, or research.

## Quick Start

```bash
git clone https://github.com/matakey/grago.git
cd grago && ./install.sh

# Fetch a URL and analyze it
grago fetch "https://example.com/api/data" --analyze "Summarize key findings"

# Multi-source research
grago research --sources sources.yaml --prompt "Compare competitor pricing"

# Pipeline: fetch → transform → analyze
grago pipe \
  --fetch "curl -s https://api.example.com/stats" \
  --transform "jq '.results[]'" \
  --analyze "Identify outliers" \
  --model gemma
```

## Why?

Local models like Gemma 2, Qwen, Llama can't call APIs or browse the web. But they're great at analyzing text. Grago does the fetching so they can do the thinking.

**Use cases:**
- Competitive intelligence sweeps
- API data analysis without expensive cloud models
- Log analysis and monitoring
- Research aggregation from multiple sources
- 24/7 background analysis on free local hardware

## Requirements

- `bash`, `curl`, `jq`
- An Ollama model (or any OpenAI-compatible endpoint)
- Optional: `yq` (for multi-source research), `pup` (HTML parsing)

## Config

```yaml
# ~/.grago/config.yaml
default_model: gemma
timeout: 30
max_input_chars: 16000
output_format: markdown
```

## As an OpenClaw Skill

Install via [ClawHub](https://clawhub.com):
```bash
clawhub install grago
```

Agents can delegate research to free local models instead of burning expensive API tokens.

## License

MIT
