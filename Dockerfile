FROM ghcr.io/rocm/therock_pytorch_dev_ubuntu_24_04_gfx1151:main
ENV DEBIAN_FRONTEND=noninteractive

# Add render/video groups
RUN groupadd -f render && \
    groupadd -f video && \
    usermod -a -G render,video $LOGNAME || usermod -a -G render,video root

# Install base tooling
RUN apt-get update && \
    apt-get install -y git wget

# Install ComfyUI dependencies
RUN ln -sf /opt/rocm/lib/llvm/lib/libomp.so /lib/libomp.so \
pip3 install --break-system-packages -i https://mirrors.aliyun.com/pypi/simple/ comfyui-frontend-package==1.23.4 comfyui-workflow-templates==0.1.51 comfyui-embedded-docs==0.2.4 torchsde einops transformers>=4.37.2 tokenizers>=0.13.3 sentencepiece safetensors>=0.4.2 aiohttp>=3.11.8 yarl>=1.18.0 alembic SQLAlchemy kornia>=0.7.1 spandrel soundfile av>=14.2.0 pydantic~=2.0 pydantic-settings~=2.0

# Install Comfy-UI
RUN git clone --depth 1 https://github.com/comfyanonymous/ComfyUI.git /comfyui
WORKDIR /comfyui

# Install Comfy-UI Manager
RUN git clone https://github.com/ltdrdata/ComfyUI-Manager custom_nodes/comfyui-manager

EXPOSE 8188
ENTRYPOINT ["python3 main.py"]
