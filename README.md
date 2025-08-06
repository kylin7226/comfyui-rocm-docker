# ComfyUI with ROCm Docker (AMD GPUs)

This repository provides a Dockerized environment for running **[ComfyUI](https://github.com/comfyanonymous/ComfyUI)** on **AMD GPUs** using **ROCm**. It includes a `Dockerfile` and `docker-compose.yaml` configured for hardware acceleration and easy deployment on systems with supported AMD GPUs.

---

## 🚀 Features

- **Full ROCm support** for AMD GPUs (tested with ROCm 7).
- Installs and runs **ComfyUI** in a containerized environment.
- Includes **ComfyUI Manager** plugin for enhanced UI node management.
- Designed to work with Docker Compose for simple setup.

---

## 🛠 Prerequisites
- AMD GPU with ROCm-compatible architecture (see table below).
- ROCm drivers installed on the host. [Install ROCm →](https://rocm.docs.amd.com/projects/install-on-linux/en/latest/install/quick-start.html#rocm-installation)
- Docker and Docker Compose installed.

## 🛠️ AMD GPUs 
just for gfx1151

## 🧰 Build and Run

### 🔧 Build the Docker Image

```bash
docker build -t comfyui-rocm .
```

### ▶️ Start the Container

```bash
docker compose up
```

```bash
docker run -it --rm \
    --ipc=host \
    --network=host \
    --privileged \
    --cap-add=CAP_SYS_ADMIN \
    --device=/dev/kfd \
    --device=/dev/dri \
    --device=/dev/mem \
    --cap-add=SYS_PTRACE \
    --security-opt seccomp=unconfined \
    -v ./:/pwd \
    -v ./data/models/checkpoints:/comfyui/models/checkpoints \
    -v ./data/output:/comfyui/output \
    comfyui-rocm
```

Then open your browser and go to: [http://localhost:8188](http://localhost:8188)

---

## 📁 Mounted Volumes

You can customize the bound directories to your likings. Keep in mind that the directories are owned by docker / root,
so you might need elevated permissions to write into those directories, e.g. copying new models.

---

## 🧪 Tested With

- ROCm 7 on ubuntu 24.04
- AMD RYZEN AI MAX+ 395 w/ Radeon 8060S
- Docker Engine 24+
- Docker Compose v2+

---

## 📝 Notes

- Make sure ROCm is functioning correctly on the host (`rocminfo`, `clinfo`, etc.).
- If using a different ROCm version, update the `amdgpu-install` package URL accordingly.


