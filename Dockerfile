# ベースイメージを指定
FROM nvcr.io/nvidia/pytorch:22.07-py3

# 必要なパッケージをインストール
RUN apt-get update && apt-get install -y --no-install-recommends \
    tmux \
    htop \
    git \
    wget \
    curl \
    unzip 

# RUN conda install -c conda-forge pytorch-lightning=1.5.10 wandb black -y
# RUN conda install seaborn -y
RUN pip install lightning black wandb hydra-core tensordict

# fenicsx or fenics
# RUN conda install -c conda-forge fenics-dolfinx=0.6.0 mpich pyvista -y
RUN conda install -c conda-forge fenics -y

RUN conda install -c conda-forge gmsh meshio python-gmsh -y
RUN apt-get install libglu1-mesa libxinerama1 -y

# gitの設定
ARG GIT_NAME="Your Name"
ARG GIT_EMAIL="your.email@example.com"
RUN git config --global user.name "${GIT_NAME}" && git config --global user.email "${GIT_EMAIL}"

# 作業ディレクトリを設定
WORKDIR /workspace

# Tunnel 設定
RUN curl -Lk 'https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64' --output vscode_cli.tar.gz
RUN tar -xf vscode_cli.tar.gz
RUN rm vscode_cli.tar.gz

# RUN ./code tunnel --accept-server-license-terms