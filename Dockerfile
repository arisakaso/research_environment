# ベースイメージを指定
FROM nvcr.io/nvidia/pytorch:23.03-py3

# 必要なパッケージをインストール
RUN apt-get update && apt-get install -y --no-install-recommends \
    tmux \
    htop \
    git \
    wget \
    curl \
    unzip 

RUN pip install --upgrade pip

RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:fenics-packages/fenics -y
RUN apt-get update
RUN apt-get install fenics -y

RUN pip install pytorch-lightning wandb

# gitの設定
ARG GIT_NAME="Your Name"
ARG GIT_EMAIL="your.email@example.com"
RUN git config --global user.name "${GIT_NAME}" && git config --global user.email "${GIT_EMAIL}"

# 作業ディレクトリを設定
WORKDIR /workspace

# Tunnel 設定
RUN curl -Lk 'https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64' --output vscode_cli.tar.gz
RUN tar -xf vscode_cli.tar.gz

# RUN ./code tunnel --accept-server-license-terms