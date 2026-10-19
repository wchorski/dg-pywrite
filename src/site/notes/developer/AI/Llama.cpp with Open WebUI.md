---
{"dg-publish":true,"permalink":"/developer/ai/llama-cpp-with-open-web-ui/","tags":["AI","automation","chat","local"],"noteIcon":"","created":"2026-10-19T16:51:53.089-05:00","updated":"2026-10-19T18:06:19.579-05:00","dg-note-properties":{"tags":["AI","automation","chat","local"]}}
---

## LLM Server

### Build local docker image
I'm using a **NVIDIA GTX 1070** which needs a special container built for it to be used

```sh
git clone https://github.com/ggml-org/llama.cpp
cd llama.cpp
grep -n -i gcc .devops/cuda.Dockerfile
```

```sh
docker build -t local/llama.cpp:server-cuda --target server \
  -f .devops/cuda.Dockerfile \
  --build-arg UBUNTU_VERSION=22.04 \
  --build-arg CUDA_VERSION=12.4.1 \
  --build-arg GCC_VERSION=12 \
  --build-arg CUDA_DOCKER_ARCH=61 .
```

### Install model
```sh
sudo chown $USER ./models
cd models
curl -L -O https://huggingface.co/Qwen/Qwen3-8B-GGUF/resolve/main/Qwen3-8B-Q4_K_M.gguf
```
## Web UI
### Docker Compose Stack
```yml
services:
  open-webui:
    image: ghcr.io/open-webui/open-webui:main
    container_name: open-webui
    restart: unless-stopped
    volumes:
      - ./data:/app/backend/data
    ports:
      - 3030:8080
    networks:
      - proxy
    depends_on:
      - llm
  llm:
    # image: ghcr.io/ggml-org/llama.cpp:server-cuda
    image: local/llama.cpp:server-cuda
    container_name: open-webui-llm
    restart: unless-stopped
    volumes:
      - ./models:/models
    # ports:
    #   - 8080:8080
    networks:
      - proxy
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: all
              capabilities: [gpu]
    command: >
      -m /models/${LLAMA_MODEL_FILE}
      --host 0.0.0.0
      --port 8080
      --n-gpu-layers 99
      --ctx-size 12288
      --parallel 1

networks:
  proxy:
    name: nginx-prox-mgmt-3_default
    driver: bridge
    external: true

```

### UI Connection
https://chat.lan/admin/users/overview

AI Connections 

Check OpenAI API

1. `+`  new
2. http://open-webui-llm:8080/v1
3. Auth `None`
4. Advanced
	1. Provider = `llama.cpp`
5. save
### Embedded Text
Open WebUI defaults to a built in embedded text

https://chat.lan/admin/users/overview

Tools > Documents > Embedding Model Engine
- Default (SentenceTransformers)
- Model `sentence-transformers/all-MiniLM-L6-v2`

I want to use llama.cpp and the gpu

```sh
cd models
curl -L -O https://huggingface.co/nomic-ai/nomic-embed-text-v1.5-GGUF/resolve/main/nomic-embed-text-v1.5.f16.gguf
```

Add this to the `compose.yml`

```yml
	embed:
		image: local/llama.cpp:server-cuda
		container_name: open-webui-embed
		restart: unless-stopped
		volumes:
			- ./models:/models
		networks:
			- proxy
		deploy:
			resources:
				reservations:
					devices:
						- driver: nvidia
							count: all
							capabilities: [gpu]
		command: >
			-m /models/nomic-embed-text-v1.5.f16.gguf
			--embeddings
			--host 0.0.0.0
			--port 8080
			--n-gpu-layers 99
			-c 2048
			-b 2048
			-ub 2048
```

**Admin → Settings → Documents**:

- Embedding Model Engine: **OpenAI**
- URL: `http://open-webui-embed:8080/v1`
- API key: leave empty
- Embedding model: `nomic-embed-text-v1.5.f16.gguf`. llama-server probably ignores the name, but using the filename is a safe guess.

> [!note] multi chat models
> This setup has separate containers. One for the chat model and a Second for the embed model. I do plan to install more models for either so I will need to setup a model 'router'. That way I can have one container serving up multiple models. 

```sh
docker run --rm --entrypoint /app/llama-server local/llama.cpp:server-cuda --help | grep -i models
```

to be continued...