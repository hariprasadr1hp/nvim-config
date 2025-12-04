#

## Overview

`neovim` config

## Install `neovim`

### `macos`

```bash
brew install neovim
```

### `ubuntu`

```bash
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install neovim
```

## Setting up

```bash
cd ~/.config/
gh repo clone hariprasadr1hp/nvim-config nvim

# for python rplugin
curl -LsSf https://astral.sh/uv/install.sh | sh
uv sync

ansible-playbook nvim_playbook.yml
```

Add a `.env` file

```
# [ORG MODE]
ORG_DIR=
ORG_ROAM_DB_PATH=

# [CORPUS]
CORPUS_DIR=

# [LLM]
OLLAMA_SERVER_HOST=
OLLAMA_LOCAL_HOST=
OLLAMA_DEFAULT_SERVER_MODEL=
OLLAMA_DEFAULT_LOCAL_MODEL=
OPENAI_API_KEY=
ANTHROPIC_API_KEY=
VENICE_API_KEY=
XAI_API_KEY=
CODEIUM_API_KEY=
CLAUDE_CODE_OAUTH_TOKEN=
CHATGPT_URL=
GROK_URL=
```

- inside `neovim`, `:Lazy` and `:Mason` to load plugins and lsp/language-related-tools respectively
