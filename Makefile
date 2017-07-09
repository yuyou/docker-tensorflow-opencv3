# COMMANDS
DOCKER_COMMAND=docker
NVIDIA_DOCKER_COMMAND=nvidia-docker
CPU_DOCKER_FILE=Dockerfile.cpu
GPU_DOCKER_FILE=Dockerfile.gpu
SVC_CPU=tf-opencv-cpu-py3
SVC_GPU=tf-opencv-gpu-py3
VERSION=v0.0.1
REGISTRY_URL=so77id


build-cpu bc:
	@echo "[build] Building cpu docker image..."
	@$(DOCKER_COMMAND) build -t $(REGISTRY_URL)/$(SVC_CPU):$(VERSION) -f $(CPU_DOCKER_FILE) .
	@echo "[build] Delete old versions..."
	@$(DOCKER_COMMAND) images|sed "1 d"|grep "<none> *<none>"|awk '{print $$3}'|sort|uniq|xargs $(DOCKER_COMMAND) rmi -f
build-gpu bg:
	@echo "[build] Building gpu docker image..."
	@$(DOCKER_COMMAND) build -t $(REGISTRY_URL)/$(SVC_GPU):$(VERSION) -f $(GPU_DOCKER_FILE) .
	@echo "[build] Delete old versions..."
	@$(DOCKER_COMMAND) images|sed "1 d"|grep "<none> *<none>"|awk '{print $$3}'|sort|uniq|xargs $(DOCKER_COMMAND) rmi -f
run-cpu rc:
	@echo "[run] Running cpu docker image..."
	@$(DOCKER_COMMAND) run -t -i $(REGISTRY_URL)/$(SVC_CPU):$(VERSION)
run-gpu rg:
	@echo "[run] Running gpu docker image..."
	@$(NVIDIA_DOCKER_COMMAND) run -t -i $(REGISTRY_URL)/$(SVC_GPU):$(VERSION)
upload-cpu uc:
	@echo "[upload] Uploading cpu docker image..."
	@$(DOCKER_COMMAND) push $(REGISTRY_URL)/$(SVC_GPU)
clean c:
	@echo "[clean] Cleaning docker images..."
	@$(DOCKER_COMMAND) rmi -f $(REGISTRY_URL)/$(SVC_GPU):$(VERSION)
	@$(DOCKER_COMMAND) rmi -f $(REGISTRY_URL)/$(SVC_GPU):$(VERSION)