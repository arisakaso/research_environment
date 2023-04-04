# Build your research environment

docker run -it --shm-size=128g --gpus "device=0" -v /home/sohei/data:/workspace/data  --name sohei_0 deep_learning_research:latest