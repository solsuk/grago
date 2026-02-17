# Gerago

**Pre-fetch data via shell, feed it to tool-less local models for analysis.**

Gerago bridges the gap for local LLMs (Ollama, llama.cpp, etc.) that can't use tools natively. It runs bash scripts to gather data from APIs, websites, and local files — then pipes the results as plain text to any model for summarization, analysis, or research.

## How It Works

1. **Fetch** — Shell scripts pull data (curl APIs, scrape pages, read files, grep logs)
2. **Analyze** — Fetched text is piped to a local model with a focused prompt
3. **Output** — Structured analysis returned (markdown, JSON, or plain text)

## Usage

```bash
# Basic: fetch a URL and analyze with local model
gerago fetch "https://example.com/api/data" --analyze "Summarize the key findings"

# Research mode: multi-source fetch + analysis
gerago research --sources sources.yaml --prompt "Compare pricing across competitors"

# Pipeline: chain fetch → transform → analyze
gerago pipe \
  --fetch "curl -s https://api.example.com/stats" \
  --transform "jq '.results[]'" \
  --analyze "Identify outliers and trends" \
  --model gemma
```

## Configuration

### sources.yaml
```yaml
sources:
  - name: reddit_proptech
    type: web
    url: "https://old.reddit.com/r/proptech/top/.json?t=week"
    transform: "jq '.data.children[].data | {title, score, url}'"
  
  - name: local_logs
    type: file
    path: "/var/log/myapp/*.log"
    transform: "tail -100"
  
  - name: api_endpoint
    type: api
    url: "https://api.example.com/v1/stats"
    headers:
      Authorization: "Bearer ${API_KEY}"
```

### Config (~/.gerago/config.yaml)
```yaml
default_model: gemma          # Ollama model alias
timeout: 30                   # seconds per fetch
max_input_chars: 16000        # truncate input to fit context
output_format: markdown       # markdown | json | text
```

## As an OpenClaw Skill

When invoked by an agent:
1. Agent calls `gerago research --sources <yaml> --prompt "<question>"`
2. Gerago fetches all sources in parallel
3. Concatenates results with source labels
4. Sends to configured local model with the prompt
5. Returns analysis to the calling agent

This lets expensive models (Opus, GPT-4) delegate research grunt work to free local models.

## Requirements

- bash, curl, jq
- An Ollama-compatible model (or any OpenAI-compatible endpoint)
- Optional: `pup` for HTML parsing, `xmlstarlet` for XML

## Install

```bash
# Via ClawHub
clawhub install gerago

# Via GitHub
git clone https://github.com/matakey/gerago.git
cd gerago && ./install.sh
```
