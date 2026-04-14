# Hybrid Document Search with Qdrant and Sentence Transformers

![learnwithparam.com](https://www.learnwithparam.com/ai-bootcamp/opengraph-image)

Parse PDFs with layout-aware PyMuPDF4LLM, store and query dense + sparse embeddings with Qdrant, and refine search results using Cross-Encoder reranking and Reciprocal Rank Fusion.

> Start learning at [learnwithparam.com](https://learnwithparam.com). Regional pricing available with discounts of up to 60%.

## What You'll Learn

- Set up and use Qdrant as a vector database for hybrid search
- Generate dense embeddings with Sentence Transformers (all-MiniLM-L6-v2)
- Parse PDFs with layout-aware extraction using PyMuPDF4LLM
- Chunk documents intelligently with RecursiveCharacterTextSplitter
- Implement Cross-Encoder reranking for precision improvement
- Combine dense and sparse retrieval with Reciprocal Rank Fusion

## Tech Stack

- **Qdrant** - Vector database for dense + sparse hybrid search
- **Sentence Transformers** - Fast, CPU-friendly embedding models
- **PyMuPDF4LLM** - Layout-aware PDF parsing to Markdown
- **FastAPI** - High-performance async Python web framework
- **Docker** - Containerized development (API + Qdrant)

## Getting Started

### Prerequisites

- Python 3.11+
- [uv](https://docs.astral.sh/uv/) (installed automatically by `make setup`)
- An API key from any supported LLM provider
- Docker (for running Qdrant)

### Quick Start

```bash
# One command to set up and run
make dev

# Or step by step:
make setup          # Create .env and install dependencies
# Edit .env with your API key
make run            # Start the FastAPI server
```

### With Docker

```bash
make build          # Build the Docker image
make up             # Start the container (API + Qdrant)
make logs           # View logs
make down           # Stop the container
```

### API Documentation

Once running, open [http://localhost:8000/docs](http://localhost:8000/docs) for the interactive Swagger UI.

## Challenges

Work through these incrementally to build the full application:

1. **The Parser** - Extract text from PDFs using PyMuPDF4LLM with layout awareness
2. **The Chunker** - Split documents intelligently with header-aware and recursive strategies
3. **The Embedder** - Generate dense and sparse vector representations
4. **The Retriever** - Query Qdrant with hybrid search and Reciprocal Rank Fusion
5. **The Reranker** - Refine results with Cross-Encoder scoring

## Makefile Targets

```
make help           Show all available commands
make setup          Initial setup (create .env, install deps)
make dev            Setup and run (one command!)
make run            Start FastAPI server
make build          Build Docker image
make up             Start container
make down           Stop container
make clean          Remove venv and cache
```

## About

Created by [learnwithparam.com](https://learnwithparam.com) - Learn AI Engineering through hands-on projects.

Explore more courses at [learnwithparam.com/courses](https://learnwithparam.com/courses).
