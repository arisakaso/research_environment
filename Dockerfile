# ベースイメージを指定
FROM nvcr.io/nvidia/pytorch:23.10-py3
# FROM nvcr.io/nvidia/pytorch:23.01-py3

# 必要なパッケージをインストール
RUN apt-get update && apt-get install -y --no-install-recommends \
    tmux \
    htop \
    git \
    wget \
    curl \
    unzip

# Install miniconda
ENV CONDA_DIR /opt/conda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda

# Put conda in path so we can use conda activate
ENV PATH=$CONDA_DIR/bin:$PATH
# RUN conda update conda -y

# RUN conda install -c conda-forge pytorch-lightning=1.5.10 wandb black -y
# RUN conda install seaborn -y
RUN pip install --pre torch torchvision torchaudio -U --index-url https://download.pytorch.org/whl/nightly/cu121
RUN pip install lightning black wandb hydra-core tensordict seaborn jaxtyping torch_optimizer scipy joblib nvitop

# fenicsx or fenics
# RUN conda install -c conda-forge fenics-dolfinx=0.6.0 mpich pyvista -y
RUN conda install -c conda-forge fenics -y

# RUN conda install -c conda-forge gmsh meshio python-gmsh -y
RUN pip install gmsh
RUN apt-get install libglu1-mesa libxinerama1 -y

# gitの設定
ARG GIT_NAME="Sohei Arisaka"
ARG GIT_EMAIL="sohei.arisaka@u.nus.edu"
RUN git config --global user.name "${GIT_NAME}" && git config --global user.email "${GIT_EMAIL}"

# 作業ディレクトリを設定
WORKDIR /workspace

# Tunnel 設定
RUN curl -Lk 'https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64' --output vscode_cli.tar.gz
RUN tar -xf vscode_cli.tar.gz
RUN rm vscode_cli.tar.gz

# RUN ./code tunnel --accept-server-license-terms